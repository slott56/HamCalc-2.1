"""hamcalc.construction.stairs.func

'Simple' functions to implement stairs design.

Note that these calculations only work in inches.
The units, therefore, must all be converted from
input to INCH and from INCH to desired output.
"""
__version__ = "2.1"

import math
from hamcalc.lib import AttrDict

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
