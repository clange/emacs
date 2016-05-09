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

(use-package org-clock-convenience
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

(setq org-clock-history-length 35)
(setq org-clock-idle-time 10)
(setq org-clock-into-drawer 2)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-log-into-drawer t)
(setq org-log-redeadline 'note)
(setq org-log-reschedule 'note)
(setq org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))
