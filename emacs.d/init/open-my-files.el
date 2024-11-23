(save-excursion
  (let ((large-file-warning-threshold nil))
    (find-file-existing my-org-default-old-file)
    (find-file-existing my-org-default-file)))
(setq initial-buffer-choice 'my-org-default-file)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
