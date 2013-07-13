"""hamcalc.audio_photo.elflash

This has calculations for flash photography.

..  py:function:: flash( B, A, G, D, F )

    Solves electronic flash problems.

    :param F: Aperture, ƒ/
    :param G: Guide number in feet (:math:`0.3048G` metres)
    :param A: Film speed, ISO
    :param B: Beam Candle Power Seconds
    :param D: Subject distance in feet (:math:`0.3048D` metres)

    :returns: AttrDict with all values filled in

Test Case

>>> import hamcalc.audio_photo.elflash as elflash
>>> flash= elflash.Flash()
>>> f= flash( G=12, D=15, A=100 )
>>> round( f.B, 3 )
28.8
>>> round( f.F, 3 )
0.8

"""
import math
from hamcalc.lib import Solver, NoSolutionError

class Flash( Solver ):
    """Solver for electronic flash problems."""
    def solve( self, args ):
        """Compute missing values.

        :F: Aperture, ƒ/
        :G: Guide number in feet (:math:`0.3048G` metres)
        :A: Film speed, ISO
        :B: Beam Candle Power Seconds
        :D: Subject distance in feet (:math:`0.3048D` metres)
        """
        while not all( var in args for var in ('F', 'G', 'A', 'B', 'D') ):
            if 'F' not in args and 'G' in args and 'D' in args:
                args.F = args.G/args.D
            elif 'D' not in args and 'G' in args and 'F' in args:
                args.D = args.G/args.F
            elif 'G' not in args and 'D' in args and 'F' in args:
                args.G = arsg.D*args.F
            elif 'B' not in args and 'G' in args and 'A' in args:
                args.B = 20*args.G**2/args.A
            elif 'A' not in args and 'G' in args and 'B' in args:
                args.A = 20*args.G**2/args.B
            elif 'G' not in args and 'A' in args and 'B' in args:
                args.G = math.sqrt( args.A*args.B/20 )
            else:
                # Partial solutions are permitted, so this is not an error.
                break
        return args

def aperture_iter( G ):
    """Yields a sequence of F and D values for a given Guide number.

    :param G: Guide number in feet
    :returns: sequence of F aperature and D subject distance in feet.
    """
    for F in 1.4,2,2.8,4,5.6,8,11,16,22,32,45,64:
        yield F, G/F

flash= Flash()
