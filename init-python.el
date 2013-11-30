;(require 'flymake-python-pyflakes)

(setq pycodechecker "flake8")
;(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook (lambda()
                              (hl-line-mode -1)))
