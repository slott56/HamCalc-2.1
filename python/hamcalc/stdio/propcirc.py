"""Circle, Properties of

"Properties of Circle","","","PROPCIRC"
"Circle","Properties Of","","PROPCIRC"
"""

import hamcalc.math.propcirc as propcirc
import math
from hamcalc.stdio import *

def radians( x ):
    return math.radians(x) if x is not None else None

def solve():
    args = dict()

    requests= [
        ("R", "ENTER: Radius of circle ", input_float),
        ("D", "ENTER: Diameter of circle ", input_float ),
        ("C", "ENTER: Cicumference of circle ", input_float),
        ("A", "ENTER: Area of circle ", input_float),
        ("angle", "ENTER: Angle between radials ", lambda a: radians(input_float(a)) ),
        ("L_C", "ENTER: Length of chord AB ", input_float),
        ("L_A", "ENTER: Length of arc AB ", input_float),
        ("G", "ENTER: Height if segment ", input_float),
    ]
    for variable, prompt, input_func in requests:
        if variable not in args:
            raw= input_func( prompt )
            if raw is not None:
                args[variable]= raw
                args= propcirc.circle( **args )
    print()
    reports = [
        ("Radius / Length of radials", "R", " units", float),
        ("Diameter", "D", " units", float),
        ("Circumference", "C", " units", float),
        ("Area of full circle", "A", " units²", float),
        ("Angle between radials", "angle", "°", math.degrees ),
        ("Length of chord AB", "L_C", " units", float),
        ("Length of arc AB", "L_A", " units", float),
        ("Height of segment", "G", " units", float),
        ("Area of segment", "A_G", " units²", float),
        ("Area of sector", "A_C", " units²", float),
        ]
    for label, variable, units, conversion in reports:
        print( "{0:.<30s} {1:9.3f}{2:s}".format( label, conversion(args[variable]), units ) )

print( propcirc.intro() )

z= None
while z != '0':
    print()
    print( " Press 1 to continue or 0 to EXIT" )
    z= input( "Choice? " )
    if z == '1':
        solve()

