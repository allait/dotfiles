(load "~/.emacs.d/macros.el")

;; Get PATH variable value from shell
(let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
  (setenv "PATH" path-from-shell)
  (setq exec-path (split-string path-from-shell path-separator)))

;; Set font size
(set-face-attribute 'default nil :height 110)

;; Disable beeping
(setq ring-bell-function 'ignore)

;; Disable scrollbar
(toggle-scroll-bar -1)

;; Disable toolbar
(tool-bar-mode -1)

;; Disable menu bar when running from terminal
(when (not (display-graphic-p))
  (menu-bar-mode 0))

;; No startup message
(setq inhibit-startup-message t)

;; Save backup files to ~/tmp
(setq backup-directory-alist `(("." . "~/tmp/backup")))
(setq auto-save-list-file-prefix nil)
(setq auto-save-file-name-transforms `((".*" "~/tmp/swap/" t)))

;; Show matching parentheses
(show-paren-mode 1)

;; Enable ido-mode
(require 'ido)
(ido-mode t)

;; Enable fuzzy matching
(setq ido-enable-flex-matching t)
(ido-everywhere t)

;; take the short answer, y/n is yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Set window size
(if (window-system)
  (set-frame-size (selected-frame) 100 50))

;; Don't ask for confirmation in ibuffer
(setq ibuffer-expert t)

;; Load config parts
(load "~/.emacs.d/packages.el")
(load "~/.emacs.d/keys.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode surround solarized-theme paredit markdown-mode ledger-mode ido-ubiquitous flycheck find-file-in-repository evil deft color-theme-solarized clojure-mode autopair adaptive-wrap))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
