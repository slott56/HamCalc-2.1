"""Decimal numbers to degrees/minutes/seconds

"DECIMAL/SEXIGESIMAL CONVERSION","","","DECICONV"
"HOURS",", conversion",", decimal to clock display","DECICONV"
"""

import hamcalc.math.deciconv as deciconv

def hours_to_sexagesimal():
    hrs_raw= input( "ENTER: Decimal hours (or 0 to quit).....?" )
    if len(hrs_raw) == 0: return
    hrs= float( hrs_raw )
    text= deciconv.HR_MIN_SEC.from_std( deciconv.HOUR.to_std( hrs ) )
    print( "     {0:8.4f} decimal hours = {1:s} (hrs:min:sec)".format( hrs, text ) )

def degrees_to_sexagesimal():
    deg_raw= input( "ENTER: Decimal degrees (or 0 to quit).....?" )
    if len(deg_raw) == 0: return
    deg= float( deg_raw )
    text= deciconv.DEG_MIN_SEC.from_std( deciconv.DEGREE.to_std( deg ) )
    print( "     {0:8.4f} decimal degrees = {1:s} (deg min sec)".format( deg, text ) )

def sexagesimal_to_hours():
    hms_raw= input( "ENTER: HH:MM:SS (or nothing to quit).....?" )
    if len(hms_raw) == 0: return
    hrs= deciconv.HOUR.from_std( deciconv.HR_MIN_SEC.to_std( hms_raw ) )
    print( "     {0:s} = {1:8.4f} decimal hours".format( hms_raw, hrs ) )

def sexagesimal_to_degrees():
    dms_raw= input( "ENTER: DEG MIN SEC (or nothing to quit).....?" )
    if len(dms_raw) == 0: return
    deg= deciconv.DEGREE.from_std( deciconv.DEG_MIN_SEC.to_std( dms_raw ) )
    fmt= deciconv.DEG_MIN_SEC.from_std( deciconv.DEGREE.to_std( deg ) )
    print( "     {0:s} = {1:8.4f} decimal degrees".format( fmt, deg ) )

print( deciconv.intro() )

z= None
while z != '0':
    print("   <1> Convert decimal hours to sexagesimal format")
    print("   <2> Convert decimal degrees to sexagesimal format")
    print("   <3> Convert sexagesimal hours to decimal format")
    print("   <4> Convert sexagesimal degrees to decimal format")
    print()
    print("   <0> EXIT")
    z= input( "Choice? " )
    if z == '1':
        hours_to_sexagesimal()
    elif z == '2':
        degrees_to_sexagesimal()
    elif z == '3':
        sexagesimal_to_hours()
    elif z == '4':
        sexagesimal_to_degrees()
