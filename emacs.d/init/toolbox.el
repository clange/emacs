;; Toolbox
(require 'toolbox)
(add-to-list 'auto-mode-alist '("\\.tx\\'" . toolbox-mode))
(add-hook 'toolbox-mode-hook
          #'(lambda()
            (turn-on-font-lock)
            (turn-on-orgstruct)
            (setq abbrev-mode t)))
