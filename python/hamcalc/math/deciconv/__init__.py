"""hamcalc.math.deciconv -- Decimal numbers to degrees/minutes/seconds.

There are two ways to handle "sexigesimal" Hour:Minute:Second and
Degree:Minute:Second values.

1.  As tuples. ``(HH,MM,SS)`` or ``(DEG,MM,SS)``.

2.  As strings. ``"HH:MM:SS"`` or ``"DEG:MM:SS"``.

We provide both implementations, since strings are an extension to tuples.

Test Cases

>>> import hamcalc.math.deciconv as deciconv
>>> deciconv.HR_MIN_SEC.to_std( "12:34:56" )
12.582222222222223
>>> deciconv.HR_MIN_SEC.from_std( 12.582 )
'12:34:55.2'
>>> deciconv.HR_MIN_SEC.from_std( 12.5822 )
'12:34:55.9'
>>> deciconv.HR_MIN_SEC.from_std( 12.58222 )
'12:34:56.0'
>>> deciconv.HMS_TUPLE.to_std( (12,34,56) )
12.582222222222223
>>> deciconv.HMS_TUPLE.from_std( 12.58222 )
(12.0, 34.0, 55.99199999999837)

"""

from hamcalc.lib import Unit, Standard_Unit
import re

introduction= """\
 DECIMAL HOUR/DEGREE CONVERTER                           by George Murphy VE3ERP

 This program converts decimal hours or decimal degrees to sexigesimal formats:

   HH:MM:SS  (hours/min./sec.) for time
   DD°MM'SS" (degrees/min./sec.) for degrees
 and vice versa.
"""

def intro():
    return introduction

class HOUR( Standard_Unit ):
    """Decimal Hours"""
    name= "hrs"

class HMS_TUPLE( Unit ):
    """Hours Minutes Seconds -- as Tuple"""
    name= "HMS"
    standard= HOUR
    @classmethod
    def to_std( class_, value ):
        h, m, s = value
        return h+(m+s/60)/60
    @classmethod
    def from_std( class_, value ):
        hms= value*3600
        sec= hms % 60
        hm= hms // 60
        min= hm % 60
        hrs= hm // 60
        return hrs, min, sec

class HR_MIN_SEC( HMS_TUPLE ):
    """Hours Minutes Seconds -- as String"""
    name= "HMS"
    standard= HOUR
    @classmethod
    def to_std( class_, value ):
        h, m, s = map( float, value.split( ":" ) )
        return super().to_std( (h,m,s) )
    @classmethod
    def from_std( class_, value ):
        hrs, min, sec = super().from_std( value )
        return "{0:02.0f}:{1:02.0f}:{2:03.1f}".format( hrs, min, sec )

class DEGREE( Standard_Unit ):
    """Decimal Degrees"""
    name= "deg"

class DMS_TUPLE( HMS_TUPLE ):
    """Degrees Minutes Seconds -- as Tuple"""
    name= "DMS"
    standard= DEGREE

class DEG_MIN_SEC( DMS_TUPLE ):
    """Degrees Minutes Seconds -- as String"""
    name= "DMS"
    standard= DEGREE
    number_pat= re.compile( "\d+\.?\d*" )
    @classmethod
    def to_std( class_, value ):
        class_.number_pat.findall( value )
        d, m, s = map( float, class_.number_pat.findall( value ) )
        return super().to_std( (d,m,s) )
    @classmethod
    def from_std( class_, value ):
        deg, min, sec = super().from_std( value )
        return "{0:02.0f}° {1:02.0f}' {2:03.1f}\"".format( deg, min, sec )
