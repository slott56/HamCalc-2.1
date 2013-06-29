"""Decimals to fractions
"""

import hamcalc.math.decifrac as decifrac
from hamcalc.stdio import *

def fraction_to_decimal():
    ft_in_raw= input( "ENTER: number of whole feet and inches [f'- i n/d\"]...? " )
    if len(ft_in_raw) == 0: return
    measure= decifrac.FOOT_INCH_FRAC.to_std( ft_in_raw )
    text= decifrac.FOOT_INCH_FRAC.from_std( measure )
    feet= decifrac.FOOT.from_std( measure )
    inches= decifrac.INCH.from_std( measure )
    metres= decifrac.METRE.from_std( measure )
    print( "{0:s}\n = {1:7.3f} feet\n = {2:7.3f} inches\n = {3:7.3f} metres".format( text, feet, inches, metres ) )

def decimal_to_fraction():
    print( "ENTER number in < > to select unit of measurement of number to be converted: " )
    print( "  < 1 >  Decimal INCHES")
    print( "  < 2 >  Decimal FEET")
    print( "  < 3 >  Decimal MILLIMETRES")
    print( "  < 4 >  Decimal CENTIMETRES")
    print( "  < 5 >  Decimal METRES")
    unit_raw= input( "Units? " )
    if len(unit_raw) == 0: return
    unit= { '1': decifrac.INCH, '2': decifrac.FOOT,
        '3': decifrac.MILLIMETRE, '4': decifrac.CENTIMETRE, '5': decifrac.METRE }[unit_raw]
    measure_raw= input_float( "ENTER: dimension (in {0}) to be converted........?".format(unit.__doc__) )
    if measure_raw is None: return
    measure= unit.to_std( measure_raw )
    text= decifrac.FOOT_INCH_FRAC.from_std( measure )
    print( "     {0:8.3f} {1} = {2:s}".format( measure_raw, unit.__doc__, text ) )
    f, i, n, d= decifrac.FOOT_INCH_FRAC_TUPLE.from_std( measure )
    if d==128:
        # Couldn't reduce. Check for nearby values.
        longer= decifrac.FOOT_INCH_FRAC_TUPLE.to_std( (f,i,n+1,d) )
        shorter= decifrac.FOOT_INCH_FRAC_TUPLE.to_std( (f,i,n-1,d) )
        print( "      near {0} and {1}".format( decifrac.FOOT_INCH_FRAC.from_std(shorter),
        decifrac.FOOT_INCH_FRAC.from_std(longer) ) )

print( decifrac.intro() )

z= None
while z != '0':
    print("  < 1 >  FRACTION to DECIMAL" )
    print("  < 2 >  DECIMAL to FRACTION" )
    print()
    print("  < 0 > EXIT")
    z= input( "Choice? " )
    if z == '1':
        fraction_to_decimal()
    elif z == '2':
        decimal_to_fraction()
