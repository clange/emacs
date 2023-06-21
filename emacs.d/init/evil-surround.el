;; surround:
(use-package evil-surround
  :ensure t)
(global-evil-surround-mode 1)
(setq-default evil-surround-pairs-alist (append '((?“ . ("“" . "”"))) '((?” . ("“" . "”"))) evil-surround-pairs-alist))
