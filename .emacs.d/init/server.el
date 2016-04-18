;; Server
(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
