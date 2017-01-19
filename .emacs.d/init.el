(menu-bar-mode -1)

(add-to-list 'load-path "~/.emacs.d/lisp")
(load "php-mode")
(load "point-undo")

(require 'point-undo)
(define-key global-map [f5] 'point-undo)
(define-key global-map [f6] 'point-redo)
