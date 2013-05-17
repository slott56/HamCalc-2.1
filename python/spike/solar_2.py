#!/Library/Frameworks/Python.framework/Versions/3.2/bin/python3.2
"""Solar Calculations.

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

import math
import datetime
import pprint

def solar( phi_o, lambda_o, z_o, date ):
    """Compute position of the sun.

    :param phi_o:
        Latitude of observer in degrees.

    :param lambda_o:
        Longitude of the observer in degrees.

    :param z_o:
        GMT offset of the observer in hours.

    :param date:
        :class:`datetime.datetime` for which the sun's position is requested

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

    # Fractions of a day after midnight
    t = date.time()
    E = t.hour/24 + t.minute/24/60 + t.second/24/60/60

    # Julian Date for date + time - UTC offset
    F = date.toordinal()-JAD_epoch+E-z_o/24

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
    phi_or= math.radians(phi_o)
    W_r = math.acos( math.cos(math.radians(90.833))/(math.cos(phi_or)*math.cos(T_r))-math.tan(phi_or)*math.tan(T_r))
    W = math.degrees( W_r )

    # Solar Noon (LST)
    X = (720 - 4*lambda_o - V + 60*z_o)/1440
    X_h, X_m, X_s = int(X*24), int(X*24*60)%60, int(X*24*60*60)%60
    X_hms= "{0:02.0f}:{1:02.0f}:{2:04.1f}".format(X_h, X_m, X_s)

    # Sunrise Time (LST)
    Y = X-4*W/1440
    Y_h, Y_m, Y_s = int(Y*24), int(Y*24*60)%60, int(Y*24*60*60)%60
    Y_hms= "{0:02.0f}:{1:02.0f}:{2:04.1f}".format(Y_h, Y_m, Y_s)

    # Sunset Time (LST)
    Z = X+4*W/1440
    Z_h, Z_m, Z_s = int(Z*24), int(Z*24*60)%60, int(Z*24*60*60)%60
    Z_hms= "{0:02.0f}:{1:02.0f}:{2:04.1f}".format(Z_h, Z_m, Z_s)

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
    AH_rstar = math.acos(
        (math.sin(phi_or)*math.cos(AD_r)-math.sin(T_r)) / (math.cos(phi_or)*math.sin(AD_r))
    )
    if AC > 0:
        AH = math.degrees(AH_rstar) + 180 % 360
    else:
        AH = (540-math.degrees(AH_rstar)) % 360

    return locals()

if __name__ == "__main__":

    phi_o=38.98 # Latitude
    lambda_o=-76.47 # Longitude
    z_o=-4 # Timezone offset
    date = datetime.datetime( 2013, 5, 1, 0, 6, 0)

    pprint.pprint( solar(phi_o, lambda_o, z_o, date) )
