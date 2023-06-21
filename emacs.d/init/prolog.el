(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(setq prolog-program-name "pl")
(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))
