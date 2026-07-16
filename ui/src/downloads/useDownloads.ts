// The one download store (FC-30/31/32): per-app download state driven by the
// engine's event channel, plus the bounded-concurrency Download All queue.
// Hub owns a single instance and hands it to the cards, detail view, and
// toolbar so every surface reads identical state.

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import type { CatalogApp } from "../catalog/types";
import { liveRelease, type InstallerAsset, type ReleaseState } from "../releases/types";
import { getEngine, getPlatform, type Platform } from "./engine";
import { pickInstaller } from "./pickInstaller";
import {
  DOWNLOAD_FAIL_CODES,
  type AppDownloadState,
  type BatchEntry,
  type DownloadEvent,
  type DownloadFailCode,
} from "./types";

// Download All fetches several installers at once, but never unboundedly —
// three keeps the network busy without starving any single transfer (FC-32).
export const MAX_CONCURRENT_DOWNLOADS = 3;

export interface BatchState {
  /** The queue's lifecycle, owned here (the store starts and settles it) so no
   *  component has to re-derive "is the batch over" from per-entry states. */
  status: "idle" | "running" | "settled";
  /** The queued entries (fixed at start; drives the aggregate bar). */
  entries: BatchEntry[];
}

export interface DownloadsApi {
  /** True when a real engine is present (Tauri shell, or a test injection). */
  supported: boolean;
  /** Per-app download state; absent key = no download attempted this session. */
  byId: ReadonlyMap<string, AppDownloadState>;
  /** The installer the engine would fetch for this app on this machine. */
  installerFor(app: CatalogApp, release: ReleaseState | undefined): InstallerAsset | null;
  /** Download one app's installer (also retry — the engine resumes partials). */
  start(appId: string, asset: InstallerAsset): void;
  /** Cancel one app's running download. */
  cancel(appId: string): void;
  /** Queue every entry with bounded concurrency (FC-32). */
  startAll(entries: BatchEntry[]): void;
  /** Cancel the queue and every running download in it. */
  cancelAll(): void;
  batch: BatchState;
}

/** Narrow an IPC code string to the typed set ("unknown" for anything else). */
function normalizeFailCode(code: string): DownloadFailCode {
  return (DOWNLOAD_FAIL_CODES as readonly string[]).includes(code)
    ? (code as DownloadFailCode)
    : "unknown";
}

/** The real bytes a state has accounted for (0 when nothing transferred). */
function receivedOf(state: AppDownloadState | undefined): number {
  switch (state?.phase) {
    case "downloading":
    case "verifying":
    case "failed":
    case "canceled":
      return state.received;
    default:
      return 0;
  }
}

/** Map one engine event onto the app's UI state (returning undefined = keep).
 *  Terminal failed/canceled states keep the bytes actually transferred so the
 *  aggregate bar stays monotonic (see batchProgress). */
function reduceEvent(
  previous: AppDownloadState | undefined,
  event: DownloadEvent,
  expectedTotal: number,
): AppDownloadState | undefined {
  switch (event.kind) {
    case "started":
      return { phase: "downloading", received: event.resumedFrom, total: event.total };
    case "progress":
      return { phase: "downloading", received: event.received, total: event.total };
    case "verifying":
      // All bytes are in — hold the bar at its real 100% while the hash runs.
      return { phase: "verifying", received: expectedTotal, total: expectedTotal };
    case "done":
      return { phase: "done", path: event.path, checksumVerified: event.checksumVerified };
    case "failed":
      return { phase: "failed", code: normalizeFailCode(event.code), received: receivedOf(previous) };
    case "canceled":
      return { phase: "canceled", received: receivedOf(previous) };
    default:
      return undefined;
  }
}

export function useDownloads(): DownloadsApi {
  const engine = getEngine();
  const supported = engine !== null;

  const [byId, setById] = useState<ReadonlyMap<string, AppDownloadState>>(new Map());
  const [batch, setBatch] = useState<BatchState>({ status: "idle", entries: [] });
  const [platform, setPlatform] = useState<Platform | null>(null);

  // In-flight downloads by app id. Holding the promise (not just a flag) lets
  // a batch worker AWAIT a download that was already started individually
  // instead of skipping past it and finishing the batch early.
  const runningRef = useRef<Map<string, Promise<void>>>(new Map());
  const batchCanceledRef = useRef(false);

  useEffect(() => {
    let alive = true;
    void getPlatform().then((p) => {
      if (alive) setPlatform(p);
    });
    return () => {
      alive = false;
    };
  }, []);

  const setAppState = useCallback((appId: string, state: AppDownloadState) => {
    setById((prev) => {
      const next = new Map(prev);
      next.set(appId, state);
      return next;
    });
  }, []);

  /** Run one download to its terminal state. Never throws (failure isolation).
   *  If this app is already downloading, returns the in-flight promise instead
   *  of restarting it. */
  const runOne = useCallback(
    (appId: string, asset: InstallerAsset): Promise<void> => {
      if (!engine) return Promise.resolve();
      const existing = runningRef.current.get(appId);
      if (existing) return existing;
      const task = (async () => {
        // Immediate feedback while the backend spins up the request.
        let last: AppDownloadState = { phase: "downloading", received: 0, total: asset.size };
        setAppState(appId, last);
        try {
          await engine.start(
            {
              id: appId,
              url: asset.url,
              fileName: asset.name,
              expectedSize: asset.size,
              expectedSha256: asset.digest,
            },
            (event) => {
              const next = reduceEvent(last, event, asset.size);
              if (next) {
                last = next;
                setAppState(appId, next);
              }
            },
          );
        } catch {
          // The invoke itself rejected (no terminal event will come).
          setAppState(appId, { phase: "failed", code: "unknown", received: receivedOf(last) });
        } finally {
          runningRef.current.delete(appId);
        }
      })();
      runningRef.current.set(appId, task);
      return task;
    },
    [engine, setAppState],
  );

  const start = useCallback(
    (appId: string, asset: InstallerAsset) => {
      void runOne(appId, asset);
    },
    [runOne],
  );

  const cancel = useCallback(
    (appId: string) => {
      engine?.cancel(appId);
    },
    [engine],
  );

  const startAll = useCallback(
    (entries: BatchEntry[]) => {
      if (!engine || entries.length === 0) return;
      batchCanceledRef.current = false;
      // Clear stale terminal states from earlier downloads so queued entries
      // read as "not started" — otherwise the aggregate bar counts them as
      // already done and moves backward when they actually begin.
      setById((prev) => {
        const next = new Map(prev);
        for (const entry of entries) {
          if (!runningRef.current.has(entry.appId)) next.delete(entry.appId);
        }
        return next;
      });
      setBatch({ status: "running", entries });
      const queue = [...entries];
      const workers = Array.from(
        { length: Math.min(MAX_CONCURRENT_DOWNLOADS, queue.length) },
        async () => {
          for (;;) {
            const next = queue.shift();
            if (!next || batchCanceledRef.current) return;
            // Each download settles independently — a failure only marks its
            // own card and the worker moves on (FC-32 failure isolation).
            await runOne(next.appId, next.asset);
          }
        },
      );
      void Promise.all(workers).then(() => {
        setBatch((b) => ({ ...b, status: "settled" }));
      });
    },
    [engine, runOne],
  );

  const cancelAll = useCallback(() => {
    batchCanceledRef.current = true;
    for (const appId of runningRef.current.keys()) {
      engine?.cancel(appId);
    }
  }, [engine]);

  const installerFor = useCallback(
    (app: CatalogApp, release: ReleaseState | undefined): InstallerAsset | null => {
      if (!platform || app.status !== "available") return null;
      const live = liveRelease(release);
      return live ? pickInstaller(live.installers[platform.os], platform.os, platform.arch) : null;
    },
    [platform],
  );

  return useMemo(
    () => ({ supported, byId, installerFor, start, cancel, startAll, cancelAll, batch }),
    [supported, byId, installerFor, start, cancel, startAll, cancelAll, batch],
  );
}
