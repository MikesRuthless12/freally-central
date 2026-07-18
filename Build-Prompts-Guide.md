# Freally Central — Build Prompts Guide

> **How to use:** feed each prompt **in order** to an AI coding agent (Claude Code) — or follow it
> as a dev checklist. Each prompt builds on the previous and ends with **acceptance criteria**;
> don't move on until they pass on **Windows, macOS, and Linux**. This guide pairs 1:1 with
> `Freally-Central-Feature-Roadmap.md` (the canonical spec) — keep both in sync.
>
> **Stack (match the brand):** Tauri v2 shell + React/TypeScript UI + Rust core. Reuse Freally
> Capture's conventions: the **Fluent i18n system with 18 locales + a CI parity lint**, a
> self-hosted **signed** multi-OS updater with a `--latest` endpoint, and the code-review /
> security-review Definition-of-Done gates. Every prompt's UI strings go through i18n from the start.
>
> **Status:** planning — nothing built yet.

---

## P0.1 — GitHub repo & repo hygiene (FC-00a, FC-00e)
Create the GitHub repository `MikesRuthless12/freally-central` and commit the scaffold: `README`,
`LICENSE`, `.gitignore`, issue/PR templates, `rust-toolchain.toml`, Node `engines`, `deny.toml`, and
this guide + the roadmap. Enable branch protection on `main` (require the CI matrix to pass).
**Accept:** the repo exists; `main` is protected; a clone builds nothing yet but the tree is clean.

## P0.2 — Cross-platform CI matrix + Playwright (FC-00b)
Add GitHub Actions that build and test on **Windows, macOS, and Linux** runners for every push/PR:
Rust (`cargo fmt --check`, `cargo clippy -D warnings`, `cargo test`) and UI (`typecheck`, `lint`,
`test`, `i18n:lint`). Scaffold **Playwright** (`playwright.config.ts` + `ui/e2e/`, a `test:e2e`
script) exactly like Freally Capture, and run `test:e2e` in the matrix as features land. A failure on
any OS blocks merge.
**Accept:** the matrix runs and is green on all three OSes; `test:e2e` is wired and runs headless in
CI; a deliberately broken commit turns the matrix red and blocks the PR.

## P0.3 — Signed release pipeline & Pages (FC-00c, FC-00d)
On a version-tag push, build and **sign** the Tauri installers for all three OSes (NSIS/MSI, `.dmg`,
AppImage/`.deb`/`.rpm`), publish a GitHub Release, and write the signed `latest.json` updater
endpoint (`--latest`) — mirroring Freally Capture's release workflow. Serve the catalog manifest +
landing site from GitHub Pages.
**Accept:** a test tag yields signed installers for Windows/macOS/Linux on the Release page; the
updater endpoint resolves; Pages serves `freally-central.json` at a stable URL.

## P1.1 — Shell & theme (FC-01)
Scaffold a Tauri v2 app: Rust core crate + a Vite/React/TS UI. Dark theme, the Freally icon and
fonts, a single main window. Generate the app icon set from the canonical source
`images/freally_app_icon.png` with `npx tauri icon images/freally_app_icon.png` and wire it as the
Tauri `bundle.icon` — the same icon used for the docs logo/favicon (see `images/README.md`). Add
the workspace scripts (`build`, `typecheck`, `lint`, `test`, `i18n:lint`) mirroring Freally
Capture's `package.json`.
**Accept:** the app launches and shows an empty themed window on all 3 OSes; the window/taskbar
icon is the Freally Central icon; `typecheck`/`lint` pass.

## P1.2 — i18n foundation (FC-05)
Port Freally Capture's Fluent i18n runtime: `ui/src/i18n/` with `en.ftl` + the 17 other locales
(`ar de es fr hi id it ja ko nl pl pt-BR ru tr uk vi zh-CN`) and the `i18n-lint.mjs` parity script.
Every string the app renders is a `t("key")`.
**Accept:** `i18n:lint` prints "ok — 18 locales"; a coverage check fails on any raw `t("…")` with no
`en` key.

## P1.3 — Catalog loader (FC-02)
Define the catalog TS/Rust types from `catalog/freally-central.json`. Fetch the hosted manifest at
launch; cache it; bundle a copy as the offline fallback so the grid always renders. No product data
is hard-coded in components.
**Accept:** with the network off, the grid still renders from the bundled manifest; with it on, the
hosted manifest wins and is cached.

## P1.4 — Product-card grid & detail (FC-03, FC-04)
Render one card per app: big icon, name, tagline. Responsive columns like the reference hub; a
category/Type filter and a search box. A detail view shows description, **features**, **date
started**, and (Phase 2) live version/date. All chrome localized.
**Accept:** every catalog app appears; filter/search work; the layout reflows cleanly at narrow and
wide widths; i18n parity stays green.

## P2.1 — GitHub releases & real download counts (FC-10, FC-11, FC-13)
Per app, resolve the latest release + date and the per-OS installer asset via the manifest's
`assets` regexes. Compute per-OS **and** total `download_count` per app, plus a brand-wide grand
total. Rate-limit-aware, cached; **hide** counts (never fake them) when the API is unreachable.
**Accept:** every counter matches the repo's real Releases page; offline/rate-limited shows an honest
empty state, not a number; version + "started {date}" render per card.

## P2.2 — Changelog & What's New viewer (FC-12)
An in-app viewer that pulls each app's `CHANGELOG.md`/`changelog.html` and renders the latest
version's notes. The viewer's **chrome** (title, buttons, "What's New") is localized in all 18
locales; the notes themselves are shown verbatim from the app.
**Accept:** each app's latest notes render; the viewer's buttons/labels appear in every locale;
parity lint green.

## P3.1 — Install detection & status badges (FC-20, FC-21, FC-22)
Detect the installed version per OS (Windows registry/uninstall keys + install paths; macOS
`/Applications/*.app` `CFBundleShortVersionString`; Linux package managers / AppImage paths), map to
the app id, and compare (semver) to the latest release. Show **Installed ✓ / Update available / Not
installed**; the card's primary button reflects it (Install / Update / Open / Re-download).
**Accept:** correct badge per app across installed/outdated/absent on all 3 OSes; detection runs
off-thread and never blocks the UI; a manual Refresh re-checks.

## P4.1 — Download engine & live percent (FC-30, FC-31)
Stream the right per-OS installer to a temp dir with a **precise two-decimal percent** (e.g.
`38.92%`) from bytes-received / content-length; resumable where possible. **Verify size + checksum
(and signature when published) before use.** Bind a progress bar 0→100 % to it.
**Accept:** the percent tracks real bytes on all 3 OSes and lands on exactly 100 % at completion; a
corrupted/short download is detected and refused, not installed.

## P4.2 — Download All (FC-32)
Queue every app's current-OS installer with bounded concurrency; an aggregate progress bar plus
per-app sub-progress; cancel/retry. One failed download isolates (never stalls the rest).
**Accept:** Download All fetches every app; a forced failure on one app leaves the others completing;
the aggregate bar reaches 100 % when the successful set finishes.

## P5.1 — Silent installation (FC-40, FC-41, FC-42)
Run each verified installer **unattended, accepting defaults**: Windows NSIS `/S` (+ MSI `/qn`),
macOS `installer -pkg … -target /` or mount+copy for `.dmg`, Linux `dpkg -i`/`rpm -U`/AppImage
`chmod +x`+place. Elevate **once per batch** where admin is required (a single consent, not one per
app). Feed install progress into the same 0–100 % bar; on success flip the card to **Installed ✓**
and offer **Open**.
**Accept:** a Download-All → install run completes with **zero** wizard clicks where the OS allows
(≤1 elevation consent) on all 3 OSes; the bar hits 100 % and badges flip to Installed; failures are
reported honestly (never shown as success); only verified official installers ever execute.
**Playwright e2e (required):** a `test:e2e` spec drives the whole flow against a mocked download +
installer backend — clicks Download All, asserts the progress bar advances 0 → 100 % (checking the
two-decimal percent text), and asserts each card ends **Installed ✓** — plus a failure-path spec
(one download errors → that card shows an honest error, the rest still complete). This is the
"works without me touching it" guarantee.

## P6.1 — "Central inside" embeddable panel (FC-50, FC-51)
Extract the grid + detail + download/install flow into a reusable module any Freally app embeds
(e.g. a "More Freally apps" entry), reading the same manifest and reusing the host app's i18n
runtime. Provide drop-in instructions for Capture, Sourcerer, File Manager, and future
apps. **Exclude Freally Studio** until its own roadmap exists.
**Accept:** the panel embeds in at least one shipping app with no duplicated business logic; its
chrome is localized via the host's catalogs.

## P7.1 — Distribution, updater, a11y, site (FC-60, FC-61, FC-62)
Ship Central signed for all 3 OSes with the brand's self-hosted `--latest` updater. Keyboard nav +
screen-reader labels; light/dark; reduced-motion for the progress animation. A Freally Central
landing/download page carrying the same **real** per-OS GitHub download counter used brand-wide.
**Accept:** signed installers on 3 OSes; Central self-updates via the signed endpoint; a11y (keyboard
+ screen reader) and both themes verified; i18n parity green; the site's counter shows real numbers.

---

## Definition of Done — every prompt
- **Local CI gate before push:** `npm run ci:local` is green — it mirrors the GitHub 3-OS CI in one
  command (`cargo fmt --check`, `clippy -D warnings`, `cargo test`, `cargo deny`, UI
  `typecheck`/`lint`/`test`/`i18n:lint`, Playwright `test:e2e`). Never push on a red local gate.
- Builds green on Windows/macOS/Linux; `typecheck`/`lint`/`test`/`i18n:lint` pass.
- Every user-facing string is localized (18 locales; parity lint green).
- Numbers are real (GitHub download counts; live percent tracks real bytes) — nothing fabricated.
- Installs run only on explicit user action, on verified official installers, with ≤1 elevation
  prompt per batch.
- Docs + CHANGELOG updated; a `/code-review` and `/security-review` pass with all findings fixed
  before merge.
