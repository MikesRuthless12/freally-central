# Freally Central — UI strings (ru)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = Один центр для всех приложений Freally.
filter-type = Тип
filter-all = Все
available = Доступные
coming-soon = Скоро
download-all = Скачать все
download-all-hint = Скачивает все доступные приложения для этого компьютера.
download-all-unsupported = «Скачать всё» требует настольное приложение Freally Central.
download-all-none = Пока нет приложений для скачивания.
language = Язык
theme-toggle = Сменить тему
card-view = Открыть
detail-back = Назад
detail-features = Возможности
detail-started = Начато { $date }
detail-visit-site = Открыть сайт
detail-no-features = Подробности о возможностях скоро.
detail-coming-soon-note = Это приложение пока недоступно для загрузки.
status-loading = Загрузка каталога…
status-offline = Офлайн — показан встроенный каталог.
grid-empty = Ни одно приложение не соответствует этому фильтру.
eula-title = Лицензионное соглашение с конечным пользователем
eula-intro = Прочитайте и примите лицензию, чтобы продолжить.
eula-accept = Принять и продолжить
eula-decline = Отклонить
eula-scroll-hint = Прокрутите до конца, чтобы включить «Принять».
footer-note = Local-first · без аккаунтов · без телеметрии

# --- Settings / About / What's New / Updates panels ---
settings-title = Настройки
settings-theme = Тема
settings-theme-light = Светлая
settings-theme-dark = Тёмная
settings-check-updates = Проверить обновления
about-title = О программе
about-version = Версия
about-created-by = Автор
about-project-started = Проект начат
about-first-stable = Первый стабильный выпуск
about-first-stable-pending = Ещё не выпущено
about-platform = Платформа
about-local-first = Local-first и честно — без аккаунтов, без телеметрии.
about-website = Сайт
about-issues = Сообщить о проблеме
about-license = Лицензия
about-eula = EULA
whats-new-title = Что нового
whats-new-loading = Загрузка примечаний к выпуску…
whats-new-version = Что нового в версии { $version }
whats-new-empty = Нет примечаний для этой версии.
updates-title = Обновления
updates-checking = Проверка обновлений…
updates-uptodate = У вас последняя версия.
updates-check-again = Проверить снова
updates-available = Доступна версия { $version }.
updates-current-version = (у вас { $current })
updates-release-notes-label = Примечания к выпуску { $version }
updates-confirm = Загрузить и установить сейчас?
updates-yes-update-now = Обновить сейчас
updates-no-not-now = Не сейчас
updates-downloading = Загрузка { $version }
updates-starting = Запуск…
updates-installed = Обновление установлено.
updates-restart-now = Перезапустить
updates-restart-later = Позже
updates-try-again = Повторить

# --- Live release data (Phase 2) ---
downloads-count =
    { $count ->
        [one] { $count } загрузка
        [few] { $count } загрузки
        [many] { $count } загрузок
       *[other] { $count } загрузки
    }
downloads-total = Всего
downloads-brandwide = Приложения Freally загружены { $count } раз
downloads-unavailable = Число загрузок сейчас недоступно.
detail-released = Выпущено { $date }
detail-downloads = Загрузки
detail-whats-new = Что нового
refresh = Обновить
changelog-heading = Что нового в { $name }
changelog-version = Версия { $version } · { $date }
changelog-empty = Пока нет примечаний к выпуску.
changelog-view-full = Посмотреть полный список изменений
changelog-view-release = Открыть на GitHub

# --- Per-app taglines (localized catalog copy) ---
card-download = Скачать
tagline-freally-capture = Записывайте и стримьте как в студии — одно приложение.
tagline-freally-vault = Ваши пароли, passkey и секреты — зашифрованы, local-first, ваши.
tagline-freally-player = Играет всё. Красиво. Без рекламы и шпионов.
tagline-freally-av = Freally Anti-Virus — скоро.
tagline-freally-studio = Музыкальная студия с ИИ — скоро.
tagline-freally-sourcerer = Будущее приложение Freally.
tagline-freally-file-manager = Кроссплатформенный файловый менеджер — скоро.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = Локальная кроссплатформенная студия стриминга и записи (уровня OBS): GPU-композитор сцен в реальном времени, многодорожечная запись и мультистрим на все платформы сразу — целиком на вашем компьютере. Без аккаунтов, без телеметрии, без облака.
desc-freally-vault = Локальный менеджер паролей, passkey и секретов с нулевым разглашением и сквозным шифрованием. Совместим с KeePass, безопасное для памяти ядро на Rust, полностью бесплатно — ваше хранилище никогда не покидает ваш компьютер.
desc-freally-player = Локальный кроссплатформенный медиаплеер, который воспроизводит практически всё с аппаратным ускорением — современный интерфейс, настоящая медиатека и стриминг, без рекламы и телеметрии.
desc-freally-av = Локальный антивирус Freally для Windows, macOS и Linux. В разработке — пока недоступен для загрузки.
desc-freally-studio = Полнофункциональная DAW с ИИ-генерацией паттернов в 35+ жанрах, микшером в стиле FL, таймлайном аранжировки и редактором аудиоклипов. Предварительная версия — пока недоступна для загрузки.
desc-freally-sourcerer = Это приложение Freally в разработке. Пока недоступно для загрузки.
desc-freally-file-manager = Это приложение Freally в разработке. Пока недоступно для загрузки.
feat-freally-capture-1 = Собственный GPU-композитор сцен (wgpu) с фильтрами и переходами для каждого источника
feat-freally-capture-2 = Многодорожечная запись (аппаратные кодировщики + собственный кодек без потерь)
feat-freally-capture-3 = Мультистрим на Twitch/YouTube/Kick одновременно (RTMP/SRT/WHIP)
feat-freally-capture-4 = Виртуальная камера, буфер повторов, downstream-кееры и 3D-трансформации
feat-freally-capture-5 = Интерфейс на 18 языках

# --- Install status & actions (Phase 3) ---
status-installed = Установлено
status-update = Доступно обновление
status-not-installed = Не установлено
action-install = Установить
action-update = Обновить
action-redownload = Скачать заново

# --- Downloads & live progress (Phase 4) ---
dl-downloading = Скачивание…
dl-verifying = Проверка…
dl-done-verified = Скачано и проверено
dl-done-size-only = Скачано (размер сверен)
dl-failed = Не удалось скачать.
dl-failed-network = Не удалось скачать — ошибка сети.
dl-failed-verify = Проверка не пройдена — файл удалён.
dl-failed-busy = Для этого приложения уже идёт скачивание.
dl-canceled = Скачивание отменено.
dl-cancel = Отмена
dl-retry = Повторить
dl-progress-label = Ход скачивания { $name }
dl-show-in-folder = Показать в папке
batch-progress = Скачано { $done } из { $total }
batch-cancel-all = Отменить всё
batch-done = Все загрузки завершены.
batch-failed = Не удалось { $failed } из { $total } загрузок.
batch-canceled = Отменено { $canceled } из { $total } загрузок.
