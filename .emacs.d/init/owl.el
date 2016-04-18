;; OWL
(autoload 'omn-mode "omn-mode.el" "Major mode for editing OWL files in Manchester syntax" t)
(add-to-list 'auto-mode-alist '("\\.omn$" . omn-mode))

(add-hook 'omn-mode-hook #'(lambda ()
			    (define-key omn-mode-map (kbd "\C-cP") 'rdf-prefix-insert)))
