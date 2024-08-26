(add-to-list 'auto-mode-alist '("\\.n3\\|\\.ttl\\|\\.turtle\\'" . ttl-mode))

;; rdf-prefix
(require 'rdf-prefix)
(add-hook 'n3-mode-hook #'(lambda ()
			    (define-key n3-mode-map (kbd "\C-cP") 'rdf-prefix-insert)))
