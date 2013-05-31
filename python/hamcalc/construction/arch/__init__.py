"""hamcalc.construction.arch

A **Solver** which calculates various properties of an arch.

Test Cases

>>> import hamcalc.construction.arch as arch
>>> a= arch.arch( C=10, B=1 )
>>> round( a.A_C, 3 )
10.265
>>> round( a.R, 3 )
13.0
>>> round( a.A_d, 3 )
45.24
>>> round( a.C_F, 3 )
81.681



"""
from hamcalc.lib import AttrDict
from hamcalc.math.propcirc import arc_height_2_r
import math

def arch( **kw ):
    """Solve arch problems.

    :param R:
        Radii XA, XH, XB, :math:`D = 2R`.

    :param A_d:
        Angle AXB in degrees.

    :param A_r:
        Angle AXB in radians.

    :param C:
        Chord AB.

    :param A_C:
        Curved arch AHB.

    :param B:
        Segment height CH.

    :returns: Dictionary with **all** values computed.
    """

    args= AttrDict( kw )
    while not all( ('R' in args, 'A_d' in args, 'C' in args, 'A_C' in args, 'B' in args ) ):
        # Calculate or break
        if 'AR' not in args and 'R' in args:
            args.AR = math.pi * args.R**2
            args.D = 2*args.R
            args.C_F = math.pi * args.D
        elif 'D' not in args and 'R' in args:
            args.D = 2*args.R
        elif 'C_F' not in args and 'R' in args:
            args.C_F = math.pi * args.D
        elif 'A_r' not in args and 'A_d' in args:
            args.A_r = math.radians( args.A_d )
        elif 'A_d' not in args and 'A_r' in args:
            args.A_d = math.degrees( args.A_r )
        elif 'A_C' not in args and 'A_r' in args and 'R' in args:
            args.A_C = args.A_r * args.R
        elif 'A_r' not in args and 'A_C' in args and 'R' in args:
            args.A_r = args.A_C / args.R
        elif 'A_r' not in args and 'R' in args and 'C' in args:
            args.A_r = math.asin( args.C / 2 / args.R )
        elif 'R' not in args and 'A_r' in args and 'B' in args:
            args.R = args.B / (1 - math.cos( args.A_r/2 ) )
        elif ('R' not in args or 'A_r' not in args) and 'B' in args and 'C' in args:
            args.R = (4*args.B**2 + args.C**2)/(8*args.B)
            args.A_r = 2*(math.pi - 2*math.atan2(args.C/2,args.B))
        elif 'C' not in args and 'B' in args and 'R' in args:
            args.C = 2*math.sqrt( 2*args.B*args.R-args.B**2 )
        elif 'C' not in args and 'A_r' in args and 'R' in args:
            args.C = 2*args.R*math.sin( args.A_r/2 )
        elif 'B' not in args and 'C' in args and 'R' in args:
            args.B = args.R - math.sqrt(4*args.R**2-args.C**2)/2
        elif 'B' not in args and 'A_r' in args and 'C' in args:
            args.B = args.C/2 * math.tan( args.A/4 )
        elif 'B' not in args and 'A_r' in args and 'R' in args:
            args.B = 2*args.R*math.sin( args.A/4 )**2
        elif 'R' not in args and 'AR' in args:
            args.R = math.sqrt( args.AR/math.pi )
        elif 'R' not in args and 'C_F' in args:
            args.R = args.C_F / (2*math.pi)
        elif 'R' not in args and 'A_C' in args and 'A_r' in args:
            args.R = args.A_C / args.A_r

        elif 'A_r' not in args and 'A_C' in args and 'B' in args:
            args.A_r= arc_height_2_r( args.A_C, args.B )
        else:
            break # Nothing more to do.
    return args
