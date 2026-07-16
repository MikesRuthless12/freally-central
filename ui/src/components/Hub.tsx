import { useMemo, useState } from "react";
import { useCatalog } from "../catalog/loader";
import type { CatalogApp } from "../catalog/types";
import { useI18n } from "../i18n";
import { formatCount } from "../releases/format";
import { useReleases } from "../releases/useReleases";
import { useTheme } from "../theme";
import { SettingsDialog } from "../panels/Settings";
import { CardGrid } from "./CardGrid";
import { DetailView } from "./DetailView";
import { Toolbar, type Filter } from "./Toolbar";
import { TopBar } from "./TopBar";

function matchesFilter(app: CatalogApp, filter: Filter): boolean {
  return filter === "all" ? true : app.status === filter;
}

function matchesQuery(app: CatalogApp, query: string): boolean {
  if (!query) return true;
  const needle = query.toLowerCase();
  return (
    app.name.toLowerCase().includes(needle) ||
    app.tagline.toLowerCase().includes(needle) ||
    app.description.toLowerCase().includes(needle)
  );
}

export function Hub() {
  const { t, locale } = useI18n();
  const { apps, source, loaded } = useCatalog();
  const releases = useReleases(apps);
  const { theme, toggle } = useTheme();
  const [query, setQuery] = useState("");
  const [filter, setFilter] = useState<Filter>("all");
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [settingsOpen, setSettingsOpen] = useState(false);

  const selected = apps.find((a) => a.id === selectedId) ?? null;
  const visible = useMemo(
    () => apps.filter((a) => matchesFilter(a, filter) && matchesQuery(a, query)),
    [apps, filter, query],
  );

  return (
    <div className="app">
      <TopBar
        query={query}
        onQuery={setQuery}
        theme={theme}
        onToggleTheme={toggle}
        onOpenSettings={() => setSettingsOpen(true)}
      />

      <main className="main">
        {selected ? (
          <DetailView
            app={selected}
            release={releases.byId.get(selected.id)}
            onBack={() => setSelectedId(null)}
          />
        ) : (
          <>
            <Toolbar filter={filter} onFilter={setFilter} />
            {loaded && source === "bundled" && (
              <p className="offline-note">{t("status-offline")}</p>
            )}
            <div className="brand-total">
              {releases.grandTotal !== null && (
                <span className="brand-total-count">
                  {t("downloads-brandwide", { count: formatCount(locale, releases.grandTotal) })}
                </span>
              )}
              <button
                type="button"
                className="link-btn"
                onClick={releases.refresh}
                disabled={releases.loading}
              >
                {t("refresh")}
              </button>
            </div>
            <CardGrid apps={visible} releases={releases.byId} onOpen={(a) => setSelectedId(a.id)} />
          </>
        )}
      </main>

      <footer className="footer">{t("footer-note")}</footer>

      {settingsOpen && (
        <SettingsDialog onClose={() => setSettingsOpen(false)} theme={theme} onToggleTheme={toggle} />
      )}
    </div>
  );
}
