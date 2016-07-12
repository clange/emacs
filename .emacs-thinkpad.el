(load-file (expand-file-name "~/.emacs.d/init/cl.el"))

;; Packages and paths
(load-file (expand-file-name "~/.emacs.d/init/gentoo.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-local.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-disable-builtin-org.el"))

;; prefer package (e.g. Gentoo ebuild) for consistency (unless ebuild is terribly outdated)
;; (load-file (expand-file-name "~/.emacs.d/init/load-path-evil-git.el"))
;; load goto-chg.el and undo-tree.el from evil as a fallback
(load-file (expand-file-name "~/.emacs.d/init/load-path-evil-lib-git.el"))
;; alternatively prefer loading goto-chg.el and undo-tree.el from evil
;; (load-file (expand-file-name "~/.emacs.d/init/load-path-evil-lib-git-prefer.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-evil-leader.el"))
(load-file (expand-file-name "~/.emacs.d/init/load-path-evil-surround.el"))
(load-file (expand-file-name "~/.emacs.d/init/load-path-evil-numbers.el"))
(load-file (expand-file-name "~/.emacs.d/init/load-path-evil-org.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-expand-region.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-other.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-post.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/load-path-org-git.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-org2blog.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-package.el"))

(eval-when-compile
  (require 'use-package))

(load-file (expand-file-name "~/.emacs.d/init/package-scala.el"))

(load-file (expand-file-name "~/.emacs.d/init/env-other.el"))

(load-file (expand-file-name "~/.emacs.d/init/eshell.el"))

(load-file (expand-file-name "~/.emacs.d/init/server.el"))

(load-file (expand-file-name "~/.emacs.d/init/frames.el"))

(menu-bar-mode -1)

;; Evil
(load-file (expand-file-name "~/.emacs.d/init/evil.el"))
(load-file (expand-file-name "~/.emacs.d/init/undo-tree.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-leader.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-numbers.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-surround.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-org.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-quickscope.el"))

;; Numbers
(load-file (expand-file-name "~/.emacs.d/init/operate-on-number.el"))

(load-file (expand-file-name "~/.emacs.d/init/general-close.el"))

(load-file (expand-file-name "~/.emacs.d/init/paredit.el"))

(load-file (expand-file-name "~/.emacs.d/init/expand-region.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/elscreen.el"))

(load-file (expand-file-name "~/.emacs.d/init/hl-line.el"))

(load-file (expand-file-name "~/.emacs.d/init/recentf.el"))

(load-file (expand-file-name "~/.emacs.d/init/savehist.el"))

(load-file (expand-file-name "~/.emacs.d/init/ido.el"))

(load-file (expand-file-name "~/.emacs.d/init/format-region.el"))

(load-file (expand-file-name "~/.emacs.d/init/epa-file.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/xtag.el"))

(load-file (expand-file-name "~/.emacs.d/init/org.el"))
(load-file (expand-file-name "~/.emacs.d/init/org-contacts.el"))
(load-file (expand-file-name "~/.emacs.d/init/org2blog.el"))
(load-file (expand-file-name "~/.emacs.d/init/org-other.el"))

(load-file (expand-file-name "~/.emacs.d/init/yankpad.el"))

(load-file (expand-file-name "~/.emacs.d/init/remember.el"))

(load-file (expand-file-name "~/.emacs.d/init/auctex.el"))
(load-file (expand-file-name "~/.emacs.d/init/reftex.el"))
(load-file (expand-file-name "~/.emacs.d/init/bibtex.el"))
(load-file (expand-file-name "~/.emacs.d/init/synctex.el"))

(load-file (expand-file-name "~/.emacs.d/init/stex.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/nomdoc.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/prolog.el"))

(load-file (expand-file-name "~/.emacs.d/init/markdown-pandoc.el"))

(load-file (expand-file-name "~/.emacs.d/init/n3.el"))

(load-file (expand-file-name "~/.emacs.d/init/xquery.el"))

(load-file (expand-file-name "~/.emacs.d/init/post.el"))

(load-file (expand-file-name "~/.emacs.d/init/google-this.el"))

(load-file (expand-file-name "~/.emacs.d/init/toolbox.el"))

(load-file (expand-file-name "~/.emacs.d/init/hets.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/mizar.el"))

(load-file (expand-file-name "~/.emacs.d/init/ensime.el"))

(load-file (expand-file-name "~/.emacs.d/init/agda-input.el"))

(load-file (expand-file-name "~/.emacs.d/init/magit.el"))

(load-file (expand-file-name "~/.emacs.d/init/git.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/mediawiki.el"))

(load-file (expand-file-name "~/.emacs.d/init/writegood.el"))

(load-file (expand-file-name "~/.emacs.d/init/style-check.el"))

(load-file (expand-file-name "~/.emacs.d/init/font-lock.el"))

(load-file (expand-file-name "~/.emacs.d/init/fringe.el"))

(load-file (expand-file-name "~/.emacs.d/init/saveplace.el"))

(load-file (expand-file-name "~/.emacs.d/init/edit-misc.el"))

;; Keys
(load-file (expand-file-name "~/.emacs.d/init/which-key.el"))
(load-file (expand-file-name "~/.emacs.d/init/special-keys.el"))

;; Completion
(load-file (expand-file-name "~/.emacs.d/init/abbrev.el"))
(load-file (expand-file-name "~/.emacs.d/init/company.el"))
;; (load-file (expand-file-name "~/.emacs.d/init/yasnippet.el"))

(load-file (expand-file-name "~/.emacs.d/init/calculator.el"))

(load-file (expand-file-name "~/.emacs.d/init/nxml.el"))

(load-file (expand-file-name "~/.emacs.d/init/sgml.el"))

(load-file (expand-file-name "~/.emacs.d/init/calendar.el"))

(load-file (expand-file-name "~/.emacs.d/init/persistent-scratch.el"))

(load-file (expand-file-name "~/.emacs.d/init/system-specific.el"))

(load-file (expand-file-name "~/.emacs.d/init/open-my-files.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(abbrev-mode t t)
 '(blink-cursor-mode nil)
 '(browse-url-mailto-function nil)
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(fringe-mode 0 nil (fringe))
 '(global-font-lock-mode t nil (font-lock))
 '(kill-whole-line t)
 '(longlines-show-effect #("¶
    " 0 2 (face escape-glyph)))
 '(longlines-show-hard-newlines t)
 '(longlines-wrap-follows-window-size t)
 '(minibuffer-eldef-shorten-default t)
 '(org-agenda-files (quote ("~/svn/kwarc.info/clange/org/default.org" "~/svn/kwarc.info/clange/org/contacts.org")))
 '(org-clock-into-drawer 2)
 '(org-file-apps (quote ((auto-mode . emacs) ("\\.mm\\'" . default) ("\\.x?html?\\'" . "firefox %s") ("\\.pdf\\'" . "okular %s"))))
 '(org-latex-pdf-process (quote ("latexmk -g -pdf %f")))
 '(safe-local-variable-values (quote ((time-stamp-active . t) (TeX-master . wd-check) (TeX-master . wd-check\.tex) (nxml-child-indent . 2) (org-time-clocksum-format :hours "%d" :require-hours t :minutes ":%02d" :require-minutes t) (org-time-clocksum-format :days "%dd " :hours "%d" :require-hours t :minutes ":%02d" :require-minutes t) (LaTeX-biblatex-use-Biber) (org-export-latex-default-packages-alist ("T1" "fontenc" t) ("AUTO" "inputenc" t) ("" "fixltx2e" nil) ("" "graphicx" t) ("" "tabulary" nil) ("" "longtable" nil) ("" "float" nil) ("" "wrapfig" nil) ("" "soul" t) ("" "textcomp" t) ("" "marvosym" t) ("" "wasysym" t) ("" "latexsym" t) ("" "amssymb" t) ("" "hyperref" nil) "\\tolerance=1000") (eval evil-emacs-state) (evil-emacs-state-minor-mode . t) (TeX-source-correlate-method . synctex) (org-export-latex-default-packages-alist ("AUTO" "inputenc" t) ("LGRx,T1" "fontenc" t) ("" "fixltx2e" nil) ("" "graphicx" t) ("" "longtable" nil) ("" "float" nil) ("" "wrapfig" nil) ("" "soul" t) ("" "textcomp" t) ("" "marvosym" t) ("" "wasysym" t) ("" "latexsym" t) ("" "amssymb" t) ("" "hyperref" nil) "\\tolerance=1000") (xquery-indent-size . 4) (org-export-pdf-remove-logfiles) (nxml-child-indent . 4) (xsl-element-indent-step . 4) (org-export-ascii-table-keep-all-vertical-lines . t) (org-export-ascii-links-to-notes . t) (org-export-ascii-links-to-notes))))
 '(save-place t nil (saveplace))
 '(scroll-bar-mode nil)
 '(send-mail-function (quote mailclient-send-it))
 '(show-paren-mode t)
 '(show-paren-style (quote mixed))
 '(tab-always-indent (quote complete))
 '(text-mode-hook (quote (turn-on-visual-line-mode text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(word-wrap t))
;; '(vc-svn-program "locutor")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "Wheat" :foreground "NavyBlue" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "Misc" :family "Fixed"))))
 '(highline-face ((((class color) (background light)) (:background "#F1DD9B"))))
 '(hl-line ((t (:background "#F1DD9B"))))
 '(org-hide ((((background light)) (:foreground "Wheat")))))

