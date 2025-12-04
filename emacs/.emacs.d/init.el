;; Require packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Load Emacs Org config file
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))

;; Meta
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons-dired ample-theme bundler comment-dwim-2 company
			 dashboard diff-hl elixir-mode emmet-mode
			 erlang eshell-syntax-highlighting
			 exec-path-from-shell go-mode magit
			 markdown-mode mix mode-icons move-text
			 multiple-cursors neotree nov org-bullets
			 pdf-tools projectile-rails racket-mode
			 rspec-mode smartparens string-inflection
			 toc-org try web-mode whitespace-cleanup-mode
			 yaml-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
