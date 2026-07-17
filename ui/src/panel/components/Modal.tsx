import { useEffect, type ReactNode } from "react";

interface ModalProps {
  title: string;
  /** Localized label for the ✕ close button (accessibility name). */
  closeLabel: string;
  onClose: () => void;
  children: ReactNode;
  wide?: boolean;
}

// Shared modal shell (Central's equivalent of Capture's PickerShell): overlay,
// titled header with a close button, Escape-to-close, click-outside-to-close.
// Purely presentational — callers pass the localized close label, so it works
// both inside the panel and in a host app's own dialogs.
export function Modal({ title, closeLabel, onClose, children, wide }: ModalProps) {
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose();
    };
    document.addEventListener("keydown", onKey);
    return () => document.removeEventListener("keydown", onKey);
  }, [onClose]);

  return (
    <div className="modal-overlay" role="presentation" onClick={onClose}>
      <div
        className={wide ? "modal modal--wide" : "modal"}
        role="dialog"
        aria-modal="true"
        aria-label={title}
        onClick={(e) => e.stopPropagation()}
      >
        <div className="modal-head">
          <h2 className="modal-title">{title}</h2>
          <button type="button" className="icon-btn" onClick={onClose} aria-label={closeLabel}>
            ✕
          </button>
        </div>
        <div className="modal-body">{children}</div>
      </div>
    </div>
  );
}
