;;; langs.el --- All of my language-specific configuration
;;
;;; Commentary:
;; Author: M Cooper Healy
;;
;;; Code:

;; Python
(use-package python-black
  :demand t
  :after python
  :hook (python-ts-mode . python-black-on-save-mode-enable-dwim))

;; TypeScript
(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 2))

;; Julia
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

;; Go
(use-package go-ts-mode
  :ensure t
  :hook
  (go-mode . go-ts-mode)
  (go-ts-mode . eglot-ensure)
  (go-ts-mode . tree-sitter-hl-mode)
  :config
  (setq go-ts-indent-level 4))

;; LaTeX
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

;; Protobuf
(use-package protobuf-mode
  :straight t)

;; Fortran 90+
(add-to-list 'eglot-server-programs '(f90-mode . ("fortls" "--notify_init" "--nthreads=4")))

(provide 'langs)
;;; langs.el ends here
