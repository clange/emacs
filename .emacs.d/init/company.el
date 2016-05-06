;; company – auto-completion
(require 'company)

(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "M-/") 'company-complete)

(add-to-list 'company-backends 'company-math-symbols-unicode)

(require 'company-auctex)
(company-auctex-init)

;; TODO prepare better source data:
;; * idea for emails (mbox files):
;; perl -ne 'print if (/^Content-Type: text\/plain.*\nContent-Transfer-Encoding: .bit/m../^--/) and !(/^Content-|^--/)' Sent | less
;; * *.tex files:
;; es -r '\.tex$' | grep -a -E ':\\(svn|git|hg|Dropbox|owncloud)' | grep -a -F -v '\__MACOSX\' |  while read -r line; do file="$(cygpath "$(echo -E "$line" | tr -d '\r')")"; echo "$file"; detex "$line" > $(date +%s)-"$(basename "${file%.tex}")".txt ; done

(with-eval-after-load 'company-ngram
  ; ~/data/ngram/*.txt are used as data
  (setq company-ngram-data-dir "~/data/ngram")
  ; company-ngram does not support python2
  (setq company-ngram-python "C:\\bin\\cygwin\\bin\\python3.4m")
  (company-ngram-init)
  ;; (add-to-list 'company-backends 'company-ngram-backend)
  ; or use `M-x turn-on-company-ngram' and
  ; `M-x turn-off-company-ngram' on individual buffers
  )
(require 'company-ngram nil t)

(add-hook 'after-init-hook 'company-statistics-mode)

(require 'company-web-html)                          ; load company mode html backend

(diminish 'company-mode "↹")
