(use-package google-this
  :diminish "G"
  :ensure t
  :init
  (setq google-this-keybind (kbd "C-x /"))
  :config
  (google-this-mode 1))
