"""A literal "transcription" from GW-Basic to Python.

This serves as the jumping-off point for a GW-Basic Graphics
class definition that has methods which are close matches to GW-Basic
statements.

The idea would be something like this.

::

    g= GWGraphics()
    g.SCREEN( 8 )
    g.PRINT( "something" )
    g.LOCATE 3, 12 ); g.PRINT( "something" )
    g.LINE( a, b, x, y, pattern=&H0x5555 )
    g.CIRCLE( x, y, radius=r )
    g.PSET( x, y )
    g.display( "title" )

That would slightly simplify the transcription of confusing
GW Basic into Python.
"""

from turtle import *
import math

# 130 SCREEN 8:U$="###,###.###"
setup( width=640, height=480 )
setworldcoordinates(0,-240,640,240)
# Documentation says 640x200 this is really 640x480
# with an aspect ratio of 0.416 (see variable S below.)

# 140 PRINT "INVOLUTE of a CIRCLE";STRING$(80,45)
penup(); goto( 0, 0 ); write( "INVOLUTE of a CIRCLE", font=("Courier", 14) )

# 150 LOCATE 3,12:PRINT "Y"
penup(); goto( 12*8, 3*8 ); write( "Y", font=("Courier", 12) )

# 160 LOCATE 12,50:PRINT "X"
penup(); goto( 50*8, 12*8 ); write( "X", font=("Courier", 12) )

# 170 LOCATE 12,11:PRINT "O"
penup(); goto( 11*8, 12*8 ); write( "O", font=("Courier", 12) )

# 180 LOCATE 7,11:PRINT "A"
penup(); goto( 11*8, 7*8 ); write( "A", font=("Courier", 12) )

# 190 LOCATE 17,11:PRINT "B"
penup(); goto( 11*8, 17*8 ); write( "B", font=("Courier", 12) )

# 200 S=0.42!                                 :REM'aspect ratio for screen 2
# (A) not exactly correct (it's 4.167), (B) Doesn't apply

# 210 R=92:H=91:PI=3.141593!
R=92; H=91; PI=math.pi

# 220 LINE(R,H+R*S)-(R,25)
penup(); goto( R, H+R); pendown(); goto( R, 25 )

# 230 LINE(R,H)-(381,H),,,&H0x5555
penup(); goto( R, H); pendown(); goto( 381, H )

# 240 CIRCLE (R,H),R
penup(); goto( R, H-R ); pendown(); circle( R )

# 250 I=80:L=0
I=80; L=0

# 260 FOR Z=1 TO I
for Z in range(1,I+1):

    # 270 L=L+PI/I
    L= L+PI/I

    # 280 X=R*((SIN(L)-L*COS(L)))+R
    X=R*((math.sin(L)-L*math.cos(L)))+R

    # 290 Y=H-(R*(COS(L)+L*SIN(L)))*S
    Y= H-(R*(math.cos(L)+L*math.sin(L))) # S omitted

    # 300 PSET (X,Y)
    penup(); goto(X,Y); dot(2)

    # 310 NEXT Z

# 320 I=10:L=0
I=10; L=0

# 330 FOR Z=1 TO I
for Z in range(1,I+1):

    # 340 L=L+PI/I
    L= L + PI/I

    # 350 X=R*((SIN(L)-L*COS(L)))+R
    X=R*((math.sin(L)-L*math.cos(L)))+R

    # 360 Y=H-(R*(COS(L)+L*SIN(L)))*S
    Y=H-(R*(math.cos(L)+L*math.sin(L))) # S omitted

    # 370 A=R*SIN(L):B=R*COS(L)*S
    A=R*math.sin(L); B=R*math.cos(L) # S omitted

    # 380 LINE(R+A,H-B)-(X,Y),,,&H0x1111
    penup(); goto( R+A, H-B ); pendown(); goto( X, Y )

    # 390 IF Z<>7 THEN 500
    if Z == 7:
        # 400 :REM'
        # 410 LINE(R+A,H-B)-(X,Y)
        penup(); goto( R+A, H-B ); pendown(); goto( X, Y )

        # 420 LINE(R,H)-(X,Y)
        penup(); goto( R, H ); pendown(); goto( X, Y )

        # 430 LINE(R+A,H-B)-(R,H)
        penup(); goto( R+A, H-B ); pendown(); goto( R, H )

        # 440 LOCATE 14,21:PRINT "E"
        penup(); goto( 21*8, 14*8 ); write( "E", font=("Courier", 12) )

        # 450 LOCATE 5,37:PRINT "C"
        penup(); goto( 37*8, 5*8 ); write( "C", font=("Courier", 12) )

        # 460 CIRCLE (R,H),R/2,,1.8!*PI,PI/2
        # 1.8\pi to .5\pi, measured from where??
        # And why not use L, which is the current angle being used?
        angle= (L*180/math.pi) # to Degrees
        penup(); goto( R, H-R/2 ); pendown(); circle( R/2, angle )

        # 470 LOCATE 11,19:PRINT CHR$(237)
        penup(); goto( 19*8, 11*8 ); write( 'phi', font=("Courier", 12) ) # ( 'φ' )

        # 480 LOCATE 7,32:PRINT "a"
        penup(); goto( 32*8, 7*8); write( "a", font=("Courier", 12) )
        # 490 :REM'
    # 500 NEXT Z

# 510 LINE(R,Y)-(X,Y),,,&H0x5555
penup(); goto( R, Y ); pendown(); goto( X, Y )

# 520 LOCATE 17,50:PRINT "D"
penup(); goto( 50*8, 17*8); write( "D", font=("Courier", 12) )

# 530 LOCATE 19:PRINT STRING$(80,45)

ht()
mainloop()
