"""hamcalc.math.primenos -- Prime Number Calculator

This includes a Sieve of Eratosthones plus a factorization.

Some test cases.

>>> import hamcalc.math.primenos as primenos
>>> list(primenos.sieve_range_iter(2,3))
[2]
>>> list(primenos.sieve_range_iter(1,2))
[]
>>> list(primenos.sieve_range_iter(2,10))
[2, 3, 5, 7]
>>> list(primenos.factor(2))
[2]
>>> list(primenos.factor(99))
[3, 3, 11]
>>> list(primenos.factor(2**32+1))
[641, 6700417]

"""
import itertools

introduction = """\
 PRIME NUMBERS                                           by George Murphy VE3ERP
         A prime number is a number evenly divisible only by itself and
         the number 1, and not by any other integer (whole number).
"""

def intro():
    return introduction

def sieve_set_iter( last ):
    """Sieve of Eratosthones: generate primes, p, such that :math:`2 \leq p < last`

    This creates a potentially large ``set`` object, which can use a LOT of memory.

    The downside of a large set is the problem of hash collisions when trying
    to collect a large number of elements. The upside is simplicity.

    :param last: primes will be 2 <= p < last.
    :returns: Yields prime numbers
    """
    composite= set()
    for i in range(2,last):
        if i not in composite:
            yield i
            for m in range(i+i,last,i):
                composite.add( m )

def sieve_list_iter( last ):
    """Sieve of Eratosthones: generate primes, p, such that :math:`2 \leq p < last`

    This creates a large ``list`` object, which can use a LOT of memory.
    But it's simple. The list is a trifle faster than a set because it avoids
    hash collisions.

    :param last: primes will be 2 <= p < last.
    :returns: Yields prime numbers
    """
    sieve = [ True for i in range(last) ] # Ouch.
    for i in range(2,last):
        if sieve[i]:
            yield i
            for m in range(i+i,last,i):
                sieve[m]= False

def sieve_range_iter( low, high ):
    """Sieve of Eratosthones such that :math:`low \leq p < last`.

    This uses the :func:`sieve_list_iter` because it's potentially
    faster for factoring.

    :param low: lowest value.
    :param last: primes will be low <= p < last.
    :returns: Yields prime numbers
    """
    return itertools.dropwhile( lambda a: a < low, sieve_list_iter(high) )

def factor( n ):
    """Simple prime factorization of n.

    Factoring small numbers (less than 2**32) is quick because small integer
    values are fast in Python.

    Factoring larger numbers is slower because it uses
    long integers which are slower and tie up more memory.

    :param n: Number of factor
    :returns: Yields factors.
    """
    n= int(n) # just in case.
    for i in sieve_list_iter( int(n**.5)+1 ):
        while n % i == 0 and n != 1:
            yield i
            n = n // i
        if i > int(n**.5)+1: break
    if n != 1:
        yield n
