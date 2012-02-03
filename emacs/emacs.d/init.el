;; Adding ~/.emacs.d to load path
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/packages/")

;; Load ELPA
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; Load evil (vim mode)
(add-to-list 'load-path "~/.emacs.d/packages/evil/")
(require 'evil)
(evil-mode 1)

;; Load paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))

;; Load color-theme
(require 'color-theme)
(color-theme-initialize)

;; Set color theme
(color-theme-gruber-darker)

;; Set font size
(set-face-attribute 'default nil :height 110)

;; Disable beeping
(setq ring-bell-function 'ignore)

;; Disable scrollbar
(toggle-scroll-bar -1)

;; Disable toolbar
(tool-bar-mode -1)

;; No startup message
(setq inhibit-startup-message t)

;; Activate Org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Associate markdown-mode with md files
(autoload 'markdown-mode "markdown-mode.el"
 "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))
