# Freally Central

**One hub for every Freally-brand app.** A desktop launcher/store that lists all Freally
products in one grid — big icons, per-OS downloads, live install/update status, changelogs,
"What's New", real download counts, and a **Download All** button — with a live 0–100 %
download/install progress bar and hands-off (silent) installation.

> Status: **planning.** This folder holds the product's roadmap and build-prompts guide.
> Nothing is built yet — see `Freally-Central-Feature-Roadmap.md` for the plan and
> `Build-Prompts-Guide.md` for the phase-by-phase build prompts.

## What it is

- A **standalone desktop app** (Tauri v2 + React + Rust — the Freally house stack), *and* a
  small **embeddable panel** ("Central inside") that ships inside every other Freally app so
  the whole family is reachable from anywhere.
- Driven by a **hosted catalog manifest** (`catalog/freally-central.json`, served from GitHub
  Pages) so the product list, versions, and download URLs update **without** shipping a new
  Central build.

## The product cards (per app)

Each card shows: the big app **icon**, name + tagline, a short description, its **cool
features**, the date the project **started**, the **latest version + date**, and a status
badge — **Installed ✓ / Update available / Not installed** — with per-OS **Download** buttons,
a **changelog + What's New** link, and that app's **download count** (per OS + total).

## Headline behaviours

- **Download All** — grabs the right installer for the current OS for every app at once.
- **Live progress** — a bar that animates 0 → 100 % with a precise percent (e.g. `38.92%`)
  across **both** the download and the (silent) install.
- **Hands-off install** — installers run unattended, accepting their defaults, with no user
  clicks where the OS allows it (NSIS `/S`, MSI `/qn`, macOS `installer`/`hdiutil`, Linux
  package managers / AppImage chmod+run).
- **Real download counts** — per-OS numbers come from GitHub's release `download_count` API
  (auto-incrementing on real downloads), never a seeded/placeholder number.
- **18-language UI** — the same Fluent i18n system and 18 locales as the rest of the brand.

## Layout (planned)

```
Freally Central/
├─ README.md                          (this file)
├─ LICENSE                            (proprietary — All Rights Reserved)
├─ EULA.md                            (shown on first use; "not responsible for what you do")
├─ Freally-Central-Feature-Roadmap.md (phased plan + Definition of Done per phase)
├─ Build-Prompts-Guide.md             (the build prompt for each phase)
├─ catalog/
│  └─ freally-central.json            (the product catalog manifest — data model + example)
└─ docs/                              (the GitHub Pages site — matches the other Freally sites)
   ├─ index.html                      (hero + features + per-OS downloads + real download counter)
   ├─ changelog.html                  (its own changelog)
   ├─ documentation.html              (docs hub)
   └─ styles.css                      (shared brand stylesheet)
```

## License

**Copyright © 2026 Mike Weaver (Havoc Software) — All Rights Reserved.** Freally Central is
proprietary. It **may not be copied, redistributed, reused, or made available to others without the
express written permission of Mike Weaver** (mythodikalone@gmail.com). See [`LICENSE`](LICENSE).
