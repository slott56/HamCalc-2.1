"""hamcalc.math.rotaplot -- Cartesian/Polar Plot Rotator

Conversions between Polar and Cartesian.

Plus rotation of polar coordinates with proper :math:`(\theta + angle) \mod 2\pi`.

Test Cases

>>> import hamcalc.math.rotaplot as rotaplot
>>> import math
>>> rotaplot.cartesian_to_polar( 5, 7 )
(8.602325267042627, 0.9505468408120752)
>>> r, theta = _
>>> math.degrees(theta)
54.46232220802562
>>> rotaplot.polar_to_cartesian( 8.602, math.radians(54.46) )
(5.000094638769196, 6.999532670353896)
>>> rotaplot.rotate( 8.602, math.radians(54.46), -math.radians(54.46) )
(8.602, 0.0)
>>> rotaplot.polar_to_cartesian( *_ )
(8.602, 0.0)
>>> rotaplot.rotate( 8.602, math.radians(54.46), math.radians(35.54) )
(8.602, 1.5707963267948966)
>>> r, theta = _
>>> math.degrees(theta)
90.0

"""
__version__ = "2.1"

import math
import cmath

introduction="""\
CARTESIAN/POLAR PLOT ROTATOR                            by George Murphy VE3ERP

              Y «0°
          -x  │  +x
          +y  │  +y
 270°» X───── * ─────X «90°
          -x  │  +x
          -y  │  -y
              Y «180°

 This program rotates a plotted point or pattern of plotted points about the
 junction * of the x and y axis of the plot. The new locations are indicated in
 both cartesian and polar coordinates.

 Coordinates may be entered in any unit of measure. All entries must be in the
 same units.
"""

def intro():
    return introduction

def polar_to_cartesian( r, theta ):
    """Convert polar (r, theta) to Cartesian (x, y)

    :param r: radius length
    :param theta: angle in radians
    :returns: x,y coordinates
    """
    return r*math.cos(theta), r*math.sin(theta)

def cartesian_to_polar( x, y ):
    """Convert Cartesian (x, y) to polar (r, theta)

    :param x: x
    :param y: y
    :returns: r,theta coordinates in radians
    """
    return math.sqrt(x*x+y*y), math.atan2(y,x),

def rotate( r, theta, angle ):
    """Rotate polar coordinates, (r, theta) through angle
    degrees. This does :math:`(\theta + angle) \mod 2\pi`.

    :param r: radius length
    :param theta: angle in radians
    :param angle: offset angle in radians
    :returns: r,theta coordinates after rotation.
    """
    return r, (theta+angle) % (2*math.pi)
