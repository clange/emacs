(global-set-key "\C-con" 'org-contacts)
;; Org contacts
(require 'org-contacts)

(unless (string-prefix-p "x86_64" system-configuration)
; disable anniversaries on non-64-bit systems (as they don't handle dates before 1970)
  (defun disable-org-contacts-anniversaries-on-32-bit (orig-fun &rest args)
    "No anniversaries on 32-bit systems")
  (advice-add 'org-contacts-anniversaries :override #'disable-org-contacts-anniversaries-on-32-bit))
