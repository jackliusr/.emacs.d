;;; package -- summary
;;; Commentary:  my emacs init file
;;; Code:
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
                      async helm
                      simple-httpd js2-mode skewer-mode js2-refactor
                      web-mode
                      tern tern-auto-complete
                      ))

(package-initialize)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
(require 'cl)
(require 'evil)
(evil-mode 1)
(setq linum-format "%d ")
(global-linum-mode t)
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

(require 'helm-config)

(setq projectile-enable-caching t)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'js-mode-hook (lambda () (flycheck-mode t)))
;(add-hook 'css-mode-hook 'skewer-css-mode)
;(add-hook 'html-mode-hook 'skewer-html-mode)
(add-hook 'js-mode-hook (lambda () (tern-mode t )))
(eval-after-load 'tern 
  '(progn 
     (require 'tern-auto-complete)
     (tern-ac-setup )))
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode ))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
 (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
     ad-do-it))

(add-hook 'jsx-mode-hook (lambda () (tern-mode t)))
(flycheck-define-checker jsxhint-checker
  "A JSX syntax and style checker based on JSXHint."

  :command ("jsxhint" source)
  :error-patterns
  ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
  :modes (web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              ;; enable flycheck
              (flycheck-select-checker 'jsxhint-checker)
              (flycheck-mode))))
