"""hamcalc.math.centrif -- Centrifugal/Centripetel Force

This is a **Solver** for Force-Mass-Velocity and Radius.

..  py:function:: centrip( F=None, M=None, V=None, R=None )

    Solve centripetal acceleration problems. This an instance of  :class:`Centripetal`.

    :params F: force (newtons, kg-m/sec^2)
    :params M: mass (kilograms)
    :params V: velocity (meters/second)
    :params R: radius (meters)
    :returns: dict with all four values.

Solver Test Cases

>>> import hamcalc.math.centrif as centrif
>>> centrif.centrif( F=100, M=10, R=333 )
{'V': 57.706152185014034, 'R': 333, 'M': 10, 'F': 100}
>>> centrif.centrif( V=57.7, M=10, R=333 )
{'F': 99.97867867867868, 'R': 333, 'M': 10, 'V': 57.7}
>>> centrif.centrif( V=57.7, F=100, R=333 )
{'V': 57.7, 'R': 333, 'M': 10.002132586827821, 'F': 100}
>>> centrif.centrif( V=57.7, F=100, M=10 )
{'R': 332.92900000000003, 'V': 57.7, 'M': 10, 'F': 100}

Unit Conversion Test Cases

>>> m= centrif.KILOGRAM.to_std( 1 )
>>> centrif.POUND_MASS.from_std( m )
2.2046226218487757
>>> f=centrif.POUND_FORCE.to_std( 1 )
>>> centrif.NEWTON.from_std(f)
4.448222
>>> v=centrif.FT_PER_SEC.to_std(12)
>>> centrif.M_PER_SEC.from_std(v)
3.657599994440448
>>> r=centrif.FOOT.to_std( 6 )
>>> centrif.METRE.from_std( r )
1.8287999879299202

"""
__version__ = "2.1"

from hamcalc.lib import AttrDict, Unit, Standard_Unit, Solver, NoSolutionError
from hamcalc.math.equiv import METRE, FOOT
import math

introduction= """\
CENTRIFUGAL/CENTRIPETAL Force                           by George Murphy VE3ERP

 DEFINITIONS:

 CENTRIFUGAL FORCE: Force directed in a straight line away from the centre.

 CENTRIPETAL FORCE: Force directed in a curve toward the centre of rotation.

 In either case the force is the same.
"""

def intro():
    return introduction

class KILOGRAM( Standard_Unit ):
    """kilogram"""
    name="kg"

class POUND_MASS( Unit ):
    """pound (mass)"""
    name= "lb_m"
    standard= KILOGRAM
    factor= 1/0.45359237

class NEWTON( Standard_Unit ):
    """Newton"""
    name= "n"

class POUND_FORCE( Unit ):
    """pound (force)"""
    name= "lb_f"
    standard= NEWTON
    factor= 1/4.448222

class M_PER_SEC( Standard_Unit ):
    """meter per second"""
    name= "m/sec"

class FT_PER_SEC( Unit ):
    """foot per second"""
    name= "ft/sec"
    standard= M_PER_SEC
    factor= 3.2808399

class Centripetal( Solver ):
    """Solver for Force-Mass-Velocity and Radius problems."""
    def solve( self, args ):
        """Solve Force-Mass-Velocity and Radius problems.

        :params F: force (newtons, kg-m/sec^2)
        :params M: mass (kilograms)
        :params V: velocity (meters/second)
        :params R: radius (meters)
        :returns: dict with all four values.
        """
        if 'M' in args and 'V' in args and 'R' in args:
            args.F= args.M*args.V**2/args.R
        elif 'F' in args and 'V' in args and 'R' in args:
            args.M= args.F/(args.V**2/args.R)
        elif 'F' in args and 'M' in args and 'R' in args:
            args.V= math.sqrt( args.F/args.M*args.R )
        elif 'F' in args and 'M' in args and 'V' in args:
            args.R= args.M*args.V**2/args.F
        else:
            raise NoSolutionError( "Insufficient Data: {0!r}".format(args) )
        return args

centrif = Centripetal()
centrip = Centripetal()
