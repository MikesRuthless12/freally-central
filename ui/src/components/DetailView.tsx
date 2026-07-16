import { useState } from "react";
import { launchApp, openExternal, revealInFolder } from "../api/commands";
import { useI18n } from "../i18n";
import { appDescription, appFeatures, appTagline } from "../catalog/localize";
import type { CatalogApp } from "../catalog/types";
import { formatCount, formatDate } from "../releases/format";
import { liveRelease, type OsKey, type ReleaseState } from "../releases/types";
import { downloadAction, statusFor } from "../install/status";
import type { DownloadAction } from "../install/types";
import type { DownloadsApi } from "../downloads/useDownloads";
import {
  isActive,
  isCancelable,
  isInstallActive,
  isInstallReady,
  stateFraction,
} from "../downloads/progress";
import { failureMessageKey, installFailureMessageKey } from "../downloads/messages";
import { AppIcon } from "./AppIcon";
import { ChangelogView } from "./ChangelogView";
import { ProgressBar } from "./ProgressBar";
import { StatusBadge } from "./StatusBadge";

interface DetailViewProps {
  app: CatalogApp;
  release?: ReleaseState;
  /** Detected installed version: string, null (probed & absent), or undefined (not probed). */
  installedVersion?: string | null;
  downloads: DownloadsApi;
  onBack: () => void;
}

// Platform names are proper nouns shown identically in every locale.
const OS_ROWS: { key: OsKey; label: string }[] = [
  { key: "windows", label: "Windows" },
  { key: "macos", label: "macOS" },
  { key: "linux", label: "Linux" },
];

// The download button's label per action (FC-22).
const ACTION_KEY: Record<DownloadAction, string> = {
  install: "action-install",
  update: "action-update",
  redownload: "action-redownload",
};

export function DetailView({ app, release, installedVersion, downloads, onBack }: DetailViewProps) {
  const { t, locale } = useI18n();
  const [changelogOpen, setChangelogOpen] = useState(false);
  const [openFailed, setOpenFailed] = useState(false);
  const soon = app.status === "coming-soon";
  const tagline = appTagline(t, app);
  const description = appDescription(t, app);
  const features = appFeatures(t, app);
  const live = liveRelease(release);
  const releasedDate = live ? formatDate(locale, live.publishedAt) : null;
  // Install status (FC-21) — null when detection produced no reading for this app.
  const status = statusFor(installedVersion, live?.version);
  // The real download (FC-30): inside the shell the engine streams and verifies
  // this machine's installer with live progress. Outside it (plain browser), the
  // button falls back to opening the release page — the same verified source.
  const asset = downloads.installerFor(app, release);
  const download = downloads.byId.get(app.id);
  const engineReady = downloads.supported && asset !== null;
  const downloading = isActive(download);
  // The hands-off install stage (FC-41) — same panel, its own bar and label.
  const installing = isInstallActive(download);
  // isCancelable also covers an orphaned backend download ("alreadyDownloading"
  // after a reload) — Cancel must reach it or the user is locked out.
  const cancelable = isCancelable(download);
  const downloadUrl =
    live?.htmlUrl ?? app.site ?? (app.repo ? `https://github.com/${app.repo}/releases` : undefined);
  // The primary download CTA shows for any available app with a source, whether
  // or not detection has resolved — a failed or still-loading probe must never
  // hide it. Its label reflects detected status when known, else a plain Download.
  const showDownload = !soon && (downloadUrl !== undefined || engineReady);
  const action: DownloadAction = status ? downloadAction(status) : "install";
  const downloadLabelKey = status ? ACTION_KEY[action] : "card-download";
  // Open (FC-42): the app is on this machine — detected, or installed just now.
  const showOpen = downloads.supported && status !== null && status !== "not-installed";
  const startPrimary = () => {
    if (downloads.supported && asset) {
      // The button's label is the consent: "Install"/"Update" run the whole
      // hands-off flow (FC-40); a plain "Download" (status unknown) or
      // "Re-download" only fetches the verified installer. A file already
      // verified on disk installs directly — no needless second download.
      if (!status || action === "redownload") downloads.start(app.id, asset);
      else if (isInstallReady(download)) downloads.install(app.id);
      else downloads.installFlow(app.id, asset);
    } else if (downloadUrl) {
      void openExternal(downloadUrl);
    }
  };
  const openApp = () => {
    setOpenFailed(false);
    launchApp(app.id, app.name).catch(() => setOpenFailed(true));
  };
  return (
    <section className="detail">
      <button type="button" className="btn btn-ghost detail-back" onClick={onBack}>
        ← {t("detail-back")}
      </button>

      <div className="detail-head">
        <AppIcon app={app} size={128} />
        <div className="detail-headtext">
          <h2 className="detail-name">{app.name}</h2>
          {tagline && <p className="detail-tagline">{tagline}</p>}
          <div className="detail-badges">
            <span className={soon ? "pill pill--soon" : "pill pill--view"}>
              {soon ? t("coming-soon") : t("available")}
            </span>
            {status && <StatusBadge status={status} />}
            {live && <span className="detail-version">v{live.version}</span>}
            {app.startedDate && (
              <span className="detail-started">{t("detail-started", { date: app.startedDate })}</span>
            )}
            {releasedDate && (
              <span className="detail-started">{t("detail-released", { date: releasedDate })}</span>
            )}
          </div>
        </div>
      </div>

      {description && <p className="detail-desc">{description}</p>}

      {live && (
        <>
          <h3 className="detail-section-title">{t("detail-downloads")}</h3>
          <dl className="detail-downloads">
            {OS_ROWS.map(({ key, label }) => {
              const count = live.perOs[key];
              if (count === undefined) return null;
              return (
                <div className="detail-download-row" key={key}>
                  <dt>{label}</dt>
                  <dd>{formatCount(locale, count)}</dd>
                </div>
              );
            })}
            <div className="detail-download-row detail-download-total">
              <dt>{t("downloads-total")}</dt>
              <dd>{formatCount(locale, live.totalDownloads)}</dd>
            </div>
          </dl>
        </>
      )}

      {release?.status === "unavailable" && (
        <p className="detail-muted detail-downloads-note">{t("downloads-unavailable")}</p>
      )}

      <h3 className="detail-section-title">{t("detail-features")}</h3>
      {features.length > 0 ? (
        <ul className="detail-features">
          {features.map((feature) => (
            <li key={feature}>{feature}</li>
          ))}
        </ul>
      ) : (
        <p className="detail-muted">{t("detail-no-features")}</p>
      )}

      {soon && <p className="detail-note">{t("detail-coming-soon-note")}</p>}

      {(live || app.site || showDownload || showOpen) && (
        <div className="detail-actions">
          {showOpen && (
            <button type="button" className="btn btn-primary" onClick={openApp}>
              {t("open-app")}
            </button>
          )}
          {live && (
            <button type="button" className="btn" onClick={() => setChangelogOpen(true)}>
              {t("detail-whats-new")}
            </button>
          )}
          {app.site && (
            <button
              type="button"
              className={showDownload || showOpen ? "btn" : "btn btn-primary"}
              onClick={() => void openExternal(app.site as string)}
            >
              {t("detail-visit-site")}
            </button>
          )}
          {showDownload && !downloading && !installing && (
            <button
              type="button"
              className={showOpen ? "btn" : "btn btn-primary"}
              onClick={startPrimary}
            >
              {t(
                download?.phase === "failed" || download?.phase === "canceled"
                  ? "dl-retry"
                  : downloadLabelKey,
              )}
            </button>
          )}
          {cancelable && (
            <button type="button" className="btn" onClick={() => downloads.cancel(app.id)}>
              {t("dl-cancel")}
            </button>
          )}
        </div>
      )}

      {openFailed && <p className="detail-download-note detail-download-note--error">{t("open-failed", { name: app.name })}</p>}

      {/* The live download/install panel (FC-31 + FC-41): a real-bytes bar with
          the two-decimal percent while streaming/verifying, the staged install
          bar while the installer runs, then an honest terminal note. */}
      {download && (
        <div className="detail-download">
          {downloading && (
            <>
              <span className="detail-download-phase">
                {t(download.phase === "verifying" ? "dl-verifying" : "dl-downloading")}
              </span>
              <ProgressBar
                fraction={stateFraction(download)}
                label={t("dl-progress-label", { name: app.name })}
                percentClassName="detail-download-percent"
              />
            </>
          )}
          {installing && (
            <>
              <span className="detail-download-phase">{t("dl-installing")}</span>
              <ProgressBar
                fraction={stateFraction(download)}
                label={t("install-progress-label", { name: app.name })}
                percentClassName="detail-download-percent"
              />
            </>
          )}
          {download.phase === "done" && (
            <>
              <p className="detail-download-note detail-download-note--ok">
                {t(download.checksumVerified ? "dl-done-verified" : "dl-done-size-only")}
              </p>
              {/* The verified installer is real and reachable — show which file
                  and open its folder (Install runs it hands-off from there). */}
              <span className="detail-download-file">
                {download.path.split(/[\\/]/).pop()}
              </span>
              <button
                type="button"
                className="btn"
                onClick={() => void revealInFolder(download.path)}
              >
                {t("dl-show-in-folder")}
              </button>
            </>
          )}
          {download.phase === "installed" && (
            <p className="detail-download-note detail-download-note--ok">{t("install-done")}</p>
          )}
          {download.phase === "installFailed" && (
            <p className="detail-download-note detail-download-note--error">
              {t(installFailureMessageKey(download.code))}
            </p>
          )}
          {download.phase === "installCanceled" && (
            <p className="detail-download-note">{t("install-canceled")}</p>
          )}
          {download.phase === "failed" && (
            <p className="detail-download-note detail-download-note--error">
              {t(failureMessageKey(download.code))}
            </p>
          )}
          {download.phase === "canceled" && (
            <p className="detail-download-note">{t("dl-canceled")}</p>
          )}
        </div>
      )}

      {changelogOpen && live && (
        <ChangelogView app={app} release={live} onClose={() => setChangelogOpen(false)} />
      )}
    </section>
  );
}
