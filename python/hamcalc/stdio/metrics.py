"""Metric Conversions

"CONVERSION",", metric to Imperial",", Imperial to metric","METRICS"
"METRIC CONVERSIONS","","","METRICS"
"""
import hamcalc.math.metrics as metrics
from hamcalc.stdio import *

introduction= """\
METRIC CONVERTER                                            by George C. Murphy
"""

metric = {
'weight':     [metrics.Gram, metrics.Kilogram, metrics.Tonne,],
'volume':     [metrics.Litre, metrics.Millilitre, metrics.Cubic_CM, metrics.Cubic_M,],
'length':     [metrics.METRE, metrics.CENTIMETRE, metrics.MILLIMETRE, metrics.KILOMETRE,],
'area':       [metrics.Square_M, metrics.Square_CM, metrics.Hectare,],
'pressure':   [metrics.KPA, metrics.MPA, metrics.BAR, metrics.KG_SQ_M,],
'energy':     [metrics.Joule,],
'power':      [metrics.Kilowatt,],
'force':      [metrics.NEWTON,],
'torque':     [metrics.Newton_Metre,],
'temperature':[metrics.CELSIUS,],
}

imperial= {
'weight':     [metrics.Ounce, metrics.Pound, metrics.Long_Ton, metrics.Short_Ton,],
'volume':     [metrics.Fluid_Ounce_US, metrics.Pint_US, metrics.Quart_US, metrics.Gallon_US,
               metrics.Fluid_Ounce_UK, metrics.Pint_UK, metrics.Quart_UK, metrics.Gallon_UK,
               metrics.Cubic_Inch, metrics.Cubic_Foot, metrics.Cubic_Yard,],
'length':     [metrics.INCH, metrics.FOOT, metrics.YARD, metrics.MILE,],
'area':       [metrics.Square_Inch, metrics.Square_Foot, metrics.Square_Yard, metrics.Acre,],
'pressure':   [metrics.PSI, metrics.PSF, metrics.IN_Hg,],
'energy':     [metrics.BTU, metrics.Foot_Pound,],
'power':      [metrics.Horsepower,],
'force':      [metrics.POUND_FORCE,],
'torque':     [metrics.Pound_Foot, metrics.Pound_Inch,],
'temperature':[metrics.FAHRENHEIT,],
}

def unit_menu( unit_dict ):
    menu= []
    for dim in unit_dict:
        for unit in unit_dict[dim]:
            menu.append( (dim,unit) )
    for i, dim_unit in enumerate(menu):
        dim, unit= dim_unit
        print( " ( {0:2d} ) {1.__doc__:s} {2}".format(
                i, unit, dim ) )
    c = input_int( "CHOICE? " )
    if c is None: return
    if 0 <= c < len(menu):
        return menu[c]

print( introduction )
s= None
while s != '0':
    print( "  Press number in < > for desired source units" )
    print()
    print("  < 1 >  Imperial" )
    print("  < 2 >  Metric" )
    print()
    print("  < 0 >  EXIT" )
    s= input( "CHOICE? " )
    if s == '1':
        dim_unit= unit_menu( imperial )
    elif s == '2':
        dim_unit= unit_menu( metric )
    else:
        continue
    if dim_unit is None: continue
    dim, unit= dim_unit
    value= input_float( "How many {0:s}? ".format(unit.__doc__) )
    if value is None: continue
    print( "  {1.__doc__:.<20s} {0:10,.3f} {1.name}".format( value, unit ) )
    v = unit.to_std( value )
    for u in imperial[dim]:
        print( "= {1.__doc__:.<20s} {0:10,.3f} {1.name}".format( u.from_std(v), u ) )
    for u in metric[dim]:
        print( "= {1.__doc__:.<20s} {0:10,.3f} {1.name}".format( u.from_std(v), u ) )

