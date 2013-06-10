"""hamcalc.math.solutri -- Triangles, solution of

This is a **Solver** for triangle problems.

..  py:function:: triangle( **args )

    Solve triangle problems. This an instance of  :class:`Triangle`.

    :param A_f: Angle opposite S_k, and adjacent to S_i and S_j
    :param A_g: Angle
    :param A_h: Angle
    :param S_i: Side Length
    :param S_j: Side Length
    :param S_k: Side Length opposite A_f

Some test cases

>>> import hamcalc.math.solutri as solutri
>>> import math
>>> solutri.triangle( A_f=math.radians(60), S_i=3, A_g=math.radians(60) )
{'A_g': 1.0471975511965976, 'A_f': 1.0471975511965976, 'S_i': 3, 'S_k': 3.0000000000000004, 'S_j': 3.000000000000001, 'A_h': 1.047197551196598}
>>> solutri.triangle( A_f=math.radians(60), S_j=3, A_g=math.radians(60) )
{'A_g': 1.0471975511965976, 'A_f': 1.0471975511965976, 'S_i': 2.9999999999999996, 'S_k': 2.9999999999999996, 'S_j': 3, 'A_h': 1.047197551196598}
>>> solutri.triangle( A_f=math.radians(60), S_k=3, A_g=math.radians(60) )
{'A_g': 1.0471975511965976, 'A_f': 1.0471975511965976, 'S_i': 3.0000000000000004, 'S_k': 3, 'S_j': 3.0, 'A_h': 1.047197551196598}
>>> math.degrees( 1.0471975511965976 )
59.99999999999999
>>> solutri.triangle( A_f=math.radians(45), S_i=3, A_h=math.radians(90), S_k=3 )
{'A_g': 0.7853981633974483, 'A_f': 0.7853981633974483, 'S_i': 3, 'S_k': 3.0, 'S_j': 4.242640687119286, 'A_h': 1.5707963267948966}
>>> math.sqrt(2)*3
4.242640687119286
>>> math.degrees(0.7853981633974483)
45.0
>>> solutri.triangle( A_f=math.radians(30), A_h=math.radians(90), )
{'A_g': 1.0471975511965979, 'A_f': 0.5235987755982988, 'A_h': 1.5707963267948966}

"""
__version__ = "2.1"

from hamcalc.lib import AttrDict, Solver, NoSolutionError
import math

def intro():
    return "    SOLUTION OF TRIANGLES                                   by George Murphy VE3ERP"

class Triangle( Solver ):
    """Solver for Triangle problems.

    ..  todo:: Refactor the :meth:`solve` function.
    """
    def solve( self, args ):
        """Solve the various elements of a Triangle.

        Angles are A_f, A_g, A_h; Sides are S_i, S_j, S_k.

        Further, A_f is opposite S_k, and adjacent to S_i and S_j.

        Angles must be measured in radians.

        Returns a dictionary with as many elements as can be determined.
        For example, if only two angles are supplied, then only the third
        angle can be computed.
        """
        # Iterate over the rules until no rule fires
        last_known, now_known= 0, len(args)
        while last_known != now_known:
            last_known= len(args)
            # Three sides known?
            if 'S_i' in args and 'S_j' in args and 'S_k' in args:
                s=(args.S_i+args.S_i+args.S_k)/2
                if 'A_f' not in args:
                    args.A_f= 2*math.atan( math.sqrt((s-args.S_i)*(s-args.S_j)/(s*(s-args.S_k)) ) )
                if 'A_g' not in args:
                    args.A_g= 2*math.atan( math.sqrt((s-args.S_j)*(s-args.S_k)/(s*(s-args.S_i)) ) )
                if 'A_h' not in args:
                    args.A_h= 2*math.atan( math.sqrt((s-args.S_k)*(s-args.S_i)/(s*(s-args.S_j)) ) )
            # Two angles known?
            if 'A_f' in args and 'A_g' in args and 'A_h' not in args:
                args.A_h= math.pi - args.A_f - args.A_g
            if 'A_f' in args and 'A_h' in args and 'A_g' not in args:
                args.A_g= math.pi - args.A_f - args.A_h
            if 'A_g' in args and 'A_h' in args and 'A_f' not in args:
                args.A_h= math.pi - args.A_g - args.A_h
            # One side and Three angles known?
            if 'S_i' in args and 'A_f' in args and 'A_g' in args and 'A_h' in args:
                args.S_j = args.S_i*math.sin(args.A_h)/math.sin(args.A_g)
                args.S_k = args.S_i*math.sin(args.A_f)/math.sin(args.A_g)
                break
            if 'S_j' in args and 'A_f' in args and 'A_g' in args and 'A_h' in args:
                args.S_i = args.S_j*math.sin(args.A_g)/math.sin(args.A_h)
                args.S_k = args.S_j*math.sin(args.A_f)/math.sin(args.A_h)
                break
            if 'S_k' in args and 'A_f' in args and 'A_g' in args and 'A_h' in args:
                args.S_i = args.S_k*math.sin(args.A_g)/math.sin(args.A_f)
                args.S_j = args.S_k*math.sin(args.A_h)/math.sin(args.A_h)
                break
            # Two sides an an angle?
            if 'S_j' in args and 'S_k' in args and 'A_h' in args and 'A_f' not in args:
                args.A_f = math.asin( args.S_k/args.S_j*math.sun(args.A_h) )
            if 'S_i' in args and 'S_k' in args and 'A_g' in args and 'A_f' not in args:
                args.A_f = math.asin( args.S_k/args.S_i*math.sun(args.A_g) )
            if 'S_i' in args and 'S_k' in args and 'A_f' in args and 'A_g' not in args:
                args.A_g = math.asin( args.S_i/args.S_k*math.sun(args.A_f) )
            if 'S_i' in args and 'S_j' in args and 'A_h' in args and 'A_g' not in args:
                args.A_g = math.asin( args.S_i/args.S_j*math.sun(args.A_h) )
            if 'S_i' in args and 'S_k' in args and 'A_f' in args and 'A_h' not in args:
                args.A_h = math.asin( args.S_i/args.S_k*math.sun(args.A_f) )
            if 'S_i' in args and 'S_j' in args and 'A_g' in args and 'A_h' not in args:
                args.A_h = math.asin( args.S_j/args.S_i*math.sun(args.A_g) )
            # Two adjacent sides and an angle?
            if 'S_j' in args and 'S_k' in args and 'A_g' in args and 'S_i' not in args:
                args.S_i = math.sqrt(args.S_j^2+args.S_k^2-(2*args.S_j*args.S_k*math.cos(args.A_g)))
            if 'S_i' in args and 'S_k' in args and 'A_h' in args and 'S_j' not in args:
                args.S_j = math.sqrt(args.S_i^2+args.S_k^2-(2*args.S_i*args.S_k*math.cos(args.A_h)))
            if 'S_i' in args and 'S_j' in args and 'A_f' in args and 'S_k' not in args:
                args.S_k = math.sqrt(args.S_i^2+args.S_j^2-(2*args.S_i*args.S_j*math.cos(args.A_f)))
            now_known= len(args)
        return args

triangle= Triangle()
