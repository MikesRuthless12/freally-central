import { useState } from "react";
import { openExternal } from "../api/commands";
import { useI18n } from "../i18n";
import { appDescription, appFeatures, appTagline } from "../catalog/localize";
import type { CatalogApp } from "../catalog/types";
import { formatCount, formatDate } from "../releases/format";
import { liveRelease, type OsKey, type ReleaseState } from "../releases/types";
import { AppIcon } from "./AppIcon";
import { ChangelogView } from "./ChangelogView";

interface DetailViewProps {
  app: CatalogApp;
  release?: ReleaseState;
  onBack: () => void;
}

// Platform names are proper nouns shown identically in every locale.
const OS_ROWS: { key: OsKey; label: string }[] = [
  { key: "windows", label: "Windows" },
  { key: "macos", label: "macOS" },
  { key: "linux", label: "Linux" },
];

export function DetailView({ app, release, onBack }: DetailViewProps) {
  const { t, locale } = useI18n();
  const [changelogOpen, setChangelogOpen] = useState(false);
  const soon = app.status === "coming-soon";
  const tagline = appTagline(t, app);
  const description = appDescription(t, app);
  const features = appFeatures(t, app);
  const live = liveRelease(release);
  const releasedDate = live ? formatDate(locale, live.publishedAt) : null;
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

      {(live || app.site) && (
        <div className="detail-actions">
          {live && (
            <button type="button" className="btn" onClick={() => setChangelogOpen(true)}>
              {t("detail-whats-new")}
            </button>
          )}
          {app.site && (
            <button
              type="button"
              className="btn btn-primary"
              onClick={() => void openExternal(app.site as string)}
            >
              {t("detail-visit-site")}
            </button>
          )}
        </div>
      )}

      {changelogOpen && live && (
        <ChangelogView app={app} release={live} onClose={() => setChangelogOpen(false)} />
      )}
    </section>
  );
}
