;;; helm-font --- Font and ucs selection for Helm -*- lexical-binding: t -*-

;; Copyright (C) 2012 ~ 2015 Thierry Volpiatto <thierry.volpiatto@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'cl-lib)
(require 'helm)
(require 'helm-help)

(defvar helm-ucs-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map helm-map)
    (define-key map (kbd "<C-backspace>") 'helm-ucs-persistent-delete)
    (define-key map (kbd "<C-left>")      'helm-ucs-persistent-backward)
    (define-key map (kbd "<C-right>")     'helm-ucs-persistent-forward)
    (define-key map (kbd "<C-return>")    'helm-ucs-persistent-insert)
    map)
  "Keymap for `helm-ucs'.")


;;; Xfont selection
;;
;;
(defvar helm-xfonts-cache nil)
(defvar helm-previous-font nil)
(defvar helm-source-xfonts
  (helm-build-sync-source "X Fonts"
    :init (lambda ()
            (unless helm-xfonts-cache
              (setq helm-xfonts-cache
                    (x-list-fonts "*")))
            ;; Save current font so it can be restored in cleanup
            (setq helm-previous-font (cdr (assoc 'font (frame-parameters)))))
    :candidates 'helm-xfonts-cache
    :action '(("Copy font to kill ring" . (lambda (elm)
                                            (kill-new elm)))
              ("Set font" . (lambda (elm)
                              (kill-new elm)
                              (set-frame-font elm 'keep-size)
                              (message "Font copied to kill ring"))))
    :cleanup (lambda ()
               ;; Restore previous font
               (set-frame-font helm-previous-font 'keep-size))
    :persistent-action (lambda (new-font)
                         (set-frame-font new-font 'keep-size)
                         (kill-new new-font))
    :persistent-help "Preview font and copy to kill-ring"))

;;; ???????????? ???????????????????????? ????????????????????????????????????????
;;
;;
(defvar helm-ucs--max-len 0)
(defvar helm-ucs--names nil)
(defun helm-calculate-ucs-max-len ()
  "Calculate the length of longest `ucs-names' candidate."
  (cl-loop with count = 0
        for (n . v) in (ucs-names)
        for len = (length n)
        if (> len count)
        do (setq count len)
        finally return count))

(defun helm-ucs-init ()
  "Initialize an helm buffer with ucs symbols.
Only math* symbols are collected."
  (unless (> helm-ucs--max-len 0)
    (setq helm-ucs--max-len
          (helm-calculate-ucs-max-len)))
  (or helm-ucs--names
      (setq helm-ucs--names
            (cl-loop for (n . v) in (ucs-names)
                     for len = (length n)
                     for diff = (+ (- helm-ucs--max-len len) 2)
                     unless (string= "" n)
                     collect (format "%s:%s%c #x%x"
                                     n (make-string diff ? ) v v)))))

(defun helm-ucs-forward-char (_candidate)
  (with-helm-current-buffer
    (forward-char 1)))

(defun helm-ucs-backward-char (_candidate)
  (with-helm-current-buffer
    (forward-char -1)))

(defun helm-ucs-delete-backward (_candidate)
  (with-helm-current-buffer
    (delete-char -1)))

(defun helm-ucs-insert (candidate n)
  (with-helm-current-buffer
    (string-match "^\\([^:]+\\): +\\(.\\) \\(#x[a-f0-9]+\\)$" candidate)
    (insert (match-string n candidate))))

(defun helm-ucs-insert-name (candidate)
  (helm-ucs-insert candidate 1))

(defun helm-ucs-insert-char (candidate)
  (helm-ucs-insert candidate 2))

(defun helm-ucs-insert-code (candidate)
  (helm-ucs-insert candidate 3))

(defun helm-ucs-persistent-insert ()
  (interactive)
  (with-helm-alive-p
    (helm-attrset 'action-insert 'helm-ucs-insert-char)
    (helm-execute-persistent-action 'action-insert)))

(defun helm-ucs-persistent-forward ()
  (interactive)
  (with-helm-alive-p
    (helm-attrset 'action-forward 'helm-ucs-forward-char)
    (helm-execute-persistent-action 'action-forward)))

(defun helm-ucs-persistent-backward ()
  (interactive)
  (with-helm-alive-p
    (helm-attrset 'action-back 'helm-ucs-backward-char)
    (helm-execute-persistent-action 'action-back)))

(defun helm-ucs-persistent-delete ()
  (interactive)
  (with-helm-alive-p
    (helm-attrset 'action-delete 'helm-ucs-delete-backward)
    (helm-execute-persistent-action 'action-delete)))

(defvar helm-source-ucs
  (helm-build-in-buffer-source "Ucs names"
    :data #'helm-ucs-init
    :help-message 'helm-ucs-help-message
    :match-part (lambda (candidate) (car (split-string candidate ":")))
    :filtered-candidate-transformer
    (lambda (candidates _source) (sort candidates #'helm-generic-sort-fn))
    :action '(("Insert character" . helm-ucs-insert-char)
              ("Insert character name" . helm-ucs-insert-name)
              ("Insert character code in hex" . helm-ucs-insert-code)
              ("Forward char" . helm-ucs-forward-char)
              ("Backward char" . helm-ucs-backward-char)
              ("Delete char backward" . helm-ucs-delete-backward)))
  "Source for collecting `ucs-names' math symbols.")

;;;###autoload
(defun helm-select-xfont ()
  "Preconfigured `helm' to select Xfont."
  (interactive)
  (helm :sources 'helm-source-xfonts
        :buffer "*helm select xfont*"))

;;;###autoload
(defun helm-ucs ()
  "Preconfigured helm for `ucs-names' math symbols."
  (interactive)
  (helm :sources 'helm-source-ucs
        :keymap  helm-ucs-map))

(provide 'helm-font)

;; Local Variables:
;; byte-compile-warnings: (not cl-functions obsolete)
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:

;;; helm-font.el ends here
