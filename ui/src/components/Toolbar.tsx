import { useT } from "../i18n";

export type Filter = "all" | "available" | "coming-soon";

interface ToolbarProps {
  filter: Filter;
  onFilter: (filter: Filter) => void;
}

export function Toolbar({ filter, onFilter }: ToolbarProps) {
  const t = useT();
  return (
    <div className="toolbar">
      {/* Download All is a Phase 4 feature; present in the shell, wired later. */}
      <button type="button" className="download-all" disabled title={t("download-all-hint")}>
        {t("download-all")}
      </button>
      <label className="type-filter">
        <span className="type-filter-label">{t("filter-type")}</span>
        <select
          value={filter}
          onChange={(e) => onFilter(e.target.value as Filter)}
          aria-label={t("filter-type")}
        >
          <option value="all">{t("filter-all")}</option>
          <option value="available">{t("available")}</option>
          <option value="coming-soon">{t("coming-soon")}</option>
        </select>
      </label>
    </div>
  );
}
