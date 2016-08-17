=================
evil-swap-keys.el
=================

This Emacs package for ``evil-mode`` swaps the numbers and symbols on
the number key row when entering text. Pressing ``1`` results in
``!``, ``2`` results in ``@``, and so on. Numbers require the shift
key. When symbols are used more often than numbers, e.g. while
programming, this results in more relaxed typing.

The keys only change when entering text (insert state). In normal
mode, the keys behave as usual, so things like ``3w`` to jump three
words forward do not require the shift key.


Installation
============

Install from Melpa::

  M-x package-install RET evil-swap-keys RET


Usage
=====

To enable the minor mode globally, use::

  (global-evil-swap-keys-mode)

To enable for a single buffer only, e.g. from a major mode hook, use::

  (evil-swap-keys-mode)

When enabled, a lighter showing ``!1`` will appear in your mode line.


Keyboard layout
===============

The defaults assume that your keyboard layout has these number and symbol pairs:

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

For a different layout, change ``evil-swap-keys-key-pairs``
by setting it in your ``init.el``. Look at the code for the format. Alternatively, use the Customize interface::

  M-x customize-group RET evil-swap-keys RET
