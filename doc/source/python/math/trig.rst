trig -- Trigonometric Functions
---------------------------------

Analysis
~~~~~~~~~~

This has three features.

1.  Conversion of angles in decimal degrees, degrees-minutes-seconds or radians
    into other measurements. The conversions duplicate (or are imported by) :program:`deciconv` and
    :program:`equiv`.

2.  Calculation of trig functions for a given angle.

3.  A link to :program:`solutri`.

Implementation
~~~~~~~~~~~~~~~~

This gives us pause. We have at least three degree-radian and degree-minute-second locations.

-   :mod:`hamcalc.math.trig`

-   :mod:`hamcalc.math.deciconv`

-   :mod:`hamcalc.math.equiv`

Which is "fundamental"? Or do we have a common module that is shared by all three?

We've decided that ``trig`` is the common module from which the other two import
some definitions.

This means that :mod:`hamcalc.math.deciconv` is a conflation of sexagesimal conversions for Hour-Minute-Second with trigonometry conversions of Degree-Minute-Second.
And it means that modules like :mod:`hamcalc.math.equiv` must import another
the trignometry definitions from :mod:`hamcalc.math.trig`.

..  automodule:: hamcalc.math.trig
    :members:

Quirks
~~~~~~~~

The sexagesimal conversions were copy-and-pasted in at least three locations
in HamCalc. A ringing indictment of the limitations of GW-Basic and the cleverness of programmers who worked around that limitation.

