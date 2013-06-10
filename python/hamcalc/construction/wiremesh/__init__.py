"""hamcalc.construction.wiremesh

These are two limited kind of **Solver** that elaborates
a wire mesh design.

Notes on the Beaufort Scale.

..  math::

    v = 0.836 B^{3/2} \\text{ m/s}

    B^{3/2} = \\frac{v}{0.836}

    B = \\left(\\frac{v}{0.836}\\right)^{2/3}

Test Cases: Wind Speed

>>> import hamcalc.construction.wiremesh as wiremesh
>>> x = wiremesh.Beaufort.to_std( 3 )
>>> round( wiremesh.KNOT.from_std( x ), 1 )
8.4
>>> round( wiremesh.MPS.from_std( x ), 1 )
4.3
>>> y = wiremesh.KNOT.to_std( 24 )
>>> round( wiremesh.MPS.from_std( y ), 1 )
12.3
>>> round( wiremesh.Beaufort.from_std( y ), 1 )
6.0

Test Cases: Wire Mesh

>>> import hamcalc.construction.wiremesh as wiremesh
>>> wm= wiremesh.mesh( A=.25, D=.0625, SA=12 )
>>> round( wm.TV*wiremesh.Al_lb_cu_in, 2 )
4.14
>>> round( wm.TV*wiremesh.Cu_lb_cu_in, 2 )
13.62
>>> round( wm.TV*wiremesh.S_lb_cu_in, 2 )
12.03
>>> round( wm.FF*100, 1 )
43.8
>>> round( wm.FA, 1 )
5.2

>>> for x in range(1,12):
...     k = (x+1)*5
...     f = wiremesh.force( A=.25, D=.0625, SA=12, W_k= k )
...     print( k, round(f.Y_lb,1), round(f.Y_n,1) )
10 1.6 0.7
15 4.2 1.9
20 6.8 3.1
25 11.0 5.0
30 16.3 7.4
35 22.1 10.0
40 28.9 13.1
45 36.2 16.4
50 44.6 20.2
55 54.1 24.5
60 64.6 29.3
>>>

"""
from hamcalc.lib import Solver, Unit, AttrDict, NoSolutionError, convert
from hamcalc.math.equiv import INCH, MILLIMETRE, SQ_METRE, SQ_FOOT
from hamcalc.navigation.satorbit import KPH, MPH, MPM, KNOT, MPS
from hamcalc.math.centrif import KILOGRAM, POUND_MASS, KILOGRAM_FORCE, POUND_FORCE
import math

# Weight of metals
Al_lb_cu_in= 0.0975 # weight/cu.in. of aluminum
Cu_lb_cu_in= 0.321  # weight/cu.in. of copper
S_lb_cu_in=  0.2835 # weight/cu.in. of steel

class Beaufort( Unit ):
    """beaufort"""
    name= "beaufort"
    standard= MPM
    @classmethod
    def to_std( class_, value ):
        # Convert Beaufort scale to m/s
        mps = 0.836*value**(3/2)
        # Standardize m/s value
        s= MPS.to_std( mps )
        return s
    @classmethod
    def from_std( class_, value ):
        # Convert standard to m/s
        mps = MPS.from_std( value )
        # Convert m/s to Beaufort scale
        b = (mps/0.836)**(2/3)
        return b

introduction="""\
WIRE MESH SCREENS                                       by George Murphy VE3ERP

   This program may be used in the design of reflectors for antennas
   in the VHF/UHF frequency range, or for anything else you want to
   make out of chain link fencing, chicken wire, hardware cloth, or
   window screening.

   The calculated effects of wind do not apply if any part of the mesh
   is covered by ice, snow, leaves, plastic sheets, or other matter
   that obstructs the free passage of air through the mesh.

   A hexagonal mesh screen of a given size contains the same amount of
   wire as a square mesh screen of the same size, if both screens have
   the same size mesh (i.e. same distance between between opposite
   sides of the hexagonal or square opening).
"""

def intro():
    return introduction

def mesh( A, D, SA ):
    """Compute a number of values for the overall wire mesh.

    :param A: Center-to-center distance across mesh opening (in)
    :param D: Wire diameter (in)
    :param SA: Screen area (ft²)
    :returns: dict with computed values.
        -   WV Wire Volume per cell
        -   N number of cells
        -   TV total volume
        -   FA windvane area
    """
    results= AttrDict( A=A, D=D, SA=SA )

    # Mesh Description
    results.CA=3.464*(A/2)**2 # Cell Area
    LS=1.155*A/2 # Length of Side
    WL=3*LS # Wire Length
    LSO=1.155*(A-D)/2
    results.OA=3.464*((A-D)/2)**2    # Open Area
    results.WA = results.CA - results.OA # Wire Area

    # Materials Description
    results.WV=WL*math.pi*(D/2)**2
    results.N=SA/results.CA*144
    results.TV=results.WV*results.N
    results.FF=results.WA/results.CA
    results.FA=SA*results.FF

    return results

def constrain( x, lo, hi ):
    """Constrain a value to be between lo and hi, inclusive."""
    return min( hi, max( lo, x ) )

def wind_force( knots ):
    """Retun wind force value for wind speed in
    knots. This does a table lookup by rounding
    wind speed up to the next multiple of 5 knots.
    """
    wind_force = [ .3, .8, 1.3, 2.1, 3.1, 4.2, 5.5, 6.9, 8.5, 10.3, 12.3 ]
    k = constrain( 5*int(knots/5+.5), 10, 60 )
    x = (k-10)//5
    return wind_force[x]

def force( A, D, SA, W_k=None, W_mph=None, W_kph=None, W_b=None ):
    """Compute force on a wire mesh for a given windspeed
    in knots, kph, mph or on the Beaufort scale.

    This relies an in internal table that has forces
    for knots between 10 and 60, where :math:`10 \\leq 5(x+1) \\leq 60`.
    This value of *x* is an integer :math:`1 \\leq x \\leq 11`.

    Therefore, wind speeds are rounded up to the nearest
    5 knots.

    :param A: Center-to-center distance across mesh opening (in)
    :param D: Wire diameter (in)
    :param SA: Screen area (ft²)
    :returns: dict with mesh values plus force values.
    """
    results= mesh( A, D, SA )
    if W_k is not None:
        # The standard case.
        results.W_k= W_k
    elif W_mph is not None:
        # Make knots from MPH
        results.W_k= convert( W_mph, MPH, KNOT )
    elif W_kph is not None:
        # Make knots from KPH
        results.W_k= convert( W_kph, KPH, KNOT )
    elif W_b is not None:
        # Make knots from Beaufort Scale winds
        results.W_k= convert( W_kph, Beaufort, KNOT )
    else:
        raise NoSolutionError( "No windspeed given" )

    results.W_mph, results.W_kph, results.W_b = convert( results.W_k, KNOT,
        MPH, KPH, Beaufort )
    results.Y_lb = wind_force( results.W_k )*results.FA
    results.Y_n = convert( results.Y_lb, POUND_FORCE, KILOGRAM_FORCE )

    return results
