; (package-initialize)

(load-file (expand-file-name "~/.emacs.d/init/cl.el"))

;; Packages and paths
;; (load-file (expand-file-name "~/.emacs.d/init/gentoo.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-local.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/load-path-disable-builtin-org.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/load-path-evil-git.el"))
;; (load-file (expand-file-name "~/.emacs.d/init/load-path-evil-lib-git.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/load-path-evil-leader.el"))
;; (load-file (expand-file-name "~/.emacs.d/init/load-path-evil-surround.el"))
;; (load-file (expand-file-name "~/.emacs.d/init/load-path-evil-numbers.el"))
;; (load-file (expand-file-name "~/.emacs.d/init/load-path-evil-org.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/load-path-expand-region.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/load-path-other.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-post.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/load-path-org-git.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/load-path-org2blog.el"))

(load-file (expand-file-name "~/.emacs.d/init/load-path-package.el"))

(eval-when-compile
  (require 'use-package))

;; (load-file (expand-file-name "~/.emacs.d/init/package-scala.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/env-other.el"))

(load-file (expand-file-name "~/.emacs.d/init/eshell.el"))
(load-file (expand-file-name "~/.emacs.d/init/dired.el"))

(load-file (expand-file-name "~/.emacs.d/init/server.el"))

;; GUI
(load-file (expand-file-name "~/.emacs.d/init/frames.el"))

(load-file (expand-file-name "~/.emacs.d/init/windows.el"))

(load-file (expand-file-name "~/.emacs.d/init/gui.el"))

(load-file (expand-file-name "~/.emacs.d/init/diminish.el"))

;; Jump/bookmarks
(load-file (expand-file-name "~/.emacs.d/init/bookmarks.el"))
(load-file (expand-file-name "~/.emacs.d/init/avy.el"))

;; Hydra
(load-file (expand-file-name "~/.emacs.d/init/hydra.el"))

;; Evil
(load-file (expand-file-name "~/.emacs.d/init/evil-leader.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-exchange.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-matchit.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-numbers.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-surround.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-org.el"))
(load-file (expand-file-name "~/.emacs.d/init/evil-quickscope.el"))

(load-file (expand-file-name "~/.emacs.d/init/undo-tree.el"))

;; Numbers
(load-file (expand-file-name "~/.emacs.d/init/operate-on-number.el"))

(load-file (expand-file-name "~/.emacs.d/init/general-close.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/paredit.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/expand-region.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/elscreen.el"))

(load-file (expand-file-name "~/.emacs.d/init/hl-line.el"))

(load-file (expand-file-name "~/.emacs.d/init/recentf.el"))

(load-file (expand-file-name "~/.emacs.d/init/savehist.el"))

;; needs to be configured correctly before Helm and magit-svn
(load-file (expand-file-name "~/.emacs.d/init/tramp.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/ido.el"))
;; Trying to use Helm everywhere
(load-file (expand-file-name "~/.emacs.d/init/helm.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/format-region.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/epa-file.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/xtag.el"))

;; Org mode
(load-file (expand-file-name "~/.emacs.d/init/org.el"))
(load-file (expand-file-name "~/.emacs.d/init/org-babel.el"))
(load-file (expand-file-name "~/.emacs.d/init/org-clock.el"))
(load-file (expand-file-name "~/.emacs.d/init/org-contacts.el"))
(load-file (expand-file-name "~/.emacs.d/init/org-jump.el"))
(load-file (expand-file-name "~/.emacs.d/init/org-secretary.el"))
(load-file (expand-file-name "~/.emacs.d/init/org2blog.el"))
;; (load-file (expand-file-name "~/.emacs.d/init/org-other.el"))

(load-file (expand-file-name "~/.emacs.d/init/yankpad.el"))

(load-file (expand-file-name "~/.emacs.d/init/remember.el"))

;; LaTeX
(load-file (expand-file-name "~/.emacs.d/init/auctex.el"))
(load-file (expand-file-name "~/.emacs.d/init/reftex.el"))
(load-file (expand-file-name "~/.emacs.d/init/bibtex.el"))
(load-file (expand-file-name "~/.emacs.d/init/synctex.el"))
;; (load-file (expand-file-name "~/.emacs.d/init/stex.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/nomdoc.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/prolog.el"))

(load-file (expand-file-name "~/.emacs.d/init/markdown-pandoc.el"))

;; Semantic Web
(load-file (expand-file-name "~/.emacs.d/init/n3.el"))
(load-file (expand-file-name "~/.emacs.d/init/owl.el"))

(load-file (expand-file-name "~/.emacs.d/init/user.el"))

(load-file (expand-file-name "~/.emacs.d/init/post.el"))

(load-file (expand-file-name "~/.emacs.d/init/google-this.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/toolbox.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/hets.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/mizar.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/ensime.el"))

;; Character input
(load-file (expand-file-name "~/.emacs.d/init/charmap.el"))
(load-file (expand-file-name "~/.emacs.d/init/agda-input.el"))

;; Software project management
(load-file (expand-file-name "~/.emacs.d/init/magit.el"))
(load-file (expand-file-name "~/.emacs.d/init/magit-svn.el"))
;; (load-file (expand-file-name "~/.emacs.d/init/magit-fix-diff-color.el"))
(load-file (expand-file-name "~/.emacs.d/init/git.el"))
(load-file (expand-file-name "~/.emacs.d/init/projectile.el"))

;; (load-file (expand-file-name "~/.emacs.d/init/mediawiki.el"))

;; Writing
(load-file (expand-file-name "~/.emacs.d/init/writegood.el"))
(load-file (expand-file-name "~/.emacs.d/init/langtool.el"))
(load-file (expand-file-name "~/.emacs.d/init/inflections.el"))
(load-file (expand-file-name "~/.emacs.d/init/style-check.el"))

;; Fonts
(load-file (expand-file-name "~/.emacs.d/init/font-lock.el"))
(load-file (expand-file-name "~/.emacs.d/init/fonts.el"))

;; Help
;; disabled because rectangle editing commands (e.g. C-x r t) no longer work
;; (load-file (expand-file-name "~/.emacs.d/init/discover.el"))

(load-file (expand-file-name "~/.emacs.d/init/fringe.el"))

(load-file (expand-file-name "~/.emacs.d/init/saveplace.el"))

(load-file (expand-file-name "~/.emacs.d/init/edit-misc.el"))

;; Keys
(load-file (expand-file-name "~/.emacs.d/init/which-key.el"))
(load-file (expand-file-name "~/.emacs.d/init/special-keys.el"))

;; Completion
(load-file (expand-file-name "~/.emacs.d/init/abbrev.el"))
(load-file (expand-file-name "~/.emacs.d/init/company.el"))
(load-file (expand-file-name "~/.emacs.d/init/yasnippet.el"))

(load-file (expand-file-name "~/.emacs.d/init/calculator.el"))

;; XML
(load-file (expand-file-name "~/.emacs.d/init/nxml.el"))
(load-file (expand-file-name "~/.emacs.d/init/sgml.el"))
(load-file (expand-file-name "~/.emacs.d/init/emmet.el"))
;; (load-file (expand-file-name "~/.emacs.d/init/xquery.el"))

(load-file (expand-file-name "~/.emacs.d/init/calendar.el"))

(load-file (expand-file-name "~/.emacs.d/init/persistent-scratch.el"))

(load-file (expand-file-name "~/.emacs.d/init/confirm-kill.el"))

;; Windows-specific configuration
(load-file (expand-file-name "~/.emacs.d/init/windows-bell.el"))
(load-file (expand-file-name "~/.emacs.d/init/windows-locale.el"))
(load-file (expand-file-name "~/.emacs.d/init/windows-unicode.el"))
(load-file (expand-file-name "~/.emacs.d/init/cygwin.el"))

;; Further system-specific configuration
(load-file (expand-file-name "~/.emacs.d/init/system-specific.el"))

(load-file (expand-file-name "~/.emacs.d/init/open-my-files.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(abbrev-mode t t)
 '(blink-cursor-mode nil)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(browse-url-mailto-function nil)
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(delete-selection-mode nil)
 '(fringe-mode 0 nil (fringe))
 '(global-font-lock-mode t nil (font-lock))
 '(kill-whole-line t)
 '(longlines-show-effect #("Â¶
    " 0 2 (face escape-glyph)))
 '(longlines-show-hard-newlines t)
 '(longlines-wrap-follows-window-size t)
 '(mark-even-if-inactive t)
 '(menu-bar-mode nil)
 '(minibuffer-eldef-shorten-default t)
 '(org-agenda-files
   (quote
    ("~/svn/kwarc.info/clange/org/default.org" "~/svn/kwarc.info/clange/org/contacts.org")))
 '(org-file-apps (quote ((auto-mode . emacs) ("\\.mm\\'" . default))))
 '(org-latex-pdf-process (quote ("latexmk -g -pdf %f")))
 '(package-selected-packages
   (quote
    (bookmark+ htmlize winum org-plus-contrib yankpad pandoc general-close dash-functional orgtbl-aggregate cygwin-mount image+ peep-dired use-package ebib google-this helm-bibtex company company-auctex company-math company-ngram company-statistics company-web smartrep org-clock-convenience evil-quickscope which-key helm-org-rifle operate-on-number 2048-game ag avy emmet-mode evil-exchange evil-surround helm-ag hydra n3-mode powershell psvn helm-projectile projectile yasnippet auctex markdown-mode csv-mode charmap writegood-mode rdf-prefix org2blog omn-mode magit-svn langtool inflections helm git-timemachine evil-org evil-numbers evil-matchit evil-leader discover diminish)))
 '(safe-local-variable-values
   (quote
    ((org-tags-exclude-from-inheritance quote
                                        ("prj" "FIX" "Tentative" "NotBusy" "OtherPeople"))
     (org-tags-exclude-from-inheritance quote
                                        ("Project" "FIX" "Tentative" "NotBusy" "OtherPeople"))
     (ispell-dictionary . british)
     (cache-long-scans)
     (org-export-babel-evaluate quote inline-only)
     (time-stamp-active . t)
     (TeX-master . wd-check)
     (TeX-master . wd-check\.tex)
     (nxml-child-indent . 2)
     (org-time-clocksum-format :hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)
     (org-time-clocksum-format :days "%dd " :hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)
     (LaTeX-biblatex-use-Biber)
     (eval evil-emacs-state)
     (evil-emacs-state-minor-mode . t)
     (TeX-source-correlate-method . synctex)
     (xquery-indent-size . 4)
     (org-export-pdf-remove-logfiles)
     (nxml-child-indent . 4)
     (xsl-element-indent-step . 4)
     (org-export-ascii-table-keep-all-vertical-lines . t)
     (org-export-ascii-links-to-notes . t)
     (org-export-ascii-links-to-notes))))
 '(save-place t nil (saveplace))
 '(save-place-mode t nil (saveplace))
 '(scroll-bar-mode nil)
 '(send-mail-function (quote mailclient-send-it))
 '(show-paren-mode t)
 '(show-paren-style (quote mixed))
 '(tab-always-indent (quote complete))
 '(text-mode-hook (quote (turn-on-visual-line-mode text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(word-wrap t))
;; '(vc-svn-program "locutor")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "Wheat" :foreground "NavyBlue" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "outline" :family "Fira Code"))))
 '(hl-line ((t (:background "#F1DD9B")))))
