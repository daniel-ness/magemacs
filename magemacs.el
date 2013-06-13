;;
;; -- Magemacs --
;; @author Daniel Ness <daniel.r.ness@gmail.com>
;;

;; -- Aims --
;; 1. Creation of new module skeleton
;; 2. Module search
;; 3. Maintain a list of projects

(defun get-magento-root (file)
  ;; Get root magento installation directory that is parent of file
  ;; by attempting to identify {root}/app/Mage.php
  (let ((root-dir (locate-dominating-file dir "app")))
    (if (stringp root-dir)
        (let* ((dir (expand-file-name root-dir))
               (app-dir (concat (file-name-as-directory dir) (file-name-as-directory "app"))))
          (if (file-exists-p (concat app-dir "Mage.php"))
              dir)))))

(defun magemacs-mode ()
  (interactive)
  (let ((file (buffer-file-name)))
    (message (get-magento-root file))))

