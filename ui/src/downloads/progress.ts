// Percent math and shared state predicates for the live progress bars (FC-31).
// The fraction is always real-bytes / published-size, clamped HERE and only
// here — every value the bars and percent labels render funnels through
// fraction(), so this is the single place the [0, 1] invariant lives.
// (Locale formatting is formatPercent in releases/format.ts, cached per locale.)

import type { AppDownloadState, BatchEntry } from "./types";

/** Bytes-received / total as a fraction in [0, 1]. */
export function fraction(received: number, total: number): number {
  if (!(total > 0)) return 0;
  return Math.min(Math.max(received / total, 0), 1);
}

/** True while bytes are moving or verification runs — the phases that render a
 *  live bar. The one definition every surface shares. */
export function isActive(state: AppDownloadState | undefined): boolean {
  return state?.phase === "downloading" || state?.phase === "verifying";
}

/** True when Cancel is meaningful: an active transfer, or an orphaned backend
 *  download ("alreadyDownloading" — e.g. after a reload, where the backend
 *  registry survived but this session's state didn't). */
export function isCancelable(state: AppDownloadState | undefined): boolean {
  return isActive(state) || (state?.phase === "failed" && state.code === "alreadyDownloading");
}

/** The fraction for one app's download state (done = 1, not started/failed = 0). */
export function stateFraction(state: AppDownloadState | undefined): number {
  switch (state?.phase) {
    case "downloading":
    case "verifying":
      return fraction(state.received, state.total);
    case "done":
      return 1;
    default:
      return 0;
  }
}

export interface BatchProgress {
  /** Aggregate fraction across the batch (real bytes; see batchProgress). */
  fraction: number;
  /** Entries that reached "done". */
  done: number;
  /** Entries that failed (canceled ones are counted separately — honest). */
  failed: number;
  /** Entries the user canceled. */
  canceled: number;
  /** True once every entry is terminal. */
  finished: boolean;
}

/**
 * Aggregate Download All progress (FC-32): total real bytes received across the
 * batch over the total expected bytes. A failed or canceled entry freezes at
 * the bytes it actually transferred (they stay on BOTH sides of the fraction),
 * so the bar never moves backward and still lands on exactly 100% when the
 * successful set finishes — one bad download never wedges the aggregate.
 */
export function batchProgress(
  entries: BatchEntry[],
  states: ReadonlyMap<string, AppDownloadState>,
): BatchProgress {
  let receivedSum = 0;
  let totalSum = 0;
  let done = 0;
  let failed = 0;
  let canceled = 0;
  let terminal = 0;
  for (const entry of entries) {
    const state = states.get(entry.appId);
    switch (state?.phase) {
      case "done":
        done += 1;
        terminal += 1;
        receivedSum += entry.asset.size;
        totalSum += entry.asset.size;
        break;
      case "failed":
      case "canceled": {
        if (state.phase === "failed") failed += 1;
        else canceled += 1;
        terminal += 1;
        const kept = Math.min(state.received, entry.asset.size);
        receivedSum += kept;
        totalSum += kept;
        break;
      }
      case "downloading":
      case "verifying":
        receivedSum += Math.min(state.received, entry.asset.size);
        totalSum += entry.asset.size;
        break;
      default:
        // Not started yet — its full size is still ahead of us.
        totalSum += entry.asset.size;
        break;
    }
  }
  return {
    fraction: fraction(receivedSum, totalSum),
    done,
    failed,
    canceled,
    finished: entries.length > 0 && terminal === entries.length,
  };
}
