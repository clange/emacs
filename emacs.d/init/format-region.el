; my paren surrounder
(require 'format-region)

;; Key bindings
(global-set-key [(control c) ?\(] 'insert-parens-round)
(global-set-key [(control c) ?\{] 'insert-parens-curly)
(global-set-key [(control c) ?\[] 'insert-parens-square)
(global-set-key [(control c) ?\<] 'insert-parens-tags)
