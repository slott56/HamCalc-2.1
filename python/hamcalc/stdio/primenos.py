"""Prime Number Calculator

"PRIME NUMBERS","","","PRIMENOS"
"""

import hamcalc.math.primenos as primenos
from hamcalc.stdio import *

def primes_in_range():
    first= input_int(" ENTER: From first number...? " )
    if first is None: return
    last= input_int(" ENTER:   To last number....? " )
    if last is None: return
    primes= list( primenos.sieve_range_iter( first, last+1 ) )
    for i in range(0,len(primes),8):
        for n in primes[i:i+8]:
            print( "{0:9d} ".format(n), end="" )
        print()

def prime_factors():
    number= input_int( " ENTER: Number to be resolved in primes? " )
    if number is None: return
    factors= list( primenos.factor(number) )
    factor_str= " x ".join(map(str,factors))
    print( " Prime factors of {0} = {1}".format(number,factor_str) )

print( primenos.intro() )

z= None
while z != '0':
    print("   < 1 >  Display all prime numbers between any two integers")
    print("   < 2 >  Find prime factors of a number")
    print()
    print("   < 0 >  EXIT")
    z = input( "Choice? " )
    if z == "1":
        primes_in_range()
    elif z == "2":
        prime_factors()
