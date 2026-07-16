// Installed-version detection (Phase 3 / FC-20).
//
// For each catalog app, read the version THIS machine has installed — from the
// installer's own record, never a guess:
//   • Windows: the Uninstall registry keys Tauri's NSIS/MSI installers write
//     (DisplayName == product name → the newest DisplayVersion across both hives,
//     so a stale leftover entry can't shadow a current install).
//   • macOS:   /Applications/<name>.app (and ~/Applications) Info.plist
//     CFBundleShortVersionString.
//   • Linux:   the deb/rpm package version (dpkg-query / rpm), else an AppImage
//     whose filename encodes the version.
//
// Charter invariant (honest, never seeded): we only ever report a version some
// installer actually wrote. If an app can't be found, `installedVersion` is
// null — the UI shows "Not installed", never a fabricated number.
//
// Everything product-specific (id, product name) arrives from the manifest via
// the query, so no product data is hard-coded here.

use serde::{Deserialize, Serialize};
#[cfg(windows)]
use std::collections::HashMap;

/// One app the UI wants an installed-version reading for. Both fields come from
/// the catalog manifest.
#[derive(Debug, Clone, Deserialize)]
pub struct DetectQuery {
    /// Manifest app id (e.g. "freally-capture"). Echoed back so the UI maps the
    /// result to its card without depending on ordering; also the Linux package
    /// name guess.
    pub id: String,
    /// Product name (e.g. "Freally Capture"). What Tauri's installers register as
    /// the Windows uninstall DisplayName and the macOS `<name>.app` folder, so it
    /// drives detection on those OSes.
    pub name: String,
}

/// The installed-version reading for one app on this machine.
#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct DetectResult {
    pub id: String,
    /// The detected installed version, or None when the app isn't on this machine.
    pub installed_version: Option<String>,
}

/// Detect the installed version of each queried app on the current OS.
///
/// Registry / filesystem / subprocess probes are blocking, so the work runs on
/// the blocking pool — never on Tauri's async worker (and so the UI, which
/// awaits this, keeps its refresh spinner live and never freezes). FC-20's
/// "detection never blocks the UI" is satisfied here at the backend boundary.
#[tauri::command]
pub async fn detect_installed(apps: Vec<DetectQuery>) -> Vec<DetectResult> {
    tauri::async_runtime::spawn_blocking(move || detect_all(&apps))
        .await
        .unwrap_or_default()
}

// --- Windows -------------------------------------------------------------------

#[cfg(windows)]
fn detect_all(queries: &[DetectQuery]) -> Vec<DetectResult> {
    // Scan the Uninstall tree ONCE into a DisplayName → newest-version map, then
    // look each app up — additive in the number of queried apps (not a full
    // re-scan per app), and the newest version wins so a leftover uninstall entry
    // can't shadow a current install.
    let installed = windows_installed_map();
    queries
        .iter()
        .map(|q| DetectResult {
            id: q.id.clone(),
            installed_version: installed.get(q.name.trim()).cloned(),
        })
        .collect()
}

#[cfg(windows)]
fn windows_installed_map() -> HashMap<String, String> {
    use winreg::enums::{HKEY_CURRENT_USER, HKEY_LOCAL_MACHINE};
    use winreg::RegKey;

    // Both the native and 32-bit (WOW6432Node) views, under both hives, so a
    // per-user NSIS install and a per-machine MSI are found the same way.
    const UNINSTALL_PATHS: [&str; 2] = [
        r"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        r"SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
    ];

    let mut map: HashMap<String, String> = HashMap::new();
    for hive in [HKEY_LOCAL_MACHINE, HKEY_CURRENT_USER] {
        let root = RegKey::predef(hive);
        for path in UNINSTALL_PATHS {
            let Ok(uninstall) = root.open_subkey(path) else {
                continue;
            };
            for sub in uninstall.enum_keys().flatten() {
                let Ok(app) = uninstall.open_subkey(&sub) else {
                    continue;
                };
                // Tauri writes DisplayName exactly as the product name.
                let Ok(name) = app.get_value::<String, _>("DisplayName") else {
                    continue;
                };
                let name = name.trim().to_string();
                let Ok(raw_version) = app.get_value::<String, _>("DisplayVersion") else {
                    continue;
                };
                let Some(version) = clean_version(&raw_version) else {
                    continue;
                };
                // Keep the newest version when a DisplayName appears more than once
                // (a leftover per-machine entry beside a current per-user install).
                match map.get(&name) {
                    Some(existing) if version_key(existing) >= version_key(&version) => {}
                    _ => {
                        map.insert(name, version);
                    }
                }
            }
        }
    }
    map
}

/// A comparable numeric key for a version string — the numeric release segments,
/// stopping at the first non-numeric one (a prerelease tag), so "1.0.0" ranks at
/// least as high as "1.0.0-beta". Enough to pick the newest of several
/// installer-written versions; full semver precedence lives in the UI.
#[cfg(windows)]
fn version_key(version: &str) -> Vec<u64> {
    let mut key = Vec::new();
    for seg in version.split(['.', '-', '+']) {
        let digits: String = seg.chars().take_while(char::is_ascii_digit).collect();
        if digits.is_empty() {
            break; // a prerelease/build tag — the numeric release ends here
        }
        key.push(digits.parse::<u64>().unwrap_or(0));
    }
    key
}

// --- Per-OS single-app detection (macOS / Linux / fallback) --------------------

#[cfg(not(windows))]
fn detect_all(queries: &[DetectQuery]) -> Vec<DetectResult> {
    queries
        .iter()
        .map(|q| DetectResult {
            id: q.id.clone(),
            installed_version: detect_one(q),
        })
        .collect()
}

// --- macOS ---------------------------------------------------------------------

#[cfg(target_os = "macos")]
fn detect_one(query: &DetectQuery) -> Option<String> {
    use std::path::PathBuf;

    let mut bundles = vec![PathBuf::from(format!("/Applications/{}.app", query.name))];
    if let Some(home) = std::env::var_os("HOME") {
        bundles.push(
            PathBuf::from(home)
                .join("Applications")
                .join(format!("{}.app", query.name)),
        );
    }

    for bundle in bundles {
        let plist = bundle.join("Contents/Info.plist");
        if !plist.exists() {
            continue;
        }
        // PlistBuddy reads both XML and binary plists (a plain file read would
        // choke on the binary form). Args are passed directly — no shell — so
        // the product name can't inject anything.
        let output = std::process::Command::new("/usr/libexec/PlistBuddy")
            .args(["-c", "Print :CFBundleShortVersionString"])
            .arg(&plist)
            .output();
        if let Ok(output) = output {
            if output.status.success() {
                if let Some(v) = clean_version(&String::from_utf8_lossy(&output.stdout)) {
                    return Some(v);
                }
            }
        }
    }
    None
}

// --- Linux ---------------------------------------------------------------------

#[cfg(target_os = "linux")]
fn detect_one(query: &DetectQuery) -> Option<String> {
    // Tauri's deb/rpm package name is the product name lowercased with spaces
    // hyphenated ("Freally Capture" → "freally-capture"), which also equals the
    // manifest id for the brand's apps; try both, deduped.
    let derived = query.name.to_lowercase().replace(' ', "-");
    let mut packages = vec![derived];
    if !packages.iter().any(|p| p == &query.id) {
        packages.push(query.id.clone());
    }

    for pkg in &packages {
        // Debian/Ubuntu. Args passed directly (no shell) — no injection.
        if let Some(v) = run_version("dpkg-query", &["-W", "-f=${Version}", pkg]) {
            return Some(v);
        }
        // Fedora/openSUSE/RHEL.
        if let Some(v) = run_version("rpm", &["-q", "--qf", "%{VERSION}", pkg]) {
            return Some(v);
        }
    }

    detect_appimage_version(query)
}

/// Run a package-manager query and return a cleaned version on success only.
#[cfg(target_os = "linux")]
fn run_version(program: &str, args: &[&str]) -> Option<String> {
    let output = std::process::Command::new(program)
        .args(args)
        .output()
        .ok()?;
    if !output.status.success() {
        return None; // package not installed, or tool absent
    }
    clean_version(&String::from_utf8_lossy(&output.stdout))
}

/// Best-effort AppImage detection: AppImages have no install registry, but the
/// bundler encodes the version in the filename ("Freally Capture_0.2.0_amd64
/// .AppImage"). We only claim an install when a version clearly parses — an
/// AppImage with no parseable version is left as "not installed" rather than
/// reported dishonestly.
#[cfg(target_os = "linux")]
fn detect_appimage_version(query: &DetectQuery) -> Option<String> {
    use std::path::PathBuf;

    let mut dirs: Vec<PathBuf> = vec![PathBuf::from("/opt")];
    if let Some(home) = std::env::var_os("HOME") {
        let home = PathBuf::from(home);
        dirs.push(home.join("Applications"));
        dirs.push(home.join(".local/bin"));
        dirs.push(home.join("Downloads"));
    }

    let name_prefix = query.name.to_lowercase();
    let id_prefix = query.id.to_lowercase();

    for dir in dirs {
        let Ok(entries) = std::fs::read_dir(&dir) else {
            continue;
        };
        for entry in entries.flatten() {
            let file = entry.file_name();
            let file = file.to_string_lossy();
            let lower = file.to_lowercase();
            if !lower.ends_with(".appimage") {
                continue;
            }
            if !lower.starts_with(&name_prefix) && !lower.starts_with(&id_prefix) {
                continue;
            }
            if let Some(v) = version_from_appimage_name(&file) {
                return Some(v);
            }
        }
    }
    None
}

/// Extract an `x.y[.z]` version from an AppImage filename, e.g.
/// "Freally Capture_0.2.0_amd64.AppImage" → "0.2.0". Returns None when no
/// dotted-numeric token is present (so we don't fabricate a version).
#[cfg(target_os = "linux")]
fn version_from_appimage_name(file: &str) -> Option<String> {
    let stem = file.strip_suffix(".AppImage").unwrap_or(file);
    for token in stem.split(['_', '-']) {
        let is_version = token
            .split('.')
            .all(|part| !part.is_empty() && part.chars().all(|c| c.is_ascii_digit()))
            && token.contains('.');
        if is_version {
            return Some(token.to_string());
        }
    }
    None
}

// --- Fallback (unsupported targets) --------------------------------------------

#[cfg(not(any(windows, target_os = "macos", target_os = "linux")))]
fn detect_one(_query: &DetectQuery) -> Option<String> {
    None
}

// --- Shared --------------------------------------------------------------------

/// Normalize a raw installer/package version into what the UI's semver compare
/// expects. Drops a Debian **epoch** prefix ("1:0.3.0" → "0.3.0") and a trailing
/// Debian **revision** ("-1"), both of which would otherwise mis-sort against a
/// plain release version. A non-numeric suffix (a "-beta" prerelease) is
/// preserved. Returns None for empty input so "present but blank" reads as
/// not-detected.
#[cfg_attr(
    not(any(windows, target_os = "macos", target_os = "linux")),
    allow(dead_code)
)]
fn clean_version(raw: &str) -> Option<String> {
    let trimmed = raw.trim();
    if trimmed.is_empty() {
        return None;
    }
    // Debian epoch: "<digits>:<version>" — the epoch orders packages but isn't
    // part of the upstream version the UI compares.
    let without_epoch = match trimmed.split_once(':') {
        Some((epoch, rest)) if !epoch.is_empty() && epoch.chars().all(|c| c.is_ascii_digit()) => {
            rest
        }
        _ => trimmed,
    };
    // Debian revision: a trailing "-<digits>".
    let cleaned = match without_epoch.rsplit_once('-') {
        Some((head, tail)) if !tail.is_empty() && tail.chars().all(|c| c.is_ascii_digit()) => head,
        _ => without_epoch,
    }
    .trim();
    if cleaned.is_empty() {
        None
    } else {
        Some(cleaned.to_string())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn clean_version_trims_and_drops_deb_revision() {
        assert_eq!(clean_version("  1.2.3  ").as_deref(), Some("1.2.3"));
        assert_eq!(clean_version("0.2.0-1").as_deref(), Some("0.2.0"));
        // A non-numeric (prerelease) suffix is kept for semver comparison.
        assert_eq!(clean_version("1.0.0-beta").as_deref(), Some("1.0.0-beta"));
        assert_eq!(clean_version(""), None);
        assert_eq!(clean_version("   "), None);
    }

    #[test]
    fn clean_version_strips_debian_epoch() {
        assert_eq!(clean_version("1:0.3.0").as_deref(), Some("0.3.0"));
        assert_eq!(clean_version("1:0.3.0-1").as_deref(), Some("0.3.0"));
        // A colon that isn't a numeric epoch is left alone.
        assert_eq!(clean_version("a:1.0").as_deref(), Some("a:1.0"));
    }

    #[cfg(windows)]
    #[test]
    fn version_key_orders_by_numeric_segments() {
        assert!(version_key("0.10.0") > version_key("0.9.0"));
        assert!(version_key("1.0.0") > version_key("0.9.9"));
        assert_eq!(version_key("0.3.0"), version_key("0.3.0"));
        // Non-numeric prerelease segments collapse to 0, so the release ranks equal-or-higher.
        assert!(version_key("1.0.0") >= version_key("1.0.0-beta"));
    }

    #[cfg(target_os = "linux")]
    #[test]
    fn parses_version_from_appimage_filename() {
        assert_eq!(
            version_from_appimage_name("Freally Capture_0.2.0_amd64.AppImage").as_deref(),
            Some("0.2.0")
        );
        assert_eq!(
            version_from_appimage_name("App-1.4_x86_64.AppImage").as_deref(),
            Some("1.4")
        );
        assert_eq!(version_from_appimage_name("noversion.AppImage"), None);
    }
}
