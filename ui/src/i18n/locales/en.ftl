# Freally Central — UI strings (en)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = One hub for every Freally app.
filter-type = Type
filter-all = All
available = Available
coming-soon = Coming soon
download-all = Download All
download-all-hint = Download every available app for this computer.
download-all-unsupported = Download All needs the Freally Central desktop app.
download-all-none = No downloadable apps yet.
language = Language
theme-toggle = Switch theme
card-view = View
detail-back = Back
detail-features = Features
detail-started = Started { $date }
detail-visit-site = Visit site
detail-no-features = Feature details coming soon.
detail-coming-soon-note = This app isn’t available to download yet.
status-loading = Loading catalog…
status-offline = Offline — showing the bundled catalog.
grid-empty = No apps match this filter.
eula-title = End-User License Agreement
eula-intro = Please read and accept the license to continue.
eula-accept = Accept & Continue
eula-decline = Decline
eula-scroll-hint = Scroll to the end to enable Accept.
footer-note = Local-first · no accounts · no telemetry

# --- Settings / About / What's New / Updates panels ---
settings-title = Settings
settings-theme = Theme
settings-theme-light = Light
settings-theme-dark = Dark
settings-check-updates = Check for updates
about-title = About
about-version = Version
about-created-by = Created by
about-project-started = Project started
about-first-stable = First stable release
about-first-stable-pending = Not yet released
about-platform = Platform
about-local-first = Local-first and honest — no accounts, no telemetry.
about-website = Website
about-issues = Report an issue
about-license = License
about-eula = EULA
whats-new-title = What's New
whats-new-loading = Loading release notes…
whats-new-version = What's new in version { $version }
whats-new-empty = No release notes for this version.
updates-title = Updates
updates-checking = Checking for updates…
updates-uptodate = You're on the latest version.
updates-check-again = Check again
updates-available = Version { $version } is available.
updates-current-version = (you have { $current })
updates-release-notes-label = Release notes for { $version }
updates-confirm = Download and install now?
updates-yes-update-now = Update now
updates-no-not-now = Not now
updates-downloading = Downloading { $version }
updates-starting = Starting…
updates-installed = Update installed.
updates-restart-now = Restart now
updates-restart-later = Later
updates-try-again = Try again

# --- Live release data (Phase 2) ---
downloads-count =
    { $count ->
        [one] { $count } download
       *[other] { $count } downloads
    }
downloads-total = Total
downloads-brandwide = Freally apps downloaded { $count } times
downloads-unavailable = Download counts are unavailable right now.
detail-released = Released { $date }
detail-downloads = Downloads
detail-whats-new = What's New
refresh = Refresh
changelog-heading = What's new in { $name }
changelog-version = Version { $version } · { $date }
changelog-empty = No release notes yet.
changelog-view-full = View full changelog
changelog-view-release = View on GitHub

# --- Per-app taglines (localized catalog copy) ---
card-download = Download
tagline-freally-capture = Record and stream like a studio — one clean app.
tagline-freally-vault = Your passwords, passkeys & secrets — encrypted, local-first, yours.
tagline-freally-player = Plays anything. Beautifully. No ads, no spyware.
tagline-freally-av = Freally Anti-Virus — coming soon.
tagline-freally-studio = An AI-assisted music studio — coming soon.
tagline-freally-sourcerer = An upcoming Freally app.
tagline-freally-file-manager = A cross-platform file manager — coming soon.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = A local-first, cross-platform live-streaming & recording studio (OBS-class): a real-time GPU scene compositor, multi-track recording, and multistream to every platform at once — entirely on your machine. No accounts, no telemetry, no cloud.
desc-freally-vault = A local-first, zero-knowledge, end-to-end-encrypted password, passkey & secrets manager. KeePass-compatible, memory-safe Rust core, completely free — your vault never leaves your machine.
desc-freally-player = A local-first, cross-platform media player that plays virtually anything with hardware acceleration — a modern UI, a real media library, and streaming, with no ads and no telemetry.
desc-freally-av = Freally's local-first anti-virus for Windows, macOS, and Linux. On the way — not yet available to download.
desc-freally-studio = A full-featured DAW with AI pattern generation across 35+ genres, an FL-style mixer, arrangement timeline, and audio-clip editor. Pre-release — not yet available to download.
desc-freally-sourcerer = This Freally-brand app is on the way. Not yet available to download.
desc-freally-file-manager = This Freally-brand app is on the way. Not yet available to download.
feat-freally-capture-1 = Owned wgpu GPU scene compositor with per-source filters & transitions
feat-freally-capture-2 = Multi-track recording (hardware encoders + the owned lossless codec)
feat-freally-capture-3 = Multistream to Twitch/YouTube/Kick at once (RTMP/SRT/WHIP)
feat-freally-capture-4 = Virtual camera, replay buffer, downstream keyers, 3D transforms
feat-freally-capture-5 = 18-language UI

# --- Install status & actions (Phase 3) ---
status-installed = Installed
status-update = Update available
status-not-installed = Not installed
action-install = Install
action-update = Update
action-redownload = Re-download

# --- Downloads & live progress (Phase 4) ---
dl-downloading = Downloading…
dl-verifying = Verifying…
dl-done-verified = Downloaded & verified
dl-done-size-only = Downloaded (size checked)
dl-failed = Download failed.
dl-failed-network = Download failed — network error.
dl-failed-verify = Verification failed — the file was discarded.
dl-failed-busy = A download is already running for this app.
dl-canceled = Download canceled.
dl-cancel = Cancel
dl-retry = Retry
dl-progress-label = Download progress for { $name }
dl-show-in-folder = Show in folder
batch-progress = { $done } of { $total } downloaded
batch-cancel-all = Cancel all
batch-done = All downloads complete.
batch-failed = { $failed } of { $total } downloads failed.
batch-canceled = { $canceled } of { $total } downloads canceled.
