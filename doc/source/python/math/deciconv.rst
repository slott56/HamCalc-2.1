..  _`math.deciconv`:

deciconv -- Decimal Hour/Degree Converter
------------------------------------------

Analysis
~~~~~~~~~

Time, in decimal hours, is a function of Hours, :math:`T_h`, Minutes, :math:`T_m`, and Seconds, :math:`T_s`.

..  math::

    T = T_h + \frac{T_m + \frac{T_s}{60}}{60}

The reverse is also true: we can extract Hours, Minutes and Seconds
from the time, if we handle time in seconds or minutes, not hours.

..  math::

    T_s = 3600T \mod 60

..  math::

    T_m = 60T \mod 60

..  math::

    T_h = \lfloor T \rfloor

Degrees have an identical analysis. The only distinction between HH:MM:SS
and DEG°MM'SS" is the formatting.

Implementation
~~~~~~~~~~~~~~~

This gives us pause. We have three degree-radian and degree-minute-second locations.

-   :mod:`hamcalc.math.trig`

-   :mod:`hamcalc.math.deciconv`

-   :mod:`hamcalc.math.equiv`

Which is "fundamental"? Or do we have  a common module that is shared by all three?

We can use simple unit conversion class definitions for the Hour-Minute-Second
conversion.  The trigonometry needs to be moved into :mod:`hamcalc.math.trig`.

..  automodule:: hamcalc.math.deciconv
    :members:

Legacy Quirks
~~~~~~~~~~~~~~~~

Note that this has three places in the menu structure.

-   It's own top-level entry.

-   As part of QuickTables.

-   As part of the sub-menu under the :program:`equiv` program. See :ref:`math.equiv`.

Perhaps this should simply be merged into :program:`equiv` so that
**all** unit conversions are in one place.

The legacy program uses multi-step input rather than parsing a single string.
That's not a quirk, *per se*; the lack of good string parsing is a limitation of GW-Basic.
