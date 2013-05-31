"""hamcalc.math.propcirc -- Circle, Properties of

This includes the bisection algorithm for approximation.

Here are some test cases.

>>> import hamcalc.math.propcirc as propcirc
>>> import math
>>> propcirc.circle( R=12, angle=math.radians(60) )
{'A': 452.3893421169302, 'C': 75.39822368615503, 'angle': 1.0471975511965976, 'D': 24, 'G': 1.6076951545867355, 'L_A': 12.566370614359172, 'A_G': 13.044394613675443, 'L_C': 11.999999999999998, 'R': 12, 'A_C': 75.39822368615502}
>>> propcirc.circle( D=24, angle=math.radians(60) )
{'A': 452.3893421169302, 'C': 75.39822368615503, 'angle': 1.0471975511965976, 'D': 24.0, 'G': 1.6076951545867355, 'L_A': 12.566370614359172, 'A_G': 13.044394613675443, 'L_C': 11.999999999999998, 'R': 12.0, 'A_C': 75.39822368615502}
>>> propcirc.circle( C=75.4, angle=math.radians(60) )
{'A': 452.41065813415986, 'C': 75.4, 'angle': 1.0471975511965976, 'D': 24.000565418257818, 'G': 1.6077330304281274, 'L_A': 12.566666666666666, 'A_G': 13.045009249155228, 'L_C': 12.000282709128907, 'R': 12.000282709128909, 'A_C': 75.40177635569331}
>>> propcirc.circle( A=452.4, angle=math.radians(60) )
{'A': 452.4, 'C': 75.39911183784653, 'angle': 1.0471975511965976, 'D': 24.000282707463835, 'G': 1.6077140923958928, 'L_A': 12.566518639641089, 'A_G': 13.044701927795316, 'L_C': 12.000141353731916, 'R': 12.000141353731918, 'A_C': 75.39999999999999}
>>> propcirc.circle( L_C=12, angle=math.radians(60) )
{'A': 452.3893421169304, 'C': 75.39822368615505, 'angle': 1.0471975511965976, 'D': 24.000000000000004, 'G': 1.6076951545867357, 'L_A': 12.566370614359174, 'A_G': 13.04439461367545, 'L_C': 12.0, 'R': 12.000000000000002, 'A_C': 75.39822368615505}
>>> propcirc.circle( L_A=12.56, angle=math.radians(60) )
{'A': 451.93077414974937, 'C': 75.36000000000001, 'angle': 1.0471975511965976, 'D': 23.98783302281047, 'G': 1.60688012165867, 'L_A': 12.56, 'A_G': 13.031172061850732, 'L_C': 11.993916511405233, 'R': 11.993916511405235, 'A_C': 75.3217956916249}
>>> propcirc.circle( G=1.6, angle=math.radians(60) )
{'A': 448.0690272864175, 'C': 75.03733375924637, 'angle': 1.0471975511965976, 'D': 23.885125168440826, 'G': 1.6, 'L_A': 12.506222293207728, 'A_G': 12.919820742768572, 'L_C': 11.942562584220411, 'R': 11.942562584220413, 'A_C': 74.67817121440291}
>>> propcirc.circle( R=12, L_C=12 )
{'A': 452.3893421169302, 'C': 75.39822368615503, 'angle': 1.0471975511965976, 'D': 24, 'G': 1.6076951545867355, 'L_A': 12.566370614359172, 'A_G': 13.044394613675443, 'L_C': 11.999999999999998, 'R': 12, 'A_C': 75.39822368615502}
>>> propcirc.circle( R=12, G=1.6 )
{'A': 452.3893421169302, 'C': 75.39822368615503, 'angle': 1.0446296436120972, 'D': 24, 'G': 1.5999999999999996, 'L_A': 12.535555723345166, 'A_G': 12.952155424152622, 'L_C': 11.973303637676612, 'R': 12, 'A_C': 75.213334340071}
>>> propcirc.circle( L_A=12.56, G=1.61 )
{'A': 450.09677997191295, 'C': 75.20693418466634, 'angle': 1.049328872579753, 'D': 23.939110660552977, 'G': 1.6099999693011857, 'L_A': 12.56, 'A_G': 13.054769563165337, 'L_C': 11.991641677007895, 'R': 11.969555330276489, 'A_C': 75.16880747413634}

"""

__version__ = "2.1"

import math
from hamcalc.lib import AttrDict

introduction = """\

PROPERTIES OF THE CIRCLE                                    by George C. Murphy
    Draw a circular clock face. Mark 3 points on the circle: A at 10
    o'clock, B at 2 o'clock, C at the centre of the circle. Draw lines
    from A to B, B to C, and C to A.

    The following definitions apply to this diagram:

    RADIAL - any line drawn between the centre of a circle and any
      point on the circumference. Lines AC and BC are radials.
    CHORD - a straight line drawn between any two points on the
      circumference. Line AB is a chord.
    ARC - that part of the circumference which lies between any two
      points. The curved line between A and B is an arc.
    ANGLE - the angle in degrees between 2 radials that terminate at
      the ends of a chord or arc. (angle ACB on your sketch).
    SECTOR - the pie shaped figure formed by two radials and the arc
      joining their ends.
    SEGMENT - the figure formed by a chord and an arc joining the two
      ends of the chord.
    HEIGHT (of segment) - the distance between the midpoints of the
      arc and the chord that form a segment.
    DIMENSIONS can be entered in any unit of measure, as long as the
      same unit is used for all dimensions.
"""

class Error( Exception ):
    pass

def intro():
    """Returns the text from the introductory page."""
    return introduction

def arc_height_2_r( L_A, G, eps=1.0E-7 ):
    """Approximate a value for *R* from *L_A* and *G* via bisection.

    We're solving :math:`G = R (1 - \\cos \\frac{L_A}{2R})` for a value of *R*.

    We know only that :math:`R > 0`.

    This requires a 2-phase search.

    1. Double R until it's demonstrably too large.
    2. Bisect between R and R/2.

    :param L_A: Length of Arc
    :param G: Height of Arc
    :param eps: Epsilon -- precision of approximation.
    :return: R radius

    >>> import hamcalc.math.propcirc as propcirc
    >>> propcirc.arc_height_2_r( L_A=12.56, G=1.61 )
    11.969555330276489

    """
    def f( R ):
        return R*(1 - math.cos( L_A/(2*R) )) - G
    # Find upper bound on R.
    R= G if G>1.0 else 1.0
    G_calc= f( R )
    while G_calc > 0:
        R= 2*R
        G_calc= f( R )
    # Root lies between R/2 and R.
    return bisection( f, R/2, R, eps )

def sign( x ):
    if x < 0: return -1
    elif x > 0: return 1
    else: return 0

def bisection( f, low, high, eps=1.0E-7 ):
    """Approximate *x* where :math:`f(x)=0 \\vert l \\leq x < h` by bisection.

    :param f: A single-argument function, ``f(x)``.
    :param low: Lower bound on search.
    :param high: Upper bound on search.
    :param eps: Epsilon -- precision of approximation.
    :return: x value

    >>> import hamcalc.math.propcirc as propcirc
    >>> sqrt_13= lambda x: x**2-13
    >>> root= propcirc.bisection( sqrt_13, 0, 13 )
    >>> root
    3.6055512726306915

    ..  todo:: Optimization possible

        Cache computation of f(low).
    """
    for count in range(64): # 64 bit of precision, in effect.
        mid= (high+low)/2
        G_calc= f( mid )
        if abs(G_calc) <= eps: break
        if sign(G_calc) == sign(f(low)):
            low= mid
        else:
            high= mid
    return mid

def circle( **kw ):
    """Solve properties of a circle.

    Note that only *R* and *angle* are really **required** to compute
    all of the values. If *angle* cannot be computed, it's assumed to
    be irrelevant and angle-related values are not computed, either.

    This solver derives values for *R* or *angle* (or both, if possible)
    and then recomputes the remaining values. It's entirely possible that
    an output value will fail to agree with an input value because
    the circle was over-specified.

    It's also possible that the circle is under-specified and *R* cannot
    be computed.

    There are two subsets of parameters: Radius and Angle.
    Without the Angle, only the Radius-related values can be computed.
    With the angle, the remaining values can be computed.

    Radius-only

    :param R: Radius

    :param D: Diameter

    :param C: Circumference

    :param A: Area of entire circle.

    Radius and Angle.

    :param angle: Angle (:math:`\\theta` might be better.) This must be in radians.

    :param L_C:
        Length of Chord (A-B line on diagram).

    :param L_A:
        Length of Arc (A-B arc on diagram).

    :param G:
        Height of segment between chord and arc.

    :returns: A dictionary with 10 values, the 8 input values plus two more.
        ``A_G`` area of segment and ``A_S`` area of the whole sector.
    """
    args= AttrDict( kw )
    # Step 1A: compute R from available data.
    if "R" in args:
        r= args.R
    elif "D" in args:
        r= args.D/2
    elif "C" in args:
        r= args.C/(2*math.pi)
    elif "A" in args:
        r= math.sqrt( args.A/math.pi )
    elif "angle" in args and "L_C" in args:
        r= args.L_C/(2*math.sin(args.angle/2))
    elif "angle" in args and "L_A" in args:
        r= args.L_A/args.angle
    elif "angle" in args and "G" in args:
        r= args.G/(1-math.cos(args.angle/2))
    elif "L_C" in args and "G" in args:
        r= (4*args.G**2 + args.L_C**2)/(2*args.G)
    elif "L_A" in args and "G" in args:
        # approximate a value for *R* from *L_A* and *G*.
        r= arc_height_2_r( args.L_A, args.G )
    else:
        raise Error( "Insufficient Data")
    # Step 1B: compute angle, if possible; it's not *required*.
    # Note that *r* is known at this point.
    if "angle" in args:
        angle= args.angle
    elif "L_C" in args:
        # Legacy
        # z= args.L_C/(2*r)
        # angle= 2 * math.atan2( z, math.sqrt(1-z**2) )
        angle= 2 * math.asin( args.L_C/(2*r) )
    elif "L_A" in args:
        angle= args.L_A / r
    elif "G" in args:
        args.L_C = 2 * math.sqrt( 2*args.G*r - args.G**2 )
        # Legacy
        # z= args.L_C/(2*r)
        # angle= 2 * math.atan2( z, math.sqrt(1-z**2) )
        angle= 2 * math.asin( args.L_C/(2*r) )
    else:
        angle= None
    # Step 3: compute the outputs from *r* and *angle*.
    args.R= r
    args.D= r*2
    args.A= math.pi*r**2
    args.C= 2*math.pi*r
    if angle:
        args.angle= angle
        args.L_C= 2*r*math.sin(angle/2)
        args.L_A= r*angle
        args.G= r*(1-math.cos(angle/2))
        args.A_C= math.pi * r**2 * angle/(2*math.pi)
        args.A_G= args.A_C-(r - args.G)*(args.L_C/2)
    return args
