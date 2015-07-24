;;; package -- summary
;;; Commentary:  my emacs init file
;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)


(defvar my-packages '(better-defaults ido-ubiquitous 
                      company cider))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(global-company-mode)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

