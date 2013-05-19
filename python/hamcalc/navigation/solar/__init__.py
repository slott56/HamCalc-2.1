"""hamcalc.navigation.solar -- Sunrise, Transit and Sunset.

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
:mod:`hamcalc.navigation.solar.timezone` module.

It's quite easy to add timezones to cover other historical periods or
other places on earth.

Test Case
----------

>>> import hamcalc.navigation.solar as solar
>>> import datetime
>>> today= datetime.datetime( 2013, 5, 13, tzinfo=solar.Eastern )
>>> rise, transit, set = solar.rise_transit_set( 38.98, -76.47, today )
>>> rise.isoformat()
'2013-05-13T05:55:00.457654-04:00'
>>> transit.isoformat()
'2013-05-13T13:02:13.475578-04:00'
>>> set.isoformat()
'2013-05-13T20:09:26.493502-04:00'
>>> rise.astimezone(solar.Eastern).isoformat()
'2013-05-13T05:55:00.457654-04:00'
>>> set.astimezone(solar.Eastern).isoformat()
'2013-05-13T20:09:26.493502-04:00'

>>> solar.azimuth_elevation( 38.98, -76.47, transit )
(179.99635135849053, 69.56582340941506)
>>> solar.azimuth_elevation( 38.98, -76.47, rise )
(65.23706511941509, -0.7937072477381264)
>>> solar.azimuth_elevation( 38.98, -76.47, set )
(294.86842169825667, -0.6953559721037266)

From other apps and web sites:

    At 13:00, Azimuth is 178.4, Elevation is 69.6

    Sunrise azimuth is 65.06, when measured from N.

    Sunset azimuth is 294.62, when measured from N.

    The center is 179.84 when measured from N (-0.16 from S).

Other Horizons; e.g., Nautical Twilight or Astronomical Twilight.

>>> rise, transit, set = solar.rise_transit_set( 38.98, -76.47, today, horizon=90+12 ) # Nautical
>>> rise.isoformat()
'2013-05-13T04:48:24.304646-04:00'
>>> set.isoformat()
'2013-05-13T21:16:02.646510-04:00'

From the USNO web page, the following two official times are given
for nautical twilight on May 13, 2013: 03:48 20:17

Calculation Details
---------------------

http://www.esrl.noaa.gov/gmd/grad/solcalc/calcdetails.html

Inputs::

    phi_o=38.98 # Latitude
    lambda_o=-76.47 # Longitude
    z_o=-4 # Timezone offset
    date = datetime.datetime( 2013, 5, 1, 0, 6, 0)

Row from the spreadsheet. Columns A through AH (skipping H).

::

    D           E       F           G               I       J       K
    5/1/2013	0:06:00	2456413.67	0.13329694		39.26	5156.09	0.02

    L   M       N       O       P       Q       R       S       T
    1.7	40.96	5157.8	1.01	40.96	23.44	23.44	38.54	15.11

    U       V       W       X           Y       Z           AA      AB
    0.04	2.88	103.76	13:03:00	6:07:57	19:58:03	830.1	1383

    AC      AD      AE      AF      AG      AH
    165.75	124.29	-34.29	0.01	-34.28	343.29

Output from this function; it includes columns F to AH, plus
a few other values.

::

    {'AA': 830.1189163955589,
     'AB': 1383.0077155592248,
     'AC': 165.7519288898062,
     'AC_r': 2.8929169006586277,
     'AD': 124.28846181320384,
     'AD_r': 2.1692428808796484,
     'AE': -34.28846181320384,
     'AE_r': -0.5984465540847519,
     'AF': 0.008462163764385251,
     'AG': -34.27999964943945,
     'AH': 343.2865712316368,
     'AH_rstar': 2.8498882922843145,
     'E': 0.004166666666666667,
     'F': 2456413.6708333334,
     'G': 0.1332969427332894,
     'I': 39.25901977112244,
     'I_r': 0.6851991561116372,
     'J': 5156.092452227982,
     'JAD_epoch': -1721424.5,
     'J_r': 89.99078982860672,
     'K': 0.016703028345203225,
     'L': 1.7030570397145302,
     'M': 40.96207681083697,
     'M_r': 0.7149231088039236,
     'N': 5157.795509267697,
     'N_r': 90.02051378129902,
     'O': 1.007569899030823,
     'P': 40.95990612522424,
     'P_r': 0.7148852231929558,
     'Q': 23.43755769373243,
     'R': 23.43929004746131,
     'R_r': 0.4090927856581378,
     'S': 38.534815164640406,
     'S_r': 0.6725594012704159,
     'T': 15.11487444281024,
     'T_r': 0.26380432505258206,
     'U': 0.043034525256302164,
     'V': 2.8877155592249477,
     'V_r': 0.05040014436954465,
     'W': 103.76486454944487,
     'W_r': 1.8110385342737552,
     'X': 0.5437446419727605,
     'X_h': 13,
     'X_hms': '13:02:59.0',
     'X_m': 2,
     'X_s': 59,
     'Y': 0.25550890711319146,
     'Y_h': 6,
     'Y_hms': '06:07:55.0',
     'Y_m': 7,
     'Y_s': 55,
     'Z': 0.8319803768323295,
     'Z_h': 19,
     'Z_hms': '19:58:03.0',
     'Z_m': 58,
     'Z_s': 3,
     'date': datetime.datetime(2013, 5, 1, 0, 6),
     'lambda_o': -76.47,
     'phi_o': 38.98,
     'phi_or': 0.6803293424273896,
     't': datetime.time(0, 6),
     'z_o': -4}

"""
import datetime
from hamcalc.lib import AttrDict
from hamcalc.navigation.solar.timezone import utc, Newfoundland, Atlantic, \
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
    E = (t.hour + (t.minute + (t.second+t.micro/1000000)/60)/60)/24

    # Julian Date for date + time - UTC offset (if defined)
    utc= 0 if dt.utcoffset() is None else dt.utcoffset()/24
    jad= dt.toordinal()-JAD_epoch+E-utc
    return jad

def hours_to_h_m_s( h ):
    return int(h*24), int(h*24*60) % 60, int(h*24*60*60) % 60

def solar( phi_o, lambda_o, date_time_tz, horizon=None ):
    """Compute position of the sun.

    :param phi_o:
        Latitude of observer in degrees.

    :param lambda_o:
        Longitude of the observer in degrees.

    :param date_time_tz:
        :class:`datetime.datetime` for which the sun's position is requested.
        This must include tzinfo for the observer's timezone.

    :param horizon:
        The horizon angle from the zenith. Default is 90.833.
        Other values can be used.
        -   Astronomical: 108°; 18° below horizon
        -   Nautical: 102°; 12° below horizon
        -   Civil: 96°; 6° below horizon

    :return: A dictionary with **all** the intermediate results.
        Of all these results, a few are more interesting than
        others.

        Here's the mapping from cryptical spreadsheet names to real names.

        :F: Julian Day
        :G: Julian Century
        :I:	Geom Mean Long Sun (deg)
        :J:	Geom Mean Anom Sun (deg)
        :K:	Eccent Earth Orbit
        :L:	Sun Eq of Ctr
        :M:	Sun True Long (deg)
        :N:	Sun True Anom (deg)
        :O:	Sun Rad Vector (AUs)
        :P:	Sun App Long (deg)
        :Q:	Mean Obliq Ecliptic (deg)
        :R:	Obliq Corr (deg)
        :S:	Sun Rt Ascen (deg)
        :T:	Sun Declin (deg)
        :U:	var y
        :V:	Eq of Time (minutes)
        :W:	HA Sunrise (deg)
        :X:	Solar Noon (LST)
        :Y:	Sunrise Time (LST)
        :Z:	Sunset Time (LST)
        :AA:	Sunlight Duration (minutes)
        :AB:	True Solar Time (min)
        :AC:	Hour Angle (deg)
        :AD:	Solar Zenith Angle (deg)
        :AE:	Solar Elevation Angle (deg)
        :AF:	Approx Atmospheric Refraction (deg)
        :AG:	Solar Elevation corrected for atm refraction (deg)
        :AH:	Solar Azimuth Angle (deg cw from N)

    """
    JAD_epoch= -1721424.5 # Julian Astronomical Date epoch.

    if horizon is None: horizon=90.833

    # GMT offset of the observer in hours.
    z_o= date_time_tz.utcoffset().total_seconds()/3600

    # Fractions of a day after midnight
    t = date_time_tz.time()
    E = t.hour/24 + t.minute/24/60 + t.second/24/60/60

    # Julian Date for date + time - UTC offset
    F = date_time_tz.toordinal()-JAD_epoch+E-z_o/24

    # Julian Century
    G = (F-2451545)/36525

    # Geom Mean Long Sun (deg)
    I = (280.46646+G*(36000.76983+0.0003032*G)) % 360
    I_r= math.radians(I)

    # Geom Mean Anom Sun (deg)
    J = 357.52911+G*(35999.05029-0.0001537*G)
    J_r= math.radians(J)

    # Eccent Earth Orbit
    K = 0.016708634-G*(0.000042037+0.0000001267*G)

    # Sun Eq of Ctr
    L = ( math.sin(J_r)*(1.914602-G*(0.004817+0.000014*G))
     + math.sin(2*J_r)*(0.019993-0.000101*G)
     + math.sin(3*J_r)*0.000289 )

    # Sun True Long (deg)
    M = I + L
    M_r = math.radians( M )

    # Sun True Anom (deg).
    N = J + L
    N_r = math.radians( N )

    # Sun Rad Vector (AUs)
    O = (1.000001018*(1-K**2))/(1+K*math.cos(N_r))

    # Sun App Long (deg)
    P = M-0.00569-0.00478*math.sin(125.04-1934.136*G)
    P_r= math.radians( P )

    # Mean Obliq Ecliptic (deg)
    Q = 23+(26+((21.448-G*(46.815+G*(0.00059-G*0.001813))))/60)/60

    # Obliq Corr (deg)
    R = Q+0.00256*math.cos(125.04-1934.136*G)
    R_r = math.radians( R )

    # Sun Rt Ascen (deg)
    S_r = math.atan2( math.cos(R_r)*math.sin(P_r), math.cos(P_r) )
    S = math.degrees( S_r )

    # Sun Declin (deg)
    T_r = math.asin(math.sin(R_r)*math.sin(P_r))
    T = math.degrees( T_r )

    # var y
    U = math.tan( R_r/2 )**2

    # Eq of Time (minutes)
    V_r = 4*(
        U*math.sin(2*I_r) - 2*K*math.sin(J_r)
        + 4*K*U*math.sin(J_r)*math.cos(2*I_r)
        - 0.5*U**2*math.sin(4*I_r)
        - 1.25*K**2*math.sin(2*J_r)
        )
    V = math.degrees( V_r )

    # HA Sunrise (deg)
    # 90.833 is sun just below the horizon.
    # Can other values can be used for various definitions of twilight?
    phi_or= math.radians(phi_o)

    # Original.
    W_r = math.acos(
        math.cos(math.radians(horizon)) / (math.cos(phi_or)*math.cos(T_r))
        - math.tan(phi_or)*math.tan(T_r)
            )
    W = math.degrees( W_r )

    # Alternate.
#     W_a= (math.sin(math.radians(90-horizon)) - math.sin(phi_or)*math.sin(T_r)) / (math.cos(phi_or)*math.cos(T_r))
#     if W_a > 1:
#         W_r_alt = 0
#     elif W_a < -1:
#         W_r_alt = math.pi
#     else:
#         W_r_alt = math.acos( W_a )
#     W = math.degrees( W_r_alt )

    # Solar Noon (LST)
    X = (720 - 4*lambda_o - V + 60*z_o)/1440
    X_h, X_m, X_s = hours_to_h_m_s(X)
    X_hms= "{0:02.0f}:{1:02.0f}:{2:04.1f}".format(*hours_to_h_m_s(X))

    # Sunrise Time (LST)
    Y = X-4*W/1440
    Y_h, Y_m, Y_s = hours_to_h_m_s(Y)
    Y_hms= "{0:02.0f}:{1:02.0f}:{2:04.1f}".format(*hours_to_h_m_s(Y))

    # Sunset Time (LST)
    Z = X+4*W/1440
    Z_h, Z_m, Z_s = hours_to_h_m_s(Z)
    Z_hms= "{0:02.0f}:{1:02.0f}:{2:04.1f}".format(*hours_to_h_m_s(Z))

    # Sunlight Duration (minutes)
    AA = 8*W

    # True Solar Time (min).
    # Requires the time-of-day offset from the Julian date.
    AB= (1440*E + V + 4*lambda_o - 60*z_o) % 1440

    # Hour Angle (deg).
    if AB/4 < 0:
        AC = AB/4 + 180
    else:
        AC = AB/4 - 180
    AC_r = math.radians(AC)

    # Solar Zenith Angle (deg).
    AD_r = math.acos( math.sin(phi_or)*math.sin(T_r) + math.cos(phi_or)*math.cos(T_r)*math.cos(AC_r) )
    AD = math.degrees( AD_r )

    # Solar Elevation Angle (deg).
    AE = 90-AD
    AE_r = math.radians(AE)

    # Approx Atmospheric Refraction (deg)
    if 85 < AE:
        AF= 0
    elif 5 < AE <= 85:
        AF = (58.1/math.tan(AE_r) - 0.07/math.tan(AE_r)**3 + 0.000086/math.tan(AE_r)**5) / 3600
    elif -0.575 < AE <=5 :
        AF = 1735+AE*(-518.2+AE*(103.4+AE*(-12.79+AE*0.711))) / 3600
    else: # AE < -0.575, i.e., just below the horizon.
        AF = -20.772/math.tan(AE_r) / 3600

    # Solar Elevation corrected for atm refraction (deg).
    AG = AE+AF

    # Solar Azimuth Angle (deg cw from N)
    AH_a= (
        (math.sin(phi_or)*math.cos(AD_r)-math.sin(T_r)) / (math.cos(phi_or)*math.sin(AD_r))
    )
    if AH_a > 1: AH_rstar= 0
    elif AH_a < -1: AH_rstar= math.pi
    else: AH_rstar = math.acos( AH_a )
    if AC > 0:
        AH = math.degrees(AH_rstar) + 180 % 360
    else:
        AH = (540-math.degrees(AH_rstar)) % 360

    return locals()

def rise_transit_set( lat, lon, date_time_tz, horizon=None ):
    """Compute rise time, noon transit time and set time for the sun.

    :param lat:
        Latitude of observer in degrees.

    :param lon:
        Longitude of the observer in degrees.

    :param date_time_tz:
        :class:`datetime.datetime` for which the sun's position is requested.
        This must include tzinfo for the observer's timezone.

    :param horizon:
        The horizon angle from the zenith. Default is 90.833.
        Other values can be used.
        -   Astronomical: 108°; 18° below horizon
        -   Nautical: 102°; 12° below horizon
        -   Civil: 96°; 6° below horizon

    :returns: Tuple of :class:`datetime.datetime` objects for rise, noon transit and set. These are timezone aware and will have the same timezone as
    the input datetime.
    """
    date= date_time_tz.replace( hour=0, minute=0, second=0, microsecond=0 )
    s= AttrDict( solar( lat, lon, date, horizon ) )

    transit= date + datetime.timedelta( days=s.X )
    rise= date + datetime.timedelta( days=s.Y )
    set= date + datetime.timedelta( days=s.Z )

    return rise, transit, set

def azimuth_elevation( lat, lon, date_time ):
    """Compute azimuth and elevation of the sun at a given point in time.

    :param lat:
        Latitude of observer in degrees.

    :param lon:
        Longitude of the observer in degrees.

    :param date_time_tz:
        :class:`datetime.datetime` for which the sun's position is requested.
        This must include tzinfo for the observer's timezone.

    :returns: Tuple of :class:`datetime.datetime` objects for rise, noon transit and set. These are timezone aware and will have the same timezone as
    the input datetime.
    """
    s= AttrDict( solar( lat, lon, date_time ) )
    return s.AH, s.AE
