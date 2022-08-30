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

(straight-use-package 'use-package) (setq straight-use-package-by-default t)

;; indentation
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq c-basic-offset tab-width)
(setq-default electric-indent-inhibit t)
(setq-default indent-tabs-mode t)
(setq backward-delete-char-untabify-method 'nil)

;; enable clipboard
(setq x-select-enable-clipboard t)

;; disable backups
(setq make-backup-files nil)
(setq auto-save-default nil)

;; disable ring-bell
(setq ring-bell-function 'ignore)

;; scroll
(setq scroll-conservatively 100)
(setq scroll-margin 2)

;; font
(defun my/set-font-faces ()
  (let* ((main-font "Iosevka Nerd Font 11")
         (fallback "monospace")
         (font (if (x-list-fonts main-font) main-font fallback)))
    (set-face-attribute 'default nil :font font)
    (set-face-attribute 'fixed-pitch nil :font font)))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame (my/set-font-faces))))
  (my/set-font-faces))

(setq global-hl-line-mode t)

;; relative number
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(defalias 'yes-or-no-p 'y-or-n-p)

;; eletric pairs
(setq eletric-pair-pairs '(
                            (?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")))
(electric-pair-mode t)

;; theme
(load-theme 'mplex t)

;; clean
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil
      server-client-instructions nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

;; org
(use-package org)

;; evil
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-operator-state-tag "OPR"
        evil-normal-state-tag "NOR"
        evil-insert-state-tag "INS"
        evil-visual-state-tag "VIS"
        evil-replace-state-tag "REP"
        evil-emacs-state-tag "EMC"
        evil-motion-state-tag "MOT")

  (use-package undo-fu)

  (setq evil-echo-state nil
        evil-undo-system 'undo-fu
        evil-want-C-u-scroll t
        evil-want-Y-yank-to-eol t
        evil-search-module 'evil-search)

  :custom
  (evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :demand t
  :after evil
  :config
  (evil-collection-init))

(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package evil-commentary
  :init (evil-commentary-mode))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))
