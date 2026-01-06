;; org-ref
(use-package bibtex)

(use-package org-ref
  :ensure t
  :after (org bibtex)
  :custom
  (bibtex-completion-bibliography '("~/git/lange-bever.de/clange/org/bib/references.bib"))
  (bibtex-completion-library-path '("~/owncloud/fraunhofer.de/org/bib/library/"))
  (bibtex-completion-notes-path '("~/git/lange-bever.de/clange/org/bib/notes/"))
  (bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n")
  (bibtex-completion-additional-search-fields '(keywords))
  (bibtex-completion-display-formats
   '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
     (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
     (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
     (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
     (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}")))
  (bibtex-autokey-year-length 4)
  (bibtex-autokey-name-year-separator "-")
  (bibtex-autokey-year-title-separator "-")
  (bibtex-autokey-titleword-separator "-")
  (bibtex-autokey-titlewords 2)
  (bibtex-autokey-titlewords-stretch 1)
  (bibtex-autokey-titleword-length 5)
  ;; (define-key bibtex-mode-map (kbd "H-b") 'org-ref-bibtex-hydra/body)
  (bibtex-completion-pdf-open-function
   (lambda (fpath)
     (call-process "cygstart" nil 0 nil fpath)))
  :bind ((:map org-mode-map
               (("C-c ]" . org-ref-insert-link)))))
