=================
evil-swap-keys.el
=================

This `Emacs <https://www.gnu.org/software/emacs/>`_ package
makes it easy to intelligently swap keyboard keys
when entering text.
The main use case is
to change the number row on the keyboard (1, 2, 3, 4, …)
to produce symbols (!, @, #, $, …) without using the shift key,
which is useful for programming,
but it can also swap other keys.

As the name suggests, this package integrates well with
`evil <https://bitbucket.org/lyro/evil/>`_,
the extensible vi layer,
but it can also be used with vanilla Emacs.

``evil-swap-keys`` is intelligent and flexible:

* Configuration is buffer-local.

  This means you can have different settings for different major
  modes. See below for examples.

* Input related to a buffer uses the buffer’s configuration.

  Key swapping also works when entering text
  outside the main buffer contents,
  such as when entering text in the minibuffer
  (``isearch``, `swiper <https://github.com/abo-abo/swiper>`_, …).

* Keys are only swapped when entering text, not when entering
  commands. (This is evil-specific behaviour.)

  When entering commands, the keys on the number row behave as
  numbers, so that commands like ``5j`` to move 5 lines down do not
  require the use of the shift key either. Commands that read keys
  when not in insert state, such as ``evil-find-char`` and
  ``evil-find-char-to`` (bound to ``f`` and ``t`` by default), will
  also have the configured key swaps applied. It even works with
  `evil-snipe <https://github.com/hlissner/evil-snipe>`_.


Installation
============

Install from Melpa::

  M-x package-install RET evil-swap-keys RET


Usage
=====

``evil-swap-keys`` provides a minor mode, aptly named
``evil-swap-keys-mode``, and a globalized version, named
``global-evil-swap-keys-mode``. Enabling or disabling the mode, either
locally or globally, does not change any keyboard behaviour until the
package is configured. This means you can safely enable
``evil-swap-keys`` using::

  M-x global-evil-swap-keys-mode RET

Even better, enable it by default by adding it to your ``init.el``:

.. code-block:: elisp

  (evil-mode)
  (global-evil-swap-keys-mode)

When enabled, ``!1`` will appear in the mode line.

Now that the mode is enabled, you can configure how it should behave.
As noted before, this package does not automatically change keyboard
behaviour, since any modifications are highly personal, likely
dependent on the major mode, and also dependent on the keyboard
layout. This means that major mode hooks are the right place to
selectively enable the key swaps that make sense to you.

This is best explained using a few examples:

* Example 1: swap numbers and symbols when programming

  In many programming languages, symbols are more common than numbers,
  so swapping the number row makes sense, which can be done for all
  programming related major modes using ``prog-mode-hook``:

  .. code-block:: elisp

    (add-hook 'prog-mode-hook #'evil-swap-keys-swap-number-row)

* Example 2: Python programming

  In Python code, colons are more common than semicolons, and
  underscores are more common than dashes. To swap these in addition
  to the numbers and symbols, configure additional key pairs from the
  Python specific major mode hook:

  .. code-block:: elisp

    (add-hook 'python-mode-hook #'evil-swap-keys-swap-colon-semicolon)
    (add-hook 'python-mode-hook #'evil-swap-keys-swap-underscore-dash)

* Example 3: normal text

  In normal prose, question marks are more common than slashes:

  .. code-block:: elisp

    (add-hook 'text-mode-hook #'evil-swap-keys-swap-question-mark-slash)


Overview of standard swaps
==========================

The available swaps for use in hooks are listed below:

* ``(defun evil-swap-keys-swap-number-row)``

  Swap the numbers and symbols on the number row of the keyboard.
  Useful for many programming languages. This uses the
  ``evil-swap-keys-number-row-keys`` configuration variable.

  This is not needed if the keyboard layout already uses symbols by
  default for the number row, e.g. French AZERTY keyboards.

* ``(evil-swap-keys-swap-underscore-dash)``

  Swap the underscore and the dash. Useful for Python and other
  languages that use underscores for variable and function names.

* ``(evil-swap-keys-swap-colon-semicolon)``

  Swap the colon and semicolon. Useful for Python which uses colons
  before an indented block, and almost never uses semicolons.

* ``(evil-swap-keys-swap-tilde-backtick)``

  Swap the backtick and tilde. Useful for C++ which uses tildes for
  destructors.

* ``(evil-swap-keys-swap-double-single-quotes)``

  Swap the double and single quotes. Useful for C-like languages,
  since typing strings is more common than typing individual
  characters.

* ``(evil-swap-keys-swap-square-curly-brackets)``

  Swap the square and curly brackets. Useful for C-like languages and
  other languages that use curly brackets as block delimiters, which
  are used more often than array indexing with square brackets.

* ``(evil-swap-keys-swap-pipe-backslash)``

  Swap the pipe and backslash. Useful for shell scripts, which use
  pipes (chaining commands) more often than backslashes (continuation
  lines).

* ``(evil-swap-keys-swap-question-mark-slash)``

  Swap the question mark and slash. Useful for regular text, since the
  former is much more common in prose, don’t you think?


Customisation
=============

The defaults assume that your keyboard layout has these number and
symbol pairs:

* ``1`` and ``!``
* ``2`` and ``@``
* ``3`` and ``#``
* ``4`` and ``$``
* ``5`` and ``%``
* ``6`` and ``^``
* ``7`` and ``&``
* ``8`` and ``*``
* ``9`` and ``(``
* ``0`` and ``)``

For a different layout, change ``evil-swap-keys-number-row-keys``,
e.g. by using the Customize interface::

  M-x customize-group RET evil-swap-keys RET

If the swaps provided by default do not suit your needs, e.g. because
you use a different keyboard layout, or because you want
non-symmetrical key swaps, you can use these lower level functions:

* ``(evil-swap-keys-add-pair FROM TO)``

  Swap two characters. Typing one will produce the other, and the
  other way around.

* ``(evil-swap-keys-add-mapping FROM TO)``

  Add a one-way mapping from one key to another. Useful if you want to
  move some keys around on your keyboard in a custom way, e.g. to
  bring some keys within closer reach (and move some others out of
  reach).
