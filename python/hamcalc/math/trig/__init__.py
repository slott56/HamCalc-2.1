"""hamcalc.math.trig -- Trig Definitions

The trig functions are in :mod:`math`. These are unit conversions.

Test Cases

>>> import hamcalc.math.trig as trig
>>> lat= trig.DEG_MIN_SEC.to_std( "36° 50' 45\\"" )
>>> trig.DEGREE.from_std( lat )
36.84583333333334
>>> trig.RADIAN.from_std( lat )
0.643081107307744
>>> lon= trig.DEG_MIN_SEC.to_std( "76° 18' 28\\"" )
>>> trig.DEGREE.from_std( lon )
76.30777777777777
>>> trig.RADIAN.from_std( lon )
1.331821967102384

"""
from hamcalc.lib import Unit, Standard_Unit
import math
import re

def intro():
    return """TRIGONOMETRIC FUNCTIONS                                 by George Murphy VE3ERP"""

class RADIAN( Standard_Unit ):
    """Radians"""
    name= "rad"

class DEGREE( Unit ):
    """Degrees"""
    name= "deg"
    standard= RADIAN
    factor= 180/math.pi

class DMS_TUPLE( Unit ):
    """Degrees Minutes Seconds -- as Tuple"""
    name= "DMS"
    standard= RADIAN
    @classmethod
    def to_std( class_, value ):
        if len(value) == 1:
            d, m, s = value[0], 0, 0
        elif len(value) == 2:
            d, m, s = value[0], value[1], 0
        else:
            d, m, s = value
        deg= d+(m+s/60)/60
        return math.pi*(deg)/180
    @classmethod
    def from_std( class_, value ):
        degree= 180*(value/math.pi)
        dms= degree*3600
        sec= dms % 60
        dm= dms // 60
        min= dm % 60
        deg= dm // 60
        return deg, min, sec

class DEG_MIN_SEC( DMS_TUPLE ):
    """Degrees Minutes Seconds -- as String"""
    name= "DMS"
    standard= RADIAN
    number_pat= re.compile( "\d+\.?\d*" )
    @classmethod
    def to_std( class_, value ):
        class_.number_pat.findall( value )
        elements = list( map( float, class_.number_pat.findall( value ) ) )
        return super().to_std( elements )
    @classmethod
    def from_std( class_, value ):
        deg, min, sec = super().from_std( value )
        return "{0:02.0f}°{1:02.0f}'{2:03.1f}\"".format( deg, min, sec )
