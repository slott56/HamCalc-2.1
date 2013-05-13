speedtd -- Speed/Time/Distance Calculator
------------------------------------------

The canonical **Solver** plus **Equivalents** example.

Analysis
~~~~~~~~~~~

This is a :math:`r \times t = d` **Solver** that works
in a variety of units for distance and time.

Distance units are

- "< a >  Millimetre"
- "< b >  Centimetre"
- "< c >  Inch"
- "< d >  Foot"
- "< e >  Metre"
- "< f >  Kilometre"
- "< g >  Statute mile"
- "< h >  Nautical mile"

Time units are

- "< h >  Hour"
- "< m >  Minute"
- "< s >  Second"

Once the basic RTD problem has been solved, there's a second feature:
computing Vehicular Fuel Consumption.

When distance is km, then the fuel consumption rate is measured in litres per 100 km.

When distance is not km, then fuel consumption rate is measured in miles/gallon.

With this note: "Quantities are in U.S. gallons. Divide by 1.2 for Imperial"

Implementation
~~~~~~~~~~~~~~~

The various distance and time units are defined in :mod:`hamcalc.math.equiv` (:ref:`math.equiv`).

There is one **Solver** that creates a standard rate, time and distance value and then displays this value back in the original input units.

A second **Solver** can use the distance as part of a
total fuel, fuel consumption rate, distance calculation.

..  automodule:: hamcalc.math.speedtd
    :members:

Legacy Quirks
~~~~~~~~~~~~~~

A common problem is to derive fuel consumption rate from overall fuel and distance values. This is not supported by this application.

Also, this program can launch the :program:`chase` program. It's not clear
why these two are bundled together like this, except, perhaps, that
the :program:`chase` program has something to do with rate and time.
