"""hamcalc.math.fibon -- Fibonacci Numbers

Here are some test cases.

>>> import hamcalc.math.fibon as fibon
>>> list( fibon.fibon_last_iter( last=100 ) )
[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
>>> list( fibon.fibon_count_iter( count=5 ) )
[1, 1, 2, 3, 5]

There are two implementations.

-   Functional. This uses a generator function.

-   Object-Oriented. This uses recursive method and memoization.

"""

__version__ = "2.1"

import math
from hamcalc.math.fibon.obj import *

introduction = """\
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
 Pi= 3.141592653589793 (approx.)
 Phi= 1.618033988749895 (approx.)
"""

def intro():
    """Returns the text from the introductory page."""
    return introduction

phi= (1+math.sqrt(5))/2
