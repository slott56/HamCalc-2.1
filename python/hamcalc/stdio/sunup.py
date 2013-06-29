"""Sunup/Sundown

"""
import hamcalc.navigation.solar as solar
from hamcalc.stdio import *
import datetime

introduction= "SUNUP/SUNDOWN                                            by George Murphy VE3ERP"

def create_table():
    location= input( "Name of your location.......? " )
    if len(location) == 0: return
    latitude= input_float( "ENTER: Your latitude  (XX.X degrees, minus if SOUTH).....? " )
    if latitude is None: return
    longitude= input_float( "ENTER: Your longitude (XX.X degrees, minus if EAST)......? " )
    if longitude is None: return
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

    year = input_int( "ENTER: Year to be used in calculations (yyyy)............? " )
    if year is None: return

    start= None
    while start is None:
        month_start, day_start = input_list_int( "ENTER: First date? (No. of Month, Day)...................? ", count=2 )
        if month_start is None or day_start is None: continue
        start= datetime.datetime( year, month_start, day_start, tzinfo=tz )

    end = None
    while end is None:
        month_end, day_end = input_list_int( "ENTER: Last date?  (No. of Month, Day)...................? ", count=2 )
        if month_end is None or day_end is None: continue
        end= datetime.datetime( year, month_end, day_end, tzinfo=tz )

    increment = input_int( "ENTER: Increment in days.................................? " )
    if increment is None:
        increment= 1
    if end < start:
        start, end = end, start

    display( latitude, longitude, tz, start, end, increment )

def display( latitude, longitude, tz, start, end, increment ):
    """Display sunup table.

    :param latitude: Latitude of observer
    :param longitude: longitude of observer
    :param tz: timezone of observer
    :param start: starting date for table
    :param end: ending date for table
    :param increment: day increment for table
    """
    heading= """\
              Hours     Sunrise (EST)        Sunset (EST)        Elev.& Azimuth
              of        and Azimuth          and Azimuth          of Noon Sun
   Date       Daylight   (degrees)            (degrees)            (degrees)
    """
    print( heading )
    for offset in range( 0, (end-start).days+increment, increment ):
        date= start+datetime.timedelta(days=offset)
        rise, transit, set = solar.rise_transit_set( latitude, longitude, date )
        az_r, el_r= solar.azimuth_elevation( latitude, longitude, rise )
        az_s, el_s= solar.azimuth_elevation( latitude, longitude, set )
        az_t, el_t= solar.azimuth_elevation( latitude, longitude, transit )
        daylight_hours= (set-rise).total_seconds()/3600
        print( "{0:10s}   {1:5.2f}    {2:8s} {3:5.2f}  {4:8s} {5:5.2f}  {6:8s} {7:5.2f} {8:5.2f}".format(
            date.strftime("%Y-%m-%d"),
            daylight_hours,
            rise.astimezone(tz).strftime("%H:%H:%S"), az_r,
            set.astimezone(tz).strftime("%H:%M:%S"), az_s,
            transit.astimezone(tz).strftime("%H:%M:%S"),
            el_t, az_t, ) )

print( introduction )
z= ''
while z != '0':
    print(" < 1 >  Run program" )
    print(" < 0 >  EXIT" )
    z= input( "CHOICE? " )
    if z == '1':
        create_table()
