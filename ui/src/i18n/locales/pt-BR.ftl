# Freally Central — UI strings (pt-BR)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = Um hub para todos os apps Freally.
search-placeholder = Buscar apps…
filter-type = Tipo
filter-all = Todas
available = Disponíveis
coming-soon = Em breve
download-all = Baixar tudo
download-all-hint = Os downloads chegarão em uma atualização futura.
language = Idioma
theme-toggle = Alternar tema
card-view = Ver
detail-back = Voltar
detail-features = Recursos
detail-started = Iniciado em { $date }
detail-visit-site = Visitar site
detail-no-features = Detalhes dos recursos em breve.
detail-coming-soon-note = Este app ainda não está disponível para download.
status-loading = Carregando catálogo…
status-offline = Offline — mostrando o catálogo incluído.
grid-empty = Nenhum app corresponde à sua busca.
eula-title = Contrato de Licença de Usuário Final
eula-intro = Leia e aceite a licença para continuar.
eula-accept = Aceitar e continuar
eula-decline = Recusar
eula-scroll-hint = Role até o fim para habilitar Aceitar.
footer-note = Local-first · sem contas · sem telemetria

# --- Settings / About / What's New / Updates panels ---
settings-title = Configurações
settings-theme = Tema
settings-theme-light = Claro
settings-theme-dark = Escuro
settings-check-updates = Verificar atualizações
about-title = Sobre
about-version = Versão
about-created-by = Criado por
about-project-started = Projeto iniciado
about-first-stable = Primeira versão estável
about-first-stable-pending = Ainda não lançada
about-platform = Plataforma
about-local-first = Local-first e honesto — sem contas, sem telemetria.
about-website = Site
about-issues = Relatar um problema
about-license = Licença
about-eula = EULA
whats-new-title = Novidades
whats-new-loading = Carregando notas da versão…
whats-new-version = Novidades da versão { $version }
whats-new-empty = Sem notas para esta versão.
updates-title = Atualizações
updates-checking = Verificando atualizações…
updates-uptodate = Você está na versão mais recente.
updates-check-again = Verificar novamente
updates-available = A versão { $version } está disponível.
updates-current-version = (você tem { $current })
updates-release-notes-label = Notas da versão { $version }
updates-confirm = Baixar e instalar agora?
updates-yes-update-now = Atualizar agora
updates-no-not-now = Agora não
updates-downloading = Baixando { $version }
updates-starting = Iniciando…
updates-installed = Atualização instalada.
updates-restart-now = Reiniciar agora
updates-restart-later = Mais tarde
updates-try-again = Tentar novamente

# --- Live release data (Phase 2) ---
downloads-count =
    { $count ->
        [one] { $count } download
       *[other] { $count } downloads
    }
downloads-total = Total
downloads-brandwide = Apps Freally baixados { $count } vezes
downloads-unavailable = As contagens de downloads estão indisponíveis no momento.
detail-released = Lançado em { $date }
detail-downloads = Downloads
detail-whats-new = Novidades
refresh = Atualizar
changelog-heading = Novidades no { $name }
changelog-version = Versão { $version } · { $date }
changelog-empty = Ainda não há notas de versão.
changelog-view-full = Ver changelog completo
changelog-view-release = Ver no GitHub

# --- Per-app taglines (localized catalog copy) ---
card-download = Baixar
tagline-freally-capture = Grave e transmita como um estúdio — um app só.
tagline-freally-vault = Suas senhas, passkeys e segredos — criptografados, local-first, seus.
tagline-freally-player = Reproduz tudo. Lindamente. Sem anúncios, sem spyware.
tagline-freally-av = Freally Anti-Virus — em breve.
tagline-freally-studio = Um estúdio de música assistido por IA — em breve.
tagline-freally-sourcerer = Um próximo app Freally.
tagline-freally-file-manager = Um gerenciador de arquivos multiplataforma — em breve.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = Um estúdio de transmissão ao vivo e gravação local-first e multiplataforma (nível OBS): um compositor de cenas por GPU em tempo real, gravação multipista e multistream para todas as plataformas ao mesmo tempo — totalmente na sua máquina. Sem contas, sem telemetria, sem nuvem.
desc-freally-vault = Um gerenciador de senhas, passkeys e segredos local-first, zero-knowledge e criptografado de ponta a ponta. Compatível com KeePass, núcleo Rust seguro em memória, totalmente gratuito — seu cofre nunca sai da sua máquina.
desc-freally-player = Um reprodutor de mídia local-first e multiplataforma que reproduz praticamente tudo com aceleração de hardware — uma UI moderna, uma biblioteca de mídia de verdade e streaming, sem anúncios e sem telemetria.
desc-freally-av = O antivírus local-first da Freally para Windows, macOS e Linux. A caminho — ainda não disponível para download.
desc-freally-studio = Uma DAW completa com geração de padrões por IA em mais de 35 gêneros, um mixer estilo FL, linha do tempo de arranjo e editor de clipes de áudio. Pré-lançamento — ainda não disponível para download.
desc-freally-sourcerer = Este app Freally está a caminho. Ainda não disponível para download.
desc-freally-file-manager = Este app Freally está a caminho. Ainda não disponível para download.
feat-freally-capture-1 = Compositor de cenas por GPU próprio (wgpu) com filtros e transições por fonte
feat-freally-capture-2 = Gravação multipista (codificadores de hardware + o codec lossless próprio)
feat-freally-capture-3 = Multistream para Twitch/YouTube/Kick ao mesmo tempo (RTMP/SRT/WHIP)
feat-freally-capture-4 = Câmera virtual, buffer de replay, downstream keyers e transformações 3D
feat-freally-capture-5 = Interface em 18 idiomas

# --- Install status & actions (Phase 3) ---
status-installed = Instalado
status-update = Atualização disponível
status-not-installed = Não instalado
action-install = Instalar
action-update = Atualizar
action-redownload = Baixar novamente
