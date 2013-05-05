"""Trigonometric functions
"""
import hamcalc.math.trig as trig
import math
import runpy

def functions( angle ):
    a0, a1, a2, a3 = (angle, math.pi-angle, math.pi+angle, 2*math.pi-angle)
    print( "TRIGONOMETRIC FUNCTIONS".center(80) )
    print()
    print(" ANGLES:" )
    print("        Deg/Min/Sec.......= {0:>12s} {1:>12s} {2:>12s} {3:>12s}".format(trig.DEG_MIN_SEC.from_std(a0),  trig.DEG_MIN_SEC.from_std(a1),  trig.DEG_MIN_SEC.from_std(a2),  trig.DEG_MIN_SEC.from_std(a3)) )
    print("        Decimal degrees...= {0:12.6f} {1:12.6f} {2:12.6f} {3:12.6f}".format(trig.DEGREE.from_std(a0), trig.DEGREE.from_std(a1), trig.DEGREE.from_std(a2), trig.DEGREE.from_std(a3)) )
    print("        Radians...........= {0:12.6f} {1:12.6f} {2:12.6f} {3:12.6f}".format(trig.RADIAN.from_std(a0), trig.RADIAN.from_std(a1), trig.RADIAN.from_std(a2), trig.RADIAN.from_std(a3)) )
    print()
    print(" FUNCTIONS of all the above angles:" )
    print("        Sine..........Sin = {0:12.6f}".format( math.sin(a0) ) )
    print("        Cosine........Cos = {0:12.6f}".format( math.cos(a0) ) )
    print("        Tangent.......Tan = {0:12.6f}".format( math.tan(a0) ) )
    print("        Cotangent.....Cot = {0:12.6f}".format( 1/math.tan(a0) ) )
    print("        Secant........Sec = {0:12.6f}".format( 1/math.cos(a0) ) )
    print("        Cosecant......Csc = {0:12.6f}".format( 1/math.sin(a0) ) )

print( trig.intro() )

z= None
while z != 'z':
    print("   <a> Angle, in degrees/minutes/seconds")
    print("   <b> Angle, in decimal degrees")
    print("   <c> Angle, in radians")
    print("   <d> Sine")
    print("   <e> Cosine")
    print("   <f> Tangent")
    print("   <g> Cotangent")
    print("   <h> Secant")
    print("   <i> Cosecant")
    print()
    print("   -or-")
    print()
    print("   <y> to run Solution of Triangles program")
    print()
    print("   <z> to EXIT program")
    z= input( "Choice? " )
    if z == 'a':
        angle_raw= input( "ENTER: Angle, in degrees minutes and seconds? " )
        if len(angle_raw) == 0: continue
        angle= trig.DEG_MIN_SEC.to_std( angle_raw )
        functions( angle )
    elif z == 'b':
        angle_raw= input( "ENTER: Angle, in degrees? " )
        if len(angle_raw) == 0: continue
        angle= trig.DEGREE.to_std( float(angle_raw) )
        functions( angle )
    elif z == 'c':
        angle_raw= input( "ENTER: Angle, in radians? " )
        if len(angle_raw) == 0: continue
        angle= trig.RADIAN.to_std( float(angle_raw) )
        functions( angle )
    elif z == 'd':
        value_raw= input( "ENTER: Value of Sine (range 0-1)? " )
        if len(value_raw) == 0: continue
        angle= math.asin( float(value_raw) )
        functions( angle )
    elif z == 'e':
        value_raw= input( "ENTER: Value of Cosine (range 0-1)? " )
        if len(value_raw) == 0: continue
        angle= math.acos( float(value_raw) )
        functions( angle )
    elif z == 'f':
        value_raw= input( "ENTER: Value of Tangent (range 0-∞)? " )
        if len(value_raw) == 0: continue
        angle= math.atan( float(value_raw) )
        functions( angle )
    elif z == 'g':
        value_raw= input( "ENTER: Value of Cotangent (range 0-∞)? " )
        if len(value_raw) == 0: continue
        angle= math.atan2( 1, float(value_raw) )
        functions( angle )
    elif z == 'h':
        value_raw= input( "ENTER: Value of Secant (range 0-∞)? " )
        if len(value_raw) == 0: continue
        z= 1/float(value_raw)
        angle= math.pi/2-math.atan2(z,math.sqrt(1-z**2))
        functions( angle )
    elif z == 'i':
        value_raw= input( "ENTER: Value of Cosecant (range 0-∞)? " )
        if len(value_raw) == 0: continue
        z= 1/float(value_raw)
        angle= math.atan2(z,math.sqrt(1-z**2))
        functions( angle )
    elif z == 'y':
        runpy.run_module( 'hamcalc.stdio.solutri' )
