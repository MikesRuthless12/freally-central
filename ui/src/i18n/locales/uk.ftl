# Freally Central — UI strings (uk)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = Один центр для всіх додатків Freally.
search-placeholder = Пошук додатків…
filter-type = Тип
filter-all = Усі
available = Доступні
coming-soon = Незабаром
download-all = Завантажити все
download-all-hint = Завантаження з’являться в наступному оновленні.
language = Мова
theme-toggle = Змінити тему
card-view = Переглянути
detail-back = Назад
detail-features = Можливості
detail-started = Розпочато { $date }
detail-visit-site = Відкрити сайт
detail-no-features = Деталі можливостей незабаром.
detail-coming-soon-note = Цей додаток ще недоступний для завантаження.
status-loading = Завантаження каталогу…
status-offline = Офлайн — показано вбудований каталог.
grid-empty = Немає додатків за вашим запитом.
eula-title = Ліцензійна угода з кінцевим користувачем
eula-intro = Прочитайте та прийміть ліцензію, щоб продовжити.
eula-accept = Прийняти та продовжити
eula-decline = Відхилити
eula-scroll-hint = Прокрутіть до кінця, щоб увімкнути «Прийняти».
footer-note = Local-first · без облікових записів · без телеметрії

# --- Settings / About / What's New / Updates panels ---
settings-title = Налаштування
settings-theme = Тема
settings-theme-light = Світла
settings-theme-dark = Темна
settings-check-updates = Перевірити оновлення
about-title = Про програму
about-version = Версія
about-created-by = Автор
about-project-started = Проєкт розпочато
about-first-stable = Перший стабільний випуск
about-first-stable-pending = Ще не випущено
about-platform = Платформа
about-local-first = Local-first і чесно — без облікових записів, без телеметрії.
about-website = Вебсайт
about-issues = Повідомити про проблему
about-license = Ліцензія
about-eula = EULA
whats-new-title = Що нового
whats-new-loading = Завантаження нотаток випуску…
whats-new-version = Що нового у версії { $version }
whats-new-empty = Немає нотаток для цієї версії.
updates-title = Оновлення
updates-checking = Перевірка оновлень…
updates-uptodate = У вас найновіша версія.
updates-check-again = Перевірити ще раз
updates-available = Доступна версія { $version }.
updates-current-version = (у вас { $current })
updates-release-notes-label = Нотатки випуску { $version }
updates-confirm = Завантажити та встановити зараз?
updates-yes-update-now = Оновити зараз
updates-no-not-now = Не зараз
updates-downloading = Завантаження { $version }
updates-starting = Запуск…
updates-installed = Оновлення встановлено.
updates-restart-now = Перезапустити зараз
updates-restart-later = Пізніше
updates-try-again = Спробувати ще раз

# --- Live release data (Phase 2) ---
downloads-count =
    { $count ->
        [one] { $count } завантаження
        [few] { $count } завантаження
        [many] { $count } завантажень
       *[other] { $count } завантаження
    }
downloads-total = Усього
downloads-brandwide = Застосунки Freally завантажено { $count } разів
downloads-unavailable = Кількість завантажень зараз недоступна.
detail-released = Випущено { $date }
detail-downloads = Завантаження
detail-whats-new = Що нового
refresh = Оновити
changelog-heading = Що нового у { $name }
changelog-version = Версія { $version } · { $date }
changelog-empty = Ще немає приміток до випуску.
changelog-view-full = Переглянути повний журнал змін
changelog-view-release = Переглянути на GitHub

# --- Per-app taglines (localized catalog copy) ---
card-download = Завантажити
tagline-freally-capture = Записуйте та стримте як студія — один зручний застосунок.
tagline-freally-vault = Ваші паролі, passkey та секрети — зашифровані, local-first, ваші.
tagline-freally-player = Відтворює все. Красиво. Без реклами та шпигунів.
tagline-freally-av = Freally Anti-Virus — незабаром.
tagline-freally-studio = Музична студія з підтримкою ШІ — незабаром.
tagline-freally-sourcerer = Майбутній застосунок Freally.
tagline-freally-file-manager = Кросплатформний файловий менеджер — незабаром.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = Локальна кросплатформна студія трансляцій і запису (рівня OBS): GPU-композитор сцен у реальному часі, багатодоріжковий запис і мультистрим на всі платформи одночасно — повністю на вашому комп'ютері. Без облікових записів, без телеметрії, без хмари.
desc-freally-vault = Локальний, zero-knowledge, наскрізно зашифрований менеджер паролів, passkey та секретів. Сумісний із KeePass, безпечне для пам'яті ядро на Rust, повністю безкоштовний — ваше сховище ніколи не покидає ваш комп'ютер.
desc-freally-player = Локальний кросплатформний медіаплеєр, що відтворює майже все з апаратним прискоренням — сучасний інтерфейс, справжня медіатека та стримінг, без реклами й телеметрії.
desc-freally-av = Локальний антивірус Freally для Windows, macOS і Linux. У розробці — ще недоступний для завантаження.
desc-freally-studio = Повнофункціональна DAW з ШІ-генерацією патернів у понад 35 жанрах, мікшером у стилі FL, таймлайном аранжування та редактором аудіокліпів. Передрелізна версія — ще недоступна для завантаження.
desc-freally-sourcerer = Цей застосунок Freally у розробці. Ще недоступний для завантаження.
desc-freally-file-manager = Цей застосунок Freally у розробці. Ще недоступний для завантаження.
feat-freally-capture-1 = Власний GPU-композитор сцен (wgpu) з фільтрами та переходами для кожного джерела
feat-freally-capture-2 = Багатодоріжковий запис (апаратні кодувальники + власний кодек без втрат)
feat-freally-capture-3 = Мультистрим на Twitch/YouTube/Kick одночасно (RTMP/SRT/WHIP)
feat-freally-capture-4 = Віртуальна камера, буфер повторів, downstream-кеєри та 3D-трансформації
feat-freally-capture-5 = Інтерфейс 18 мовами

# --- Install status & actions (Phase 3) ---
status-installed = Встановлено
status-update = Доступне оновлення
status-not-installed = Не встановлено
action-install = Встановити
action-update = Оновити
action-redownload = Завантажити знову
