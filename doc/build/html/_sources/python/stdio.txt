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

    -   :mod:`hamcalc.stdio.graphs`. This contains a useful class
        for graphing functions.

    -   :mod:`hamcalc.stdio.gwgraphics`. This contains a useful
        class for emulating some aspects of GW-Basic graphics mode output.

-   Simple Programs.

    These programs are so short that they don't really need documentation.
    Also, they simply wrap a calculation module, which has
    the relevant documentation.

Intro
----------------

..  automodule:: hamcalc.stdio.intro
    :members:

Menu
------------------

..  automodule:: hamcalc.stdio.menu
    :members:

..  _`stdio.graphs`:

Graphs
---------

..  automodule:: hamcalc.stdio.graphs
    :members:

GW Graphics
------------

..  automodule:: hamcalc.stdio.gwgraphics
    :members:
