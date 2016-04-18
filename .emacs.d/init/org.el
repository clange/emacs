;; Org mode
(let ((my-org-default-file (expand-file-name "~/svn/kwarc.info/clange/org/default.org"))
      (my-org-contacts-file (expand-file-name "~/svn/kwarc.info/clange/org/contacts.org")))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (setq org-default-notes-file my-org-default-file)

  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)

  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)
  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-cL" 'org-insert-link-global)
  (global-set-key "\C-cO" 'org-open-at-point-global)
  ;; http://mbork.pl/2013-05-25_Clocking_in_from_anywhere_(en)
  (defun org-clock-in-anywhere (&optional select)
    "Clock in.  If called without prefix, check whether we are in an org-mode buffer first."
    (interactive "P")
    (if select
        (org-clock-in select)
      (if (equal major-mode 'org-mode) (org-clock-in) (error "Not in Org-mode"))))
  (global-set-key "\C-c\C-x\C-i" 'org-clock-in-anywhere)
  (global-set-key "\C-c\C-x\C-j" 'org-clock-goto)
  (global-set-key "\C-c\C-x\C-o" 'org-clock-out)
  (global-set-key "\C-c\C-x\C-q" 'org-clock-cancel)
  (global-set-key "\C-c\C-x\C-x" 'org-clock-in-last)

  (setq org-return-follows-link t)
  
  (require 'org-id)
  (define-obsolete-function-alias 'fancy-diary-display
    'diary-fancy-display "23.1")
  (setq org-agenda-include-diary t)
  (setq org-agenda-start-on-weekday nil)
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

  (defun org-clock-split-current-interval (end-as-default)
    "If this is a CLOCK line, split its clock time interval into two.
Let the current time interval be A--C.  By default, this function interactively prompts for a time B (suggesting A as a default), and then replaces A--C by B--C and A--B.  When called with a prefix argument, the function uses C as a default for B.  The point is left on the later interval, so that this line can, e.g., be moved to another entry."
    (interactive "P")
    (save-excursion
      ;; Part of the following code is copied from org-clock-update-time-maybe.
      ;; If this function becomes part of org-clock.el, some refactoring would be in order.
      (beginning-of-line nil)
      (skip-chars-forward " \t")
      (when (looking-at org-clock-string)
        (beginning-of-line nil)
        (let ((re (concat "\\([ \t]*" org-clock-string " *\\)"
                          "\\([[<][^]>]+[]>]\\)\\(-+\\)\\([[<][^]>]+[]>]\\)"
                          "\\(?:[ \t]*=>.*\\)?")))
          (when (looking-at re)
            (let ((indentation (match-string 1))
                  (start (match-string 2))
                  (to (match-string 3))
                  (end (match-string 4))
                  (use-start-as-default (equal end-as-default nil)))
              ;; interactively change A--C to B--C,
              ;; or (given prefix argument) to A--B, …
              (re-search-forward (concat org-clock-string " \\([[<]\\)"))
              (when (not use-start-as-default) (re-search-forward "\\([[<]\\)"))
              ;; … respecting whether A or C is an active or an inactive timestamp
              (call-interactively (if (equal (match-string 1) "<")
                                        'org-time-stamp
                                      'org-time-stamp-inactive))
              ;; If there were a function that implemented the actual body of org-clock-update-time-maybe, we could call that function, as in this context we _know_ that we are on a CLOCK line.
              (org-clock-update-time-maybe)
              ;; copy changed time B
              (re-search-backward org-ts-regexp-both)
              (let ((middle (match-string 0)))
                ;; insert A--B below, or (given prefix argument) insert B--C above
                (end-of-line (if use-start-as-default 1 0))
                (insert "\n" indentation
                        (if use-start-as-default start middle)
                        to
                        (if use-start-as-default middle end))
                (org-clock-update-time-maybe))))))))

  (define-key org-mode-map (kbd "\C-cos") 'org-clock-split-current-interval)
  
  ;; distinguish TODO keywords by color:
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "DarkOrange1" :weight bold))
          ("MAYBE" . (:foreground "sea green"))
          ("DONE" . (:foreground "light sea green"))
          ("CANCELLED" . (:foreground "forest green"))
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
          ("w" "Log work task" entry (id "00fba618-a215-4d39-a8fd-88f1ffce1fdb") "* %^{Description}  %^g%?"
           :prepend t
           :clock-in t
           :clock-keep t)
          ("t" "TODO" entry (id "00fba618-a215-4d39-a8fd-88f1ffce1fdb") "* TODO %^{Description}
  DEADLINE: %^{DEADLINE}t"
           :prepend t
           :clock-in t
           :clock-resume t)))
  (setq org-clock-history-length 20)
  (setq org-clock-idle-time 10)
  (setq org-clock-into-drawer 2)
  (setq org-clock-out-remove-zero-time-clocks t)
  (setq org-completion-use-ido t)
  (setq org-contacts-files (list my-org-contacts-file))
  (setq org-directory "~/svn/kwarc.info/clange/org")
  (setq org-enforce-todo-checkbox-dependencies t)
  (setq org-enforce-todo-dependencies t)
  (setq org-goto-auto-isearch nil)
  (setq org-id-link-to-org-use-id (quote create-if-interactive-and-no-custom-id))
  (setq org-latex-listings t)
  (setq org-latex-remove-logfiles nil)
  (setq org-log-into-drawer t)
  (setq org-log-redeadline 'note)
  (setq org-log-reschedule 'note)
  (setq org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
  (setq org-outline-path-complete-in-steps nil) ;; makes sense when using helm etc.
  (setq org-pretty-entities t)
  (setq org-refile-targets '((nil . (:level . 8))))
  (setq org-refile-use-outline-path t)
  (setq org-support-shift-select nil)
  (setq org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))
  (setq org-use-speed-commands t)
)
