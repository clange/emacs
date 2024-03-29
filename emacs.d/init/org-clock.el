;; Org clock / logging functionality
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

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

(defun org-todo-mark-done-from-log ()
  "Marks the current item done as defined by \\[org-todo].
The most recent time logged for this item is used as closing time."
  (interactive)
  (let ((ts
         (save-excursion
           (org-clock-find-position nil)
           (when (looking-at (concat "\\([ \t]*" org-clock-string " *\\)"
                                     "\\([[<][^]>]+[]>]\\)\\(-+\\)\\([[<][^]>]+[]>]\\)"
                                     "\\(?:[ \t]*=>.*\\)?"))
             (match-string 4)))))
    (org-todo 'done)
    ;; TODO handle the case of blocked state changes
    (org-add-planning-info 'closed (org-time-string-to-time ts))))

(define-key org-mode-map (kbd "\C-cod") 'org-todo-mark-done-from-log)

(defun org-clock-split-current-interval (end-as-default)
  "If this is a CLOCK line, split its clock time interval into two.
Let the current time interval be A--C.  By default, this function interactively prompts for a time B (suggesting A as a default), and then replaces A--C by B--C and A--B.  When called with a prefix argument, the function uses C as a default for B.  The point is left on the later interval, so that this line can, e.g., be moved to another entry."
  (interactive "P")
  (save-excursion
    ;; Part of the following code is copied from org-clock-update-time-maybe.
    ;; If this function becomes part of org-clock.el, some refactoring would be in order.
    (beginning-of-line)
    (skip-chars-forward " \t")
    (when (looking-at org-clock-string)
      (beginning-of-line)
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

(use-package org-clock-convenience
  :ensure t
  :init
  (progn
    ;; https://github.com/dfeich/org-clock-convenience
    (defun dfeich/org-agenda-mode-fn ()
      (define-key org-agenda-mode-map
	(kbd "<S-up>") #'org-clock-convenience-timestamp-up)
      (define-key org-agenda-mode-map
	(kbd "<S-down>") #'org-clock-convenience-timestamp-down)
      (define-key org-agenda-mode-map
	(kbd "–") #'org-clock-convenience-fill-gap))
    (add-hook 'org-agenda-mode-hook #'dfeich/org-agenda-mode-fn)

    (defun dfeich/helm-org-clock-in (marker)
      "Clock into the item at MARKER"
      (with-current-buffer (marker-buffer marker)
	(goto-char (marker-position marker))
	(org-clock-in)))
    (eval-after-load 'helm-org
      '(nconc helm-org-headings-actions
	      (list
	       (cons "Clock into task" #'dfeich/helm-org-clock-in))))))

;; when jumping to the agenda from a log message, the point ends up at
;; a CLOCK item in a LOGBOOK drawer, but the drawer gets closed, even
;; if the drawer was open before. I add a drawer opening function to
;; the respective agenda hook
(defun dfeich/org-open-if-in-drawer ()
  (let ((element (org-element-at-point)))
    (while (and element
        (not (memq (org-element-type element)
               '(drawer property-drawer))))
      (setq element (org-element-property :parent element)))
    (when element
      (let ((pos (point)))
    (goto-char (org-element-property :begin element))
    (org-flag-drawer nil)
    (goto-char pos)))))

(add-hook 'org-agenda-after-show-hook #'dfeich/org-open-if-in-drawer)

(defun org-clock-change-hh-mm (&optional use-existing new-value)
  "When on a CLOCK line, replace the two HH:MM stamps with new ones, entered as HH:MM-HH:MM,
or HH:MM- to replace only the first one, or -HH:MM to replace only the second one.
With prefix USE-EXISTING, ignore NEW-VALUE, prompt for new timestamp
using the existing timestamps as initial input.
Without a prefix argument and with a nil NEW-VALUE (i.e. the default when called interactively),
prompt for a new timestamp to be entered.
Without a prefix argument and a non-nil NEW-VALUE, the latter will be used for replacement."
  (interactive "P")
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward " \t")
    (cond
     ((and (looking-at org-clock-string)
           (re-search-forward
            (concat "\\[" org-ts-regexp1 "\\]\\(?:--\\[" org-ts-regexp1 "\\]\\)?")
            (line-end-position)
            t))
      ;; define "constants" for matched expressions
      (let ((matches-in-line (match-data))
        (from-hh-num 7)
        (from-mm-num 8)
        (to-hh-num 15)
        (to-mm-num 16))
        ;; 1. initialise arguments
        (when (equal new-value nil)
          ;; prompt for new value
          (setq new-value
                (read-string "New timestamps on same days (HH:MM-HH:MM): "
                             ;; If we didn't want to use the INITIAL-INPUT argument,
                             ;; we could have used (interactive "Mprompt") for this function.
                             (if use-existing
                                 ;; use existing as initial input for prompt
                                 (let ((from-hh (match-string from-hh-num))
                                       (from-mm (match-string from-mm-num))
                                       (to-hh (match-string to-hh-num))
                                       (to-mm (match-string to-mm-num)))
                                   (cond
                                    (from-hh
                                     (cond
                                      ;; HH:MM-HH:MM
                                      (to-hh
                                       (format "%s:%s-%s:%s"
                                               (match-string from-hh-num)
                                               (match-string from-mm-num)
                                               (match-string to-hh-num)
                                               (match-string to-mm-num)))
                                      ;; HH:MM-
                                      (t
                                       (format "%s:%s-"
                                               (match-string from-hh-num)
                                               (match-string from-mm-num)))))
                                    ;; -HH:MM
                                    (t
                                     (format "-%s:%s"
                                             (match-string to-hh-num)
                                             (match-string to-mm-num))))))
                             nil)))
        (cond
         ;; 2. check whether new value is well-formed
         ((string-match "\\(\\([0-9]\\{1,2\\}\\):\\([0-9]\\{2\\}\\)\\)?-\\(\\([0-9]\\{1,2\\}\\):\\([0-9]\\{2\\}\\)\\)?" new-value)
          (let ((from-hh (match-string 2 new-value))
                (from-mm (match-string 3 new-value))
                (to-hh (match-string 5 new-value))
                (to-mm (match-string 6 new-value)))
            ;; 3. perform replace
            (set-match-data matches-in-line)
            (when from-hh
              (replace-match (format "%02d" (string-to-number from-hh)) nil t nil from-hh-num)
              (replace-match from-mm nil t nil from-mm-num))
            (when to-hh
              (replace-match (format "%02d" (string-to-number to-hh)) nil t nil to-hh-num)
              (replace-match to-mm nil t nil to-mm-num)))
          (org-clock-update-time-maybe))
         (t (message "New timestamps not well-formed")))))
     (t (message "Not on a clock line with timestamps; therefore this function has no effect")))))

(define-key org-mode-map (kbd "\C-co:") 'org-clock-change-hh-mm)

(defun org-clock-merge-log ()
  "Merges the clock timestamps of the current item into those of the following item, then deletes the current item.  This function assumes that both items have a clock drawer."
  (interactive)
  (org-back-to-heading t)
  (catch 'exit
    (let* ((beg (line-beginning-position))
           (end (save-excursion (outline-next-heading) (point)))
           (drawer (org-clock-drawer-name)))
      (if drawer
          (progn
            (goto-char beg)
            (let ((drawer-re (concat "^[ \t]*:" (regexp-quote drawer) ":[ \t]*$")))
              (while (re-search-forward drawer-re end t)
                (let ((element (org-element-at-point)))
                  (when (eq (org-element-type element) 'drawer)
                    (let ((cend (org-element-property :contents-end element)))
                      (goto-char cend)
                      (throw 'exit t))))))
            (message drawer)
            )
        (message "No clock drawer found in this item")))))

(define-key org-mode-map (kbd "\C-com") 'org-clock-merge-log)

(require 'logbook-sorter)

(setq org-clock-history-length 35)
(setq org-clock-idle-time 10)
(setq org-clock-into-drawer t)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-log-into-drawer t)
(setq org-log-redeadline 'note)
(setq org-log-reschedule 'note)
(setq org-duration-format '((special . h:mm)))
