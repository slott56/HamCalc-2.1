solutri -- Triangles, solution of
-----------------------------------

Analysis
~~~~~~~~~~

The separation into right-triangle and non-right-triangle is mostly a quirk.
At best, it saves entering "90°" for one of the angles.

..  note:: Right Triangle Rules

    In the case of a right triangle, there's a known 90° angle. Given
    one angle, :math:`\theta`, the remaining angle is :math:`90-\theta`.

    The lengths of the sides of a right triangle follow the Pythagorean Theorem: :math:`c^2+d^2=e^2`. Two sides determine the third.

    Since one angle is 90°, two sides or angles define the remaining five values.
    There are 10 combinations of the five values; because the angles are so simple, the combinations boil down to three rules for pairs of sides and three rules
    for side and angle.

HamCalc does an "incremental" solution. Given two angles it will compute the third, making no effort to compute the sides.

In the general case, there are 15 combinations of values.
The three angles are *f*, *g* and *h*,
measured in radians. The three sides are *I*, *J*, and *K*.

-   Three sides, *I*, *J*, and *K*, known. We can compute the angles.

    ..  math::

        S=(I+J+K)/2

    ..  math::

        f=2 \arctan{\sqrt{\frac{(S-J)(S-I)}{S(S-K)}}}

    Similar formulae provide values for *g* and *h*.

-   Two angles known: *f* and *g*, *f* and *h* or *g* amd *h*.
    The third angle is :math:`h = \pi - (f+g)` or some variant for the other two
    combinations.

-   Three angles known and one side give us the two other sides. *f*, *g* and *h* and a side (*I*, *J* or *K*):

    ..  math::

        J=I \frac{\sin h}{\sin g}

    ..  math::

        K=I \frac{\sin f}{\sin g}

    Three similar pairs of equations deduce other pairs of sides from three angles and a side.

-   One angle and an adjacent and opposite sides known -- for example, *f*, *J* and *K* -- we can derive another angle.

    ..  math::

        h = \arcsin{\frac{J}{K}\sin f}

    Given two angles, we can deduce the missing angle. Now we're working
    with three angles and two sides, so the third side is also available
    using rules above.

-   One angle and two adjacent sides known -- for example, *f*, *I* and *J* -- we can derive the missing side.

    ..  math::

        K = \sqrt{I^2+J^2-(2IJ\cos f)}


Implementation
~~~~~~~~~~~~~~~~

This is a sophisticated **Solver** with six variables.

It can deal with just three angles or various combinations of sides
and angles.

..  automodule:: hamcalc.math.solutri
    :members:

Quirks
~~~~~~~~~

Having a separate right-triangle case is a quirk. The general case
with one angle = 90° will produce the correct answers, also.

The use of similar single-letter variables (F, G, H, I, J, K) for angles and sides makes the code somewhat difficult to interpret.

The implementation of arcsin and arccos is peculiar. Rather than define
proper functions, a ``GOSUB`` using three global variables is used.

Here's the "definition":

::

    380 :REM'.....inverse sin and cos
    390 ASN=ATN(X/SQR(-X*X+1))         :REM'arc sin
    400 ACS=-ASN+PI/2                  :REM'arc cos
    410 RETURN

Here's a "reference". This line will put a value in ``X``, then ``GOSUB 380`` and
find a value in ``ASN`` and ``ACS``.

::

    1080 IF D*E THEN C=SQR(E^2-D^2):X=D/E:GOSUB 380:T1=ASN:T2=PI/2-T1:GOTO 1460


The legacy application has a kind of cool character-mode graphics look-and-feel.
The values are displayed adjacent to the relevant bits of the triangle.

Legacy Menu
~~~~~~~~~~~~~~~

::

    SOLUTION OF TRIANGLES                                   by George Murphy VE3ERP

                  |\                                     /^\
                  |  \                                 / (f) \
                  |(a) \                             /         \
                  |      \                      <i>/             \<j>
                  |        \<e>                  /                 \
                  |          \                 /                     \
               <d>|        (b) \             / (h)                 (g) \
                  |_ _ _ _ _ _ _ \         /_ _ _ _ _ _ _ _ _ _ _ _ _ _ _\
                        <c>                              <k>

               RIGHT-ANGLED TRIANGLE           OBLIQUE-ANGLED TRIANGLE
               ─────────────────────           ───────────────────────
             (a),(b) are the angles          (f),(g),(h) are the angles
             <c>,<d>,<e> are the sides       <i>,<j>,<k> are the sides

