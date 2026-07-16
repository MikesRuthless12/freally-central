import { useT } from "../i18n";
import type { CatalogApp } from "../catalog/types";
import type { ReleaseState } from "../releases/types";
import { ProductCard } from "./ProductCard";

interface CardGridProps {
  apps: CatalogApp[];
  releases: Map<string, ReleaseState>;
  onOpen: (app: CatalogApp) => void;
}

export function CardGrid({ apps, releases, onOpen }: CardGridProps) {
  const t = useT();
  if (apps.length === 0) {
    return <p className="grid-empty">{t("grid-empty")}</p>;
  }
  return (
    <div className="grid">
      {apps.map((app) => (
        <ProductCard key={app.id} app={app} release={releases.get(app.id)} onOpen={onOpen} />
      ))}
    </div>
  );
}
