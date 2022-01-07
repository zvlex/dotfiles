(setq package-archives
  '(("gnu" . "http://elpa.gnu.org/packages/")
  ("melpa" . "https://melpa.org/packages/")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; turn bell off
(setq ring-bell-function
      (lambda ()
	(unless (memq this-command
		      '(isearch-abort abort-recursive-edit exit-minibuffer keyboard-quit))
	  (ding))
	))
(setq ring-bell-function 'ignore)

;;;;;;;;;;;;;
;; Plugins ;;
;;;;;;;;;;;;;

(require 'use-package)

;; Autopair
(require 'smartparens-config)
(use-package smartparens-mode
  :ensure smartparens
  :hook (prog-mode text-mode markdown-mode)
  :init
  (require 'smartparens-config)
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-git-gutter-mode t)
 '(package-selected-packages
   '(lsp-dart mmm-mode ag multiple-cursors expand-region diff-hl git-gutter-fringe git-gutter git-gutter-fringe+ magit mix treemacs-persp treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil treemacs dumb-jump darktooth-theme company eglot-jl eglot ivy projectile-rails projectile use-package smartparens lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;
(setq inhibit-startup-screen t)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)


;; Autocomplete
(add-hook 'after-init-hook 'global-company-mode)

;; Projectile
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(require 'eglot)

;; Ruby
(use-package eglot :ensure t)
(add-hook 'ruby-mode-hook 'eglot-ensure)

;; Elixir
(require 'elixir-mode)

(add-hook 'elixir-mode-hook
		(lambda () (add-hook 'before-save-hook 'elixir-format nil t)))

(add-to-list 'auto-mode-alist '("\\.elixir2\\'" . elixir-mode))

;; EEx
(require 'mmm-mode)

(require 'mmm-defaults)

(setq mmm-global-mode 'auto
      mmm-submode-decoration-level 0
      mmm-parse-when-idle t)


(add-to-list 'auto-mode-alist '("\\.html.eex\\'" . mhtml-mode))
(add-to-list 'auto-mode-alist '("\\.html.leex\\'" . mhtml-mode))

(mmm-add-classes
 '((eex-elixir
    :submode elixir-mode
    :face mmm-declaration-submode-face
    :front "<%[#=%]*" ;; regex to find the opening tag
    :back "%>"))) ;; regex to find the closing tag

(mmm-add-mode-ext-class 'mhtml-mode nil 'eex-elixir)


;; Projectile Phoenix
(add-to-list 'load-path "~/.emacs.d/plugins/projectile-phoenix")

(require 'projectile-phoenix)

(define-key projectile-phoenix-mode-map (kbd "C-c e") 'projectile-phoenix-command-map)

(projectile-phoenix-global-mode)

;; Mix
(use-package mix
  :config
  (add-hook 'elixir-mode-hook 'mix-minor-mode))

(eval-after-load "elixir-mode"
  '(defun elixir-format--mix-executable ()
     (string-trim-right (shell-command-to-string "asdf which mix"))))


;; Projectile
(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-completion-system 'ivy)

;; Rails
(require 'projectile-rails)
(projectile-rails-global-mode)
(define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)


(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))


;; Themes
(load-theme 'darktooth t)
(add-to-list 'default-frame-alist '(font . "Source Code Pro 12"))



;; Git
(global-diff-hl-mode)
(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)


;; Appearance
(menu-bar-mode 1)
(tool-bar-mode -1)
(global-display-line-numbers-mode)
(scroll-bar-mode -1)
(setq-default frame-title-format '(buffer-file-name "%b"))

;; Enable the www ligature in every possible major mode
;; (ligature-set-ligatures 't '("www"))

;; Enable ligatures in programming modes
;;(ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
;;                                     ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
;;                                     "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
;;                                     "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
;;                                     "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
;;                                     "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
;;                                     "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
;;                                     "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
;;                                     "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
;;                                    "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))

;;(global-ligature-mode 't)


;; Disable extra files
(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving
(setq require-final-newline t)

;; Clear Whitespace
(require 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Load bundle
(if (not (getenv "TERM_PROGRAM"))
    (setenv "PATH"
	    (shell-command-to-string "source $HOME/.zshrc && printf $PATH")))

;; Global reload and reread files from disk
(global-auto-revert-mode)

;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
	  treemacs-deferred-git-apply-delay        0.5
	  treemacs-directory-name-transformer      #'identity
	  treemacs-display-in-side-window          t
	  treemacs-eldoc-display                   t
	  treemacs-file-event-delay                5000
	  treemacs-file-extension-regex            treemacs-last-period-regex-value
	  treemacs-file-follow-delay               0.2
	  treemacs-file-name-transformer           #'identity
	  treemacs-follow-after-init               t
	  treemacs-expand-after-init               t
	  treemacs-git-command-pipe                ""
	  treemacs-goto-tag-strategy               'refetch-index
	  treemacs-indentation                     2
	  treemacs-indentation-string              " "
	  treemacs-is-never-other-window           nil
	  treemacs-max-git-entries                 5000
	  treemacs-missing-project-action          'ask
	  treemacs-move-forward-on-expand          nil
	  treemacs-no-png-images                   nil
	  treemacs-no-delete-other-windows         t
	  treemacs-project-follow-cleanup          nil
	  treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
	  treemacs-position                        'left
	  treemacs-read-string-input               'from-child-frame
	  treemacs-recenter-distance               0.1
	  treemacs-recenter-after-file-follow      nil
	  treemacs-recenter-after-tag-follow       nil
	  treemacs-recenter-after-project-jump     'always
	  treemacs-recenter-after-project-expand   'on-distance
	  treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
	  treemacs-show-cursor                     nil
	  treemacs-show-hidden-files               t
	  treemacs-silent-filewatch                nil
	  treemacs-silent-refresh                  nil
	  treemacs-sorting                         'alphabetic-asc
	  treemacs-select-when-already-in-treemacs 'move-back
	  treemacs-space-between-root-nodes        t
	  treemacs-tag-follow-cleanup              t
	  treemacs-tag-follow-delay                1.5
	  treemacs-user-mode-line-format           nil
	  treemacs-user-header-line-format         nil
	  treemacs-width                           35
	  treemacs-width-is-initially-locked       t
	  treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (pcase (cons (not (null (executable-find "git")))
		 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
	("M-0"       . treemacs-select-window)
	("C-x t 1"   . treemacs-delete-other-windows)
	("C-x t t"   . treemacs)
	("C-x t B"   . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :after (treemacs dired)
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))


;; Elixir LSP
(add-to-list
 'eglot-server-programs
 '(elixir-mode . ("sh" "~/.emacs.d/plugins/elixir-ls/language_server.sh")))

(use-package lsp-mode
    :commands lsp
    ensure t
    :diminish lsp-mode
    :hook
    (elixir-mode . lsp)
    :init
    (add-to-list 'exec-path "~/.emacs.d/plugins/elixir-ls"))

;;;;;;;;;;;;;;
;; Keyboard ;;
;;;;;;;;;;;;;;
(global-set-key (kbd "C-`") 'term)

(global-set-key (kbd "C-c <left>")  'windmove-left)
(g`lobal-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Multiple Cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
