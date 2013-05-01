"""Fibonacci Series

"FIBONACCI SERIES","","","FIBON"
"""

import hamcalc.math.fibon as fibon

def pairs( iterable ):
    a= next(iterable)
    for b in iterable:
        yield a, b
        a= b

def progressive():
    try:
        b= int( input( "ENTER: first number in progressive series? " ) )
    except:
        b= 1
    print( "{0:<16s}{1:<30s}{2:<20s}{3:s}".format(
        " N (number)", " R (ratio N/previous N)",
        " P (ratio 1/R+1)", "Diff. (P-Phi)" ) )
    for b, c in pairs( fibon.fibon_count_iter( f_1= b, count=22 ) ):
        r= c/b
        p= 1/r+1
        d= p-fibon.phi
        print( "{0:10d}      {1:10g}                    {2:10g}          {3:10g}".format(c, r, p, d) )

def regressive():
    """..   todo:: Finish this."""
    pass

print( fibon.intro() )

z= None
while z != '0':
    print( " To display progressive series (in ascending) order.....press 1 " )
    print( " To display regressive series (in descending) order.....press 2 " )
    print( " To EXIT program........................................press 0 " )
    z= input( "? " )
    if z == '1':
        progressive()
    elif z == '2':
        regressive()
