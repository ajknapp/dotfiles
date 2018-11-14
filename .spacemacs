;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;;; TTY Key hacks
;;; The translations with the settings below fit the adjustments to the key table.

;; (add-to-load-path "~/.emacs.d/elpa/xelb-0.14")
;; (add-to-load-path "~/.emacs.d/elpa/exwm-0.18")

;; (require 'exwm)
;; (require 'exwm-config)

(defun my-exwm-config ()
  "My configuration of EXWM."
  ;; Set the initial workspace number.
  (setq exwm-workspace-number 4)
  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (exwm-workspace-rename-buffer exwm-class-name)))
  ;; 's-r': Reset
  (exwm-input-set-key (kbd "s-r") #'exwm-reset)
  ;; 's-w': Switch workspace
  (exwm-input-set-key (kbd "s-w") #'exwm-workspace-switch)
  ;; 's-N': Switch to certain workspace
  (dotimes (i 10)
    (exwm-input-set-key (kbd (format "s-%d" i))
                        `(lambda ()
                           (interactive)
                           (exwm-workspace-switch-create ,i))))
  ;; 's-&': Launch application
  (exwm-input-set-key (kbd "s-&")
                      (lambda (command)
                        (interactive (list (read-shell-command "$ ")))
                        (start-process-shell-command command nil command)))
  ;; 's-j': move window down
  (exwm-input-set-key (kbd "s-j") #'evil-window-down)
  ;; 's-k': move window up
  (exwm-input-set-key (kbd "s-k") #'evil-window-up)
  ;; 's-h': move window left
  (exwm-input-set-key (kbd "s-h") #'evil-window-left)
  ;; 's-l': move window right
  (exwm-input-set-key (kbd "s-l") #'evil-window-right)
  ;; 's-SPC': activate buffer list
  (exwm-input-set-key (kbd "s-SPC") #'helm-mini)
  ;; Line-editing shortcuts
  (exwm-input-set-simulation-keys nil
   ;; '(([?\C-b] . left)
   ;;   ([?\C-f] . right)
   ;;   ([?\C-p] . up)
   ;;   ([?\C-n] . down)
   ;;   ([?\C-a] . home)
   ;;   ([?\C-e] . end)
   ;;   ([?\M-v] . prior)
   ;;   ([?\C-v] . next)
   ;;   ([?\C-d] . delete)
   ;;   ([?\C-k] . (S-end delete)))
   )
  ;; Enable EXWM
  (exwm-enable)
  ;; Configure Ido
  (exwm-config-ido)
  ;; Other configurations
  (exwm-config-misc))

;; (my-exwm-config)

(define-key input-decode-map "\e[25~" [(f13)])
(define-key input-decode-map "\e[26~" [(f14)])
(define-key input-decode-map "\e[28~" [(f15)])
(define-key input-decode-map "\e[29~" [(f16)])
(define-key input-decode-map "\e[31~" [(f17)])
(define-key input-decode-map "\e[32~" [(f18)])
(define-key input-decode-map "\e[33~" [(f19)])
(define-key input-decode-map "\e[34~" [(f20)])
(define-key input-decode-map "\e[35~" [(f21)])
(define-key input-decode-map "\e[36~" [(f22)])
(define-key input-decode-map "\e[37~" [(f23)])
(define-key input-decode-map "\e[38~" [(f24)])
(define-key input-decode-map "\e[39~" [(f25)])
(define-key input-decode-map "\e[40~" [(f26)])
(define-key input-decode-map "\e[41~" [(f27)])
(define-key input-decode-map "\e[42~" [(f28)])
(define-key input-decode-map "\e[43~" [(f29)])
(define-key input-decode-map "\e[44~" [(f30)])
(define-key input-decode-map "\e[45~" [(f31)])
(define-key input-decode-map "\e[46~" [(f32)])
(define-key input-decode-map "\e[47~" [(f33)])
(define-key input-decode-map "\e[48~" [(f34)])
(define-key input-decode-map "\e[49~" [(f35)])
(define-key input-decode-map "\e[50~" [(f36)])
(define-key input-decode-map "\e[51~" [(f37)])
(define-key input-decode-map "\e[52~" [(f38)])
(define-key input-decode-map "\e[53~" [(f39)])
(define-key input-decode-map "\e[54~" [(f40)])


(define-key key-translation-map (kbd "<f13>") (kbd "<C-return>"))
(define-key key-translation-map (kbd "<f14>") (kbd "<C-S-return>"))
(define-key key-translation-map (kbd "<f15>") (kbd "<M-S-return>"))

(define-key key-translation-map (kbd "<f16>") (kbd "M-S-<left>"))
(define-key key-translation-map (kbd "<f17>") (kbd "M-S-<right>"))
(define-key key-translation-map (kbd "<f18>") (kbd "M-S-<up>"))
(define-key key-translation-map (kbd "<f19>") (kbd "M-S-<down>"))

(define-key key-translation-map (kbd "<f20>") (kbd "M-<left>"))
(define-key key-translation-map (kbd "<f21>") (kbd "M-<right>"))
(define-key key-translation-map (kbd "<f22>") (kbd "M-<up>"))
(define-key key-translation-map (kbd "<f23>") (kbd "M-<down>"))

(define-key key-translation-map (kbd "<f24>") (kbd "C-<left>"))
(define-key key-translation-map (kbd "<f25>") (kbd "C-<right>"))
(define-key key-translation-map (kbd "<f26>") (kbd "C-<up>"))
(define-key key-translation-map (kbd "<f27>") (kbd "C-<down>"))

(define-key key-translation-map (kbd "<f28>") (kbd "S-<left>"))
(define-key key-translation-map (kbd "<f29>") (kbd "S-<right>"))
(define-key key-translation-map (kbd "<f30>") (kbd "S-<up>"))
(define-key key-translation-map (kbd "<f31>") (kbd "S-<down>"))

(define-key key-translation-map (kbd "<f32>") (kbd "C-S-<left>"))
(define-key key-translation-map (kbd "<f33>") (kbd "C-S-<right>"))
(define-key key-translation-map (kbd "<f34>") (kbd "C-S-<up>"))
(define-key key-translation-map (kbd "<f35>") (kbd "C-S-<down>"))

(define-key key-translation-map (kbd "<f36>") (kbd "<backtab>"))

(define-key key-translation-map (kbd "<f37>") (kbd "S-<return>"))

(setq user-full-name "Andy Knapp")

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     (ocaml :variables tuareg-support-metaocaml t)
     (haskell :variables haskell-completion-backend 'intero)
     rust
     html
     yaml
     d
     javascript
     sml
     csv
     octave
     python
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     ;; better-defaults
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            ;; c-c++-enable-clang-support t
            ;; flycheck-clang-args '("-std=c++14")
            ;; flycheck-gcc-args '("-std=c++14")
            )
     common-lisp
     cscope
     emacs-lisp
     ess
     ;; fancy-cpp
     git
     java
     latex
     lua
     markdown
     (org :variables
          org-log-into-drawer t
          org-projectile-file "PROJECT.org")
     semantic
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages
   '(
     ;; exwm-x
     google-c-style
     j-mode
     ob-sagemath
     polymode
     rtags
     flycheck-rtags
     flycheck-ocaml
     org-plus-contrib
     )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(org-bullets)
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         zenburn
                         spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         monokai
                         leuven
                         )
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Consolas"
                               :size 24
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to miminimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols nil
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Turn off comment highlighting for spacemacs themes.
   spacemacs-theme-comment-bg nil
   ;; Deactivate org headline sizes
   spacemacs-theme-org-height nil
   ;; Deactivate annoying neotree pictures
   neo-theme 'arrow
   ;; Use avy only in current window
   avy-all-windows nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put any
user code."
  (unless window-system
    (load "term/xterm")
    (unless (terminal-coding-system)
      (set-terminal-coding-system 'utf-8-unix))
    (tty-no-underline)
    (ignore-errors
      (when gpm-mouse-mode
	      (require 't-mouse)
	      (gpm-mouse-enable)))
    (xterm-register-default-colors xterm-standard-colors))

  ;; d mode
  (defun flycheck-dmd-dub-set-include-path ())

  (setq-default c-doc-comment-style
                '((java-mode . javadoc)
                  (pike-mode . autodoc)
                  (c-mode    . gtkdoc)
                  ;; (d-mode    . doxygen)
                  ))

  ;; haskell mode
  ;; (with-eval-after-load 'intero
  ;;   (flycheck-add-next-checker 'intero '(warning . haskell-hlint)))

  ;; (with-eval-after-load 'merlin
  ;;   ;; Disable Merlin's own error checking
  ;;   (setq merlin-error-after-save nil)
  ;;   ;; Enable Flycheck checker
  ;;   (flycheck-ocaml-setup))


  ;; latex mode
  (setq TeX-view-program-selection '((output-pdf "Zathura")
                                     ((output-dvi has-no-display-manager) "dvi2tty")
                                     ((output-dvi style-pstricks) "dvips and gv")
                                     (output-dvi "xdvi")
                                     (output-pdf "Evince")
                                     (output-html "xdg-open")))
  (setq TeX-view-program-list '(("Zathura"
                                 ("zathura "
                                  (mode-io-correlate " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\" ")
                                  " %o")
                                 "zathura")))

  (setq org-drill-add-random-noise-to-intervals-p t)
  (setq org-structure-template-alist '(
                                       ("P" ":PROPERTIES:\n?\n:END:")
                                       ("s" "#+BEGIN_SRC ?\n\n#+END_SRC")
                                       ("e" "#+BEGIN_EXAMPLE\n?\n#+END_EXAMPLE")
                                       ("q" "#+BEGIN_QUOTE\n?\n#+END_QUOTE")
                                       ("v" "#+BEGIN_VERSE\n?\n#+END_VERSE")
                                       ("V" "#+BEGIN_VERBATIM\n?\n#+END_VERBATIM")
                                       ("c" "#+BEGIN_CENTER\n?\n#+END_CENTER")
                                       ("l" "#+BEGIN_LaTeX\n?\n#+END_LaTeX")
                                       ("L" "#+LaTeX: ")
                                       ("h" "#+BEGIN_HTML\n?\n#+END_HTML")
                                       ("H" "#+HTML: ")
                                       ("a" "#+BEGIN_ASCII\n?\n#+END_ASCII")
                                       ("A" "#+ASCII: ")
                                       ("i" "#+INDEX: ?")
                                       ("I" "#+INCLUDE: %file ?")
                                       ("p" "#+BEGIN_problem\n\n#+END_problem")
                                       ("f" "#+BEGIN_proof\n\n#+END_proof")))
  (load "~/.spacemacs-latex-export")
  (setq org-drill-spaced-repetition-algorithm 'simple8)
  (setq font-latex-fontify-sectioning 'color)
  (setq font-latex-fontify-script nil)

  (defun auto-publish-blog-hook ()
    "Auto publish blog on save"
    ;; check if saved file is part of blog
    (if (org-publish-get-project-from-filename
         (buffer-file-name (buffer-base-buffer)) 'up)
        (save-excursion (org-publish-current-file)
                        (message "auto published blog") nil)))

  ;; Enable auto-publish when a org file in blog is saved
  (add-hook 'org-mode-hook
            (lambda ()
              (add-hook 'after-save-hook 'auto-publish-blog-hook nil nil)))

  ;; haskell mode
  ;; (push "-fshow-loaded-modules" haskell-process-args-ghci)

  ;; j mode
  (setq j-console-cmd "/usr/lib/j8/bin/jconsole")

  (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                           ("marmalade" . "https://marmalade-repo.org/packages/")
                           ("melpa" . "https://melpa.org/packages/")))
)

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
 This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  ;; Make evil-mode up/down operate in screen lines instead of logical lines
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-motion-state-map "U" 'undo-tree-redo)
  ;; Also in visual mode
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)

  (require 'evil-magit)
  (require 'flycheck)
  (require 'projectile)
  (load-file "~/projects/ats-mode/ats.el")

  (defun ats-newline-val ()
    (interactive)
    (newline)
    (insert "val ")
    (indent-according-to-mode))

  (evil-define-key 'insert ats-mode-map (kbd "M-RET") 'ats-newline-val)
  (evil-define-key 'insert ats-mode-map (kbd "RET") 'newline-and-indent)

  (setq flycheck-d-dmd-executable "/usr/bin/ldc")
  (setq flycheck-dmd-args "-w")

  (projectile-register-project-type 'dub '("dub.json")
                                    :compile "dub build --compiler=ldc"
                                    :test "dub test --compiler=ldc")

  ;; (require 'polymode)
  ;; (require 'poly-noweb)

  ;; (defcustom pm-inner/noweb+ats
  ;;   (clone pm-inner/noweb :mode 'ats-mode)
  ;;   "Noweb innermode for ats"
  ;;   :group 'innermodes
  ;;   :type 'object)

  ;; (defcustom pm-poly/noweb+ats
  ;;   (clone pm-poly/noweb :innermode 'pm-inner/noweb+ats)
  ;;   "Noweb polymode for ats"
  ;;   :group 'polymodes
  ;;   :type 'object)

  ;; (define-polymode poly-noweb+ats-mode pm-poly/noweb+ats :lighter " PM-atsnw")

  ;; (add-to-list 'auto-mode-alist '("\\.ats.nw\\'" . poly-noweb+ats-mode))

)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eval-sexp-fu-flash ((t (:foreground "#8CD0D3" :weight bold))))
 '(eval-sexp-fu-flash-error ((t (:foreground "#CC9393" :weight bold)))))

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-org-rifle zenburn-theme yasnippet-snippets yapfify yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen utop use-package tuareg toml-mode toc-org tagedit symon string-inflection stickyfunc-enhance srefactor spaceline-all-the-icons solarized-theme smeargle slime-company slim-mode shell-pop scss-mode sass-mode restart-emacs rainbow-delimiters racer pyvenv pytest pyenv-mode py-isort pug-mode prettier-js polymode pippel pipenv pip-requirements persp-mode pcre2el password-generator paradox overseer orgit org-projectile org-present org-pomodoro org-mime org-download org-brain open-junk-file ocp-indent ob-sml ob-sagemath neotree nameless mvn multi-term move-text monokai-theme mmm-mode meghanada maven-test-mode markdown-toc magit-svn magit-gitflow lorem-ipsum livid-mode live-py-mode link-hint json-navigator json-mode js2-refactor js-doc j-mode intero indent-guide importmagic impatient-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-swoop helm-rtags helm-pydoc helm-purpose helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-git-grep helm-flx helm-descbinds helm-css-scss helm-cscope helm-company helm-c-yasnippet helm-ag haskell-snippets groovy-mode groovy-imports gradle-mode google-translate google-c-style golden-ratio gnuplot gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy font-lock+ flyspell-correct-helm flycheck-rust flycheck-rtags flycheck-pos-tip flycheck-ocaml flycheck-haskell flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu ess-R-data-view eshell-z eshell-prompt-extras esh-help ensime emmet-mode elisp-slime-nav editorconfig dumb-jump dotenv-mode doom-modeline disaster diminish diff-hl define-word dante d-mode cython-mode csv-mode counsel-projectile company-web company-tern company-statistics company-rtags company-lua company-ghci company-ghc company-emacs-eclim company-dcd company-cabal company-c-headers company-auctex company-anaconda common-lisp-snippets column-enforce-mode cmm-mode clean-aindent-mode clang-format centered-cursor-mode cargo browse-at-remote auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk aggressive-indent ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eval-sexp-fu-flash ((t (:foreground "#8CD0D3" :weight bold))))
 '(eval-sexp-fu-flash-error ((t (:foreground "#CC9393" :weight bold)))))
)
