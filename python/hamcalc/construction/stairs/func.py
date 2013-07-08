"""hamcalc.construction.stairs.func

'Simple' functions to implement stairs design.

Note that these calculations only work in inches.
The units, therefore, must all be converted from
input to INCH and from INCH to desired output.
"""
import math
from hamcalc.math.decifrac import INCH, MILLIMETRE, FOOT, METRE, FOOT_INCH_FRAC
from hamcalc.lib import AttrDict

def max_height( unit ):
    """Returns the maximum height for economy and residential construction.

    :param units: Current units (either INCH or MILLIMETRE)
    """
    max_economy= INCH.to_std( 7.5 )
    max_residential= INCH.to_std( 8 )
    return unit.from_std( max_economy ), unit.from_std( max_residential )

def _stringer( R, T, P ):
    """Compute the stringer details for a given design.

    :param R: rise
    :param T: run
    :param P: number of rungs, steps, ramps or treads
    :returns: X and Y
    """
    X = math.sqrt( R**2 + T** 2 )
    Y = X*P
    return X, Y

def stairwell_headroom( **args ):
    """Requires the following arguments.

    :T: run
    :R: rise
    :N: no.of full risers
    :F: Floor Thickness, FL

    Updates args with "HR" and "SW".

    :SW:    Stairwell Dimension
    :HR:    Headroom Dimension
    """
    args= AttrDict( args )
    if 'F' not in args: return args
    try:
        Z = min( Z for Z in range(1,args.N+1) if Z*args.R-args.F >= 75 )
    except ValueError:
        Z = args.N
    args.HR = Z*args.R-args.F
    #args.X = args.N-Z # Legacy Quirk
    args.SW = (Z-1)*args.T
    return args

def handrail_height( **args ):
    """Compute handrail height. Requires the following arguments.

    :A: Angle in degrees.

    Updates args with

    :B: Handrail height.
    """
    args= AttrDict( args )
    if 48 < args.A <= 90:
        args.B = 34+(args.A-48.4)/41.6*14
    elif 39.2 < args.A <= 48:
        args.B = 33+(args.A-39.2)/9.2
    elif 24 < args.A <= 39.2:
        args.B = 33
    else:
        # assert A <= 24
        args.B = 33+(24-args.A)/8
    return args

def stair_design( H, L=None, R=None ):
    """Determine what kind of stair, ramp or ladded
    will be involved.

    :param H: Height
    :param L: optional Length (also called "SP" or Spread).
        If omitted, this is an unrestricted stairwell.
    :param R: If L is unknown, this must be the maximum step
        step height.
    :returns: AttrDict object with complete design.
        :H: Level-to-Level height HT
        :L: Maximum allowable spread SP
        :P: no. of rungs
        :N: no.of full risers
        :TBR:   top and bottom risers
        :A: angle
        :T: run
        :R: rise
        :X: string
        :Y: stringer
        :L: length
        :F: Floor Thickness, FL
    """
    if L is None:
        return unrestricted_risers( H, R )
    else:
        if L == 0:
            return vertical_ladder( H, L )
        A = math.degrees( math.atan2( H, L ) )
        if A <= 20.45:
            N = int(H // 5)
            if N > 1:
                return step_ramp( H, L )
            else:
                return inclined_ramp( H, L )
        else:
            return restricted_risers( H, L )

def vertical_ladder( H, L ):
    P = int( H/13.5 + .5 )
    N = int(P - 1)
    TBR = (H-13.5*N)/2
    A = 90
    R = 0
    R = 13.5
    X = 0
    Y = 0
    L = 0
    return AttrDict(locals())

def step_ramp( H, L ):
    A = math.degrees( math.atan2( H, L ) )
    N = int(H // 5)
    P = int(N - 1)
    R = H / N
    T = L / P
    X, Y = _stringer( R, T, P )
    return AttrDict(locals())

def inclined_ramp( H, L ):
    A = math.degrees( math.atan2( H, L ) )
    N = int(H // 5)
    P = R = T = 0
    X, Y = _stringer( R, T, P )
    return AttrDict(locals())

def restricted_risers( H, L ):
    A = math.degrees( math.atan2( H, L ) )
    N = int(H // 5+1)
    R = H/N
    T = 20 - 4*R/3
    while T*N-T <= L and R >= 5:
        N += 1
        R = H / N
        T = 20 - 4*R/3
    N -= 1
    P = int(N-1)
    try:
        R = H/N
    except ZeroDivisionError as e:
        return vertical_ladder(H,L)
    T = 20 - 4*R/3
    if R > 13.5 or T <= 0:
        return vertical_ladder(H,L)
    X, Y = _stringer( R, T, P )
    return AttrDict(locals())

def unrestricted_risers( H, R ):
    N = int( H/R + .5 )
    P = int(N-1)
    R = H/N
    while R < 5 and N-1 != 0:
        N -= 1
        P = int(N-1)
        R = H/N
    T = 20-4*R/3
    L = P*T
    A = math.degrees( math.atan2(R,T) )
    if 17.35 <= A < 33:
        T = 25 + (33-A)/15.65 - 2*R
    X, Y = _stringer( R, T, P )
    return AttrDict(locals())

def is_ramp_inclined( **args ):
    """Does this design reflect an inclined ramp?"""
    return args['P'] == 0

def is_ladder_vertical( **args ):
    """Does this design reflect a vertical ladder?"""
    return args['A'] == 90

def is_ladder_inclined( **args ):
    """Does this design reflect an inclined ladder?"""
    return 77 <= args['A'] < 90

def is_ladder_open( **args ):
    """Does this design reflect an open stepladder?"""
    return 48.37 <= args['A'] < 77

def is_stairway( **args ):
    """Does this design reflect a stairway?"""
    return 20.45 <= args['A'] < 48.37

def is_ramp_step( **args ):
    """Does this design reflect a step ramp?"""
    return args['A'] < 20.45
