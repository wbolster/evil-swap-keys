;;; evil-swap-numbers-symbols --- swap numbers and symbols row while typing text with evil -*- lexical-binding: t; -*-

;; Author: Wouter Bolsterlee <wouter@bolsterl.ee>
;; Version: 1.0.0
;; Package-Requires: ((emacs "24") (evil "1.2.12"))
;; Keywords: evil numbers symbols
;; URL: https://github.com/wbolster/evil-swap-numbers-symbols
;;
;; This file is not part of GNU Emacs.

;;; License:

;; Licensed under the same terms as Emacs.

;;; Commentary:

;; This minor mode swaps the behaviour of the numbers and symbols
;; keyboard row when entering text.  See the README for more details.

;;; Code:

(require 'evil)

(defgroup evil-swap-numbers-symbols nil
  "Swap the numbers/symbols keyboard row when entering text"
  :prefix "evil-swap-numbers-symbols-"
  :group 'evil)

(defcustom evil-swap-numbers-symbols-key-pairs
  '(("1" . "!")
    ("2" . "@")
    ("3" . "#")
    ("4" . "$")
    ("5" . "%")
    ("6" . "^")
    ("7" . "&")
    ("8" . "*")
    ("9" . "(")
    ("0" . ")"))
  "The keys on the keyboard that should be swapped.  This should match the keyboard layout."
  :type 'alist)

;;;###autoload
(define-minor-mode evil-swap-numbers-symbols-mode
  "Minor mode to default to symbols for the keyboard's number row."
  :keymap (make-sparse-keymap)
  :lighter " !1")

;;;###autoload
(define-globalized-minor-mode global-evil-swap-numbers-symbols-mode
  evil-swap-numbers-symbols-mode
  (lambda () (evil-swap-numbers-symbols-mode t))
  "Global minor mode to default to symbols for the keyboard's number row.")

(dolist
    (key-pair evil-swap-numbers-symbols-key-pairs)
  (let ((number-value (car key-pair))
        (symbol-value (cdr key-pair)))
    (evil-define-minor-mode-key
      'insert 'evil-swap-numbers-symbols-mode
      number-value (lambda () (interactive) (insert symbol-value))
      symbol-value (lambda () (interactive) (insert number-value)))))

(provide 'evil-swap-numbers-symbols)
;;; evil-swap-numbers-symbols.el ends here
