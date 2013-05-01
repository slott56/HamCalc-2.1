STDIO Interface
==============================

These are HamCalc programs that run from the terminal window, using only
Python :func:`print` and :func:`input` functions.

This is approximately like the legacy HamCalc user experience.

There are two subgroups of stdio programs.

-   The intro and menu programs. These are special because they're not
    specific HamCalc applications. They're just a "splash page" and
    a menu system.

-   All the other programs.
    These programs are so short that they don't really need documentation.
    Also, they simply wrap a calculation module, which does have documentation.

Intro
----------------

..  automodule:: hamcalc.stdio.intro
    :members:

Menu
------------------

..  automodule:: hamcalc.stdio.menu
    :members:

