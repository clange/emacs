;; Hets
(load-file (expand-file-name "~/git/github.com/spechub/Hets/utils/el/casl.el"))
(load-file (expand-file-name "~/git/github.com/spechub/Hets/utils/el/hpf.el"))
; for now we associate DOL with CASL
(add-to-list 'auto-mode-alist '("\\.dol\\'" . casl-mode))

(setq casl-indent-offset 4)
