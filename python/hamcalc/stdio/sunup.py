"""Sunup/Sundown

"""
import hamcalc.navigation.solar as solar
import datetime

introduction= "SUNUP/SUNDOWN                                            by George Murphy VE3ERP"

def create_table():
    location= input( "Name of your location.......? " )
    if len(location) == 0: return
    latitude= None
    while latitude is None:
        lat_raw= input( "ENTER: Your latitude  (XX.X degrees, minus if SOUTH).....? " )
        try:
            latitude= float(lat_raw)
        except ValueError:
            pass
    longitude= None
    while longitude is None:
        lon_raw= input( "ENTER: Your longitude (XX.X degrees, minus if EAST)......? " )
        try:
            longitude= -float(lon_raw)
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

    year = None
    while year is None:
        year_raw = input( "ENTER: Year to be used in calculations (yyyy)............? " )
        try:
            year= int(year_raw)
        except ValueError:
            pass
    start= None
    while start is None:
        md_start = input( "ENTER: First date? (No. of Month, Day)...................? " )
        try:
            month_start, day_start = map( int, md_start.split(",") )
            start= datetime.datetime( year, month_start, day_start, tzinfo=tz )
        except ValueError:
            pass
    end = None
    while end is None:
        md_end = input( "ENTER: Last date?  (No. of Month, Day)...................? " )
        try:
            month_end, day_end = map( int, md_end.split(",") )
            end= datetime.datetime( year, month_end, day_end, tzinfo=tz )
        except ValueError:
            pass
    increment= None
    increment_raw = input( "ENTER: Increment in days.................................? " )
    try:
        increment= int(increment_raw)
    except ValueError:
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
