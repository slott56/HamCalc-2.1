arch -- Arch Calculator
-------------------------

From the introduction::

    ARCH CALCULATOR                                         by George Murphy VE3ERP

                *H
     A*         *C        *B



                *X

     This program calculates the following elements of an arch:
                                     Curved arch AHB
                                     Chord AB
                                     Segment height CH
                                     Radii XA, XH, XB
                                     Angle AXB

     All dimensions in ANY identical units of measure:

Sample Output::

    Curved arch AHB....    10.265 units
    Chord AB...........    10.000 units
    Segment Height CH..     1.000 units
    Radii XA, XH, XB...    13.000 units
    Angle AXB..........    45.240°

Analysis
~~~~~~~~~~

This is a proper **Solver** for various features of an arch.

Input parameters are the following.

:R:
    Radii XA, XH, XB, :math:`D = 2R`.

:A:
    Angle AXB.

:C:
    Chord AB.

:AC:
    Curved arch AHB.

:B:
    Segment height CH.

Extra variables, *CF* (Circumference) and *AR* (Area) are also computed.

The Calculations::

    440 IF B=0  AND A=P     THEN B=0:GOSUB 640
    450 IF AR=0 AND R<>0    THEN AR=P*R^2:D=2*R:CF=P*D
    460 IF D=0  AND R<>0    THEN D=2*R
    470 IF CF=0 AND R<>0    THEN CF=P*2*R
    480 IF AC=0 AND A*R<>0  THEN AC=A*R
    490 IF A=0  AND AC*R<>0 THEN A=AC/R
    500 IF A=0  AND R*C<>0  THEN Z=C/2/R:A=2*ATN(Z/SQR(-Z*Z+1))
    510 IF R=0  AND A*B<>0  THEN R=B/(1-COS(A/2))
    520 IF R=0  AND B*C<>0  THEN R=(4*B^2+C^2)/(8*B):A=2*(P-(2*(ATN((C/2)/B))))
    530 IF C=0  AND B*R<>0  THEN C=2*(SQR(2*B*R-B^2))
    540 IF C=0  AND A*R<>0  THEN C=2*R*SIN(A/2)
    550 IF B=0  AND R*C<>0  THEN B=R-0.5!*(SQR(4*R^2-C^2))
    560 IF B=0  AND A*C<>0  THEN B=C/2*TAN(A/4)
    570 IF B=0  AND A*R<>0  THEN B=2*R*(SIN(A/4)^2)
    580 IF R=0  AND AR<>0   THEN R=SQR(AR/P)
    590 IF R=0  AND CF<>0   THEN R=CF/(2*P)
    600 IF R=0  AND A*AC<>0 THEN R=AC/A
    610 IF A=0  AND AC*B<>0 THEN GOSUB 640
    620 IF A=0  AND AC*C<>0 THEN GOSUB 700

**440**. If :math:`A = \pi` and *B* is unknown: :math:`B = 0`; approximate *A* via 640. This seems needless.

**450**. Given *R*:
:math:`A_R=\pi R^2; D=2R; C_F=\pi D`

**460**. Given *R*: :math:`D=2R`

**470**. Given *R*: :math:`C_F=2 \pi R`

**480**. Given *A* and *R*:  :math:`A_C=A R`

**490**. Given *AC* and *R*:  :math:`A=A_C/R`

**500**. Given *R* and *C*:  :math:`A=\arcsin \dfrac{C}{2R}`

    Legacy uses a trig identity :math:`\arcsin X = \arctan \frac{X}{\sqrt{1-X^2}}`.

**510**. Given *A* and *B*: :math:`R=\dfrac{B}{1-\cos(A/2)}`

**520**. Given *B* and *C*:
:math:`R=\dfrac{4B^2+C^2}{8B}; A=2(\pi-2\arctan\frac{C/2}{B})`

**530**. Given *B* and *R*: :math:`C=2\sqrt{2BR-B^2}`

**540**. Given *A* and *R*: :math:`C=2R\sin \frac{A}{2}`

**550**. Given *R* and *C*: :math:`B=R-\frac{1}{2}\sqrt{4R^2-C^2}`

**560**. Given *A* and *C*: :math:`B=\dfrac{C}{2}\tan \frac{A}{4}`

**570**. Given *A* and *R*: :math:`B=2R(\sin \frac{A}{4})^2`

**580**. Given *AR*: :math:`R=\sqrt{\dfrac{A_R}{\pi}}`

**590**. Given *CF*: :math:`R=\dfrac{C_F}{2\pi}`

**600**. Given *A* and *AC*: :math:`R=A_C/A`

**610**. Given *AC* and *B*: approximate *A* via 640.

**620**. Given *AC* and *C*, approximate *A* via 700.
This doesn't look completely sensible.

Line 640 says this.

::

    640 :REM'.....solve angle A by iteration if AC (arc) and B (height) known

Solve *A* from AHB (*AC*) and the segment height CH (*B*).
In :ref:`math.propcirc`, these are called *AC* and *B*, also.
The :mod:`hamcalc.math.propcirc` module has :func:`hamcalc.math.propcirc.arc_height_2_r` which does precisely this.

Line 700 says this:

::

    700 :REM'.....solve angle A by iteration if AC (arc) and C (chord) known

Is an approximation even possible? Two points do not define a circle,
this may not actually be sensible.

Implementation
~~~~~~~~~~~~~~~~

Note that some optimization may be possible. Specifically, it
may be possible to follow the two-phase strategy shown in :ref:`math.propcirc`.
First, compute the **essential** parameters from the inputs;
second, comute all remaining derived values from the essential values.

..  automodule:: hamcalc.construction.arch
    :members:

Legacy Quirks
~~~~~~~~~~~~~~~~

The "solver" algorithm in lines 410-630 iterates 21 times.
There are only five unknowns.

Being sure that ``B`` really is zero and A is really ``pi``?

::

    440 IF B=0  AND A=P     THEN B=0:GOSUB 640

