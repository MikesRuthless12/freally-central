// Download engine types (Phase 4 / FC-30..32). The engine itself is native
// (src-tauri/src/download.rs); the UI drives it over an IPC channel and renders
// real byte progress — every percent shown is bytes-received / published-size.

import type { InstallerAsset } from "../releases/types";

/// What the UI hands the engine for one download (mirrors Rust's DownloadRequest).
export interface DownloadRequest {
  id: string; // catalog app id — also the cancel key
  url: string;
  fileName: string;
  expectedSize: number;
  expectedSha256: string | null; // the API's "sha256:<hex>" digest, when published
}

/// Events streamed back from the engine (mirrors Rust's DownloadEvent).
export type DownloadEvent =
  | { kind: "started"; total: number; resumedFrom: number }
  | { kind: "progress"; received: number; total: number }
  | { kind: "verifying" }
  | { kind: "done"; path: string; sha256: string; checksumVerified: boolean }
  | { kind: "failed"; code: string; detail: string }
  | { kind: "canceled" };

/// The engine boundary. Production is the Tauri backend; tests inject a scripted
/// fake (see engine.ts) so flows are drivable outside the shell.
export interface DownloadEngine {
  /** Resolves once the download reaches a terminal state (done/failed/canceled). */
  start(request: DownloadRequest, onEvent: (event: DownloadEvent) => void): Promise<void>;
  /** Cancel by app id; the engine answers with a terminal "canceled" event. */
  cancel(id: string): void;
}

/// The engine's stable failure codes (mirrors Rust's `fail` module), plus the
/// UI-side "unknown" for anything unrecognized. Typing the closed set keeps
/// every code-keyed lookup (messages, cancel affordances) compiler-checked.
export const DOWNLOAD_FAIL_CODES = [
  "badRequest",
  "alreadyDownloading",
  "network",
  "sizeMismatch",
  "shortDownload",
  "checksumMismatch",
  "io",
  "unknown",
] as const;
export type DownloadFailCode = (typeof DOWNLOAD_FAIL_CODES)[number];

/// One app's download as the UI tracks it. "verifying" keeps the byte counts so
/// the bar holds at 100% while the checksum runs; "done" records what was
/// actually verified (honest: checksum only when a digest was published).
/// Failed/canceled keep the real bytes received so aggregate progress stays
/// monotonic — a terminal entry freezes at what it actually transferred.
export type AppDownloadState =
  | { phase: "downloading"; received: number; total: number }
  | { phase: "verifying"; received: number; total: number }
  | { phase: "done"; path: string; checksumVerified: boolean }
  | { phase: "failed"; code: DownloadFailCode; received: number }
  | { phase: "canceled"; received: number };

/// An entry in the Download All queue: the app id plus its resolved installer.
export interface BatchEntry {
  appId: string;
  asset: InstallerAsset;
}
