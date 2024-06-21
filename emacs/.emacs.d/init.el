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
   '(markdown-mode org-bullets toc-org yaml-mode whitespace-cleanup-mode which-key web-mode try string-inflection smartparens rspec-mode racket-mode projectile-rails pgmacs pg-el pg pdf-tools nov neotree multiple-cursors move-text mode-icons mix magit go-mode exec-path-from-shell erlang emmet-mode elixir-ts-mode elixir-mode diff-hl dashboard company comment-dwim-2 bundler ample-theme all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
