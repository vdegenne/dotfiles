;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(menu-bar-mode -1)
(ido-mode)
;; (ivy-mode)


(add-to-list 'load-path "~/.emacs.d/lisp")
(load "php-mode")
(load "point-undo")

;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . js-mode))


(require 'point-undo)
(define-key global-map [f5] 'point-undo)
(define-key global-map [f6] 'point-redo)

(global-auto-revert-mode t)

;; js indentation set to 2
(setq js-indent-level 2)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (ivy js2-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face))))
 '(font-lock-comment-face ((t (:foreground "color-52"))))
 '(ido-only-match ((t (:foreground "green"))))
 '(ido-subdir ((t (:foreground "cyan"))))
 '(isearch-fail ((t (:background "RosyBrown1" :foreground "black"))))
 '(lazy-highlight ((t (:background "paleturquoise" :foreground "black"))))
 '(region ((t (:background "color-23")))))
