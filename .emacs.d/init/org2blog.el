;; Org Blog
(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist
      '(("kwarc"
         :url "https://kwarc.info/blog/xmlrpc.php"
         :username "clange"
         :default-title "KWARCwas!"
         :default-categories ("clange")
         :tags-as-categories nil)
        ("langec"
         :url "https://langec.wordpress.com/xmlrpc.php"
         :username "langec")))
