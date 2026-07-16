# Changelog

All notable changes to Freally Central are documented here. The top section is
embedded into the app and shown in **Settings → What's New**.

## 0.4.0 — Phase 4: downloads, the live progress bar & Download All

- A native **download engine**: each app's right-for-this-machine installer streams from its GitHub release to a temp folder with a **precise two-decimal percent** (e.g. `38.92%`) computed from real bytes received against the API-published size — landing on exactly **100.00%** at completion. Interrupted downloads resume where they left off.
- **Verification before use**: the byte count must match the published size exactly, and when GitHub publishes a SHA-256 digest for the asset the streamed hash must match it — a short, oversized, or corrupted download is refused and discarded, never kept as an installer. Only `https://github.com/<owner>/<repo>/releases/download/…` URLs are ever fetched.
- A **live progress bar** on the card and the detail view, bound 0 → 100% to the download and held through verification, with **Cancel** and **Retry** (retry resumes the partial file).
- **Download All**: one click queues every available app's installer for this OS with bounded concurrency, an aggregate progress bar plus per-app bars, **Cancel all**, and honest results — one failed download never stalls the rest, and the summary reports exactly what failed.
- The top-bar **search box was removed** (seven apps don't need one); the Type filter stays.
- All new UI strings localized across the 18 locales; i18n parity lint stays green.

## 0.3.0 — Phase 3: install detection & status badges

- Installed-version detection per OS — Windows uninstall registry keys, macOS `/Applications/*.app` `Info.plist`, and Linux dpkg/rpm packages (with an AppImage-filename fallback) — mapped to each catalog app. Detection runs off the UI thread and is cached with a manual **Refresh**.
- Status badges on every card and the detail view: **Installed ✓ / Update available / Not installed**, computed by a semver-aware comparison of the detected version to the latest release. Honest by construction — a version is shown only when an installer actually wrote it.
- The detail view's primary action now reflects status — **Install / Update / Re-download** — routing to the verified download source. (Hands-off silent install and one-click **Open** arrive with Phase 4–5.)
- The Windows **NSIS** installer now creates a **Desktop shortcut** on install (and removes it on uninstall); the MSI already did.
- New **`npm run ci:local`** gate mirrors the GitHub 3-OS CI (`cargo fmt`/`clippy`/`test`/`deny`, UI `typecheck`/`lint`/`test`/`i18n:lint`, Playwright e2e) so red CI is caught before pushing.
- All new UI strings localized across the 18 locales; i18n parity lint stays green.

## 0.2.0 — Phase 2: live release data & real download counts

- Live GitHub release data per app: the latest version and release date, resolved from the GitHub Releases API against each app's per-OS asset patterns.
- Real download counts — per-OS and total per app, plus a brand-wide grand total — straight from GitHub's `download_count`, never seeded. Counts are hidden (never faked) when the API is offline or rate-limited.
- In-app **changelog / What's New** viewer: the latest release's notes shown verbatim, with fully localized chrome and links to the app's full changelog and GitHub release.
- Rate-limit-friendly caching with a manual and automatic refresh.
- All new UI strings localized across the 18 locales; i18n parity lint stays green.

## 0.1.0 — Phase 1: the shell & the catalog grid

- Tauri v2 + React/TypeScript shell with a standard light/dark theme (follows the OS by default).
- Product-card grid driven by the hosted catalog manifest, with a bundled offline fallback so the grid always renders.
- App detail view (description, features, start date, link to the app's site); a Type filter and a search box.
- 18-language UI (Fluent) with a CI parity + coverage lint.
- First-run EULA gate (accept to continue; remembered).
- Settings with **About**, **What's New**, and a self-hosted **Check for updates** flow (signed updater).
