"""hamcalc.construction.conecalc

This creates two solvers for laying out cones (or truncated cones)
on rectangular sheets.

-   cone

-   truncated_cone

A Cone is defined by diameter ("D") and height ("H").

A Sheet is defined by an width ("A") and length ("B").

A Cone has some additional attributes whch must be computed
to properly lay out the cone pattern.

-   Arc Angle ("theta_r" and "theta_d").

-   Arc Radius ("L").

-   Arc Center Coordinates ("X", "Y").
    "X" is measured along the "B" (length) axis.
    "Y" is measured along the "A" (width) axis.

A Truncated Code is defined two diameters and a height:
"D_B", "D_T", "H".


Test Cases

>>> import hamcalc.construction.conecalc as conecalc
>>> c= conecalc.cone( D=8, H=4 )
>>> c.D
8
>>> c.H
4
>>> round(c.C,3)
25.133
>>> round(c.theta_d,3)
254.558
>>> round(c.L,3)
5.657
>>> round(c.X,3)
5.657
>>> round(c.Y,3)
3.426
>>> round(c.A,3)
9.083
>>> round(c.B,3)
11.314

>>> s= conecalc.cone( A=9, B=11.3 )
>>> s.next
1
>>> round(s.D,3)
6.791
>>> round(s.H,3)
4.516
>>> round(s.C,3)
21.336
>>> round(s.theta_d,3)
216.365
>>> round(s.L,3)
5.65
>>> round(s.X,3)
5.65
>>> round(s.Y,3)
3.35

>>> s= conecalc.cone( **s )
>>> s.next
2
>>> round(s.D,3)
3.889
>>> round(s.H,3)
8.787
>>> round(s.C,3)
12.217
>>> round(s.theta_d,3)
77.773
>>> round(s.L,3)
9
>>> round(s.X,3)
5.65
>>> round(s.Y,3)
0

>>> s= conecalc.cone( **s )
>>> s.next
3
>>> round(s.D,3)
5.24
>>> round(s.H,3)
8.61
>>> round(s.C,3)
16.463
>>> round(s.theta_d,3)
104.807
>>> round(s.L,3)
9
>>> round(s.X,3)
2.3
>>> round(s.Y,3)
0

>>> s= conecalc.cone( **s )
>>> s.next
4
>>> round(s.D,3)
3.314
>>> round(s.H,3)
11.178
>>> round(s.C,3)
10.412
>>> round(s.theta_d,3)
52.793
>>> round(s.L,3)
11.3
>>> round(s.X,3)
0
>>> round(s.Y,3)
0

>>> s= conecalc.cone( **s )
>>> s.next
>>> round(s.D,3)
2.946
>>> round(s.H,3)
11.204
>>> round(s.C,3)
9.257
>>> round(s.theta_d,3)
46.935
>>> round(s.L,3)
11.3
>>> round(s.X,3)
0
>>> round(s.Y,3)
4.5

>>> t = conecalc.truncated_cone( D_B=2, D_T=4, H=2 )
>>> round(t.L,3)
4.472
>>> round(t.L_X,3)
2.236
>>> round(t.theta_d,3)
160.997
>>> round(t.B,3)
8.822
>>> round(t.A,3)
4.103
>>> t.relative
'below'
>>> round(t.X,3)
4.411
>>> round(t.Y,3)
0.369

"""
__version__ = "2.1"

from hamcalc.lib import AttrDict, Solver
import math

class Error( Exception ):
    pass

introduction="""\
Cone Calculator                                         by George Murphy VE3ERP
Algorithm by Robert Dehoney

    This program computes pattern sheet size and layout for any size
    cone and/or the cone and the pattern dimensions to fit any size
    pattern sheet.

    Dimensions can be any unit of measure as long as all dimensions
    are entered in the same units; x and y dimensions are measured from
    the lower left corner of the pattern sheet.
"""
def intro():
    return introduction

class Cone( Solver ):
    """Solver for Cone and Sheet Size problems.

    ..  todo:: Refactor the :meth:`solve` method.
    """
    def solve( self, args ):
        """Solve Cone and Sheet Size problems.

        -   Given the Cone base diameter and height ("D", "H"),
            Compute the sheet size and other helpful measures.

        -   Given sheet size ("A", "B") maximize the cone
            that can be cut. There are as many as five alternatives.

            A "next" indicator is used. If omitted to set to ``None``, a solution
            is picked, and the value of "next" is added to the
            attr dict with state information to compute the next value.

            When "next" is returned as ``None``, there are no more
            values.

            ::

                params= conecalc.cone( **params )
                print( template.format( **params ) )
                while params.next:
                    params= conecalc.cone( **params )
                    print( template.format( **params ) )

        """
        if 'next' not in args or args.next is None:
            # General cases: cone to sheet or sheet to cones
            if "D" in args or "H" in args:
                # Given a cone, compute the sheet
                args.R = args.D/2
                args.L = math.sqrt( args.R**2 + args.H**2 )
                args.theta_r = math.pi * args.D / args.L
                args.theta_d = math.degrees( args.theta_r )
                if math.pi <= args.theta_r:
                    args.A = args.L + args.L*math.sin( (args.theta_r-math.pi)/2 )
                    args.B = 2*args.L
                    args.X = args.B/2
                    args.Y = args.A - args.B/2
                elif math.pi/2 <= args.theta_r < math.pi:
                    args.A = args.L
                    args.B = args.L + args.L*math.sin( args.theta_r-(math.pi/2) )
                    args.X = args.B-args.A
                    args.Y = 0
                else:
                    args.A = args.L*math.sin( args.theta_r )
                    args.B = args.L
                    args.X = 0
                    args.Y = 0
                args.C = math.pi * args.D
                return args
            elif "A" in args or "B" in args:
                # Given a sheet, compute the first of the cones and set "more"
                if args.B > 2*args.A:
                    args.next= 3
                else:
                    args.next= 0
            else:
                raise Error( "Unrecognized variables: {0}".format(kw.keys()) )
        assert 'next' in args and args.next is not None
        # Fitting cones to sheets, next alternative solution.
        if args.next == 0:
            args.next += 1
            args.L = args.B/2
            args.theta_r = math.pi + math.asin( args.A/args.L - 1 )
            args.X, args.Y = args.B/2, args.A-args.B/2
        elif args.next == 1:
            args.next += 1
            args.L = args.A
            args.theta_r = 2 * math.asin( args.B / 2 / args.L )
            args.X, args.Y = args.B/2, 0
        elif args.next == 2:
            args.next += 1
            args.L = args.A
            args.theta_r = math.pi/2 + math.asin( args.B/args.L - 1 )
            args.X, args.Y = args.B-args.A, 0
        elif args.next == 3:
            args.next += 1
            args.L = args.B
            args.theta_r = math.asin( args.A / args.L )
            args.X, args.Y = 0, 0
        elif args.next == 4:
            args.next = None
            args.L = args.B
            args.theta_r = 2 * math.asin( args.A / 2 / args.L )
            args.X, args.Y = 0, args.A/2
        else:
            raise Error( "Logic Error: next={0}".format(args.next) )

        args.theta_d = math.degrees( args.theta_r )
        args.C = args.L * args.theta_r
        args.D = args.C / math.pi
        args.R = args.D / 2
        args.H = math.sqrt( args.L**2 - args.R**2 )

        return args

cone = Cone()

class Truncate_Cone( Solver ):
    """Solver for Truncated Cone and Sheet Size problems."""

    def solve( self, args ):
        """Solve Truncated Cone and Sheet Size problems.

        Given the Cone base diameter, top diameter and height
        ("D_B", "D_T", "H"),
        Compute the sheet size and other helpful measures.

        This is not complete solver, because it can't resolve
        a cone design given a sheet size.
        """
        if args.D_T > args.D_B:
            args.LE, args.SE=args.D_T, args.D_B
        else:
            args.LE, args.SE=args.D_B, args.D_T

        assert args.LE >= args.SE # LE is the large end

        args.R_T = args.LE/2
        args.R_B = args.SE/2
        args.H_X = args.R_B * args.H / (args.R_T - args.R_B)
        args.L = math.sqrt( args.R_T**2 + (args.H + args.H_X)**2 )
        args.L_X = args.R_B * args.L / args.R_T
        args.theta_r = 2*math.pi*args.R_T/args.L
        args.theta_d = math.degrees( args.theta_r )
        if args.theta_r >= math.pi:
            args.B = 2*args.L
            args.A = args.L + args.L * math.sin( (args.theta_r-math.pi)/2 )
            args.X, args.Y = args.B/2, args.A-args.B/2
        else:
            args.B = 2*args.L*math.sin( args.theta_r/2 )
            args.A = args.L - args.L_X*math.cos( args.theta_r/2 )
            args.X, args.Y = args.B/2, 0
        args.TOP= args.A
        args.BOT= 0
        if args.theta_r > math.pi:
            args.Y = args.A - args.L
            args.relative= "above"
        elif args.theta_r < math.pi:
            args.Y = args.L - args.A
            args.relative= "below"
        else:
            args.relative= "above"
        return args

truncated_cone = Truncate_Cone()
