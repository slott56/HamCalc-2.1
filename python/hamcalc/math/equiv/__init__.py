"""hamcalc.math.equiv -- Unit Conversions

Simple Units

-   Capacitance
-   Current
-   Degrees / Radians (imported from :mod:`hamcalc.math.trig`)
-   Inductance
-   Length / Distance
-   Resistance
-   Temperature
-   Time
-   MPG/KPL

Plus, the Frequencies/Wavelengths is both units conversion and a :math:`c=\lambda\nu`  **Solver**.

In addition to the unit definitions, there's a variable,
:data:`unit_map`.
This collects units into dimensions.

-       'capacitance': (FARAD, MICROFARAD, NANOFARAD, PICOFARAD),

-       'current': (AMPERE, MILLIAMPERE, MICROAMPERE),

-       'degrees': (DEGREE, RADIAN),

-       'radians': (DEGREE, RADIAN),

-       'inductance': (HENRY, MICROHENRY, MILLIHENRY, NANOHENRY, PICOHENRY),

-       'length':  (METRE, CENTIMETRE, MILLIMETRE, KILOMETRE, INCH, FOOT, MILE),

-       'distance': (METRE, CENTIMETRE, MILLIMETRE, KILOMETRE, INCH, FOOT, MILE),

-       'resistance': (OHM, KILOHM, MEGOHM),

-       'temperature': (CELSIUS, FAHRENHEIT),

-       'time': (SECOND, MINUTE, HOUR, DAY, WEEK, YEAR),

-       'mpg': (MPGI, MPG, KPL, LPK),

-       'kpl': (MPGI, MPG, KPL, LPK),

-       'frequency': (HERTZ, KILOHERTZ, MEGAHERTZ, GIGAHERTZ),


Test Cases, Unit-by-Unit

>>> import hamcalc.math.equiv as equiv

Capacitance

>>> x= equiv.FARAD.to_std( .0000001 )
>>> equiv.MICROFARAD.from_std( x )
0.09999999999999999
>>> equiv.NANOFARAD.from_std( x )
100.0
>>> equiv.PICOFARAD.from_std( x )
100000.0

Current

>>> x= equiv.MILLIAMPERE.to_std( 150 )
>>> equiv.AMPERE.from_std( x )
0.15
>>> equiv.MICROAMPERE.from_std( x )
150000.0

Degree/Radians

>>> x= equiv.DEGREE.to_std( 30 )
>>> equiv.RADIAN.from_std( x )
0.5235987755982988

Frequency

>>> x= equiv.MEGAHERTZ.to_std( 157.100 )
>>> equiv.HERTZ.from_std( x )
157100000.0
>>> equiv.KILOHERTZ.from_std( x )
157100.0
>>> equiv.GIGAHERTZ.from_std( x )
0.15710000000000002
>>> equiv.freq_wavelength( f=157100000.0 )
{'l': 1.908290630171865, 'f': 157100000.0}
>>> equiv.freq_wavelength( l=10 )
{'l': 10, 'f': 29979245.799999997}

Inductance

>>> x=equiv.MILLIHENRY.to_std( 2 )
>>> equiv.HENRY.from_std( x )
0.002
>>> equiv.MICROHENRY.from_std( x )
2000.0
>>> equiv.NANOHENRY.from_std( x )
2000000.0
>>> equiv.PICOHENRY.from_std( x )
2000000000.0

Length/Distance

>>> x= equiv.FOOT.to_std( 6076.1155 )
>>> equiv.KILOMETRE.from_std( x )
1.8519999921768002
>>> equiv.MILE.from_std( x )
1.1507794507575757
>>> y= equiv.FOOT.to_std( 13.302 )
>>> equiv.METRE.from_std( y )
4.054449573240633
>>> equiv.CENTIMETRE.from_std( y )
405.4449573240633
>>> equiv.MILLIMETRE.from_std( y )
4054.4495732406326

Resistance

>>> x= equiv.KILOHM.to_std( 4.70 )
>>> equiv.OHM.from_std( x )
4700.0
>>> equiv.MEGOHM.from_std( x )
0.0047

Temperature

>>> x= equiv.FAHRENHEIT.to_std( 72 )
>>> equiv.CELSIUS.from_std( x )
22.22222222222222

Time

>>> x= equiv.WEEK.to_std( 3 )
>>> equiv.DAY.from_std( x )
21.0
>>> equiv.YEAR.from_std( x )
0.05749486652977412
>>> y= equiv.MINUTE.to_std( 45 )
>>> equiv.HOUR.from_std( y )
0.75
>>> equiv.SECOND.from_std( y )
2700.0

MPG

>>> x= equiv.MPGI.to_std( 12.5 )
>>> equiv.MPG.from_std( x )
10.416666666666668
>>> equiv.KPL.from_std( x )
4.425
>>> equiv.LPK.from_std( x )
35.31073446327684

VOLUME

>>> x = equiv.LITER.to_std( 4 )
>>> round(equiv.GALLON.from_std( x ),6)
1.056688

It's possible that the legacy computes this incorrectly.
The result from the legacy may be 22.6 LPK.

Area

>>> a = equiv.SQ_FOOT.to_std( 9 )
>>> equiv.SQ_METRE.from_std( a )
0.83612736
>>> equiv.SQ_FOOT.from_std( a )
9.0

"""

from hamcalc.lib import Unit, Standard_Unit, AttrDict, NoSolutionError
from hamcalc.math.trig import DEGREE, RADIAN
import math

def intro():
    return """\
EQUIVALENT VALUES                                       by George Murphy VE3ERP"""

class FARAD( Standard_Unit ):
    """Farad"""
    name= "F"

class MICROFARAD( Unit ):
    """microfarad"""
    standard= FARAD
    name= "µF"
    factor= 1.0E6

class NANOFARAD( Unit ):
    """nanofarad"""
    standard= FARAD
    name= "nF"
    factor= 1.0E9

class PICOFARAD( Unit ):
    """picofarad"""
    standard= FARAD
    name= "pF"
    factor= 1.0E12

class AMPERE( Standard_Unit ):
    """Ampere"""
    name= "A"

class MILLIAMPERE( Unit ):
    """millimpere"""
    standard= AMPERE
    name= "mA"
    factor= 1.0E3

class MICROAMPERE( Unit ):
    """micrampere"""
    standard= AMPERE
    name= "µA"
    factor= 1.0E6

class HERTZ( Standard_Unit ):
    """Hertz"""
    name= "Hz"

class KILOHERTZ( Unit ):
    """kilohertz"""
    standard= HERTZ
    name= "kHz"
    factor= 1.0E-3

class MEGAHERTZ( Unit ):
    """megahertz"""
    standard= HERTZ
    name= "mHz"
    factor= 1.0E-6

class GIGAHERTZ( Unit ):
    """gigahertz"""
    standard= HERTZ
    name= "gHz"
    factor= 1.0E-9

class HENRY( Standard_Unit ):
    """Henry"""
    name= "H"

class MILLIHENRY( Unit ):
    """millihenry"""
    standard= HENRY
    name= "mH"
    factor= 1.0E3

class MICROHENRY( Unit ):
    """microhenry"""
    standard= HENRY
    name= "µH"
    factor= 1.0E6

class NANOHENRY( Unit ):
    """nanohenry"""
    standard= HENRY
    name= "nH"
    factor= 1.0E9

class PICOHENRY( Unit ):
    """picohenry"""
    standard= HENRY
    name= "pH"
    factor= 1.0E12

class METRE( Standard_Unit ):
    """Metre"""
    name= "M"

class CENTIMETRE( Unit ):
    """centimetre"""
    standard= METRE
    name= "cm"
    factor= 1.0E2

class MILLIMETRE( Unit ):
    """millimetre"""
    standard= METRE
    name= "mm"
    factor= 1.0E3

class KILOMETRE( Unit ):
    """kilometre"""
    standard= METRE
    name= "km"
    factor= 1.0E-3

class INCH( Unit ):
    """Inch"""
    standard= METRE
    name= "in"
    factor= 39.370079

class FOOT( Unit ):
    """Foot"""
    standard= METRE
    name= "ft"
    factor= 39.370079/12

class YARD( Unit ):
    """Yard"""
    standard= METRE
    name= "yd"
    factor= 39.370079/36

class MILE( Unit ):
    """Statute Mile"""
    standard= METRE
    name= "mi"
    factor= 39.370079/12/5280 # 1/1609.344

class NAUTICAL_MILE( Unit ):
    """Nautical Mile"""
    standard= METRE
    name= "nm"
    factor= 1/1852.0

class OHM( Standard_Unit ):
    """Ohm"""
    name= "Ω"

class KILOHM( Unit ):
    """kilohm"""
    standard= OHM
    name= "kΩ"
    factor= 1.0E-3

class MEGOHM( Unit ):
    """megohm"""
    standard= OHM
    name= "mΩ"
    factor= 1.0E-6

class CELSIUS( Standard_Unit ):
    """Degrees C"""
    name="°C"

class FAHRENHEIT( Unit ):
    """Degrees F"""
    name="°F"
    standard= CELSIUS
    @classmethod
    def to_std( class_, value ):
        return (value-32)*5/9
    @classmethod
    def from_std( class_, value ):
        return value*9/5+32

class SECOND( Standard_Unit ):
    """Second"""
    name= "Sec"

class MINUTE( Unit ):
    """Minute"""
    name= "Min"
    standard= SECOND
    factor= 1/60

class HOUR( Unit ):
    """Hour"""
    name= "Hr"
    standard= SECOND
    factor= 1/3600

class DAY( Unit ):
    """Day"""
    name= "Day"
    standard= SECOND
    factor= 1/86400

class WEEK( Unit ):
    """Week"""
    name= "Wk"
    standard= SECOND
    factor= 1/604800

class YEAR( Unit ):
    """Year (365.25 days)"""
    name= "Yr"
    standard= SECOND
    factor= 1/31557600


class MPGI( Standard_Unit ):
    """Miles per Imperial Gallon"""
    name= "MPGI"

class MPG( Unit ):
    """Miles per US Gallon"""
    name= "MPG"
    standard= MPGI
    factor= 1/1.2

class KPL( Unit ):
    """Kilometres per Litre"""
    name= "KPL"
    standard= MPGI
    factor= 0.354

class LPK( Unit ):
    """Litres per 100 Kilometre"""
    # [Imperial Gallons]/[Mile] * [liters]/[Imperial Gallon] * [Miles]/[100 Kilometre]
    # 1/value * 4.54609 * 62.137119
    name= "LPK"
    standard= MPGI
    factor= 1/0.354

class LITER( Standard_Unit ):
    """liter"""
    name= "l"

class GALLON( Unit ):
    """Gallon"""
    name= "gal"
    standard= LITER
    factor= 1/3.7854118

def freq_wavelength( **kw ):
    """A kind of **Solver** for frequency-wavelength problems in Standard units
    of meters and Hertz.

    :param f: Frequency in Hz
    :param l: Wavelength in m
    :returns: dict with both values
    """
    c= 299792.458
    args= AttrDict( kw )
    if 'f' in args:
        args.l= 1000*c/args.f
    elif 'l' in args:
        args.f = c/(args.l/1000)
    else:
        raise NoSolutionError( "Insufficient Data: {0!r}".format(args) )
    return args


class SQ_METRE( Standard_Unit ):
    """Square Metre"""
    name= "sq.metre"

class SQ_FOOT( Unit ):
    """Square Foot"""
    name= "sq.ft"
    factor= 1/0.09290304

unit_map = {
    'capacitance': (FARAD, MICROFARAD, NANOFARAD, PICOFARAD),
    'current': (AMPERE, MILLIAMPERE, MICROAMPERE),
    'degrees': (DEGREE, RADIAN),
    'radians': (DEGREE, RADIAN),
    'inductance': (HENRY, MICROHENRY, MILLIHENRY, NANOHENRY, PICOHENRY),
    'length':  (METRE, CENTIMETRE, MILLIMETRE, KILOMETRE, INCH, FOOT, MILE),
    'distance': (METRE, CENTIMETRE, MILLIMETRE, KILOMETRE, INCH, FOOT, MILE),
    'resistance': (OHM, KILOHM, MEGOHM),
    'temperature': (CELSIUS, FAHRENHEIT),
    'time': (SECOND, MINUTE, HOUR, DAY, WEEK, YEAR),
    'mpg': (MPGI, MPG, KPL, LPK),
    'kpl': (MPGI, MPG, KPL, LPK),
    'frequency': (HERTZ, KILOHERTZ, MEGAHERTZ, GIGAHERTZ), # Plus freq_wavelength Solver
}

