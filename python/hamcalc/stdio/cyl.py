"""Cylinders, Air and Hydraulic

"AIR CYLINDERS","","","MECHMENU"
"CYLINDERS",", air & hydraulic","","MECHMENU"
"HYDRAULIC CYLINDERS","","","MECHMENU"
"""
import hamcalc.construction.cyl as cyl
from hamcalc.stdio import *
import math

def solve():
    P = input_float( "P.S.I. ..................? " )
    C = input_float( "Cylinder diameter .......? " )
    A = math.pi * (C/2)**2
    O = input_float( "Lbs. Push ...............? " )
    R = input_float( "Rod diameter ............? " )
    D = math.pi * (R/2)**2
    I = input_float( "Lbs. Pull ...............? " )
    S = input_float( "Stroke (in.) ............? " )

    display( P=P, A=A, O=O, D=D, I=I, S=S)

def display( **args ):
    cylinder= cyl.Cylinder()
    result= cylinder( **args )
    result.C = 2*math.sqrt( result.A/math.pi )
    result.R = 2*math.sqrt( result.D/math.pi )

    template= """\
Cylinder diameter (in.) ... {C:10,.3f}
Rod diameter (in.) ........ {R:10,.3f}
Lbs. Push ................. {O:10,.3f}
Lbs. Pull ................. {I:10,.3f}
Pressure (P.S.I.) ......... {P:10,.3f}
"""
    if "S" in result:
        template += """\
Stroke (in.) .............. {S:10,.3f}
Displacement (cu.in.) ..... {V:10,.3f}
"""
    print( template.format( **result ) )

print( cyl.intro() )
z= None
while z != '0':
    print( "( 1 )  Run CYLINDER program" )
    print( "( 0 )  EXIT" )
    z= input( "CHOICE? " )
    if z == '1':
        solve()
