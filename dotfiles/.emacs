(require 'package)
(add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/") t)
(package-initialize)

;; for personal scripts
(add-to-list 'load-path "~/.emacs.d/lisp")

;; tramp
(require 'tramp)
(setq tramp-default-method "scp")


(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


;; auto-update when files change from external forces
(global-auto-revert-mode t)

(setq shell-command-switch "-ci")
(global-set-key (kbd "M-!") 'async-shell-command)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(global-visual-line-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages (quote (ivy sokoban)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(truncate-lines t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :height 120)))))


;; key redefinition

(global-set-key (kbd "C-x w") 'global-visual-line-mode)



;; javascript

(setq-default js-indent-level 2)
