;; company – auto-completion
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "M-/") 'company-complete)
(diminish 'company-mode "↹")
