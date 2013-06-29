STDIO Interface
==============================

These are HamCalc programs that run from the terminal window, using only
Python :func:`print` and :func:`input` functions.

This is approximately like the legacy HamCalc user experience.

There are four subgroups of stdio programs.

-   Application Programs.

    This is the bulk of HamCalc.
    These are short programs that do the real work.
    Most of these wrap a calculation module; the calculation module has
    all relevant documentation.

    A few of these are stand-alone programs that don't even have a calculation
    module.

    Most of these cannot be imported, either. They're designed
    to be relatively simple Python scripts.

-   Special Importable Modules.

    These are a few modules with a proper "main/import" switch block of code.
    They can be imported and reused.

    -   The :mod:`hamlcalc.stdio.intro`, :mod:`hamlcalc.stdio.menu`.
        :program:`intro` is just a "splash page", which imports the menu.
        :program:`menu` (circularly) imports :program:`intro`.

    -   :mod:`hamcalc.stdio.graphs`. This contains a useful class
        for graphing functions; other modules might import this.

    -   :mod:`hamcalc.stdio.gwgraphics`. This contains a useful
        class for emulating some aspects of GW-Basic graphics mode output.

-   Other Menus.

    There are few programs which are, themselves, merely menus.

    -   :mod:`hamcalc.stdio.rjd`.

    -   :mod:`hamcalc.stdio.mechmenu`.

    It might be sensible to merge these into the menu application
    itself.

-   Screen Savers.

    Once upon a time, a screen saver was considered essential to
    preserve the life of expensive monitors.

    There are four screen savers in HamCalc.

    -   :mod:`hamcalc.stdio.logoclok`.

    -   :mod:`hamcalc.stdio.bignum`.

    -   :mod:`hamcalc.stdio.shuttle`.

    -   :mod:`hamcalc.stdio.walker`.

    These tend to be rather quirky programs because of the way that
    they depend (deeply) on GW Basic Graphics, MS-DOS and legacy
    hardware.

__main__
----------------

..  automodule:: hamcalc.stdio.__main__
    :members:

__init__
-----------------

..  automodule:: hamcalc.stdio.__init__
    :members:

Intro
----------------

..  automodule:: hamcalc.stdio.intro
    :members:

Menu
------------------

..  automodule:: hamcalc.stdio.menu
    :members:

RJD
-------------------

..  automodule:: hamcalc.stdio.rjd
    :members:

mechmenu
-------------------

..  automodule:: hamcalc.stdio.mechmenu
    :members:

..  _`stdio.graphs`:

Graphs
---------

..  automodule:: hamcalc.stdio.graphs
    :members:

..  _`stdio.gwgraphics`:

GW Graphics
------------

..  automodule:: hamcalc.stdio.gwgraphics
    :members:

