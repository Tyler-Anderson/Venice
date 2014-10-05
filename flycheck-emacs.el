;;; Commentary: Package form flychecks a bitch
;;;Code:
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get/recipes")
(add-to-list 'load-path "~/.emacs.d/custom/")
(add-to-list 'load-path "~/.emacs.d/personal")
(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/venice/")

(let ((default-directory "~/.emacs.d/elpa/"))
  (setq load-path
        (append
         (let ((load-path (copy-sequence load-path))) ;; Shadow
           (append 
            (copy-sequence (normal-top-level-add-to-load-path '(".")))
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))
(package-initialize)
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(setq
 el-get-sources
 '(el-get eyedropper hexrgb facemenu+ sr-speedbar))				; el-get is self-hosting

(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200)
(setq tab-width 4)
(setq indent-tabs-mode nil)

(setq evil-shift-width 2)
(unintern 'hl-line-mode)
;(require 'elscreen)
(require 'evil-elscreen)
(require 'aj-compilation)
(elscreen-start)
(global-linum-mode 1)
(load "screen-size")
(load "personal")
(load "evil-extra-maps")
(load "init-python")
(require 'minimap)
(require 'julia-mode)
(load "evil-powerline")
(load "init-elixir")
(powerline-center-evil-theme)
(require 'cider)
(require 'eyedropper)
(require 'hexrgb)
(require 'facemenu+)
(require 'sr-speedbar)
(require 'evil-nerd-commenter)
(require 'init-coffeescript)
(projectile-global-mode)
(global-evil-leader-mode t)
(global-rainbow-delimiters-mode)
(evil-leader/set-leader ",")
(require 'color-theme)
(require 'desert-theme)
(require 'evil-leader)
(require 'projectile)
(load "utils")
(require 'evil)
(evil-mode 1)
(load "evil-acejump")
(require 'auto-complete-config)
(require 'clojure-mode)
(require 'nrepl)
(require 'ac-nrepl)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-word-mode)
(define-key ac-completing-map [tab] 'ac-next)
(define-key ac-completing-map [S-tab] 'ac-previous)
(define-key ac-completing-map "\M-/" 'ac-stop) ; use M-/ to stop completion
(evil-make-intercept-map ac-completing-map) 
;overblown magit keymaps, fixed to simplify s to stage c to commit
(require 'evil-magit-rebellion)
(define-key global-map (kbd "RET") 'newline-and-indent)

;;nrepl goes with clojure
(load "init-clojure")
;; real global autocomplete hack
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                           (auto-complete-mode 1))))
(real-global-auto-complete-mode t)
(require 'evil-paredit)

(add-hook 'emacs-lisp-mode-hook
          (lambda() 
            (auto-complete-mode)))

(setq nrepl-hide-special-buffers t)
;; (setq cider-repl-tab-command 'indent-for-tab-command)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-popup-stacktraces nil)
(setq cider-repl-popup-stacktraces t)
(setq nrepl-buffer-name-separator "-")
(add-hook 'cider-repl-mode-hook 'subword-mode)


;TODO move all autocomplete functions into one file
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

 ;(setq powerline-color1 "#ffff")
 ;(setq powerline-color2 "#0000")

(add-hook 'prog-mode-hook 'powerline-center-evil-theme)
(add-hook 'prog-mode-hook 'flycheck-mode)
;; (add-hook 'html-mode-hook 'powerline-center-evil-theme)
;; (add-hook 'css-mode-hook 'powerline-center-evil-theme)
;; (add-hook 'sass-mode-hook 'powerline-center-evil-theme)

(load "init-theme-patch")
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)
;; (set-face-foreground 'mode-line "white")
;; (set-face-background 'mode-line "black")
;; (set-face-background 'powerline-active1  "#737373")
;; (set-face-background 'powerline-inactive1 "#9E9E9E")
;; (set-face-background 'po
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(defun set-exec-path-from-shell-PATH ()
  "Sets the exec-path to the same value used by the user shell"
  (let ((path-from-shell
         (replace-regexp-in-string
          "[[:space:]\n]*$" ""
          (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; call function now
(set-exec-path-from-shell-PATH)
