import { useT } from "../i18n";
import type { BatchEntry } from "../downloads/types";
import type { DownloadsApi } from "../downloads/useDownloads";
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

  // The aggregate bars reflect the batch that was actually queued; the
  // lifecycle comes from the store, not re-derived from per-entry states.
  const progress = batchProgress(batch.entries, downloads.byId);
  const installs = installProgress(batch.installIds, downloads.byId);
  // "Cancel all" can settle a batch with queued entries that never started —
  // count everything that didn't finish or fail as canceled, honestly.
  const canceledCount = batch.entries.length - progress.done - progress.failed;

  // The one honest settled line, most specific problem first: a failed install
  // outranks a failed download outranks a cancel outranks success.
  const settledLabel =
    installs.failed > 0
      ? t("batch-install-failed", { failed: installs.failed, total: batch.installIds.length })
      : progress.failed > 0
        ? t("batch-failed", { failed: progress.failed, total: batch.entries.length })
        : installs.canceled > 0
          ? t("batch-install-canceled", {
              canceled: installs.canceled,
              total: batch.installIds.length,
            })
          : canceledCount > 0
            ? t("batch-canceled", { canceled: canceledCount, total: batch.entries.length })
            : batch.installIds.length > 0
              ? t("batch-installed")
              : t("batch-done");

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
          {batch.status === "running" && (
            <>
              <span className="batch-label">
                {t("batch-progress", {
                  done: progress.done,
                  total: batch.entries.length,
                })}
              </span>
              <ProgressBar
                fraction={progress.fraction}
                label={t("install-all")}
                percentClassName="batch-percent"
              />
              <button type="button" className="btn btn-ghost" onClick={downloads.cancelAll}>
                {t("batch-cancel-all")}
              </button>
            </>
          )}
          {batch.status === "installing" && (
            <>
              <span className="batch-label">
                {t("batch-installing", {
                  done: installs.installed,
                  total: batch.installIds.length,
                })}
              </span>
              <ProgressBar
                fraction={installs.fraction}
                label={t("install-all")}
                percentClassName="batch-percent"
              />
              <button type="button" className="btn btn-ghost" onClick={downloads.cancelAll}>
                {t("batch-cancel-all")}
              </button>
            </>
          )}
          {batch.status === "settled" && <span className="batch-label">{settledLabel}</span>}
        </div>
      )}
    </div>
  );
}
