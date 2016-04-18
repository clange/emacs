; Disable built-in org-mode
(delete-if #'(lambda (elem) (string-match-p "/usr/share/emacs/[^/]*/lisp/org" elem)) load-path)
