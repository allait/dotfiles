;; Adding ~/.emacs.d to load path
(add-to-list 'load-path "~/.emacs.d/")
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

;; Activate Org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; take the short answer, y/n is yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Load config parts
(load "~/.emacs.d/packages.el")
(load "~/.emacs.d/keys.el")
