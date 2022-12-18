;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "Nick K"
;;       user-mail-address "xndt98@live.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "Terminus" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-ir-black)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.emacsOrgFiles/org")
(setq org-roam-directory "~/.emacsOrgFiles/org/roam")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; org-agenda config
(setq org-agenda-files '("~/.emacsOrgFiles/agenda/todo.org"
                         "~/.emacsOrgFiles/agenda/habits.org"))

;; elfeed config
(setq rmh-elfeed-org-files (list "~/.emacsOrgFiles/private/elfeed.org"))

(after! elfeed
  (setq elfeed-search-filter "@1-minute-ago +yt"))

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

(defun elfeed-custom-radio-filter ()
  "Change search filter to radio"
  (interactive)
  (setq elfeed-search-filter "@2-weeks-ago +radio")
  (elfeed-search-update--force))

(add-hook 'elfeed-search-mode-hook
          (lambda ()
            (display-line-numbers-mode 1)))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "link-handler.pl")

;; custom keybindings
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
      :desc "Default Filter" "d" #'elfeed-custom-default-filter
      :desc "Radio Filter" "r" #'elfeed-custom-radio-filter)

;; custom functions
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

;; org-capture template config
(after! org
  (setq org-capture-templates
      '(
        ("t" "TODO")
        ("tp" "Personal TODO" entry (file+headline "~/.emacsOrgFiles/agenda/todo.org" "Personal")
         "* TODO %?\nSCHEDULED: %^t\n" :empty-lines-before 1)

        ("l" "Laptop file")
        ("lm" "Music to add" entry (file+headline "~/.emacsOrgFiles/org/laptop.org" "Music")
         "* TODO %?\n" :empty-lines-after 1)
        ("ln" "New Section" entry (file "~/.emacsOrgFiles/org/laptop.org")
         "* %?\n" :empty-lines-after 1)
        ("ld" "Downloaded Programs")
        ("ldd" "Default or Other Repo" entry (file+headline "~/.emacsOrgFiles/org/laptop.org" "Default Repo or Other")
         "* %?\n" :empty-lines-after 1)
        ("lda" "AUR" entry (file+headline "~/.emacsOrgFiles/org/laptop.org" "AUR")
         "* %?\n" :empty-lines-after 1)

        ("H" "Testing more functionality" entry (file+headline "~/.emacsOrgFiles/org/testNote.org" "TestHeader")
         "* %? \n %a \n" :empty-lines 1)

        ("w" "Watch/Read Later" entry (file "~/.emacsOrgFiles/org/later.org")
         "* TODO %a %i\nSCHEDULED: %t")

        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a"))))

(setq ispell-dictionary "en")

(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance '("crypt"))

;; (setq org-crypt-key nil)
(setq org-crypt-key "xndt98@live.com")

(setq auto-save-default nil)

;; (add-hook! 'org-mode-hook
;;   (setq-local yas-indent-line 'fixed))

(setq yas-triggers-in-field t)

(after! org
  (add-to-list 'org-modules 'org-habit))

(set-file-template! "\\.pl$" :trigger "__" :mode 'perl-mode)
