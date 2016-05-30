;; Abort commands with Esc
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Indent newline with Return
(global-set-key (kbd "RET") 'newline-and-indent)

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)
