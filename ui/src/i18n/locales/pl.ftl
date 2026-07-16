# Freally Central — UI strings (pl)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = Jedno centrum dla wszystkich aplikacji Freally.
filter-type = Typ
filter-all = Wszystkie
available = Dostępne
coming-soon = Wkrótce
install-all = Pobierz i zainstaluj wszystko
install-all-hint = Pobiera i po cichu instaluje wszystkie dostępne aplikacje na ten komputer.
install-all-unsupported = Instalacja wymaga aplikacji desktopowej Freally Central.
install-all-none = Brak aplikacji do pobrania.
language = Język
theme-toggle = Zmień motyw
card-view = Zobacz
detail-back = Wstecz
detail-features = Funkcje
detail-started = Rozpoczęto { $date }
detail-visit-site = Odwiedź stronę
detail-no-features = Szczegóły funkcji wkrótce.
detail-coming-soon-note = Ta aplikacja nie jest jeszcze dostępna do pobrania.
status-loading = Ładowanie katalogu…
status-offline = Offline — pokazano wbudowany katalog.
grid-empty = Żadna aplikacja nie pasuje do tego filtra.
eula-title = Umowa licencyjna użytkownika końcowego
eula-intro = Przeczytaj i zaakceptuj licencję, aby kontynuować.
eula-accept = Akceptuj i kontynuuj
eula-decline = Odrzuć
eula-scroll-hint = Przewiń do końca, aby włączyć Akceptuj.
footer-note = Local-first · bez kont · bez telemetrii

# --- Settings / About / What's New / Updates panels ---
settings-title = Ustawienia
settings-theme = Motyw
settings-theme-light = Jasny
settings-theme-dark = Ciemny
settings-check-updates = Sprawdź aktualizacje
about-title = O programie
about-version = Wersja
about-created-by = Autor
about-project-started = Rozpoczęcie projektu
about-first-stable = Pierwsze stabilne wydanie
about-first-stable-pending = Jeszcze nie wydano
about-platform = Platforma
about-local-first = Local-first i uczciwie — bez kont, bez telemetrii.
about-website = Strona
about-issues = Zgłoś problem
about-license = Licencja
about-eula = EULA
whats-new-title = Nowości
whats-new-loading = Ładowanie informacji o wersji…
whats-new-version = Nowości w wersji { $version }
whats-new-empty = Brak informacji o tej wersji.
updates-title = Aktualizacje
updates-checking = Sprawdzanie aktualizacji…
updates-uptodate = Masz najnowszą wersję.
updates-check-again = Sprawdź ponownie
updates-available = Wersja { $version } jest dostępna.
updates-current-version = (masz { $current })
updates-release-notes-label = Informacje o wersji { $version }
updates-confirm = Pobrać i zainstalować teraz?
updates-yes-update-now = Zaktualizuj teraz
updates-no-not-now = Nie teraz
updates-downloading = Pobieranie { $version }
updates-starting = Rozpoczynanie…
updates-installed = Aktualizacja zainstalowana.
updates-restart-now = Uruchom ponownie
updates-restart-later = Później
updates-try-again = Spróbuj ponownie

# --- Live release data (Phase 2) ---
downloads-count =
    { $count ->
        [one] { $count } pobranie
        [few] { $count } pobrania
        [many] { $count } pobrań
       *[other] { $count } pobrań
    }
downloads-total = Łącznie
downloads-brandwide = Aplikacje Freally pobrano { $count } razy
downloads-unavailable = Liczba pobrań jest teraz niedostępna.
detail-released = Wydano { $date }
detail-downloads = Pobrania
detail-whats-new = Co nowego
refresh = Odśwież
changelog-heading = Co nowego w { $name }
changelog-version = Wersja { $version } · { $date }
changelog-empty = Brak informacji o wersji.
changelog-view-full = Zobacz pełny dziennik zmian
changelog-view-release = Zobacz na GitHub

# --- Per-app taglines (localized catalog copy) ---
card-download = Pobierz
tagline-freally-capture = Nagrywaj i streamuj jak studio — jedna prosta aplikacja.
tagline-freally-vault = Twoje hasła, passkeye i sekrety — zaszyfrowane, local-first, Twoje.
tagline-freally-player = Odtwarza wszystko. Pięknie. Bez reklam, bez spyware.
tagline-freally-av = Freally Anti-Virus — wkrótce.
tagline-freally-studio = Studio muzyczne wspomagane AI — wkrótce.
tagline-freally-sourcerer = Nadchodząca aplikacja Freally.
tagline-freally-file-manager = Wieloplatformowy menedżer plików — wkrótce.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = Local-first, wieloplatformowe studio streamingu i nagrywania (klasy OBS): kompozytor scen GPU w czasie rzeczywistym, nagrywanie wielościeżkowe i multistreaming na wszystkie platformy naraz — w całości na Twoim komputerze. Bez kont, bez telemetrii, bez chmury.
desc-freally-vault = Local-first, zero-knowledge, szyfrowany end-to-end menedżer haseł, passkeyów i sekretów. Zgodny z KeePass, bezpieczny pamięciowo rdzeń Rust, całkowicie darmowy — Twój sejf nigdy nie opuszcza Twojego komputera.
desc-freally-player = Local-first, wieloplatformowy odtwarzacz multimediów, który odtwarza praktycznie wszystko ze sprzętową akceleracją — nowoczesny interfejs, prawdziwa biblioteka multimediów i streaming, bez reklam i bez telemetrii.
desc-freally-av = Local-first antywirus Freally dla Windows, macOS i Linux. W drodze — jeszcze niedostępny do pobrania.
desc-freally-studio = W pełni funkcjonalne DAW z generowaniem wzorców AI w ponad 35 gatunkach, mikserem w stylu FL, osią czasu aranżacji i edytorem klipów audio. Przedpremiera — jeszcze niedostępne do pobrania.
desc-freally-sourcerer = Ta aplikacja Freally jest w drodze. Jeszcze niedostępna do pobrania.
desc-freally-file-manager = Ta aplikacja Freally jest w drodze. Jeszcze niedostępna do pobrania.
feat-freally-capture-1 = Własny kompozytor scen GPU (wgpu) z filtrami i przejściami dla każdego źródła
feat-freally-capture-2 = Nagrywanie wielościeżkowe (sprzętowe enkodery + własny bezstratny kodek)
feat-freally-capture-3 = Multistreaming na Twitch/YouTube/Kick naraz (RTMP/SRT/WHIP)
feat-freally-capture-4 = Kamera wirtualna, bufor powtórek, downstream keyery i transformacje 3D
feat-freally-capture-5 = Interfejs w 18 językach

# --- Install status & actions (Phase 3) ---
status-installed = Zainstalowano
status-update = Dostępna aktualizacja
status-not-installed = Niezainstalowano
action-install = Zainstaluj
action-update = Aktualizuj
action-redownload = Pobierz ponownie

# --- Downloads & live progress (Phase 4) ---
dl-downloading = Pobieranie…
dl-verifying = Weryfikowanie…
dl-done-verified = Pobrano i zweryfikowano
dl-done-size-only = Pobrano (sprawdzono rozmiar)
dl-failed = Pobieranie nie powiodło się.
dl-failed-network = Pobieranie nie powiodło się — błąd sieci.
dl-failed-verify = Weryfikacja nie powiodła się — plik został odrzucony.
dl-failed-busy = Pobieranie tej aplikacji już trwa.
dl-canceled = Pobieranie anulowane.
dl-cancel = Anuluj
dl-retry = Spróbuj ponownie
dl-progress-label = Postęp pobierania { $name }
dl-show-in-folder = Pokaż w folderze
batch-progress = Pobrano { $done } z { $total }
batch-cancel-all = Anuluj wszystko
batch-done = Wszystkie pobrania ukończone.
batch-failed = Nie powiodło się { $failed } z { $total } pobrań.
batch-canceled = Anulowano { $canceled } z { $total } pobrań.

# --- Silent install (Phase 5) ---
dl-installing = Instalowanie…
install-progress-label = Postęp instalacji { $name }
install-done = Zainstalowano ✓
install-canceled = Instalacja anulowana.
install-failed = Instalacja nie powiodła się.
install-failed-not-downloaded = Najpierw pobierz aplikację, aby ją zainstalować.
install-failed-not-verified = Ten instalator nie jest zweryfikowany do cichej instalacji — nie został uruchomiony.
install-failed-verify = Weryfikacja nie powiodła się — instalator został odrzucony.
install-failed-unsupported = Tego typu instalatora nie można zainstalować po cichu na tym komputerze.
install-failed-installer = Instalator zgłosił błąd.
install-failed-elevation = Odmówiono uprawnień administratora.
install-failed-busy = Instalacja już trwa.
open-app = Otwórz
open-failed = Nie można otworzyć { $name }.
batch-installing = Instalowanie… zainstalowano { $done } z { $total }
batch-installed = Wszystkie aplikacje zainstalowane.
batch-install-failed = Nie powiodło się { $failed } z { $total } instalacji.
batch-install-canceled = Anulowano { $canceled } z { $total } instalacji.
