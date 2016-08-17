;;; evil-swap-keys --- intelligently swap keys on text input with evil -*- lexical-binding: t; -*-

;; Author: Wouter Bolsterlee <wouter@bolsterl.ee>
;; Version: 1.0.0
;; Package-Requires: ((emacs "24") (evil "1.2.12"))
;; Keywords: evil numbers symbols
;; URL: https://github.com/wbolster/evil-swap-keys
;;
;; This file is not part of GNU Emacs.

;;; License:

;; Licensed under the same terms as Emacs.

;;; Commentary:

;; This minor mode swaps the behaviour of the numbers and symbols
;; keyboard row and some other keys, but only when entering text.
;; See the README for more details.

;;; Code:

(require 'evil)

(defgroup evil-swap-keys nil
  "Swap the numbers/symbols keyboard row when entering text"
  :prefix "evil-swap-keys-"
  :group 'evil)

(defcustom evil-swap-keys-key-pairs
  '(("1" . "!")
    ("!" . "1")
    ("2" . "@")
    ("@" . "2")
    ("3" . "#")
    ("#" . "3")
    ("4" . "$")
    ("$" . "4")
    ("5" . "%")
    ("%" . "5")
    ("6" . "^")
    ("^" . "6")
    ("7" . "&")
    ("&" . "7")
    ("8" . "*")
    ("*" . "8")
    ("9" . "(")
    ("(" . "9")
    ("0" . ")")
    (")" . "0"))
  "The keys on the keyboard that should be swapped.  This should match the keyboard layout."
  :group 'evil-swap-keys
  :type 'alist)

;;;###autoload
(define-minor-mode evil-swap-keys-mode
  "Minor mode to default to symbols for the keyboard's number row."
  :keymap (make-sparse-keymap)
  :lighter " !1")

;;;###autoload
(define-globalized-minor-mode global-evil-swap-keys-mode
  evil-swap-keys-mode
  (lambda () (evil-swap-keys-mode t))
  "Global minor mode to default to symbols for the keyboard's number row.")

(dolist
    (key-pair evil-swap-keys-key-pairs)
  (let ((from (car key-pair))
        (to (cdr key-pair)))
    (evil-define-minor-mode-key
      'insert 'evil-swap-keys-mode
      from (lambda () (interactive) (insert to)))))

;; FIXME: perhaps key-translation-map combined with
;; evil-*-state-entry-hook and evil-*-state-exit-hook is a better way
;; to implement this. for things like f and evil-snipe some around
;; advice may be helpful

;; FIXME: keyboard-translate-table

;; (keyboard-translate ?1 nil)
;; (keyboard-translate ?! nil)
;; keyboard-translate-table

;; TODO: on enable, add bindings in key-translation-map; on disable,
;; remove. the function bound to the keys should check evil-state
;; swap for anything but 'motion 'normal 'visual

;; TODO: minibuffer text entry. (active-minibuffer-window) perhaps?

(provide 'evil-swap-keys)
;;; evil-swap-keys.el ends here
