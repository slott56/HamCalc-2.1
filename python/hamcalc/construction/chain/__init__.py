"""hamcalc.construction.chain

This has several calculation functions for various parts
of the belt design process.

Plus definitions of tensile strebgth for some common chain pitches.

The materials are a module global, :data:`material`.

..  csv-table::

    name,pitch,TS
    25,.25,925
    35,.375,2100
    40,.5,3700
    50,.625,6100
    60,.75,8500
    80,1,14500
    100,1.25,24000
    120,1.5,34000
    140,1.75,46000
    160,2,58000
    180,2.25,80000
    200,2.5,95000
    240,3,130000
    500,3,1E7

Test Cases for Materials

>>> import hamcalc.construction.chain as chain
>>> chain.material["25"]
Chain(name='25', P=0.25, TS=925)

Test Cases for :func:`design_sprocket_distances` and :func:`final_sprocket_distance`

>>> import hamcalc.construction.chain as chain
>>> V_1, I, S, R= chain.design_sprocket_distances( 59, 28, chain.material["35"] )
>>> round( V_1, 3 )
5.573
>>> round( I, 3 )
3.349
>>> round( S, 3 )
7.046
>>> round( R, 3 )
2.107
>>> C, L, L_P = chain.final_sprocket_distance( 59, 28, chain.material["35"], 6 )
>>> round( C, 3 )
6.193
>>> round( L, 3 )
78
>>> round( L_P, 3 )
29.25

Test Cases for :func:`sprocket_choice_iter`

>>> import hamcalc.construction.chain as chain
>>> choices= [ row for row in chain.sprocket_choice_iter( 3500, 1700, 24 ) ]
>>> len(choices)
35
>>> even = [ c for c in choices if c[2] ]
>>> even
[(34, 70, True), (51, 105, True)]

Test Cases for :func:`design_sprocket_size`

>>> import hamcalc.construction.chain as chain
>>> factors = chain.design_sprocket_size( 3500, 1700, 51 )
>>> factors[0]
(105, 51)
>>> round(factors[1],3)
2.059
>>> tuple( round(x,3) for x in factors[2] )
(3500.0, 1700)
>>> tuple( round(x,3) for x in factors[3] )
(3500, 1700.0)

>>> factors = chain.design_sprocket_size( 3500, 1700, 26 )
>>> factors[0]
(54, 26)
>>> round(factors[1],3)
2.077
>>> tuple( round(x,3) for x in factors[2] )
(3530.769, 1700)
>>> tuple( round(x,3) for x in factors[3] )
(3500, 1685.185)

Test Cases for :func:`design_chain_iter`

>>> import hamcalc.construction.chain as chain
>>> chains = list( chain.design_chain_iter( 54, 26, 3530.769, 1700, 80 ) )
>>> chains[0]
(Chain(name='35', P=0.375, TS=2100), 1)

Test Cases for :func:`tension_torque`

>>> import hamcalc.construction.chain as chain
>>> Q, T_A, T_B = chain.tension_torque( 54, 26, 3530.769, 1700, 80, chain.material["35"] )
>>> round(Q,3)
920.261
>>> round(T_A,3)
2967.573
>>> round(T_B,3)
1431.506

"""
from hamcalc.lib import Solver, NoSolutionError
from collections import namedtuple, OrderedDict
import math

def intro():
    return """\
TRANSMISSION CHAIN                                      by George Murphy VE3ERP
"""

Chain= namedtuple( "Chain", ["name","P","TS"] )

chain_list = [
    Chain("25",   .25,   925),
    Chain("35",   .375, 2100),
    Chain("40",   .5,   3700),
    Chain("50",   .625, 6100),
    Chain("60",   .75,  8500),
    Chain("80",  1,    14500),
    Chain("100", 1.25, 24000),
    Chain("120", 1.5,  34000),
    Chain("140", 1.75, 46000),
    Chain("160", 2,    58000),
    Chain("180", 2.25, 80000),
    Chain("200", 2.5,  95000),
    Chain("240", 3,   130000),
    Chain("500", 3,      1E7),
]

material = OrderedDict(
    (m.name,m) for m in chain_list
)


def design_sprocket_distances( X, Y, chain ):
    """Given sprocket teeth counts X and Y, and a particular
    chain description, compute
    minimum center-to-center distance.

    :param X: larger sprocket teeth
    :param Y: smaller sprocket teeth
    :param chain: instance of :class:`hamcalc.construction.chain.Chain`
    :returns: 4-tuple with
        minimum distance between sprockets, pitch diameter of both sprockets,
        and the ratio.
    """
    A, B = max( X, Y ), min( X, Y )
    R = X / Y
    I = chain.P / math.sin( math.pi/B )
    S = chain.P / math.sin( math.pi/A )
    V_1 = (I+S)/2 + chain.P
    return V_1, I, S, R

def final_sprocket_distance( X, Y, chain, V_2 ):
    """Given sprocket teeth counts X and Y, a particular
    chain description, and a desired distance, V_2, compute
    required center-to-center distance.

    :param X: larger sprocket teeth
    :param Y: smaller sprocket teeth
    :param chain: instance of :class:`hamcalc.construction.chain.Chain`
    :param V_2: Desired center-to-center distance
    :returns: 2-tuple with center to center distance, chain length in pitches and inches
    """
    A, B = max( X, Y ), min( X, Y )
    N = V_2 / chain.P
    L = int( 2*N + A/2 + B/2 + ((A-B)/(2*math.pi))**2/N )
    L = 2 * int( (5*L+5)/10 ) - 2
    C = 0
    V_1, I, S, R = design_sprocket_distances( X, Y, chain )
    while C < V_1:
        L += 2
        T = 2*L - A - B
        U = 0.81 * (A-B)**2
        C = chain.P/8 * (T + math.sqrt(T**2-U))
    return C, L, L*chain.P

def sprocket_choice_iter( X, Y, W=17 ):
    """Given sprocket RPM values X and Y, and a particular
    mimumum sprocket size, W, yield
    alternative sprocket pairs for the requested ratio.

    :param X: larger sprocket RPM
    :param Y: smaller sprocket RPM
    :param W: small sprocket minimum number of teeth.
        Less than 17 teeth is not recommended.
    :returns: Sequence of triples with two sprocket sizes and
        a boolean flag to indicate that this is an exact
        match with the given RPM values.
    """
    K, J = max( X, Y ), min( X, Y )
    Z = int( W * K / J + .5 )
    while Z < 120:
        yield W, Z, W*K == Z*J
        W += 1
        Z = int( W * K / J + .5 )

def design_sprocket_size( X, Y, B ):
    """Given sprocket RPM values X and Y, and a particular
    small sprocket size, B, compute
    the A sprocket size, as well as the actual ratio
    and final RPM combinations.

    :param X: larger sprocket RPM
    :param Y: smaller sprocket RPM
    :param B: Small sprocket size in  number of teeth
    :returns: 4-tuple with (A,B) sprocket sizes,
        the actual ratio, plus the design (X,Y) RPM pair
        and an alternate design (X,Y) RPM pair.
    """
    K, J = max( X, Y ), min( X, Y )
    A = int( (10*K*B/J+5)/10 )
    R = A/B
    E = J*R
    D = K/R
    return (A, B), R, (E, J), (K, D)

def design_chain_iter( A, B, X, Y, H ):
    """Given sprocket teeth counts, A and B,
    and an RPM values, X and Y,
    and drive horsepower, H, compute
    the minimimal chain and, possibly, the number of chain strands.
    Generally, the first value is all that's required.

    :param A: larger sprocket teeth
    :param B: smaller sprocket teeth
    :param X: larger sprocket RPM
    :param Y: smaller sprocket RPM
    :param H: Drive horsepower
    :returns: Iterates over a sequence of
        acceptable chain and number of strands.
        Strands is usually 1 but may be 2.
    """
    for c in chain_list:
        SP = A * c.P * Y/60
        Q = 6600*H/SP
        if Q*1.1 <= c.TS:
            NS = int( Q/c.TS ) + 1
            if NS * c.TS < 1.1 * Q: NS += 1
            yield c, NS

def tension_torque( A, B, X, Y, H, M ):
    """Given sprocket teeth counts, A and B,
    and an RPM values, X and Y,
    and drive horsepower, H, compute
    tension overall and torque at each sprocket.

    :param A: larger sprocket teeth
    :param B: smaller sprocket teeth
    :param X: larger sprocket RPM
    :param Y: smaller sprocket RPM
    :param H: Drive horsepower
    :param M: Chain material object.
    """
    I = M.P / math.sin( math.pi/B )
    S = M.P / math.sin( math.pi/A )
    SP = A * M.P * Y/60
    Q=6600*H/SP
    T_B=Q*I/2
    T_A=Q*S/2
    return Q, T_A, T_B
