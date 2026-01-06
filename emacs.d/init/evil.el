; a prerequisite (should be required by evil, but sometimes that doesn't work)
(use-package goto-chg
  :ensure t)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)

(use-package evil
  :ensure t)
(evil-mode 1)

;; modes
(dolist (mode '(
                Buffer-menu-mode
                ag-mode
                calculator-mode
                flycheck-error-list-mode
                git-rebase-mode
                magit-popup-mode
                makey-key-mode
                reftex-select-label-mode ;; TODO report as bug in evil-vars.el
                ))
  (add-to-list 'evil-emacs-state-modes mode))
(dolist (mode '(
                git-commit-mode
                log-edit-mode
                vc-git-log-edit-mode
                post-mode
                ))
  (add-to-list 'evil-insert-state-modes mode))
(dolist (mode '(
                diff-mode
                ))
  (add-to-list 'evil-motion-state-modes mode))

;; http://blog.aaronbieber.com/2016/01/23/living-in-evil.html
(add-hook 'occur-mode-hook
          (lambda ()
            (evil-add-hjkl-bindings occur-mode-map 'emacs
              (kbd "/")       'evil-search-forward
              (kbd "n")       'evil-search-next
              (kbd "N")       'evil-search-previous
              ;; (kbd "C-d")     'evil-scroll-down
              ;; (kbd "C-u")     'evil-scroll-up
              (kbd "C-w C-w") 'other-window)))

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
(evil-set-undo-system 'undo-fu)
