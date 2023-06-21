;; Org Index

(require 'org-index)
(define-prefix-command 'org-index-map)
(global-set-key (kbd "C-c i") 'org-index-map)
(define-key org-index-map (kbd "o") (lambda () (interactive) (org-index 'occur)))
(define-key org-index-map (kbd "r") (lambda () (interactive) (org-index 'ref)))
(define-key org-index-map (kbd "l") (lambda () (interactive) (org-index 'leave)))
(define-key org-index-map (kbd "h") (lambda () (interactive) (org-index 'head)))
(define-key org-index-map (kbd "i") (lambda () (interactive) (org-index)))
(setq org-index-id "2c6e4848-34b9-498a-9870-dbf710b65993")

