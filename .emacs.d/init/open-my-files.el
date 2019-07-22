(save-excursion
  (let ((large-file-warning-threshold nil))
    (find-file-existing (expand-file-name "~/git/lange-bever.de/clange/org/default.org"))))
(setq initial-buffer-choice (expand-file-name "~/git/lange-bever.de/clange/org/default.org"))
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
