// Map the engine's failure codes onto localized message keys — exhaustive over
// the typed code set, so adding a code without a message is a compile error.
// Verify failures get their own honest message (the file was refused and
// discarded); transport-ish failures share the network message.

import type { DownloadFailCode, InstallFailCode } from "./types";

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

// Install failures (Phase 5). The trust-gate refusals get their own honest
// messages — "the file was refused" is a different fact from "the installer
// errored", and the DoD forbids blurring either into success.
const INSTALL_FAILURE_KEY: Record<InstallFailCode, string> = {
  notDownloaded: "install-failed-not-downloaded",
  noChecksum: "install-failed-not-verified",
  untrustedSource: "install-failed-not-verified",
  tampered: "install-failed-verify",
  unsupportedInstaller: "install-failed-unsupported",
  installerFailed: "install-failed-installer",
  elevationDeclined: "install-failed-elevation",
  busy: "install-failed-busy",
  io: "install-failed",
  unknown: "install-failed",
};

export function installFailureMessageKey(code: InstallFailCode): string {
  return INSTALL_FAILURE_KEY[code];
}
