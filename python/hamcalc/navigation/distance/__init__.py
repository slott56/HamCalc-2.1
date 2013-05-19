"""hamcalc.navigation.distance -- Great Circle Distance Calculation.

Test Case

>>> import hamcalc.math.trig as trig
>>> import hamcalc.navigation.distance as distance
>>> deg = distance.dms_2_deg
>>> lat_1, lon_1 = deg(50, 21, 50), -deg(4, 9, 25)
>>> lat_2, lon_2 = deg(42, 21, 4), -deg(71, 2, 27)
>>> lat_1, lon_1
(50.36388888888889, -4.156944444444444)
>>> lat_2, lon_2
(42.3511111111111, -71.04083333333335)
>>> r, b = distance.range_bearing( lat_1, lon_1, lat_2, lon_2, R=distance.KM )
>>> round(r,0)
5196.0
>>> tuple( int(round(x,0)) for x in distance.deg_2_dms( b ) )
(260, 7, 38)

"""
import math
import hamcalc.math.trig as trig

def dms_2_deg( d, m, s ):
    x = trig.DMS_TUPLE.to_std( (d,m,s) )
    return trig.DEGREE.from_std( x )

def deg_2_dms( d ):
    x = trig.DEGREE.to_std( d )
    return trig.DMS_TUPLE.from_std( x )

# The International Union of Geodesy and Geophysics (IUGG) defined mean radius values
KM= 6371.009 # R_1 in km
MI= 3958.761 # R_1 in mi
NM= 3440.069 # R_1 in nm

def range_bearing( lat_1, lon_1, lat_2, lon_2, R=NM ):
    """Rhumb-line course from ``(lat_1, lon_1)`` to ``(lat_2, lon_2)``.

    :param lat_1: latitude, postive N
    :param lon_1: longitude, positive E
    :param lat_2: latitude, postive N
    :param lon_2: longitude, positive E
    :param R: radius of the earth in appropriate units;
        default is nautical miles.
        Values include :py:data:`KM` for kilometers,
        :py:data:`MI` for statute miles and :py:data:`NM` for nautical miles.

    :returns: 2-tuple of range and bearing from from ``(lat_1, lon_1)`` to ``(lat_2, lon_2)``.

    """
    lat1= math.radians(lat_1)
    lat2= math.radians(lat_2)
    dLat= lat2 - lat1
    dPhi = math.log(math.tan(lat2/2+math.pi/4)/math.tan(lat1/2+math.pi/4))
    if abs(dPhi) < 1.0E-6:
        q= math.cos(lat1)
    else:
        q= dLat/dPhi
    lon1= math.radians(lon_1)
    lon2= math.radians(lon_2)
    dLon = lon2 - lon1
    if abs(dLon) > math.pi:
        dLon = -(2*math.pi-dLon) if dLon > 0 else (2*math.pi+dLon)
    d = math.sqrt(dLat*dLat + q*q*dLon*dLon) * R
    brng= math.atan2(dLon, dPhi)
    theta= math.degrees( brng ) % 360
    return d, theta
