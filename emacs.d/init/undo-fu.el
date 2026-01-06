(use-package undo-fu
  :ensure t)

(setq undo-limit 67108864) ; 64mb.
(setq undo-strong-limit 100663296) ; 96mb.
(setq undo-outer-limit 1006632960) ; 960mb.

(use-package undo-fu-session
  :ensure t)
(undo-fu-session-global-mode)
