;;;;;;;;;;;;;;;;;;;;
;; set up unicode
(cond
 ((eq system-type 'windows-nt)
  (setq visible-bell 1)
  (set-message-beep 'silent)))
