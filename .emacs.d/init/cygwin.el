;; Windows Cygwin shell settings
(cond
 ((eq system-type 'windows-nt)
  (add-hook 'comint-output-filter-functions
	    'shell-strip-ctrl-m nil t)
  (add-hook 'comint-output-filter-functions
	    'comint-watch-for-password-prompt nil t)
  (setq explicit-shell-file-name "bash.exe")
  ;; For subprocesses invoked via the shell
  ;; (e.g., "shell -c command")
  (setq shell-file-name explicit-shell-file-name)

  (add-to-list 'Info-directory-list
               (replace-regexp-in-string "\r?\n$" ""
                                         (shell-command-to-string "cygpath -w /usr/share/info")))

  (eval-after-load "tramp"
    '(progn
       (add-to-list 'tramp-methods
                    (mapcar
                     (lambda (x)
                       (cond
                        ((equal x "sshx") "cygssh")
                        ((eq (car x) 'tramp-login-program) (list 'tramp-login-program "fakecygpty ssh"))
                        (t x)))
                     (assoc "sshx" tramp-methods)))
       (setq tramp-default-method "cygssh")))))
