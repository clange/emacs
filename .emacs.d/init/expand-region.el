(require 'expand-region)
(define-key evil-visual-state-map ",x" 'er/expand-region)
(define-key evil-visual-state-map ",c" 'er/contract-region)
(define-key evil-normal-state-map ",x" 'er/expand-region)
