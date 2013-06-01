brick -- Masonry Estimator
-----------------------------

Legacy Output
~~~~~~~~~~~~~~~~

Introduction::

    MASONRY ESTIMATOR                                       by George Murphy VE3ERP

     │«──── A ────»│
     ┌─┬───┬───┬───┐«─┐
     ├─┴─┬─┴─┬─┴─┬─┤  │
     ├─┬─┴─┬─┴─┬─┴─┤  B
     ├─┴─┬─┴─┬─┴─┬─┤  │
     └───┴───┴───┴─┘«─┘
      Typical Panel

    │«L»│
    ┌───┐«┐H
    └───┘«┘
    Brick/Block
    Dimensions
     This program estimates quantities and dimensions for brick/block panels.

Sample Output::

     Enter all dimensions in the same units of measure (cm.,in. etc,)
     ENTER: Panel length A (in.)...........? 120
     ENTER: Panel height B (in.)...........? 60
     ENTER: Brick/block length L (in.).....? 5
     ENTER: Brick/block height H (in.).....? 3
     ENTER: Width of mortar joints (in.)...? .5

     Panel area...................     2.000 sq.feet
     Panel length...............A=   120.000 in.
     Panel height...............B=    60.000 in.
     Brick/block length.........L=     5.000 in.
     Brick/block height.........H=     3.000 in.
     Bricks/blocks per course.....    22 (approximate)(depends on pattern)
     Width of mortar joints.......     0.500 in.
     Number of bricks/blocks......   374 (approximate)

     Height B contains 17 courses


Analysis
~~~~~~~~~~

The unit of construction is brick plus joint (*J*) on each side.
:math:`U=(L+J)\times(H+J)`.

Bricks per course *B_C* is the length (*A*) divided by the brick length plus joint.
:math:`B_C = \lceil \frac{A}{L+J} \rceil`.

Total number of bricks, *N* is total area/unit size. :math:`N=\frac{AB}{U}`.

Number of courses, *N_C* is the height (*B*) divided by the brick height plus joint.
:math:`N_C = \lfloor \frac{B}{H+J} \rfloor`.

Plus unit conversions between inches and millimeters, square meters
and square feet.

And nice ASCII art diagrams.

Implementation
~~~~~~~~~~~~~~~

There's no "module" for this. It's just a simple stdio application.
