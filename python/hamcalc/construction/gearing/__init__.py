"""hamcalc.construction.gearing

Test Cases

>>> import hamcalc.construction.gearing as gearing
>>> D, E, C, R = gearing.design_gear_distances( P=35, A=92, B=189 )
>>> round(D,3)
2.629
>>> round(E,3)
5.4
>>> round(C,3)
4.014
>>> round(R,3)
2.054

>>> import hamcalc.construction.gearing as gearing
>>> choices= list( gearing.design_teeth_iter( P=35, K=3500, S=1700, C=4 ) )
>>> len(choices)
9
>>> choices[0][0]
88
>>> choices[0][1]
181
>>> round(choices[0][2],3)
3.843
>>> round(choices[0][3],2)
1701.66
>>> round(choices[4][3],2)
1703.7
>>> round(choices[8][3],2)
1696.97

>>> import hamcalc.construction.gearing as gearing
>>> torque= gearing.torque( 80, 3500, 1703.7 )
>>> round(torque[0])
1441
>>> round(torque[1])
2959

"""
__version__ = "2.1"


def intro():
    return """\
GEARING DESIGN                                          by George Murphy VE3ERP
"""

class GearTooSmall( Exception ):
    """This exception is raised when a selected gear pair
    can't fit the minimum gear teeth requirements.
    """
    pass

def design_gear_distances( P, A, B ):
    """Given a Diametrical Pitch, *P*, plus two gear sizes
    *A*, and *B* specified by number of teeth, compute
    the final gear size and center-to-center spacing.

    :param P: Diametrical Pitch, must not be zero
    :param A: No. of teeth - Gear A
    :param B: No. of teeth - Gear B
    :returns: D, E, C and R, diameters of each gear,
        center-to-center distance and actual ratio.
    """
    D = A/P
    E = B/P
    C = (D+E)/2
    R = A/B if A/B > 1 else B/A
    return D, E, C, R

def design_from_A( P, A, K, S ):
    """Given a Diametrical Pitch, *P*,
    a gear size *A*, and
    pair of RPMs, *K* and *S* compute the other gear's
    information.

    :param P: Diametrical pitch, must not be zero
    :param A: No. of teeth - Gear A
    :param K: Known RPM
    :param S: Known RPM
    :return: A, B, C and S: given A, calculated B,
        center-to-center, *C* and RPM, *S*.
    """
    R = K/S
    B= int( A*R +.5 )
    C_alt= (A+B)/(2*P)
    S_alt= A*K/B
    return A, B, C_alt, S_alt

def design_teeth_iter( P, K, S, C, offset=4 ):
    """Given a Diametrical Pitch, *P*, plus two gear RPM's
    *K*, and *S*, as well as a desired Center-to-center
    distance, *C*, compute
    suggested gear sizes and center-to-center spacing.

    :param P: Diametrical pitch, must not be zero
    :param K: Known RPM
    :param S: Sought RPM
    :param C: Desired c.c. distance (in.)

    :returns: 4-tuples of A, B teeth count, C c-to-c distance and S,
        RPM "sought".
    """
    K, S = max( K, S ), min( K, S )
    R = K/S
    A = int( 2*P*C/(1+R) +.5 )
    if A < 8:
        raise GearTooSmall
    for Y in range(A-offset,A+offset+1):
        yield design_from_A( P, Y, K, S )
        #B= int( Y*R +.5 )
        #C_alt= (Y+B)/(2*P)
        #S_alt= Y*K/B
        #yield Y, B, C_alt, S_alt

def torque( H, K, S ):
    """Given two gear RPM's
    *K*, and *S*, as well as horsepower rating, *H*, compute
    torque on each gear.

    :param K: Known RPM
    :param S: Sought RPM
    :param H: Horsepower
    :returns: torque on each gear as a 2-tuple.
    """
    I=63025*H/K
    J=63025*H/S
    return I, J
