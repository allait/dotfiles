(require 'package)


;; Package installation
;; --------------------

;; Set the package sources.
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))



;; Setup packages
(setq elpa-packages
      '(evil
        paredit
        flycheck
        autopair
        deft
        surround ;; evil-surround
        clojure-mode
        markdown-mode
        adaptive-wrap
        ido-ubiquitous
        find-file-in-repository
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

;; Add themes/ to deftheme list
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; Set color theme
(load-theme 'gruber-darker t)

;; Load paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))

;; Setup deft
(require 'deft)
(setq deft-extension "md")
(setq deft-text-mode 'markdown-mode)
(setq deft-directory "~/wiki/scratch/")
(setq deft-use-filename-as-title t)

(global-set-key [f1] 'deft)

;; Enable flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Enable autopair
(require 'autopair)
(autopair-global-mode)

;; Enable ido-ubiquitous
(ido-ubiquitous 1)

(load "~/.emacs.d/evil.el")
(load "~/.emacs.d/org.el")
(load "~/.emacs.d/markdown.el")
