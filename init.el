;;;
(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milbox.net/packages/"))


(defvar my-packages '(better-defaults paredit idle-highlight-mode ido-ubiquitous
                      find-file-in-project magit smex scpaste
                      evil))

(package-initialize)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(require 'evil)
(evil-mode 1)
