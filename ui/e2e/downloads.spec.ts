import { test, expect, type Page } from "@playwright/test";
import { acceptEula } from "./helpers";

// Phase 4 flows: the download engine, the live two-decimal percent, and
// Download All with failure isolation — driven headless with the catalog, the
// GitHub API, and the native engine all mocked through the test-only
// window.__FC_TEST__ seam (the same one the unit tests use). In production the
// engine is the Rust backend streaming real bytes; here it is scripted so the
// bar's behavior is deterministic.

const MANIFEST_URL = "https://mikesruthless12.github.io/freally-central/freally-central.json";

const WINDOWS_ASSETS = { windows: "\\.(exe|msi)$", macos: "\\.dmg$", linux: "\\.(AppImage|deb|rpm)$" };

// Three downloadable apps so Download All has a real queue.
const CATALOG = {
  schemaVersion: 1,
  brand: "Freally",
  apps: [
    { id: "freally-capture", name: "Freally Capture", tagline: "", description: "", features: [], repo: "o/capture", status: "available", assets: WINDOWS_ASSETS },
    { id: "freally-vault", name: "Freally Vault", tagline: "", description: "", features: [], repo: "o/vault", status: "available", assets: WINDOWS_ASSETS },
    { id: "freally-player", name: "Freally Player", tagline: "", description: "", features: [], repo: "o/player", status: "available", assets: WINDOWS_ASSETS },
  ],
};

function releaseFor(repo: string) {
  const app = repo.split("/")[1];
  const name = `${app}_1.0.0_x64-setup.exe`;
  return {
    tag_name: "v1.0.0",
    published_at: "2026-07-10T10:00:00Z",
    html_url: `https://github.com/${repo}/releases/tag/v1.0.0`,
    body: "notes",
    assets: [
      {
        name,
        browser_download_url: `https://github.com/${repo}/releases/download/v1.0.0/${name}`,
        download_count: 10,
        size: 500_000,
        digest: `sha256:${"e".repeat(64)}`,
      },
    ],
  };
}

/** EULA accepted, caches cleared, catalog + releases mocked, engine injected. */
async function installMocks(page: Page, options: { failIds?: string[] } = {}) {
  await acceptEula(page);
  await page.addInitScript((failIds: string[]) => {
    // A deterministic scripted engine behind the app's test-only seam.
    const active = new Map<string, { canceled: boolean }>();
    const fail = new Set(failIds);
    window.__FC_TEST__ = {
      platform: { os: "windows", arch: "x86_64" },
      downloadEngine: {
        async start(request, onEvent) {
          const entry = { canceled: false };
          active.set(request.id, entry);
          const total = request.expectedSize;
          const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
          onEvent({ kind: "started", total, resumedFrom: 0 });
          const steps = 5;
          for (let i = 1; i <= steps; i += 1) {
            await sleep(120);
            if (entry.canceled) {
              onEvent({ kind: "canceled" });
              active.delete(request.id);
              return;
            }
            if (fail.has(request.id) && i === 2) {
              onEvent({ kind: "failed", code: "network", detail: "scripted failure" });
              active.delete(request.id);
              return;
            }
            onEvent({ kind: "progress", received: Math.round((total * i) / steps), total });
          }
          onEvent({ kind: "verifying" });
          await sleep(500);
          onEvent({
            kind: "done",
            path: `C:/downloads/${request.fileName}`,
            sha256: "e".repeat(64),
            checksumVerified: true,
          });
          active.delete(request.id);
        },
        cancel(id) {
          const entry = active.get(id);
          if (entry) entry.canceled = true;
        },
      },
    };
  }, options.failIds ?? []);

  await page.route(MANIFEST_URL, (route) =>
    route.fulfill({ status: 200, contentType: "application/json", body: JSON.stringify(CATALOG) }),
  );
  await page.route("https://api.github.com/repos/**/releases/latest", async (route) => {
    const repo = /repos\/([^/]+\/[^/]+)\//.exec(route.request().url())?.[1] ?? "o/unknown";
    await route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify(releaseFor(repo)),
    });
  });
}

test("a download streams to a verified 100.00% (FC-30/31)", async ({ page }) => {
  await installMocks(page);
  await page.goto("/");

  await page.getByRole("button", { name: /Freally Capture/ }).click();
  await page.getByRole("button", { name: "Download", exact: true }).click();

  // The live percent is always two decimals while streaming…
  const percent = page.locator(".detail-download-percent");
  await expect(percent).toHaveText(/^\d{1,3}[.,]\d{2}\s?%$/);
  // …lands on exactly 100.00% (held through verification)…
  await expect(percent).toHaveText("100.00%");
  await expect(page.locator(".detail-download-phase")).toHaveText("Verifying…");
  // …and ends honestly verified.
  await expect(page.locator(".detail-download-note--ok")).toHaveText("Downloaded & verified");
});

test("a download can be canceled and retried", async ({ page }) => {
  await installMocks(page);
  await page.goto("/");

  await page.getByRole("button", { name: /Freally Capture/ }).click();
  await page.getByRole("button", { name: "Download", exact: true }).click();
  await page.getByRole("button", { name: "Cancel", exact: true }).click();

  await expect(page.locator(".detail-download-note")).toHaveText("Download canceled.");
  // Retry runs the download to completion.
  await page.getByRole("button", { name: "Retry", exact: true }).click();
  await expect(page.locator(".detail-download-note--ok")).toHaveText("Downloaded & verified");
});

test("Download All fetches every app; one failure isolates (FC-32)", async ({ page }) => {
  await installMocks(page, { failIds: ["freally-vault"] });
  await page.goto("/");

  const downloadAll = page.getByRole("button", { name: "Download All" });
  await expect(downloadAll).toBeEnabled();
  await downloadAll.click();

  // The aggregate bar shows a live two-decimal percent while the batch runs.
  await expect(page.locator(".batch-percent")).toHaveText(/^\d{1,3}[.,]\d{2}\s?%$/);

  // The batch finishes despite the forced failure, and reports it honestly.
  await expect(page.locator(".batch-label")).toHaveText("1 of 3 downloads failed.");

  // The survivors completed: open one and confirm its verified note.
  await page.getByRole("button", { name: /Freally Capture/ }).click();
  await expect(page.locator(".detail-download-note--ok")).toHaveText("Downloaded & verified");
});
