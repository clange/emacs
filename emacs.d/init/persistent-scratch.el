;; source: http://dorophone.blogspot.de/2011/11/how-to-make-emacs-scratch-buffer.html

(defvar persistent-scratch-filename 
    "~/.emacs-persistent-scratch"
    "Location of *scratch* file contents for persistent-scratch.")
(defvar persistent-scratch-backup-directory 
    "~/.emacs-persistent-scratch-backups/"
    "Location of backups of the *scratch* buffer contents for
    persistent-scratch.")

(defun make-persistent-scratch-backup-name ()
  "Create a filename to backup the current scratch file by
  concatenating PERSISTENT-SCRATCH-BACKUP-DIRECTORY with the
  current date and time."
  (concat 
   persistent-scratch-backup-directory 
   (replace-regexp-in-string 
     (regexp-quote ":") "_" (replace-regexp-in-string 
     (regexp-quote " ") "-" (current-time-string)))))

(defun save-persistent-scratch ()
  "Write the contents of *scratch* to the file name
  PERSISTENT-SCRATCH-FILENAME, making a backup copy in
  PERSISTENT-SCRATCH-BACKUP-DIRECTORY."
  (with-current-buffer (get-buffer "*scratch*")
    (if (file-exists-p persistent-scratch-filename)
        (copy-file persistent-scratch-filename
                   (make-persistent-scratch-backup-name)))
    (write-region (point-min) (point-max) 
                  persistent-scratch-filename)))

(defun load-persistent-scratch ()
  "Load the contents of PERSISTENT-SCRATCH-FILENAME into the
  scratch buffer, clearing its contents first."
  (if (file-exists-p persistent-scratch-filename)
      (with-current-buffer (get-buffer "*scratch*")
        (delete-region (point-min) (point-max))
        (insert-file persistent-scratch-filename))))

(push #'load-persistent-scratch after-init-hook)
(push #'save-persistent-scratch kill-emacs-hook)

(run-with-idle-timer 300 t 'save-persistent-scratch)
