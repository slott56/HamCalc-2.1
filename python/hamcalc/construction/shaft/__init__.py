"""hamcalc.construction.shaft

Shaft **Solver** for diameter, horsepower and RPM.

There are three callable objects defined here:

..  function:: main_shaft( D, N, H )

    Solves shaft design problems for main shafts.

    :param D: Diameter
    :param N: RPM
    :param H: Horsepower
    :returns: :class:`hamcalc.lib.AttrDict` with missing values.
        This includes *L*, the bearing spacing.

..  function::  pulley_shaft( D, N, H )

    Solves shaft design problems for main shafts.

    :param D: Diameter
    :param N: RPM
    :param H: Horsepower
    :returns: :class:`hamcalc.lib.AttrDict` with missing values.
        This includes *L*, the bearing spacing.


..  function::  stub_shaft( D, N, H )

    Solves shaft design problems for main shafts.

    :param D: Diameter
    :param N: RPM
    :param H: Horsepower
    :returns: :class:`hamcalc.lib.AttrDict` with missing value.
        Bearing spacing, *L* is not computed.

Test Cases

>>> import hamcalc.construction.shaft as shaft
>>> pulley = shaft.pulley_shaft( N=3500, H=80 )
>>> round(pulley.D,3)
1.069
>>> round(pulley.L,3)
65.253

>>> main = shaft.main_shaft( N=3500, H=80 )
>>> round(main.D,3)
1.223
>>> round(main.L,3)
122.815

"""
__version__ = "2.1"

from hamcalc.lib import Solver, NoSolutionError

def intro():
    return """\
SHAFTING DESIGN                                         by George Murphy VE3ERP
"""

class Shaft( Solver ):
    """Solve shaft diameter, horsepower and RPM problems.
    This requires a *Y* and *Z* value defines some shaft
    geometry features.

    :D: Diameter
    :N: RPM
    :H: Horsepower

    Also computes *L*

    :L: Bearing Spacing
    """
    def __init__( self, Y, Z=None ):
        self.Y= Y
        self.Z= Z
    def solve( self, args ):
        if "D" in args and "N" in args:
            args.H = args.D**3 * args.N / self.Y
        elif "H" in args and "N" in args:
            args.D = ( args.H*self.Y/args.N ) ** (1/3)
        elif "H" in args and "D" in args:
            args.N = args.H * self.Y / args.D**3
        else:
            raise NoSolutionError( "Does not compute: {0!r}".format(args) )
        if self.Z:
            args.L= self.Z * args.D ** (2/3)
        return args

main_shaft= Shaft( 80, 107.4 )
pulley_shaft= Shaft( 53.5, 62.4 )
stub_shaft= Shaft( 38 )
