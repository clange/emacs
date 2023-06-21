;; BibTeX
(require 'bibtex)

(defun bibtex-copy-key-as-kill ()
  (interactive)
  (save-excursion
    (bibtex-beginning-of-entry)
    ;; TODO continue: get key (between { and ,)
    ))

(defun current-time-YYYY-MM-DD ()
  (format-time-string "%Y-%m-%d" (current-time)))

(defun bibtex-insert-current-urldate ()
  (interactive)
  (bibtex-make-field
  '("urldate" "" current-time-YYYY-MM-DD)
  t))
(add-hook 'bibtex-mode-hook #'(lambda ()
			       (define-key
				 bibtex-mode-map [(control c) ?u]
				 'bibtex-insert-current-urldate)))

;; (let (bibtex-entry-field-alist-additions)
;;   (unless (assoc-string "Online" bibtex-entry-field-alist)
;;     (add-to-list 'bibtex-entry-field-alist-additions "Online")
;;     (add-to-list 'bibtex-entry-field-alist
;;                  `("Online" ((,(assoc-string "author"
;;                                             (car (cadr (assoc-string "Book" bibtex-entry-field-alist))))
;;                               ,(assoc-string "editor"
;;                                             (car (cadr (assoc-string "Book" bibtex-entry-field-alist))))
;;                               ("title" "Title of the online resource")
;;                               ("url" "URL of the online resource"))
;;                              (("urldate" "Date when this URL was last visited"
;;                                current-time-YYYY-MM-DD)))))
;;     (defun bibtex-Online ()
;;       "Insert a new BibTeX @Online entry; see also `bibtex-entry'."
;;       (interactive "*")
;;       (bibtex-entry "Online"))
;;     (add-hook 'bibtex-mode-hook #'(lambda ()
;;                                    (define-key
;;                                      bibtex-mode-map [(control c) (control e) (control o)]
;;                                      'bibtex-Online))))
;;   (unless (assoc-string "WebPage" bibtex-entry-field-alist)
;;     (add-to-list 'bibtex-entry-field-alist-additions "Online")
;;     (add-to-list 'bibtex-entry-field-alist
;;                  `("WebPage" ((,(assoc-string "author"
;;                                             (car (cadr (assoc-string "Book" bibtex-entry-field-alist))))
;;                                ,(assoc-string "editor"
;;                                             (car (cadr (assoc-string "Book" bibtex-entry-field-alist))))
;;                                ("title" "Title of the web page")
;;                                ("url" "URL of the web page"))
;;                               (("lastchecked" "Date when this URL was last visited")))))
;;     (defun bibtex-WebPage ()
;;       "Insert a new BibTeX @WebPage entry; see also `bibtex-entry'."
;;       (interactive "*")
;;       (bibtex-entry "WebPage"))
;;     (add-hook 'bibtex-mode-hook #'(lambda ()
;;                                    (define-key
;;                                      bibtex-mode-map [(control c) (control e) (control w)]
;;                                      'bibtex-WebPage))))
;;   (when bibtex-entry-field-alist-additions
;;     ;; Enforce update of some bibtex variables.  This is a hack, as bibtex.el is only extensible
;;     ;; via "custom"
;;     (setq bibtex-entry-type (concat "@[ \t]*\\(?:"
;;                                     (regexp-opt (mapcar 'car bibtex-entry-field-alist)) "\\)"))
;;     (setq bibtex-entry-head (concat "^[ \t]*\\("
;;                                     bibtex-entry-type
;;                                     "\\)[ \t]*[({][ \t\n]*\\("
;;                                     bibtex-reference-key
;;                                     "\\)"))
;;     (setq bibtex-entry-maybe-empty-head (concat bibtex-entry-head "?"))
;;     (setq bibtex-any-valid-entry-type (concat "^[ \t]*@[ \t]*\\(?:"
;;           (regexp-opt (append '("String" "Preamble")
;;                               (mapcar 'car bibtex-entry-field-alist))) "\\)"))))

(setq bibtex-autoadd-commas t)
(setq bibtex-comma-after-last-field t)
(setq bibtex-dialect (quote biblatex))
(setq bibtex-entry-format (quote (opts-or-alts required-fields numerical-fields last-comma)))
