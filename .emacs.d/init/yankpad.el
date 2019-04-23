(use-package yankpad
  :defer 10
  :config
  (setq yankpad-file "~/svn/kwarc.info/clange/org/yankpad.org")
  :init
  (bind-key "<f7>" 'yankpad-map)
  (bind-key "<f12>" 'yankpad-expand)
  :ensure t)
