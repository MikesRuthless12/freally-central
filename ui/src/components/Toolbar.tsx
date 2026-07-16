import { useT } from "../i18n";
import type { BatchEntry } from "../downloads/types";
import type { BatchSummary, DownloadsApi } from "../downloads/useDownloads";
import { batchProgress, installProgress } from "../downloads/progress";
import { ProgressBar } from "./ProgressBar";

export type Filter = "all" | "available" | "coming-soon";

interface ToolbarProps {
  filter: Filter;
  onFilter: (filter: Filter) => void;
  downloads: DownloadsApi;
  /** Every installer Download & install all would fetch on this machine. */
  entries: BatchEntry[];
}

export function Toolbar({ filter, onFilter, downloads, entries }: ToolbarProps) {
  const t = useT();
  const { batch } = downloads;
  const busy = batch.status === "running" || batch.status === "installing";

  // Download & install all (FC-32 + FC-40): enabled only where a real engine
  // exists and at least one app ships an installer for this machine; the
  // title says why otherwise.
  const canStart = downloads.supported && entries.length > 0 && !busy;
  const hint = !downloads.supported
    ? t("install-all-unsupported")
    : entries.length === 0
      ? t("install-all-none")
      : t("install-all-hint");

  // The live aggregate bar reflects the batch that was actually queued; the
  // lifecycle comes from the store, not re-derived from per-entry states. Each
  // stage's aggregate is computed only while that stage renders it.
  let liveBar: { label: string; fraction: number } | null = null;
  if (batch.status === "running") {
    const progress = batchProgress(batch.entries, downloads.byId);
    liveBar = {
      label: t("batch-progress", { done: progress.done, total: batch.entries.length }),
      fraction: progress.fraction,
    };
  } else if (batch.status === "installing") {
    const installs = installProgress(batch.installIds, downloads.byId);
    liveBar = {
      label: t("batch-installing", { done: installs.installed, total: batch.installIds.length }),
      fraction: installs.fraction,
    };
  }

  // The settled line reports EVERY problem the batch had — a failed install
  // must never hide a download that was never fetched, and vice versa. It
  // reads from the summary frozen at settle time, so later activity on a
  // member app can't rewrite what this batch's outcome was.
  const settledLabel = (s: BatchSummary): string => {
    const entriesTotal = batch.entries.length;
    const installTotal = batch.installIds.length;
    const parts: string[] = [];
    if (s.downloadsFailed > 0) {
      parts.push(t("batch-failed", { failed: s.downloadsFailed, total: entriesTotal }));
    }
    if (s.installsFailed > 0) {
      parts.push(t("batch-install-failed", { failed: s.installsFailed, total: installTotal }));
    }
    if (s.downloadsCanceled > 0) {
      parts.push(t("batch-canceled", { canceled: s.downloadsCanceled, total: entriesTotal }));
    }
    if (s.installsCanceled > 0) {
      parts.push(
        t("batch-install-canceled", { canceled: s.installsCanceled, total: installTotal }),
      );
    }
    if (parts.length > 0) return parts.join(" ");
    return installTotal > 0 ? t("batch-installed") : t("batch-done");
  };

  return (
    <div className="toolbar">
      <div className="toolbar-row">
        <button
          type="button"
          className="download-all"
          disabled={!canStart}
          title={hint}
          onClick={() => downloads.startAll(entries)}
        >
          {t("install-all")}
        </button>
        <label className="type-filter">
          <span className="type-filter-label">{t("filter-type")}</span>
          <select
            value={filter}
            onChange={(e) => onFilter(e.target.value as Filter)}
            aria-label={t("filter-type")}
          >
            <option value="all">{t("filter-all")}</option>
            <option value="available">{t("available")}</option>
            <option value="coming-soon">{t("coming-soon")}</option>
          </select>
        </label>
      </div>

      {batch.status !== "idle" && (
        <div className="batch">
          {liveBar && (
            <>
              <span className="batch-label">{liveBar.label}</span>
              <ProgressBar
                fraction={liveBar.fraction}
                label={t("install-all")}
                percentClassName="batch-percent"
              />
              <button type="button" className="btn btn-ghost" onClick={downloads.cancelAll}>
                {t("batch-cancel-all")}
              </button>
            </>
          )}
          {batch.status === "settled" && batch.summary && (
            <span className="batch-label">{settledLabel(batch.summary)}</span>
          )}
        </div>
      )}
    </div>
  );
}
