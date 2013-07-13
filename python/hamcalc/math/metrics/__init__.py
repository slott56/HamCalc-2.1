"""hamcalc.math.metics

Yet More Unit Conversions.

Weight:

    ounce, pound, short ton, long ton

    gram, kilogram, metric ton

    >>> from hamcalc.math.metrics import Ounce, Pound, Long_Ton, Short_Ton
    >>> from hamcalc.math.metrics import Gram, Kilogram, Tonne
    >>> wt= Pound.to_std( 113 )
    >>> for u in Ounce, Pound, Long_Ton, Short_Ton:
    ...    print( round(u.from_std(wt),3) )
    1808.0
    113.0
    0.05
    0.057
    >>> for u in Gram, Kilogram, Tonne:
    ...    print( round(u.from_std(wt),3) )
    51255.938
    51.256
    0.051

Volume:

    fluid ounce (imperial), fluid ounce (US),
    pint (imperial), pint (US),
    quart (imperial), quart (US),
    gallon (imperial), gallon (US),
    cu. in., cu. ft., cu. yd

    millilitre, litre, cu. cm, cu. metre

    >>> from hamcalc.math.metrics import Litre, Millilitre, Cubic_CM, Cubic_M
    >>> from hamcalc.math.metrics import Fluid_Ounce_US, Pint_US, Quart_US, Gallon_US, Cubic_Inch, Cubic_Foot, Cubic_Yard
    >>> vol= Millilitre.to_std( 750 )
    >>> for u in Litre, Millilitre, Cubic_CM, Cubic_M:
    ...    print( round(u.from_std(vol),3) )
    0.75
    750.0
    750.0
    0.001
    >>> for u in Fluid_Ounce_US, Pint_US, Quart_US, Gallon_US, Cubic_Inch, Cubic_Foot, Cubic_Yard:
    ...    print( round(u.from_std(vol),3) )
    25.361
    1.585
    0.793
    0.198
    45.768
    0.026
    0.001

Length or Distance:

    inch, foot, yard, mile

    mm, cm, metre, kilometre

    >>> from hamcalc.math.metrics import METRE, CENTIMETRE, MILLIMETRE, KILOMETRE
    >>> from hamcalc.math.metrics import INCH, FOOT, YARD, MILE
    >>> d = METRE.to_std( 1.7526 )
    >>> for u in METRE, CENTIMETRE, MILLIMETRE, KILOMETRE:
    ...     print( round(u.from_std(d),3) )
    1.753
    175.26
    1752.6
    0.002
    >>> for u in INCH, FOOT, YARD, MILE:
    ...     print( round(u.from_std(d),3) )
    69.0
    5.75
    1.917
    0.001

Area:

    sq.in., sq.ft., sq.yd., acre

    sq.cm., sq.metre, hectare

    >>> from hamcalc.math.metrics import Square_M, Square_CM, Hectare
    >>> from hamcalc.math.metrics import Square_Inch, Square_Foot, Square_Yard, Acre
    >>> a = Square_Foot.to_std( 1800 )
    >>> for u in Square_M, Square_CM, Hectare:
    ...     print( round(u.from_std(a),3) )
    167.225
    1672254.785
    0.017
    >>> a = Square_Foot.to_std( 1800 )
    >>> for u in Square_Inch, Square_Foot, Square_Yard, Acre:
    ...     print( round(u.from_std(a),3) )
    259200.01
    1800.0
    200.0
    0.041

Pressure:

    PSI, lb/sq.in., lb/sq.ft., in.Hg

    kPa, mPa, bar, Kg/sq.metre

    >>> from hamcalc.math.metrics import PSI, PSF, IN_Hg, KPA, MPA, BAR, KG_SQ_M
    >>> p = BAR.to_std( 1.032 )
    >>> for u in PSI, PSF, IN_Hg, KPA, MPA, BAR, KG_SQ_M:
    ...     print( round(u.from_std(p),3) )
    14.679
    2113.742
    29.886
    101.207
    0.101
    1.032
    10320.274

Energy:

    ft/lb

    BTU

    >>> from hamcalc.math.metrics import Foot_Pound, BTU
    >>> e= BTU.to_std( 25 )
    >>> round( Foot_Pound.from_std(e), 3 )
    19454.172

Power:

    Horsepower

    Kilowatt

    >>> from hamcalc.math.metrics import Kilowatt, Horsepower
    >>> p= Kilowatt.to_std( 0.8 )
    >>> round( Horsepower.from_std(p), 3 )
    1.073


Force:

    lb.(force)

    newton

    >>> from hamcalc.math.metrics import NEWTON, POUND_FORCE
    >>> f= POUND_FORCE.to_std( 180 )
    >>> round( NEWTON.from_std(f), 3 )
    800.68

Torque or Moment:

    lb/in, lb/ft

    newton-metres

    >>> from hamcalc.math.metrics import Newton_Metre, Pound_Foot, Pound_Inch
    >>> t = Pound_Foot.to_std( 75 )
    >>> for u in Newton_Metre, Pound_Foot, Pound_Inch:
    ...     print( round(u.from_std(t),3) )
    101.686
    75.0
    900.0

Temperature:

    fahrenheit

    celsius

    >>> from hamcalc.math.metrics import CELSIUS, FAHRENHEIT
    >>> t= FAHRENHEIT.to_std( 72 )
    >>> round( CELSIUS.from_std(t), 3 )
    22.222

"""
from hamcalc.lib import Unit, Standard_Unit
from hamcalc.math.baromtr import PSI, PSF, IN_Hg, KPA, MPA, BAR, KG_SQ_M
from hamcalc.math.equiv import METRE, CENTIMETRE, MILLIMETRE, KILOMETRE
from hamcalc.math.equiv import INCH, FOOT, YARD, MILE
from hamcalc.math.centrif import NEWTON, POUND_FORCE
from hamcalc.math.equiv import INCH, FOOT, YARD, MILE
from hamcalc.math.equiv import CELSIUS, FAHRENHEIT

class Kilogram( Standard_Unit ):
    """Kilogram"""
    name= "kg"

class Gram( Unit ):
    """Gram"""
    standard= Kilogram
    name= "g"
    factor= 1000

class Tonne( Unit ):
    """Metric Tonne"""
    standard= Kilogram
    name= "t"
    factor= .001

class Ounce( Unit ):
    """Ounce"""
    standard= Kilogram
    name= "oz."
    factor= 35.273962

class Pound( Unit ):
    """Pound"""
    standard= Kilogram
    name= "lb."
    factor= 2.2046226

class Short_Ton( Unit ):
    """Short Ton"""
    standard= Kilogram
    name= "t (US)"
    factor= 0.0011023113

class Long_Ton( Unit ):
    """Long Ton"""
    standard= Kilogram
    name= "t (UK)"
    factor= 0.00098420652


class Litre( Standard_Unit ):
    """Litre"""
    name= "l"

class Millilitre( Unit ):
    """Millilitre"""
    name= "ml"
    factor= 1000

class Cubic_CM( Unit ):
    """Cubic Centimetre"""
    name= "cc"
    factor= 1000

class Cubic_M( Unit ):
    """Cubic Metre"""
    name= "cu.m"
    factor= 0.001

class Fluid_Ounce_UK( Unit ):
    """fluid ounce (imperial)"""
    name= "fl.oz.(UK)"
    factor= 35.1951

class Pint_UK( Unit ):
    """pint (imperial)"""
    name= "pt.(UK)"
    factor= 1.75975

class Quart_UK( Unit ):
    """quart (imperial)"""
    name= "qt.(UK)"
    factor= 0.879877

class Gallon_UK( Unit ):
    """gallon (imperial)"""
    name="gal.(UK)"
    factor= 0.219969

class Fluid_Ounce_US( Unit ):
    """fluid ounce (US)"""
    name= "fl.oz.(US)"
    factor= 33.814

class Pint_US( Unit ):
    """pint (US)"""
    name= "pt.(US)"
    factor= 2.11338

class Quart_US( Unit ):
    """quart (US)"""
    name= "qt.(US)"
    factor= 1.05669

class Gallon_US( Unit ):
    """gallon (US)"""
    name="gal.(US)"
    factor= 0.264172

class Cubic_Inch( Unit ):
    """Cubic Inch"""
    name= "cu.in."
    factor= 61.0237

class Cubic_Foot( Unit ):
    """Cubic Foot"""
    name= "cu.ft."
    factor= 0.0353147

class Cubic_Yard( Unit ):
    """Cubic Yard"""
    name= "cu.yd."
    factor= 0.0013080

class Square_M( Standard_Unit ):
    """Square Metre"""
    name= "m²"

class Hectare( Unit ):
    """Hectare"""
    standard= Square_M
    name= 'ha'
    factor= 0.0001

class Square_CM( Unit ):
    """Square Centimetre"""
    standard= Square_M
    name= "cm²"
    factor= 10000

class Square_Inch( Unit ):
    """Square Inch"""
    standard= Square_M
    name= "sq.in."
    factor= 1550.0031

class Square_Foot( Unit ):
    """Square Foot"""
    standard= Square_M
    name= "sq.ft."
    factor= 10.76391

class Square_Yard( Unit ):
    """Square Yard"""
    standard= Square_M
    name= "sq.yd."
    factor= 1.1959905

class Acre( Unit ):
    """Acre"""
    standard= Square_M
    name= "acre"
    factor= 0.00024710537

class Joule( Standard_Unit ):
    """Joule"""
    name= "J"

class Foot_Pound( Unit ):
    """Foot-Pound"""
    standard= Joule
    name= "ft.lb."
    factor= 0.73756215

class BTU( Unit ):
    """BTU"""
    standard= Joule
    name= "BTU"
    factor= 9.4782E-4

class Watt( Standard_Unit ):
    """Watt"""
    name= "W"

class Kilowatt( Unit ):
    """Kilowatt"""
    standard= Watt
    name= "kW"
    factor = 0.001

class Horsepower( Unit ):
    """Horsepower"""
    standard= Watt
    name= "HP"
    factor= 0.0013410221


class Newton_Metre( Standard_Unit ):
    """Newton Metre"""
    name= "N·m"

class Pound_Foot( Unit ):
    """Pound Foot"""
    standard= Newton_Metre
    name= "ft-lbf"
    factor = 0.7375621

class Pound_Inch( Unit ):
    """Pound Inch"""
    standard= Newton_Metre
    name= "in-lbf"
    factor= 8.850745792
