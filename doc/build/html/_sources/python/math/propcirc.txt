propcirc -- Circle, Properties of
----------------------------------

Analysis
~~~~~~~~~

This is a kind of **Solver** with a number of circle elements.

Here's the canonical diagram based on the introductory text in HamCalc.

..  image:: circle.png
    :height: 2.5in

The description covers the CAB sector of the circle, triangle, and the segment.
This is the "inside triangle".

The program's description doesn't cover the second triangle very clearly.

The second triangle is the small outside triangle labeled ABD. The point D is on the circumference
midway between A and B. Line CD bisects CA and CB. The "height of segment" is this *g*.

Here's an different variation on this picture that shows the
trigonometric functions and how they apply to the triangle.

..  image:: Circle-trig6.png
    :height: 2.5in

[From the Wikimedia Commons, http://en.wikipedia.org/wiki/File:Circle-trig6.svg]

In this, the triangle is OAB instead of CAB. The Angle, *a*, is :math:`2\theta`.
The line CD is the "height of segment".

The segment labeled "chord" on this diagram is not the chord used by HamCalc; the HamCalc chord is the line AB, with a length :math:`2 R \sin \theta`.

HamCalc has a number of equations used to solve different portions of the circle.

We'll analyze that algorithm below.

In order to keep the analysis sensible, we'll stick with the
legacy variable names are as follows:

:R:
    Radius, :math:`R`.

:D:
    Diameter, :math:`D`.

:CF:
    Circumference, :math:`C_f` to make it distinct from :math:`C`.

:AR:
    Area, :math:`A_r` to make it distinct from :math:`A \times R`.

:A:
    Angle, :math:`A` (:math:`\theta` might be better.)

:C:
    Length of Chord (A-B line on diagram), :math:`C` (should be :math:`L_c`.)

:AC:
    Length of Arc (A-B on diagram), :math:`A_c` to make it distinct from :math:`A \times C` (should be :math:`L_a`.)

:B:
    Height of segment (g on diagram), :math:`B`.

The bottom line is this:

..  important:: Given *R* and *A*, all other values can be determined.

While HamCalc does quite a bit of work, it
 seems simpler, if *R* or *A* is omitted, to do the following:

**Step 1**. Compute the missing value(s) for *R*, *A* (or both) from the available values. Step 1A is to compute *R*. Step 1B is to compute *A* if possible.

**Step 2**. Compute the remaining values from *R* and *A* if it's known. This may lead to contradictory results if the input is over-specified.

There are over 40,000 combinations of the eight variables. Of these, many are over-specified; they include too many values. A user could enter contradictory values. For example,
:math:`R=5, D=5` is a potential combination that includes a contradiction.

The combination :math:`R=5, D=10`, however, has no contradiction, but omits providing a way to derive *A*.

We'll look at this "simplified" version of what HamCalc does. Below, we'll look
the legacy HamCalc code in detail.

Step 1A -- Compute *R*
^^^^^^^^^^^^^^^^^^^^^^

Deriving *R* from any one of *D*, *CF* or *AR* is easy.

..  math::

    R = \frac{D}{2}

..  math::

    R = \frac{C_f}{2\pi}

..  math::

    R = \sqrt{\frac{A_r}{\pi}}

What's left is deriving *R* from the remaining four variables, *A*, *C*, *AC* and *B*. There are six combinations.

-   *A* and *C*:

    ..  math::

        R = \frac{C}{2\sin \frac{A}{2}}


-   *A* and *AC* (line 750):

    ..  math::

        R = \frac{A_c}{A}


-   *A* and *B* (line 660):

    ..  math::

        R= \frac{B}{1-\cos \frac{A}{2} }


-   *C* and *AC*.

    Two points on the circumference are not sufficient to define a circle.
    There's no way to compute the radius.

-   *C* and *B* (line 670):

    ..  math::

        R=\frac{4B^2+C^2}{8B}

    ..  math::

        A=2\left[\pi-\left(2\arctan \frac{C}{2B}\right) \right]

-   *AC* and *B*:

    We need to solve the following for *R*.

    ..  math::

        B = R (1 - \cos \frac{A_c}{2R})

    An approximation looks sensible. There are two in the legacy program for
    determining *A*. A similar approximation may be able to determine *R*.

    There are a few constraints on the ranges of values:
    :math:`0 \leq B \leq R` and :math:`0 \leq A_c \leq 2 \pi R`
    and :math:`-1 \leq 1 - \cos \frac{A_c}{2R} \leq 1`.

    However, :math:`0 < R` is the open issue. With *R* allowed to range to
    essentially infinity, this isn't a simple bisection to locate the root.

Step 1B -- Compute *A*
^^^^^^^^^^^^^^^^^^^^^^

If we can, *A* can be computed. It's not essential, however. If omitted, then
it can be treated as zero for the purposes of computing the output values.

Deriving *A* from *R* and one of *C*, *AC* or *B* is a little more work.

There are three cases.

-   *R* and *C* (line 650):

    ..  math::

        Z = \frac{C}{2R}

    ..  math::

        A = f_1(C, R) = 2 \arctan \frac{Z}{\sqrt{1-Z^2}}

-   *R* and *AC* (line 640):

    ..  math::

        A = f_2(A_c, R) = \frac{A_c}{R}

-   *R* and *B* (lines 680 and 650):

    ..  math::

        A = f_3(B, R) = f_1( 2 \sqrt{2BR-B^2}, R )

Step 2 -- Final Results
^^^^^^^^^^^^^^^^^^^^^^^^^

Then, step 2, is to develop all the values from *R* and *A*.

..  math::

    D = 2R

..  math::

    C_f = 2\pi R

..  math::

    A_r = \pi R^2

..  math::

    C = 2R \sin \frac{A}{2}

..  math::

    A_c = R A

When *A* measured in degrees it's :math:`A_c = 2\pi R \frac{A}{360}`.

..  math::

    B = R (1 - \cos \frac{A}{2})

Bonus value: area of sector.

..  math::

    S_c = \pi R^2 \frac{A}{2\pi}

Bonus value: area of segment.

..  math::

    S_g = S_c - (R-B)\frac{C}{2}

Implementation
~~~~~~~~~~~~~~~~

This is a variant on a **Solver**. It's not purely a **Solver** since we have
so many relationships among to many variables.

Instead, we derive *R* and *A* and then compute all the derived values from those two.

Note that the sample output includes 10 output values from 8 potential input variables.

..  automodule:: hamcalc.math.propcirc
    :members:

Legacy Design
~~~~~~~~~~~~~~~

Here are the rules.  The program iterates over these rules, making it kind
of like an AI rules engine. Each decision is revisited as computations change
the available pieces of data.

In the legacy code, P is :math:`\pi`.

::

    590 IF B=0  AND A=P     THEN B=0:GOSUB 800
    600 IF AR=0 AND R<>0    THEN AR=P*R^2:D=2*R:CF=P*D
    610 IF D=0  AND R<>0    THEN D=2*R
    620 IF CF=0 AND R<>0    THEN CF=P*2*R
    630 IF AC=0 AND A*R<>0  THEN AC=A*R
    640 IF A=0  AND AC*R<>0 THEN A=AC/R
    650 IF A=0  AND R*C<>0  THEN Z=C/2/R:A=2*ATN(Z/SQR(-Z*Z+1))
    660 IF R=0  AND A*B<>0  THEN R=B/(1-COS(A/2))
    670 IF R=0  AND B*C<>0  THEN R=(4*B^2+C^2)/(8*B):A=2*(P-(2*(ATN((C/2)/B))))
    680 IF C=0  AND B*R<>0  THEN C=2*(SQR(2*B*R-B^2))
    690 IF C=0  AND A*R<>0  THEN C=2*R*SIN(A/2)
    700 IF B=0  AND R*C<>0  THEN B=R-0.5!*(SQR(4*R^2-C^2))
    710 IF B=0  AND A*C<>0  THEN B=C/2*TAN(A/4)
    720 IF B=0  AND A*R<>0  THEN B=2*R*(SIN(A/4)^2)
    730 IF R=0  AND AR<>0   THEN R=SQR(AR/P)
    740 IF R=0  AND CF<>0   THEN R=CF/(2*P)
    750 IF R=0  AND A*AC<>0 THEN R=AC/A
    760 IF A=0  AND AC*B<>0 THEN GOSUB 850
    770 IF A=0  AND AC*C<>0 THEN GOSUB 920

**590**. This is a special case to handle a angle of 180° (:math:`\pi` radians).
In this case, Diameter, *D*, Radius, *R*, and Chord Length, *C* are related simply.

    **800**. If *C* is known:  :math:`D = C`; :math:`R = \frac{D}{2}`.

    **810**. If *D* is known:  :math:`C = D`; :math:`R = \frac{D}{2}`.

    **820**. If *R* is known:  :math:`D = 2 \times R`; :math:`C = D`.

**600-620**. If the radius, *R*, is known, then Area, *AR*, Diameter, *D*, and Circumference, *CF* can all be computed.  :math:`A_r = \pi R^2`. Also :math:`D = 2 \times R` and :math:`C_f = \pi \times D`.

Ways to compute Length of Arc, *AC*:

    **630**. If Angle, *A*, and Radius, *R*, are known, then Length of Arc, *AC*, can be computed. :math:`A_c = A \times R`.

Ways to compute Angle, *A*.

    **640**. If Length of Arc, *AC*, and Radius, *R*, are known: :math:`A = \frac{A_c}{R}`.

    **650**. If  Radius, *R*,  and Length of Chord, *C*,  are known, this is two
    sides of a triangle, and the angle, *A* can be computed. :math:`Z=\frac{C}{2R}`
    :math:`A= 2 \arctan \frac{Z}{\sqrt{1-Z^2}}`.

Ways to compute Radius, *R*.

    **660**. If Angle, *A*, and Height of Segment, *B* are known:
    :math:`R= \frac{B}{1-\cos \frac{A}{2} }`

    **670**. If Length of Chord, *C*, and Height of Segment, *B* are known:
    :math:`R=\frac{4B^2+C^2}{8B}`. Angle, *A*, can also be computed. :math:`A=2\left[\pi-\left(2\arctan \frac{C}{2B}\right) \right]`

Ways to compute Length of Chord, *C*.

    **680**. If Height of Segment, *B*, and Radius, *R* are known: :math:`C=2\sqrt{2BR-B^2}`

    **690**. If Angle, *A*, and Radius, *R* are known:
    :math:`C=2R\sin{\frac{A}{2}}`

Ways to compute height of segment, *B*.

    **700**. If Radius, *R*, and Length of Chord, *C*, are known:
    :math:`B = R - \frac{1}{2}\sqrt{(4 R^2-C^2)}`

    **710**. If Angle, *A*, and Length of Chord, *C*, are known:
    :math:`B = \frac{C}{2} \tan \frac{A}{4}`

    **720**.  If  Angle, *A*, and Radius, *R*, are known:
    :math:`B = 2 R \left(\sin \frac{A}{4}\right)^2`

Yet more ways to compute Radius, *R*.

    **730**. If Area, *AR*, is known: :math:`R = \sqrt \frac{A_r}{\pi}`

    **740**. If Circumference, *CF*, is known: :math:`R = \frac{C_f}{2\pi}`

    **750**. If Angle, *A*, and Length of Arc, *AC*, are known: :math:`R=\frac{A_c}{A}`. See line 630.

More ways to compute the Angle, *A* using iterative approximations.

    **760**. If Length of Arc, *AC*, and Height of Segment, *B*, are known.
    Lines 850 to 900.

    **770**. If Length of Arc, *AC*, and Length of Chord, *C*, are known:
    Lines 920 to 970.


Legacy Introduction
~~~~~~~~~~~~~~~~~~~~~

::

    PROPERTIES OF THE CIRCLE                                    by George C. Murphy
        Draw a circular clock face. Mark 3 points on the circle: A at 10
        o'clock, B at 2 o'clock, C at the centre of the circle. Draw lines
        from A to B, B to C, and C to A.

        The following definitions apply to this diagram:

        RADIAL - any line drawn between the centre of a circle and any
          point on the circumference. Lines AC and BC are radials.
        CHORD - a straight line drawn between any two points on the
          circumference. Line AB is a chord.
        ARC - that part of the circumference which lies between any two
          points. The curved line between A and B is an arc.
        ANGLE - the angle in degrees between 2 radials that terminate at
          the ends of a chord or arc. (angle ACB on your sketch).
        SECTOR - the pie shaped figure formed by two radials and the arc
          joining their ends.
        SEGMENT - the figure formed by a chord and an arc joining the two
          ends of the chord.
        HEIGHT (of segment) - the distance between the midpoints of the
          arc and the chord that form a segment.
        DIMENSIONS can be entered in any unit of measure, as long as the
          same unit is used for all dimensions.


Sample Output
~~~~~~~~~~~~~

::

    Radius / Length of radials...    12.000 units
    Diameter.....................    24.000 units
    Circumference................    75.398 units
    Area of full circle..........   452.389 units²
    Angle between radials........    60.000°
    Length of chord AB...........    12.000 units
    Length of arc AB.............    12.566 units
    Height of segment............     1.608 units
    Area of segment..............    13.044 units²
    Area of sector...............    75.398 units²

