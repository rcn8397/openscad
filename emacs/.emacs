(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Load custom elisp packages
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Load scad package
(load "scad-mode")
(require 'scad-preview)

;; setup files ending in “.scad” to open in scad-mode
(add-to-list 'auto-mode-alist '("\\.scad\\'" . scad-mode))
