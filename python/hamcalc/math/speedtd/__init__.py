"""hamcalc.math.speedtd -- Speed/Time/Distance Calculator

..  py:function:: speed_time_distance( S=None, T=None, D=None )

    A **Solver** for :math:`d = s \\times t` calculations.
    This an instance of  :class:`Speed_Time_Distance`.

    :param S: speed
    :param T: time
    :param D: distance
    :returns: Dict with all three values.

..  py:function:: fuel_volume_distance( R=None, V=None, D=None )

    A **Solver** for MPG, gallons, distance (or LPK, liters, kilometers)
    problems.
    This an instance of  :class:`Fuel_Volume_Distance`.

    :param R: fuel consumption rate (e.g. miles/gallon)
    :param V: volume (e.g. gallons)
    :param D: distance (e.g. miles)
    :returns: Dict with all three values.

Test Cases

>>> import hamcalc.math.speedtd as speedtd
>>> speedtd.speed_time_distance( D=37, T=11 )
{'S': 3.3636363636363638, 'T': 11, 'D': 37}
>>> speedtd.fuel_volume_distance( D=53, V=17 )
{'R': 3.1176470588235294, 'D': 53, 'V': 17}

"""
__version__ = "2.1"

from hamcalc.lib import AttrDict, Solver, NoSolutionError

def intro():
    return """\
SPEED, TIME and DISTANCE Calculator                     by George Murphy VE3ERP
"""

class Speed_Time_Distance( Solver ):
    """Solver for speed/time/distance problems."""
    def solve( self, args ):
        """Solve speed/time/distance problems.

        :param S: speed
        :param T: time
        :param D: distance
        :returns: Dict with all three values.
        """
        if "S" in args and "T" in args:
            args.D = args.S * args.T
        elif "S" in args and "D" in args:
            args.T = args.D / args.S
        elif "T" in args and "D" in args:
            args.S = args.D / args.T
        else:
            raise NoSolutionError( "Insufficient Data: {0!r}".format(args) )
        return args

speed_time_distance = Speed_Time_Distance()

class Fuel_Volume_Distance( Solver ):
    """Solver for fuel-rate/volume/distance problems."""
    def solve( self, args ):
        """Solve fuel-rate/volume/distance problems.

        :param R: fuel consumption rate (e.g. miles/gallon)
        :param V: volume (e.g. gallons)
        :param D: distance (e.g. miles)
        :returns: Dict with all three values.
        """
        if "R" in args and "V" in args:
            args.D = args.R * args.V
        elif "R" in args and "D" in args:
            args.V = args.D / args.R
        elif "V" in args and "D" in args:
            args.R = args.D / args.V
        else:
            raise NoSolutionError( "Insufficient Data: {0!r}".format(args) )
        return args

fuel_volume_distance = Fuel_Volume_Distance()
