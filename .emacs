(menu-bar-mode -1) 
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(global-linum-mode t)

(add-to-list 'load-path "~/.emacs.d/lisp/cider-0.17.0")

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; orgmode stuff
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files '("~/org"))

(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ("melpa-stable" . "http://stable.melpa.org/packages/")))
(package-initialize)
;;;(package-refresh-contents) ;;use if getting use-package errors
(package-install 'use-package)

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(setq visible-bell t)

;; MAC fix below for clojure, but shouldn't hurt any other system.
(setenv "PATH"

        (concat

         (getenv "PATH") ":usr/local/bin"))

(setq exec-path (append exec-path '("/usr/local/bin")))

;;;;;;;;;;;;;;;;;;;;;;;;
;; BASIC KEY BINDINGS ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [f5] 'toggle-truncate-lines) ;; Linewrap?
(global-set-key [f6] 'global-hl-line-mode) ;; Highlight current line
(global-set-key [f7] 'linum-mode) ;; Line Numbers in margin
(global-set-key [C-f7] 'toggle-scroll-bar) ;; Toggle scroll bar 
(global-set-key [s-f11] 'toggle-frame-fullscreen)
(global-set-key (kbd "C-x C-d") 'dired) ;; so dired is both C-x C-d and C-x d
(global-set-key (kbd "C-x C-q") 'view-mode) ;; view mode
(global-set-key (kbd "M-C-;") 'comment-box)

(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;;;;
;; PACKAGE SETUP ;;
;;;;;;;;;;;;;;;;;;;
;; (use-package cider-hydra
;;   :ensure t)

(use-package clojure-mode
  :ensure t
  :config
  (defun my-clojure-mode-hook () 
    (highlight-phrase "TODO" 'web-mode-comment-keyword-face) 
    (yas-minor-mode 1))
  (add-hook 'clojure-mode-hook #'my-clojure-mode-hook))


(use-package company
  :ensure t
  :bind (("TAB" . company-indent-or-complete-common))
  :defer t
  :config
  (global-company-mode)
  (use-package "helm-company")
  (define-key company-mode-map (kbd "C-:") 'helm-company)
  (define-key company-active-map (kbd "C-:") 'helm-company)
  (setq company-idle-delay 0.3))

;; (use-package company-quickhelp
;;   :ensure pos-tip
;;   :config
;;   (company-quickhelp-mode 1)
;;   (setq company-quickhelp-delay 0.5))

(use-package dired-filter
  :ensure t)
(use-package dired-subtree
  :ensure t)
(use-package dired-narrow
  :ensure t
  :config 
  (bind-keys
   :map dired-mode-map
   ("C-c n" . dired-narrow)))

(use-package helm
  :ensure t
  :bind (("C-c h" . helm-command-prefix)
         ("M-y" . helm-show-kill-ring)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-mini)
         ("C-h z" . helm-resume)
         ("M-x" . helm-M-x))

  :config
  (use-package helm-config)
  (use-package helm-files)
  (use-package helm-grep)
  (global-unset-key (kbd "C-x c"))
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  (define-key helm-find-files-map (kbd "C-c x")  'helm-ff-run-open-file-with-default-tool)
  (define-key helm-find-files-map (kbd "C-c C-x")  'helm-ff-run-open-file-with-default-tool)
  (define-key helm-find-files-map (kbd "C-c X")  'helm-ff-run-open-file-externally)
  (define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
  (define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
  (define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  (setq helm-quick-update                     t ; do not display invisible candidates
      helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
  (helm-mode 1)
(eval-after-load "winner"
  '(progn 
    (add-to-list 'winner-boring-buffers "*helm M-x*")
    (add-to-list 'winner-boring-buffers "*helm mini*")
    (add-to-list 'winner-boring-buffers "*Helm Completions*")
    (add-to-list 'winner-boring-buffers "*Helm Find Files*")
    (add-to-list 'winner-boring-buffers "*helm mu*")
    (add-to-list 'winner-boring-buffers "*helm mu contacts*")
    (add-to-list 'winner-boring-buffers "*helm-mode-describe-variable*")
    (add-to-list 'winner-boring-buffers "*helm-mode-describe-function*"))))

(use-package hydra
  :ensure t
  :config
  
  (require 'windmove) ; also already added in my emacs-el
  (defun hydra-move-splitter-left (arg)
    "Move window splitter left."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'right))
        (shrink-window-horizontally arg)
      (enlarge-window-horizontally arg)))
  
  (defun hydra-move-splitter-right (arg)
    "Move window splitter right."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'right))
        (enlarge-window-horizontally arg)
      (shrink-window-horizontally arg)))
  
  (defun hydra-move-splitter-up (arg)
    "Move window splitter up."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'up))
        (enlarge-window arg)
      (shrink-window arg)))
  
  (defun hydra-move-splitter-down (arg)
    "Move window splitter down."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'up))
        (shrink-window arg)
      (enlarge-window arg)))
  
  
  (global-set-key [C-up] 'enlarge-window)
  (global-set-key [C-down] (lambda () (interactive)
                             (enlarge-window -1)))
  
  (bind-key* "C-M-o"
             (defhydra hydra-window ()
               "
Movement^^        ^Split^         ^Switch^		^Resize^
----------------------------------------------------------------
_h_ ←       	_v_ertical    	_b_uffer		_q_ X←
_j_ ↓        	_x_ horizontal	_f_ind files	_w_ X↓
_k_ ↑        	_z_ undo      	_a_ce 1		_e_ X↑
_l_ →        	_Z_ redo      	_s_wap		_r_ X→
_F_ollow		_D_lt Other   	_S_ave		max_i_mize
_SPC_ cancel	_o_nly this   	_d_elete	
_,_ Scroll←			_p_roject
_._ Scroll→
"
               ("h" windmove-left )
               ("C-h"  windmove-left )
               ("j" windmove-down )
               ("C-j"  windmove-down )
               ("k" windmove-up )
               ("C-k"  windmove-up )
               ("l" windmove-right )
               ("C-l"  windmove-right )
               ("q" hydra-move-splitter-left)
               ("C-q"  hydra-move-splitter-left)
               ("w" hydra-move-splitter-down)
               ("C-w"  hydra-move-splitter-down)
               ("e" hydra-move-splitter-up)
               ("C-e"  hydra-move-splitter-up)
               ("r" hydra-move-splitter-right)
               ("C-r"  hydra-move-splitter-right)
               ("b" helm-mini)
               ("C-b"  helm-mini)
               ("f" helm-find-files)
               ("C-f"  helm-find-files)
               ("p" helm-projectile)
               ("C-p"  helm-projectile)
               ("F" follow-mode)
               ("C-F"  follow-mode)
               ("a" hydra-ace-cmd)
               ("C-a"  hydra-ace-cmd)
               ("v" hydra-split-vertical)
               ("C-v"  hydra-split-vertical)
               ("x" hydra-split-horizontal)
               ("C-x"  hydra-split-horizontal)
               ("s" hydra-swap)
               ("C-s"  hydra-swap)
               ("S" save-buffer)
               ("C-S"  save-buffer)
               ("d" delete-window)
               ("C-d"  delete-window)
               ("D" hydra-del-window)
               ("C-D"  hydra-del-window)
               ("o" delete-other-windows)
               ("C-o"  delete-other-windows)
               ("i" ace-maximize-window)
               ("C-i"  ace-maximize-window)
               ("z" (progn
                      (winner-undo)
                      (setq this-command 'winner-undo)))
               ("C-z" (progn
                        (winner-undo)
                        (setq this-command 'winner-undo)))
               ("Z" winner-redo)
               ("C-Z"  winner-redo)
               ("SPC" nil)
               ("C-SPC"  nil)
               ("." scroll-left)
               ("," scroll-right)
               ))
  
  (global-set-key
   (kbd "M-g")
   (defhydra hydra-goto ()
     "Go To"
     ("g" goto-line "line") ; reserve for normal M-g g function (may be different in some modes)
     ("M-g" goto-line "line")
     ("TAB" move-to-column "col")
     ("a" ace-jump-mode "ace line")
     ("c" goto-char "char")
     ("n" next-error "next err")
     ("p" previous-error "prev err")
     ("r" anzu-query-replace "qrep")
     ("R" anzu-query-replace-regexp "rep regex")
     ("t" anzu-query-replace-at-cursor "rep cursor")
     ("T" anzu-query-replace-at-cursor-thing "rep cursor thing")
     ("," scroll-right "scroll leftward")
     ("." scroll-left "scroll rightward")
     ("[" backward-page "back page")
     ("]" forward-page "forward page")
     ("SPC" nil "cancel")
     )))

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer))
  :config (autoload 'ibuffer "ibuffer" "List buffers." t))

(use-package ivy
  :ensure t)

(use-package magit
  :ensure t
  :config
  (global-magit-file-mode)
  (global-set-key "\C-xg" 'magit-status)
  (setq magit-diff-use-overlays nil))



(use-package smartparens-config
  :ensure smartparens
  :demand t
  :config
  (show-smartparens-global-mode)
  (sp-use-paredit-bindings)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-smartparens-strict-mode)
  (add-hook 'clojure-mode-hook 'turn-on-smartparens-strict-mode)
  (add-hook 'cider-repl-mode-hook #'turn-on-smartparens-strict-mode)
  (bind-keys
   :map smartparens-strict-mode-map
   (";" . sp-comment)
   ("M-f" . sp-forward-symbol)
   ("M-b" . sp-backward-symbol)
   ("M-a" . sp-beginning-of-sexp)
   ("M-e" . sp-end-of-sexp)))

(use-package paren
  :config
  (show-paren-mode 1))

(use-package projectile
  :ensure t
  :config
  (use-package helm-projectile :ensure t)
  (projectile-global-mode)
  (setq projectile-completion-system 'helm
        projectile-switch-project-action 'helm-projectile)
  (define-key projectile-command-map (kbd "s g") 'helm-projectile-grep))

(use-package rainbow-mode
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package rainbow-identifiers
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-identifiers-mode))

(use-package rainbow-mode
  :ensure t)

(use-package recentf
  :ensure t
  :bind (("C-x C-r" . recentf-open-files))
  :config
  (setq recentf-max-menu-items 100)
  (recentf-mode 1))

(use-package spacemacs-common
  :ensure spacemacs-theme
  :config
  (load-theme 'spacemacs-dark t))


(use-package windmove
  :ensure t
  :config
  (setq windmove-default-keybindings t)
  (setq max-specpdl-size 10000))

(use-package yasnippet
  :ensure t
  :config
  (use-package clojure-snippets :ensure t)
  (yas-global-mode))

(use-package cider
  ;:ensure t
  :config
  (setq cider-repl-use-clojure-font-lock t
        cider-font-lock-dynamically '(macro core function var))
  (cider-repl-toggle-pretty-printing)
  (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")
  (defun figwheel-connect ()
    (interactive)
    (cider-connect "localhost" "7002")))

(use-package undo-tree
  :ensure t
  :delight undo-tree-mode
  :bind (("C-x /" . undo-tree-visualize))
  :config
  (global-undo-tree-mode t)
  )

(use-package which-key
  :ensure t
  :config
  (which-key-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (darcula)))
 '(custom-safe-themes
   (quote
    ("cd4d1a0656fee24dc062b997f54d6f9b7da8f6dc8053ac858f15820f9a04a679" "7d2e7a9a7944fbde74be3e133fc607f59fdbbab798d13bd7a05e38d35ce0db8d" "c856158cc996d52e2f48190b02f6b6f26b7a9abd5fea0c6ffca6740a1003b333" "ef98b560dcbd6af86fbe7fd15d56454f3e6046a3a0abd25314cfaaefd3744a9e" "a5956ec25b719bf325e847864e16578c61d8af3e8a3d95f60f9040d02497e408" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "8eafb06bf98f69bfb86f0bfcbe773b44b465d234d4b95ed7fa882c99d365ebfd" "62c81ae32320ceff5228edceeaa6895c029cc8f43c8c98a023f91b5b339d633f" "f27c3fcfb19bf38892bc6e72d0046af7a1ded81f54435f9d4d09b3bff9c52fc1" "1d0ee3d14476f29dc12e3ed9803c4a634ed8f375d2b160e7eae24fe71c324083" "3d5307e5d6eb221ce17b0c952aa4cf65dbb3fa4a360e12a71e03aab78e0176c5" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "021720af46e6e78e2be7875b2b5b05344f4e21fad70d17af7acfd6922386b61e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "6ee6f99dc6219b65f67e04149c79ea316ca4bcd769a9e904030d38908fd7ccf9" "ed0b4fc082715fc1d6a547650752cd8ec76c400ef72eb159543db1770a27caa7" "3fa81193ab414a4d54cde427c2662337c2cab5dd4eb17ffff0d90bca97581eb6" "42b9d85321f5a152a6aef0cc8173e701f572175d6711361955ecfb4943fe93af" default)))
 '(fci-rule-color "#424748")
 '(highlight-changes-colors (quote ("#ff8eff" "#ab7eff")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#424748" . 0)
     ("#63de5d" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#424748" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(magit-diff-use-overlays nil t)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-agenda-files
   (quote
    ("/Users/s33r/org/work.org" "/Users/s33r/org/todo.org")))
 '(package-selected-packages
   (quote
    (darcula-theme color-theme-solarized color-theme-zenburn color-theme-molokai color-theme-monokai ubuntu-theme night-owl-theme solarized-theme darkokai-theme gruvbox-theme helm-company company-quickhelp which-key undo-tree clojure-snippets yasnippet spacemacs-theme rainbow-identifiers rainbow-delimiters rainbow-mode helm-projectile projectile smartparens pos-tip magit ivy helm dired-narrow dired-subtree dired-filter company use-package)))
 '(pos-tip-background-color "#E6DB74")
 '(pos-tip-foreground-color "#242728")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#ff0066")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#63de5d")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#53f2dc")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#06d8ff"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#242728" "#424748" "#F70057" "#ff0066" "#86C30D" "#63de5d" "#BEB244" "#E6DB74" "#40CAE4" "#06d8ff" "#FF61FF" "#ff8eff" "#00b2ac" "#53f2dc" "#f8fbfc" "#ffffff"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


