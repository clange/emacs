;; evil-leader no longer worked for me (https://old.reddit.com/r/emacs/comments/x79dds/evil_and_org_tables_what_am_i_missing/inbycsi/)

;; general:
(use-package general
  :ensure t)

; enable evil-leader-mode before evil-mode
(general-create-definer my-leader-def
                        :prefix "SPC")

(my-leader-def
 :keymaps 'normal
 "a" 'org-agenda
 "e" 'ido-find-file
 "b" 'ido-switch-buffer
 "k" 'helm-buffers-list
 "s" 'save-buffer
 "v" 'vc-prefix-map
 "w" 'winum-base-map
 "+" 'evil-numbers/inc-at-pt
 "-" 'evil-numbers/dec-at-pt
 "SPC" 'avy-goto-char-2)
 
;; (evil-leader/set-key-for-mode 'emacs-lisp-mode "b" 'byte-compile-file)
