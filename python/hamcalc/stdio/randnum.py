"""Random Number Generator

"LOTTERY NUMBERS","","","RANDNUM"
"NUMBERS",", Random generator","","RANDNUM"
"RANDOM NUMBER GENERATOR","","","RANDNUM"
"""
import random

print("""\
Random Number Generator                                 by George Murphy VE3ERP
""")

print( "This program generates arrays of consecutive numbers and arranges them in" )
print( "random order." )

z = None
while z != '0':
    print( " To RUN program.....press 1" )
    print( " To EXIT............press 0" )

    z= input( "CHOICE? " )
    if z == '1':
        l= input( " Do you want 6 numbers between 1 and 49 for Lotto 649?  (y/n)? " )
        if l == 'y':
            n= 49
        else:
            n= int( input( " ENTER last number in array (1 to " ) )
        p= [ i+1 for i in range(n) ]
        random.shuffle( p )
        print( "RANDOM NUMBER GENERATOR" )
        print( "Numbers from 1 to {0} in random order".format(n) )
        print( " ".join( map(str,p) ) )
        if l == 'y':
            pick= p[-6:]
            bonus= p[-7]
            pick.sort()
            print( "LOTTO 649 pick:", " ".join( map( str, pick) ), "  Bonus", bonus )

