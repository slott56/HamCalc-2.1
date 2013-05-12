polygon -- Polygon Dimensions
------------------------------

Analysis
~~~~~~~~~

This program computes the following features of a regular N-sided Polygon

Given

N = "Number of sides/radials"

..  math::

    A = \frac{2 \pi}{N}

    B = \frac{A}{2}

And one of these:

-   H = "Perpendicular distance from centre to mid point of each side"

    ..  math::

        R = \frac{H}{\cos B}

        S = 2 H \tan{B}

-   R = "Length of radial from centre to end of each side"

    ..  math::

        H = R \cos{B}

        S = 2 R \sin{B}

-   S = "Length of each side"

    ..  math::

        H = \frac{S}{2 \tan B}

        R = \frac{S}{2 \sin B}


It computes the following:

H = "Perpendicular distance from centre to mid point of each side"

R = "Length of radial from centre to end of each side"

A = "Angle between radials"

S = "Length of each side"

P = "Perimeter"

..  math:: P = N \times S

D = "Circumference of circle running thru mid points of sides"

..  math:: D = 2 \pi H

E = "Circumference of circle running thru end points of sides"

..  math:: E = 2 \pi R

C = "Area of polygon"

..  math:: C= \frac{S H N}{2}

Implementation
~~~~~~~~~~~~~~

This is a **Solver** that works with B, S and H to derive the missing values.

..  automodule:: hamcalc.math.polygon
    :members:

Quirks
~~~~~~~~~~~

The GOSUB/GOTO tangle between lines 440 and 480 is hopeless.
A RETURN or something would be helpful.

