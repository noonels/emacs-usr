;;; custom.el --- All of my look-and-feel configuration
;;
;;; Commentary:
;; Author: M Cooper Healy
;;
;;; Code:

(setq starmacs/fixed-pitch-font "Berkeley Mono")
(set-face-attribute 'fixed-pitch nil :font starmacs/fixed-pitch-font :height starmacs/fixed-pitch-height)
(set-face-attribute 'mode-line nil :font starmacs/fixed-pitch-font :height (+ starmacs/fixed-pitch-height 15)) ; add a little extra height to the mode line
(setq all-the-icons-scale-factor 1.1)


;; Got bit by the Atom bug again (RIP), so I'm gonna give Anisochromatic a break for a while.
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (doom-themes-org-config))
(load-theme 'doom-one t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 35)
  (doom-modeline-def-modeline 'main
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs "  "))) ; <-- added padding here
    

(provide 'custom)
;;; custom.el ends here
