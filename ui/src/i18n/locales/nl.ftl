# Freally Central — UI strings (nl)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = Één hub voor elke Freally-app.
filter-type = Type
filter-all = Alle
available = Beschikbaar
coming-soon = Binnenkort
download-all = Alles downloaden
download-all-hint = Download elke beschikbare app voor deze computer.
download-all-unsupported = “Alles downloaden” vereist de Freally Central-desktop-app.
download-all-none = Nog geen downloadbare apps.
language = Taal
theme-toggle = Thema wisselen
card-view = Bekijken
detail-back = Terug
detail-features = Functies
detail-started = Gestart op { $date }
detail-visit-site = Site bezoeken
detail-no-features = Functiedetails binnenkort.
detail-coming-soon-note = Deze app is nog niet beschikbaar om te downloaden.
status-loading = Catalogus laden…
status-offline = Offline — ingebouwde catalogus wordt getoond.
grid-empty = Geen apps voldoen aan dit filter.
eula-title = Licentieovereenkomst voor eindgebruikers
eula-intro = Lees en accepteer de licentie om door te gaan.
eula-accept = Accepteren & doorgaan
eula-decline = Weigeren
eula-scroll-hint = Scroll naar het einde om Accepteren in te schakelen.
footer-note = Local-first · geen accounts · geen telemetrie

# --- Settings / About / What's New / Updates panels ---
settings-title = Instellingen
settings-theme = Thema
settings-theme-light = Licht
settings-theme-dark = Donker
settings-check-updates = Controleren op updates
about-title = Over
about-version = Versie
about-created-by = Gemaakt door
about-project-started = Project gestart
about-first-stable = Eerste stabiele release
about-first-stable-pending = Nog niet uitgebracht
about-platform = Platform
about-local-first = Local-first en eerlijk — geen accounts, geen telemetrie.
about-website = Website
about-issues = Probleem melden
about-license = Licentie
about-eula = EULA
whats-new-title = Nieuw
whats-new-loading = Release-opmerkingen laden…
whats-new-version = Nieuw in versie { $version }
whats-new-empty = Geen release-opmerkingen voor deze versie.
updates-title = Updates
updates-checking = Controleren op updates…
updates-uptodate = Je hebt de nieuwste versie.
updates-check-again = Opnieuw controleren
updates-available = Versie { $version } is beschikbaar.
updates-current-version = (je hebt { $current })
updates-release-notes-label = Release-opmerkingen voor { $version }
updates-confirm = Nu downloaden en installeren?
updates-yes-update-now = Nu bijwerken
updates-no-not-now = Niet nu
updates-downloading = { $version } wordt gedownload
updates-starting = Starten…
updates-installed = Update geïnstalleerd.
updates-restart-now = Nu herstarten
updates-restart-later = Later
updates-try-again = Opnieuw proberen

# --- Live release data (Phase 2) ---
downloads-count =
    { $count ->
        [one] { $count } download
       *[other] { $count } downloads
    }
downloads-total = Totaal
downloads-brandwide = Freally-apps { $count } keer gedownload
downloads-unavailable = Downloadaantallen zijn momenteel niet beschikbaar.
detail-released = Uitgebracht op { $date }
detail-downloads = Downloads
detail-whats-new = Nieuw
refresh = Vernieuwen
changelog-heading = Nieuw in { $name }
changelog-version = Versie { $version } · { $date }
changelog-empty = Nog geen release-opmerkingen.
changelog-view-full = Volledige changelog bekijken
changelog-view-release = Bekijk op GitHub

# --- Per-app taglines (localized catalog copy) ---
card-download = Downloaden
tagline-freally-capture = Opnemen en streamen als een studio — één nette app.
tagline-freally-vault = Je wachtwoorden, passkeys & geheimen — versleuteld, local-first, van jou.
tagline-freally-player = Speelt alles af. Prachtig. Geen advertenties, geen spyware.
tagline-freally-av = Freally Anti-Virus — binnenkort.
tagline-freally-studio = Een AI-ondersteunde muziekstudio — binnenkort.
tagline-freally-sourcerer = Een aankomende Freally-app.
tagline-freally-file-manager = Een platformonafhankelijke bestandsbeheerder — binnenkort.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = Een local-first, platformonafhankelijke livestream- en opnamestudio (OBS-klasse): een realtime GPU-scènecompositor, meersporenopname en multistream naar elk platform tegelijk — volledig op je eigen machine. Geen accounts, geen telemetrie, geen cloud.
desc-freally-vault = Een local-first, zero-knowledge, end-to-end-versleutelde wachtwoord-, passkey- en geheimenmanager. KeePass-compatibel, geheugenveilige Rust-kern, volledig gratis — je kluis verlaat nooit je machine.
desc-freally-player = Een local-first, platformonafhankelijke mediaspeler die vrijwel alles afspeelt met hardwareversnelling — een moderne UI, een echte mediabibliotheek en streaming, zonder advertenties en zonder telemetrie.
desc-freally-av = Freally's local-first antivirus voor Windows, macOS en Linux. Onderweg — nog niet beschikbaar om te downloaden.
desc-freally-studio = Een volwaardige DAW met AI-patroongeneratie over 35+ genres, een mixer in FL-stijl, arrangement-tijdlijn en audioclip-editor. Voorpublicatie — nog niet beschikbaar om te downloaden.
desc-freally-sourcerer = Deze Freally-app is onderweg. Nog niet beschikbaar om te downloaden.
desc-freally-file-manager = Deze Freally-app is onderweg. Nog niet beschikbaar om te downloaden.
feat-freally-capture-1 = Eigen wgpu-GPU-scènecompositor met filters & overgangen per bron
feat-freally-capture-2 = Meersporenopname (hardware-encoders + de eigen lossless codec)
feat-freally-capture-3 = Multistream naar Twitch/YouTube/Kick tegelijk (RTMP/SRT/WHIP)
feat-freally-capture-4 = Virtuele camera, replaybuffer, downstream keyers en 3D-transformaties
feat-freally-capture-5 = UI in 18 talen

# --- Install status & actions (Phase 3) ---
status-installed = Geïnstalleerd
status-update = Update beschikbaar
status-not-installed = Niet geïnstalleerd
action-install = Installeren
action-update = Bijwerken
action-redownload = Opnieuw downloaden

# --- Downloads & live progress (Phase 4) ---
dl-downloading = Downloaden…
dl-verifying = Verifiëren…
dl-done-verified = Gedownload & geverifieerd
dl-done-size-only = Gedownload (grootte gecontroleerd)
dl-failed = Download mislukt.
dl-failed-network = Download mislukt — netwerkfout.
dl-failed-verify = Verificatie mislukt — het bestand is verwijderd.
dl-failed-busy = Er loopt al een download voor deze app.
dl-canceled = Download geannuleerd.
dl-cancel = Annuleren
dl-retry = Opnieuw proberen
dl-progress-label = Downloadvoortgang van { $name }
dl-show-in-folder = Tonen in map
batch-progress = { $done } van { $total } gedownload
batch-cancel-all = Alles annuleren
batch-done = Alle downloads voltooid.
batch-failed = { $failed } van { $total } downloads mislukt.
batch-canceled = { $canceled } van { $total } downloads geannuleerd.
