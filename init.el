(setq package-enable-at-startup nil)

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

(use-package evil-args
  :straight t
  :bind (:map evil-inner-text-objects-map
         :map evil-outer-text-objects-map
         :map evil-normal-state-map
         :map evil-normal-state-map
         :map evil-motion-state-map
         ("n" . 'swiper)))
         
