;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "magit" "20251020.1946"
  "A Git porcelain inside Emacs."
  '((emacs         "28.1")
    (compat        "30.1")
    (cond-let      "0.1")
    (llama         "1.0")
    (magit-section "4.4")
    (seq           "2.24")
    (transient     "0.10")
    (with-editor   "3.4"))
  :url "https://github.com/magit/magit"
  :commit "d8bfab264b9e8ad4f25e8e2df8fbabf6e4e464dd"
  :revdesc "d8bfab264b9e"
  :keywords '("git" "tools" "vc")
  :authors '(("Marius Vollmer" . "marius.vollmer@gmail.com")
             ("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev"))
  :maintainers '(("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev")
                 ("Kyle Meyer" . "kyle@kyleam.com")))
