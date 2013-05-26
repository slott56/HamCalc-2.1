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

def get_lat_lon_tz_date():
    """
    Get latitude, longitude, timezone and date.
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

    print(" (1) Atlantic" )
    print(" (2) Eastern" )
    print(" (3) Central" )
    print(" (4) Mountain" )
    print(" (5) Pacific" )
    print(" (6) Other" )
    tz= None
    while tz is None:
        tz_choice = input( "ENTER: Your timezone? " )
        if tz_choice == "6":
            gmt= -int(longitude/15)
            tz= FixedOffset( gmt*60 )
            print( "Using {0} based on Longitude {1:f}°".format(tz.tzname(),longitude) )
        else:
            try:
                tz= { '1': solar.Atlantic, '2': solar.Eastern,
                '3': solar.Central, '4': solar.Mountain,
                '5': solar.Pacific }[tz_choice]
            except KeyError:
                pass
    print( "Location..............  {0:5.1f}°N {1:5.1f}°W.   UTC {2:.2f} hours".format( latitude, longitude, tz.stdoffset.total_seconds()/3600 ) )

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
    return  latitude, longitude, tz, date_time

def display( latitude, longitude, tz, date_time ):
    """Display various sunrise, sunset details.

    ..  todo:: Confirm this output.

    :param latitude: Latitude of observer
    :param longitude: longitude of observer
    :param tz: timezone of observer
    :param date_time: datetime object with date to display
    """
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

def run():
    print( introduction )
    z= ''
    while z != '0':
        print("   < 1 > run this program" )
        print("   < 2 > run Sunrise/Sunset program")
        print("   < 0 >  EXIT" )
        z= input( "CHOICE? " )
        if z == '1':
            lat, lon, tz, date = get_lat_lon_tz_date()
            display( latitude, longitude, tz, date_time )
        elif z == '2':
            runpy.run_module( 'hamcalc.stdio.riseset' )

if __name__ == "__main__":
    run()
