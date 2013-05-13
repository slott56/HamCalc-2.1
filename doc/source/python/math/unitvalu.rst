unitvalu -- Unit Value Comparator
---------------------------------

This seems to be a simple divide and sort kind of thing.
Maybe it's a shabby spreadsheet? A data visualization aid?

Introduction::

    UNIT VALUE COMPARATOR                                   by George Murphy VE3ERP
      This program calculates Value per Unit (V/U) of one or more samples of any

     given V/U combination, and sorts them for comparison. Typical V/U combinations
     are:

                         kw/hr          ohms/ft.       dB/watt
                         lb./sq.ft.     mi./hr.        cents/kg.

                    or any other V/U combination you wish to specify.

Analysis
~~~~~~~~~~~

The use case appears to be that the user defines two dimensions,
the "value" and the "unit".

Then the user provides a sequence of value and unit pairs, :math:`(v,u)`.

The application computes :math:`v/u` for each value. It sorts
the values into :math:`v/u` order, and identifies the max and min.
Each value in the report also has two relative
fractions (as a percent) compared to max
and min of the pairs.

Implementation
~~~~~~~~~~~~~~~

This doesn't seem to deserve a proper HamCalc calculation module for one
formula.

It's a cute little module in :mod:`hamcalc.stdio`.

Legacy Output
~~~~~~~~~~~~~~~~

The calculated results shown below are incorrect.

::

     ENTER: The term (plural) you wish used to express value (V)? nm

     ENTER: The term (singular) you wish used to express units (U)? h

    Item   nm           Units (h)       nm per h

    Item A
     ENTER: Number of (h) units? 25
     ENTER: Value (nm)? 13

      A:   13           25              =    0.5200

Summary

::

    Item   nm           Units (h)       nm per h              % of A    % of B
      A:   54           9               =    6.0000             0.0%     0.01%
      C:   60           10              =    6.0000             0.0%     0.01%
      B:   40           6               =    6.6667             0.0%     0.01%

