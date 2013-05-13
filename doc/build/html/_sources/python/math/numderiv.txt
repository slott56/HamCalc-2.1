numderiv -- Numbers and Functions
----------------------------------

- Logarithms to any base

- Numbers and Functions

- Powers of numbers

- Reciprocals of numbers

- Roots of numbers

Analysis
~~~~~~~~~~

There are three menu items:

-   Powers, roots, reciprocals & logarithms

    ::

        360 PRINT " Number.................................";A
        370 PRINT " Square.................................";A^2
        380 PRINT " Cube...................................";A^3

    etc.

    For any given :math:`n \neq 0`:

    ..  math::

        n^2, n^3, \sqrt n, \sqrt[3]{n}, n^{-1}=\frac{1}{n}, \log n, \log_{10} n

-   Antilogarithms

    ::

        570 PRINT "        Value of logarithm...............";A
        580 ANL=EXP(A)
        590 PRINT "        Antilogarithm if natural log.....";ANL
        600 ACL=10^A
        610 PRINT "        Antilogarithm if common log......";ACL

    For any given :math:`n`:

    ..  math::

        e^n, 10^n

-   Logarithms to any base

    For any given base, :math:`b` and :math:`n \neq 0`:

    ..  math::

        \log_{b} n = \frac{\log n}{\log b}

Implementation
~~~~~~~~~~~~~~~~

This is all in the exiting Python :mod:`math` package.

Which raises a subtle question of what to test and how to test it.

Legacy Quirks
~~~~~~~~~~~~~~

None, really.
