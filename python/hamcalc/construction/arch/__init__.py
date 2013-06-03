"""hamcalc.construction.arch

A **Solver** which calculates various properties of an arch.

Test Cases

>>> import hamcalc.construction.arch as arch
>>> a= arch.arch( C=10, B=1 )
>>> round( a.A_d, 3 )
45.24
>>> round( a.B, 3 )
1
>>> round( a.C, 3 )
10
>>> round( a.A_C, 3 )
10.265
>>> round( a.R, 3 )
13.0
>>> round( a.C_F, 3 )
81.681

>>> b= arch.arch( R=13, A_d=45 )
>>> round( b.A_d, 3 )
45
>>> round( b.B, 3 )
0.99
>>> round( b.C, 3 )
9.95
>>> round( b.A_C, 3 )
10.21
>>> round( b.R, 3 )
13
>>> round( b.C_F, 3 )
81.681

>>> d= arch.arch( A_d=45, C=10 )
>>> round( d.A_d, 3 )
45
>>> round( d.B, 3 )
0.995
>>> round( d.C, 3 )
10
>>> round( d.A_C, 3 )
10.262
>>> round( d.R, 3 )
13.066
>>> round( d.C_F, 3 )
82.094

>>> e= arch.arch( R=13, C=10 )
>>> round( e.A_d, 3 )
45.24
>>> round( e.B, 3 )
1.0
>>> round( e.C, 3 )
10
>>> round( e.A_C, 3 )
10.265
>>> round( e.R, 3 )
13
>>> round( e.C_F, 3 )
81.681

>>> f= arch.arch( R=13, B=1 )
>>> round( f.A_d, 3 )
45.24
>>> round( f.B, 3 )
1
>>> round( f.C, 3 )
10.0
>>> round( f.A_C, 3 )
10.265
>>> round( f.R, 3 )
13
>>> round( f.C_F, 3 )
81.681

>>> g= arch.arch( R=13, A_C=10.25 )
>>> round( g.A_d, 3 )
45.176
>>> round( g.B, 3 )
0.997
>>> round( g.C, 3 )
9.987
>>> round( g.A_C, 3 )
10.25
>>> round( g.R, 3 )
13
>>> round( g.C_F, 3 )
81.681

>>> h= arch.arch( A_d=45, A_C=10.25 )
>>> round( h.A_d, 3 )
45
>>> round( h.B, 3 )
0.993
>>> round( h.C, 3 )
9.989
>>> round( h.A_C, 3 )
10.25
>>> round( h.R, 3 )
13.051
>>> round( h.C_F, 3 )
82.0

>>> i= arch.arch( A_d=45, B=1 )
>>> round( i.A_d, 3 )
45
>>> round( i.B, 3 )
1
>>> round( i.C, 3 )
10.055
>>> round( i.A_C, 3 )
10.318
>>> round( i.R, 3 )
13.137
>>> round( i.C_F, 3 )
82.543

>>> j= arch.arch( C=10, A_C=10.3 )
>>> round( j.A_d, 3 )
48.115
>>> round( j.B, 3 )
1.065
>>> round( j.C, 3 )
10
>>> round( j.A_C, 3 )
10.3
>>> round( j.R, 3 )
12.265
>>> round( j.C_F, 3 )
77.065

>>> k= arch.arch( B=1, A_C=10.3 )
>>> round( k.A_d, 3 )
57.296
>>> round( k.B, 3 )
1
>>> round( k.C, 3 )
7.833
>>> round( k.A_C, 3 )
10.3
>>> round( k.R, 3 )
8.169
>>> round( k.C_F, 3 )
51.326

Here's an incomplete example, showing how things can't be computed
from an incomplete set of parameters.

>>> c= arch.arch( R=13 )
>>> c.A_d is None
True
>>> c.B is None
True
>>> c.C is None
True
>>> c.A_C is None
True
>>> round( c.R, 3 )
13
>>> round( c.C_F, 3 )
81.681

"""
from hamcalc.lib import AttrDict, Solver
from hamcalc.math.propcirc import arc_height_2_r, bisection
import math

introduction="""\
ARCH CALCULATOR                                         by George Murphy VE3ERP

            *H
 A*         *C        *B



            *X

 This program calculates the following elements of an arch:
                                 Curved arch AHB
                                 Chord AB
                                 Segment height CH
                                 Radii XA, XH, XB
                                 Angle AXB
"""

def intro():
    return introduction

def arc_chord_2_angle( A_C, C, eps=1.0E-7 ):
    """Use bisection to find the angle that gives the proper
    arc and chord information.

    ..  todo:: move this to propcirc, where it belongs.
    """
    def f_a_c_ac( A_r ):
        return A_r/math.sin( A_r/2 ) - 2*A_C/C
    return bisection( f_a_c_ac, eps, math.pi, eps )

class Arch( Solver ):
    """Solver for Arch problems.

    ..  todo:: Refactor the :meth:`solve` method.
    """
    def solve( self, args ):
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
        while not all( ('R' in args, 'A_d' in args, 'A_r' in args,
            'C' in args, 'A_C' in args, 'B' in args, 'C_F' in args, ) ):
            # Calculate or break
            if 'AR' not in args and 'R' in args:
                args.AR = math.pi * args.R**2
                # Legacy redundancy.
                # args.D = 2*args.R
                # args.C_F = math.pi * args.D
            elif 'D' not in args and 'R' in args:
                args.D = 2*args.R
            elif 'C_F' not in args and 'R' in args:
                args.C_F = 2 * math.pi * args.R
            elif 'A_r' not in args and 'A_d' in args:
                args.A_r = math.radians( args.A_d )
            elif 'A_d' not in args and 'A_r' in args:
                args.A_d = math.degrees( args.A_r )
            elif 'A_C' not in args and 'A_r' in args and 'R' in args:
                args.A_C = args.A_r * args.R
            elif 'A_r' not in args and 'A_C' in args and 'R' in args:
                args.A_r = args.A_C / args.R
            elif 'A_r' not in args and 'R' in args and 'C' in args:
                args.A_r = 2*math.asin( args.C / 2 / args.R )
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
                args.B = args.C/2 * math.tan( args.A_r/4 )
            elif 'B' not in args and 'A_r' in args and 'R' in args:
                args.B = 2*args.R*math.sin( args.A_r/4 )**2
            elif 'R' not in args and 'AR' in args:
                args.R = math.sqrt( args.AR/math.pi )
            elif 'R' not in args and 'C_F' in args:
                args.R = args.C_F / (2*math.pi)
            elif 'R' not in args and 'A_C' in args and 'A_r' in args:
                args.R = args.A_C / args.A_r

            elif 'A_r' not in args and 'A_C' in args and 'B' in args:
                args.A_r= arc_height_2_r( args.A_C, args.B )
            elif 'A_r' not in args and 'A_C' in args and 'C' in args:
                args.A_r= arc_chord_2_angle( args.A_C, args.C )
            else:
                break # Nothing more to do.
        return args

arch = Arch()
