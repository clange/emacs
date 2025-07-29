;; Org mode
(use-package dash
  :ensure t)

;; (use-package org
;;   :ensure org-plus-contrib)

(setq my-org-directory (file-name-as-directory (expand-file-name "~/git/lange-bever.de/clange/org")))
(setq my-org-default-file (expand-file-name "default.org" my-org-directory))
(setq my-org-default-old-file (expand-file-name "default-old.org" my-org-directory))
(setq my-org-contacts-file (expand-file-name "contacts.org" my-org-directory))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(setq org-default-notes-file my-org-default-file)

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cL" 'org-insert-link-global)
(global-set-key "\C-cO" 'org-open-at-point-global)

(define-key org-mode-map (kbd "C-c SPC") #'org-table-blank-field)

(global-set-key "\C-co^" #'(lambda () (interactive) (org-back-to-heading)))

(setq org-return-follows-link t)

(require 'org-id)
(define-obsolete-function-alias 'fancy-diary-display
  'diary-fancy-display "23.1")
(setq org-agenda-include-diary t)
(setq org-agenda-diary-file my-org-default-file)
(setq org-agenda-span 8)
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

;; force taking a note on state change even if this state is not set up for taking notes
;; (http://emacs.stackexchange.com/a/97)
(defun org-todo-force-notes ()
  (interactive)
  (let ((org-todo-log-states
         (mapcar (lambda (state)
                   (list state 'note 'time))
                 (apply 'append org-todo-sets))))
    (call-interactively 'org-todo)))

(define-key org-mode-map (kbd "C-c M-t") 'org-todo-force-notes)

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

(eval-after-load "calendar"
  '(progn
     (org-defkey calendar-mode-map [?C]
                 #'(lambda ()
                     (interactive)
                     (let ((org-agenda-span 'day))
                       (org-calendar-goto-agenda))))))

(add-to-list 'org-agenda-custom-commands
      '("X" "One month from today"
         ((agenda ""))
         ((org-agenda-span 'month))
         ("~/owncloud/uni-bonn.sciebo.de/sync/agenda.html")))

(defun org-recurring-skip-instance ()
  "Skip a recurring event once.
If the agenda item at point was created by an `org-class' entry,
change that entry to add a SKIP-WEEK argument for the week selected in the agenda.
If a diary expression was used, exclude the day selected in the agenda."
  (interactive)
  ;; code taken from org-agenda-switch-to in org-agenda.el
  (if (and org-return-follows-link
	   (not (org-get-at-bol 'org-marker))
	   (org-in-regexp org-link-bracket-re))
      (org-link-open-from-string (match-string 0))
    (let* ((marker (or (org-get-at-bol 'org-marker)
		       (org-agenda-error)))
	   (buffer (marker-buffer marker))
	   (pos (marker-position marker))
           ;; code taken from org-agenda-goto-calendar in org-agenda.el
           (day (or (get-text-property (min (1- (point-max)) (point)) 'day)
		     (user-error "Don't know which date to open in calendar"))))
      (unless buffer (user-error "Trying to switch to non-existent buffer"))
      (with-current-buffer buffer
        (widen)
        (goto-char pos)
        ;; actual functionality of this function starts here:
        (save-restriction
          (back-to-indentation)
          ;; the .* before org-class allows for combining `org-class' with, e.g., `and'
          (cond ((re-search-forward "<%%.*(org-class \\(?:[0-9]\\{4\\} [0-9]\\{2\\} [0-9]\\{2\\} \\)\\{2\\}[0-6]\\(?: \\(?:[0-9]\\{1,2\\}\\|'holidays\\|\"[^\"]*\"\\)\\)*)" (line-end-position) t)
                 (backward-char)
                 (insert ? )
                 (insert (number-to-string (org-days-to-iso-week day))))
                ((or (re-search-forward "<%%.*\\((and \\)(diary-.*)\\( (not (or (diary-date .*))))\\)>" (line-end-position) t)
                     (re-search-forward "<%%.*\\((and \\)(diary-.*))>" (line-end-position) t)
                     (re-search-forward "<%%.*(diary-.*)>" (line-end-position) t))
                 (let* ((gregorian-day (calendar-gregorian-from-absolute day))
                        (diary-date-string (apply 'format "(diary-date %d %02d %02d)"
                                                  (list (calendar-extract-year gregorian-day) (calendar-extract-month gregorian-day) (calendar-extract-day gregorian-day)))))
                   ;; insert today's date at cursor position designated by <>
                   (cond ((match-string 2) ;; (and (diary-.*) (not (or (diary-date .*) <>)))
                          (goto-char (- (match-end 2) 3))
                          (insert " " diary-date-string))
                         ((match-string 1) ;; (and (diary-.*)
                          (goto-char (- (match-end 0) 2))
                          (insert " (not (or " diary-date-string "))"))
                         (t
                          (goto-char (+ (match-beginning 0) 3))
                          (insert "(and ")
                          (goto-char (- (+ (match-end 0) 5) 1))
                          (insert " (not (or " diary-date-string ")))")))))
                 (t (user-error "No valid org-class entry found"))))))))

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

;; Disable org-global-cycle in large buffers, as it takes forever
(defun org-global-cycle-if-small-file (&rest arguments)
  "Only execute org-global-cycle if the buffer is smaller than 1 MiB."
  ;; small buffer: return t
  ;; large buffer: return nil; print message
  (not (and (>= (buffer-size) 1048576) (message "Buffer is too large for cycling global visibility"))))

(advice-add 'org-global-cycle :before-while 'org-global-cycle-if-small-file)
;; (advice-remove 'org-global-cycle 'org-global-cycle-if-small-file)

;; http://orgmode.org/Changes.html#orgheadline1
(defun org-repair-property-drawers ()
  "Fix properties drawers in current buffer.
gnore non Org buffers."
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

(use-package org-contrib
  :ensure t
  :config
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

(setq org-agenda-files (list my-org-default-file my-org-contacts-file))
(setq org-agenda-sticky t)
(setq org-capture-templates
      `(("c" "Contacts" entry (file ,my-org-contacts-file) "* %^{Name}%^{CUSTOM_ID}p
%?")
        ("j" "Journal" entry (id "eecedf40-4ab3-449a-ae5f-91f416dd85f0") "* %?\nEntered on %U\n   %i\n   %a"
         :prepend t)
        ("w" "Log work task" entry (id "eecedf40-4ab3-449a-ae5f-91f416dd85f0") "* %^{Description}  %^g%?"
         :prepend t
         :clock-in t
         :clock-keep t)
       ("t" "TODO" entry (id "eecedf40-4ab3-449a-ae5f-91f416dd85f0") "* TODO %^{Description}
DEADLINE: %^{DEADLINE}t"
         :prepend t) 
        ("T" "TODO (and clock in)" entry (id "eecedf40-4ab3-449a-ae5f-91f416dd85f0") "* TODO %^{Description}
DEADLINE: %^{DEADLINE}t"
         :prepend t
         :clock-in t
         :clock-resume t)))
(setq org-completion-use-ido t)
(setq org-contacts-files (list my-org-contacts-file))
(setq org-directory my-org-directory)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-enforce-todo-dependencies t)
(setq org-goto-auto-isearch nil)
(setq org-adapt-indentation t)
(setq org-id-extra-files '(my-org-default-old-file))
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
(setq org-time-stamp-custom-formats '("<%a %d %b %Y>" . "<%a %d %b %Y %H:%M>"))
(setq org-use-speed-commands t)
