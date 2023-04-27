; TODO initialize quelpa like
; https://github.com/quelpa/quelpa-use-package
; https://github.com/quelpa/quelpa
(use-package bookmark+
  :quelpa (bookmark+ :fetcher wiki
                     :files
                     ("bookmark+.el"
                      "bookmark+-mac.el"
                      "bookmark+-bmu.el"
                      "bookmark+-1.el"
                      "bookmark+-key.el"
                      "bookmark+-lit.el"
                      "bookmark+-doc.el"
                      "bookmark+-chg.el"))
  :defer 2)
(setq bookmark-version-control t)
