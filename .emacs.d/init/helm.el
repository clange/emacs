(use-package helm-config
  :ensure helm)
(require 'helm-command)
;; (require 'helm-descbinds)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-quick-update                     t ; do not display invisible candidates
      helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-ff-skip-boring-files             t)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-c r") 'helm-mini)

(with-eval-after-load "org"
  (use-package helm-org)
  (use-package helm-org-rifle
    :ensure t)
  (global-set-key (kbd "C-c o h") 'helm-org-agenda-files-headings)
  (define-key org-mode-map (kbd "\C-cof") 'helm-org-rifle-current-buffer))

(autoload 'helm-bibtex "helm-bibtex" "" t)
(setq bibtex-completion-bibliography '(
                                       "~/git/github.com/EIS-Bonn/Papers/bib/all.bib"
                                       "~/git/github.com/EIS-Bonn/Papers/bib/eis.bib"
                                       "~/svn/codex.cs.bham.ac.uk/mmk/formare/lib/bibtex/formare.bib"
                                       "~/svn/kwarc.info/kwarc/doc/bibs/kwarc.bib"
                                       ))
(global-set-key (kbd "C-c h [") 'helm-bibtex)

(diminish 'helm-mode "H")

(helm-mode 1)
