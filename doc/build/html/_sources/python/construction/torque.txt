..  _construction.torque:

torque -- Torque & Horsepower
-------------------------------

See :ref:`construction.beltdriv`,
:ref:`construction.chain`,
:ref:`construction.gearing`,
and :ref:`construction.shaft`.

Analysis
~~~~~~~~~~~~~~~

This is a **Solver** for the relationships among several
values:

:R: R.P.M.
:D: Pitch dia.(gear/sprkt.)
:T: Torque (in.lb.)
:H: Horsepower
:W: Force in lb.(belt/chain tension)
:V: Velocity (feet/min.)

There are two interrelated sets of calculations.

The Velocity-RPM-Diameter

..  math::

    V &= \frac{\pi}{12}DR \\
    R &= \frac{12}{\pi}V/D \\
    D &= \frac{12}{\pi}V/R

The Torque-Force-Horsepower based on Velocity, RPM or Diameter.

..  math::

    T &= WD/2 \\
    H &= WV/33000 \\
    H &= TR/63025 \\
    T &= 63025H/R \\
    W &= 33000H/V \\
    R &= 63025H/T

Implementation
~~~~~~~~~~~~~~~

..  automodule:: hamcalc.construction.torque
    :members:

Quirks
~~~~~~~~

As with other solvers, this iterates through the various rules. It iterates
seven times, as if each rule might be used one time.

Rather than execute all seven rules, however, there are several GOTO's to
somehow optimize the rule execution.
