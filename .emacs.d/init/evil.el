; a prerequisite (should be required by evil, but sometimes that doesn't work)
(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)

(require 'evil)
(evil-mode 1)

;; modes
(add-to-list 'evil-insert-state-modes 'log-edit-mode)
(add-to-list 'evil-emacs-state-modes 'Buffer-menu-mode)
;; TODO report as bug in evil-vars.el
(add-to-list 'evil-emacs-state-modes 'reftex-select-label-mode)
(add-to-list 'evil-emacs-state-modes 'org-mode)
(add-to-list 'evil-emacs-state-modes 'makey-key-mode)
(add-to-list 'evil-emacs-state-modes 'magit-popup-mode)
(add-to-list 'evil-motion-state-modes 'diff-mode)

;; key mappings

; use TAB as an alternative to ESC to exit insert mode
(define-key evil-normal-state-map [tab] 'evil-normal-state)
(define-key evil-visual-state-map [tab] 'evil-normal-state)
(define-key evil-insert-state-map [tab] 'evil-normal-state)
(define-key evil-replace-state-map [tab] 'evil-normal-state)
; transpose chars
(define-key evil-normal-state-map "gt" 'transpose-chars)
; further keys
(define-key evil-motion-state-map [XF86Back] 'evil-jump-backward)
(when evil-want-C-i-jump
  (define-key evil-motion-state-map [XF86Forward] 'evil-jump-forward))

(setq evil-echo-state t)
(setq evil-search-module 'evil-search)
