import { useT } from "../i18n";
import { appTagline } from "../catalog/localize";
import type { CatalogApp } from "../catalog/types";
import { AppIcon } from "./AppIcon";

interface ProductCardProps {
  app: CatalogApp;
  onOpen: (app: CatalogApp) => void;
}

export function ProductCard({ app, onOpen }: ProductCardProps) {
  const t = useT();
  const soon = app.status === "coming-soon";
  const tagline = appTagline(t, app);
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
      </div>
    </button>
  );
}
