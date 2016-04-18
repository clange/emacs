;; sTeX
(add-to-list 'load-path (expand-file-name "~/svn/kwarc.info/stex/emacs"))
(autoload 'stex-mode "stex-mode" "Major mode for editing sTeX documents" t)
(defun sTeX-load-snippet (point mark)
  (interactive "r")
  (let ((string (buffer-substring point mark)))
    (find-file (concat "/home/clange/svn/kwarc.info/stc/slides/" string ".tex"))))
(add-hook 'sTeX-mode-hook #'(lambda ()
 			     (define-key stex-mode-map [(control c) (control a) ?l] 'sTeX-load-snippet) 
))

(setq sTeX-modules-paths (quote ("~/svn/kwarc.info/stc/slides")))
