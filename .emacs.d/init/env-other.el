;; Environment
(setenv "PATH" (concat (expand-file-name "~/bin") ":" (getenv "PATH")))
(setenv "DISPLAY" ":0.0")
;; no longer using mapconcat because of irregular location of default path
(setenv "TEXINPUTS" (concat ".//:"
			    (expand-file-name "~/git/github.com/clange/latex/") "/:"
			    (expand-file-name "~/svn/kwarc.info/stex/trunk/sty/") "/:"
			    (expand-file-name "~/svn/kwarc.info/stc/sty/") "/:"
			    ;; (expand-file-name "~/svn/kwarc.info/kwarc/doc/macros/fromCTAN/biblatex/") "/:"
                            ":"
			    (expand-file-name "~/svn/kwarc.info/kwarc/doc/macros/") "/:"
			    (expand-file-name "~/svn/codex.cs.bham.ac.uk/mmk/KLR/lib/tex/") "/:"
			    (expand-file-name "~/svn/omdoc.org/trunk/doc/macros/") "/"))
(setenv "BIBINPUTS" (concat ".//:"
                            (expand-file-name "~/svn/kwarc.info/kwarc/doc/bibs/") ":"
                            (expand-file-name "~/svn/codex.cs.bham.ac.uk/mmk/formare/lib/bibtex/") ":"
                             ":"))
(setenv "BSTINPUTS" (concat ".//:"
                            ;; (expand-file-name "~/svn/kwarc.info/kwarc/doc/macros/fromCTAN/biblatex/bibtex/bst/") "/:"
                            ":"
                            (expand-file-name "~/svn/kwarc.info/kwarc/doc/macros/ext/") "/"))
