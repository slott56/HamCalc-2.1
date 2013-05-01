fibon -- Fibonacci Series
--------------------------

Analysis
~~~~~~~~~

The Fibonacci Series, :math:`F_n`, is defined by a simple recurrence rule.

..  math::

    F_{n+2} = F_{n+1} + F_{n}

Typically, :math:`F_0 = 1` and :math:`F_1 = 1`.

This leads to the sequence

..  math::

    \{ 1, 1, 2, 3, 5, 8, ... \}

There are number of interesting properties for the values in this series.

Most notable, the Golden Ratio, :math:`\phi`, is related to this sequence.

..  math::

    \phi \approx \frac{F_{n+1}}{F_{n}} = \frac{1+\sqrt{5}}{2}

Note that :math:`\phi` has this property:

..  math::

    \phi = (1/\phi+1)

Implementations
~~~~~~~~~~~~~~~~

The essential module has this API.

..  automodule:: hamcalc.math.fibon
    :members:

There are two implementations: object-oriented and functional.

**Object-Oriented Fibonacci Series**

..  automodule:: hamcalc.math.fibon.obj
    :members:

**Functional Fibonacci Series**

..  automodule:: hamcalc.math.fibon.func
    :members:

Legacy Introduction
~~~~~~~~~~~~~~~~~~~~

::

    FIBONACCI SERIES of Numbers                             by George Murphy VE3ERP

    A Fibonacci series is a series of numbers, positive or negative, integer or
    decimal, where each number is the sum of the two preceding numbers.

    The Fibonacci Ratio R is the value of any number in the series divided by the
    previous number. R approaches, but can never reach the Golden Ratio Phi.

    In cryptograhy (e.g., the DaVinci Code) the Golden Ratio Phi is, like the value
    of Pi, an irrational number.

     EQUATIONS:
     Pi= 4 x arctangent of 1 radian.
     Phi= (1/r+1), where r is the Fibonacci Ratio.
     n = nr² + nr where n is a Finonacci number.

     Commonly accepted practical values are:
     Pi= 3.141593 (approx.)
     Phi=1.618033989 (approx.)

Legacy Output
~~~~~~~~~~~~~~

::

     N (number)      R (ratio N/previous N)       P (ratio 1/R+1)    Diff. (P-Phi)

     0               0                            0                  0.000000
     1               1                            2                  0.381967
     2               2                            1.5                -0.118033
     3               1.5                          1.666667           0.048634
     5               1.666667                     1.6                -0.018033
     8               1.6                          1.625              0.006967
     13              1.625                        1.615385           -0.002648
     21              1.615385                     1.619048           0.001015
     34              1.619048                     1.617647           -0.000386
     55              1.617647                     1.618182           0.000149
     89              1.618182                     1.617978           -0.000055
     144             1.617978                     1.618056           0.000023
     233             1.618056                     1.618026           -0.000007
     377             1.618026                     1.618037           0.000004
     610             1.618037                     1.618033           -0.000000
     987             1.618033                     1.618034           0.000001
     1597            1.618034                     1.618034           0.000001
     2584            1.618034                     1.618034           0.000001
     4181            1.618034                     1.618034           0.000001
     6765            1.618034                     1.618034           0.000001
     10946           1.618034                     1.618034           0.000001
     17711           1.618034                     1.618034           0.000001

Legacy Quirks
~~~~~~~~~~~~~~

The Legacy did several division-by-zero operations, which were masked by adjusting the output.

The Legacy did a "regressive" series, also.
