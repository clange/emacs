;; adapted http://felixge.de/2013/08/08/vim-trick-open-current-line-on-github.html from vim to Emacs; see `which git-url` for the accompanying shell script
(defun git-url ()
  (interactive)
  (kill-new
   (concat
    (replace-regexp-in-string "\n$" "" (shell-command-to-string (concat "git url " (buffer-file-name) " echo")))
    "#L"
    (number-to-string (line-number-at-pos)))))
