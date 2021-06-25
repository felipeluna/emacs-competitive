(setq package-enable-at-startup nil)

(if (display-graphic-p)
    (setq initial-frame-alist
          '(
            (tool-bar-lines . 0)
            (width . 106)
            (height . 60)
            (background-color . "LightYellow2")
            (left . 50)
            (top . 50)))
  (setq initial-frame-alist '( (tool-bar-lines . 0))))

(setq default-frame-alist initial-frame-alist)
(set-face-attribute 'default nil :height 130)


(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Bootstrap install use-package
(straight-use-package 'use-package)

;; Functions
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
  Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun xah-copy-all-or-region ()
  "Put the whole buffer content to `kill-ring', or text selection if there's one.
Respects `narrow-to-region'.
URL `http://ergoemacs.org/emacs/emacs_copy_cut_all_or_region.html'
Version 2015-08-22"
  (interactive)
  (if (use-region-p)
      (progn
        (kill-new (buffer-substring (region-beginning) (region-end)))
        (message "Text selection copied."))
    (progn
      (kill-new (buffer-string))
      (message "Buffer content copied."))))

;; Package
(use-package swiper
  :straight t)

(use-package evil
  :straight t
  :demand t
  :custom
  (evil-esc-delay 0.001 "avoid ESC/meta mixups")
  (evil-shift-width 4)
  (evil-search-module 'evil-search)

  :bind (:map evil-normal-state-map
         ("S" . replace-symbol-at-point))

  :config
  ;; Enable evil-mode in all buffers.
  (evil-mode 1))

(use-package evil-escape
  :straight t
  :after evil
  :config (setq-default evil-escape-key-sequence "fd")
  :init (evil-escape-mode))

(use-package evil-args
  :straight t
  :bind (:map evil-inner-text-objects-map
         :map evil-outer-text-objects-map
         :map evil-normal-state-map
         :map evil-normal-state-map
         :map evil-motion-state-map
         ("n" . 'swiper)
	 ("," . 'switch-to-previous-buffer)))
         
(use-package general
  :straight t
  :config
  (general-define-key
    :states 'motion
    ";" 'find-file

    "/" 'java-one-click-run)
    ;; create space definer
    (general-create-definer my-leader-def
	;; :prefix my-leader
	:prefix "SPC")
    
    (my-leader-def
	:keymaps '(normal visual)
	"1" 'delete-other-windows
	"o" 'other-window
	"y" 'xah-copy-all-or-region
	"s" 'save-buffer))

;; java
(use-package java-one-click-run
  :straight (java-one-click-run :type git :host github :repo "MatthewZMD/java-one-click-run")
  :load-path "~/.emacs.d/site-elisp/java-one-click-run/"
  :init (use-package shell-here)
  :bind ("<f5>" . java-one-click-run))
