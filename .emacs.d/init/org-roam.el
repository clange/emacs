;; org-roam
(use-package org-roam
  :ensure t
  :after org
  :init (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/git/lange-bever.de/clange/org/roam"))
  (org-roam-database-connector 'libsqlite3)
  :config
  (org-roam-db-autosync-mode)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n r" . org-roam-node-random)
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)
                ("C-c n o" . org-id-get-create)
                ("C-c n t" . org-roam-tag-add)
                ("C-c n a" . org-roam-alias-add)
                ("C-c n l" . org-roam-buffer-toggle)))))
