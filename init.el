(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(setq mode-require-final-newline t)
(setq require-final-newline t)

(add-hook 'before-save-hook #'delete-trailing-whitespace nil 'local)
