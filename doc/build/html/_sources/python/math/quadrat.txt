quadrat -- Quadratic Equation Calculator
----------------------------------------

From the introduction

::

    QUADRATIC EQUATION CALCULATOR                           by George Murphy VE3ERP

    This programs solves quadratic equations

    Quadratic equation: ax²+bx+c= 0

    This program calculates 2 values of x:
     x1 when b²-4ac >= 0  (if b²-4ac < 0 THEN x1 cannot be calculated)
     x2 when b²+4ac >= 0  (if b²-4ac < 0 THEN x2 cannot be calculated)
        (ref. Machinery's Handbook, revised 21st edition, page 118)

Analysis
~~~~~~~~~~

Solution to this:

..  math:: 0 = Ax^2+Bx+C

is this:

..  math::

    x = \frac{-B \pm \sqrt{B^2-4AC}}{2A}

This has some numeric stability issues. It's less than ideal as
a general solution.

Example of badly-behaved quadratic.

..  math::

    0 = x^2 + 100000 + 1

Correct answers are

-   x_1 = -99999.99999

-   x_2 = -1.000000000e-05

The ``x_2`` value will show error bits because of the instability
issue.

The preferred solution is this.

..  math::

    q = -\frac{1}{2} ( B + \operatorname{sgn}(B)\sqrt{B^2-4AC} )

    x_1 = \frac{q}{A}

    x_2 = \frac{C}{q}

Where :func:`sgn` is the sign function: :math:`1 \text{ if } B \geq 0 \text{ else } -1`.

Here's an example of **really** badly-behaved quadratic. This requires
quad-precision! We don't expect to solve this with the built-in
Python float type.

..  math::

    0 = 94906265.625x^2 - 189812534x + 94906268.375

Correct answers are

-   x_1 = 1.000000028975958

-   x_2 = 1.000000000000000

Common incorrect answers for modern 80-bit floating-point processors
are x_1 and x_2 = 1.000000014487979.


Implementation
~~~~~~~~~~~~~~

The :mod:`cmath` package includes the :func:`cmath.sqrt` which properly
returns complex values instead of raising an exception.

..  automodule:: hamcalc.math.quadrat
    :members:

Legacy Quirks
~~~~~~~~~~~~~~

The introduction is wrong. :math:`B^2+4AC` is irrelevant.

It should say something like::

    When b²-4ac >= 0, computes x1 and x2 as real values
    When b²-4ac < 0, the values of x1 and x2 are complex numbers

The results **can** be calculated rather simply.
