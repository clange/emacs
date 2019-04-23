(require 'ispell)
(setq ispell-dictionary "english")
(add-to-list 'ispell-local-dictionary-alist '(("english"
                                               "[[:alpha:]]"
                                               "[^[:alpha:]]"
                                               "[']"
                                               t
                                               ("-d" "en_US")
                                               nil
                                               utf-8)))
(setq ispell-hunspell-dictionary-alist ispell-local-dictionary-alist)
(setq ispell-program-name "hunspell")
