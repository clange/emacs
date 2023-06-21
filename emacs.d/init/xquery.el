;; XQuery
(require 'xquery-mode)
(add-hook 'xquery-mode-hook 'turn-on-font-lock)
(add-to-list 'auto-mode-alist '("\\.xq\\'" . xquery-mode))
