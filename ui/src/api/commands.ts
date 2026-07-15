import { invoke } from "@tauri-apps/api/core";
import { openUrl } from "@tauri-apps/plugin-opener";
import type { BuildInfo, ReleaseNotes } from "./types";

// Build metadata for the About panel (from src-tauri/src/commands.rs).
export function buildInfo(): Promise<BuildInfo> {
  return invoke<BuildInfo>("build_info");
}

// The running build's changelog section for What's New (embedded from CHANGELOG.md).
export function releaseNotes(): Promise<ReleaseNotes> {
  return invoke<ReleaseNotes>("release_notes");
}

/**
 * A plain `<a target="_blank">` doesn't reach the OS browser from a Tauri
 * webview, so hand the URL to the opener plugin. Falls back to window.open when
 * running in a plain browser (dev/test).
 */
export async function openExternal(url: string): Promise<void> {
  try {
    await openUrl(url);
  } catch {
    window.open(url, "_blank", "noopener");
  }
}
