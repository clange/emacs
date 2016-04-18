;; RefTeX
(add-hook 'LaTeX-mode-hook #'(lambda () 
                              (turn-on-reftex)
                              (add-to-list 'reftex-bibliography-commands "addbibresource")
                              (define-key LaTeX-mode-map
                                [(control c) ?f] 'reftex-fancyref-fref)
                              (define-key LaTeX-mode-map
                                [(control c) ?F] 'reftex-fancyref-Fref)))
(setq reftex-plug-into-AUCTeX t)
(setq reftex-use-external-file-finders t)
(setq reftex-external-file-finders
      '(("tex" . "kpsewhich -format=.tex %f")
        ("bib" . "kpsewhich -format=.bib %f")))

(setq reftex-default-bibliography (quote ("kwarc.bib")))

(setq reftex-use-external-file-finders t)
