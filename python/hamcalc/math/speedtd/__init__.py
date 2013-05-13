"""hamcalc.math.speedtd -- Speed/Time/Distance Calculator

A **Solver** for :math:`d = s \\times t` calculations.

Plus a **Solver** for MPG, gallons, distance (or LPK, liters, kilometers)
problems.

Test Cases

>>> import hamcalc.math.speedtd as speedtd
>>> speedtd.speed_time_distance( D=37, T=11 )
{'S': 3.3636363636363638, 'D': 37, 'T': 11}
>>> speedtd.fuel_volume_distance( D=53, V=17 )
{'R': 3.1176470588235294, 'D': 53, 'V': 17}

"""
from hamcalc.lib import AttrDict

def intro():
    return """\
SPEED, TIME and DISTANCE Calculator                     by George Murphy VE3ERP
"""

def speed_time_distance( **kw ):
    """Solver for speed/time/distance problems.

    :param S: speed
    :param T: time
    :param D: distance
    :returns: Dict with all three values.
    """
    args= AttrDict( kw )
    if "S" in args and "T" in args:
        args.D = args.S * args.T
    elif "S" in args and "D" in args:
        args.T = args.D / args.S
    elif "T" in args and "D" in args:
        args.S = args.D / args.T
    return args

def fuel_volume_distance( **kw ):
    """Solver for fuel-rate/volume/distance problems.

    :param R: fuel consumption rate (e.g. miles/gallon)
    :param V: volume (e.g. gallons)
    :param D: distance (e.g. miles)
    :returns: Dict with all three values.
    """
    args= AttrDict( kw )
    if "R" in args and "V" in args:
        args.D = args.R * args.V
    elif "R" in args and "D" in args:
        args.V = args.D / args.R
    elif "V" in args and "D" in args:
        args.R = args.D / args.V
    return args
