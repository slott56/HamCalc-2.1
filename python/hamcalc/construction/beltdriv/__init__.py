"""hamcalc.construction.beltdriv

This has several calculation functions for various parts
of the belt design process.

Test Case for :func:`pulley_choice_iter`.

>>> import hamcalc.construction.beltdriv as belt
>>> choices = list( belt.pulley_choice_iter( 1700, 3500, 7, 5, 4.5 ) )
>>> [ ( round(d,1), round(e,1) ) for d,e in choices ]
[(7, 3.4), (14.4, 7), (5, 2.4), (10.3, 5), (4.5, 2.2), (9.3, 4.5)]

>>> belt.design_pulley_distances( 9.5, 4.5 )
(7.5, 11.5)

>>> l= belt.design_belt_length( 9.5, 4.5, 9 )
>>> round(l, 1)
40.7

>>> c= belt.final_pulley_distance( 9.5, 4.5, 42 )
>>> round( c, 1 )
9.7

>>> V, T, T_E, T_D = belt.tension_torque( 9.5, 4.5, 1700, 80 )
>>> round(V,1)
2002.8
>>> round(T,1)
1318.2
>>> round(T_E,1)
2965.9
>>> round(T_D,1)
6261.3

"""
__version__ = "2.1"

import math

def intro():
    return """\
BELT DRIVES (V-belts/Gear belts)                        by George Murphy VE3ERP
"""

class BeltTooShort( Exception ):
    """This exception is raised when a selected belt
    can't fit the minimum belt length requirements.

    :func:`design_belt_length` defines the minimum.
    """
    pass

def pulley_choice_iter( X, Y, *pitches ):
    """Given X RPM and Y RPM, and a collection
    of wheel pitches, compute
    a list of potential wheel sizes that produce the desired RPM's.

    :param X: Known RPM
    :param Y: Sought RPM
    :returns: Iterates over a sequence of pulley pairs.
        This can be used to select a pulley close
        to a standard (or available) size.
    """
    R1 = Y/X
    for p in pitches:
        yield p, p/R1
        yield p*R1, p

def design_pulley_distances( D, E ):
    """Given pulley sizes D and E, compute
    minimum and ideal center-to-center distance.

    :param D: larger pitch diameter
    :param E: smaller pitch diameter
    :returns: Pair of minimum and ideal distances.
    """
    if E > D:
        D, E = E, D
    R = D/E
    if R < 3:
        G = (D+E)/2 + E
    else:
        G = 2*D
    I = (D+E)/2 + 0.5
    return I, G

def design_belt_length( D, E, C ):
    """Given pulley sizes D and E and desired
    center-to-center distance, C, compute
    the required belt length.

    :param D: larger pitch diameter
    :param E: smaller pitch diameter
    :param C: desired center-to-center distance
    :returns: design belt length. This can be used
        to select a standard (or available) belt length.
    """
    if E > D:
        D, E = E, D
    V = math.pi/2 * ( D + E )
    W = (D - E)**2/(4*C)
    M = 2*C + V + W
    return M

def final_pulley_distance( D, E, L ):
    """Given pulley sizes D and E and actual belt
    length, L, compute
    the required center-to-center distance.

    :param D: larger pitch diameter
    :param E: smaller pitch diameter
    :param L: available belt length.
    :returns: center to center distance.
    :rauses: BeltTooShort if the belt can't be fit.
    """
    if E > D:
        D, E = E, D
    F = 4*L - 2*math.pi*(D + E)
    H = 32*(D-E)**2
    if F**2 < H:
        raise BeltTooShort()
    C = (F+math.sqrt(F**2-H))/16
    min_d, ideal_d = design_pulley_distances(D,E)
    if C < min_d:
        raise BeltTooShort()
    return C

def tension_torque( D, E, X, HP ):
    """Given pulley sizes D and E, RPM of X,
    and Horsepower of HP, compute
    velocity, tension on belt, and torque on each pulley.

    :param D: larger pitch diameter
    :param E: smaller pitch diameter
    :param X: Known RPM
    :param HP: Horsepower
    :returns: Tuple with Velocity, Tension,  Torque on small
        wheel, Torque on large wheel
    """
    V = 0.2618*E*X
    T = 33000*HP/V
    T_E = T*E/2
    T_D = T*D/2
    return V, T, T_E, T_D
