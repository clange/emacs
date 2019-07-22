;; company – auto-completion
(use-package company
  :diminish "↹"
  :ensure t
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (global-set-key (kbd "M-/") 'company-complete)
    (add-to-list 'company-backends 'company-math-symbols-unicode)))

(use-package company-auctex
  :config (company-auctex-init)
  :ensure t)

;; TODO prepare better source data:
;; * idea for emails (mbox files):
;; perl -ne 'print if (/^Content-Type: text\/plain.*\nContent-Transfer-Encoding: .bit/m../^--/) and !(/^Content-|^--/)' Sent | less
;; * *.tex files:
;; es -r '\.tex$' | grep -a -E ':\\(svn|git|hg|Dropbox|owncloud)' | grep -a -F -v '\__MACOSX\' |  while read -r line; do file="$(cygpath "$(echo -E "$line" | tr -d '\r')")"; echo "$file"; detex "$line" > $(date +%s)-"$(basename "${file%.tex}")".txt ; done

(use-package company-ngram
  :ensure t
  :config
  (progn
                                        ; ~/data/ngram/*.txt are used as data
    (setq company-ngram-data-dir "~/data/ngram")
                                        ; company-ngram does not support python2
    (setq company-ngram-python "C:\\Python37\\python")
    (company-ngram-init)
    ;; (add-to-list 'company-backends 'company-ngram-backend)
                                        ; or use `M-x turn-on-company-ngram' and
                                        ; `M-x turn-off-company-ngram' on individual buffers
                                        ; save the cache of candidates
    (run-with-idle-timer 3600 t
                         (lambda ()
                           (company-ngram-command "save_cache")))
    ))

(add-hook 'after-init-hook 'company-statistics-mode)

(use-package company-web
  :ensure t)                          ; load company mode html backend
