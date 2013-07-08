"""hamcalc.construction.binhop

Calculate volumes of hoppered bins as well as support design of bins.

Analysis
----------

There are two functions defined from :class:`Rectangular`
and :class:`Cylindrical`. These functions don't have the
:data:`draw` variable set, so there's a two-step use case.

1.  Set :data:`draw`.

2.  Calculate.

Example::

    rectangular.draw= Center()
    rectangular( D=3, E=8, H=12, F=12, G=12, J=12 )

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

Test Case for analysis:

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

Design
--------

The :func:`design_hopper` and :func:`design_final` functions
support design. These require a :class:`Shape` object,
either :class:`Square` or :class:`Circle`.

Test Case for design:

>>> import hamcalc.construction.binhop as binhop
>>> result= binhop.design_hopper( binhop.Square(), V=2900, N=70, D=5 )
>>> round(result.V_H)
2900
>>> round(result.F,3)
18.622
>>> round(result.H,3)
18.714

>>> final= binhop.design_final( binhop.Square(), V=2900, N=70, D=5, M=36, H=18.714, F=18.622, V_H=2900 )
>>> round(final.V_T)
2900
>>> round(final.V_H)
2567
>>> round(final.V_B)
333
>>> round(final.J,3)
1.041
>>> round(final.H,3)
17.714

"""
__version__ = "2.1"

from hamcalc.lib import Solver, AttrDict
from hamcalc.math.propcirc import bisection
import math

introduction= {}
introduction[1]= """\
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

introduction[2]= """\
HOPPERED BIN DESIGN                                            by George Murphy


     │«─── F ───»│
  ┌─»┌───────────┐«─┐
  │  │    bin    │  J
  │  └───────────┘«─┤
  M   \         /   │
  │    \hopper /    H
  │     \     /     │
  └─────»└───┘«─────┘
         │«D»│

 This program calculates dimensions of hoppered bins and tanks of any cubic
 capcacity. Dimensions can be entered in any units of measure, bearing in mind
 that the calculated results will be in the same units.
"""

def intro( op=1 ):
    return introduction[op]

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
    """Rectangular Hopper analysis."""
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
    """Cylindrical Hopper analysis."""
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

class Shape:
    """A shape for hopper design purposes.
    An instance is provided to :func:`design_hopper`
    or :func:`design_final`.
    """
    def volume( self, args ):
        """Compute Hopper Volume, V_H, from H, N and D."""
        pass
    def area( self, args ):
        """Compute area, A, from diameter (or size), D, H, and angle, N."""
        pass
    def height( self, args ):
        """Compute total height, K, and many other things,
        from D, H and N.
        """
        self.volume( args )
        self.area( args )
        args.V_B = args.V - args.V_H
        args.J = args.V_B / args.A
        args.K = args.H + args.J
        args.V_T = args.V_H + args.V_B
        return args

class Square( Shape ):
    """Design a square-shaped bin and hopper."""
    def volume( self, args ):
        """Compute Hopper Volume, V_H, from H, N and D."""
        E = args.H/math.tan( math.radians(args.N) )
        args.F = 2*E + args.D
        args.V_H = args.H/3*(args.F**2+args.D**2+math.sqrt(args.F**2*args.D**2))
        return args
    def area( self, args ):
        """Compute bin area, A, from bin size, F."""
        args.A = args.F**2
        return args

class Circle( Shape ):
    """Design a circular bin and hopper."""
    def volume( self, args ):
        """Compute Hopper Volume, V_H, from H, N and D."""
        E = args.H/math.tan( math.radians(args.N) )
        args.F = 2*E + args.D
        args.V_H = math.pi/12*args.H*(args.F**2+(args.F*args.D)+args.D**2)
        return args
    def area( self, args ):
        """Compute bin area, A, from bin size, F."""
        args.A = math.pi*(args.F/2)**2
        return args

def design_hopper( shape, **args ):
    """Given a shape (Square or Circle),
    and some parameters, initial design with
    minimum height, H, for the hopper.

    :param V: target volume
    :param N: given angle
    :param D: given size or diameter
    :returns: dict with design parameters added.
    """
    args= AttrDict( args )
    def hopper_vol_from_h( H ):
        args.H = H
        shape.volume( args )
        return args.V - args.V_H
    # In principle, we should develop a rational upper limit.
    # The overall volume, though, is a good estimator for the
    # upper bound.
    args.H = bisection( hopper_vol_from_h, 0, args.V )
    return args

def design_final( shape, **args ):
    """Given a shape (Square or Circle),
    and some parameters, final design.

    :param V: target volume
    :param N: given angle
    :param D: given size or diameter
    :param M: hopper height, larger than the minimum
    :returns: dict with design parameters added.
    """
    args= AttrDict( args )
    def height_from_h( H ):
        args.H = H
        shape.height( args )
        return args.K - args.M
    args.H = bisection( height_from_h, args.M, args.H-1 )
    return args
