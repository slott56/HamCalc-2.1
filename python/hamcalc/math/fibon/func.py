"""hamcalc.math.fibon -- Fibonacci Numbers, functional implementation.

This module defines a generator function which can efficiently
generate Fibonacci numbers.

It also defines two useful iterator tools functions to provide finite sequences
of Fibonacci numbers.

Test Cases

>>> list( fibon_count_iter( count=13 ) )
[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233]
>>> f= list( fibon_count_iter( count=13 ) )
>>> a, b = f[11], f[12]
>>> a
144
>>> b
233
>>> b/a
1.6180555555555556
>>> list( fibon_last_iter( last=100 ) )
[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

For HamCalc compatibility, use f_0=0 in the various generator functions.
This will yield a Fibonacci Series that starts with zero.

"""

__version__ = "2.1"

import itertools

def fibonacci_iter( f_0=1, f_1=1 ):
    """Yields an infinite sequence of Fibonacci numbers given two starting values.

    :param f_0: The first number, default is 1.
    :param f_1: The second number, default is 1.
    """
    yield f_0
    while True:
        yield f_1
        f_1, f_0 = f_0+f_1, f_1

def fibon_count_iter( f_0=1, f_1=1, count=22 ):
    """Yields a sequence of Fibonacci numbers bounded by count.

    :param f_0: The first number, default is 1.
    :param f_1: The second number, default is 1.
    :param count: The number of numbers to return.
    """
    for i, f in enumerate(fibonacci_iter(f_0,f_1)):
        if i == count: break
        yield f

def fibon_last_iter( f_0=1, f_1=1, last=10000000 ):
    """Yields a sequence of Fibonacci numbers bounded by the last value.

    :param f_0: The first number, default is 1.
    :param f_1: The second number, default is 1.
    :param last: Upper limit; this number is greater than all numbers returned.
    """
    for f in fibonacci_iter(f_0,f_1):
        if f > last: break
        yield f
