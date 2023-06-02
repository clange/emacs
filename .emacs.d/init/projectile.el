(use-package projectile
  :ensure t)
(projectile-global-mode)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-indexing-method 'alien)
(use-package helm-projectile
  :ensure t)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)
(diminish 'projectile-mode "P")
(use-package ag
  :ensure t)
