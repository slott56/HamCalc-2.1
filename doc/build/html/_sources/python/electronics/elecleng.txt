..  _`electronics.elecleng`:

elecleng
---------

HamDex Entries

..  csv-table::

    "ELECTRICAL LENGTH",", transmission line","","ELECLENG"
    "VELOCITY FACTOR",", transmission lines","","ELECLENG"
    "ELECTRICAL LENGTH",", transmission line","","ELECLENG"

..  todo:: Finish elecleng

Analysis
~~~~~~~~~~

This is a **Solver**
for Frequency, Length (physical), Length Electrical ("degrees") and
Velocity Factor of the line.

Here's some information extracted from one part of legacy :program:`equiv`.

:L:
    Line length in feet

:N:
    Line length, electrical, in degrees

:F:
    Frequency

:V:
    Velocity Factor

..  math::

    L = 984 \frac{V N}{360 F}

..  math::

    N = L F \frac{360}{984 V}

Here's some information extract from another part of legacy :program:`equiv`.

Given Length in Degrees, :math:`l_d`, and frequency, :math:`f`, we can calculate lenth in inches, :math:`l_i`. Length in centimeters, `l_c`, is simply :math:`l_c = 2.54 l_i`.

..  math::

    l_i = 32.8 \frac{l_d}{f}

We can solve this equation for :math:`l_d`, also.
