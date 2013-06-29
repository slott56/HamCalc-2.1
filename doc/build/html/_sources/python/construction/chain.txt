..  _construction.chain:

chain -- Chain Drives
------------------------

See :ref:`construction.beltdriv`, and :ref:`construction.gearing`.

Legacy Output
~~~~~~~~~~~~~~

The following is incomplete. But it gives a flavor.

::

     No. of teeth in sprocket A ..........? 59
     No. of teeth in sprocket B ..........? 28
     ENTER: Chain No., or pitch in decimal inches ...? 25
    Chain Number ..............    25
    Chain pitch   (inches).....     0.250
    SMALL SPROCKET-No.teeth....    28
                  -Pitch dia...     2.233
    LARGE SPROCKET-No.teeth ...    59
                  -Pitch dia...     4.697
    Ratio .....................     2.107:1
    Minimum c.c.  (inches).....     3.715
    ( Press [ ENTER ] if not applicable )
    ENTER desired approx. c.c. ........? 36



    Desired c.c.  (inches).....    36.000


Analysis
~~~~~~~~~

Chain data appears to be an integer code, the pitch measurement, and
the tensile strength.

..  csv-table::

    code,pitch,TS
    25,.25,925
    35,.375,2100
    40,.5,3700
    50,.625,6100
    60,.75,8500
    80,1,14500
    100,1.25,24000
    120,1.5,34000
    140,1.75,46000
    160,2,58000
    180,2.25,80000
    200,2.5,95000
    240,3,130000
    500,3,1E7

There are several calculations here: Sprocket Size (from RPM),
Chain Size (from sprocket size) and tension/torque.

Menu Item "1" computes chain data from sprocket sizes. This is
a piece of the larger calculation. Lines 1520-1670.

    :X: No. of teeth in sprocket A
    :Y: No. of teeth in sprocket B

    ..  math::

        A &= \max(X,Y) \\
        B &= \min(X,Y) \\
        R &= X/Y

    :NO: Chain Code
    :P:  Chain pitch
    :TS: Chain Tensile Strength

    Lines 1680-2240  display the report
    and compute center-to-center spacing.

    :I: Small Sprocket Pitch Diameter
    :S: Large Sprocket Pitch Diameter.
    :V_1: Minimum c.c. (inches)

    ..  math::

        I &= P/\sin \left(\frac{\pi}{B} \right) \\
        S &= P/\sin \left(\frac{\pi}{A} \right) \\
        V_1 &= (I+S)/2+P

    :V_2: Desired approx. c.c.
    :C: Actual  c.c.  (inches)
    :L: Chain length  (pitches)
    :P*L: Chain length  (inches)

    ..  math::

        N &= V_2 / P \\
        L &= \left\lfloor 2N+\frac{A}{2}+\frac{B}{2}+\frac{\left[(A-B)/(2 \pi)\right]^2}{N} \right\rfloor \\
        L &= 2 \left\lfloor (5L+5)/10 \right\rfloor

    while :math:`C < V_1`:

        ..  math::

            L &\gets L + 2 \\
            T &= 2L-A-B \\
            U &= 0.81(A-B)^2 \\
            C &= \dfrac{P}{8}(T+\sqrt{T^2-U})

Menu Item "2" computes sprocket and chain data from shaft speeds.
This is lines 550-1500. Then it jumps to 1680 to display the report
and compute center-to-center spacing.

    :X: RPM Sprocket A
    :Y: RPM Sprocket B
    :W: Minimum teeth, small sprocket

    ..  math::

        K &= X \\
        J &= Y \\
        W_1 &= W

    While :math:`Z < 120`:

        ..  math::

            Z &= \left\lceil W \times K / J \right\rceil \\
            A_W &= \left\langle W, Z, \text{`*' if $W \times X = Y \times Z$ else `'} \right\rangle \\
            W &\gets W + 1

    After computing the various combinations, this is the number
    of rows to display.

    [Note the quirky reuse of *Y*.]

    ..  math::

        Y^\prime = \left\lfloor \frac{W - W_1}{6} \right\rfloor + 1

    Display the various formatted :math:`\lbrace A_Z | W_1 \leq Z \leq W \rbrace`
    values in a six-column display.


    After this display, then the small sprocket, *B*, is chosen.
    From this, the large sprocket, *A*, is calculated.

    ..  math::

        A &= \left\lfloor \frac{10*K*B/J+5}{10} \right\rfloor  \\
        R &= A/B \\
        E &= J \times R \\
        D &= K/R

    :E: RPM (a) X
    :J: RPM (a) Y
    :K: RPM (b) X
    :D: RPM (b) YY

    Pick either (a) or (b).

    [Note the possible bug in using *YY*.]

    :H: Drive horsepower

    Compute number of strands of various types of chain.
    Lines 1270 to 1500. This code is quirky.

    The variable *CH* starts at zero.

    Line 1280.

    If *CH* is greater than zero, this isn't a real
    search, instead it simply computes *SP* and *Q*
    for the currently found size of chain.

    This section appears to simply step through each size of chain
    looking for a size where the tensile strength is not
    exceeded.

    This uses :math:`\frac{D+J}{2}` as the RPM's
    to design for. Why an average? Why not the larger of
    *D* or *J* (which is generally *J*)?

    For *SN*, *P*, *TS* in each size of chain:

        ..  math::

            Y^\prime &= (D+J)/2 \\
            SP &= A \times P \times Y^\prime/60 \\
            Q &= 6600 H/SP \\
            & \text{if $Q \times 1.1 \leq TS$: break}

    This has located the smallest size of chain that will work.
    *SN* is the code, *P* is the pitch and *TS* is the tensile
    strength.

    If *CH* is 2, it does not compute the number of strands.
    It jumps to 1680 to produce the final report.

    ..  math::

        NS &= \left\lfloor \frac{Q}{TS} \right\rfloor + 1 \\
        & \text{if $NS \times TS < 1.1 \times Q$:} NS \gets NS + 1

    If necessary, two strands may be required. This isn't a loop,
    so the answer to the number of strands is either one or two.

    However.  During the initial *CH* = 0 pass, if SN is not 500 (the largest size)
    then the number of strands is reset to 1. Weirdly. See line 1370.

    The user is given a menu of two items.

    -   **space**. Set *CH* to 2, goes back to line 1280. This recomputes
        the current chain size, *SP* and *Q*.

    -   **zero**. Set *CH* to 1, go to line 1510 to accept manual
        input of a chain size. This does the menu item 1 calculation.

    Then jump to 1680 to display the report
    and compute center-to-center spacing.

Implementation
~~~~~~~~~~~~~~~~~~

..  automodule:: hamcalc.construction.chain
    :members:

Quirks
~~~~~~~~~

Exit isn't menu item 0. Also, there are a extra
RESTORE's.

The region from 1270 to 1500 has a peculiar looping structure,
and uses a *CH* status variable to invoke parts of the
calculation as a kind of subroutine.
