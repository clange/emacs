;; Package manager
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(setq package-pinned-packages '(
				(ace-jump-mode . "melpa-stable")
				(ag . "melpa-stable")
				(async . "melpa-stable")
				(avy . "melpa-stable")
				(charmap . "melpa-stable")
				(dash . "melpa-stable")
				(diminish . "melpa-stable")
				(discover . "melpa-stable")
				(emmet-mode . "melpa-stable")
				;; (evil-surround . "melpa-stable")
				(evil-org . "melpa-stable")
				(evil-quickscope . "melpa-stable")
				(evil-numbers . "melpa-stable")
				(evil-matchit . "melpa-stable")
				(evil-leader . "melpa-stable")
				;; (evil-exchange . "melpa-stable")
				(evil . "melpa-stable")
				(git-commit . "melpa-stable")
				(git-timemachine . "melpa-stable")
				(helm-ag . "melpa-stable")
				(helm-org-rifle . "melpa-stable")
				(hydra . "melpa-stable")
				(inflections . "melpa-stable")
				(langtool . "melpa-stable")
				(helm . "melpa-stable")
				(helm-core . "melpa-stable")
				(magit . "melpa-stable")
				(magit-popup . "melpa-stable")
				(magit-svn . "melpa-stable")
				(makey . "melpa-stable")
				(markdown-mode . "melpa-stable")
				(operate-on-number . "melpa-stable")
				(org . "melpa-stable")
				(org2blog . "melpa-stable")
				(powershell . "melpa-stable")
				(projectile . "melpa-stable")
				(rdf-prefix . "melpa-stable")
				(undo-tree . "melpa-stable")
				(which-key . "melpa-stable")
				(with-editor . "melpa-stable")
				(writegood-mode . "melpa-stable")
				(yasnippet . "melpa-stable")
				))
(package-initialize)
