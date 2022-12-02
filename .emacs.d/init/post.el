;; E-Mails
;; mail_.*\\.txt is for https://github.com/taiyaki32lp64/external_editor_for_outlook365
(setq post-mail-message "\\(mail_.*\\.txt\\|mutt-[a-z0-9]+-[0-9]+-[0-9]+.*\\|vimperator-exchange\\(-xfer1\\)?\\.iais\\.fraunhofer\\.de\\(-[0-9]+\\)?\\.tmp\\|tmp_exchange\\(-xfer1\\)?\\.iais\\.fraunhofer\\.de_[_[:alnum:]]+\\|kmail.*\\.tmp\\|\\.eml\\|mutt-ator-mail\\(-[0-9]+\\)?\\)\\'")

(use-package orgalist
  :ensure t)

(require 'post)

(define-key post-mode-map "\C-c." (lambda ()
                                    (interactive)
                                    (insert "> [...]
")))

; expand the word before cursor into both female and male forms, if it is a German male word
(defun both-german-genders ()
  (interactive)
  (let ((saved-point (point)))
    (backward-word)
    (cond
     ((looking-at "\\([[:upper:]][[:alpha:]]*\\)\\(en\\|er\\|ern\\)\\>")
      (let* ((word (match-string 0))
             (prefix (match-string 1))
             (suffix (match-string 2)))
        (kill-word 1)
        (insert prefix)
        (cond
         ((equal suffix "en") (insert "innen"))
         (t (insert "erinnen")))
        (insert " und ")
        (insert word)))
     (t (goto-char saved-point)))))

(define-key post-mode-map "\C-c*" 'both-german-genders)

; full-quote the email; reply inline
(defun full-quote-reply-inline ()
  (interactive)
  ;; Thunderbird
  (when (search-forward-regexp "^From: " nil t)
    (let ((end (point)))
      (forward-line -2)
      (delete-region (point) end))
    ; cursor is on the beginning of the sender's name/address
    (join-line t)
    (let ((begin (point)))
      (when (search-forward "Sent: ")
        (delete-region begin (point))))
    ; cursor is on the beginning of the date
    (insert " on ")
    (move-end-of-line nil)
    (insert ":")
    (forward-line)
    ; cursor is on the beginning of the next header field
    (let ((begin (point)))
      (when (search-forward-regexp "^[[:space:] ]*$")
        (forward-line)
        (delete-region begin (point))))
    ; cursor is on the beginning of the email body
    ; we assume we are in post-mode, where commenting means quoting
    (comment-region (point) (point-max))
    (forward-line -1)
    (kill-region (point) (point-max))
    (goto-char (point-min))
    ; insert quoted body at the beginning of the buffer
    (yank '(4)) ; yank below cursor
    ;; TODO (open-line 2) doesn't work
    )
  ;; Outlook
  (when (search-forward-regexp "^> -----Original Message-----$" nil t)
    (let ((end (point)))
      (forward-line -1)
      (delete-region (point) end))
    (forward-line)
    ;; cursor is on the beginning of the header
    (let ((begin (point)))
      (when (search-forward-regexp "^> $" nil t)
        ;; we assume we are in post-mode, where commenting means quoting
        (uncomment-region begin (point)))
      (goto-char begin))
    (forward-line)
    ;; We should be after the From: header; put it into a single line
    (while (not (looking-at "^Sent: "))
      (forward-line -1)
      (join-line t)
      (delete-char 1)
      (forward-line))
    (forward-line -1)
    ;; delete "From: "
    (beginning-of-line nil)
    (let ((begin (point)))
      (when (search-forward-regexp "^From: " nil t)
        (delete-region begin (point))))
    ;; Cursor is on the beginning of the sender's name/address
    (join-line t)
    (let ((begin (point)))
      (when (search-forward "Sent: " nil t)
        (delete-region begin (point))))
    ;; Cursor is on the beginning of the date
    (insert " on ")
    (move-end-of-line nil)
    (insert ":")
    (forward-line)
    ;; Cursor is on the beginning of the next header field – delete rest of header
    (let ((begin (point)))
      (when (search-forward-regexp "^[[:space:] ]*$")
        (forward-line)
        (delete-region begin (point))))
    (forward-line -1)
    ;; FIXME get this done without the kill-ring, i.e. without messing with the system clipboard
    (let ((quoted-text (buffer-substring (point) (point-max))))
      (delete-region (point) (point-max))
      (goto-char (point-min))
      ; insert quoted body at the beginning of the buffer
      (insert quoted-text))
    (open-line 2)
    ;; note: if you would like to edit the message in Evil insert mode, do
    ;; (add-to-list 'evil-insert-state-modes 'post-mode)
    ;; in your Evil customization
    ))
 
(add-hook 'post-mode-hook
          #'(lambda()
            (orgalist-mode)
            (turn-on-orgtbl)
            (make-local-variable 'sentence-end-double-space)
            (setq sentence-end-double-space nil)
            (setq comment-empty-lines t)
            ;; we assume that Thunderbird/Muttator uses format=flowed
            (unless (string-match-p
                     "\\(\.eml\\|mutt-ator-mail\\(-[0-9]+\\)?\\)\\'"
                     (buffer-file-name))
              (unless (string-match-p "mail_.*\\.txt" (buffer-file-name))
                (save-excursion
                  (let ((threshold 80)
                        ;; -1: all lines empty
                        ;;  0: all lines less than threshold
                        ;;  1: long lines
                        (result 0))
                    ;; for debugging: (goto-char (point-max)) 
                    (post-goto-signature) 
                    (forward-line -1)
                    (if (bobp) ; i.e. the mail is empty
                        (setq result -1))
                    (while (and (not (bobp)) (= result 0))
                      (let ((line-length (- (line-end-position) (line-beginning-position))))
                        (cond ((> line-length threshold)
                               (setq result 1))
                              ((bobp)
                               nil)
                              (t
                               (forward-line -1)))))
                    (if (= result 0)
                        (progn
                          (setq fill-column 72)
                          (auto-fill-mode 1))
                                        ; we override post-uses-fill-mode
                      (auto-fill-mode -1)
                      (setq fill-column (max-char))))))
              (full-quote-reply-inline))))

(setq post-signature-pattern "\\(--\\|\\(Cheers\\|Viele Grüße\\),\\|\\)")
(setq post-uses-fill-mode nil)

(cond
 ((eq system-type 'windows-nt)
  ;; Convert to Unix line breaks before saving and exiting
  (defadvice post-save-current-buffer-and-exit (before post-save-unix-line-breaks activate) 
    (set-buffer-file-coding-system 'unix))))
