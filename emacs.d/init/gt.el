(use-package gt :ensure t)

(setq gt-langs '(en de))

(setq gt-default-translator
      (gt-translator
       :taker   (gt-taker :text 'buffer :pick 'paragraph)  ; config the Taker
       :engines (list (gt-bing-engine) (gt-google-engine)) ; specify the Engines
       :render  (gt-buffer-render)))                       ; config the Render
;; This configuration means:
;; Initialize the default translator, let it send all paragraphs in the buffer to Bing and Google,
;; and output the results with a new Buffer.
