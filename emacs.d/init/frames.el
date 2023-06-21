;; Windows
(setq frame-title-format
      '((:eval (concat "Emacs – "
                       (if (buffer-file-name)
                           (abbreviate-file-name (buffer-file-name))
                         "%b")))))

(setq initial-frame-alist '((width . 90)))

(setq redisplay-dont-pause t)

