;; LanguageTool
(require 'langtool)
(setq langtool-language-tool-jar (expand-file-name "~/tools/LanguageTool/languagetool-commandline.jar"))
(global-set-key "\C-x4w" 'langtool-check-buffer)
(global-set-key "\C-x4W" 'langtool-check-done)
(global-set-key "\C-x4n" 'langtool-goto-next-error)
(global-set-key "\C-x4p" 'langtool-goto-previous-error)
(global-set-key "\C-x44" 'langtool-show-message-at-point)
