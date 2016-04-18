;; System-specific configuration
(cond
 ((eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (defun raise-emacs-on-aqua()
    (shell-command
     "osascript -e 'tell application \"Emacs\" to activate'"))
  (add-hook 'server-switch-hook 'raise-emacs-on-aqua)
  (add-hook 'LaTeX-mode-hook #'(lambda ()
			     (add-to-list 'TeX-output-view-style
					  '("^pdf$" "." "/Applications/PDFView.app/Contents/MacOS/gotoline.sh %n %(OutFullPath)"))
			     (add-to-list 'TeX-expand-list
			     '("%(OutFullPath)" (lambda nil
						  (expand-file-name
						   (funcall file (TeX-output-extension) t)
						   (TeX-master-directory))))))))
 ((eq system-type 'gnu/linux)
  (add-hook 'LaTeX-mode-hook #'(lambda ()
                               (add-to-list 'TeX-expand-list
                                            '("%u" Okular-make-url))))))
(defun url-hexify-spaces (string)
  (replace-regexp-in-string " " "%20" string))

(defun Okular-make-url ()
  (concat
   "file://"
   (url-hexify-spaces (expand-file-name
                       (funcall file (TeX-output-extension) t)
                       (file-name-directory (TeX-master-file))))
   "#src:"
   (TeX-current-line)
   (url-hexify-spaces (expand-file-name (TeX-master-directory)))
   "./"
   (url-hexify-spaces (TeX-current-file-name-master-relative))))
