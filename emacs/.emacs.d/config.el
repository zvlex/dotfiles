(use-package ample-theme
  :ensure t)
(load-theme 'ample-flat t)

(set-face-attribute 'default nil :family "Source Code Pro")
(set-face-attribute 'default nil :height 110)

(global-display-line-numbers-mode t) ;; Enable line numbers
(column-number-mode 1) ;; Enable column numbers

;; 120 column indicator
(global-display-fill-column-indicator-mode 1)
(setq-default display-fill-column-indicator-column 120)

(tool-bar-mode -1) ;; Disable toolbar

(scroll-bar-mode -1) ;; Do not show scrollbar
(pixel-scroll-precision-mode t) ;; Fix scroll

(setq redisplay-dont-pause t) ;; Redisplay without pause

(fset 'yes-or-no-p 'y-or-n-p)

(setq ring-bell-function 'ignore)

(setq make-backup-files         nil) ;; Don't want any backup files
(setq auto-save-list-file-name  nil) ;; Don't want any .saves files
(setq auto-save-default         nil) ;; Don't want any auto saving

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(setq require-final-newline t) ;; Insert new like in the end of file
(global-auto-revert-mode t) ;; Autoreload changed file on disk

(use-package all-the-icons
  :if (display-graphic-p))
(setq all-the-icons-scale-factor 0.75)

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

;; Current mode icons
;; Overwriting the definitions
(setq mode-line-modified
      '(:eval (if (buffer-modified-p) " %*" " % ")))

(setq mode-line-read-only
      '(:eval (if buffer-read-only " %1* " " %1 ")))

(setq mode-line-read-only
      '(:eval (if buffer-read-only " %n" " %n ")))

(defvar mode-icons--eol-construct
  '(:eval (mode-line-eol-desc))
  "End of Line Construct.")

(setq vc-follow-symlinks t)

(use-package toc-org
  :ensure t
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))
(setq toc-org-max-depth 3)

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets
    :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package magit
  :ensure t)

(use-package diff-hl
  :ensure t
  :hook ((after-init . global-diff-hl-mode)
         (dired-mode . diff-hl-dired-mode)
         (magit-pre-refresh-hook . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (diff-hl-flydiff-mode +1)
  (diff-hl-margin-mode +1))

(use-package dashboard
  :ensure t
  :config
(dashboard-setup-startup-hook))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
            ("s-p" . projectile-command-map)
            ("C-c p" . projectile-command-map)))

(use-package neotree
  :ensure t
  :config
  (setq-default neo-show-hidden-files t))

(global-set-key (kbd "<f9>") 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-auto-merge-work-directories-length -1)
(ido-mode 1)

;; (use-package projectile-speedbar
;;   :ensure t)

(use-package move-text
  :ensure t)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

(use-package comment-dwim-2
  :ensure t)
(global-set-key (kbd "M-;") 'comment-dwim-2)

(use-package smartparens-mode
  :ensure smartparens
  :hook (prog-mode text-mode markdown-mode)
  :init
  (require 'smartparens-config))

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package multiple-cursors
:ensure t
:bind (("C-c m c" . mc/edit-lines)
       ("C-c m n" . mc/mark-next-like-this)
       ("C-c m p" . mc/mark-previous-like-this)
       ("C-c m a" . mc/mark-all-like-this)))

(use-package whitespace-cleanup-mode
  :ensure t
  :hook (before-save . whitespace-cleanup)
  :config (global-whitespace-cleanup-mode))

(use-package string-inflection
  :ensure t
  :hook ((ruby-mode . (lambda () (local-set-key (kbd "C-c C-u") 'string-inflection-ruby-style-cycle)))
         (elixir-mode . (lambda () (local-set-key (kbd "C-c C-u") 'string-inflection-elixir-style-cycle)))
         (java-mode . (lambda () (local-set-key (kbd "C-c C-u") 'string-inflection-java-style-cycle)))
         (python-mode . (lambda () (local-set-key (kbd "C-c C-u") 'string-inflection-python-style-cycle)))))

(global-set-key (kbd "C-c C-u") 'string-inflection-all-cycle)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package try
  :ensure t)

(use-package eshell-syntax-highlighting
  :ensure t
  :defer t
  :hook (eshell-mode . eshell-syntax-highlighting-mode)
  :config
  (eshell-syntax-highlighting-global-mode +1))

(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  (setq exec-path-from-shell-name "/bin/zsh")
  (let ((envs '("PATH" "SHELL" "DB_USERNAME" "DB_PASSWORD" "GOPATH" "GOROOT")))  ;; List your important env variables
    (exec-path-from-shell-copy-envs envs)))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package ruby-mode
  :ensure t
  :hook (ruby-mode . (lambda ()
                       (eglot-ensure)
                       ;; (add-to-list 'eglot-server-programs '((ruby-mode ruby-ts-mode) "ruby-lsp")))))
                       (add-to-list 'eglot-server-programs '(ruby-mode . ("solargraph" "stdio"))))))
;;(add-to-list 'eglot-server-programs '(ruby-mode . ("bundle" "exec" "rubocop" "--lsp"))))))

(use-package bundler
  :ensure t)

(use-package projectile-rails
  :ensure t
  :after projectile
  :bind-keymap
  ("C-c r" . projectile-rails-command-map)
  :config
  (projectile-rails-global-mode))

(use-package rspec-mode
  :ensure t
  :init
  (add-hook 'ruby-mode-hook #'rspec-mode)
  :bind (:map rspec-mode-map
              ("C-c t" . rspec-verify))
    :config
    (setq compilation-scroll-output t))

(use-package inf-ruby
  :ensure t
  :config
  (add-hook 'after-init-hook 'inf-ruby-switch-setup)
  (add-hook 'after-init-hook 'inf-ruby-switch-from-compilation)
  (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter))

;; (add-hook 'after-init-hook 'inf-ruby-switch-from-compilation)
;; (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter)

(use-package elixir-mode
  :ensure t)

(use-package elixir-ts-mode
  :ensure t)

(use-package heex-ts-mode
  :ensure t)

(use-package elixir-mode
  :ensure t
  :hook (elixir-mode . (lambda ()
                         (eglot-ensure)
                         (add-to-list 'eglot-server-programs `((elixir-ts-mode heex-ts-mode elixir-mode) . ("~/.emacs.d/pkg/elixir-ls/scripts/language_server.sh"))))))

;; Highlights *.elixir2 as well
(add-to-list 'auto-mode-alist '("\\.elixir2\\'" . elixir-mode))

(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'elixir-ts-mode-hook 'eglot-ensure)
  (add-hook 'heex-ts-mode-hook 'eglot-ensure)

;; Mix
(use-package mix
  :ensure t
  :config
  (add-hook 'elixir-mode-hook 'mix-minor-mode))

(eval-after-load "elixir-mode"
  '(defun elixir-format--mix-executable ()
     (string-trim-right (shell-command-to-string "asdf which mix"))))

(use-package erlang
  :ensure t)

(use-package go-mode
  :ensure t
  :hook (go-mode . (lambda ()
                     (eglot-ensure)
                     (add-to-list 'eglot-server-programs '(go-mode . ("gopls")))
                     ;; Add gofmt before saving
                     (add-hook 'before-save-hook 'gofmt-before-save nil t))))

(use-package racket-mode
  :ensure t
  :hook (racket-mode . (lambda ()
                         (eglot-ensure)
                         (add-to-list 'eglot-server-programs '(racket-mode . ("racket" "-l" "racket-langserver"))))))

(use-package yaml-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(use-package web-mode
  :ensure t
  :mode (("\\.html\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.js\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2) ; Set HTML indentation to 2 spaces
  (setq web-mode-css-indent-offset 2)    ; Set CSS indentation to 2 spaces
  (setq web-mode-code-indent-offset 2)   ; Set JS/PHP/Ruby indentation to 2 spaces
  (setq web-mode-enable-auto-pairing t)  ; Enable auto-pairing of tags and quotes
  (setq web-mode-enable-css-colorization t) ; Enable colorization of CSS colors
  (setq web-mode-enable-current-element-highlight t) ; Highlight the current HTML element
  (setq web-mode-enable-auto-expanding t) ; Enable auto-expanding of braces/brackets
  )

(use-package emmet-mode
  :ensure t
  :hook (web-mode css-mode html-mode mhtml-mode)
  :bind (:map emmet-mode-keymap
              ("C-c j" . emmet-expand-line))
  :config
  )

(use-package markdown-mode
  :ensure t)

(use-package pdf-tools
  :ensure t
  :config
  ;; Initialize pdf-tools
  (pdf-tools-install))

(use-package nov
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))
