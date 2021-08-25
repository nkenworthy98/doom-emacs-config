;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
;; (setq user-full-name "Nick K"
;;       user-mail-address "xndt98@live.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Terminus" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'wheatgrass)
;; (setq doom-theme 'doom-acario-dark)
(setq doom-theme 'doom-homage-black)

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

;; Changes the splash image
(setq fancy-splash-image "~/Pictures/logos/emacs/emacs-logo.png")

(setq org-agenda-files '("~/.emacsOrgFiles/agenda/todo.org"))

;; This is for elfeed
;; https://develop.spacemacs.org/layers/+readers/elfeed/README.html#setup-feeds
;; Page for documentation on getting elfeed setup
;; (elfeed :variables rmh-elfeed-org-files (list "~/.emacsOrgFiles/private/elfeed1.org"))
(setq rmh-elfeed-org-files (list "~/.emacsOrgFiles/private/elfeed.org"))

(after! elfeed
  (setq elfeed-search-filter "@2-week-ago +yt"))

(defun elfeed-custom-minimize-cutoff ()
  "Change search filter to speed up time updating elfeed"
  (interactive)
  (setq elfeed-search-filter "@1-minute-ago +yt")
  (elfeed-search-update--force))

(defun elfeed-custom-default-filter ()
  "Change search filter to default"
  (interactive)
  (setq elfeed-search-filter "@2-weeks-ago +yt")
  (elfeed-search-update--force))

(add-hook 'elfeed-search-mode-hook
          (lambda ()
            (display-line-numbers-mode 1)))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "urlscan.sh")

;; Custom Keybindings
(map! :leader
      :desc "fd-dired in cwd"
      "s f" #'fd-dired)

(map! :leader
      :desc "rg in cwd"
      "s g" #'+ivy/project-search-from-cwd)

(map! :leader
      :desc "Open elfeed RSS reader"
      "o r" #'elfeed)

(map! :leader
      (:prefix-map ("v" . "vterm-programs")
       :desc "Run ncmpcpp in vterm" "m" #'vterm-run-ncmpcpp
       :desc "Run nnn in vterm" "n" #'vterm-run-nnn
       :desc "Run reflex-curses in vterm" "r" #'vterm-run-reflex-curses
       :desc "Run tuir in vterm" "t" #'vterm-run-tuir))

(map! :leader
      :desc "Insert current date into buffer"
      "i d" #'org-time-stamp)

(map! :leader
      :desc "org-capture"
      "x" #'org-capture)

(map! :map elfeed-search-mode-map
      :localleader
      :desc "Minimize Cutoff Filter" "m" #'elfeed-custom-minimize-cutoff
      :desc "Default Filter" "d" #'elfeed-custom-default-filter)

(map! :after evil-org
      :map evil-org-mode-map
      :m "[[" nil
      :m "]]" nil
      :m "[[" #'org-previous-visible-heading
      :m "]]" #'org-next-visible-heading)

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

(after! org
  (setq org-capture-templates
      '(
        ("t" "TODO")
        ("tp" "Personal TODO" entry (file+headline "~/.emacsOrgFiles/agenda/todo.org" "Personal")
         "* TODO %?\nSCHEDULED: %^t\n")
        ("ts" "School TODO" entry (file+headline "~/.emacsOrgFiles/agenda/todo.org" "School")
         "* TODO %?\nSCHEDULED: %^t\n")

        ("l" "Laptop file")
        ("ld" "Downloaded Programs" item (file+headline "~/.emacsOrgFiles/org/laptop.org" "Downloaded Programs")
         "%?\n + [ ] from AUR? \n")
        ("lm" "Music to add" entry (file+headline "~/.emacsOrgFiles/org/laptop.org" "Music")
         "* TODO %?\n" :empty-lines-after 1)
        ("ln" "New Section" entry (file "~/.emacsOrgFiles/org/laptop.org")
         "* %?\n" :empty-lines-after 1)

        ("H" "Testing more functionality" entry (file+headline "~/.emacsOrgFiles/org/testNote.org" "TestHeader")
         "* %? \n %a \n" :empty-lines 1)

        ("w" "Watch/Read Later" entry (file "~/.emacsOrgFiles/org/later.org")
         "* TODO %a %i\nSCHEDULED: %t")

        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a"))))

(require 'mu4e)
;; (require 'smtpmail)

(defvar my-mu4e-account-alist
  '(("xndt98-live"
     (mu4e-sent-folder "/xndt98-live/Sent")
     (mu4e-drafts-folder "/xndt98-live/Drafts")
     (mu4e-trash-folder "/xndt98-live/Trash")
     (mu4e-compose-signature
       (concat
         "Nick K\n"
         "test something\n"))
     (user-mail-address "xndt98@live.com")
     (smtpmail-default-smtp-server "smtp.office365.com")
     (smtpmail-smtp-server "smtp.office365.com")
     (smtpmail-local-domain "live.com")
     (smtpmail-smtp-user "xndt98")
     (smtpmail-smtp-service 587))
    ("acc2-domain"
     (mu4e-sent-folder "/acc2-domain/Sent")
     (mu4e-drafts-folder "/acc2-domain/Drafts")
     (mu4e-trash-folder "/acc2-domain/Trash")
     (mu4e-compose-signature
       (concat
         "Suzy Q\n"
         "acc2@domain.com\n"))
     (user-mail-address "acc2@domain.com")
     (smtpmail-default-smtp-server "smtp.domain.com")
     (smtpmail-smtp-server "smtp.domain.com")
     (smtpmail-smtp-user "acc2@domain.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))
    ("acc3-domain"
     (mu4e-sent-folder "/acc3-domain/Sent")
     (mu4e-drafts-folder "/acc3-domain/Drafts")
     (mu4e-trash-folder "/acc3-domain/Trash")
     (mu4e-compose-signature
       (concat
         "John Boy\n"
         "acc3@domain.com\n"))
     (user-mail-address "acc3@domain.com")
     (smtpmail-default-smtp-server "smtp.domain.com")
     (smtpmail-smtp-server "smtp.domain.com")
     (smtpmail-smtp-user "acc3@domain.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))))

;; (setq send-mail-function    'smtpmail-send-it
;;           user-mail-address  "xndt98@live.com"
;;           smtpmail-smtp-server  "smtp.office365.com"
;;           smtpmail-smtp-user  "xndt98"
;;           smtpmail-stream-type  'starttls
;;           smtpmail-smtp-service 587)

(setq ispell-dictionary "en")

(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance '("crypt"))

;; (setq org-crypt-key nil)
(setq org-crypt-key "xndt98@live.com")
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.

(setq auto-save-default nil)
;; Auto-saving does not cooperate with org-crypt.el: so you need to
;; turn it off if you plan to use org-crypt.el quite often.  Otherwise,
;; you'll get an (annoying) message each time you start Org.

;; To turn it off only locally, you can insert this:
;;
;; # -*- buffer-auto-save-file-name: nil; -*-

(setq perl-indent-level 2)

(add-hook! 'org-mode-hook
  (setq-local yas-indent-line 'fixed))

(setq yas-triggers-in-field t)

(after! org
  (add-to-list 'org-modules 'org-habit))
