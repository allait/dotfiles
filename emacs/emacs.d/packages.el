(require 'package)


;; Package installation
;; --------------------

;; Set the package sources.
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))


;; Setup packages
(setq elpa-packages
      '(clojure-mode
        deft
        evil
        markdown-mode
        paredit
        ))

;; Initialize the package system.
(package-initialize)

;; Refresh package archives when necessary.
(unless (file-exists-p "~/.emacs.d/elpa/archives")
  (package-refresh-contents))

;; Install all packages.
(dolist (package elpa-packages)
  (when (not (package-installed-p package))
    (package-install package)))


;; Package configuration
;; ---------------------

;; Load paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))

;; Add themes/ to deftheme list
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; Set color theme
(load-theme 'gruber-darker t)

;; Associate markdown-mode with md files
(autoload 'markdown-mode "markdown-mode.el"
 "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; Setup deft
(require 'deft)
(setq deft-extension "md")
(setq deft-text-mode 'markdown-mode)
(setq deft-directory "~/wiki/scratch/")
(setq deft-use-filename-as-title t)

(global-set-key [f1] 'deft)

;; Load evil (vim mode)
(add-to-list 'load-path "~/.emacs.d/packages/evil/")
(require 'evil)
(evil-mode 1)

;; Configure evil-mode keys

;; Rebind M-x to ";"
(define-key evil-normal-state-map ";" 'execute-extended-command)

(evil-define-key 'normal markdown-mode-map "\C-m" 'markdown-enter-key)

