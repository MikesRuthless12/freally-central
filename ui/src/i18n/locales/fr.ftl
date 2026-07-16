# Freally Central — UI strings (fr)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = Un hub pour toutes les applis Freally.
filter-type = Type
filter-all = Toutes
available = Disponibles
coming-soon = Bientôt disponible
install-all = Tout télécharger et installer
install-all-hint = Télécharge et installe silencieusement toutes les apps disponibles pour cet ordinateur.
install-all-unsupported = L’installation nécessite l’app de bureau Freally Central.
install-all-none = Aucune app téléchargeable pour l’instant.
language = Langue
theme-toggle = Changer de thème
card-view = Voir
detail-back = Retour
detail-features = Fonctionnalités
detail-started = Démarré le { $date }
detail-visit-site = Visiter le site
detail-no-features = Détails des fonctionnalités bientôt disponibles.
detail-coming-soon-note = Cette appli n’est pas encore disponible au téléchargement.
status-loading = Chargement du catalogue…
status-offline = Hors ligne — catalogue intégré affiché.
grid-empty = Aucune app ne correspond à ce filtre.
eula-title = Contrat de licence utilisateur final
eula-intro = Veuillez lire et accepter la licence pour continuer.
eula-accept = Accepter et continuer
eula-decline = Refuser
eula-scroll-hint = Faites défiler jusqu’à la fin pour activer Accepter.
footer-note = Local-first · sans compte · sans télémétrie

# --- Settings / About / What's New / Updates panels ---
settings-title = Paramètres
settings-theme = Thème
settings-theme-light = Clair
settings-theme-dark = Sombre
settings-check-updates = Rechercher des mises à jour
about-title = À propos
about-version = Version
about-created-by = Créé par
about-project-started = Projet démarré
about-first-stable = Première version stable
about-first-stable-pending = Pas encore publiée
about-platform = Plateforme
about-local-first = Local-first et honnête — sans compte, sans télémétrie.
about-website = Site web
about-issues = Signaler un problème
about-license = Licence
about-eula = EULA
whats-new-title = Nouveautés
whats-new-loading = Chargement des notes de version…
whats-new-version = Nouveautés de la version { $version }
whats-new-empty = Aucune note pour cette version.
updates-title = Mises à jour
updates-checking = Recherche de mises à jour…
updates-uptodate = Vous avez la dernière version.
updates-check-again = Vérifier à nouveau
updates-available = La version { $version } est disponible.
updates-current-version = (vous avez { $current })
updates-release-notes-label = Notes de version { $version }
updates-confirm = Télécharger et installer maintenant ?
updates-yes-update-now = Mettre à jour
updates-no-not-now = Plus tard
updates-downloading = Téléchargement de { $version }
updates-starting = Démarrage…
updates-installed = Mise à jour installée.
updates-restart-now = Redémarrer
updates-restart-later = Plus tard
updates-try-again = Réessayer

# --- Live release data (Phase 2) ---
downloads-count =
    { $count ->
        [one] { $count } téléchargement
       *[other] { $count } téléchargements
    }
downloads-total = Total
downloads-brandwide = Applications Freally téléchargées { $count } fois
downloads-unavailable = Le nombre de téléchargements est indisponible pour le moment.
detail-released = Publié le { $date }
detail-downloads = Téléchargements
detail-whats-new = Nouveautés
refresh = Actualiser
changelog-heading = Nouveautés de { $name }
changelog-version = Version { $version } · { $date }
changelog-empty = Pas encore de notes de version.
changelog-view-full = Voir le journal des modifications complet
changelog-view-release = Voir sur GitHub

# --- Per-app taglines (localized catalog copy) ---
card-download = Télécharger
tagline-freally-capture = Enregistrez et diffusez comme en studio — une seule appli.
tagline-freally-vault = Vos mots de passe, passkeys et secrets — chiffrés, local-first, à vous.
tagline-freally-player = Lit tout. Superbement. Sans pub, sans spyware.
tagline-freally-av = Freally Anti-Virus — bientôt disponible.
tagline-freally-studio = Un studio de musique assisté par IA — bientôt disponible.
tagline-freally-sourcerer = Une future appli Freally.
tagline-freally-file-manager = Un gestionnaire de fichiers multiplateforme — bientôt disponible.

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = Un studio de streaming et d'enregistrement local-first et multiplateforme (niveau OBS) : un compositeur de scènes GPU en temps réel, un enregistrement multipiste et le multistreaming vers toutes les plateformes à la fois — entièrement sur votre machine. Sans compte, sans télémétrie, sans cloud.
desc-freally-vault = Un gestionnaire de mots de passe, passkeys et secrets local-first, zero-knowledge et chiffré de bout en bout. Compatible KeePass, cœur Rust sûr en mémoire, entièrement gratuit — votre coffre ne quitte jamais votre machine.
desc-freally-player = Un lecteur multimédia local-first et multiplateforme qui lit pratiquement tout avec accélération matérielle — une interface moderne, une vraie médiathèque et le streaming, sans pub ni télémétrie.
desc-freally-av = L'antivirus local-first de Freally pour Windows, macOS et Linux. En préparation — pas encore disponible au téléchargement.
desc-freally-studio = Une STAN (DAW) complète avec génération de motifs par IA sur plus de 35 genres, un mixeur façon FL, une timeline d'arrangement et un éditeur de clips audio. Préversion — pas encore disponible au téléchargement.
desc-freally-sourcerer = Cette appli Freally est en préparation. Pas encore disponible au téléchargement.
desc-freally-file-manager = Cette appli Freally est en préparation. Pas encore disponible au téléchargement.
feat-freally-capture-1 = Compositeur de scènes GPU propriétaire (wgpu) avec filtres et transitions par source
feat-freally-capture-2 = Enregistrement multipiste (encodeurs matériels + le codec sans perte propriétaire)
feat-freally-capture-3 = Multistreaming vers Twitch/YouTube/Kick en même temps (RTMP/SRT/WHIP)
feat-freally-capture-4 = Caméra virtuelle, buffer de replay, downstream keyers et transformations 3D
feat-freally-capture-5 = Interface en 18 langues

# --- Install status & actions (Phase 3) ---
status-installed = Installé
status-update = Mise à jour disponible
status-not-installed = Non installé
action-install = Installer
action-update = Mettre à jour
action-redownload = Retélécharger

# --- Downloads & live progress (Phase 4) ---
dl-downloading = Téléchargement…
dl-verifying = Vérification…
dl-done-verified = Téléchargé et vérifié
dl-done-size-only = Téléchargé (taille contrôlée)
dl-failed = Échec du téléchargement.
dl-failed-network = Échec du téléchargement — erreur réseau.
dl-failed-verify = Échec de la vérification — le fichier a été supprimé.
dl-failed-busy = Un téléchargement est déjà en cours pour cette app.
dl-canceled = Téléchargement annulé.
dl-cancel = Annuler
dl-retry = Réessayer
dl-progress-label = Progression du téléchargement de { $name }
dl-show-in-folder = Afficher dans le dossier
batch-progress = { $done } sur { $total } téléchargées
batch-cancel-all = Tout annuler
batch-done = Tous les téléchargements sont terminés.
batch-failed = { $failed } téléchargements sur { $total } ont échoué.
batch-canceled = { $canceled } téléchargements sur { $total } annulés.

# --- Silent install (Phase 5) ---
dl-installing = Installation…
install-progress-label = Progression de l’installation de { $name }
install-done = Installé ✓
install-canceled = Installation annulée.
install-failed = Échec de l’installation.
install-failed-not-downloaded = Téléchargez l’app avant de l’installer.
install-failed-not-verified = Cet installateur n’est pas vérifié pour l’installation silencieuse — il n’a pas été exécuté.
install-failed-verify = Échec de la vérification — l’installateur a été refusé.
install-failed-unsupported = Ce type d’installateur ne peut pas être installé silencieusement sur cet ordinateur.
install-failed-installer = L’installateur a signalé une erreur.
install-failed-elevation = L’autorisation administrateur a été refusée.
install-failed-busy = Une installation est déjà en cours.
open-app = Ouvrir
open-failed = Impossible d’ouvrir { $name }.
batch-installing = Installation… { $done } sur { $total } installées
batch-installed = Toutes les apps sont installées.
batch-install-failed = { $failed } installations sur { $total } ont échoué.
batch-install-canceled = { $canceled } installations sur { $total } annulées.
