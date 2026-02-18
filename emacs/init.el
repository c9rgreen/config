;; Disable toolbar
(tool-bar-mode -1)

;; Right-click context menu
(context-menu-mode 1)

;; Font
(set-face-attribute 'default nil :family "Aporetic Sans Mono" :height 140)

;; Theme - follow macOS dark mode
(defun cg/apply-theme ()
  (mapc #'disable-theme custom-enabled-themes)
  (if (string-match-p "Dark"
        (shell-command-to-string "defaults read -g AppleInterfaceStyle 2>/dev/null"))
      (load-theme 'modus-vivendi t)
    (load-theme 'modus-operandi t)))

(cg/apply-theme)

(when (boundp 'ns-system-appearance-change-functions)
  (add-hook 'ns-system-appearance-change-functions
            (lambda (_) (cg/apply-theme))))

;; Package setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install packages
(dolist (pkg '(magit vertico orderless consult marginalia evil evil-collection markdown-mode))
  (unless (package-installed-p pkg)
    (package-refresh-contents)
    (package-install pkg)))

;; Evil - vi keybindings
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)
(evil-collection-init)

;; Vertico - vertical completion UI
(vertico-mode)

;; Orderless - fuzzy matching
(setq completion-styles '(orderless basic))

;; Consult - enhanced search and navigation
(global-set-key (kbd "C-x b") #'consult-buffer)
(global-set-key (kbd "C-x C-r") #'consult-recent-file)

;; Markdown
(setq markdown-header-scaling t)

;; Marginalia - annotations in the minibuffer
(marginalia-mode)

;; Auto-revert - reload files when changed on disk
(global-auto-revert-mode 1)
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
