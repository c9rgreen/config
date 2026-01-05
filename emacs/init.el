;; Initialize the package system
(require 'package)

;; Add MELPA (Milkypostman's Emacs Lisp Package Archive) repository
;; This gives access to thousands of community packages beyond the built-in ones
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Initialize package contents (required before installing packages)
(package-initialize)

;; Install Evil mode if not already installed
(unless (package-installed-p 'evil)
  (package-refresh-contents)
  (package-install 'evil))

;; Install Magit if not already installed
(unless (package-installed-p 'magit)
  (package-refresh-contents)
  (package-install 'magit))

;; Install markdown-mode if not already installed
(unless (package-installed-p 'markdown-mode)
  (package-refresh-contents)
  (package-install 'markdown-mode))

;; Magit configuration
(require 'magit)

;; Enable automatic refresh of magit buffers when files change
(add-hook 'after-save-hook 'magit-after-save-refresh-status t)

;; Automatically refresh magit status buffer when Emacs gains focus
(add-hook 'focus-in-hook 'magit-refresh-all)

;; Enable file watching for automatic magit updates
;; This makes magit automatically update when files change outside Emacs
(setq magit-auto-revert-mode t)

;; Refresh magit buffers when files change on disk
(setq magit-refresh-status-buffer t)

;; Optional: Set the interval for checking file changes (in seconds)
;; Default is 4 seconds, you can adjust as needed
(setq auto-revert-interval 2)

;; Optional: Refresh magit buffers quietly without messages
(setq magit-refresh-verbose nil)

;; Enable Evil mode (vi keybindings)
(require 'evil)
(evil-mode 1)

;; Optional Evil configuration
;; Make C-u scroll up half page (like in vim)
(setq evil-want-C-u-scroll t)

;; Start in normal mode by default
(setq evil-default-state 'normal)

;; Make horizontal movement cross lines
(setq evil-cross-lines t)

;; Enable Fido mode - a lightweight alternative to Ivy/Helm for completion
;; Provides fuzzy matching in minibuffer for commands, files, etc.
(fido-mode 1)

;; Make Fido display completions vertically (one per line)
;; Easier to read than the default horizontal layout
(fido-vertical-mode 1)

;; Set default font to Monaspace Neon
(set-face-attribute 'default nil
                    :family "Monaspace Neon"
                    :height 130)

;; Set font for all frames
(add-to-list 'default-frame-alist
             '(font . "Monaspace Neon-13"))

;; Hide the toolbar
(tool-bar-mode -1)

;; Auto-revert files when they change on disk
(global-auto-revert-mode 1)

;; Also auto-revert buffers like dired
(setq global-auto-revert-non-file-buffers t)

;; Auto-revert without asking
(setq auto-revert-verbose nil)

;; Markdown mode configuration
(require 'markdown-mode)

;; Associate markdown-mode with .md, .markdown, and .mkd files
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mkd\\'" . markdown-mode))

;; Optional: Use GitHub Flavored Markdown mode for README.md files
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; Set markdown command (if you have markdown installed)
;; For macOS with homebrew: brew install markdown
;; For other systems, install pandoc or another markdown processor
(setq markdown-command "markdown")

;; Optional markdown-mode customizations
(setq markdown-enable-math t)           ; Enable LaTeX math support
(setq markdown-asymmetric-header t)     ; Prefer asymmetric headers (# Header #)
(setq markdown-italic-underscore t)     ; Use underscores for italic
(setq markdown-indent-on-enter t)       ; Automatically indent on enter
(setq markdown-follow-wiki-link-on-enter nil) ; Don't follow wiki links with enter

;; Optional: Enable live preview (requires markdown command to be set)
;; Use C-c C-c p to preview in browser
(setq markdown-live-preview-window-function 'markdown-live-preview-window-eww)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
