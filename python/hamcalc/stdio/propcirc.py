"""Circle, Properties of

"Properties of Circle","","","PROPCIRC"
"Circle","Properties Of","","PROPCIRC"
"""

import hamcalc.math.propcirc as propcirc
import math

def solve():
    args = dict()

    requests= [
        ("R", " ENTER: Radius of circle ", float),
        ("D", " ENTER: Diameter of circle ", float ),
        ("C", " ENTER: Cicumference of circle ", float),
        ("A", " ENTER: Area of circle ", float),
        ("angle", " ENTER: Angle between radials ", lambda a: math.radians(float(a)) ),
        ("L_C", " ENTER: Length of chord AB ", float),
        ("L_A", " ENTER: Length of arc AB ", float),
        ("G", " ENTER: Height if segment ", float),
    ]
    for variable, prompt, conversion in requests:
        if variable not in args:
            raw= input( prompt )
            if raw:
                args[variable]= conversion(raw)
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

