"""True North via the Sun

"NORTH",", determined by noon sun","","TRUNORTH"
"TRUE NORTH VIA THE SUN","","","TRUNORTH"
"""
import hamcalc.navigation.solar as solar
from hamcalc.navigation.solar.timezone import utc, FixedOffset
import datetime

introduction="""\
TRUE NORTH via the Sun                                  by George Murphy VE3ERP

     The shadow of a vertically plumb stake cast by the sun at High
   Noon runs exactly north and south. This ancient axiom can be used to
   aim your antenna, orient a sundial, or calibrate your car compass.
     If the stake is north of lat. 23.5°N the shadow points north, if
   south of lat. 23.5°S, it points south. If the stake is between
   these latitudes and above the Equator the shadow points north in
   the winter and south in the summer. If south of the Equator it
   points north in the summer and south in the winter.
     To determine just when High Noon is, you must know your longitude.
   This will tell you when High Noon is SUPPOSED to occur but doesn't,
   due to the somewhat complex wobbling of the earth about its axis as
   it circles the sun. Ancient mathematicians didn't know much about
   the wobble but we do, so we have to take it into account, which the
   program does.
     The program refers to High Noon as SOLAR NOON (it sounds more
   High Tech). Local SOLAR (geophysical) TIMES shown may not be the
   same as STANDARD (political) TIMES in some political jurisdictions,
   and are dependent on your distance east or west of longitude 0.00°
   or the nearest multiple of 15 degrees of longitude.
"""

def offsets( local_tz ):
    year= datetime.date.today().year
    jan_1_ord= datetime.date( year, 1, 1 ).toordinal()
    for i in range(12):
        month= i+1
        for day in 1, 10, 21:
            date= datetime.datetime( year, month, day, 12, tzinfo=local_tz )
            offset= datetime.timedelta( minutes=solar.eot( date.toordinal()-jan_1_ord ))
            yield date, offset

def show_lon( lat ):
    """..   todo:: This needs to be shared among several programs."""
    if lat < 0:
        return "{0:5.1f}°W".format( abs(lat)%180 )
    else:
        return "{0:5.1f}°E".format( abs(lat)%180 )

def format_column( date_time, offset ):
    lst = date_time + offset
    text = "{0:12s} UTC ({1:5s} LST)".format(
            lst.astimezone(utc).strftime("%b %d %H:%M"),
            lst.strftime("%H:%M")
            )
    return text

def display( longitude ):
    print( "     At longitude {0:7s} SOLAR NOON times throughout the year are:".format(show_lon(longitude)) )
    print( "     (UTC = Universal Co-ordinated Time)   (LST = Local SOLAR Time)" )
    print()
    tz= FixedOffset( int(longitude/15)*60 )
    all_offsets= list( offsets(tz) )
    for d_1, d_2 in zip( all_offsets[:18], all_offsets[18:] ):
        col_1= format_column( *d_1 )
        col_2= format_column( *d_2 )
        print( "{0:38s} {1:38s}".format( col_1, col_2 ) )
    print()

print( introduction )
long_raw= None
while long_raw != '':
    long_raw= input( "ENTER: Your longitude in decimal degrees: " )
    if len(long_raw) == 0: break
    try:
        longitude= float(long_raw)
    except ValueError:
        continue
    display( longitude )
