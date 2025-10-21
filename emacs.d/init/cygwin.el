;; Windows Cygwin shell settings
;; https://www.emacswiki.org/emacs/setup-cygwin.el
(cond
 ((eq system-type 'windows-nt)
  (setq cygwin-root-directory (expand-file-name "~/scoop/persist/cygwin/root"))
  (require 'setup-cygwin)

  (setenv "TMPDIR" (getenv "TEMP"))

  (require 'fakecygpty)
  (fakecygpty-activate)

  (defun ssh (hostname &optional flags)
    "Start an SSH session in a shell window."
    (interactive "MSSH to host: ")
    (let ((buf (concat "*SSH:" hostname "*")))
      (if (and (get-buffer buf) (get-buffer-process buf))
          (switch-to-buffer-other-window buf)
        (async-shell-command (concat "fakecygpty ssh " flags (when flags " ") hostname) buf))))

  (defun sshx (hostname)
    "Start an SSH session with X11 forwarding in a shell window."
    (interactive "MSSH to host (X11): ")
    (ssh hostname "-X"))

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
       (add-to-list 'tramp-methods
                    (mapcar
                     (lambda (x)
                       (cond
                        ((equal x "plink") "klink")
                        ((eq (car x) 'tramp-login-program) (list 'tramp-login-program "klink"))
                        (t x)))
                     (assoc "plink" tramp-methods)))
       (setq tramp-default-method "plink")))

  (add-to-list 'Info-directory-list
               (replace-regexp-in-string "\r?\n$" ""
                                         (shell-command-to-string "cygpath -w /usr/share/info")))))
