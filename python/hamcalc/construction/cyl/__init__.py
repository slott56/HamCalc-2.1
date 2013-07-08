"""hamcalc.construction.cyl

AIR & HYDRAULIC CYLINDERS

This is a **Solver** for various attributes
of a cylinder.

:P: PSI

:A: Cylinder Area, based on input diameter, *C*.

    :math:`A = \\pi \\left(\\frac{C}{2}\\right)^2`

:O: Lbs. Push

:D: Rod Area, based on input diameter, *R*.

    :math:`D = \\pi \\left(\\frac{R}{2}\\right)^2`

:I: Lbs. Pull

:B: The cylinder outside the rod.

Additionally it computes volumne, *V*,
from stroke *S*, and area, *A*.

Test Cases

>>> import hamcalc.construction.cyl as cyl
>>> import math
>>> cylinder = cyl.Cylinder()
>>> C = 3
>>> A = math.pi * (C/2)**2
>>> R = .25
>>> D = math.pi * (R/2)**2
>>> c= cylinder( A=A, P=90, D=D, S=18 )
>>> round(c.A,3)
7.069
>>> round(c.D,3)
0.049
>>> round(c.B,3)
7.019
>>> round(c.I,3)
631.755
>>> round(c.O,3)
636.173
>>> round(c.V,3)
127.235

"""
__version__ = "2.1"

from hamcalc.lib import Solver, NoSolutionError
import math

def intro():
    return """\
AIR & HYDRAULIC CYLINDERS                               by George Murphy VE3ERP
"""

class Cylinder( Solver ):
    """Solve cylinder design problems."""
    def solve( self, args ):
        """
        :param A: Overall area
        :param D: Rod area
        :param O: push force in lbs
        :param I: pull force in lbs
        :param P: PSI.
        :param S: Stroke distance

        Returns an dictionary with all values
        filled in, including ``V``, volume.
        """
        self.area( args )
        self.push( args )
        self.pull( args )
        if "S" in args:
            args.V = args.S * args.A
        return args
    def area( self, args ):
        if "A" in args and "D" in args:
            args.B = args.A - args.D
        elif "A" in args and "B" in args:
            args.D = args.A - args.B
        elif "B" in args and "D" in args:
            args.A = args.B + args.D
        return args
    def push( self, args ):
        if "A" in args and "P" in args:
            args.O = args.A * args.P
        elif "A" in args and "O" in args:
            args.P = args.O / args.A
        elif "A" not in args and "P" in args and "O" in args:
            args.A = args.O / args.P
        return args
    def pull( self, args ):
        if "B" in args and "P" in args:
            args.I = args.B * args.P
        elif "B" in args and "I" in args:
            args.P = args.I / args.B
        elif "B" not in args and "P" in args and "I" in args:
            args.B = args.I / args.P
        return args
