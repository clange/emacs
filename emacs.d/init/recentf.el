;; Recent files
(require 'recentf)
(recentf-mode 1)
; file name history
(put 'file-name-history 'history-length 200)
; now handled by Helm; see helm.el
;; (global-set-key "\C-cr" 'recentf-open-files)

(setq recentf-max-menu-items 50)
(setq recentf-max-saved-items 200)
