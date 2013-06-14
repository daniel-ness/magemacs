;;
;; -- Magemacs --
;; @author Daniel Ness <daniel.r.ness@gmail.com>
;;

;; -- Aims --
;; 1. Creation of new module skeleton
;; 2. Module search
;; 3. Maintain a list of projects

(defun mage-get-root ()
  ;; Get root magento installation directory that is parent of file
  ;; by attempting to identify {root}/app/Mage.php
  (interactive)
  (let* ((dir (file-name-directory (buffer-file-name)))
         (root-dir (expand-file-name (locate-dominating-file dir "app"))))
    (if (stringp root-dir)
        (let* ((dir (expand-file-name root-dir))
               (app-dir (concat (file-name-as-directory dir) (file-name-as-directory "app"))))
          (if (file-exists-p (filepath-concat app-dir "Mage.php"))
              root-dir)))))

(defun filepath-concat (dir file)
  (concat (file-name-as-directory dir) file))

(defun mage-get-app-dir ()
  (filepath-concat (mage-get-root) "app"))

(defun mage-get-etc-dir ()
  (filepath-concat (mage-get-app-dir) "etc"))

(defun mage-get-module-dir ()
  (filepath-concat (mage-get-etc-dir) "modules"))

(defun mage-list-modules ()
  (directory-files (mage-get-module-dir) nil "\\w+_\\w+.xml$"))


