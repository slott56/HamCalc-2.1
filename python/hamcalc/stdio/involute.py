"""Involute of a Circle

"CIRCLE",", involute of","","INVOLUTE"
"INVOLUTE OF A CIRCLE","","","INVOLUTE"
"""
from hamcalc.stdio.gwgraphics import GWGraphics
from hamcalc.math.involute import involute
from hamcalc.stdio import *
import math
import sys

SIN=math.sin
COS=math.cos

def diagram():
    """The Involute diagram.

    This is "transliterated" from the original GW-Basic, quirks
    and all.
    """
    g= GWGraphics()
    g.SCREEN( 8 )
    g.PRINT( "INVOLUTE of a CIRCLE" )
    g.LOCATE( 3,12 ); g.PRINT( "Y" )
    g.LOCATE( 12,50 ); g.PRINT( "X" )
    g.LOCATE( 12,11 ); g.PRINT( "O" )
    g.LOCATE( 7,11 ); g.PRINT( "A" )
    g.LOCATE( 17,11 ); g.PRINT( "B" )
    S=0.42 #!                                 :REM'aspect ratio for screen 2
    R=92; H=91; PI=3.141593
    g.LINE(R,H+R*S,R,25)
    g.LINE(R,H,381,H, pattern=0x5555 )
    g.CIRCLE (R,H,R)
    I=80; L=0
    for Z in range(1,I+1): # FOR Z=1 TO I
        L=L+PI/I
        X=R*((SIN(L)-L*COS(L)))+R
        Y=H-(R*(COS(L)+L*SIN(L)))*S
        g.PSET (X,Y)
    I=10; L=0
    for Z in range(1,I+1): # FOR Z=1 TO I
        L=L+PI/I
        X=R*((SIN(L)-L*COS(L)))+R
        Y=H-(R*(COS(L)+L*SIN(L)))*S
        A=R*SIN(L); B=R*COS(L)*S
        g.LINE(R+A,H-B,X,Y, pattern=0x1111)
        if Z == 7: # IF Z<>7 THEN 500
            g.LINE(R+A,H-B,X,Y)
            g.LINE(R,H,X,Y)
            g.LINE(R+A,H-B,R,H)
            g.LOCATE( 14,21 ); g.PRINT( "E" )
            g.LOCATE( 5,37 ); g.PRINT( "C" )
            g.CIRCLE (R,H,R/2,start=1.8*PI,end=PI/2 )
            g.LOCATE (11,19); g.PRINT("phi")
            g.LOCATE (7,32); g.PRINT( "a" )
    g.LINE(R,Y,X,Y, pattern=0x5555 )
    g.LOCATE (17,50); g.PRINT( "D" )
    #530 LOCATE 19:PRINT STRING$(80,45)
    g.display( "Involute of a Circle" )

diagram()
r = input_float( "ENTER: Radius OE.........? " )
args = involute( radius=r )
print( args )
print( "Radius OE=     {0:11,.3f}".format(args.radius) )
print( "Diameter AB=   {0:11,.3f}".format(args.diameter) )
print( "Base Line BD=  {0:11,.3f}".format(args.baseline) )
print( "Involute ACD=  {0:11,.3f}".format(args.involute) )
while True:
    phi = input_float( "ENTER: angle φ°? " )
    if phi is None: break
    args= involute( radius=r, phi=math.radians(phi) )
    print( "Values for point C are:   " )
    print( "-----------------------   " )
    print( "Angle φ = {0:.2f}°".format( math.degrees( args.phi ) ) )
    print( "Coordinate X=  {0:11,.3f}".format(args.C_X) )
    print( "Coordinate Y=  {0:11,.3f}".format(args.C_Y) )
    print( "Angle a = {0:.2f}°".format( math.degrees(args.OCE) ) )
    print( "Angle COE = {0:.2f}°".format( math.degrees(args.COE) ) )
    print( "Line CO=       {0:11,.3f}".format(args.CO) )
    print( "Line CE=       {0:11,.3f}".format(args.CE) )
