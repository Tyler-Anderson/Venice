(require 'coffee-mode)
(require 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)

(defun coffee-custom ()
  "coffee-mode-hook"
  (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
  (define-key coffee-mode-map [(meta R)] 'coffee-compile-region))

(add-hook 'coffee-mode-hook
          '(lambda()
             (coffee-custom)))

(add-hook 'after-init-hook
          '(lambda ()
              (when (locate-library "slime-js")
                (require 'setup-slime-js))))

(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))

(setq inferior-lisp-program "/usr/local/bin/sbcl")
(flymake-mode t)
(require 'slime)
(slime-setup)
(whitespace-mode)
(defun slime-js-coffee-eval-current ()
  (interactive)
  (coffee-compile-region (point) (mark))
  (switch-to-buffer coffee-compiled-buffer-name) 
  (slime-js-eval-buffer)
  (kill-buffer coffee-compiled-buffer-name))

(defun slime-js-coffee-eval-buffer ()
  (interactive)
  (coffee-compile-buffer)
  (switch-to-buffer coffee-compiled-buffer-name) 
  (slime-js-eval-buffer)
  (kill-buffer coffee-compiled-buffer-name))

(require 'coffee-mode)

(add-hook 'coffee-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))
 (local-set-key (kbd "C-c C-d") 'slime-js-coffee-eval-current)
 (local-set-key (kbd "C-c C-b") 'slime-js-coffee-eval-buffer)

(provide 'init-coffeescript)
