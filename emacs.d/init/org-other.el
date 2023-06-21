;; Babel (some stuff from http://doc.norang.ca/org-mode.html#playingwithditaa)
; (setq org-ditaa-jar-path "~/tools/DitaaEps/DitaaEps.jar")
; (setq org-ditaa-jar-path "~/git/orgmode.org/org-mode/contrib/scripts/ditaa.jar")
(setq org-plantuml-jar-path "~/java/plantuml.jar")
(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)
(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ditaa . t)
   (plantuml . t)))
(setq org-confirm-babel-evaluate nil)
(add-to-list 'org-src-lang-modes '("plantuml" . fundamental))
