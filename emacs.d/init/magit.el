;; http://www.emacswiki.org/emacs/Magit#toc5
;; (eval-after-load "magit"
;;   '(progn
;;      (defun magit-highlight-section ())))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)))

(setq magit-diff-refine-hunk (quote all))

(setq magit-last-seen-setup-instructions "1.4.0")

(cond
 ((eq system-type 'windows-nt)
  (setq magit-git-executable (expand-file-name "~/scoop/shims/git.exe"))))
