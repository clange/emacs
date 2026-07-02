;; save minibuffer history
(savehist-mode 1)
(add-to-list 'savehist-additional-variables 'log-edit-comment-ring)
(add-to-list 'savehist-additional-variables 'search-ring)
(add-to-list 'savehist-additional-variables 'regexp-search-ring)
(add-to-list 'savehist-additional-variables 'helm-grep-history)
(add-to-list 'savehist-additional-variables 'helm-occur-history)
