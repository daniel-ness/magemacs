;;
;; -- Magemacs --
;; @author Daniel Ness <daniel.r.ness@gmail.com>
;;

;; -- Aims --
;; 1. Creation of new module skeleton
;; 2. Module search

(setq magemacs-dir (expand-file-name (file-name-directory (buffer-file-name))))

(defun mage-get-root ()
  ;; Get root magento installation directory that is parent of file
  ;; by attempting to identify {root}/app/Mage.php
  (let* ((dir (file-name-directory (buffer-file-name)))
         (root-dir (expand-file-name (locate-dominating-file dir "app"))))
    (if (stringp root-dir)
        (let* ((dir (expand-file-name root-dir))
               (app-dir (concat (file-name-as-directory dir) (file-name-as-directory "app"))))
          (if (file-exists-p (filepath-concat app-dir "Mage.php"))
              root-dir)))))

(defun filepath-concat (&rest parts)
  (let ((start (butlast parts))
        (end (car (last parts))))
    (expand-file-name (concat (mapconcat 'file-name-as-directory start "") end))))
      
(defun mage-get-app-dir ()
  (filepath-concat (mage-get-root) "app"))

(defun mage-get-etc-dir ()
  (filepath-concat (mage-get-app-dir) "etc"))

(defun mage-get-module-dir ()
  (filepath-concat (mage-get-etc-dir) "modules"))

(defun mage-list-modules ()
  (directory-files (mage-get-module-dir) nil "\\w+_\\w+.xml$"))

(defun mage-new-module ()
  (interactive)
  (read-from-minibuffer "Codepool (local/community): ")
  (read-from-minibuffer "Namespace_ModuleName: ")
  )

(defun mage-describe-model ()
  (interactive)
  )

(defun mage-summary ()
  (interactive)
  )

(defun mage-version ()
  (interactive)
  )

(defun mage-list-modules ()
  (interactive)
  )

(defun mage-run-shell (arg)
  ;; Execute the php bridge script to get information
  ;; directly from magento
  (let ((root-dir (mage-get-root)))
    (with-temp-buffer
      (let ((output (current-buffer)))
        (progn
          (with-temp-buffer
            (insert (format "require_once '%s/shell/abstract.php';" root-dir))
            (insert-file-contents (filepath-concat magemacs-dir "magemacs.php"))
            (call-process "php" nil output nil "-r" (buffer-string) arg)
            )
          (buffer-string))))))

(defun mage-get-version ()
  (interactive)
  (message (mage-run-shell "version")))

(defun mage-open-config ()
  (interactive)
  (find-file (filepath-concat (mage-get-root) "app" "etc" "local.xml"))
  )



                          








