;; Highlighting
(global-hl-line-mode 1)

;; http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/dd861a79cf4492a4?pli=1
(defun visual-line-line-range ()
  (save-excursion
    (cons (progn (vertical-motion 0) (point))
         (progn (vertical-motion 1) (+ (point) 0)))))

(setq hl-line-range-function 'visual-line-line-range) 
