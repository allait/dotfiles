;; Load and configure evil (vim mode)
;; ----------------------------------

(add-to-list 'load-path "~/.emacs.d/packages/evil/")
(require 'evil)
(evil-mode 1)

(evil-set-initial-state 'ibuffer-mode 'normal)

;; Load and configure evil plugins
;; -------------------------------

;; Enable evil-surround mode
(require 'surround)
(global-surround-mode 1)

;; Configure evil-mode keys
;; ------------------------

;; Fuzzy search
(define-key evil-normal-state-map ",e" 'find-file-in-repository)
(define-key evil-normal-state-map ",q" 'ido-switch-buffer)

;; Rebind M-x to ";"
(define-key evil-normal-state-map ";" 'execute-extended-command)
(define-key evil-normal-state-map "\C-wq" 'delete-window)
