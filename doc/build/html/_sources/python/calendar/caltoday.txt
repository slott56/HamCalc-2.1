caltoday -- Calendar, Perpetual/Universal
-----------------------------------------

From the comments::

    20 :REM'Adapted from "How to Program Your IBM PC", by Carl Shipman
    30 :REM'Published by Knight-Ridder Press        ISBN:0-89586-544-0
    40 :REM'Library of Congress Catalog No. 83-81692

Option 1. Rewrite this GW-Basic adaptation of an algorithm from Shipman's book.

Option 2. Use the better algorithms in the book Calendrical Calculations.
    Dershowitz, Nachum and Edward M. Reingold. Calendrical Calculations. Cambridge University Press. 1997.

Option 3. Use Python's built-in packages and move on.

Implementation
~~~~~~~~~~~~~~~

Since most of this is a first-class piece of the Python library, there's no calculation module required. This is mostly just flashy output.

See built-in modules :mod:`calendar` and :mod:`datetime`.

This becomes three cute little modules in :mod:`hamcalc.stdio`.

-   :program:`hamcalc.stdio.caltoday` is the essental calendar features.

-   :program:`hamcalc.stdio.days` is the days-between-two-dates calculation.

-   :program:`hamcalc.stdio.sunup` is the sunup/sundown calculation.

The only part that's not built-in is menu item 5, Sunrise/Sunset Calendar.
But this is really a separate program.  See :ref:`navigation.sunup`.

Quirks
~~~~~~~

This line starts a massive loop that's partially ignored, depending on main menu options.

::

    210  FOR ABC=1 TO 3

The loop ends at

::

    1400 NEXT ABC

This does the "3-month" calendar. The main menu is **inside** this loop.

For the "Any Month" option, an extra mystery GOTO is wedged in to avoid highlighting today's date.

::

    1170 IF Q$="2"THEN COLOR 15,6:GOTO 1190

And this extra mystery GOTO is wedged in to only process one month, in spite of being in the middle of a FOR loop.

::

    1330 IF Q$="2"THEN COLOR 7,0:GOTO 1410      :REM'single month display

For whole year, an entirely separate piece of code is used.
