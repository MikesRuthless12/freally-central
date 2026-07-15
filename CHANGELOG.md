# Changelog

All notable changes to Freally Central are documented here. The top section is
embedded into the app and shown in **Settings → What's New**.

## 0.1.0 — Phase 1: the shell & the catalog grid

- Tauri v2 + React/TypeScript shell with a standard light/dark theme (follows the OS by default).
- Product-card grid driven by the hosted catalog manifest, with a bundled offline fallback so the grid always renders.
- App detail view (description, features, start date, link to the app's site); a Type filter and a search box.
- 18-language UI (Fluent) with a CI parity + coverage lint.
- First-run EULA gate (accept to continue; remembered).
- Settings with **About**, **What's New**, and a self-hosted **Check for updates** flow (signed updater).
