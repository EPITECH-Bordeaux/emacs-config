
(set-face-inverse-video-p 'vertical-border nil)
(set-face-background 'vertical-border (face-background 'default))

;; Set symbol for the border
(set-display-table-slot standard-display-table
			'vertical-border
			(make-glyph-code ?┃))


(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
(setq initial-major-mode 'text-mode)

;(add-hook  'paredit-mode) ; for nrepl.el <= 0.1.8
;(add-hook 'nrepl-repl-mode-hook 'paredit-mode) ; for nrepl.el > 0.1.8

(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)

     (defun linum-format-func (line)
       (let ((w (length
                 (number-to-string (count-lines (point-min) (point-max))))))
         (concat
          (propertize (make-string (- w (length (number-to-string line))) ?0)
                      'face 'linum-leading-zero)
          (propertize (number-to-string line) 'face 'linum))))

     (setq linum-format 'linum-format-func)))

(global-linum-mode 1)
(setq linum-format "%3d ")

(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("left8" (ecb-directories-buffer-name 0.3298429319371728 . 0.28846153846153844) (ecb-sources-buffer-name 0.3298429319371728 . 0.23076923076923078) (ecb-methods-buffer-name 0.3298429319371728 . 0.2692307692307692) (ecb-history-buffer-name 0.3298429319371728 . 0.17307692307692307)))))
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(highlight-changes-visible-mode)
;;(highlight-80+-mode)
;;(ecb-activate)

(require 'ecb)
(require 'ecb-autoloads)
(setq ecb-layout-name "left1")
(setq ecb-compile-window-height 4)
(ecb-hide-ecb-windows)
;;(ecb-activate)

;;(setq ecb-layout-name "layout-name")
(setq ecb-show-sources-in-directories-buffer 'always)


;;(setq ecb-compile-window-height 4)

;;; activate and deactivate ecb
(global-set-key (kbd "C-x C-;") 'ecb-activate)
(global-set-key (kbd "C-x C-'") 'ecb-deactivate)
;;; show/hide ecb window
(global-set-key (kbd "C-;") 'ecb-show-ecb-windows)
(global-set-key (kbd "C-'") 'ecb-hide-ecb-windows)
;;; quick navigation between ecb windows
(global-set-key (kbd "C-)") 'ecb-goto-window-edit1)
(global-set-key (kbd "C-!") 'ecb-goto-window-directories)
(global-set-key (kbd "C-@") 'ecb-goto-window-sources)
(global-set-key (kbd "C-#") 'ecb-goto-window-methods)
(global-set-key (kbd "C-$") 'ecb-goto-window-compilation)


(defun tmtxt/ecb-deactivate ()
  "deactive ecb and then split emacs into 2 windows that contain 2 most recent buffers"
  (interactive)
  (ecb-deactivate)
  (split-window-right)
  (switch-to-next-buffer)
  (other-window 1))
(defun tmtxt/ecb-hide-ecb-windows ()
  "hide ecb and then split emacs into 2 windows that contain 2 most recent buffers"
  (interactive)
  (ecb-hide-ecb-windows)
  (split-window-right)
  (switch-to-next-buffer)
  (other-window 1))
(defun tmtxt/ecb-show-ecb-windows ()
  "show ecb windows and then delete all other windows except the current one"
  (interactive)
  (ecb-show-ecb-windows)
  (delete-other-windows))

(global-set-key (kbd "<M-left>") 'ecb-goto-window-directories)
(global-set-key (kbd "<M-right>") 'ecb-goto-window-methods)
(global-set-key (kbd "<M-up>") 'ecb-goto-window-edit1)

(require 'sr-speedbar)
(sr-speedbar-open)

;; yes no > y n
(fset 'yes-or-no-p 'y-or-n-p)

;;numer line and colonne
(column-number-mode t)
(line-number-mode t)


;; Switch between buffers
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer windows

;; Lancer le man avec F3
(defun vectra-man-on-word ()
  "Appelle le man sur le mot pointe par le curseur"
  (interactive)
  (manual-entry (current-word)))
(global-set-key [f3] 'vectra-man-on-word)

;; Suppression des espaces en fin de ligne a l'enregistrement
(add-hook 'c++-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook   'c-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))

;; parenthese em couleur
(custom-set-variables
 '(show-paren-mode t))
(custom-set-faces)

;; Reduit la fontion sur elle meme avec F1
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'lisp-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(global-set-key [f1] 'hs-hide-block)

;; Et la 'de'reduit avec F2
(global-set-key [f2] 'hs-show-block)

(setq-default show-trailing-whitespace t) ; affiche les espaces en fin de ligne
(setq-default delete-trailing-whitespace t) ; affiche les espaces en fin de ligne
(global-set-key [f9] 'compile) ; raccourcie pour compile dans emacse

(global-hl-line-mode 1)
(set-face-background 'hl-line "#000")
(set-face-foreground 'highlight nil)
(set-face-foreground 'hl-line nil)

;; (load "~/.emacs.d/std.el")
(load "~/.emacs.d/std_comment.el")

(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(electric-pair-mode 1)
(setq electric-pair-pairs '(
			    (?\" . ?\")
			    (?\{ . ?\})
			    ) )
