;;; langs.el --- All of my language-specific configuration
;;
;;; Commentary:
;; Author: M Cooper Healy
;;
;;; Code:

;;; Python
(use-package python-black
  :demand t
  :after python
  :hook (python-ts-mode . python-black-on-save-mode-enable-dwim))

;;; TypeScript
(use-package web-mode
  :ensure t)

(define-derived-mode typescriptreact-mode web-mode "TypescriptReact"
  "A major mode for tsx.")

(use-package prettier-js
  :ensure t
  :hook
  (typescript-ts-mode . prettier-js-mode)
  (typescriptreact-mode . prettier-js-mode)
  (typescript-mode . prettier-js-mode))

(use-package add-node-modules-path
  :ensure t
  :hook
  (typescript-ts-mode . add-node-modules-path)
  (typescriptreact-mode . add-node-modules-path)
  (typescript-mode . add-node-modules-path))

(use-package typescript-mode
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescriptreact-mode)))

(use-package eglot
  :ensure t
  :defer 3
  :hook
  ((js-mode
    typescript-mode
    typescriptreact-mode) . eglot-ensure)
  :config
  (cl-pushnew '((js-mode typescript-mode typescriptreact-mode) . ("typescript-language-server" "--stdio"))
              eglot-server-programs
              :test #'equal))
;;(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
;;(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
;; (use-package jtsx
;;   :ensure t
;;   :mode (("\\.jsx?\\'" . jtsx-jsx-mode)
;;          ("\\.tsx?\\'" . jtsx-tsx-mode))
;;   :commands jtsx-install-treesit-language
;;   :hook ((jtsx-jsx-mode . hs-minor-mode)
;;          (jtsx-tsx-mode . hs-minor-mode))
;;   :custom
;;   Optional customizations
;;   (js-indent-level 2)
;;   (typescript-ts-mode-indent-offset 2)
;;   (jtsx-switch-indent-offset 0)
;;   (jtsx-indent-statement-block-regarding-standalone-parent nil)
;;   (jtsx-jsx-element-move-allow-step-out t)
;;   (jtsx-enable-jsx-electric-closing-element t)
;;   (jtsx-enable-electric-open-newline-between-jsx-element-tags t)
;;   (jtsx-enable-all-syntax-highlighting-features t)
;;   :config
;;   (defun jtsx-bind-keys-to-mode-map (mode-map)
;;     "Bind keys to MODE-MAP."
;;     (define-key mode-map (kbd "C-c C-j") 'jtsx-jump-jsx-element-tag-dwim)
;;     (define-key mode-map (kbd "C-c j o") 'jtsx-jump-jsx-opening-tag)
;;     (define-key mode-map (kbd "C-c j c") 'jtsx-jump-jsx-closing-tag)
;;     (define-key mode-map (kbd "C-c j r") 'jtsx-rename-jsx-element)
;;     (define-key mode-map (kbd "C-c <down>") 'jtsx-move-jsx-element-tag-forward)
;;     (define-key mode-map (kbd "C-c <up>") 'jtsx-move-jsx-element-tag-backward)
;;     (define-key mode-map (kbd "C-c C-<down>") 'jtsx-move-jsx-element-forward)
;;     (define-key mode-map (kbd "C-c C-<up>") 'jtsx-move-jsx-element-backward)
;;     (define-key mode-map (kbd "C-c C-S-<down>") 'jtsx-move-jsx-element-step-in-forward)
;;     (define-key mode-map (kbd "C-c C-S-<up>") 'jtsx-move-jsx-element-step-in-backward)
;;     (define-key mode-map (kbd "C-c j w") 'jtsx-wrap-in-jsx-element)
;;     (define-key mode-map (kbd "C-c j u") 'jtsx-unwrap-jsx)
;;     (define-key mode-map (kbd "C-c j d") 'jtsx-delete-jsx-node))

;;   (defun jtsx-bind-keys-to-jtsx-jsx-mode-map ()
;;       (jtsx-bind-keys-to-mode-map jtsx-jsx-mode-map))

;;   (defun jtsx-bind-keys-to-jtsx-tsx-mode-map ()
;;       (jtsx-bind-keys-to-mode-map jtsx-tsx-mode-map))

;;   (add-hook 'jtsx-jsx-mode-hook 'jtsx-bind-keys-to-jtsx-jsx-mode-map)
;;   (add-hook 'jtsx-tsx-mode-hook 'jtsx-bind-keys-to-jtsx-tsx-mode-map))

;; Prettier
(use-package prettier
  :ensure t
  :hook (typescript-ts-mode . prettier-mode)
  (tsx-ts-mode . prettier-mode))

;;; Julia
(use-package vterm :ensure t)
(use-package julia-repl)
(use-package eglot-jl)
(use-package julia-mode
  :mode "\\.jl\\'"
  :interpreter ("julia" . julia-mode)
  :init (setenv "JULIA_NUM_THREADS" "6")
  :config
  (add-hook 'julia-mode-hook 'julia-repl-mode)
  (add-hook 'julia-mode-hook 'eglot-jl-init)
  (add-hook 'julia-mode-hook 'eglot-ensure)
  (add-hook 'julia-mode-hook (lambda () (setq julia-repl-set-terminal-backend 'vterm))))

(setq eglot-jl-julia-command "/usr/local/bin/julia")
(setq julia-repl-executable-records
      '((default "/usr/local/bin/julia")
        (master "/usr/local/bin/julia")))

(setq-default indent-tabs-mode nil)

;;; Go
(use-package go-mode
  :ensure t
  :hook
  (go-mode . eglot-ensure)
  (go-mode . tree-sitter-hl-mode)
  :config
  (setq go-ts-indent-level 4))

(use-package zig-mode
  :ensure t
  :mode ("\\.zig\\'")
  :hook
  (zig-mode . eglot-ensure)
  (zig-mode . tree-sitter-hl-mode))

;;; LaTeX
(use-package tex
  :defer t
  :straight auctex
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq-default Tex-engine 'xetex)
  (setq-default TeX-PDF-mode t))

(use-package preview-latex
  :defer t
  :straight auctex
  :ensure auctex)

;;; Protobuf
(use-package protobuf-mode
  :straight t)

;;; Godot
(use-package gdscript-mode
    :straight (gdscript-mode
               :type git
               :host github
               :repo "godotengine/emacs-gdscript-mode"))

;;; Fortran 90+
(add-to-list 'eglot-server-programs '(f90-mode . ("fortls" "--notify_init" "--nthreads=4")))

;;; LISP
;; no tabs in lisp
(add-hook 'emacs-lisp-mode-hook (lambda () (setq-local indent-tabs-mode nil)))
(add-hook 'lisp-mode-hook (lambda () (setq-local indent-tabs-mode nil)))

(provide 'langs)
;;; langs.el ends here
