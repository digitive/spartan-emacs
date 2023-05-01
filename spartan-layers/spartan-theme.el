;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; remove hostname from the GUI titlebar
(setq-default frame-title-format '("Emacs"))

;; simple mode-line

;; https://emacs.stackexchange.com/questions/5529/how-to-right-align-some-items-in-the-modeline
(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT
 aligned respectively."
  (let* ((available-width (- (window-width) (length left) 2)))
    (format (format " %%s %%%ds " available-width) left right)))

(setq mode-line-format
      '((:eval (simple-mode-line-render
                ;; left
                (format-mode-line "%* %b %l")
                ;; right
                (format-mode-line "%m")))))

;; modeline to top

(setq-default header-line-format mode-line-format)
(setq-default mode-line-format nil)

;; a glorious startup theme

(setq inhibit-startup-screen t
      initial-major-mode 'emacs-lisp-mode
      load-prefer-newer t)

  (setq initial-scratch-message "
; _______  _____  _______  ______ _______ _______
; |______ |_____] |_____| |_____/    |    |_____|
; ______| |       |     | |    \\_    |    |     |

")

;; better scratch https://www.reddit.com/r/emacs/comments/4cmfwp/scratch_buffer_hacks_to_increase_its_utility/

(defun immortal-scratch ()
  (if (eq (current-buffer) (get-buffer "*scratch*"))
      (progn (bury-buffer)
             nil)
  t))

(add-hook 'kill-buffer-query-functions 'immortal-scratch)

(defun save-persistent-scratch ()
  "Save the contents of *scratch*"
  (with-current-buffer (get-buffer-create "*scratch*")
    (write-region (point-min) (point-max)
                  (concat user-emacs-directory "scratch"))))

(defun load-persistent-scratch ()
  "Reload the scratch buffer"
  (let ((scratch-file (concat user-emacs-directory "scratch")))
    (if (file-exists-p scratch-file)
        (with-current-buffer (get-buffer "*scratch*")
          (delete-region (point-min) (point-max))
          (insert-file-contents scratch-file)))))

(add-hook 'after-init-hook 'load-persistent-scratch)
(add-hook 'kill-emacs-hook 'save-persistent-scratch)

(run-with-idle-timer 300 t 'save-persistent-scratch)

;; no colors

;; (global-font-lock-mode -1)

;; (or window-system
;;       (add-to-list 'default-frame-alist '(tty-color-mode . -1)))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))



(provide 'spartan-theme)
