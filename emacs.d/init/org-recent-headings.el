;; Org recent headings
(use-package org-recent-headings
  :ensure t)
(org-recent-headings-mode)
(global-set-key "\C-cor" 'org-recent-headings-helm)
