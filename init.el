;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; configuration -- uncomment desired layers => C-x C-s => M-x spartan-reconfigure

(setq spartan-layers '(spartan-startup
                       spartan-performance
                       spartan-better-defaults
                       spartan-binds-global
                       spartan-environment
                       spartan-elpa-melpa ; required by layers below

                       spartan-my-theme
                       spartan-ido
                       spartan-flymake
                       ;; spartan-projectile
                       spartan-evil
                       spartan-kill-ring
                       spartan-crux
                       spartan-webpaste
                       spartan-shell
                       ;; spartan-emacs-nw
                       spartan-vterm
                       spartan-magit
                       spartan-eglot
                       spartan-lisp
                       ;; spartan-c
                       spartan-python
                       spartan-terraform
                       ;; spartan-nix
                       spartan-nginx
                       ;; spartan-systemd
                       spartan-json
                       spartan-yaml
                       spartan-xml
                       spartan-javascript
                       ;; spartan-ruby
                       ;; spartan-rust
                       spartan-go
                       ;; spartan-solidity
                       spartan-custom
                       ))

;; spartan-layers

(add-to-list 'load-path (concat user-emacs-directory "spartan-layers"))

(dolist (layer spartan-layers)
  (require layer))

;; install third party packages

(with-eval-after-load 'spartan-elpa-melpa
  (spartan-package-bootstrap))

;; M-x customize

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load-file custom-file))

;; spartan.d/

(setq spartan-lisp-d (concat user-emacs-directory "spartan.d"))

(defun spartan-user-local-hook ()
  (when (file-directory-p spartan-lisp-d)
  (dolist (file (directory-files spartan-lisp-d nil "^.*\.el$"))
    (load-file (concat spartan-lisp-d "/" file)))))

(add-hook 'emacs-startup-hook 'spartan-user-local-hook)

;; M-x spartan-reconfigure

(defun spartan-reconfigure ()
  (interactive)
  (load-file user-init-file)
  (run-hooks 'after-init-hook
             'emacs-startup-hook))

;;; init.el ends here
