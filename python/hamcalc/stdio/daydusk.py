"""Daylight Dusk and Dawn Calculator

"DAYLIGHT DUSK & DAWN","","","DAYDUSK"
"""
import hamcalc.navigation.solar as solar
from hamcalc.navigation.solar.timezone import FixedOffset, utc
from hamcalc.lib import AttrDict
import datetime
import runpy

introduction = """\
DAYLIGHT DUSK & DAWN CALCULATOR                                  Author Unknown
Edited for HAMCALC by George Murphy, VE3ERP

This program computes times of sunrise, sunset, dawn and dusk at any location.

Enter the latitude and longitude of the location in decimal degrees. If the
latitude is south of the equator enter the latitude as a minus (-) value or as
a positive value if north of the equator. If the longitude is west of the
prime meridian (0° - Greenwich) enter the longitude as a minus (-) value or as
a positive value if east of the prime meridian.

Times calculated are local sidereal (SOLAR) times. Forget about Standard Time,
Daylight Saving Time, local political time, UTC, or any other man-made time
system. Sidereal time is time referenced to the stars. It is the time shown
for millenia on properly installed sun dials.

Related data can also be calculated using Hamcalc's `Sunrise/Sunset' program.
"""

def dusk_dawn():
    """
    ..  todo:: Confirm the output.
    """

    latitude= None
    while latitude is None:
        lat_raw= input( "ENTER: Latitude, in decimal degrees (minus if south)...? " )
        try:
            latitude= float( lat_raw )
        except ValueError:
            pass
    longitude= None
    while longitude is None:
        lon_raw= input( "ENTER: Longitude, in decimal degrees (minus if west)...? " )
        try:
            longitude= float( lon_raw )
        except ValueError:
            pass

    tz_offset_hr= longitude/15
    tz= FixedOffset( tz_offset_hr*60 )
    print( "Location..............  {0:5.1f}°N {1:5.1f}°W.   UTC {2:.2f} hours".format( latitude, longitude, tz_offset_hr ) )

    date_time= None
    while date_time is None:
        try:
            yr_raw= input( "ENTER: Year...........? " )
            yr= int(yr_raw)
            mon_raw= input( "ENTER: Month no. .....? " )
            mon= int(mon_raw)
            day_raw= input( "ENTER: Day no. .......? " )
            day= int(day_raw)
            date_time= datetime.datetime( yr, mon, day, tzinfo=tz )
        except ValueError:
            pass
    print( "Date (y/m/d).......... {0}".format(date_time.date()) )

    rise_a, _, set_a = solar.rise_transit_set( latitude, longitude, date_time, horizon=90+18 )
    rise_n, _, set_n = solar.rise_transit_set( latitude, longitude, date_time, horizon=90+12 )
    rise_c, _, set_c = solar.rise_transit_set( latitude, longitude, date_time, horizon=90+6 )
    rise_v, _, set_v = solar.rise_transit_set( latitude, longitude, date_time )

    line= "{0:.<22s} {1:8s} = {2:8s} UTC   {3:s}"
    print( line.format( "Astronomical Dawn", rise_a.strftime( "%H:%M:%S" ), rise_a.astimezone(utc).strftime( "%H:%M:%S" ), "Sun 18° below horizon" ) )
    print( line.format("Nautical Dawn", rise_n.strftime( "%H:%M:%S" ), rise_n.astimezone(utc).strftime( "%H:%M:%S" ), "Sun 12° below horizon" ) )
    print( line.format("Civil Dawn", rise_c.strftime( "%H:%M:%S" ), rise_c.astimezone(utc).strftime( "%H:%M:%S" ), "Sun  6° below horizon"  ) )
    print( line.format("Sunrise", rise_v.strftime( "%H:%M:%S" ), rise_v.astimezone(utc).strftime( "%H:%M:%S" ), "Top of sun at the horizon" ) )
    print( "────────────────────────────────────────" )
    print( line.format("Sunset", set_v.strftime( "%H:%M:%S" ), set_v.astimezone(utc).strftime( "%H:%M:%S" ), "Top of sun at the horizon"  ) )
    print( line.format("Civil Dusk", set_c.strftime( "%H:%M:%S" ), set_c.astimezone(utc).strftime( "%H:%M:%S" ), "Sun  6° below horizon"  ) )
    print( line.format("Nautical Dusk", set_n.strftime( "%H:%M:%S" ), set_n.astimezone(utc).strftime( "%H:%M:%S" ), "Sun 12° below horizon" ) )
    print( line.format("Astronomical Dusk", set_a.strftime( "%H:%M:%S" ), set_a.astimezone(utc).strftime( "%H:%M:%S" ), "Sun 18° below horizon" ) )

print( introduction )
z= ''
while z != '0':
    print("   < 1 > run this program" )
    print("   < 2 > run Sunrise/Sunset program")
    print("   < 0 >  EXIT" )
    z= input( "CHOICE? " )
    if z == '1':
        dusk_dawn()
    elif z == '2':
        runpy.run_module( 'hamcalc.stdio.riseset' )
