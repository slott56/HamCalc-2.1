STDIO Interface
==============================

These are HamCalc programs that run from the terminal window, using only
Python :func:`print` and :func:`input` functions.

This is approximately like the legacy HamCalc user experience.

There are two subgroups of stdio programs.

-   Importable Modules.

    These are modules with a proper "main/import" switch block of code.
    They can be imported and reused.

    -   The :mod:`hamlcalc.stdio.intro`, :mod:`hamlcalc.stdio.menu`.
        :program:`intro` is just a "splash page", which imports the menu.
        :program:`menu` (circularly) imports :program:`intro`.

    -   :mod:`hamcalc.stdio.rjd` is a separate menu program with
        a subset of HamCalc modules.

    -   :mod:`hamcalc.stdio.graphs`. This contains a useful class
        for graphing functions.

    -   :mod:`hamcalc.stdio.gwgraphics`. This contains a useful
        class for emulating some aspects of GW-Basic graphics mode output.

-   Simple Programs.

    These programs are so short that they don't really need documentation.
    Most of these wrap a calculation module; the calculation module has
    the relevant documentation.

    A few of these are stand-alone programs that on't have a calculation
    module.

-   Screen Savers.

    Once upon a time, a screen saver was considered essential to
    preserve the life of expensive monitors.

    There are four screen savers.

    -   :mod:`hamcalc.stdio.logoclok`.

    -   :mod:`hamcalc.stdio.bignum`.

    -   :mod:`hamcalc.stdio.shuttle`.

    -   :mod:`hamcalc.stdio.walker`.

    These tend to be rather quirky programs because of the way that
    they depend (deeply) on GW Basic Graphics, MS-DOS and legacy
    hardware.

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

