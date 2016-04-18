;; Org Secretary
(require 'org-secretary)
;; defining a tag that marks TASK entries as mine
(setq org-sec-me "mine")
;; special agenda views
(add-to-list 'org-agenda-custom-commands
             '("h" "Work todos" tags-todo
               "-personal-doat={.+}-dowith={.+}/!-TASK"
               ((org-agenda-todo-ignore-scheduled t))))
(add-to-list 'org-agenda-custom-commands
             '("H" "All work todos" tags-todo "-personal/!-TASK-MAYBE"
               ((org-agenda-todo-ignore-scheduled nil))))
(add-to-list 'org-agenda-custom-commands
             '("A" "Work todos with doat or dowith" tags-todo
               "-personal+doat={.+}|dowith={.+}/!-TASK"
               ((org-agenda-todo-ignore-scheduled nil))))
(add-to-list 'org-agenda-custom-commands
             '("j" "TODO dowith and TASK with"
               ((org-sec-with-view "TODO dowith")
                (org-sec-where-view "TODO doat")
                (org-sec-assigned-with-view "TASK with")
                (org-sec-stuck-with-view "STUCK with"))))
(add-to-list 'org-agenda-custom-commands
             '("J" "Interactive TODO dowith and TASK with"
               ((org-sec-who-view "TODO dowith"))))
;; redefine a key which interferes with my own mappings:
(global-set-key "\C-cJ" 'org-sec-tag-entry)
