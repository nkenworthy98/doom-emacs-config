;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Nick K"
      user-mail-address "xndt98@live.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "xos4 Terminus" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'wheatgrass)
(setq doom-theme 'doom-acario-dark)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/.emacsOrgFiles/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(setq org-agenda-files '("~/.emacsOrgFiles/agenda/todo.org"))

;; This is for elfeed
;; https://develop.spacemacs.org/layers/+readers/elfeed/README.html#setup-feeds
;; Page for documentation on getting elfeed setup
;; (elfeed :variables rmh-elfeed-org-files (list "~/.emacsOrgFiles/private/elfeed1.org"))
(setq rmh-elfeed-org-files (list "~/.emacsOrgFiles/private/elfeed.org"))

;; This is to watch mpv in elfeed
;; It calls urlscanScript from ~/bin
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "urlscanScript.sh")

;; Custom Keybindings
(map! :leader
      :desc "fd-dired in cwd"
      "s f" #'fd-dired)

(map! :leader
      :desc "rg in cwd"
      "s g" #'+ivy/project-search-from-cwd)

(map! :mode html-mode
      :leader
      :localleader
      :desc "HTML links"
      "t" #'html-custom-insert-ahref)

(map! :leader
      :desc "Open elfeed RSS reader"
      "o r" #'elfeed)

(map! :leader
      :desc "Run ncmpcpp in vterm"
      "v m" #'vterm-run-ncmpcpp)

(map! :leader
      :desc "Run nnn in vterm"
      "v n" #'vterm-run-nnn)

(map! :leader
      :desc "Run reflex-curses in vterm"
      "v r" #'vterm-run-reflex-curses)

(map! :leader
      :desc "Run tuir in vterm"
      "v t" #'vterm-run-tuir)

(map! :leader
      :desc "Insert current date into buffer"
      "i d" #'org-time-stamp)

(fset 'test-macro-1
   (kmacro-lambda-form [?i ?< ?a ?  ?h ?r ?e ?f ?= ?\" ?\" escape ?x ?A ?> ?< ?/ ?a ?> escape ?h ?h ?h ?h ?h ?i escape ?l] 0 "%d"))

(fset 'html-custom-insert-ahref
   (kmacro-lambda-form [?A return ?< ?a ?h backspace ?  ?h ?r ?e ?d backspace ?f ?= ?\" ?\" backspace right right ?< ?/ ?a left left left left left] 0 "%d"))

(defun vterm-run-ncmpcpp ()
  "Run ncmpcpp in vterm"
  (interactive)
  (vterm-run-custom-command "ncmpcpp"))

(defun vterm-run-reflex-curses ()
  "Run reflex-curses in vterm"
  (interactive)
  (vterm-run-custom-command "reflex-curses"))

(defun vterm-run-nnn ()
  "Run nnn in vterm"
  (interactive)
  (vterm-run-custom-command "nnn"))

(defun vterm-run-tuir ()
  "Run tuir in vterm"
  (interactive)
  (vterm-run-custom-command "tuir"))

(defun vterm-run-custom-command (vterm-custom-command-name)
  "Run custom command in vterm"
  (interactive)
    (if (get-buffer vterm-custom-command-name)
        (switch-to-buffer vterm-custom-command-name)
      (+vterm/here 0)
      (rename-buffer vterm-custom-command-name)
      (vterm-send-string vterm-custom-command-name)
      (vterm-send-return)))

(defun test-check-buffer ()
    (if (get-buffer "*Messages*")
        (print "Buffer exists")
      (print "Buffer doesn't exist")))

;; (defun dired-do-encrypt-file ()
;; "Encrypt the group of marked files"
;; (interactive)
;; (dired-do-shell-command
;;  "gpg -r 'Nicholas Kenworthy' -e" current-prefix-arg
;;  (dired-get-marked-files t current-prefix-arg)))
;; (defun find-school-notes-org-files ()
;;   "Find org files under seniorYear recursively"
;;   (interactive)
;;   (doom-project-find-file "/home/nick/Documents/GU/SeniorYear/"))
