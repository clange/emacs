;;;;;;;;;;;;;;;;;;;;
;; set up unicode
(cond
 ((eq system-type 'windows-nt)
  (set-language-environment "UTF-8")
  (prefer-coding-system       'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  ;; This from a japanese individual.  I hope it works.
  (setq default-buffer-file-coding-system 'utf-8-unix)
  ;; From Emacs wiki
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
  ;; MS Windows clipboard is UTF-16LE 
  (set-clipboard-coding-system 'utf-16le-dos)


  (defun my-compile-utf8-advice (orig-fun &rest args)
    "Run `compile` ensuring UTF-8 env and decoding."
    (let ((coding-system-for-read 'utf-8)
          (coding-system-for-write 'utf-8)
          ;; Merge/override LANG/LC_CTYPE just for this invocation:
          (process-environment
           (let ((env (copy-sequence process-environment)))
             (setenv "LANG" "en_US.UTF-8" env)
             (setenv "LC_CTYPE" "en_US.UTF-8" env)
             env)))
      (apply orig-fun args)))

  (advice-add 'compile :around #'my-compile-utf8-advice)))
