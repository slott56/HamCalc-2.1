"""hamcalc.math.fibon.obj -- Fibonacci Numbers, object-oriented implementation.

This module defines a callable class which can efficiently
generate Fibonacci numbers.

It also defines two useful generator functions to provide sequences
of Fibonacci numbers.

Test Cases

>>> import hamcalc.math.fibon.obj as fibon
>>> fibon_func= fibon.Fibonacci()
>>> a, b = fibon_func(11), fibon_func(12)
>>> a
144
>>> b
233
>>> b/a
1.6180555555555556
>>> list( fibon.fibon_count_iter( count=5 ) )
[1, 1, 2, 3, 5]
>>> list( fibon.fibon_last_iter( last=100 ) )
[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

For HamCalc compatibility, use f_0=0 in the constructor.
This will yield a Fibonacci Series that starts with zero.

"""

__version__ = "2.1"

from collections import Callable
import itertools

class Fibonacci( Callable ):
    """Returns the *n*\ th Fibonacci number."""
    def __init__( self, f_0=1, f_1=1 ):
        self._memo= { 0: f_0, 1: f_1, 2: f_1+f_0 }
    def __call__( self, n ):
        if n not in self._memo:
            f_n = self.__call__( n-1 ) + self.__call__( n-2 )
            self._memo[n]= f_n
        return self._memo[n]

def fibon_count_iter( f_0=1, f_1=1, count=22 ):
    """Yields a sequence of Fibonacci numbers bounded by count.

    :param f_0: The first number, default is 1.
    :param f_1: The second number, default is 1.
    :param count: The number of numbers to return.
    """
    fibon=Fibonacci(f_0, f_1)
    for i in range(count):
        yield fibon(i)

def fibon_last_iter( f_0=1, f_1=1, last=10000000 ):
    """Yields a sequence of Fibonacci numbers bounded by the last value.

    :param f_0: The first number, default is 1.
    :param f_1: The second number, default is 1.
    :param last: Upper limit; this number is greater than all numbers returned.
    """
    fibon=Fibonacci(f_0, f_1)
    for f in (fibon(i) for i in itertools.count()):
        if f > last: break
        yield f
