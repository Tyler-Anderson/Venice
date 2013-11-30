(eval-after-load 'speedbar
  '(progn
     (evil-make-overriding-map speedbar-key-map)
     (evil-make-overriding-map speedbar-file-key-map)
     (evil-make-overriding-map speedbar-buffers-key-map)
     (evil-define-key 'motion speedbar-key-map "h" 'backward-char)
     (evil-define-key 'motion speedbar-key-map "j" 'speedbar-next)
     (evil-define-key 'motion speedbar-key-map "k" 'speedbar-prev)
     (evil-define-key 'motion speedbar-key-map "l" 'forward-char)
     (evil-define-key 'motion speedbar-key-map "i" 'speedbar-item-info)
     (evil-define-key 'motion speedbar-key-map "r" 'speedbar-refresh)
     (evil-define-key 'motion speedbar-key-map "u" 'speedbar-up-directory)
     (evil-define-key 'motion
       speedbar-key-map "o" 'speedbar-toggle-line-expansion)
     (evil-define-key
       'motion speedbar-key-map (kbd "RET") 'speedbar-edit-line)))

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                                     clojure-mode    scheme-mode
                                                     haskell-mode    ruby-mode
                                                     rspec-mode      python-mode
                                                     c-mode          c++-mode
                                                     objc-mode       latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))


;;;###autoload
(defun minimap-toggle ()
  "Toggle minimap for current buffer."
  (interactive)
  (if (null minimap-bufname)
      (minimap-create)
    (minimap-kill)))
