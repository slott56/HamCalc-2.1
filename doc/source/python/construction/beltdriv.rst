beltdriv --  Belt Drives
-------------------------

Legacy Output
~~~~~~~~~~~~~~~

Intro and Menu::

    BELT DRIVES (V-belts/Gear belts)                        by George Murphy VE3ERP

      Press number in < > to select:

      < 1 >  Pulleys known
      < 2 >  Pulleys unknown, R.P.M.'s known

      < 0 >  Exit

The following is incomplete.

Sample Output::

    ENTER: Pitch dia. - Pulley A  (in.)...? 5
    ENTER: Pitch dia. - Pulley B  (in.)...? 2.5
    Pitch diameter - small pulley.......     2.500
    Pitch diameter - large pulley.......     5.000
    Minimum c.c.(in.)...................     4.250
    Ideal   c.c.(in.)(V-belt drives)....     6.250
    ENTER: Desired c.c.distance (in.)...? 8
    Desired c.c.(in.)...................     8.000
    Design Belt length (in.)............    16.405
    ENTER: Nearest standard belt (in.)..? 17
    BELT TOO SHORT - Try a longer belt! ( Press SPACE BAR to continue )


Analysis
~~~~~~~~~

There are several calculations here: Pulley Size (from RPM),
Belt Size (from pulley size) and tension/torque.

Menu Item "1" computes belt size from pulley sizes. This is
a piece of the larger calculation.

    :E: Small Pulley Diameter
    :D: Large Pulley Diameter
    :I: Mimumum c.c.
    :G: Ideal c.c. (V-belt drives)

    ..  math::

        R &= D/E \\
        & \begin{cases}
        G &= (D+E)/2+E \text{ if $R < 3$} \\
        G &= 2*D \text{ if $R \geq 3$}
        \end{cases} \\
        I &= \frac{D+E}{2}+0.5

    :C: Desired c.c.
    :M: Design Belt length

    ..  math::

        V &= \frac{\pi}{2}(D+E) \\
        W &= \frac{(D-E)^2}{4C} \\
        M &= 2C+V+W

    :L: Nearest standard belt
    :C: Actual  c.c.

    ..  math::

        F &= 4L-2\pi(D+E) \\
        H &= 32(D-E)^2 \\
        \text{if } & F^2<H \text{ belt is too short} \\
        C &= \frac{F+\sqrt{F^2-H}}{16} \\
        \text{if } & C < I \text{ belt is too short}

    Since RPM's aren't known, nothing more is computed.

Menu Item "2" computes pulley sizes, belt length, and torque given
RPM's. This is the full calculation.

    :X: Known R.P.M.
    :Y: Sought R.P.M.

    Given a collection, :math:`\lbrace A_i | 0 \leq i < n\rbrace`, of *n*
    pitch sizes, we have a number of alternative wheel combinations.

    ..  math::

        P_i &= \frac{A_i}{Y/X} \\
        Q_i &= A_i\times(Y/X)

    :W: Selected Pulley, from the :math:`A_i` collection
    :V: Calculated Pulley, either :math:`P_i` or :math:`Q_i`

    We need to replace *V* with a standard-sized pulley
    close to the computed size, :math:`V^\prime`.

    There are four cases that can occur. Avoiding any swapping
    of large and small values greatly simplifies this.

    -   *X* RPM is larger, target *Y* is smaller: we're reducing RPM.

        -   Large pulley is standard (*W*) and small is computed (*V*):
            Small pulley at *X* RPM, large pulley at :math:`Y^\prime=XV/W`.

        -   Small pulley is standard (*W*) and large is computed (*V*):
            Small pulley at *X* RPM, large pulley at :math:`Y^\prime=XW/V`.

    -   *X* RPM is smaller, target *Y* is larger: we're increasing RPM.

        -   Large pulley is standard (*W*) and small is computed (*V*):
            Large pulley at *X* RPM, small pulley at :math:`Y^\prime=XW/V`.

        -   Small pulley is standard (W) and large is computed (V)
            Large pulley at *X* RPM, small pulley at :math:`Y^\prime=XV/W`.

    This sets *D* and *E* for the large and small pulleys, as well as
    the calculated value of *Y*, :math:`Y^\prime`.

    From here, calculation one (above) for belt length is done based
    on pulley sizes.

    Finally, since ``X`` and :math:`Y^\prime` are known from RPM calculations,
    and ``D`` and ``E`` are known from pulley sizing
    then the tension, speed and torque can be computed.

    :HP:    Horsepower
    :VL:    Velocity on small pulley
    :TN:    Tension (lbs.) on belt(s)
    :TE:    In./lb. torque - small pulley shaft
    :TD:    In./lb. torque - large pulley shaft

    ..  math::

        V_L &= 0.2618 E X \\
        T_N &= \frac{33000 HP}{V_L} \\
        T_E &= \frac{T_N E}{2} \\
        T_D &= \frac{T_N D}{2}


Implementation
~~~~~~~~~~~~~~~~

..  automodule:: hamcalc.construction.beltdriv
    :members:
