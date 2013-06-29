..  _construction.gearing:

gearing -- Gears & Gearing
---------------------------

See :ref:`construction.beltdriv` and :ref:`construction.chain`.

Legacy Output
~~~~~~~~~~~~~~

Heading::

    GEARING DESIGN                                          by George Murphy VE3ERP

Sample Output::

    ENTER: Diametrical pitch ............? 35
    ENTER: Known  R.P.M. ................? 3500
    ENTER: Sought R.P.M. ................? 1700
    ENTER: Desired c.c. distance (in.) ..? 4


    Diametrical pitch ............ 35
    Known  R.P.M. ................ 3500
    Sought R.P.M. ................ 1700
    Desired c.c. distance (in.) .. 4

    Combinations of gear teeth and sought R.P.M.:

          Gear A  Gear B  c.c.(in.)    R.P.M.

    ( 1 )     88     181     3.84    1701.66
    ( 2 )     89     183     3.89    1702.19
    ( 3 )     90     185     3.93    1702.70
    ( 4 )     91     187     3.97    1703.21
    ---------------------------------------
    ( 5 )     92     189     4.01    1703.70
    ---------------------------------------
    ( 6 )     93     191     4.06    1704.19
    ( 7 )     94     194     4.11    1695.88
    ( 8 )     95     196     4.16    1696.43
    ( 9 )     96     198     4.20    1696.97

    Press number in ( ) to indicate your selection
    ( Press [ENTER] if not applicable )
    ENTER: (if applicable) Horsepower.........? 80
    GEARING SPECIFICATIONS
    Diametrical pitch ...............    35
    Gear A - No. of teeth ...........    82
           - Pitch diameter (in.) ...     2.343
           - R.P.M. .................  3500.000
           - Shaft torque (in./lb)...  1441
    Gear B - No. of teeth ...........   169
           - Pitch diameter (in.) ...     4.829
           - R.P.M. .................  1703.704
           - Shaft torque (in./lb)...  2959
    C.C. (inches) ...................     0.000
    Ratio ...........................     2.061:1
    Horsepower ......................    80.000

Analysis
~~~~~~~~~

There are several calculations here: gear Size (from RPM),
and gear location (from gear size) and torque.

Menu Item 1 calculates some design features given the
gear sizes. This is
a piece of the larger calculation.

    :P: "Diametrical pitch", must not be zero
    :A: No. of teeth - Gear A
    :B: No. of teeth - Gear B

    ..  math::

        D &= \dfrac{A}{P} \\
        E &= \dfrac{B}{P} \\
        C &= \dfrac{D+E}{2} \\
        R &= \begin{cases}
            A/B & \text{if $A/B > 1$}, \\
            B/A & \text{if $A/B \leq 1$}
        \end{cases}

    :D: Pitch Diameter of A
    :E: Pitch Diameter of B
    :C: Center-to-center distance
    :R: Ratio

Menu Item 2 calculates the gear sizes from RPM, as well
as shaft torque. This is the complete calculation.

    :P: Diametrical pitch, must not be zero
    :L: Known RPM
    :S: Sought RPM
    :C: Desired c.c. distance (in.)

    Sanity Check:

    ..  math::

        K, S &= \max(L,S), \min(L,S) \\
        R &= \dfrac{K}{S} \\
        A &= \left\lceil 2 \times P \times \dfrac{C}{1+R} \right\rceil

    If :math:`A < 8`, there are too few teeth.  Either
    a finer pitch needs to be used or a larger C.C. distance.
    Both alternatives lead to more teeth.

    If :math:`A \geq 8`, the design is acceptable.

    Table of nine alternatives:

    ..  math::

        A^\prime & \in \lbrace A-4, A-3, ..., A+4 \rbrace \\
        B_{A^\prime} &= \left\lceil A^\prime \times R \right\rceil \\
        C_{A^\prime} &= \left\lceil (A^\prime+B)/2P \right\rceil \\
        S_{A^\prime} &= \dfrac{BS}{A^\prime}

    The middle of the nine alternatives (:math:`A^\prime=A`) will be
    the closest to the requested configuration.

    The legacy application makes a quirky use of dimensioned array named
    *A* to save *S_N* values; these are the final design values for *S*,
    the actual RPM for the smaller gear. Its not clear why this can't
    be computed.

    The user picks a specific size, *N*, :math:`A-4 \leq N \leq A+4`.

    ..  math::

        A &= N \\
        L, S &= \max(L, S_N), \min(L, S_N) \\
        B &= \left\lceil A \times R \right\rceil \\
        D &= A / P \\
        E &= B / P \\
        C &=  \left\lceil (D+E)/2 \right\rceil

    :H: Horsepower
    :I: Shaft torque
    :J: Shaft torque

    ..  math::

        I &= \frac{63025H}{K} \\
        J &= \frac{63025H}{S}

    Given that *A* and *B* are known, the gearing information
    can be displayed, including shaft torque.

Implementation
~~~~~~~~~~~~~~~~

..  automodule:: hamcalc.construction.gearing
    :members:

Quirks
~~~~~~~~~~

::

    260 IF Z$="1"THEN CLS:GOTO 330
    270 IF Z$="2"THEN CLS:GOTO 330

A few lines later...

::

    330 :REM'.....start
    340 COLOR 7,0,0
    350 INPUT "ENTER: Diametrical pitch ............";P
    360 IF P=0 THEN CLS:GOTO 320
    370 IF Z$="1"THEN 770

So, Really, option #2 is lines of code starting at 770.
Option #1 is lines of code starting at 330.
And there are three overlapping lines of code (340, 350 and 360).

