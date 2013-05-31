"""Arch Calculator
"""
import hamcalc.construction.arch as arch
from hamcalc.lib import AttrDict

def solve():
    """Gather Inputs for Arch Problems."""
    print( "All dimensions in ANY identical units of measure:" )

    r_raw= input( " ENTER: Radii XA, XH, XB? " )
    a_d_raw= input( " ENTER: Angle AXB in degrees? " )
    c_raw= input( " ENTER: Chord AB? " )
    a_c_raw= input( " ENTER: Curved arch AHB? " )
    b_raw= input( " ENTER: Segment height CH? " )

    args = AttrDict()
    try:
        if r_raw: args.R= float(r_raw)
        if a_d_raw: args.A_d= float(a_d_raw)
        if c_raw: args.C = float(c_raw)
        if a_c_raw: args.A_C = float(a_c_raw)
        if b_raw: args.B= float(b_raw)
        display( **args )
    except ValueError as e:
        print( e )

def display( **args_r ):
    """Compute and display results."""
    results= arch.arch( **args_r )

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

