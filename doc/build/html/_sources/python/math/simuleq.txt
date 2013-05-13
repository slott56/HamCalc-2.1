..  _`math.simuleq`:

simuleq -- Simultaneous Equation Calculator
---------------------------------------------

From the comments::

    20 :REM'ref:"57 Practical Programs & Games in BASIC", Radio Shack cat. no. 62-2008

Therefore, the HamCalc program is a rewrite of a program in the Radio Shack book.
It doesn't seem valuable to attempt to preserve this rewrite of a published solution.

Analysis
~~~~~~~~~~~~~

Solving *n* equations in *n* unknowns is done by using Guassian Elimination
and Back Substituion.

..  math::
    x -  3y +  z = 4

    2x - 8y + 8z = -2

    -6x + 3y - 15z = 9

This can be represented as a matrix:

..  math::
    \begin{bmatrix}
         1& -3&   1& \vert &  4 \\
         2& -8&   8& \vert & -2 \\
        -6&  3& -15& \vert &  9 \\
    \end{bmatrix}

The Gaussian Elimination leads to this matrix:

..  math::
    \begin{bmatrix}
    1& 0& 0& \vert & 3 \\
    0& 1& 0& \vert &-1 \\
    0& 0& 1& \vert &-2 \\
    \end{bmatrix}

Which is interpreted as:

..  math::
    x = 3

    y = -1

    z = -2


Implementation
~~~~~~~~~~~~~~~~

See :mod:`hamcalc.math.curvefit` (:ref:`math.curvefit`) for an implementation of Gaussian Elimination that can also be used to solve *n* equations in *n* unknowns.

In a way, the general Gaussian Elimination is "overkill" for two equations
in two unknowns. But it's also a simple, general solution that can easily
be reused.

Legacy Quirks
~~~~~~~~~~~~~~

The legacy HamCalc program could only solve two or three equations
in two or three unknowns.
