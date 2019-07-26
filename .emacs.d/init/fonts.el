;; Fonts
;; Incomplete ligature setup recommended for Fira Code
;; https://github.com/tonsky/FiraCode/wiki/Setting-up-Emacs

(defun fira-code-mode--make-alist (list)
  "Generate prettify-symbols alist from LIST."
  (let ((idx -1))
    (mapcar
     (lambda (s)
       (setq idx (1+ idx))
       (let* ((code (+ #Xe100 idx))
          (width (string-width s))
          (prefix ())
          (suffix '(?\s (Br . Br)))
          (n 1))
     (while (< n width)
       (setq prefix (append prefix '(?\s (Br . Bl))))
       (setq n (1+ n)))
     (cons s (append prefix suffix (list (decode-char 'ucs code))))))
     list)))

(defconst fira-code-mode--ligatures
  '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
    "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
    "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
    "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
    ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
    "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
    "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
    "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
    ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
    "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
    "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
    "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
    "x" ":" "+" "+" "*"))

(defvar fira-code-mode--old-prettify-alist)

(defun fira-code-mode--enable ()
  "Enable Fira Code ligatures in current buffer."
  (setq-local fira-code-mode--old-prettify-alist prettify-symbols-alist)
  (setq-local prettify-symbols-alist (append (fira-code-mode--make-alist fira-code-mode--ligatures) fira-code-mode--old-prettify-alist))
  (prettify-symbols-mode t))

(defun fira-code-mode--disable ()
  "Disable Fira Code ligatures in current buffer."
  (setq-local prettify-symbols-alist fira-code-mode--old-prettify-alist)
  (prettify-symbols-mode -1))

(define-minor-mode fira-code-mode
  "Fira Code ligatures minor mode"
  :lighter " Fira Code"
  (setq-local prettify-symbols-unprettify-at-point 'right-edge)
  (if fira-code-mode
      (fira-code-mode--enable)
    (fira-code-mode--disable)))

(defun fira-code-mode--setup ()
  "Setup Fira Code Symbols"
  (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol"))

(provide 'fira-code-mode)

;; ; Old code
;; (let ((alist '(
;;                (33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
;;                (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
;;                (36 . ".\\(?:>\\)")
;;                (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
;;                (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
;;                (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
;;                (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
;;                (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
;;                (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
;;                (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
;;                (48 . ".\\(?:x[a-zA-Z]\\)")
;;                ;; The following one crashes org-mode's org-set-tags-command
;;                (58 . ".\\(?:::\\|[:=]\\)")
;;                (59 . ".\\(?:;;\\|;\\)")
;;                (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
;;                (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
;;                (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
;;                (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
;;                (91 . ".\\(?:]\\)")
;;                (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
;;                (94 . ".\\(?:=\\)")
;;                (119 . ".\\(?:ww\\)")
;;                (123 . ".\\(?:-\\)")
;;                (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
;;                (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
;;                )
;;              ))
;;   (dolist (char-regexp alist)
;;     (set-char-table-range composition-function-table (car char-regexp)
;;                           `([,(cdr char-regexp) 0 font-shape-gstring]))))

;; ;; https://gist.github.com/mordocai/50783defab3c3d1650e068b4d1c91495
;; (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")

;; (defconst fira-code-font-lock-keywords-alist
;;   (mapcar (lambda (regex-char-pair)
;;             `(,(car regex-char-pair)
;;               (0 (prog1 ()
;;                    (compose-region (match-beginning 1)
;;                                    (match-end 1)
;;                                    ;; The first argument to concat is a string containing a literal tab
;;                                    ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
;;           '(("\\(www\\)"                   #Xe100)
;;             ("[^/]\\(\\*\\*\\)[^/]"        #Xe101)
;;             ("\\(\\*\\*\\*\\)"             #Xe102)
;;             ("\\(\\*\\*/\\)"               #Xe103)
;;             ("\\(\\*>\\)"                  #Xe104)
;;             ("[^*]\\(\\*/\\)"              #Xe105)
;;             ("\\(\\\\\\\\\\)"              #Xe106)
;;             ("\\(\\\\\\\\\\\\\\)"          #Xe107)
;;             ("\\({-\\)"                    #Xe108)
;;             ("\\(\\[\\]\\)"                #Xe109)
;;             ("\\(::\\)"                    #Xe10a)
;;             ("\\(:::\\)"                   #Xe10b)
;;             ("[^=]\\(:=\\)"                #Xe10c)
;;             ("\\(!!\\)"                    #Xe10d)
;;             ("\\(!=\\)"                    #Xe10e)
;;             ("\\(!==\\)"                   #Xe10f)
;;             ("\\(-}\\)"                    #Xe110)
;;             ("\\(--\\)"                    #Xe111)
;;             ("\\(---\\)"                   #Xe112)
;;             ("\\(-->\\)"                   #Xe113)
;;             ("[^-]\\(->\\)"                #Xe114)
;;             ("\\(->>\\)"                   #Xe115)
;;             ("\\(-<\\)"                    #Xe116)
;;             ("\\(-<<\\)"                   #Xe117)
;;             ("\\(-~\\)"                    #Xe118)
;;             ("\\(#{\\)"                    #Xe119)
;;             ("\\(#\\[\\)"                  #Xe11a)
;;             ("\\(##\\)"                    #Xe11b)
;;             ("\\(###\\)"                   #Xe11c)
;;             ("\\(####\\)"                  #Xe11d)
;;             ("\\(#(\\)"                    #Xe11e)
;;             ("\\(#\\?\\)"                  #Xe11f)
;;             ("\\(#_\\)"                    #Xe120)
;;             ("\\(#_(\\)"                   #Xe121)
;;             ("\\(\\.-\\)"                  #Xe122)
;;             ("\\(\\.=\\)"                  #Xe123)
;;             ("\\(\\.\\.\\)"                #Xe124)
;;             ("\\(\\.\\.<\\)"               #Xe125)
;;             ("\\(\\.\\.\\.\\)"             #Xe126)
;;             ("\\(\\?=\\)"                  #Xe127)
;;             ("\\(\\?\\?\\)"                #Xe128)
;;             ("\\(;;\\)"                    #Xe129)
;;             ("\\(/\\*\\)"                  #Xe12a)
;;             ("\\(/\\*\\*\\)"               #Xe12b)
;;             ("\\(/=\\)"                    #Xe12c)
;;             ("\\(/==\\)"                   #Xe12d)
;;             ("\\(/>\\)"                    #Xe12e)
;;             ("\\(//\\)"                    #Xe12f)
;;             ("\\(///\\)"                   #Xe130)
;;             ("\\(&&\\)"                    #Xe131)
;;             ("\\(||\\)"                    #Xe132)
;;             ("\\(||=\\)"                   #Xe133)
;;             ("[^|]\\(|=\\)"                #Xe134)
;;             ("\\(|>\\)"                    #Xe135)
;;             ("\\(\\^=\\)"                  #Xe136)
;;             ("\\(\\$>\\)"                  #Xe137)
;;             ("\\(\\+\\+\\)"                #Xe138)
;;             ("\\(\\+\\+\\+\\)"             #Xe139)
;;             ("\\(\\+>\\)"                  #Xe13a)
;;             ("\\(=:=\\)"                   #Xe13b)
;;             ("[^!/]\\(==\\)[^>]"           #Xe13c)
;;             ("\\(===\\)"                   #Xe13d)
;;             ("\\(==>\\)"                   #Xe13e)
;;             ("[^=]\\(=>\\)"                #Xe13f)
;;             ("\\(=>>\\)"                   #Xe140)
;;             ("\\(<=\\)"                    #Xe141)
;;             ("\\(=<<\\)"                   #Xe142)
;;             ("\\(=/=\\)"                   #Xe143)
;;             ("\\(>-\\)"                    #Xe144)
;;             ("\\(>=\\)"                    #Xe145)
;;             ("\\(>=>\\)"                   #Xe146)
;;             ("[^-=]\\(>>\\)"               #Xe147)
;;             ("\\(>>-\\)"                   #Xe148)
;;             ("\\(>>=\\)"                   #Xe149)
;;             ("\\(>>>\\)"                   #Xe14a)
;;             ("\\(<\\*\\)"                  #Xe14b)
;;             ("\\(<\\*>\\)"                 #Xe14c)
;;             ("\\(<|\\)"                    #Xe14d)
;;             ("\\(<|>\\)"                   #Xe14e)
;;             ("\\(<\\$\\)"                  #Xe14f)
;;             ("\\(<\\$>\\)"                 #Xe150)
;;             ("\\(<!--\\)"                  #Xe151)
;;             ("\\(<-\\)"                    #Xe152)
;;             ("\\(<--\\)"                   #Xe153)
;;             ("\\(<->\\)"                   #Xe154)
;;             ("\\(<\\+\\)"                  #Xe155)
;;             ("\\(<\\+>\\)"                 #Xe156)
;;             ("\\(<=\\)"                    #Xe157)
;;             ("\\(<==\\)"                   #Xe158)
;;             ("\\(<=>\\)"                   #Xe159)
;;             ("\\(<=<\\)"                   #Xe15a)
;;             ("\\(<>\\)"                    #Xe15b)
;;             ("[^-=]\\(<<\\)"               #Xe15c)
;;             ("\\(<<-\\)"                   #Xe15d)
;;             ("\\(<<=\\)"                   #Xe15e)
;;             ("\\(<<<\\)"                   #Xe15f)
;;             ("\\(<~\\)"                    #Xe160)
;;             ("\\(<~~\\)"                   #Xe161)
;;             ("\\(</\\)"                    #Xe162)
;;             ("\\(</>\\)"                   #Xe163)
;;             ("\\(~@\\)"                    #Xe164)
;;             ("\\(~-\\)"                    #Xe165)
;;             ("\\(~=\\)"                    #Xe166)
;;             ("\\(~>\\)"                    #Xe167)
;;             ("[^<]\\(~~\\)"                #Xe168)
;;             ("\\(~~>\\)"                   #Xe169)
;;             ("\\(%%\\)"                    #Xe16a)
;;             ;;("\\(x\\)"                     #Xe16b)
;;             ("[^:=]\\(:\\)[^:=]"           #Xe16c)
;;             ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
;;             ("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f))))

;; (defun add-fira-code-symbol-keywords ()
;;   (font-lock-add-keywords nil fira-code-font-lock-keywords-alist))

;; (add-hook 'prog-mode-hook
;;           #'add-fira-code-symbol-keywords)
