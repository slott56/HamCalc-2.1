"""Polygon Dimensions"""

import hamcalc.math.polygon as polygon
from hamcalc.stdio import *
import math

print( polygon.intro() )

arg_names = {
"S": "Length of each side",
"H": "Perpendicular distance from centre to mid point of each side",
"R": "Length of radial from centre to end of each side",
"N": "Number of sides/radials",
"A": "Angle between radials",
"P": "Perimeter",
"D": "Circumference of circle running thru mid points of sides",
"E": "Circumference of circle running thru end points of sides",
"A_P": "Area of polygon",
}

N = None
while True:
    N= input_int( "ENTER:  {0}? ".format(arg_names["N"]) )
    if N is None: break
    if N < 3: continue
    print(" Press number in < > for known dimension:")
    print("   <1> {0}".format( arg_names["H"]) )
    print("   <2> {0}".format( arg_names["R"]) )
    print("   <3> {0}".format( arg_names["S"]) )
    Z = input( "CHOICE? " )
    if Z == "1":
        H= input_float( "ENTER: {0}? ".format(arg_names["H"]) )
        args= dict( N=N, H=H )
    elif Z == "2":
        R = input_float( "ENTER: {0}? ".format(arg_names["R"]) )
        args= dict( N=N, R=R )
    elif Z == "3":
        S = input_float( "ENTER: {0}? ".format(arg_names["S"]) )
        args= dict( N=N, S=S )
    args= polygon.polygon( **args )
    for var in 'N', 'H', 'R', 'A', 'S', 'P', 'D', 'E', 'A_P':
        if var == "N":
            print( "{0:.<64s} {1:9,.0f}".format( arg_names[var], args.get(var) ) )
        elif var == "A":
            print( "{0:.<64s} {1:9,.3f}°".format( arg_names[var], math.degrees(args.get(var)) ) )
        else:
            print( "{0:.<64s} {1:9,.3f}".format( arg_names[var], args.get(var) ) )


