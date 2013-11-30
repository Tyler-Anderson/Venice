;;;package is things

(add-to-list 'auto-mode-alist '("\\.elixir2\\'" . elixir-mode))
(require 'flymake-elixir)
(add-hook 'elixir-mode-hook 'flymake-elixir-load)
(evil-leader/set-key-for-mode 'elixir-mode
  "," 'elixir-mode-eval-on-region
  "er" 'elixir-mode-iex
  "C" 'elixir-mode-compile-file
  "el" 'elixir-mode-eval-on-current-line
  "eb" 'elixir-mode-eval-on-current-buffer)
  
  
;;;init-elixir ends here
