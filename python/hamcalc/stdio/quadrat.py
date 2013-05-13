"""Quadratic Equation Calculator

"EQUATION",", quadratic","","QUADRAT"
"QUADRATIC EQUATIONS","","","QUADRAT"
"""
import hamcalc.math.quadrat as quadratic


def solve():
    a_raw= input( "ENTER: Value of a? " )
    if len(a_raw) == 0: return
    b_raw= input( "ENTER: Value of b? " )
    if len(b_raw) == 0: return
    c_raw= input( "ENTER: Value of c? " )
    if len(c_raw) == 0: return
    a, b, c = float(a_raw), float(b_raw), float(c_raw)
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
