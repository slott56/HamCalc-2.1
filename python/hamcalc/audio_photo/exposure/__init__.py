"""hamcalc.audio_photo.exposure

Calculate camera, enlarger and filter exposure values.

There are three callable objects that work like functions.

..  py:function:: camera( C, I, S, F )

    Solve camera exposure problems.

    :param C: Footcandles
    :param I: Film Speed (ISO)
    :param S: Exposure Time
    :param F: Aperture

    Given any three, compute the fourth.

    :returns: :class:`hamcalc.lib.AttrDict` with all four values.

..  py:function:: enlarger( S_O, F_O, L_O, W_O, H_O, S, F, L, W )

    Solve enlarger exposure problems.

    :param S_O: original Exposure Time
    :param F_O: original Aperture
    :param L_O: original length
    :param W_O: original width
    :param H_O: original height of lens
    :param S: desired Exposure Time
    :param F: desired Aperture
    :param L: original length
    :param W: original width
    :param H: height of lens

    Given all the original values and two of the desired
    values, the other desired values are computed.

    :returns: :class:`hamcalc.lib.AttrDict` with calculated values.

Some other function test cases

>>> import hamcalc.audio_photo.exposure as exposure
>>> for P in range(1,13):
...     print( P, exposure.time_floor( 4096/2**P ) )
...
1 2000
2 1000
3 500
4 250
5 125
6 60
7 30
8 15
9 8
10 4
11 2
12 1

Test Cases for Camera

>>> import hamcalc.audio_photo.exposure as exposure
>>> c = exposure.camera( I=100, S=1/125, F=8 )
>>> c
{'I': 100, 'S': 0.008, 'EV': 13.0, 'C': 1600.0, 'F': 8}
>>> list( (round(F,1),int(1/S)) for F,S in exposure.aperture_iter( c ) )
[(1.4, 3999), (2.0, 1999), (2.8, 999), (4.0, 499), (5.7, 249), (8.0, 124), (11.3, 62), (16.0, 31), (22.6, 15), (32.0, 7), (45.3, 3), (64.0, 1)]
>>> list( (round(F,1),S) for F,S in exposure.exposure_iter( c ) )
[(2.0, 2000), (2.8, 1000), (4.0, 500), (5.7, 250), (8.0, 125), (11.5, 60), (16.3, 30), (23.1, 15), (31.6, 8), (44.7, 4), (63.2, 2), (89.4, 1)]

Test Cases for Enlarger

>>> import hamcalc.audio_photo.exposure as exposure
>>> e = exposure.enlarger( S_O=1/125, F_O=8, W_O=35, L_O=46, H_O=100,
... L=254, S=1/60 )
>>> round(e.F,1)
2.1
>>> int(1/e.S)
60
>>> int(e.L)
254
>>> int(e.W)
193
>>> round(e.H,1)
552.2

Test Cases for Filter

>>> import hamcalc.audio_photo.exposure as exposure
>>> S, F = exposure.filter( S=1/125, F=8, X=1.8 )
>>> int(S)
69
>>> round(F,1)
6.0

"""
from hamcalc.lib import Solver, NoSolutionError
import math

def footer():
    return """\
The exposures and apertures shown are mathematically correct but,
due to the reciprocity failure characteristics of each particular
film emulsion, unusually short (less than 1/1000 sec.) or very long
(more than 5 sec.) indicated exposures may have to be increased by
a factor of up to 3x. Unusually long or short exposures can also
cause colour shifts in some colour films.
"""

def floor_to( S, n ):
    return n*int(S//n)

def time_floor(S):
    if 1000 <= S: return floor_to(S,100)
    elif 100 <= S < 1000: return floor_to(S,25)
    elif 15 <= S < 100: return floor_to(S,15)
    else: return int(S)

class Camera( Solver ):
    """Solver for camera exposure problems."""
    def solve( self, args ):
        """Given three of the four values, compute
        the remaining one.

        :C: Footcandles (integer, rounded up)
        :I: Film Speed (ISO) (integer)
        :S: Exposure Time (fraction of 4000)
        :F: Aperture ƒ/ (power of :math:`\sqrt{2}`

        Additionally, the EV value is also computed.
        """
        if 'C' in args and 'I' in args and 'S' in args:
            args.F = math.sqrt( args.C*args.I*args.S/20 )
        elif 'C' in args and 'I' in args and 'F' in args:
            args.S = 20*args.F**2/args.C/args.I
        elif 'F' in args and 'I' in args and 'S' in args:
            args.C = 20*args.F**2/args.S/args.I
        elif 'C' in args and 'F' in args and 'S' in args:
            args.I = 20*args.F**2/args.C/args.S
        args.EV = math.log( 0.0512*args.C*args.I, 2 )
        return args

def aperture_iter( args ):
    """Given a camera solution, iterate through aperature settings.
    Times are actual times, not inverted values.
    """
    C, I = args.C, args.I
    s2= math.sqrt(2)
    for P in range(1,13):
        F= s2**P
        S= 20*F**2/C/I
        yield F, S

def exposure_iter( args ):
    """Given a camera solution, iterate through exposure times.
    The times are inverted: 120, for example, means 1/120 second.
    """
    C, I = args.C, args.I
    for P in range(1,13):
        S= time_floor(4096/2**P)
        F= math.sqrt(C*I/(S*20))
        yield F, S

class Enlarger( Solver ):
    """Solver for enlarger problems."""
    def solve( self, args ):
        """Given original exposure information:
        aperture and exposure (F_O, S_O)
        and original Length and width (L_O and W_O);
        given one dimension (L or W), compute the other dimension,
        given exposure or aperture (S or F) compute
        the the other.

        Also, given original height (H_O) compute
        a new height.

        Original Values

        :F_O: Aperture ƒ/ (power of :math:`\sqrt{2}`
        :S_O: Exposure Time (fraction of 4000)
        :L_O: length
        :W_O: width
        :H_O: Original Lens height

        New setup

        :F: Aperture ƒ/ (power of :math:`\sqrt{2}`
        :S: Exposure Time (fraction of 4000)
        :L: length
        :W: width
        :H: lens height

        For the new setup, either *F* or *S* must be given.
        Also, either *W* or *L* must be given.
        """
        R = args.L_O/args.W_O
        if 'L' in args and 'W' not in args:
            args.W = args.L/R
        elif 'W' in args and 'L' not in args:
            args.L = args.W*R
        args.Q = args.L*args.W/args.L_O/args.W_O
        args.Y = 4 * args.Q * args.S_O / args.F_O**2
        if 'F' in args and 'S' not in args:
            args.S = args.Y*args.F**2/4
        elif 'S' in args and 'F' not in args:
            args.F = 2*math.sqrt( args.S/args.Y )
        if 'H_O' in args:
            args.H = args.H_O*args.W/args.W_O
        return args

def filter( S, F, X ):
        """Given calculated exposure and aperture,
        and filter factor, compute new
        exposure and new aperture.

        :param S: desired Exposure Time
        :param F: desired Aperture
        :param X: filter factor

        :returns: INVERTED Exposure and Aperture.
            The INVERTED exposure of 120 means 1/120 second.
        """
        S_f = int( 1/(S*X) + .5 )
        F_f = math.sqrt( F**2/X )
        return S_f, F_f

camera= Camera()
enlarger= Enlarger()
