import { useCallback, useMemo, useState } from "react";
import { useCatalog } from "../catalog/loader";
import type { CatalogApp } from "../catalog/types";
import { useI18n } from "../i18n";
import { formatCount } from "../releases/format";
import { useReleases } from "../releases/useReleases";
import { useInstalled } from "../install/useInstalled";
import { useDownloads } from "../downloads/useDownloads";
import type { BatchEntry } from "../downloads/types";
import { useTheme } from "../theme";
import { SettingsDialog } from "../panels/Settings";
import { CardGrid } from "./CardGrid";
import { DetailView } from "./DetailView";
import { Toolbar, type Filter } from "./Toolbar";
import { TopBar } from "./TopBar";

function matchesFilter(app: CatalogApp, filter: Filter): boolean {
  return filter === "all" ? true : app.status === filter;
}

export function Hub() {
  const { t, locale } = useI18n();
  const { apps, source, loaded } = useCatalog();
  const releases = useReleases(apps);
  const installed = useInstalled(apps);
  const downloads = useDownloads();
  const { theme, toggle } = useTheme();

  // One manual Refresh re-checks both the live release data and what's installed.
  const refreshAll = useCallback(() => {
    releases.refresh();
    installed.refresh();
  }, [releases, installed]);
  const [filter, setFilter] = useState<Filter>("all");
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [settingsOpen, setSettingsOpen] = useState(false);

  const selected = apps.find((a) => a.id === selectedId) ?? null;
  const visible = useMemo(() => apps.filter((a) => matchesFilter(a, filter)), [apps, filter]);

  // Everything Download All would fetch: each available app whose release
  // ships an installer for this machine (FC-32). Depends on installerFor (a
  // stable callback that changes only with the platform), NOT the whole
  // downloads object — which changes identity on every progress event.
  const { installerFor } = downloads;
  const downloadAllEntries = useMemo<BatchEntry[]>(() => {
    const entries: BatchEntry[] = [];
    for (const app of apps) {
      const asset = installerFor(app, releases.byId.get(app.id));
      if (asset) entries.push({ appId: app.id, asset });
    }
    return entries;
  }, [apps, releases.byId, installerFor]);

  return (
    <div className="app">
      <TopBar theme={theme} onToggleTheme={toggle} onOpenSettings={() => setSettingsOpen(true)} />

      <main className="main">
        {selected ? (
          <DetailView
            app={selected}
            release={releases.byId.get(selected.id)}
            installedVersion={installed.byId.get(selected.id)}
            downloads={downloads}
            onBack={() => setSelectedId(null)}
          />
        ) : (
          <>
            <Toolbar
              filter={filter}
              onFilter={setFilter}
              downloads={downloads}
              entries={downloadAllEntries}
            />
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
                onClick={refreshAll}
                disabled={releases.loading || installed.loading}
              >
                {t("refresh")}
              </button>
            </div>
            <CardGrid
              apps={visible}
              releases={releases.byId}
              installed={installed.byId}
              downloads={downloads.byId}
              onOpen={(a) => setSelectedId(a.id)}
            />
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
