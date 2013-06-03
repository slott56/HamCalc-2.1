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

Solar Position Test Cases
---------------------------

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

Output from this test case.

>>> from hamcalc.navigation.solar import Position_Sun, Eastern
>>> import datetime
>>> phi_o=38.98 # Latitude
>>> lambda_o=-76.47 # Longitude
>>> z_o=-4 # Timezone offset
>>> date = datetime.datetime( 2013, 5, 1, 0, 6, 0, tzinfo=Eastern )
>>> s= Position_Sun( phi_o, lambda_o, date )
>>> round(s.E,6)
0.004167
>>> round(s.F,2)
2456413.67
>>> round(s.G,8)
0.13329694
>>> round(s.I,2)
39.26
>>> round(s.J,2)
5156.09
>>> round(s.K,2)
0.02
>>> round(s.L,1)
1.7
>>> round(s.M,2)
40.96
>>> round(s.N,1)
5157.8
>>> round(s.O,2)
1.01
>>> round(s.P,2)
40.96
>>> round(s.Q,2)
23.44
>>> round(s.R,2)
23.44
>>> round(s.S,2)
38.53
>>> round(s.T,2)
15.11
>>> round(s.U,2)
0.04
>>> round(s.V,2)
2.89
>>> round(s.W,2)
103.76
>>> s.X_hms
'13:02:59.0'
>>> s.Y_hms
'06:07:55.0'
>>> s.Z_hms
'19:58:03.0'
>>> round(s.AA,1)
830.1
>>> round(s.AB,1)
1383.0
>>> round(s.AC,2)
165.75
>>> round(s.AD,2)
124.29
>>> round(s.AE,2)
-34.29
>>> round(s.AF,2)
0.01
>>> round(s.AG,2)
-34.28
>>> round(s.AH,2)
343.29

Equation of Time Test Cases
----------------------------

>>> solar.eot( 73 )
-9.288136257894735
>>> solar.eot( 171 )
-1.3629763831233621
>>> solar.eot( 257 )
4.438308798331203
>>> solar.eot( 354 )
2.3235852575988147

Compared with HamCalc "wobble correction factors"
of 4,8,11 for Jan 1, Jan 10 and Jan 21.

>>> round(solar.eot( 0 ))
-3
>>> round(solar.eot( 9 ))
-7
>>> round(solar.eot( 20 ))
-11

"""
__version__ = "2.1"

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
    E = (t.hour + (t.minute + (t.second+t.microsecond/1000000)/60)/60)/24

    # Julian Date for date + time - UTC offset (if defined)
    utc= 0 if dt.utcoffset() is None else dt.utcoffset()/24
    jad= dt.toordinal()-JAD_epoch+E-utc.total_seconds()/24/60/60
    return jad

def hours_to_h_m_s( h ):
    return int(h*24), int(h*24*60) % 60, int(h*24*60*60) % 60

class Position_Sun:
    """Here's the mapping from cryptical spreadsheet names to real names.

    :E: Time (past local midnight)
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
    def __init__( self, phi_o, lambda_o, date_time_tz, horizon=None ):
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
        """
        if horizon is None: horizon=90.833

        # GMT offset of the observer in hours.
        z_o= date_time_tz.utcoffset().total_seconds()/3600

        # Fractions of a day after midnight
        t = date_time_tz.time()
        self.E = t.hour/24 + t.minute/24/60 + t.second/24/60/60

        # Julian Date for date + time - UTC offset
        self.F = date_time_tz.toordinal()-self.JAD_epoch+self.E-z_o/24

        # Julian Century
        self.G = (self.F-2451545)/36525

        # Geom Mean Long Sun (deg)
        self.I = (280.46646+self.G*(36000.76983+0.0003032*self.G)) % 360
        I_r= math.radians(self.I)

        # Geom Mean Anom Sun (deg)
        self.J = 357.52911+self.G*(35999.05029-0.0001537*self.G)
        J_r= math.radians(self.J)

        # Eccent Earth Orbit
        self.K = 0.016708634-self.G*(0.000042037+0.0000001267*self.G)

        # Sun Eq of Ctr
        self.L = ( math.sin(J_r)*(1.914602-self.G*(0.004817+0.000014*self.G))
         + math.sin(2*J_r)*(0.019993-0.000101*self.G)
         + math.sin(3*J_r)*0.000289 )

        # Sun True Long (deg)
        self.M = self.I + self.L
        M_r = math.radians( self.M )

        # Sun True Anom (deg).
        self.N = self.J + self.L
        N_r = math.radians( self.N )

        # Sun Rad Vector (AUs)
        self.O = (1.000001018*(1-self.K**2))/(1+self.K*math.cos(N_r))

        # Sun App Long (deg)
        self.P = self.M-0.00569-0.00478*math.sin(125.04-1934.136*self.G)
        P_r= math.radians( self.P )

        # Mean Obliq Ecliptic (deg)
        self.Q = 23+(26+((21.448-self.G*(46.815+self.G*(0.00059-self.G*0.001813))))/60)/60

        # Obliq Corr (deg)
        self.R = self.Q+0.00256*math.cos(125.04-1934.136*self.G)
        R_r = math.radians( self.R )

        # Sun Rt Ascen (deg)
        S_r = math.atan2( math.cos(R_r)*math.sin(P_r), math.cos(P_r) )
        self.S = math.degrees( S_r )

        # Sun Declin (deg)
        T_r = math.asin(math.sin(R_r)*math.sin(P_r))
        self.T = math.degrees( T_r )

        # var y
        self.U = math.tan( R_r/2 )**2

        # Eq of Time (minutes)
        V_r = 4*(
            self.U*math.sin(2*I_r) - 2*self.K*math.sin(J_r)
            + 4*self.K*self.U*math.sin(J_r)*math.cos(2*I_r)
            - 0.5*self.U**2*math.sin(4*I_r)
            - 1.25*self.K**2*math.sin(2*J_r)
            )
        self.V = math.degrees( V_r )

        # HA Sunrise (deg)
        # 90.833 is sun just below the horizon.
        # Other values can be used for various definitions of twilight.
        phi_or= math.radians(phi_o)

        # Original.
        W_r = math.acos(
            math.cos(math.radians(horizon)) / (math.cos(phi_or)*math.cos(T_r))
            - math.tan(phi_or)*math.tan(T_r)
                )
        self.W = math.degrees( W_r )

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
        self.X = (720 - 4*lambda_o - self.V + 60*z_o)/1440
        self.X_h, self.X_m, self.X_s = hours_to_h_m_s(self.X)
        self.X_hms= "{0:02.0f}:{1:02.0f}:{2:04.1f}".format(*hours_to_h_m_s(self.X))

        # Sunrise Time (LST)
        self.Y = self.X-4*self.W/1440
        self.Y_h, self.Y_m, self.Y_s = hours_to_h_m_s(self.Y)
        self.Y_hms= "{0:02.0f}:{1:02.0f}:{2:04.1f}".format(*hours_to_h_m_s(self.Y))

        # Sunset Time (LST)
        self.Z = self.X+4*self.W/1440
        self.Z_h, self.Z_m, self.Z_s = hours_to_h_m_s(self.Z)
        self.Z_hms= "{0:02.0f}:{1:02.0f}:{2:04.1f}".format(*hours_to_h_m_s(self.Z))

        # Sunlight Duration (minutes)
        self.AA = 8*self.W

        # True Solar Time (min).
        # Requires the time-of-day offset from the Julian date.
        self.AB= (1440*self.E + self.V + 4*lambda_o - 60*z_o) % 1440

        # Hour Angle (deg).
        if self.AB/4 < 0:
            self.AC = self.AB/4 + 180
        else:
            self.AC = self.AB/4 - 180
        AC_r = math.radians(self.AC)

        # Solar Zenith Angle (deg).
        AD_r = math.acos( math.sin(phi_or)*math.sin(T_r) + math.cos(phi_or)*math.cos(T_r)*math.cos(AC_r) )
        self.AD = math.degrees( AD_r )

        # Solar Elevation Angle (deg).
        self.AE = 90-self.AD
        AE_r = math.radians(self.AE)

        # Approx Atmospheric Refraction (deg)
        if 85 < self.AE:
            self.AF= 0
        elif 5 < self.AE <= 85:
            self.AF = (58.1/math.tan(AE_r) - 0.07/math.tan(AE_r)**3 + 0.000086/math.tan(AE_r)**5) / 3600
        elif -0.575 < self.AE <=5 :
            self.AF = 1735+self.AE*(-518.2+self.AE*(103.4+self.AE*(-12.79+self.AE*0.711))) / 3600
        else: # AE < -0.575, i.e., just below the horizon.
            self.AF = -20.772/math.tan(AE_r) / 3600

        # Solar Elevation corrected for atm refraction (deg).
        self.AG = self.AE+self.AF

        # Solar Azimuth Angle (deg cw from N)
        AH_a= (
            (math.sin(phi_or)*math.cos(AD_r)-math.sin(T_r)) / (math.cos(phi_or)*math.sin(AD_r))
        )
        if AH_a > 1: AH_rstar= 0
        elif AH_a < -1: AH_rstar= math.pi
        else: AH_rstar = math.acos( AH_a )
        if self.AC > 0:
            self.AH = math.degrees(AH_rstar) + 180 % 360
        else:
            self.AH = (540-math.degrees(AH_rstar)) % 360

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

    :returns: Tuple of :class:`datetime.datetime` objects for rise, noon transit
        and set. These are timezone aware and will have the same timezone as
        the input datetime.
    """
    date= date_time_tz.replace( hour=0, minute=0, second=0, microsecond=0 )
    sun= Position_Sun( lat, lon, date, horizon )

    transit= date + datetime.timedelta( days=sun.X )
    rise= date + datetime.timedelta( days=sun.Y )
    set= date + datetime.timedelta( days=sun.Z )

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

    :returns: Tuple of :class:`datetime.datetime` objects for rise, noon transit
        and set. These are timezone aware and will have the same timezone as
        the input datetime.
    """
    sun= Position_Sun( lat, lon, date_time )
    return sun.AH, sun.AE

def eot(d):
    """An approximation for the Equation of Time.

    See http://en.wikipedia.org/wiki/Equation_of_time

     A positive value of the equation of time implies that a sundial is ahead of a clock.

    :param d: Day of the year, zero is  January 1.
        Use ``some_date.toordinal()-some_date.replace(month=1,day=1).toordinal()``
    :returns: Equation of Time offset for this date.
    """
    W = 360/365.24
    A = W*(d+10)
    B = A +1.914*(math.sin(math.radians(W*(d-2))))
    C = (A-math.degrees(math.atan2(math.tan(math.radians(B)),math.cos(math.radians(23.44)))))/180
    return 720*(C-int(C+.5))
