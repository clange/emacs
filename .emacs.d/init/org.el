;; Org mode
(require 'dash)

(let ((my-org-default-file (expand-file-name "~/svn/kwarc.info/clange/org/default.org"))
      (my-org-contacts-file (expand-file-name "~/svn/kwarc.info/clange/org/contacts.org")))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (setq org-default-notes-file my-org-default-file)

  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)
  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-cL" 'org-insert-link-global)
  (global-set-key "\C-cO" 'org-open-at-point-global)

  (global-set-key "\C-co^" #'(lambda () (interactive) (org-back-to-heading)))

  (setq org-return-follows-link t)
  
  (require 'org-id)
  (define-obsolete-function-alias 'fancy-diary-display
    'diary-fancy-display "23.1")
  (setq org-agenda-include-diary t)
  (setq org-agenda-start-on-weekday nil)
  (add-hook 'org-agenda-finalize-hook #'(lambda () (undo-tree-mode -1)))

  (require 'org-agenda)
  ;; sort TODO's in agenda and todo view by keyword/state also (requires dash.el)
  (dolist (context '(agenda todo))
    (add-to-list 'org-agenda-sorting-strategy
                 (let ((split (--partition-by-header
                               (eq it 'priority-down)
                               (assoc context org-agenda-sorting-strategy))))
                   ;; keep the default values, but insert 'todo-state-down and 'effort-down just before 'priority-down
                   (-concat (car split) '(todo-state-down effort-down) (cadr split)))))

  ;; Org appointments (http://doc.norang.ca/org-mode.html#Reminders)
                                        ; Erase all reminders and rebuilt reminders for today from the agenda
  (defun bh/org-agenda-to-appt ()
    (interactive)
    (setq appt-time-msg-list nil)
    (org-agenda-to-appt))
                                        ; Rebuild the reminders everytime the agenda is displayed
  (add-hook 'org-finalize-agenda-hook 'bh/org-agenda-to-appt 'append)
                                        ; This is at the end of my .emacs - so appointments are set up when Emacs starts
  (bh/org-agenda-to-appt)
                                        ; Activate appointments so we get notifications
  (appt-activate t)
                                        ; If we leave Emacs running overnight - reset the appointments one minute after midnight
  (setq midnight-mode t)
  (add-hook 'midnight-hook 'bh/org-agenda-to-appt)

  (add-to-list 'org-agenda-custom-commands
        '("X" "One month from today"
           ((agenda ""))
           ((org-agenda-span 'month))
           ("~/Dropbox/Sync/agenda.html")))
  
  ;; http://www.mfasold.net/blog/2009/02/using-emacs-org-mode-to-draft-papers/
  (defun org-mode-reftex-setup ()
    (load-library "reftex")
    (and (buffer-file-name)
         (file-exists-p (buffer-file-name))
         (reftex-parse-all))
    (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
    )
  (add-hook 'org-mode-hook 'org-mode-reftex-setup)
    
  ;; distinguish TODO keywords by color:
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "DarkOrange1" :weight bold))
          ("MAYBE" . (:foreground "sea green"))
          ("DONE" . (:foreground "light sea green"))
          ("CANCELLED" . (:foreground "forest green"))
          ("NEXT" . (:foreground "red" :weight bold))
          ("TASK" . (:foreground "blue"))))
  ;; keeping track of stuck projects:
  (setq org-tags-exclude-from-inheritance '("prj")
        org-stuck-projects '("+prj/-MAYBE-DONE"
                             ("TODO" "TASK") ()))

  ;; Org Mobile
  ;; Set to the name of the file where new notes will be stored
  (setq org-mobile-inbox-for-pull "~/svn/kwarc.info/clange/org/flagged.org")
  ;; Set to <your Dropbox root directory>/MobileOrg.
  (setq org-mobile-directory "~/Dropbox/MobileOrg")

  ;; http://orgmode.org/Changes.html#orgheadline1
  (defun org-repair-property-drawers ()
    "Fix properties drawers in current buffer.
 Ignore non Org buffers."
    (when (eq major-mode 'org-mode)
      (org-with-wide-buffer
       (goto-char (point-min))
       (let ((case-fold-search t)
             (inline-re (and (featurep 'org-inlinetask)
                             (concat (org-inlinetask-outline-regexp)
                                     "END[ \t]*$"))))
         (org-map-entries
          (lambda ()
            (unless (and inline-re (org-looking-at-p inline-re))
              (save-excursion
                (let ((end (save-excursion (outline-next-heading) (point))))
                  (forward-line)
                  (when (org-looking-at-p org-planning-line-re) (forward-line))
                  (when (and (< (point) end)
                             (not (org-looking-at-p org-property-drawer-re))
                             (save-excursion
                               (and (re-search-forward org-property-drawer-re end t)
                                    (eq (org-element-type
                                         (save-match-data (org-element-at-point)))
                                        'drawer))))
                    (insert (delete-and-extract-region
                             (match-beginning 0)
                             (min (1+ (match-end 0)) end)))
                    (unless (bolp) (insert "\n"))))))))))))

  (setq org-agenda-files (list my-org-default-file my-org-contacts-file))
  (setq org-agenda-sticky t)
  (setq org-capture-templates
        `(("c" "Contacts" entry (file ,my-org-contacts-file) "* %^{Name}%^{CUSTOM_ID}p
  %?")
          ("j" "Journal" entry (id "00fba618-a215-4d39-a8fd-88f1ffce1fdb") "* %?\nEntered on %U\n   %i\n   %a"
           :prepend t)
          ("w" "Log work task" entry (id "00fba618-a215-4d39-a8fd-88f1ffce1fdb") "* %^{Description}  %^g%?"
           :prepend t
           :clock-in t
           :clock-keep t)
         ("t" "TODO" entry (id "00fba618-a215-4d39-a8fd-88f1ffce1fdb") "* TODO %^{Description}
  DEADLINE: %^{DEADLINE}t"
           :prepend t) 
          ("T" "TODO (and clock in)" entry (id "00fba618-a215-4d39-a8fd-88f1ffce1fdb") "* TODO %^{Description}
  DEADLINE: %^{DEADLINE}t"
           :prepend t
           :clock-in t
           :clock-resume t)))
  (setq org-completion-use-ido t)
  (setq org-contacts-files (list my-org-contacts-file))
  (setq org-directory "~/svn/kwarc.info/clange/org")
  (setq org-enforce-todo-checkbox-dependencies t)
  (setq org-enforce-todo-dependencies t)
  (setq org-goto-auto-isearch nil)
  (setq org-id-link-to-org-use-id (quote create-if-interactive-and-no-custom-id))
  (setq org-latex-listings t)
  (setq org-latex-remove-logfiles nil)
  (setq org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
  (setq org-outline-path-complete-in-steps nil) ;; makes sense when using helm etc.
  (setq org-pretty-entities t)
  (setq org-refile-targets '((nil . (:level . 8))))
  (setq org-refile-use-outline-path t)
  (setq org-support-shift-select nil)
  (setq org-tags-column -90)
  (setq org-use-speed-commands t)
)
