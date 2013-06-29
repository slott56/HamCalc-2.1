"""Arch Calculator
"""
import hamcalc.construction.arch as arch
from hamcalc.stdio import *

def solve():
    """Gather Inputs for Arch Problems."""
    print( "All dimensions in ANY identical units of measure:" )

    R= input_float( "ENTER: Radii XA, XH, XB? " )
    A_d= input_float( "ENTER: Angle AXB in degrees? " )
    C= input_float( "ENTER: Chord AB? " )
    A_C= input_float( "ENTER: Curved arch AHB? " )
    B= input_float( "ENTER: Segment height CH? " )

    display( R=R, A_d=A_d, C=C, A_C=A_C, B=B )

def display( **args_r ):
    """Compute and display results."""
    results= arch.arch( **args_r )
    print( results )

    print("ARCH CALCULATION")
    print()

    template="""\
Curved arch AHB.... {A_C:9.3f} units
Chord AB........... {C:9.3f} units
Segment Height CH.. {B:9.3f} units
Radii XA, XH, XB... {R:9.3f} units
Angle AXB.......... {A_d:9.3f}°

                    (Values rounded off to nearest .001)
"""

    print( template.format(**results) )


print( arch.intro() )

z= None
while z != '0':
    print()
    print( " ENTER 1 to continue or 0 to EXIT" )
    z= input( "CHOICE? " )
    if z == '1':
        solve()

