(evil-leader/set-key
  "mm" 'minimap-toggle
  "M" 'magit-status
  "/"  'smex
  "C"  'evilnc-comment-or-uncomment-lines
  "b"  'switch-to-buffer
  "nn" 'sr-speedbar-toggle

  "ji" 'cider-jack-in
  "ns" 'cider-repl-set-ns
  ","  'cider-eval-expression-at-point
  "sf" 'cider-load-current-buffer
  "rn" 'nrepl-ritz-jack-in
  "N"  'cider-switch-to-repl-buffer


  "pa" 'projectile-ack
  "pf" 'projectile-find-file
  "pg" 'projectile-grep
  "pb" 'projectile-switch-to-buffer
  "po" 'projectile-multi-occur
  "pr" 'projectile-replace
  "pi" 'projectile-invalidate-cache
  "pt" 'projectile-regenerate-tags)

(evil-leader/set-key-for-mode 'paredit-mode
  "pe" 'paredit-mode
  "S"  'paredit-splice-sexp
  "W"  'paredit-wrap-sexp
  "w(" 'paredit-wrap-sexp
  "w[" 'paredit-wrap-square
  "w{" 'paredit-wrap-curly
  ">"  'paredit-forward-slurp-sexp
  "<"  'paredit-backward-barf-sexp
  "J"  'paredit-join-sexps)

(define-key evil-normal-state-map (kbd "C-j") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-k") 'windmove-up)
(define-key evil-normal-state-map (kbd "C-h") 'windmove-left)
(define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
