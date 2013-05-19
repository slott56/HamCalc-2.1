#!/Library/Frameworks/Python.framework/Versions/3.2/bin/python3.2
"""hamcalc.navigation.sunrise -- Sunrise, Transit and Sunset.

See "Sunrise Equation" in Wikipedia. http://en.wikipedia.org/wiki/Sunrise_equation

This is the calculation of the Julian Astronomical Dates
of the transit, rise and set of the sun at a given latitude
and longitude near a given date.

Julian Astronomical Dates
--------------------------

Julian astronomical day calculations from Dershowitz and Reingold.
This is Herschel and Scaliger julian astronomical day calendar.

See http://en.wikipedia.org/wiki/Julian_day

See Dershowitz, Nachum and Edward M. Reingold.  *Calendrical Calculations*. Cambridge University Press. 1997.

http://emr.cs.uiuc.edu/home/reingold/calendar-book/index.html

Python's :mod:`datetime` module uses The Reingold-Dershowitz *rata die*
system.

http://en.wikipedia.org/wiki/Rata_Die

The conversion to Julian Astronomical Dates is ``-1721424.5``,
the :data:`JAD_epoch` defined in this module.

Local Time and North American TimeZones
-----------------------------------------

The sunrise and sunset times are in UTC.  Localtime offsets need to be applied,
based on local knowledge of timezones and Daylight Savings Time
to get to proper local times.

For this, timezones are imported from the
:mod:`hamcalc.navigation.sunrise.timezone` module.

It's quite easy to add timezones to cover other historical periods or
other places on earth.

Test Case
----------

>>> import hamcalc.navigation.sunrise as sunrise
>>> import datetime
>>> today= datetime.datetime( 2013, 5, 13 )
>>> rise, transit, set = sunrise.rise_transit_set( 38.98, 76.47, today.date() )
>>> rise.isoformat()
'2013-05-12T09:56:59.724521+00:00'
>>> transit.isoformat()
'2013-05-12T17:03:35.085187+00:00'
>>> set.isoformat()
'2013-05-13T00:10:10.445854+00:00'
>>> rise.astimezone(sunrise.Eastern).isoformat()
'2013-05-12T05:56:59.724521-04:00'
>>> set.astimezone(sunrise.Eastern).isoformat()
'2013-05-12T20:10:10.445854-04:00'

>>> sunrise.elevation( 38.98, 76.47, today.date() )
69.27142385947161

Here's a back-door way to get to the Equation of Time.
Determine the offset from local apparent noon, which should be due south.

>>> tt= transit.astimezone(sunrise.Eastern).timetz()
>>> tt.hour, tt.minute, tt.second
(13, 3, 35)
>>> az_hours = tt.minute/60 + tt.second/3600
>>> 180-(az_hours)*15
179.10416666666666

From other apps and web sites:

    At 13:00, Azimuth is 178.4, Elevation is 69.6

    Sunrise azimuth is 65.06, when measured from N.

    Sunset azimuth is 294.62, when measured from N.

    The center is 179.84 when measured from N (-0.16 from S).

"""
import datetime
from hamcalc.navigation.sunrise.timezone import utc, Newfoundland, Atlantic, \
    Eastern, Central, Mountain, Pacific
import math

JAD_epoch= -1721424.5 # Julian Astronomical Date epoch.

def jad_to_datetime( jad ):
    """Convert a Julian Astronomical Date into a datetime
    object.

    :param jad: floating point JAD.
    :returns: :class:`datetime.datetime` object with
        date, time and UTC timezone.
    """
    ordinal= jad+JAD_epoch
    date= datetime.date.fromordinal( int(ordinal) )
    tm= (ordinal-int(ordinal))*24*60*60 # in seconds
    micro= int((tm-int(tm))*1000000)
    sec= int(tm % 60)
    min= int((tm // 60) % 60)
    hr= int(tm // 3600)
    time= datetime.time( hr, min, sec, micro, utc )
    return datetime.datetime.combine( date, time )

def datetime_to_jad( dt ):
    """Convert a datetime into a Julian Astronomical Date.

    :param dt: :class:`datetime.datetime` object with
        date, time and UTC timezone.
    :returns: floating point JAD
    """
    # Fractions of a day after midnight
    t = dt.time()
    E = t.hour/24 + t.minute/24/60 + t.second/24/60/60

    # Julian Date for date + time - UTC offset (if defined)
    utc= 0 if dt.utcoffset() is None else dt.utcoffset()/24
    jad= dt.toordinal()-JAD_epoch+E-utc
    return jad

def solar_position( lat, lon, J_star ):
    """Compute solar position for lat, lon and date.

    :param lat: Latitude in degrees, North is positive.
    :param lon: Longitude in degrees, West is positive.
    :param J_star: Julian Astronomical Date
    :returns: dictionary with M, M_r, lambda\_, lambda_r, delta, delta_r, omega_0, omega_0r as keys
    """
    # Solar Mean Anomaly
    M = (357.5291 + 0.98560028*(J_star-2451545)) % 360
    M_r= math.radians(M)
    # Equation of Center
    C = 1.9148*math.sin(M_r)+0.0200*math.sin(2*M_r)+0.0003*math.sin(3*M_r)
    # Ecliptic Longitude
    lambda_ = (M + 102.9372 + C + 180) % 360
    lambda_r= math.radians( lambda_ )
    # Equatorial Obliquity
    eps= math.radians(23.45)
    # Declination of Sun
    delta_r= math.asin( math.sin(lambda_r) * math.sin(eps) )
    delta= math.degrees( delta_r )
    # Right Ascension of the Sun
    alpha_r= math.atan( math.tan(lambda_r) * math.cos(eps) )
    alpha= math.degrees( alpha_r )
    # Hour Angle
    num= math.sin(math.radians(-0.83)) - math.sin(math.radians(lat))*math.sin(delta_r)
    den= math.cos(math.radians(lat))*math.cos(delta_r)
    omega_0r= math.acos( num/den )
    omega_0= math.degrees( omega_0r )

    return dict(
        M= M, M_r= M_r,
        lambda_= lambda_, lambda_r= lambda_r,
        delta= delta, delta_r= delta_r,
        alpha= alpha, alpha_r= alpha_r,
        omega_0= omega_0, omega_0r= omega_0r, )

def transit_details( lat, lon, date ):
    """Compute sunrise, transit and sunset; returns
    :class:`datetime.datetime` objects with date, time and UTC timezone.

    To convert to a local time, use this.

    ::

        rise_local= rise_utc.astimezone(sunrise.Eastern)

    :param lat: Latitude in degrees, North is positive.
    :param lon: Longitude in degrees, West is positive.
    :param date: Datetime.date object
    :returns: dictionary with M, M_r, lambda\_, lambda_r, delta, delta_r, omega_0, omega_0r, and J_transit as keys
    """
    # Calculate current Julian Cycle
    J_date= date.toordinal()-JAD_epoch
    n_star= J_date - 2451545.0009 - lon/360
    n = int( n_star + .5 ) # Julian Cycle since Jan 1, 2000.
    # Approximate Solar Noon
    J_star= 2451545.0009 + lon/360 + n

    s= solar_position( lat, lon, J_star )
    M_r= s['M_r']
    lambda_r= s['lambda_r']

    # Solar Transit offset from Approximate Solar Noon
    J_transit = J_star + 0.0053*math.sin(M_r) - 0.0069*math.sin(2*lambda_r)
    s['J_transit']= J_transit
    s['n']= n
    return s

def rise_transit_set( lat, lon, date ):
    """Compute sunrise, transit and sunset, returns
    :class:`datetime.datetime` objects with date, time and UTC timezone.

    To convert to a local time, use this.

    ::

        rise_local= rise_utc.astimezone(sunrise.Eastern)

    :param lat: Latitude in degrees, North is positive.
    :param lon: Longitude in degrees, West is positive.
    :param date: Datetime.date object
    :returns: Datetime.datetime objects for Sunrise, Transit and Sunset.
        These are in UTC.
    """
    s= transit_details( lat, lon, date )
    omega_0= s['omega_0']
    M_r= s['M_r']
    lambda_r= s['lambda_r']
    J_transit= s['J_transit']
    n= s['n']

    # Sunset and Sunrise
    J_set = 2451545.0009 + (omega_0+lon)/360 + n + 0.0053*math.sin(M_r) - 0.0069*math.sin(2*lambda_r)
    J_rise = J_transit - (J_set - J_transit)

    # Convert to datetime.datetime
    return jad_to_datetime( J_rise ), jad_to_datetime( J_transit ), jad_to_datetime( J_set )

def elevation( lat, lon, date ):
    """Compute elevation at transit.

    :param lat: Latitude in degrees, North is positive.
    :param lon: Longitude in degrees, West is positive.
    :param date: Datetime.date object
    :returns: elevation.
    """
    # Get exact transit time and approximte solar location
    s= transit_details( lat, lon, date )
    delta_r= s['delta_r']
    omega_0r= s['omega_0r']

    # This calculation is deeply suspicious.
    #a_r = math.asin( math.sin(math.radians(lat))*math.sin(delta_r)
    #    + math.cos(math.radians(lat))*math.cos(delta_r)*math.cos(omega_0r) )
    #a= math.degrees(a_r)

    # This may not be correct either.
    #A_r = math.atan2( math.sin(omega_0r),
    #    math.cos(omega_0r)*math.sin(lat) - math.tan(delta_r)*math.cos(lat) )
    #A= math.degrees( A_r )

    # HamCalc Version of Elevation from Declination.
    delta= s['delta']
    if lat < delta:
        a = 90 - (delta-lat)
    else:
        a = 90 - (lat-delta)

    return a
