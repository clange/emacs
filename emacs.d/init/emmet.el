(use-package emmet-mode
  :ensure t)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'nxml-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(diminish 'emmet-mode ">")
