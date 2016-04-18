;; ido
(require 'ido)
(ido-mode t)
(add-to-list 'ido-ignore-files "\.synctex\.gz\\'")

;; Buffers
(unless ido-mode 
  ;; smarter buffer switching (not needed when ido-switch-buffer is available)
  ; From: Writing GNU Emacs Extensions
  (defadvice switch-to-buffer (before existing-buffer activate compile)
    "When interactive, switch to existing buffers only, unless given a prefix argument."
    (interactive
     (list (read-buffer "Switch to buffer: "
                        (other-buffer)
                        (null current-prefix-arg)))))

  (defadvice switch-to-buffer-other-window (before existing-buffer activate compile)
    "When interactive, switch to existing buffers only, unless given a prefix argument."
    (interactive
     (list (read-buffer "Switch to buffer: "
                        (other-buffer)
                        (null current-prefix-arg)))))

  (defadvice switch-to-buffer-other-frame (before existing-buffer activate compile)
    "When interactive, switch to existing buffers only, unless given a prefix argument."
    (interactive
     (list (read-buffer "Switch to buffer: "
                        (other-buffer)
                        (null current-prefix-arg))))))

(setq ido-enable-flex-matching t)
(setq ido-file-extensions-order (quote (".tex")))
(setq ido-max-work-file-list 50)
