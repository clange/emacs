(setq LaTeX-command "latex -synctex=1")
(setq TeX-source-correlate-method "synctex")
(setq TeX-source-correlate-mode t)

(cond
 ((eq system-type 'gnu/linux)
  (setq TeX-view-program-list (quote (("Okular" "okular --unique %u"))))
  (setq TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "Okular") (output-html "xdg-open")))))
 ((eq system-type 'windows-nt)
  ;; corresponding setting in SumatraPDF:
  ;; emacsclientw --no-wait +%l "%f"
  (setq TeX-view-program-list (quote (("SumatraPDF" "\"C:/Program Files (x86)/SumatraPDF/SumatraPDF.exe\" -reuse-instance %o"))))
  (setq TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "SumatraPDF") (output-html "cygstart"))))))
