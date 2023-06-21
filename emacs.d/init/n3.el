;; n3
(autoload 'n3-mode "n3-mode" "Major mode for N3 or Turtle files" t)
; Turn on font lock when in n3 mode
(add-hook 'n3-mode-hook 'turn-on-font-lock)
(add-to-list 'auto-mode-alist '("\\.n3\\|\\.ttl\\|\\.turtle\\'" . n3-mode))

;; rdf-prefix
(require 'rdf-prefix)
(add-hook 'n3-mode-hook #'(lambda ()
			    (define-key n3-mode-map (kbd "\C-cP") 'rdf-prefix-insert)))
