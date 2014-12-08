;;; my emacs init file
(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milbox.net/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))


(defvar my-packages '(better-defaults paredit idle-highlight-mode ido-ubiquitous
                      find-file-in-project magit smex scpaste
                      yasnippet 
                      evil evil-surround evil-leader 
                      powerline-evil evil-leader evil-paredit evil-visualstar
                      evil-matchit evil-args  evil-nerd-commenter
                      flycheck
                     projectile multiple-cursors smartparens
                      simple-httpd js2-mode skewer-mode js2-refactor
                      ))

(package-initialize)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
(require 'cl)
(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-leader)
(global-evil-leader-mode)

(require 'evil-nerd-commenter)
(evilnc-default-hotkeys)

(require 'evil-matchit)
(global-evil-matchit-mode 1)


(require 'evil-args)
;; bind evil-args text objects
(define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
(define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

;; bind evil-forward/backward-args
(define-key evil-normal-state-map "L" 'evil-forward-arg)
(define-key evil-normal-state-map "H" 'evil-backward-arg)
(define-key evil-motion-state-map "L" 'evil-forward-arg)
(define-key evil-motion-state-map "H" 'evil-backward-arg)

;; bind evil-jump-out-args
(define-key evil-normal-state-map "K" 'evil-jump-out-args)



;;; yasnippet
;;; should be loaded before autu complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

(require 'flycheck)

(require 'projectile)
(projectile-global-mode)

(require 'js2-refactor)

(require 'smartparens)

(setq projectile-enable-caching t)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'js-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)
