;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(setq spartan-package-list '())

(require 'package)

;; Prefer GNU ELPA > MELPA (fallback)
(setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("GNU ELPA"     . 10)
        ("MELPA" . 5)))

(add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))

(setq package-enable-at-startup nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq straight-use-package-by-default t)
(straight-use-package 'use-package)
(require 'use-package)
(
(package-initialize)

(defun spartan-package-bootstrap ()
  (unless package-archive-contents
    (package-refresh-contents))

  (dolist (package spartan-package-list)
    (unless (package-installed-p package)
      (package-install package))))

(provide 'spartan-elpa-melpa)
