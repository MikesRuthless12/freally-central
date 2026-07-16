import { useT } from "../i18n";
import type { BatchEntry } from "../downloads/types";
import type { DownloadsApi } from "../downloads/useDownloads";
import { batchProgress } from "../downloads/progress";
import { ProgressBar } from "./ProgressBar";

export type Filter = "all" | "available" | "coming-soon";

interface ToolbarProps {
  filter: Filter;
  onFilter: (filter: Filter) => void;
  downloads: DownloadsApi;
  /** Every installer Download All would fetch on this machine. */
  entries: BatchEntry[];
}

export function Toolbar({ filter, onFilter, downloads, entries }: ToolbarProps) {
  const t = useT();
  const { batch } = downloads;

  // Download All (FC-32): enabled only where a real engine exists and at least
  // one app ships an installer for this machine; the title says why otherwise.
  const canDownloadAll = downloads.supported && entries.length > 0 && batch.status !== "running";
  const hint = !downloads.supported
    ? t("download-all-unsupported")
    : entries.length === 0
      ? t("download-all-none")
      : t("download-all-hint");

  // The aggregate bar reflects the batch that was actually queued; its
  // lifecycle comes from the store, not re-derived from per-entry states.
  const progress = batchProgress(batch.entries, downloads.byId);
  // "Cancel all" can settle a batch with queued entries that never started —
  // count everything that didn't finish or fail as canceled, honestly.
  const canceledCount = batch.entries.length - progress.done - progress.failed;

  return (
    <div className="toolbar">
      <div className="toolbar-row">
        <button
          type="button"
          className="download-all"
          disabled={!canDownloadAll}
          title={hint}
          onClick={() => downloads.startAll(entries)}
        >
          {t("download-all")}
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
          {batch.status === "running" ? (
            <>
              <span className="batch-label">
                {t("batch-progress", {
                  done: progress.done,
                  total: batch.entries.length,
                })}
              </span>
              <ProgressBar
                fraction={progress.fraction}
                label={t("download-all")}
                percentClassName="batch-percent"
              />
              <button type="button" className="btn btn-ghost" onClick={downloads.cancelAll}>
                {t("batch-cancel-all")}
              </button>
            </>
          ) : (
            <span className="batch-label">
              {/* Honest summary: failures and user cancels are different things. */}
              {progress.failed > 0
                ? t("batch-failed", {
                    failed: progress.failed,
                    total: batch.entries.length,
                  })
                : canceledCount > 0
                  ? t("batch-canceled", {
                      canceled: canceledCount,
                      total: batch.entries.length,
                    })
                  : t("batch-done")}
            </span>
          )}
        </div>
      )}
    </div>
  );
}
