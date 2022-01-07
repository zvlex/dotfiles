;;; mix-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "mix" "mix.el" (0 0 0 0))
;;; Generated autoloads from mix.el

(autoload 'mix-compile "mix" "\
Run the mix compile command.
If PREFIX is non-nil, prompt for additional params.  See `mix--prompt`
IF USE-UMBRELLA-SUBPROJECTS is t, prompt for umbrells subproject.

\(fn &optional PREFIX USE-UMBRELLA-SUBPROJECTS)" t nil)

(autoload 'mix-test "mix" "\
Run the mix test command.
If PREFIX is non-nil, prompt for additional params.  See `mix--prompt`
IF USE-UMBRELLA-SUBPROJECTS is t, prompt for umbrells subproject.

\(fn &optional PREFIX USE-UMBRELLA-SUBPROJECTS)" t nil)

(autoload 'mix-test-current-buffer "mix" "\
Run the mix test for the current buffer.
If PREFIX is non-nil, prompt for additional params.  See `mix--prompt`.
IF USE-UMBRELLA-SUBPROJECTS is t, excutes a test from a subproject
where a file is located, otherwise starts from the umbrella root.

\(fn &optional PREFIX USE-UMBRELLA-SUBPROJECTS)" t nil)

(autoload 'mix-test-current-test "mix" "\
Run the mix test for the curret test.
If PREFIX is non-nil, prompt for additional params.  See `mix--prompt`.
IF USE-UMBRELLA-SUBPROJECTS is t, excutes a test from a subproject
where a test is located, otherwise starts from the umbrella root.

\(fn &optional PREFIX USE-UMBRELLA-SUBPROJECTS)" t nil)

(autoload 'mix-execute-task "mix" "\
Select and run mix task.
If PREFIX is non-nil, prompt for additional params.  See `mix--prompt`
IF USE-UMBRELLA-SUBPROJECTS is t, prompt for umbrells subproject to start a mix task from.

\(fn &optional PREFIX USE-UMBRELLA-SUBPROJECTS)" t nil)

(autoload 'mix-last-command "mix" "\
Execute the last mix task." t nil)

(autoload 'mix-minor-mode "mix" "\
Mix minor mode. Used to hold keybindings for mix-mode.
\\{mix-minor-mode-map}

If called interactively, enable mix minor mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mix" '("mix-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; mix-autoloads.el ends here
