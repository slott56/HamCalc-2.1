"""Quadratic Equation Calculator

"EQUATION",", quadratic","","QUADRAT"
"QUADRATIC EQUATIONS","","","QUADRAT"
"""
import hamcalc.math.quadrat as quadratic
from hamcalc.stdio import *

def solve():
    a= input_float( "ENTER: Value of a? " )
    if a is None: return
    b= input_float( "ENTER: Value of b? " )
    if b is None: return
    c= input_float( "ENTER: Value of c? " )
    if c is None: return
    roots= quadratic.solve( a, b, c )
    print( "{0!s}x² + {1!s}x + {2!s}= 0".format(a,b,c) )
    print( "x = {0!s} or {1!s}".format( *roots ) )
    print()
    print( "Select the value of x that suits your application." )

print( quadratic.intro() )

z = None
while z != '0':
    print( " < 1 > to continue" )
    print( " < 0 > to EXIT" )
    z = input( "CHOICE? " )
    if z == '1':
        solve()
