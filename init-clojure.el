(add-hook 'clojure-mode-hook
          '(lambda ()
             (font-lock-add-keywords
              nil
              '(("(\\(defwidget\\)\\s-+\\(\\w+\\)"
                 (1 font-lock-keyword-face)
                 (2 font-lock-function-name-face))))))

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
(defun my-nrepl-mode-setup ()
  (require 'nrepl-ritz))

(defun nrepl-popup-tip-symbol-at-point ()
  (interactive)
  (popup-tip (ac-nrepl-documentation (symbol-at-point))
             :point (ac-nrepl-symbol-start-pos)
             :around t
             :scroll-bar t
             :margin t))
;;(require 'nrepl-inspect)
;; Configure nrepl.el
(setq nrepl-hide-special-buffers t)
(setq nrepl-popup-stacktraces nil)
(setq nrepl-history-file "~/.emacs.d/nrepl-history")




;; Repl mode hook
;; Auto completion for NREPL
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(add-hook 'clojure-mode-hook
          (lambda()
            (auto-complete-mode t)))

                                        ;(setq nrepl-tab-command 'indent-for-tab-command)

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

;; (cider-enable-on-existing-clojure-buffers)
(add-hook 'nrepl-connected-hook 'cider-enable-on-existing-clojure-buffers)
