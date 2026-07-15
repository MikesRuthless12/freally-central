import { useT } from "../i18n";
import type { Theme } from "../theme";

interface TopBarProps {
  query: string;
  onQuery: (query: string) => void;
  theme: Theme;
  onToggleTheme: () => void;
  onOpenSettings: () => void;
}

export function TopBar({ query, onQuery, theme, onToggleTheme, onOpenSettings }: TopBarProps) {
  const t = useT();
  return (
    <header className="topbar">
      <div className="brand">
        <img className="brand-logo" src="/logo.png" alt="" width={30} height={30} />
        <span className="brand-name">{t("app-name")}</span>
      </div>
      <div className="topbar-actions">
        <input
          className="search"
          type="search"
          value={query}
          onChange={(e) => onQuery(e.target.value)}
          placeholder={t("search-placeholder")}
          aria-label={t("search-placeholder")}
        />
        <button
          type="button"
          className="icon-btn"
          onClick={onToggleTheme}
          aria-label={t("theme-toggle")}
          title={t("theme-toggle")}
        >
          {theme === "dark" ? "☀" : "☾"}
        </button>
        <button
          type="button"
          className="icon-btn"
          onClick={onOpenSettings}
          aria-label={t("settings-title")}
          title={t("settings-title")}
        >
          ⚙
        </button>
      </div>
    </header>
  );
}
