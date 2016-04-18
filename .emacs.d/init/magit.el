;; http://www.emacswiki.org/emacs/Magit#toc5
;; (eval-after-load "magit"
;;   '(progn
;;      (defun magit-highlight-section ())))

(setq magit-diff-refine-hunk (quote all))

(setq magit-last-seen-setup-instructions "1.4.0")

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
