#!/Library/Frameworks/Python.framework/Versions/3.2/bin/python3.2
"""Logoclok

"CLOCK",", (screen saver)","","LOGOCLOK"
"SCREEN SAVER",", (analog clock)","","LOGOCLOK"
"""
from hamcalc.stdio.gwgraphics import GWGraphics
import math
import datetime

# 60
N = "H A M C A L C"                 #REM'logo

g= GWGraphics()
g.SCREEN( 9 )
J = "Sunday,Monday,Tuesday, Wednesday,Thursday,Friday,Saturday".split(',')
M = "Jan.,Feb.,Mar.,Apr.,May.,Jun.,Jul.,Aug.,Sep.,Oct.,Nov.,Dec.".split(',')
C = [0,0,10,11,12,13,14] # colours

SX = SY = 0 # Implied Initial Values
MX = MY = 0

ASP = 1.38                          #REM'aspect ratio correction
while True:
    CX=315;CY=104                   #REM'initial coordinates of dial centre
    LIN=8                           #REM'initial line for text
    RD=147                          #REM'length of dial radial
    RN=98                           #REM'length of 5 minute markers radial
    RS=98                           #REM'length of seconds radial
    RM=90                           #REM'length of minutes radial
    RH=60                           #REM'length of hours radial
    B1=1                            #REM'blue background color
    B2=4                            #REM'red background color

    #390 :REM'.....start one minute cycle

    # 400
    B1, B2 = B2, B1; BG = B1

    # 410-450
    for Z in range(2,7):
        C[Z] = C[Z] + 1             #REM'change colours
        if C[Z] == 15: C[Z]= 10
        if C[Z] == 7: C[Z]= 2

    # 470 :REM'.....draw clock face
    LIN = LIN + 1                   #REM'shift display one line down
    if LIN == 18: continue
    CY = CY + 14                    #REM'shift Y coordinate one line down

    # 520
    X = 1                           #REM'set color base for dial outline

    # 530                           #REM'draw dial outline
    for W in range(1,14,3):
        X = X + 1                   #REM'set new color for each ring
        g.COLOR( C[X], BG )
        g.CIRCLE( CX, CY, RD+W )    #REM'draw ring

    # 590
    L = math.pi / 6                 #REM'5 minute marker angle in radians
    g.COLOR( C[3], BG )

    # 610
    for Z in range(1,13):           #REM'draw 5 minute markers
        DX = math.sin( L*Z )*RN*ASP
        DY = math.cos( L*Z )*RN
        # This is really just pensize(2)
        g.CIRCLE( CX+DX, CY+DY, 7 )
        g.CIRCLE( CX+DX, CY+DY, 8 )

    # 680
    L = math.pi / 30                #REM'seconds marker angle in radians
    for Z in range(1,61):           #REM'draw seconds markers
        DX = math.sin( L*Z )*RS*ASP
        DY = math.cos( L*Z )*RS
        #g.CIRCLE( CX+DX, CY+DY, 1 )

    # 740
    now= datetime.datetime.now()
    time= now.time()
    HRS, MIN = time.hour % 12, time.minute

    # 780
    HS_deg = HRS*30+MIN/2+180           #REM'hours angle in degrees
    HS = math.radians( 180-HS_deg )     #REM'hours angle in radians, clockwise rotation

    # 800
    HX = math.sin(HS)*RH*ASP            #REM'X coordinate of hour hand
    HY = math.cos(HS)*RH                #REM'Y coordinate of hour hand

    # SECOND LOOP

    # 840 :REM'.....start seconds counter
    SEC = time.second

    # 900 :REM'.....seconds
    g.COLOR( BG, BG )
    g.CIRCLE(CX+SX, CY+SY, 4)           #REM'subdue seconds indicator

    S=SEC*6+180                         #REM'seconds angle in degrees
    LS=math.radians(180-S)              #REM'angle in radians, clockwise rotation
    SX=math.sin(LS)*RS*ASP              #REM'X coordinate of second hand
    SY=math.cos(LS)*RS                  #REM'Y coordinate of second hand

    # 1005
    g.COLOR( 15,BG )
    g.CIRCLE (CX+SX,CY+SY,4)            #REM'print new seconds indicator

    # 1040
    JD = now.strftime( "%A %b. %d" )

    # 1050
    g.COLOR( C[4], BG )
    g.LOCATE( LIN-2, (80-len(JD))/2 )
    g.PRINT( JD )                       #REM'print day & date

    # 1080
    T = now.strftime( "%H:%M:%S" )
    g.LOCATE( LIN+2, (80-len(T))/2 )
    g.PRINT( T )                        #REM'print digital time

    # 1120
    g.COLOR( C[5], BG )
    # 1130 -- 1600
    g.LOCATE( LIN, (80-len(N))/2 )
    g.PRINT( N )                        #REM'N$ is logo as defined at start of program
    # 1140
    g.COLOR( C[6], BG )

    # 1170
    g.LINE(CX, CY, CX+HX, CY+HY)        #REM'print hour hand

    # 1190 :REM'.....minutes
    g.COLOR( BG,BG )
    g.LINE(CX,CY,CX+MX,CY+MY)           #REM'blank current minute hand

    # 1230
    M=MIN*6+SEC/10+180                  #REM'minutes angle in degrees
    MS=math.radians(180-M)              #REM'angle in radians, clockwise rotation
    MX=math.sin(MS)*RM*ASP              #REM'X coordinate of minute hand
    MY=math.cos(MS)*RM                  #REM'Y coordinate of minute hand

    # 1300
    g.COLOR( C[6], BG )
    g.LINE(CX,CY,CX+MX,CY+MY)           #REM'print new minute hand

    break

g.wait()
