"""Prime Number Calculator

"PRIME NUMBERS","","","PRIMENOS"
"""

import hamcalc.math.primenos as primenos

def primes_in_range():
    first_raw= input(" ENTER: From first number...? " )
    if len(first_raw) == 0: return
    last_raw= input(" ENTER:   To last number....? " )
    if len(last_raw) == 0: return
    first= int(first_raw)
    last= int(last_raw)
    primes= list( primenos.sieve_range_iter( first, last+1 ) )
    for i in range(0,len(primes),8):
        for n in primes[i:i+8]:
            print( "{0:9d} ".format(n), end="" )
        print()

def prime_factors():
    number_raw= input( " ENTER: Number to be resolved in primes? " )
    if len(number_raw) == 0: return
    number= int(number_raw)
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
