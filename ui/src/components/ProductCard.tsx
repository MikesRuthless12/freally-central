import { useT } from "../i18n";
import { appTagline } from "../catalog/localize";
import type { CatalogApp } from "../catalog/types";
import { liveRelease, type ReleaseState } from "../releases/types";
import { AppIcon } from "./AppIcon";

interface ProductCardProps {
  app: CatalogApp;
  release?: ReleaseState;
  onOpen: (app: CatalogApp) => void;
}

export function ProductCard({ app, release, onOpen }: ProductCardProps) {
  const t = useT();
  const soon = app.status === "coming-soon";
  const tagline = appTagline(t, app);
  const live = liveRelease(release);
  return (
    <button
      type="button"
      className={soon ? "card card--soon" : "card"}
      onClick={() => onOpen(app)}
    >
      <div className="card-head">
        <h3 className="card-name">{app.name}</h3>
        {tagline && <p className="card-tagline">{tagline}</p>}
      </div>
      <div className="card-art">
        <AppIcon app={app} size={150} />
      </div>
      <div className="card-foot">
        <span className={soon ? "pill pill--soon" : "pill pill--view"}>
          {soon ? t("coming-soon") : t("card-download")}
        </span>
        {live && (
          <p className="card-meta">
            <span className="card-version">v{live.version}</span>
            {" · "}
            {/* Pass the number (not a preformatted string) so Fluent selects the
                right plural form and formats it for the active locale. */}
            {t("downloads-count", { count: live.totalDownloads })}
          </p>
        )}
      </div>
    </button>
  );
}
