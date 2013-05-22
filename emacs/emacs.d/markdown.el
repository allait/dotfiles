;; Markdown mode
;; -------------

;; Associate markdown-mode with md files
(autoload 'markdown-mode "markdown-mode.el"
 "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; Use [[link|Text]] syntax for Wiki links
(setq markdown-wiki-link-alias-first nil)

;; Fix Tab binding
(after 'markdown-mode
       (define-key markdown-mode-map (kbd "<backtab>") 'markdown-shifttab))

;; Enable adaptive-wrap for markdown files
(add-hook 'markdown-mode-hook '(lambda () (progn (adaptive-wrap-prefix-mode 1) (visual-line-mode 1))))

