;; Org nav
(use-package orgnav
  :ensure t)

(define-key org-mode-map (kbd "\C-coc") 'orgnav-search-subtree)
(define-key org-mode-map (kbd "\C-con") 'orgnav-search-nearby)
