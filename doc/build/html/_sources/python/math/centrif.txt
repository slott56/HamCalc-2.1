centrif -- Centrifugal/Centripetel Force
-----------------------------------------

Analysis
~~~~~~~~~

This is a Force-Mass-Velocity-Radius **Solver**.

The essential relationship among Force, *F*, Mass, *M*, Velocity, *V*, and Radius, *R*, seems to be this:

..  math:: F=\frac{MV^2}{R}

This program can solve for any one given the other three.

It also converts from Standard to Imperial units.

Implementation
~~~~~~~~~~~~~~~~

..  automodule:: hamcalc.math.centrif
    :members:

Quirks
~~~~~~~~

The units of force and mass are wrong.

See http://en.wikipedia.org/wiki/Slug_(mass)

http://en.wikipedia.org/wiki/Pound-force

http://en.wikipedia.org/wiki/Pound_(mass)

Weight is the force of a mass accelerated by gravity: :math:`w = mg`.

Force is measured in Newtons, N, or pounds, lb. The prompt and output says "kilograms", which is not quite correct.

Mass is measured in kilograms, kg, or a number of different ways in imperial units. The output says "lbs" which is not totally correct.

One imperial unit for mass is the slug.

1 slug = 14.593903 kg based on standard gravity.

**Or**

We can use poundals (pdl) of force and pounds (lb) of mass.

1 pdl = 0.138254954376 N

**Or**

We can distinguish between Pound Mass (lb_m) and Pound Force (lb_f).

lb_m = 0.45359237 Kg

lb_f = 4.448222 N

What's confusing here is that a scale for measuring *weight* can be calibrated to provide Kg of *mass* instead of Newtons of force
because the acceleration of gravity at sea level is essentially constant.

In the imperial units, the distinction between weight and mass was not carefully
defined, leading to units like poundals of fource or slugs of mass.

The velocity and radius units are correct.

Legacy Introduction
~~~~~~~~~~~~~~~~~~~~~

::

    CENTRIFUGAL/CENTRIPETAL Force                           by George Murphy VE3ERP

     DEFINITIONS:

     CENTRIFUGAL FORCE: Force directed in a straight line away from the centre.

     CENTRIPETAL FORCE: Force directed in a curve toward the centre of rotation.

     In either case the force is the same.

Legacy Output
~~~~~~~~~~~~~~

Note that this has a math error. The numbers are incorrect. The format and the displayed units are all that's important.

::

    ENTER: Force in kilograms? 100
    ENTER: Mass in kilograms? 10
    Velocity in metres/second?
    Radius of orbit in metres? 333



    Force........... 100.000 kg =     220.460 lb.
    Mass............  10.000 kg =      22.046 lb.
    Velocity........   0.173 m./sec =   0.569 ft/sec
    Orbital Radius.. 333.000 m. =    1092.240 ft.
