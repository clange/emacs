;; AUCTeX
(require 'tex-site)
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t)  ; Enable parse on save.
(setq-default TeX-master t) ; Query for master file.

(add-hook 'LaTeX-mode-hook #'(lambda ()
  (require 'texmathp)
  (LaTeX-math-mode)))

; kein fill mehr, probiere jetzt visual-line-mode aus
; (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
; (load "preview-latex.el" nil t t)

;; ;; Biber: http://lists.gnu.org/archive/html/auctex/2011-01/msg00007.html
;; ;; customize per file: TeX-command-BibTeX
;; (eval-after-load "tex"
;; ; fix AUCTeX 11.86 wrt. LuaTeX (http://comments.gmane.org/gmane.emacs.auctex.bugs/1837)
;; ; Instead of customize-variable, we _replace_ one entry in the alist.
;;   '(progn
;;      (setq TeX-command-list
;;       (append
;;        ; a singleton list containing the new entry
;;        '(("LaTeX" "%`%l --jobname=%s %(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX"))
;;        (assq-delete-all
;;         ; assq-delete-all uses eq instead of equal, so we need exactly this string object
;;         (car (assoc "LaTeX" TeX-command-list))
;;         TeX-command-list)))
;;   (add-to-list 'TeX-command-list
;;                 '("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber") t)))
;; 
;; (defun TeX-run-Biber (name command file)
;;   "Create a process for NAME using COMMAND to format FILE with Biber." 
;;   (let ((process (TeX-run-command name command file)))
;;     (setq TeX-sentinel-function 'TeX-Biber-sentinel)
;;     (if TeX-process-asynchronous
;;         process
;;       (TeX-synchronous-sentinel name file process))))
;; 
;; (defun TeX-Biber-sentinel (process name)
;;   "Cleanup TeX output buffer after running Biber."
;;   (goto-char (point-max))
;;   (cond
;;    ;; Check whether Biber reports any warnings or errors.
;;    ((re-search-backward (concat
;;                          "^(There \\(?:was\\|were\\) \\([0-9]+\\) "
;;                          "\\(warnings?\\|error messages?\\))") nil t)
;;     ;; Tell the user their number so that she sees whether the
;;     ;; situation is getting better or worse.
;;     (message (concat "Biber finished with %s %s. "
;;                      "Type `%s' to display output.")
;;              (match-string 1) (match-string 2)
;;              (substitute-command-keys
;;               "\\\\[TeX-recenter-output-buffer]")))
;;    (t
;;     (message (concat "Biber finished successfully. "
;;                      "Run LaTeX again to get citations right."))))
;;   (setq TeX-command-next TeX-command-default))

(setq LaTeX-csquotes-close-quote "”")
(setq LaTeX-csquotes-open-quote "“")

(setq LaTeX-verbatim-environments (quote ("verbatim" "verbatim*" "lstlisting")))
(setq TeX-PDF-mode t)
(setq TeX-fold-auto nil)
(setq TeX-fold-macro-spec-list (quote (("[!]" ("todo" "ednote")) ("[f]" ("tmark" "footnote" "marginpar")) ("[c]" ("cite")) ("[l]" ("label")) ("[r]" ("ref" "pageref" "eqref" "Cref" "cref" "Fref" "fref")) ("[i]" ("index" "glossary")) ("[1]:||*" ("item")) ("..." ("dots")) ("(C)" ("copyright")) ("(R)" ("textregistered")) ("TM" ("texttrademark")) (1 ("part" "chapter" "section" "subsection" "subsubsection" "paragraph" "subparagraph" "part*" "chapter*" "section*" "subsection*" "subsubsection*" "paragraph*" "subparagraph*" "emph" "textit" "textsl" "textmd" "textrm" "textsf" "texttt" "textbf" "textsc" "textup" "identifier" "attribute" "person" "underline" "ul")))))
(setq TeX-fold-type-list (quote (macro math)))
