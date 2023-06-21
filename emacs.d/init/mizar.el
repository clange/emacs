;; Mizar
(add-to-list 'load-path (expand-file-name "~/tools/mizar-8.1/share") t)
(require 'mizar)
(add-to-list 'auto-mode-alist '("\\.miz\\'" . mizar-mode))
