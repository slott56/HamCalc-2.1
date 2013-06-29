"""Equinoxes & Solstices

"EQUINOXES","","","SEASONS"
"SEASONS","","","SEASONS"
"SOLSTICES","","","SEASONS"
"""
import hamcalc.navigation.solar as solar
from hamcalc.stdio import *
import datetime

introduction= "SEASONS                                                 by George Murphy VE3ERP"

def bisection( lat, lon, low, high, G ):
    """Find a target date via bisection.

    We have a discontinuity at zero, there's no "negative"
    numbers, instead the value jumps to be less than 360.
    When the target is near zero, we have to adjust the
    function output to make 270-360 into negative numbers.

    :param lat: Latitude of observer
    :param lon: longitude of observer
    :param low: start date for search
    :param high: end date for search
    :param G: target value of ``P`` (apparent solar longitude)
        Usualy 0, 90, 180 or 270 to find solstices
        or equinoxes.
    """
    eps= 1/24/60/60 # 1 second
    def f_non_zero( lat, lon, date_time ):
        """The normal, non-zero case, avoids the discontinuity."""
        sun = solar.Position_Sun( lat, lon, date_time )
        #print( date_time, sun.F, sun.P, sun.T )
        return sun.P
    def f_zero( lat, lon, date_time ):
        """The near-zero case, where we apply an offset around the discontinuity."""
        sun = solar.Position_Sun( lat, lon, date_time )
        if sun.P > 270:
            P= sun.P-360
        else:
            P= sun.P
        #print( date_time, sun.F, P, sun.T )
        return P
    if G == 0:
        f= f_zero
    else:
        f= f_non_zero
    for count in range(64): # 64 bit of precision, in effect.
        mid= (high-low)/2+low
        G_calc= f( lat, lon, mid )
        if abs(G-G_calc) <= eps: break
        if G_calc < G:
            low= mid
        else:
            high= mid
    return mid

def report( latitude, longitude, date_time, tz ):
    details = solar.Position_Sun( latitude, longitude, date_time )
    rise, transit, set = solar.rise_transit_set( latitude, longitude, date_time )
    az_r, el_r= solar.azimuth_elevation( latitude, longitude, rise )
    az_s, el_s= solar.azimuth_elevation( latitude, longitude, set )

    print( "{0:10s}   {1:5.2f}     {2:8s} {3:6.2f}      {4:8s} {5:4.2f}     {6:6.2f} {7:6.2f}".format(
        date_time.strftime("%Y-%m-%d"),
        details.AA/60,
        rise.astimezone(tz).strftime("%H:%H:%S"), az_r,
        set.astimezone(tz).strftime("%H:%M:%S"), az_s,
        details.AE+180, details.AH , ) )

def find_dates():
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

    # Search for  ``P`` values of 0, 90, 180, 270 within the given year.

    heading = """\
   Date      Daylight  Sunrise (EST)        Sunset (EST)       ┌───── Noon ────┐
             hours     and Azimuth          and Azimuth         Sun  Earth Axis
"""

    print( heading )

    low= datetime.datetime( year, 3, 1, tzinfo=tz )
    high= datetime.datetime( year, 3, 31, tzinfo=tz )
    vernal_equinox= bisection( latitude, longitude, low, high, 0 )
    report( latitude, longitude, vernal_equinox, tz )

    low= datetime.datetime( year, 6, 1, tzinfo=tz )
    high= datetime.datetime( year, 6, 30, tzinfo=tz )
    summer_solstice= bisection( latitude, longitude, low, high, 90 )
    report( latitude, longitude, summer_solstice, tz )

    low= datetime.datetime( year, 9, 1, tzinfo=tz )
    high= datetime.datetime( year, 9, 30, tzinfo=tz )
    autumnal_equinox= bisection( latitude, longitude, low, high, 180 )
    report( latitude, longitude, autumnal_equinox, tz )

    low= datetime.datetime( year, 12, 1, tzinfo=tz )
    high= datetime.datetime( year, 12, 31, tzinfo=tz )
    winter_solstice= bisection( latitude, longitude, low, high, 270 )
    report( latitude, longitude, winter_solstice, tz )

print( introduction )
z= ''
while z != '0':
    print(" < 1 >  Run program" )
    print(" < 0 >  EXIT" )
    z= input( "CHOICE? " )
    if z == '1':
        find_dates()
