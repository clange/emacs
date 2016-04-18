;;;;;;;;;;;;;;;;;;;;
;; set up unicode
(cond
 ((eq system-type 'windows-nt)
  (prefer-coding-system       'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  ;; This from a japanese individual.  I hope it works.
  (setq default-buffer-file-coding-system 'utf-8)
  ;; From Emacs wiki
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
  ;; MS Windows clipboard is UTF-16LE 
  (set-clipboard-coding-system 'utf-16le-dos)))
