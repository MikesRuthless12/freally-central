import type { Page } from "@playwright/test";

/**
 * Seed an accepted EULA (so the gate never blocks a flow test) and clear the
 * catalog/release caches so mocked network routes are always consulted.
 * The one place the storage keys live — every spec imports this.
 */
export async function acceptEula(page: Page): Promise<void> {
  await page.addInitScript(() => {
    try {
      localStorage.setItem("fc.eula.accepted", "2026-07-15");
      for (const key of Object.keys(localStorage)) {
        if (key.startsWith("fc.release.") || key.startsWith("fc.catalog.")) {
          localStorage.removeItem(key);
        }
      }
    } catch {
      /* ignore */
    }
  });
}
