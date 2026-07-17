// The panel's shell boundary (FC-50): actions only the host app can perform.
// Central passes its opener-plugin implementations; other hosts pass their own.
import { createContext, useContext } from "react";

export interface PanelHost {
  /** Open an external http(s) URL in the OS browser. */
  openExternal: (url: string) => void | Promise<void>;
  /**
   * Reveal a downloaded file in the OS file manager. Optional — when a host
   * has no reveal capability the panel hides its "Show in folder" action.
   */
  revealInFolder?: (path: string) => void | Promise<void>;
}

export const PanelHostContext = createContext<PanelHost | null>(null);

export function useHost(): PanelHost {
  const ctx = useContext(PanelHostContext);
  if (!ctx) throw new Error("Central panel components must render inside <CentralPanel>");
  return ctx;
}

/**
 * The one path panel code hands a URL to the host. Links come from the catalog
 * manifest and the GitHub API; constraining the scheme here means no host and
 * no manifest can ever be tricked into opening a `file:`/other-scheme URL.
 */
export function openExternalUrl(host: PanelHost, url: string): void {
  let parsed: URL;
  try {
    parsed = new URL(url);
  } catch {
    return; // not an absolute URL — nothing safe to open
  }
  if (parsed.protocol !== "http:" && parsed.protocol !== "https:") return;
  void host.openExternal(url);
}
