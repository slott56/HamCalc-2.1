primenos -- Prime Number Calculator
--------------------------------------

Analysis
~~~~~~~~~~

This does two things.

-   Sieve of Eratosthones to show prime numbers between two values.

    There are potentially several variations on the Sieve algorithm.
    We'll create  s generator function which iterates through the prime
    numbers.

-   Prime factoring of any number.

Implementation
~~~~~~~~~~~~~~~~

..  automodule:: hamcalc.math.primenos
    :members:

Quirks
~~~~~~~~~

The legacy used fairly inefficient and brute-force algorothims.
Fine for recreational programming.

We'll leave it at that, rather than provide really cool, high-powered factoring
algorithms.

Indeed, this program contains the following quirky bit of code.

::

    730 FOR N=A TO T STEP B
    750 IF T/N=INT(T/N)THEN X=X+1:PN(X)=N:T=T/N:GOTO 730
    760 A=3:B=2
    770 NEXT N

It's not clear what the ``GOTO`` on line 750 even means.
