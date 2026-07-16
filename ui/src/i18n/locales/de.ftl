# Freally Central — UI strings (de)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = Ein Hub für jede Freally-App.
filter-type = Typ
filter-all = Alle
available = Verfügbar
coming-soon = Demnächst
install-all = Alle laden & installieren
install-all-hint = Lädt jede verfügbare App für diesen Computer herunter und installiert sie ohne Assistenten.
install-all-unsupported = Installieren erfordert die Freally-Central-Desktop-App.
install-all-none = Noch keine herunterladbaren Apps.
language = Sprache
theme-toggle = Design wechseln
card-view = Ansehen
detail-back = Zurück
detail-features = Funktionen
detail-started = Gestartet { $date }
detail-visit-site = Website besuchen
detail-no-features = Funktionsdetails folgen bald.
detail-coming-soon-note = Diese App steht noch nicht zum Download bereit.
status-loading = Katalog wird geladen…
status-offline = Offline – integrierter Katalog wird angezeigt.
grid-empty = Keine Apps entsprechen diesem Filter.
eula-title = Endbenutzer-Lizenzvereinbarung
eula-intro = Bitte lies und akzeptiere die Lizenz, um fortzufahren.
eula-accept = Akzeptieren & fortfahren
eula-decline = Ablehnen
eula-scroll-hint = Scrolle bis zum Ende, um „Akzeptieren“ zu aktivieren.
footer-note = Local-first · keine Konten · keine Telemetrie

# --- Settings / About / What's New / Updates panels ---
settings-title = Einstellungen
settings-theme = Design
settings-theme-light = Hell
settings-theme-dark = Dunkel
settings-check-updates = Nach Updates suchen
about-title = Über
about-version = Version
about-created-by = Erstellt von
about-project-started = Projektbeginn
about-first-stable = Erste stabile Version
about-first-stable-pending = Noch nicht veröffentlicht
about-platform = Plattform
about-local-first = Local-first und ehrlich – keine Konten, keine Telemetrie.
about-website = Website
about-issues = Problem melden
about-license = Lizenz
about-eula = EULA
whats-new-title = Neuigkeiten
whats-new-loading = Versionshinweise werden geladen…
whats-new-version = Neuigkeiten in Version { $version }
whats-new-empty = Keine Versionshinweise für diese Version.
updates-title = Updates
updates-checking = Nach Updates wird gesucht…
updates-uptodate = Du verwendest die neueste Version.
updates-check-again = Erneut suchen
updates-available = Version { $version } ist verfügbar.
updates-current-version = (du hast { $current })
updates-release-notes-label = Versionshinweise für { $version }
updates-confirm = Jetzt herunterladen und installieren?
updates-yes-update-now = Jetzt aktualisieren
updates-no-not-now = Nicht jetzt
updates-downloading = { $version } wird heruntergeladen
updates-starting = Wird gestartet…
updates-installed = Update installiert.
updates-restart-now = Jetzt neu starten
updates-restart-later = Später
updates-try-again = Erneut versuchen

# --- Live release data (Phase 2) ---
downloads-count =
    { $count ->
        [one] { $count } Download
       *[other] { $count } Downloads
    }
downloads-total = Gesamt
downloads-brandwide = Freally-Apps { $count }-mal heruntergeladen
downloads-unavailable = Download-Zahlen sind derzeit nicht verfügbar.
detail-released = Veröffentlicht am { $date }
detail-downloads = Downloads
detail-whats-new = Neuigkeiten
refresh = Aktualisieren
changelog-heading = Neuigkeiten in { $name }
changelog-version = Version { $version } · { $date }
changelog-empty = Noch keine Versionshinweise.
changelog-view-full = Vollständiges Änderungsprotokoll ansehen
changelog-view-release = Auf GitHub ansehen

# --- Per-app taglines (localized catalog copy) ---
card-download = Herunterladen
tagline-freally-capture = Aufnehmen und streamen wie im Studio – eine saubere App.
tagline-freally-vault = Deine Passwörter, Passkeys & Geheimnisse – verschlüsselt, local-first, deine.
tagline-freally-player = Spielt alles ab. Wunderschön. Keine Werbung, keine Spyware.
tagline-freally-av = Freally Anti-Virus – demnächst.
tagline-freally-studio = Ein KI-gestütztes Musikstudio – demnächst.
tagline-freally-sourcerer = Eine kommende Freally-App.
tagline-freally-file-manager = Ein plattformübergreifender Dateimanager – demnächst.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = Ein local-first, plattformübergreifendes Livestreaming- und Aufnahmestudio (OBS-Klasse): ein Echtzeit-GPU-Szenencompositor, Mehrspuraufnahme und Multistream auf alle Plattformen gleichzeitig – komplett auf deinem Rechner. Keine Konten, keine Telemetrie, keine Cloud.
desc-freally-vault = Ein local-first, Zero-Knowledge, Ende-zu-Ende-verschlüsselter Passwort-, Passkey- und Geheimnis-Manager. KeePass-kompatibel, speichersicherer Rust-Kern, komplett kostenlos – dein Tresor verlässt nie deinen Rechner.
desc-freally-player = Ein local-first, plattformübergreifender Mediaplayer, der praktisch alles mit Hardwarebeschleunigung abspielt – eine moderne Oberfläche, eine echte Medienbibliothek und Streaming, ohne Werbung und ohne Telemetrie.
desc-freally-av = Freallys local-first Antivirus für Windows, macOS und Linux. In Arbeit – noch nicht zum Download verfügbar.
desc-freally-studio = Eine voll ausgestattete DAW mit KI-Mustergenerierung über 35+ Genres, einem Mixer im FL-Stil, Arrangement-Timeline und Audioclip-Editor. Vorabversion – noch nicht zum Download verfügbar.
desc-freally-sourcerer = Diese Freally-App ist in Arbeit. Noch nicht zum Download verfügbar.
desc-freally-file-manager = Diese Freally-App ist in Arbeit. Noch nicht zum Download verfügbar.
feat-freally-capture-1 = Eigener wgpu-GPU-Szenencompositor mit Filtern & Übergängen pro Quelle
feat-freally-capture-2 = Mehrspuraufnahme (Hardware-Encoder + eigener verlustfreier Codec)
feat-freally-capture-3 = Multistream zu Twitch/YouTube/Kick gleichzeitig (RTMP/SRT/WHIP)
feat-freally-capture-4 = Virtuelle Kamera, Replay-Buffer, Downstream-Keyer, 3D-Transformationen
feat-freally-capture-5 = Oberfläche in 18 Sprachen

# --- Install status & actions (Phase 3) ---
status-installed = Installiert
status-update = Update verfügbar
status-not-installed = Nicht installiert
action-install = Installieren
action-update = Aktualisieren
action-redownload = Erneut herunterladen

# --- Downloads & live progress (Phase 4) ---
dl-downloading = Wird heruntergeladen…
dl-verifying = Wird überprüft…
dl-done-verified = Heruntergeladen & verifiziert
dl-done-size-only = Heruntergeladen (Größe geprüft)
dl-failed = Download fehlgeschlagen.
dl-failed-network = Download fehlgeschlagen — Netzwerkfehler.
dl-failed-verify = Überprüfung fehlgeschlagen — die Datei wurde verworfen.
dl-failed-busy = Für diese App läuft bereits ein Download.
dl-canceled = Download abgebrochen.
dl-cancel = Abbrechen
dl-retry = Erneut versuchen
dl-progress-label = Download-Fortschritt für { $name }
dl-show-in-folder = Im Ordner anzeigen
batch-progress = { $done } von { $total } heruntergeladen
batch-cancel-all = Alle abbrechen
batch-done = Alle Downloads abgeschlossen.
batch-failed = { $failed } von { $total } Downloads fehlgeschlagen.
batch-canceled = { $canceled } von { $total } Downloads abgebrochen.

# --- Silent install (Phase 5) ---
dl-installing = Installation läuft…
install-progress-label = Installationsfortschritt für { $name }
install-done = Installiert ✓
install-canceled = Installation abgebrochen.
install-failed = Installation fehlgeschlagen.
install-failed-not-downloaded = Die App muss vor der Installation heruntergeladen werden.
install-failed-not-verified = Dieses Installationsprogramm ist nicht für die stille Installation verifiziert — es wurde nicht ausgeführt.
install-failed-verify = Verifizierung fehlgeschlagen — das Installationsprogramm wurde abgelehnt.
install-failed-unsupported = Dieser Installer-Typ kann auf diesem Computer nicht still installiert werden.
install-failed-installer = Das Installationsprogramm hat einen Fehler gemeldet.
install-failed-elevation = Die Administratorberechtigung wurde verweigert.
install-failed-busy = Es läuft bereits eine Installation.
open-app = Öffnen
open-failed = { $name } konnte nicht geöffnet werden.
batch-installing = Installation läuft… { $done } von { $total } installiert
batch-installed = Alle Apps installiert.
batch-install-failed = { $failed } von { $total } Installationen fehlgeschlagen.
batch-install-canceled = { $canceled } von { $total } Installationen abgebrochen.
