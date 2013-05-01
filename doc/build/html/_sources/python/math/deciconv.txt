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

Implementation
~~~~~~~~~~~~~~~

We can use simple unit conversion class definitions for this.

..  automodule:: hamcalc.math.deciconv
    :members:


