import { openExternal } from "../api/commands";
import { useT } from "../i18n";
import { appDescription, appFeatures, appTagline } from "../catalog/localize";
import type { CatalogApp } from "../catalog/types";
import { AppIcon } from "./AppIcon";

interface DetailViewProps {
  app: CatalogApp;
  onBack: () => void;
}

export function DetailView({ app, onBack }: DetailViewProps) {
  const t = useT();
  const soon = app.status === "coming-soon";
  const tagline = appTagline(t, app);
  const description = appDescription(t, app);
  const features = appFeatures(t, app);
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
            {app.startedDate && (
              <span className="detail-started">{t("detail-started", { date: app.startedDate })}</span>
            )}
          </div>
        </div>
      </div>

      {description && <p className="detail-desc">{description}</p>}

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

      {app.site && (
        <div className="detail-actions">
          <button
            type="button"
            className="btn btn-primary"
            onClick={() => void openExternal(app.site as string)}
          >
            {t("detail-visit-site")}
          </button>
        </div>
      )}
    </section>
  );
}
