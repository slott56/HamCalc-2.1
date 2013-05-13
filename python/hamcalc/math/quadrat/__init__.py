"""hamcalc.math.quadrat -- Quadratic Equation Calculator

The standard formula has a minor numeric stability issue.

Instead of using this:

..  math::

    x = \\frac{-B \\pm \\sqrt{B^2-4AC}}{2A}

We'll use the following alternative.

..  math::

    q = -\\frac{1}{2} ( B + \\operatorname{sgn}(B)\\sqrt{B^2-4AC} )

    x_1 = \\frac{q}{A}

    x_2 = \\frac{C}{q}

Where :func:`sgn` is the sign function: :math:`1 \\text{ if } B \\geq 0 \\text{ else } -1`.

Test Cases

>>> import hamcalc.math.quadrat as quadratic
>>> import math
>>> quadratic.solve( 1, 4, 3 )
(-3.0, -1.0)
>>> quadratic.solve( 1, 0, 1 )
((-0-1j), (-0+1j))
>>> quadratic.solve_real( 1, 0, 1 ) #doctest: +IGNORE_EXCEPTION_DETAIL
Traceback (most recent call last):
  File "/Library/Frameworks/Python.framework/Versions/3.2/lib/python3.2/doctest.py", line 1288, in __run
    compileflags, 1), test.globs)
  File "<doctest default[3]>", line 1, in <module>
    quadratic.solve_real( 1, 0, 1 ) #doctest: +IGNORE_EXCEPTION_DETAIL
  File "/Users/slott/github/local/HamCalc-2.1/python/hamcalc/math/quadrat/__init__.py", line 51, in solve_real
    raise Error( "No Real Roots" )
hamcalc.math.quadrat.Error: No real roots
>>> quadratic.solve( 1, 200, -0.000015 )
(-200.000000075, 7.4999999971875e-08)
>>> quadratic.solve( 1, 100000, 1 )
(-99999.99999, -1.0000000001000001e-05)

The classic formula provides a less accurate value of -1.0000003385357559e-05 instead of
the closer-to correct -1.0000000001000001e-05.

>>> a, b, c = 1, 100000, 1
>>> (-b+math.sqrt(b*b-4*a*c))/(2*a)
-1.0000003385357559e-05
>>> (-b-math.sqrt(b*b-4*a*c))/(2*a)
-99999.99999

We don't expect the folllowing to work correctly at all.
This will produce known incorrect results of
``(1.0000000144879793, 1.000000014487979)``.
The test code is here, but it's skipped as far as unit testing
for validation.

>>> quadratic.solve( 94906265.625, -189812534.0, 94906268.375 ) #doctest: +SKIP
(1.000000028975958, 1.0)
"""
import cmath
import math

introduction="""\
QUADRATIC EQUATION CALCULATOR                           by George Murphy VE3ERP

This programs solves quadratic equations

Quadratic equation: ax²+bx+c= 0

This program calculates 2 values of x:
  When b²-4ac >= 0, computes x1 and x2 as real values
  When b²-4ac < 0, the values of x1 and x2 are complex numbers
    (ref. Machinery's Handbook, revised 21st edition, page 118)
"""

def intro():
    return introduction

class Error( Exception ):
    pass

def sgn( b ):
    return 1.0 if b >= 0 else -1.0

def solve( a, b, c ):
    if a == 0:
        raise Error( "Not quadratic" )
    if b*b - 4*a*c < 0:
        q = -0.5*(b + sgn(b) * cmath.sqrt( b*b - 4*a*c ) )
    else:
        q = -0.5*(b + sgn(b) * math.sqrt( b*b - 4*a*c ) )
    return q/a, c/q

def solve_real( a, b, c ):
    if b*b - 4*a*c < 0:
        raise Error( "No real roots" )
    return solve( a, b, c )

