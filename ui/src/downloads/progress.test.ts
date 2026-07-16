import { describe, expect, it } from "vitest";
import { formatPercent } from "../releases/format";
import type { InstallerAsset } from "../releases/types";
import { batchProgress, fraction, isActive, isCancelable, stateFraction } from "./progress";
import type { AppDownloadState, BatchEntry } from "./types";

function asset(size: number): InstallerAsset {
  return { name: "a.exe", url: "https://github.com/o/r/releases/download/v1/a.exe", size, digest: null };
}

describe("fraction / formatPercent", () => {
  it("is real bytes over total, clamped to [0, 1]", () => {
    expect(fraction(3892, 10000)).toBeCloseTo(0.3892);
    expect(fraction(0, 100)).toBe(0);
    expect(fraction(100, 100)).toBe(1);
    expect(fraction(150, 100)).toBe(1);
    expect(fraction(50, 0)).toBe(0); // no total — never invent progress
  });

  it("formats exactly two decimals (FC-31's precise percent)", () => {
    expect(formatPercent("en", 0.3892)).toBe("38.92%");
    expect(formatPercent("en", 0)).toBe("0.00%");
    // Lands on exactly 100.00% at completion (inputs are clamped by fraction —
    // the single place the [0, 1] invariant lives).
    expect(formatPercent("en", 1)).toBe("100.00%");
    expect(formatPercent("en", 0.9999)).toBe("99.99%");
  });

  it("classifies active and cancelable phases in one place", () => {
    expect(isActive({ phase: "downloading", received: 1, total: 2 })).toBe(true);
    expect(isActive({ phase: "verifying", received: 2, total: 2 })).toBe(true);
    expect(isActive({ phase: "done", path: "x", checksumVerified: true })).toBe(false);
    expect(isActive(undefined)).toBe(false);
    // An orphaned backend download must stay cancelable (post-reload lockout).
    expect(isCancelable({ phase: "failed", code: "alreadyDownloading", received: 0 })).toBe(true);
    expect(isCancelable({ phase: "failed", code: "network", received: 0 })).toBe(false);
    expect(isCancelable({ phase: "downloading", received: 1, total: 2 })).toBe(true);
  });

  it("derives the fraction from each download phase", () => {
    expect(stateFraction(undefined)).toBe(0);
    expect(stateFraction({ phase: "downloading", received: 25, total: 100 })).toBe(0.25);
    expect(stateFraction({ phase: "verifying", received: 100, total: 100 })).toBe(1);
    expect(stateFraction({ phase: "done", path: "x", checksumVerified: true })).toBe(1);
    expect(stateFraction({ phase: "failed", code: "network", received: 25 })).toBe(0);
    expect(stateFraction({ phase: "canceled", received: 25 })).toBe(0);
  });
});

describe("batchProgress (FC-32)", () => {
  const entries: BatchEntry[] = [
    { appId: "a", asset: asset(100) },
    { appId: "b", asset: asset(300) },
    { appId: "c", asset: asset(600) },
  ];

  function states(map: Record<string, AppDownloadState>): Map<string, AppDownloadState> {
    return new Map(Object.entries(map));
  }

  it("aggregates real bytes across the batch", () => {
    const progress = batchProgress(
      entries,
      states({
        a: { phase: "done", path: "x", checksumVerified: true },
        b: { phase: "downloading", received: 150, total: 300 },
        // c not started yet
      }),
    );
    // (100 + 150 + 0) / (100 + 300 + 600)
    expect(progress.fraction).toBeCloseTo(250 / 1000);
    expect(progress.done).toBe(1);
    expect(progress.failed).toBe(0);
    expect(progress.finished).toBe(false);
  });

  it("a failure isolates: the bar still reaches exactly 100% for the rest", () => {
    const progress = batchProgress(
      entries,
      states({
        a: { phase: "done", path: "x", checksumVerified: true },
        b: { phase: "failed", code: "network", received: 150 },
        c: { phase: "done", path: "y", checksumVerified: true },
      }),
    );
    // The failed entry freezes at its real 150 bytes on both sides.
    expect(progress.fraction).toBe(1);
    expect(progress.done).toBe(2);
    expect(progress.failed).toBe(1);
    expect(progress.finished).toBe(true);
  });

  it("a failure never moves the aggregate bar backward", () => {
    const before = batchProgress(
      entries,
      states({
        a: { phase: "done", path: "x", checksumVerified: true },
        b: { phase: "downloading", received: 270, total: 300 },
        c: { phase: "downloading", received: 60, total: 600 },
      }),
    );
    const after = batchProgress(
      entries,
      states({
        a: { phase: "done", path: "x", checksumVerified: true },
        b: { phase: "failed", code: "network", received: 270 },
        c: { phase: "downloading", received: 60, total: 600 },
      }),
    );
    expect(after.fraction).toBeGreaterThanOrEqual(before.fraction);
  });

  it("cancels are counted separately from failures (honest summary)", () => {
    const progress = batchProgress(entries, states({ a: { phase: "canceled", received: 40 } }));
    expect(progress.failed).toBe(0);
    expect(progress.canceled).toBe(1);
    expect(progress.finished).toBe(false);
  });

  it("an empty batch is never 'finished'", () => {
    expect(batchProgress([], states({})).finished).toBe(false);
  });
});
