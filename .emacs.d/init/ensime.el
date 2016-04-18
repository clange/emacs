;; Scala
(add-to-list 'load-path (expand-file-name "~/.emacs.d/ensime/elisp/"))
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
