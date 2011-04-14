;; Adding ~/.emacs.d to load path
(add-to-list 'load-path "~/.emacs.d/")

;; Load Vimpulse 
;(require 'vimpulse)

;; Load paredit
(autoload 'enable-paredit-mode "paredit"
    "Turn on paredit" t)

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


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
