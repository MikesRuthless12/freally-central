import { useState } from "react";
import type { CatalogApp } from "../catalog/types";

interface AppIconProps {
  app: CatalogApp;
  size: number;
}

function monogram(name: string): string {
  const stripped = name.replace(/^Freally\s+/i, "").trim();
  return (stripped || name).charAt(0).toUpperCase() || "F";
}

// The app's own icon is the big card image. If it's missing or fails to load
// (offline, coming-soon app with no hosted icon), fall back to a monogram so the
// grid always renders something legible.
export function AppIcon({ app, size }: AppIconProps) {
  const [failed, setFailed] = useState(false);

  if (!app.icon || failed) {
    return (
      <div
        className="app-icon app-icon--mono"
        style={{ width: size, height: size, fontSize: Math.round(size * 0.42) }}
        aria-hidden="true"
      >
        {monogram(app.name)}
      </div>
    );
  }

  return (
    <img
      className="app-icon"
      src={app.icon}
      alt=""
      width={size}
      height={size}
      loading="lazy"
      onError={() => setFailed(true)}
    />
  );
}
