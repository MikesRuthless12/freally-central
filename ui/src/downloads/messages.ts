// Map the engine's failure codes onto localized message keys — exhaustive over
// the typed code set, so adding a code without a message is a compile error.
// Verify failures get their own honest message (the file was refused and
// discarded); transport-ish failures share the network message.

import type { DownloadFailCode } from "./types";

const FAILURE_KEY: Record<DownloadFailCode, string> = {
  network: "dl-failed-network",
  shortDownload: "dl-failed-network",
  sizeMismatch: "dl-failed-verify",
  checksumMismatch: "dl-failed-verify",
  alreadyDownloading: "dl-failed-busy",
  badRequest: "dl-failed",
  io: "dl-failed",
  unknown: "dl-failed",
};

export function failureMessageKey(code: DownloadFailCode): string {
  return FAILURE_KEY[code];
}
