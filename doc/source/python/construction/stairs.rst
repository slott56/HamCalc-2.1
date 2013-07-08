stairs -- Stairs, Ladders & Ramps
----------------------------------

Legacy Output
~~~~~~~~~~~~~~~

Incomplete. But.

::

     FL    │«─────── SP ──────»│
      ├»═══╪═══╗«──── SW ─────»╔══ «┐
     ┌┴»═══╪═══╝           ╔═══╝e   │
     │     │           ╔═══╝        │
     HR    │       ╔═══╝           HT
     └─────┼» c╔═══╝d    BASIC      │
           ╔═══╝b       ELEMENTS    │
        ═══╝a «─────────────────────┘

See lines 2200 to 2300, "animate diagram". This makes it difficult
to determine what the output looks like.

Also, having the "Courier New" font used when viewing this page matters for
getting the ASCII art to come out exactly right.

Analysis
~~~~~~~~~~

:H:    Level-to-Level height HT
:SP:    Maximum allowable spread SP, also known as *L*.

There are two decision trees.

    The *SP* factor starts us into a decision tree.

    If SP is determined, then we can design

    -   A vertical ladder.

    -   Inclined Ramp or Step Ramp.

    -   Restricted length stairs, which can devolve to a ladder design.

    If SP is not determined, then we can design unrestricted stairs.

Once the design has been completed, the display area will
use a second decision tree based on angle, *A*, in degrees.

:P: no. of rungs, steps, ramps or treads
:N: no.of full risers
:TBR:   top and bottom risers
:A: angle
:T: run
:R: rise
:X: string
:Y: stringer
:L: length

Decision Tree
^^^^^^^^^^^^^^^^^^^^^^^^^

There are six designs available.

If *SP* has been determined, then

    [Line 450, *SP* Known.]

    [Quirk.] L = SP.

    If :math:`L = 0`: `Line 770, Vertical Ladder Design`_.

    ..  math::

        A = \arctan{ \dfrac{H}{L} }

    If :math:`A \leq 20.45`: `Line 510, Ramp Design`_.
    This can create an inclined ramp or a step ramp.

    If :math:`A > 20.45`: `Line 640, Restricted Length Risers`_.
    This can create stairs, stepladder or inclined ladder.

If *SP* has not been determined, then

    [Line 890, *SP* unknown.]

    Show recommended maximum: 7.5 in. (8.0 in. for economy) or 19 cm (20 cm for economy)

    Get *MAX*, Maximum rise desired

    Assert *MAX* is within range of 5 in. to 13.5 in or 12.5 cm to 34 cm

    [Quirk.] R = MAX.

    `Line 1060, Unrestricted Length Risers`_.

Line 510, Ramp Design
^^^^^^^^^^^^^^^^^^^^^^

There are two ramp designs: Step Ramp and Inclined Ramp.

..  math::

    N = \left\lfloor \dfrac{H}{5} \right\rfloor

If :math:`N > 1`: step ramp with risers and treads

    ..  math::

        P &= N-1 \\
        R &= \frac{H}{N} \\
        T &= \frac{L}{P}

Else if :math:`N \leq 1`: inclined ramp

    ..  math::

        P = R = T = 0


Line 640, Restricted Length Risers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are three restricted riser designs: Stairway, Step Ladder and Inclined Ladder. It's also possible that a Vertical Ladder might be required.

Compute the number of risers by incrementing N.

While :math:`(TN-T \leq L) \text{ AND } (R \geq 5)`:

    ..  math::

        N &\gets N + 1 \\
        R &= \frac{H}{N} \\
        T &= 20 - \dfrac{4R}{3}

Back off one riser.

..  math::

    N &\gets N - 1 \\
    P &= N-1 \\
    R &= \frac{H}{N} \\
    T &= 20 - \dfrac{4R}{3}

How steep is it?

If :math:`R > 13.5 \text{ OR }  T \leq 0`: ladder, :math:`A = \dfrac{\pi}{2}`

Else: Not quite a ladder.

This next bit is quirky. Why compute this when the ladder section
will set *L* to zero?

..  math::

    L = PT

If :math:`A = \dfrac{\pi}{2} \text{ OR } A < 0`: `Line 770, Vertical Ladder Design`_.

Line 770, Vertical Ladder Design
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..  math::

    P &= \left\lceil \dfrac{H}{13.5} \right\rceil \\
    N &= P-1  \\
    TBR &= \dfrac{H-13.5N}{2}  \\
    A &= \dfrac{\pi}{2} \\
    T &= 0 \\
    R &= 13.5 \\
    X &= 0  \\
    Y &= 0  \\
    L &= 0  \\


Line 1060, Unrestricted Length Risers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is Stairway Design.

..  math::

    N &= \left\lceil \dfrac{H}{R} \right\rceil \\
    P &= N-1  \\
    R &= \dfrac{H}{N}

While :math:`R < 5`:

    ..  math::

        N &\gets N-1 \\
        P &= N - 1 \\
        R &= \dfrac{H}{N}

..  math::

    T &= 20-\dfrac{4R}{3} \\
    L &= PT \\
    A &= \arctan \dfrac{R}{T}

[Line 1160, stairs with low pitch.]

IF  :math:`17.35 \leq A_{deg} < 33`:

    ..  math::

        T=25+\dfrac{33-AD}{15.65}-2R

Line 1180 and 1190, Display
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Here's the second decision tree.

::

    1180 :REM'
    1190 :REM'.....determine type
    1200 AD=A*180/PI       :REM'angle in degrees
    1210 IF P=0 THEN B$=" INCLINED RAMP ":GOSUB 2210:GOSUB 3100:GOTO 1320
    1220 IF AD=90 THEN B$=" VERTICAL LADDER ":TR$="rungs.":GOSUB 2210:GOSUB 2840:GOTO 1320
    1230 :REM'
    1240 IF AD>77 THEN B$=" INCLINED LADDER ":TR$="rungs.":GOSUB 2210:GOSUB 2730:GOTO 1320
    1250 :REM'
    1260 IF AD>48.37 THEN B$=" OPEN-RISER STEPLADDER ":TR$="steps.":GOSUB 2210:GOSUB 2590:GOTO 1320
    1270 :REM'
    1280 IF AD>20.45 THEN B$=" STAIRWAY ":TR$="treads":GOSUB 2210:GOSUB 2460:GOTO 1320
    1290 :REM'
    1300 IF AD<=20.45 THEN B$=" STEP RAMP ":TR$="ramps.":GOSUB 2210:GOSUB 2980:GOTO 1320

It appears that it works like this.

-   Special case, P=0: Inclined Ramp. Line 3100 has the picture.

-   Angle of 90°: Vertical Ladder. Line 2840 has the picture.

-   Angle of 77° to 90°: Inclined Ladder. Line 2730 has the picture.

-   Angle of 48.37° to 77°: Open-Riser Step Ladder. Line 2590 has the picture.

-   Angle of 20.45° to 48.37°: Stairway. Line 2460 has the picture.

-   Angle less than 20.45°: Step Ramp. Line 2980 has the picture.

Lines 1310 to 2160 is the details display. Which includes some additional
calculations on lines 1690 and 1720.

..  math::

    X &=\sqrt{R^2+T^2} \\
    Y &= XP

Lines 2210 to 2300 "animate diagram". It appears to move the diagram to the right, so a new diagram can be drawn to the left.

The following sections are ASCII art, used by the display.

    Lines 2320 is the introductory stairway diagram

    Lines 2460 is stairway details

    Lines 2590 is stepladder details

    Lines 2730 is inclined ladder details

    Lines 2840 is vertical ladder details

    Lines 2980 is step ramp details

    Lines 3100 is inclined ramp details

Stairwell and Headroom
^^^^^^^^^^^^^^^^^^^^^^^^^

This is for (optional) stairwell, *SW*, and headroom, *HR*, dimensions.

It requires

:F:     Floor Thickness, FL
:SW:    Stairwell Dimension
:HR:    Headroom Dimension

::

    1490 FOR Z=1 TO N
    1500 HR=Z*R-F
    1510 IF HR>=75 THEN 1530
    1520 NEXT Z
    1530 X=N-Z    :REM'number of runs
    1540 SW=(Z-1)*T


..  math::

    Z &= \min \left\lbrace Z |_{1 \leq Z \leq N} \text{ IF } ZR-F \geq 75 \right\rbrace \\
    HR &= ZR-F \\
    X &= N - Z \text{ quirk}\\
    SW &= (Z-1)T

Note the quirk if setting *X* to a value that doesn't seem to fit
with the definition of *X*. And. That value gets overwritten later.

::

    1690 X=SQR(R^2+T^2)

Other
^^^^^

Lines 3220 is a subroutine to compute fractions from decimal values.


Implementation
~~~~~~~~~~~~~~~

This could be seen as a rather complex **Decision Tree** class hierarchy.
It's a kind of **Factory** because it emits specific design objects.

It's also a kind of **Chain of Command** structure.
A sequence of rules are chained together. Each rule either emits a design or
passes control to a fallback rule.

The subtlety is there may be back-and-forth interaction between some
design rules and some API which must gather user input.

In other cases (i.e., :program:`beltdriv`, :program:`chain`, :program:`gearing`, :program:`shaft` and :program:`torque`) there isn't a complex decision *tree*;
rather there is a sequence of steps to refine a design, so there's no
conditional back-and-forth.

In this :program:`stairs` case, though, a subsequent input is
conditional in a way that -- perhaps -- should be isolated to the calculation module, not the application itself.

Additionally, it's important to avoid peppering the output display
with too many if-statements to handle the six different special cases.
Sadly, there are other programs (e.g. :program:`beamdefl` and :program:`satorbit`) which suffer from
this design deficiency.

Top-Level Module
^^^^^^^^^^^^^^^^^^

..  automodule:: hamcalc.construction.stairs
    :members:

Function-Oriented Implementation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..  automodule:: hamcalc.construction.stairs.func
    :members:

Object-Oriented Implementation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

TBD

Quirks
~~~~~~~~~

Lines 1360 and 1640 check for ``B$="RAMP"``. No line sets B$ to ``"RAMP"``.
