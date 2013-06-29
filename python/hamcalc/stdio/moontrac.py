"""Moon Tracker
"""
import hamcalc.navigation.lunar as lunar
from hamcalc.navigation.solar.timezone import utc, FixedOffset
from hamcalc.stdio import *
import datetime

introduction="""\
MOON TRACKER                                          by Lance Collister WA1JXN
edited for HAMCALC by George Murphy VE3ERP

   Displays GHA, Declination, Azimuth and Elevation of the moon from a
   selected latitude and longitude on a selected date. 'Windows'
   between the Western Hemisphere and other parts of the world are
   also indicated where appropriate.

   Position is calculated at 30 minute intervals during the portions
   of the GMT day when the moon is above the local horizon.

   Latitude and longitude are computed in decimal degrees. If you wish
   to convert degree/minute/second coordinates to decimal degrees, run
   the EQUIVALENT VALUES program.

   (For further information see the 1997 ARRL HANDBOOK for RADIO
   AMATEURS, page 23.55).
"""


def moontrack():

    latitude= input_float( "ENTER: Latitude, in decimal degrees (minus if south)...? " )
    longitude= input_float( "ENTER: Longitude, in decimal degrees (minus if west)...? " )
    if latitude is None or longitude is None: return

    tz_offset_hr= longitude/15
    tz= FixedOffset( tz_offset_hr*60 )
    print( "Location..............  {0:5.1f}°N {1:5.1f}°W.   UTC {2:.2f} hours".format( latitude, longitude, tz_offset_hr ) )

    yr= input_int( "ENTER: Year...........? " )
    mon= input_int( "ENTER: Month no. .....? " )
    day= input_int( "ENTER: Day no. .......? " )
    if yr is None or mon is None or day is None: return
    date_time= datetime.datetime( yr, mon, day, tzinfo=tz )
    print( "Date (y/m/d).......... {0}".format(date_time.date()) )

    display( latitude, longitude, tz_offset_hr, tz, date_time )

def display( latitude, longitude, tz_offset_hr, tz, date_time ):
    """Display moon position table.

    ..  todo:: Figure the "window" calculation

        See legacy :program:`montrac` lines 1120-1150,
        line 1660, and lines 1690-1820.

    """
    print( " POSITION OF THE MOON on {0} as seen from {1}°{2} {3}°{4}".
        format( date_time.strftime( "%Y-%m-%d" ),
        abs(latitude), 'N' if latitude >= 0 else 'S',
        abs(longitude), 'E' if longitude >= 0 else 'W' )
        )
    print()
    print( " LST = Local Solar Time; ≈y = yesterday; ≈t = tomorrow" )
    print()
    print( " GMT        GHA     DECLIN   WINDOW      LST     AZIMUTH   ELEVATION" )
    print( " ───────────────────────────────────────────────────────────────────" )
    base_date= date_time.replace( hour=0, minute=0, second=0, microsecond=0, tzinfo=utc )
    for tm in range(48):
        date = base_date + datetime.timedelta( days = tm/48 )
        jad= lunar.datetime_to_jad( date )
        m= lunar.Position_Moon( jad )
        az, alt= m.local_az_alt( latitude, longitude, tm/2 )
        if alt < 0: continue
        lst_h, lst_m = divmod( (m.LST%24)*60, 60 )
        # Not quite right.
        window = ""
        if 50 <= az < 80: window="Europe"
        elif 80 <= az < 141.5: window="Americas"
        elif 141.5<= az < 170.5: window="Far East"
        print( "{0:6s}  {1:8.3f}  {2:8.3f} {3:10s}   {4:02.0f}:{5:02.0f}    {6:8.3f}   {7:8.3f}".format( date.strftime("%H:%M"), m.HA, m.Decl, window, lst_h, lst_m, az, alt ) )

print( introduction )
z= ''
while z != '0':
    print("   < 1 >  run this program" )
    print("   < 2 >  run Equivalent Values program")
    print("   < 0 >  EXIT" )
    z= input( "CHOICE? " )
    if z == '1':
        moontrack()
    elif z == '2':
        runpy.run_module( 'hamcalc.stdio.equiv' )
