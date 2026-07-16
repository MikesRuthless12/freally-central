import { openExternal } from "../api/commands";
import { useI18n } from "../i18n";
import type { CatalogApp } from "../catalog/types";
import { formatDate } from "../releases/format";
import type { ReleaseInfo } from "../releases/types";
import { Modal } from "./Modal";

interface ChangelogViewProps {
  app: CatalogApp;
  release: ReleaseInfo;
  onClose: () => void;
}

// The in-app changelog / What's New viewer (FC-12). The chrome (title, heading,
// version line, buttons) is fully localized; the release notes themselves are
// shown verbatim from GitHub. "View full changelog" opens the app's own branded
// changelog page; "View on GitHub" opens the release. React escapes the notes,
// so untrusted markup in a release body can never inject into the UI.
export function ChangelogView({ app, release, onClose }: ChangelogViewProps) {
  const { t, locale } = useI18n();
  const date = formatDate(locale, release.publishedAt) ?? release.publishedAt;
  return (
    <Modal title={t("whats-new-title")} onClose={onClose} wide>
      <div className="changelog">
        <p className="changelog-heading">{t("changelog-heading", { name: app.name })}</p>
        <p className="muted changelog-version">
          {t("changelog-version", { version: release.version, date })}
        </p>
        {release.notes ? (
          <div className="changelog-notes">{release.notes}</div>
        ) : (
          <p className="muted">{t("changelog-empty")}</p>
        )}
        <div className="changelog-links">
          {app.changelog && (
            <button
              type="button"
              className="link-btn"
              onClick={() => void openExternal(app.changelog as string)}
            >
              {t("changelog-view-full")}
            </button>
          )}
          {release.htmlUrl && (
            <button
              type="button"
              className="link-btn"
              onClick={() => void openExternal(release.htmlUrl)}
            >
              {t("changelog-view-release")}
            </button>
          )}
        </div>
      </div>
    </Modal>
  );
}
