(use-package projectile
  :ensure t)
(projectile-global-mode)
(setq projectile-indexing-method 'alien)
(use-package helm-projectile
  :ensure t)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)
(diminish 'projectile-mode "P")
