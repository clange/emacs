;; General

; deprecated: (fset 'yes-or-no-p 'y-or-n-p) instead see following line
(setq use-short-answers t)

(setq-default indent-tabs-mode nil)
(minibuffer-electric-default-mode 1)

(diminish 'visual-line-mode "")

;; disabled functions
(put 'downcase-region 'disabled t)
(put 'narrow-to-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled t)
(put 'set-goal-column 'disabled nil)

(custom-set-variables
  '(case-fold-search t)
  '(current-language-environment "UTF-8")
  '(kill-whole-line t)
  '(mark-even-if-inactive t)
  '(tab-always-indent 'complete)
  '(transient-mark-mode t)
  '(text-mode-hook '(turn-on-visual-line-mode text-mode-hook-identify))
  '(word-wrap t))
