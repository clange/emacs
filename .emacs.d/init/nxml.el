(require 'nxml-mode)
(setq nxml-attribute-indent 2)
(setq nxml-child-indent 4)
(setq nxml-outline-child-indent 4)
(setq nxml-sexp-element-flag t)
(add-to-list 'rng-schema-locating-files (expand-file-name "~/.emacs.d/schemas/xslt/xslt.rnc"))
