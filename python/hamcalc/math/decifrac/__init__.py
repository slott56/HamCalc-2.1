"""hamcalc.math.decifrac -- Decimals to fractions

Some Test Cases

>>> import  hamcalc.math.decifrac as decifrac
>>> x=decifrac.FOOT_INCH_FRAC_TUPLE.to_std( (13, 3, 5, 8) )
>>> decifrac.INCH.from_std( x )
159.625
>>> decifrac.FOOT.from_std( x )
13.302083333333332
>>> decifrac.METRE.from_std( x )
4.054475
>>> decifrac.FOOT_INCH_FRAC_TUPLE.from_std( x )
(13, 3, 5, 8)
>>> decifrac.FOOT_INCH_FRAC.from_std(x)
'13\\'- 3 5/8"'

>>> decifrac.FOOT_INCH_FRAC.from_std( decifrac.INCH.to_std( 73 ) )
'6\\'- 1"'
"""
__version__ = "2.1"

from hamcalc.lib import Unit, Standard_Unit
import re

introduction = """\
DECIMAL / FRACTION CONVERTER                                by George C. Murphy
"""

def intro():
    return introduction

class INCH( Standard_Unit ):
    """Decimal Inches"""
    name= "in"

class FOOT( Unit ):
    """Decimal Feet"""
    name= "ft"
    standard= INCH
    factor= 1/12

class FOOT_INCH_FRAC_TUPLE( Unit ):
    """Feet-Inch-Fraction -- as tuple"""
    name='ft-in'
    standard= INCH
    @classmethod
    def _gcd( class_, a, b ):
        if a == 0: return b
        elif b == 0: return a
        elif a < b:
            return class_._gcd( b-a, a )
        else:
            return class_._gcd( a-b, b )
    @classmethod
    def to_std( class_, value ):
        if len(value) == 2:
            f, i = value
            n, d = 0, 1
        else:
            f, i, n, d = value
        return f*12+i+n/d
    @classmethod
    def from_std( class_, value ):
        # A round up that may lead to more accurate fractions.
        n = int(value*128+0.5) % 128
        i = int(value) % 12
        f = int(value//12)
        # Reduce the n/128, if possible.
        r = class_._gcd( n, 128 )
        n= n // r
        d= 128 // r
        return f, i, n, d

class FOOT_INCH_FRAC( FOOT_INCH_FRAC_TUPLE ):
    """Feet-Inch-Fraction -- as String"""
    name= "ft-in"
    standard= INCH
    number_pat= re.compile( "\d+" )
    @classmethod
    def to_std( class_, value ):
        values= list( map( float, class_.number_pat.findall( value ) ) )
        if len(values) == 1:
            # Only entered feet, append zero inches.
            values.append( 0 )
        return super().to_std( values )
    @classmethod
    def from_std( class_, value ):
        ft, in_, num, den = super().from_std( value )
        if num == 0:
            ft_in_fmt= "{0:.0f}'- {1:.0f}\""
        else:
            ft_in_fmt= "{0:.0f}'- {1:.0f} {2:.0f}/{3:.0f}\""
        return ft_in_fmt.format( ft, in_, num, den )

class MILLIMETRE( Unit ):
    """Decimal Millimetres"""
    name= "in"
    standard= INCH
    factor= 25.4

class CENTIMETRE( Unit ):
    """Decimal Centimetres"""
    name= "in"
    standard= INCH
    factor= 2.54

class METRE( Unit ):
    """Decimal Metres"""
    name= "in"
    standard= INCH
    factor= .0254
