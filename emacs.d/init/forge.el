; Magit Forge
(use-package forge
  :after magit
  :config
  (push '("gitlab.cc-asp.fraunhofer.de"        ; GITHOST
	  "gitlab.cc-asp.fraunhofer.de/api/v4" ; APIHOST
	  "gitlab.cc-asp.fraunhofer.de"        ; WEBHOST and INSTANCE-ID
	  forge-gitlab-repository)             ; CLASS
	forge-alist))
