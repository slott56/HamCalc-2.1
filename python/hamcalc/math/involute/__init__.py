"""hamcalc.math.involute

Compute various parts of the involute of a circle.

Test Cases

>>> import hamcalc.math.involute as involute
>>> import math
>>> involute.involute( radius=91 )
{'diameter': 182, 'radius': 91, 'baseline': 285.88493147667117, 'involute': 449.0670002495658}
>>> i= involute.involute( radius=91, phi=math.radians(144) )
>>> i
{'diameter': 182, 'phi': 2.5132741228718345, 'CO': 316.5057744165644, 'baseline': 285.88493147667117, 'COE': 1.2791655754811324, 'OCE': 0.2916307513137641, 'CE': 303.1417246751578, 'radius': 91, 'C_Y': -208.05170374782548, 'C_X': 238.51707235889052, 'involute': 449.0670002495658}
>>> math.degrees( i.OCE )
16.70921122650797
>>> math.degrees( i.COE )
73.29078877349203

"""
from hamcalc.lib import AttrDict
import math

def involute( radius, phi=None ):
    """Compute involute dimensions given radius
    and optional angle phi.

    :param radius: Radius of circle
    :param phi: optional angle in radians.
    :returns: dictionary with numerous values for the
        involute.

        -   radius, given
        -   diameter, :math:`2 \\times r`
        -   baseline, :math:`\\pi \\times r`
        -   involute circumference

        If Phi is provided

        -   phi, given
        -   C_X, C_Y, location of point C on the involate at angle phi
        -   CO length of the line from origin to C
        -   CE length of the line from circumference to C
        -   OCE the angle at C (on involute) between O and E (on circumference)
        -   COE the angle at O between C (on involute) and E (on circumference)
    """
    args = AttrDict()
    args.radius= radius
    args.diameter = 2*args.radius
    args.baseline = math.pi*args.radius
    args.involute = args.radius*math.pi**2/2

    if phi is not None:
        args.phi= phi
        args.C_X= args.radius*(math.sin(phi)-phi*math.cos(phi))
        args.C_Y= args.radius*(math.cos(phi)-phi*math.sin(phi))
        args.CO= math.sqrt( args.C_X**2 + args.C_Y**2 )
        args.CE= math.sqrt( args.CO**2 - args.radius**2 )
        args.OCE = math.atan2( args.radius, args.CE )
        args.COE = math.pi/2-args.OCE

    return args
