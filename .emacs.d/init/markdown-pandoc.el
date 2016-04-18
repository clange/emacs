;; Markdown and Pandoc
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(autoload 'pandoc-mode "pandoc-mode" "" t)
(add-to-list 'auto-mode-alist '("\\.md\\|\\.pdc\\'" . markdown-mode))
(add-hook 'markdown-mode-hook #'(lambda()
                                  (if (featurep 'pandoc) (turn-on-pandoc))))
(add-hook 'markdown-mode-hook 'turn-on-orgstruct++)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
