(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'eglot)
(require 'elixir-mode)
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs '(elixir-mode "~/.emacs.d/pkg/elixir-ls/language_server.sh"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-visual-line-mode t)
 '(package-selected-packages
   '(darktooth-theme projectile-phoenix quelpa-use-package use-package-quelpa comment-dwim-2 bundler exec-path-from-shell rspec-mode try diff-hl dotenv-mode multiple-cursors treemacs-magit yaml-mode move-text projectile-rails treemacs-projectile which-key projectile lsp-mode mentor whitespace-cleanup-mode magit smartparens company-ctags company ivy elixir-mode eglot)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Emacs
(require 'use-package)
(global-set-key [remap list-buffers] 'ibuffer)
(global-display-line-numbers-mode t)
(setq ring-bell-function 'ignore)

(tool-bar-mode -1)
(scroll-bar-mode -1)

;; UI
(use-package darktooth-theme
  :ensure t
  :init
  (load-theme 'darktooth t))

;; Bind global keymap
(global-set-key (kbd "M-;") 'comment-line)


;; Disable extra files
(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving
(setq require-final-newline t)

;; Clear Whitespace
(use-package whitespace-cleanup-mode
  :ensure t
  :hook (before-save . whitespace-cleanup)
  :config (global-whitespace-cleanup-mode))

;; Ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Load PATH
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (setq exec-path-from-shell-shell-name "/bin/zsh")
    (exec-path-from-shell-initialize))
    (exec-path-from-shell-copy-env "CHATGPT_KEY"))

;; Autocomplete
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;; Autopair
(require 'smartparens-config)
(use-package smartparens-mode
  :ensure smartparens
  :hook (prog-mode text-mode markdown-mode)
  :init
  (require 'smartparens-config))

;; LSP
(require 'lsp-mode)
(add-to-list 'exec-path "/home/zvlex/.asdf/shims/")
(setq lsp-ruby-executable "/home/zvlex/.asdf/shims/ruby-lsp")
(add-hook 'ruby-mode-hook #'lsp)

;; Project
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind-keymap
	 ("s-p" . projectile-command-map)
	 ("C-c p" . projectile-command-map)
  :config
  (setq projectile-switch-project-action #'projectile-treemacs)
  (defun projectile-treemacs ()
    (interactive)
    (projectile-dired)
    (treemacs)))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

;; Ruby
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

(use-package bundler
  :ensure t)

;; Elixir
(use-package quelpa-use-package
  :ensure t)

(use-package projectile-phoenix
  :ensure t
  :after projectile
  :bind-keymap
  ("C-c e" . projectile-phoenix-command-map)
  :quelpa (projectile-phoenix :fetcher github :repo "Auralcat/projectile-phoenix"))


(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package treemacs
  :ensure t
  :bind
  (:map global-map
	([f8] . treemacs))
  :config
  (progn
   (setq treemacs-is-never-other-window t)))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package move-text
  :ensure t
  :config (move-text-default-bindings))

(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'")

(use-package multiple-cursors
  :ensure t
  :bind (("C-c m c" . mc/edit-lines)
	 ("C-c m n" . mc/mark-next-like-this)
	 ("C-c m p" . mc/mark-previous-like-this)
	 ("C-c m a" . mc/mark-all-like-this)))

(use-package dotenv-mode
  :ensure t
  :mode (("\\.env\\..*\\'" . dotenv-mode)
	 ("\\.env\\'" . dotenv-mode)))

(use-package diff-hl
  :ensure t
  :hook ((after-init . global-diff-hl-mode)
	 (dired-mode . diff-hl-dired-mode)
	 (magit-pre-refresh-hook . diff-hl-magit-pre-refresh)
	 (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (diff-hl-flydiff-mode +1)
  (diff-hl-margin-mode +1))

(use-package try
  :ensure t)

(use-package gptel
  :ensure t
  :config
  (setq gptel-api-key (getenv "CHATGPT_KEY")))
