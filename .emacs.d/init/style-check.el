;; style-check
(defun style-check-file ()
  (interactive)
  (compile (format "style-check.rb -v %s" (buffer-file-name))))
