# Freally Central — UI strings (es)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = Un centro para todas las apps de Freally.
filter-type = Tipo
filter-all = Todas
available = Disponibles
coming-soon = Próximamente
install-all = Descargar e instalar todo
install-all-hint = Descarga e instala silenciosamente todas las apps disponibles para este equipo.
install-all-unsupported = Instalar requiere la app de escritorio Freally Central.
install-all-none = Aún no hay apps para descargar.
language = Idioma
theme-toggle = Cambiar tema
card-view = Ver
detail-back = Atrás
detail-features = Características
detail-started = Iniciado el { $date }
detail-visit-site = Visitar sitio
detail-no-features = Detalles de características próximamente.
detail-coming-soon-note = Esta app aún no está disponible para descargar.
status-loading = Cargando catálogo…
status-offline = Sin conexión: mostrando el catálogo incluido.
grid-empty = Ninguna app coincide con este filtro.
eula-title = Acuerdo de licencia de usuario final
eula-intro = Lee y acepta la licencia para continuar.
eula-accept = Aceptar y continuar
eula-decline = Rechazar
eula-scroll-hint = Desplázate hasta el final para habilitar Aceptar.
footer-note = Local-first · sin cuentas · sin telemetría

# --- Settings / About / What's New / Updates panels ---
settings-title = Ajustes
settings-theme = Tema
settings-theme-light = Claro
settings-theme-dark = Oscuro
settings-check-updates = Buscar actualizaciones
about-title = Acerca de
about-version = Versión
about-created-by = Creado por
about-project-started = Proyecto iniciado
about-first-stable = Primera versión estable
about-first-stable-pending = Aún no publicada
about-platform = Plataforma
about-local-first = Local-first y honesto: sin cuentas, sin telemetría.
about-website = Sitio web
about-issues = Informar de un problema
about-license = Licencia
about-eula = EULA
whats-new-title = Novedades
whats-new-loading = Cargando notas de la versión…
whats-new-version = Novedades de la versión { $version }
whats-new-empty = No hay notas para esta versión.
updates-title = Actualizaciones
updates-checking = Buscando actualizaciones…
updates-uptodate = Tienes la última versión.
updates-check-again = Buscar de nuevo
updates-available = La versión { $version } está disponible.
updates-current-version = (tienes { $current })
updates-release-notes-label = Notas de la versión { $version }
updates-confirm = ¿Descargar e instalar ahora?
updates-yes-update-now = Actualizar ahora
updates-no-not-now = Ahora no
updates-downloading = Descargando { $version }
updates-starting = Iniciando…
updates-installed = Actualización instalada.
updates-restart-now = Reiniciar ahora
updates-restart-later = Más tarde
updates-try-again = Reintentar

# --- Live release data (Phase 2) ---
downloads-count =
    { $count ->
        [one] { $count } descarga
       *[other] { $count } descargas
    }
downloads-total = Total
downloads-brandwide = Apps de Freally descargadas { $count } veces
downloads-unavailable = Los recuentos de descargas no están disponibles ahora mismo.
detail-released = Publicado el { $date }
detail-downloads = Descargas
detail-whats-new = Novedades
refresh = Actualizar
changelog-heading = Novedades de { $name }
changelog-version = Versión { $version } · { $date }
changelog-empty = Aún no hay notas de la versión.
changelog-view-full = Ver el registro de cambios completo
changelog-view-release = Ver en GitHub

# --- Per-app taglines (localized catalog copy) ---
card-download = Descargar
tagline-freally-capture = Graba y transmite como un estudio: una sola app.
tagline-freally-vault = Tus contraseñas, passkeys y secretos: cifrados, local-first, tuyos.
tagline-freally-player = Reproduce de todo. Con estilo. Sin anuncios ni spyware.
tagline-freally-av = Freally Anti-Virus: próximamente.
tagline-freally-studio = Un estudio de música asistido por IA: próximamente.
tagline-freally-sourcerer = Una próxima app de Freally.
tagline-freally-file-manager = Un gestor de archivos multiplataforma: próximamente.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = Un estudio de streaming y grabación local-first y multiplataforma (nivel OBS): un compositor de escenas por GPU en tiempo real, grabación multipista y multistreaming a todas las plataformas a la vez, totalmente en tu equipo. Sin cuentas, sin telemetría, sin nube.
desc-freally-vault = Un gestor de contraseñas, passkeys y secretos local-first, de conocimiento cero y cifrado de extremo a extremo. Compatible con KeePass, núcleo Rust seguro en memoria, completamente gratis: tu bóveda nunca sale de tu equipo.
desc-freally-player = Un reproductor multimedia local-first y multiplataforma que reproduce prácticamente todo con aceleración por hardware: interfaz moderna, una biblioteca multimedia real y streaming, sin anuncios ni telemetría.
desc-freally-av = El antivirus local-first de Freally para Windows, macOS y Linux. En camino: aún no disponible para descargar.
desc-freally-studio = Una DAW completa con generación de patrones por IA en más de 35 géneros, un mezclador estilo FL, línea de tiempo de arreglos y editor de clips de audio. Versión previa: aún no disponible para descargar.
desc-freally-sourcerer = Esta app de Freally está en camino. Aún no disponible para descargar.
desc-freally-file-manager = Esta app de Freally está en camino. Aún no disponible para descargar.
feat-freally-capture-1 = Compositor de escenas por GPU propio (wgpu) con filtros y transiciones por fuente
feat-freally-capture-2 = Grabación multipista (codificadores por hardware + el códec sin pérdidas propio)
feat-freally-capture-3 = Multistreaming a Twitch/YouTube/Kick a la vez (RTMP/SRT/WHIP)
feat-freally-capture-4 = Cámara virtual, búfer de repetición, keyers de salida (downstream) y transformaciones 3D
feat-freally-capture-5 = Interfaz en 18 idiomas

# --- Install status & actions (Phase 3) ---
status-installed = Instalado
status-update = Actualización disponible
status-not-installed = No instalado
action-install = Instalar
action-update = Actualizar
action-redownload = Volver a descargar

# --- Downloads & live progress (Phase 4) ---
dl-downloading = Descargando…
dl-verifying = Verificando…
dl-done-verified = Descargado y verificado
dl-done-size-only = Descargado (tamaño comprobado)
dl-failed = Error en la descarga.
dl-failed-network = Error en la descarga — fallo de red.
dl-failed-verify = La verificación falló — el archivo se descartó.
dl-failed-busy = Ya hay una descarga en curso para esta app.
dl-canceled = Descarga cancelada.
dl-cancel = Cancelar
dl-retry = Reintentar
dl-progress-label = Progreso de descarga de { $name }
dl-show-in-folder = Mostrar en la carpeta
batch-progress = { $done } de { $total } descargadas
batch-cancel-all = Cancelar todo
batch-done = Todas las descargas se completaron.
batch-failed = Fallaron { $failed } de { $total } descargas.
batch-canceled = Se cancelaron { $canceled } de { $total } descargas.

# --- Silent install (Phase 5) ---
dl-installing = Instalando…
install-progress-label = Progreso de instalación de { $name }
install-done = Instalado ✓
install-canceled = Instalación cancelada.
install-failed = La instalación falló.
install-failed-not-downloaded = Descarga la app antes de instalarla.
install-failed-not-verified = Este instalador no está verificado para la instalación silenciosa — no se ejecutó.
install-failed-verify = Falló la verificación — el instalador fue rechazado.
install-failed-unsupported = Este tipo de instalador no se puede instalar silenciosamente en este equipo.
install-failed-installer = El instalador informó un error.
install-failed-elevation = Se denegó el permiso de administrador.
install-failed-busy = Ya hay una instalación en curso.
open-app = Abrir
open-failed = No se pudo abrir { $name }.
batch-installing = Instalando… { $done } de { $total } instaladas
batch-installed = Todas las apps instaladas.
batch-install-failed = Fallaron { $failed } de { $total } instalaciones.
batch-install-canceled = Se cancelaron { $canceled } de { $total } instalaciones.
