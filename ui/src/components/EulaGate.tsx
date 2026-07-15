import { useState, type UIEvent } from "react";
import { exit } from "@tauri-apps/plugin-process";
import eulaText from "../legal/eula.md?raw";
import { useT } from "../i18n";

// First-run EULA gate (FC-06): the app does not proceed until the user accepts.
// Accept is enabled only after the text is scrolled to the end; acceptance is
// remembered by the caller (App.tsx). Decline closes the app.
export function EulaGate({ onAccept }: { onAccept: () => void }) {
  const t = useT();
  const [atEnd, setAtEnd] = useState(false);

  const onScroll = (e: UIEvent<HTMLDivElement>) => {
    const el = e.currentTarget;
    if (el.scrollTop + el.clientHeight >= el.scrollHeight - 12) setAtEnd(true);
  };

  const decline = () => {
    // You must accept to use the app; declining quits it.
    void exit(0).catch(() => {
      /* not running under Tauri (dev/test) — no-op */
    });
  };

  return (
    <div className="eula-overlay" role="dialog" aria-modal="true" aria-labelledby="eula-title">
      <div className="eula">
        <h2 id="eula-title" className="eula-title">
          {t("eula-title")}
        </h2>
        <p className="eula-intro">{t("eula-intro")}</p>
        <div className="eula-body" onScroll={onScroll}>
          <pre className="eula-text">{eulaText}</pre>
        </div>
        {!atEnd && <p className="eula-hint">{t("eula-scroll-hint")}</p>}
        <div className="eula-actions">
          <button type="button" className="btn btn-ghost" onClick={decline}>
            {t("eula-decline")}
          </button>
          <button type="button" className="btn btn-primary" disabled={!atEnd} onClick={onAccept}>
            {t("eula-accept")}
          </button>
        </div>
      </div>
    </div>
  );
}
