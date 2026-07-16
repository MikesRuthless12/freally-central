# Freally Central — UI strings (tr)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = Tüm Freally uygulamaları için tek merkez.
filter-type = Tür
filter-all = Tümü
available = Mevcut
coming-soon = Yakında
install-all = Tümünü indir ve yükle
install-all-hint = Bu bilgisayar için mevcut tüm uygulamaları indirir ve sessizce yükler.
install-all-unsupported = Yükleme, Freally Central masaüstü uygulamasını gerektirir.
install-all-none = Henüz indirilebilir uygulama yok.
language = Dil
theme-toggle = Temayı değiştir
card-view = Görüntüle
detail-back = Geri
detail-features = Özellikler
detail-started = Başlangıç { $date }
detail-visit-site = Siteyi ziyaret et
detail-no-features = Özellik ayrıntıları yakında.
detail-coming-soon-note = Bu uygulama henüz indirilemiyor.
status-loading = Katalog yükleniyor…
status-offline = Çevrimdışı — yerleşik katalog gösteriliyor.
grid-empty = Bu filtreyle eşleşen uygulama yok.
eula-title = Son Kullanıcı Lisans Sözleşmesi
eula-intro = Devam etmek için lisansı okuyup kabul edin.
eula-accept = Kabul et ve devam et
eula-decline = Reddet
eula-scroll-hint = Kabul et’i etkinleştirmek için sona kaydırın.
footer-note = Local-first · hesap yok · telemetri yok

# --- Settings / About / What's New / Updates panels ---
settings-title = Ayarlar
settings-theme = Tema
settings-theme-light = Açık
settings-theme-dark = Koyu
settings-check-updates = Güncellemeleri denetle
about-title = Hakkında
about-version = Sürüm
about-created-by = Geliştiren
about-project-started = Proje başlangıcı
about-first-stable = İlk kararlı sürüm
about-first-stable-pending = Henüz yayınlanmadı
about-platform = Platform
about-local-first = Local-first ve dürüst — hesap yok, telemetri yok.
about-website = Web sitesi
about-issues = Sorun bildir
about-license = Lisans
about-eula = EULA
whats-new-title = Yenilikler
whats-new-loading = Sürüm notları yükleniyor…
whats-new-version = { $version } sürümündeki yenilikler
whats-new-empty = Bu sürüm için sürüm notu yok.
updates-title = Güncellemeler
updates-checking = Güncellemeler denetleniyor…
updates-uptodate = En son sürümü kullanıyorsunuz.
updates-check-again = Tekrar denetle
updates-available = { $version } sürümü mevcut.
updates-current-version = (sizde { $current } var)
updates-release-notes-label = { $version } sürüm notları
updates-confirm = Şimdi indirilip kurulsun mu?
updates-yes-update-now = Şimdi güncelle
updates-no-not-now = Şimdi değil
updates-downloading = { $version } indiriliyor
updates-starting = Başlıyor…
updates-installed = Güncelleme kuruldu.
updates-restart-now = Şimdi yeniden başlat
updates-restart-later = Sonra
updates-try-again = Tekrar dene

# --- Live release data (Phase 2) ---
downloads-count = { $count } indirme
downloads-total = Toplam
downloads-brandwide = Freally uygulamaları { $count } kez indirildi
downloads-unavailable = İndirme sayıları şu anda kullanılamıyor.
detail-released = { $date } tarihinde yayınlandı
detail-downloads = İndirmeler
detail-whats-new = Yenilikler
refresh = Yenile
changelog-heading = { $name } yenilikleri
changelog-version = Sürüm { $version } · { $date }
changelog-empty = Henüz sürüm notu yok.
changelog-view-full = Tüm değişiklik günlüğünü gör
changelog-view-release = GitHub'da gör

# --- Per-app taglines (localized catalog copy) ---
card-download = İndir
tagline-freally-capture = Stüdyo gibi kaydedin ve yayınlayın — tek temiz uygulama.
tagline-freally-vault = Parolalarınız, passkey'leriniz ve sırlarınız — şifreli, local-first, sizin.
tagline-freally-player = Her şeyi oynatır. Şık biçimde. Reklamsız, casus yazılımsız.
tagline-freally-av = Freally Anti-Virus — yakında.
tagline-freally-studio = Yapay zekâ destekli müzik stüdyosu — yakında.
tagline-freally-sourcerer = Yakında gelecek bir Freally uygulaması.
tagline-freally-file-manager = Çapraz platform dosya yöneticisi — yakında.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = Local-first, çapraz platform canlı yayın ve kayıt stüdyosu (OBS sınıfı): gerçek zamanlı GPU sahne birleştirici, çok parçalı kayıt ve tüm platformlara aynı anda çoklu yayın — tamamen kendi makinenizde. Hesap yok, telemetri yok, bulut yok.
desc-freally-vault = Local-first, sıfır bilgi (zero-knowledge), uçtan uca şifreli parola, passkey ve sır yöneticisi. KeePass uyumlu, bellek güvenli Rust çekirdeği, tamamen ücretsiz — kasanız makinenizden asla çıkmaz.
desc-freally-player = Local-first, çapraz platform bir medya oynatıcı; donanım hızlandırmayla neredeyse her şeyi oynatır — modern arayüz, gerçek bir medya kütüphanesi ve akış, reklamsız ve telemetrisiz.
desc-freally-av = Freally'nin Windows, macOS ve Linux için local-first antivirüsü. Yolda — henüz indirilemiyor.
desc-freally-studio = 35'ten fazla türde yapay zekâ ile desen üretimi, FL tarzı mikser, düzenleme zaman çizelgesi ve ses klibi düzenleyicisi olan tam donanımlı bir DAW. Ön sürüm — henüz indirilemiyor.
desc-freally-sourcerer = Bu Freally uygulaması yolda. Henüz indirilemiyor.
desc-freally-file-manager = Bu Freally uygulaması yolda. Henüz indirilemiyor.
feat-freally-capture-1 = Kaynak başına filtre ve geçişlerle kendi wgpu GPU sahne birleştiricisi
feat-freally-capture-2 = Çok parçalı kayıt (donanım kodlayıcılar + kendi kayıpsız codec'i)
feat-freally-capture-3 = Aynı anda Twitch/YouTube/Kick'e çoklu yayın (RTMP/SRT/WHIP)
feat-freally-capture-4 = Sanal kamera, tekrar arabelleği, downstream keyer'lar ve 3D dönüşümler
feat-freally-capture-5 = 18 dilli arayüz

# --- Install status & actions (Phase 3) ---
status-installed = Yüklü
status-update = Güncelleme mevcut
status-not-installed = Yüklü değil
action-install = Yükle
action-update = Güncelle
action-redownload = Yeniden indir

# --- Downloads & live progress (Phase 4) ---
dl-downloading = İndiriliyor…
dl-verifying = Doğrulanıyor…
dl-done-verified = İndirildi ve doğrulandı
dl-done-size-only = İndirildi (boyut denetlendi)
dl-failed = İndirme başarısız.
dl-failed-network = İndirme başarısız — ağ hatası.
dl-failed-verify = Doğrulama başarısız — dosya silindi.
dl-failed-busy = Bu uygulama için zaten bir indirme sürüyor.
dl-canceled = İndirme iptal edildi.
dl-cancel = İptal
dl-retry = Yeniden dene
dl-progress-label = { $name } indirme ilerlemesi
dl-show-in-folder = Klasörde göster
batch-progress = { $done } / { $total } indirildi
batch-cancel-all = Tümünü iptal et
batch-done = Tüm indirmeler tamamlandı.
batch-failed = { $total } indirmeden { $failed } tanesi başarısız oldu.
batch-canceled = { $total } indirmeden { $canceled } tanesi iptal edildi.

# --- Silent install (Phase 5) ---
dl-installing = Yükleniyor…
install-progress-label = { $name } yükleme ilerlemesi
install-done = Yüklendi ✓
install-canceled = Yükleme iptal edildi.
install-failed = Yükleme başarısız oldu.
install-failed-not-downloaded = Yüklemeden önce uygulamayı indirin.
install-failed-not-verified = Bu yükleyici sessiz yükleme için doğrulanmadı — çalıştırılmadı.
install-failed-verify = Doğrulama başarısız oldu — yükleyici reddedildi.
install-failed-unsupported = Bu yükleyici türü bu bilgisayarda sessizce yüklenemez.
install-failed-installer = Yükleyici bir hata bildirdi.
install-failed-elevation = Yönetici izni reddedildi.
install-failed-busy = Zaten bir yükleme sürüyor.
open-app = Aç
open-failed = { $name } açılamadı.
batch-installing = Yükleniyor… { $total } uygulamadan { $done } tanesi yüklendi
batch-installed = Tüm uygulamalar yüklendi.
batch-install-failed = { $total } yüklemeden { $failed } tanesi başarısız oldu.
batch-install-canceled = { $total } yüklemeden { $canceled } tanesi iptal edildi.
