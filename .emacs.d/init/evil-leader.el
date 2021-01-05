;; leader:
(use-package evil-leader
  :ensure t)
; enable evil-leader-mode before evil-mode
(evil-leader/set-leader "<SPC>")
(global-evil-leader-mode)

(evil-leader/set-key
  "a" 'org-agenda
  "e" 'ido-find-file
  "b" 'ido-switch-buffer
  "k" 'helm-buffers-list
  "s" 'save-buffer
  "v" 'vc-prefix-map
  "w" 'winum-base-map
  "+" 'evil-numbers/inc-at-pt
  "-" 'evil-numbers/dec-at-pt
  "<SPC>" 'avy-goto-char-2)

;; (evil-leader/set-key-for-mode 'emacs-lisp-mode "b" 'byte-compile-file)
