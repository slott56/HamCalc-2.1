"""hamcalc.construction.binhop

Calculate volumes of hoppered bins.

There are two functions defined:

..  function:: rectangular( D, E, F, G, H, J )

    Skeleton function to compute rectangular bin volumes.
    This requires the :data:`draw` variable set to a proper
    instance of :class:`Side` or :class:`Center` before
    any calculation can be done. See :class:`Draw` below.

    :param D: Outlet width D
    :param E: Outlet length D
    :param F: Bin width F
    :param G: Bin length F
    :param H: Hopper height H
    :param J: Bin wall height J

    :returns: :class:`hamcalc.lib.AttrDict` with additional items.

        :V: Hopper Area
        :X: Bin Cross-section Area
        :Z: Total Volume
        :N: Min Hopper Slope

..  function:: cylindrical( D, F, H, J )

    Skeleton function to compute cylindrical bin volumes.
    This requires the :data:`draw` variable set to a proper
    instance of :class:`Side` or :class:`Center` before
    any calculation can be done. See :class:`Draw` below.

    :param D: Outlet Diameter D
    :param F: Bin Diameter F
    :param H: Hopper height H
    :param J: Bin wall height J

    :returns: :class:`hamcalc.lib.AttrDict` with additional items.

        :V: Hopper Area
        :X: Bin Cross-section Area
        :Z: Total Volume
        :N: Min Hopper Slope

Test Case:

>>> import hamcalc.construction.binhop as binhop
>>> rect = binhop.Rectangular( draw=binhop.Center() )
>>> bin= rect( D=3, E=8, H=12, F=12, G=12, J=12 )
>>> bin.X
144
>>> bin.V
24
>>> round(bin.N,1)
69.4
>>> round(bin.Z,3)
2635.151
>>> rect.name()
'Rectangular Bin, Center Draw Hopper'

"""
from hamcalc.lib import Solver
import math

introduction= """\
HOPPERED BIN ANALYSIS                                  by George Murphy, VE3ERP


  │«─ F ─»│
  ┌───────┐«─┐«─┐
  │  bin  │  J  │
  └───────┤«─┤  │
   \hopper│  H  M
    \     │  │  │
     └────┘──┘«─┘
   ─»│ D  │«─

 This program calculates dimensions and cubic capacity of hoppered rectangular
 or round bins and tanks. Dimensions can be entered in any units of measure,
 bearing in mind that the calculated results will be in the same units.
"""

def intro():
    return introduction

class Draw:
    """Strategy class definition for draw placement.

    A subclass instance is attached to the :class:`Hopper` instance.

    ::

        rectangular.draw = Center()

    or

    ::

        solver= Cylindrical( draw=Side() )
    """
    pass

class Side( Draw ):
    """Side draw calculation.
    This is the ``.draw`` attribute of a :class:`Hopper`.
    """
    def angle( self, args ):
        """Compute the side-fed hopper angle.

        :param D: Outlet diameter D
        :param H: Hopper height H
        :param F: Bin Diameter F
        """
        return math.degrees( math.atan2( args.H, args.F-args.D ) )

class Center( Draw ):
    """Center Draw calculation.
    This is the ``.draw`` attribute of a :class:`Hopper`.
    """
    def angle( self, args ):
        """Compute the center-fed hopper angle.

        :param D: Outlet diameter D
        :param H: Hopper height H
        :param F: Bin Diameter F
        """
        return math.degrees( math.atan2( 2*args.H, args.F-args.D ) )

class Hopper( Solver ):
    """Abstract superclass for hopper solvers.
    A subclass must handle the proper geometry of the hopper.
    """
    def __init__( self, draw=None ):
        super().__init__()
        self.draw= draw
    def name( self ):
        return "{0} Bin, {1} Draw Hopper".format(
            self.__class__.__name__,
            self.draw.__class__.__name__ )
    def solve( self, args ):
        args.V= self.hopper_section( args )
        args.X= self.bin_section( args )
        args.Z= args.H/3 * ( args.V + args.X + math.sqrt(args.V*args.X) ) + args.X*args.J
        args.M= args.H + args.J
        args.N= self.draw.angle( args )
        return args

class Rectangular( Hopper ):
    """Rectangular Hopper."""
    def hopper_section( self, args ):
        """Hopper cross section area.

        :param D: Outlet width D
        :param E: Outlet length D
        """
        return args.D * args.E
    def bin_section( self, args ):
        """Bin cross section area.

        :param F: Bin width F
        :param G: Bin length F
        """
        return args.F * args.G

class Cylindrical( Hopper ):
    """Cylindrical Hopper."""
    def hopper_section( self, args ):
        """Hopper cross section area.

        :param D: Outlet diameter D
        """
        return math.pi*(args.D/2)**2
    def bin_section( self, args ):
        """Bin cross section area.

        :param F: Bin diameter D
        """
        return math.pi*(args.F/2)**2

rectangular= Rectangular()
cylindrical= Cylindrical()
