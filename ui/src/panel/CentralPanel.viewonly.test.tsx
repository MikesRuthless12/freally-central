import { cleanup, fireEvent, render, screen, waitFor } from "@testing-library/react";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { CentralPanel } from "./CentralPanel";
import type { PanelHost } from "./host";

// View-only mode (allowDownloads=false): the panel a host embeds when it only
// wants to showcase the family — every download/install control is gone, but
// the cards, detail, real counts, and changelog stay. The panel is localized by
// the host, so a pass-through `t` lets us assert on the fcp-* keys directly.
const t = (id: string) => id;

function renderPanel(allowDownloads: boolean) {
  const host: PanelHost = { openExternal: vi.fn() };
  return render(<CentralPanel t={t} locale="en" host={host} allowDownloads={allowDownloads} />);
}

describe("CentralPanel view-only mode", () => {
  beforeEach(() => {
    // Offline: the catalog falls back to the bundled copy and release data stays
    // unavailable — the grid still renders every app from the manifest.
    vi.stubGlobal("fetch", vi.fn(() => Promise.reject(new Error("offline"))));
  });
  afterEach(() => {
    cleanup();
    vi.unstubAllGlobals();
    vi.clearAllMocks();
  });

  it("hides Download-All yet keeps the grid and the type filter", async () => {
    renderPanel(false);
    await screen.findByRole("heading", { name: "Freally Capture" });
    // Let the offline resolution settle so no state update escapes act().
    await waitFor(() => expect(screen.getByText("fcp-status-offline")).toBeInTheDocument());

    expect(screen.queryByRole("button", { name: "fcp-install-all" })).toBeNull();
    expect(screen.getByRole("combobox")).toBeInTheDocument();
  });

  it("labels an available app 'Available', never 'Download'", async () => {
    renderPanel(false);
    await screen.findByRole("heading", { name: "Freally Capture" });
    await waitFor(() => expect(screen.getByText("fcp-status-offline")).toBeInTheDocument());

    // Capture is available; its card pill must not invite a download here.
    expect(screen.queryByText("fcp-card-download")).toBeNull();
  });

  it("full mode still shows Download-All and the card's Download pill", async () => {
    renderPanel(true);
    await screen.findByRole("heading", { name: "Freally Capture" });
    await waitFor(() => expect(screen.getByText("fcp-status-offline")).toBeInTheDocument());

    expect(screen.getByRole("button", { name: "fcp-install-all" })).toBeInTheDocument();
    expect(screen.getByText("fcp-card-download")).toBeInTheDocument();
  });

  it("the detail view offers the site, not a download/install action", async () => {
    renderPanel(false);
    const card = await screen.findByRole("button", { name: /Freally Capture/ });
    fireEvent.click(card);

    await screen.findByRole("heading", { level: 2, name: "Freally Capture" });
    // Visit-site is the primary action; no Install/Update/Download/Open exist.
    expect(screen.getByRole("button", { name: "fcp-detail-visit-site" })).toBeInTheDocument();
    expect(screen.queryByRole("button", { name: "fcp-card-download" })).toBeNull();
    expect(screen.queryByRole("button", { name: "fcp-action-install" })).toBeNull();
    expect(screen.queryByRole("button", { name: "fcp-open-app" })).toBeNull();
  });
});
