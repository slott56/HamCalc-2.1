"""Gears and Gearing
"""
import hamcalc.construction.gearing as gearing
from hamcalc.stdio import *

def gear_size( P=None, A=None, B=None ):
    if P is None:
        P= input_int( "ENTER: Diametrical pitch ............? " )
    if A is None:
        A= input_int( "ENTER: No. of teeth - Gear A ........? " )
    if B is None:
        B= input_int( "ENTER: No. of teeth - Gear B ........? " )
    D, E, C, R = gearing.design_gear_distances( P, A, B )

    print( "GEARING SPECIFICATIONS" )

    print( "Diametrical pitch ............... {0:6d}".format( P ) )
    print( "Gear A - No. of teeth ........... {0:6d}".format( A ) )
    print( "       - Pitch diameter (in.) ... {0:10,.3f}".format( D ) )
    print( "Gear B - No. of teeth ........... {0:6d}".format( B ) )
    print( "       - Pitch diameter (in.) ... {0:10,.3f}".format( E ) )
    print( "C.C. (inches) ...................{0:10,.3f}".format( C ) )
    print( "Ratio ...........................{0:10,.3f}:1".format( R ) )

def gear_design( ):
    P= input_int( "ENTER: Diametrical pitch ............? " )
    K= input_float( "ENTER: Known  R.P.M. ................? " )
    S= input_float( "ENTER: Sought R.P.M. ................? " )
    C= input_float( "ENTER: Desired c.c. distance (in.) ..? " )
    if any( (P is None, K is None, S is None, C is None) ): return

    print( "Gear A  Gear B  c.c.(in.)  R.P.M." )
    for A, B, C2, S2 in gearing.design_teeth_iter( P, K, S, C ):
        print( "{0:8d} {1:8d} {2:10,.3f} {3:10,.3f}".format(
            A, B, C2, S2 ) )

    N= input_int( "ENTER: desired gear A size? " )
    if N is None: return
    A, B, C, S = gearing.design_from_A( P, N, K, S )
    D, E, _, R = gearing.design_gear_distances( P, A, B )

    H= input_float( "ENTER: (if applicable) Horsepower.........? " )
    if H is None:
        I = J = None
        # one report
    else:
        I, J = gearing.torque( H, K, S )
        # other report

    print( "GEARING SPECIFICATIONS" )

    print( "Diametrical pitch ............... {0:6d}".format( P ) )
    print( "Gear A - No. of teeth ........... {0:6d}".format( A ) )
    print( "       - Pitch diameter (in.) ... {0:10,.3f}".format( D ) )
    print( "       - R.P.M. ................. {0:10,.3f}".format( K ) )
    if I is not None:
        print( "       - Shaft torque (in./lb)... {0:10,.3f}".format( I ) )
    print( "Gear B - No. of teeth ........... {0:6d}".format( B ) )
    print( "       - Pitch diameter (in.) ... {0:10,.3f}".format( E ) )
    print( "       - R.P.M. ................. {0:10,.3f}".format( S ) )
    if J is not None:
        print( "       - Shaft torque (in./lb)... {0:10,.3f}".format( J ) )
    print( "C.C. (inches) ...................{0:10,.3f}".format( C ) )
    print( "Ratio ...........................{0:10,.3f}:1".format( R ) )
    if H is not None:
        print( "Horsepower ...................... {0:10,.3f}".format( H ) )

print( gearing.intro() )
z = None
while z != '0':
    print("  (1)  Gears known")
    print("  (2)  Gears unknown, R.P.M.'s known")
    print("  (0)  Exit")
    z= input( "CHOICE? " )
    if z == '1':
        gear_size()
    elif z == '2':
        gear_design()

