;; OMDoc
(add-to-list 'load-path (expand-file-name "~/svn/omdoc.org/trunk/lib/emacs/nomdoc-mode"))
(require 'nomdoc-mode)
(add-to-list 'auto-mode-alist '("\\.omdoc\\'" . nomdoc-mode))
