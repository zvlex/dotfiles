(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;
;; Emacs
;;

(load-theme 'ample-flat t)

;; Font
(set-face-attribute 'default nil :height 125)

;; Set the font family to Source Code Pro
(set-face-attribute 'default nil :family "Source Code Pro")

;; Do not display scrollbar
(scroll-bar-mode -1)

;; Disable bell ring
(setq ring-bell-function 'ignore)

;; Disable extra files
(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving
(setq require-final-newline t)
(tool-bar-mode -1) ; Disable toolbar

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;;  Line numbers
(global-display-line-numbers-mode t)

;; Do not pause
(setq redisplay-dont-pause t)

;; Fix scroll
(pixel-scroll-precision-mode t)


;; Display column number
(column-number-mode 1)

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; 120 column indicator
(global-display-fill-column-indicator-mode 1)
(setq-default display-fill-column-indicator-column 120)

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

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

;; Autoreload changed file on disk
(global-auto-revert-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("07885feecd236e4ba3837e7ff15753d47694e1f9a8049400c114b3298285534e" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "2b501400e19b1dd09d8b3708cefcb5227fda580754051a24e8abf3aff0601f87" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(0blayout web-mode emmet-mode all-the-icons-install-fonts all-the-icons comment-dwim-2 neotree darktooth-theme ample-theme doom-themes nov pdf-tools mix yaml-mode elixir-ts-mode move-text string-inflection whitespace-cleanup-mode railscasts-theme railscasts-reloaded-theme pretty-speedbar diff-hl multiple-cursors elixir-mode rspec-mode projectile-rails bundler projectile-speedbar magit projectile try which-key smartparens company exec-path-from-shell go-mode sicp racket-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Help with keys
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Try any package
(use-package try
  :ensure t)

;; Load PATH
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (setq exec-path-from-shell-shell-name "/bin/zsh")
    (exec-path-from-shell-initialize)
    (let ((envs '("PATH" "DB_USERNAME" "DB_PASSWORD")))  ;; List your important env variables
      (exec-path-from-shell-copy-envs envs))))

;; Autocomplete
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-c m c" . mc/edit-lines)
	 ("C-c m n" . mc/mark-next-like-this)
	 ("C-c m p" . mc/mark-previous-like-this)
	 ("C-c m a" . mc/mark-all-like-this)))

;; Autopair
(use-package smartparens-mode
  :ensure smartparens
  :hook (prog-mode text-mode markdown-mode)
  :init
  (require 'smartparens-config))

;; Find file autocomplete (Ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-auto-merge-work-directories-length -1)
(ido-mode 1)

;;
;; Text manipulation
;;

;; Move lines
(use-package move-text
  :ensure t)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

(use-package comment-dwim-2
  :ensure t)
(global-set-key (kbd "M-;") 'comment-dwim-2)

;; Clear Whitespace
(use-package whitespace-cleanup-mode
  :ensure t
  :hook (before-save . whitespace-cleanup)
  :config (global-whitespace-cleanup-mode))

;; CamelCase, snake_case
(use-package string-inflection
  :ensure t
  :hook ((ruby-mode . (lambda () (local-set-key (kbd "C-c C-u") 'string-inflection-ruby-style-cycle)))
	 (elixir-mode . (lambda () (local-set-key (kbd "C-c C-u") 'string-inflection-elixir-style-cycle)))
	 (java-mode . (lambda () (local-set-key (kbd "C-c C-u") 'string-inflection-java-style-cycle)))
	 (python-mode . (lambda () (local-set-key (kbd "C-c C-u") 'string-inflection-python-style-cycle)))))

(global-set-key (kbd "C-c C-u") 'string-inflection-all-cycle)

;;
;;
;;



;; Git
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

;; Project
;; (use-package projectile-speedbar
;;   :ensure t)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("s-p" . projectile-command-map)
	      ("C-c p" . projectile-command-map)))

;; Neotree
(use-package neotree
  :ensure t)
(global-set-key (kbd "<f9>") 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; Icons
(use-package all-the-icons
  :if (display-graphic-p))
(setq all-the-icons-scale-factor 0.8)


;;
;; Programming Languages
;;

;; Golang
(use-package go-mode
  :ensure t
  :hook (go-mode . (lambda ()
		     (eglot-ensure)
		     (add-to-list 'eglot-server-programs '(go-mode . ("gopls")))
		     ;; Add gofmt before saving
		     (add-hook 'before-save-hook 'gofmt-before-save nil t))))

;; Ruby
(use-package ruby-mode
  :ensure t
  :hook (ruby-mode . (lambda ()
		       (eglot-ensure)
		       (add-to-list 'eglot-server-programs '((ruby-mode ruby-ts-mode) "ruby-lsp")))))
		     ;; (add-to-list 'eglot-server-programs '(ruby-mode . ("solargraph" "stdio"))))))

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

(add-hook 'after-init-hook 'inf-ruby-switch-setup)
(add-hook 'compilation-filter-hook 'inf-ruby-auto-enter) ;; auto enter binding.pry in rspec mode


;; Elixir
(use-package elixir-mode
  :ensure t)

(use-package elixir-ts-mode
  :ensure t)

(use-package heex-ts-mode
  :ensure t)

;; Highlights *.elixir2 as well
(add-to-list 'auto-mode-alist '("\\.elixir2\\'" . elixir-mode))

(use-package elixir-mode
  :ensure t
  :hook (elixir-mode . (lambda ()
		     (eglot-ensure)
		     (add-to-list 'eglot-server-programs `((elixir-ts-mode heex-ts-mode elixir-mode) . ("~/.emacs.d/pkg/elixir-ls/release/language_server.sh"))))))

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

;; Racket
(use-package racket-mode
  :ensure t
  :hook (racket-mode . (lambda ()
		     (eglot-ensure)
		     (add-to-list 'eglot-server-programs '(racket-mode . ("racket" "-l" "racket-langserver"))))))

;; Yaml
(use-package yaml-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))


;; Pdf
(use-package pdf-tools
  :ensure t
  :config
  ;; Initialize pdf-tools
  (pdf-tools-install))

;; Epub
(use-package nov
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))


;; Web mode
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


;; Emmet
(use-package emmet-mode
  :ensure t
  :hook (web-mode css-mode html-mode mhtml-mode)
  :bind (:map emmet-mode-keymap
	 ("C-c j" . emmet-expand-line))
  :config
  ;; Additional configuration, if needed
  )
