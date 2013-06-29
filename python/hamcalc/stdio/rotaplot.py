"""Cartesian/Polar Plot Rotator

"PLOT ROTATOR",", cartesian/polar","","ROTAPLOT"
"CARTESIAN/POLAR PLOT ROTATOR","","","ROTAPLOT"
"""
import hamcalc.math.rotaplot as rotaplot
from hamcalc.stdio import *
import math

heading= """\
┌─────────────── Cartesion Plot ───────────────┐│┌──────── Polar Plot ────────┐
┌───── rotate from ────┐ ┌───── rotate to ─────┐│            ┌─ rotate angle ─┐
     -x-          -y-        -x-          -y-   │    Vector  ┌ from ┐  ┌─ to ─┐
"""

def report( x1, y1, x2, y2, r, theta, theta_2 ):
    print( "{0:+11.3f} {1:+11.3f} {2:+11.3f} {3:+11.3f} | {4:9.3f}   {5:6.2f}    {6:6.2f}".format(x1, y1, x2, y2, r, math.degrees(theta), math.degrees(theta_2)) )

def rotate(p):
    print( " To rotate plotted coordinates about " )
    print( " the junction * of the X and Y axis: " )
    d= input_float( "ENTER: Rotation in degrees (minus if counter-clockwise) ?" )
    if d is None: return
    d_text= "° counter-clockwise " if d < 0 else "° clockwise "
    offset= math.radians( d )
    print( "Rotation = {0}{1}".format( abs(d), d_text ) )

    print( heading )

    points= []
    while True:
        if p == '2':
            r= input_float( "ENTER: Vector length? " )
            if r is None: break
            theta= input_float( "ENTER: Angle? " )
            if theta is None: break
            x1, y1 = rotaplot.polar_to_cartesian( r, theta )
        elif p == '1':
            x1= input_float( "ENTER: x? " )
            if x1 is None: break
            y1= input_float( "ENTER: y? " )
            if y1 is None: break
            r, theta = rotaplot.cartesian_to_polar( x1, y1 )
        _, theta_2 = rotaplot.rotate( r, theta, offset )
        x2, y2 = rotaplot.polar_to_cartesian( r, theta_2 )
        points.append( (x1, y1, x2, y2, r, theta, theta_2) )
        report( x1, y1, x2, y2, r, theta, theta_2 )

    print( heading )
    for p in points:
        report( *p )

print( rotaplot.intro() )

p = None
while p != '0':
    print( "   < 1 > Enter data in CARTESIAN co-ordinates" )
    print( "   < 2 > Enter data in POLAR co-ordinates" )
    print( )
    print( "   < 0 > EXIT" )
    p = input( "CHOICE? " )
    if p == '1':
        rotate(p)
    elif p == '2':
        rotate(p)
