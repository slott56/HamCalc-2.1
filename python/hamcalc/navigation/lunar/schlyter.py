"""hamcalc.navigation.lunar -- Position of the moon.

See http://www.stjarnhimlen.se/comp/ppcomp.html

http://www.stjarnhimlen.se/comp/tutorial.html

This is an implementation based on the outstandingly detailed pair of
web pages. One has the complete theoretical explanation, the other
has a detailed calculation.

Test Cases

>>> import datetime
>>> import hamcalc.navigation.lunar.schlyter as lunar
>>> today= datetime.datetime( 1990, 4, 19, tzinfo=lunar.utc )
>>> jad= lunar.datetime_to_jad( today )
>>> jad
2448000.5
>>> jad - 2451543.5
-3543.0

>>> s= lunar.Position_Sun( jad )
>>> round(s.w,4)
282.7735
>>> round(s.e,6)
0.016713
>>> round(s.M,4)
104.0653
>>> round(s.L,4)
26.8388
>>> round( lunar.Orbital_Elements.ecl( jad ), 4 )
23.4406
>>> round( s.E, 4 )
104.9904
>>> round( s.x, 6 )
-0.27537
>>> round( s.y, 6 )
0.965834
>>> round( s.r, 6 )
1.004323
>>> round( s.v, 4 )
105.9134
>>> round( s.x_s, 6 )
0.881048
>>> round( s.y_s, 6 )
0.482099
>>> round( s.z_s, 6 )
0
>>> round( s.x_e, 6 )
0.881048
>>> round( s.y_e, 6 )
0.442313
>>> round( s.z_e, 6 )
0.191778
>>> az, alt = s.local_az_alt( 60, 15, 0 )
>>> round(s.LST,5)
14.78926
>>> round(s.HA,4)
195.1808
>>> round(az,4)
15.6767
>>> round(alt,4)
-17.957

>>> RA, Decl= lunar.RA_Decl_sun( jad )
>>> round( RA, 4 )
26.6581
>>> round( Decl, 4 )
11.0084

>>> m= lunar.Position_Moon( jad )
>>> round(m.N,4)
312.7381
>>> round(m.i,4)
5.1454
>>> round(m.w,4)
95.7454
>>> round(m.a,4)
60.2666
>>> round(m.e,6)
0.0549
>>> round(m.M,4)
266.0954
>>> round(m.E,4)
262.9735
>>> round(m.x,5)
-10.68099
>>> round(m.y,5)
-59.72377
>>> round(m.r,5)
60.67134
>>> round(m.v,4)
259.8604
>>> round(m.M_s,4)
104.0653
>>> round(m.M_m,4)
266.0954
>>> round(m.L_s,4)
26.8388
>>> round(m.L_m,4)
314.5789
>>> round(m.D,4)
287.7401
>>> round(m.F,4)
1.8408
>>> round(m.P_long,4)
-1.4132
>>> round(m.P_lat,4)
-0.1919
>>> round(m.P_r,4)
0.0066
>>> round(m.x_m,5)
37.65311
>>> round(m.y_m,5)
-47.57185
>>> round(m.z_m,5)
-0.41689
>>> round(m.lon_ecl, 4)
306.9484
>>> round(m.lat_ecl, 4)
-0.5856
>>> round(m.r_ecl, 4)
60.6779
>>> round(m.RA, 4 )
309.5011
>>> round(m.Decl, 4 )
-19.1032

>>> az, alt = m.local_az_alt( 60, 15, 0 )
>>> round(m.LST,5)
14.78926
>>> round(m.HA,4)
272.3377
>>> round(az,4)
101.7868
>>> round(alt,4)
-16.2275
>>> round(m.alt_geoc,4)
-15.3167
>>> round(m.alt_topoc,4)
-16.2275

"""
__version__ = "2.1"

from hamcalc.navigation.solar import jad_to_datetime, datetime_to_jad, utc
from collections import namedtuple
import math

class Orbital_Elements:
    """Abstract base class for Sun and Moon positions."""
    def __init__( self, jad ):
        """Create orbital elements.

        A subclass will extend this as follows::

            super().__init__( self, jad )
            self.N = longitude of the ascending node
            self.i = inclination to the ecliptic
            self.w = argument of perihelion
            self.a = semi-major axis, or mean distance from Sun
            self.e = eccentricity
            self.M = mean anomaly
            self.related()

        :param jad: Julian Astronomical Day.
        """
        self.d= jad - 2451543.5
    def related( self ):
        """Derive additional orbital elements.

        :w1: longitude of perihelion
        :L:  mean longitude
        :q:  perihelion distance
        :Q:  aphelion distance
        :P:  orbital period (years if a is in AU, astronomical units)
        """
        self.w1 = (self.N + self.w) % 360   # longitude of perihelion
        self.L  = (self.M + self.w1) % 360  # mean longitude
        self.q  = self.a*(1-self.e) # perihelion distance
        self.Q  = self.a*(1+self.e) # aphelion distance
        self.P  = self.a**1.5 # orbital period (years if a is in AU, astronomical units)
        # self.T  = Epoch_of_M - (M(deg)/360_deg) / P  = time of perihelion

    def _az_alt( self, lat, lon, utc_offset, sun ):
        """Azimuth and Elevation come from Hour Angle which comes from LST.
        Starts with RA and Decl. Computes az and alt.

        ::

            HA = LST - RA
            x = cos(HA) * cos(Decl)
            y = sin(HA) * cos(Decl)
            z = sin(Decl)

            xhor = x * sin(lat) - z * cos(lat)
            yhor = y
            zhor = x * cos(lat) + z * sin(lat)

            az  = atan2( yhor, xhor ) + 180_degrees
            alt = asin( zhor ) = atan2( zhor, sqrt(xhor*xhor+yhor*yhor) )

        :param lat: latitude of observer
        :param lon: longiude of observer
        :param utc_offset: UTC time-of-day offset of observer, in hours.
        :param sun: An instance of :class:`Position_Sun` or ``self``,
            if this is the :class:`Position_Sun`  subclass itself.
            This provides the local solar longitude for LST offset.
        """
        # Sun's Mean Longitude, L, gives us GMT at midnight.
        # GMST0 = (L + 180)/15
        GMST0 = ((sun.L+180)/15) % 24

        # Local Sidereal Time = GMST0 + UT + LON/15
        self.LST = GMST0 + utc_offset + lon/15

        # Hour Angle (in degrees) = 15*(LST - RA (in hours))
        self.HA = (15*(self.LST - self.RA/15)) % 360

        # celestial rectangular (x,y,z) coordinate
        x = math.cos(math.radians(self.HA)) * math.cos(math.radians(self.Decl))
        y = math.sin(math.radians(self.HA)) * math.cos(math.radians(self.Decl))
        z = math.sin(math.radians(self.Decl))

        # rotate this x,y,z system along the Y axis
        xhor = x*math.sin(math.radians(lat)) - z*math.cos(math.radians(lat))
        yhor = y
        zhor = x*math.cos(math.radians(lat)) + z*math.sin(math.radians(lat))

        self.azimuth  = math.degrees( math.atan2( yhor, xhor ) ) + 180
        self.altitude = math.degrees( math.atan2( zhor, math.sqrt(xhor**2+yhor**2) ) )

        return self.azimuth, self.altitude
    @staticmethod
    def ecl( jad ):
        """Compute the obliquity of the ecliptic."""
        d = jad - 2451543.5
        return 23.4393 - 3.563E-7*d

class Position_Moon( Orbital_Elements ):
    """Position of the Moon on a given date."""
    def __init__( self, jad ):
        """Create orbital elements and compute position of the
        moon. This includes the largest perturbations.

        :param jad: Julian Astronomical Day.
        """
        super().__init__( jad )
        d= self.d
        self.N = (125.1228 - 0.0529538083*d) % 360
        self.i = 5.1454
        self.w = (318.0634 + 0.1643573223*d) % 360
        self.a = 60.2666 # Earth radii
        self.e = 0.054900
        self.M = (115.3654 + 13.0649929509*d) % 360
        self.related()
        # Eccentric Anomaly
        E_0=self.M + self.e*180/math.pi * math.sin( math.radians( self.M ) ) * (1 + self.e*math.cos( math.radians(self.M) ) )
        for c in range(16):
            E_1= E_0 - (E_0 - self.e*180/math.pi * math.sin (math.radians(E_0) ) - self.M) / (1 - self.e*math.cos( math.radians(E_0)) )
            if abs(E_0-E_1) <= 0.005: break
            E_0= E_1
        self.E= E_1
        self.x= self.a*(math.cos( math.radians( self.E ) ) - self.e)
        self.y= self.a*(math.sin( math.radians( self.E ) ) * math.sqrt( 1-self.e**2 ) )
        self.v = math.degrees( math.atan2( self.y, self.x ) ) % 360
        self.r = math.sqrt( self.x**2 + self.y**2 )

        # Perturbation Base Values
        # Sun's  mean longitude:        Ls     (already computed)
        # Moon's mean longitude:        Lm  =  N + w + M (for the Moon)
        # Sun's  mean anomaly:          Ms     (already computed)
        # Moon's mean anomaly:          Mm     (already computed)
        # Moon's mean elongation:       D   =  Lm - Ls
        # Moon's argument of latitude:  F   =  Lm - N
        sun= Position_Sun( jad )
        self.sun= sun
        self.L_s = sun.L
        self.L_m = (self.N + self.w + self.M) % 360
        self.M_s = sun.M
        self.M_m = self.M
        self.D = (self.L_m - self.L_s) % 360
        self.F = (self.L_m - self.N) % 360

        self.P_longitude= (
            -1.274 * math.sin( math.radians(self.M_m - 2*self.D) ),    #(Evection)
            +0.658 * math.sin( math.radians(2*self.D) ),         #(Variation)
            -0.186 * math.sin( math.radians(self.M_s) ),          #(Yearly equation)
            -0.059 * math.sin( math.radians(2*self.M_m - 2*self.D) ),
            -0.057 * math.sin( math.radians(self.M_m - 2*self.D + self.M_s) ),
            +0.053 * math.sin( math.radians(self.M_m + 2*self.D) ),
            +0.046 * math.sin( math.radians(2*self.D - self.M_s) ),
            +0.041 * math.sin( math.radians(self.M_m - self.M_s) ),
            -0.035 * math.sin( math.radians(self.D) ),            #(Parallactic equation)
            -0.031 * math.sin( math.radians(self.M_m + self.M_s) ),
            -0.015 * math.sin( math.radians(2*self.F - 2*self.D) ),
            +0.011 * math.sin( math.radians(self.M_m - 4*self.D) ),
            )
        self.P_long = sum( self.P_longitude )

        self.P_latitude = (
            -0.173 * math.sin( math.radians(self.F - 2*self.D) ),
            -0.055 * math.sin( math.radians(self.M_m - self.F - 2*self.D) ),
            -0.046 * math.sin( math.radians(self.M_m + self.F - 2*self.D) ),
            +0.033 * math.sin( math.radians(self.F + 2*self.D) ),
            +0.017 * math.sin( math.radians(2*self.M_m + self.F) ),
            )
        self.P_lat= sum( self.P_latitude )

        self.P_distance= (
            -0.58 * math.cos( math.radians(self.M_m - 2*self.D) ),
            -0.46 * math.cos( math.radians(2*self.D) ),
            )
        self.P_r= sum( self.P_distance )

        # Ecliptic Coordinates
        self.x_m = self.r * ( math.cos(math.radians(self.N)) * math.cos(math.radians(self.v+self.w)) - math.sin(math.radians(self.N)) * math.sin(math.radians(self.v+self.w)) * math.cos(math.radians(self.i)) )
        self.y_m = self.r * ( math.sin(math.radians(self.N)) * math.cos(math.radians(self.v+self.w)) + math.cos(math.radians(self.N)) * math.sin(math.radians(self.v+self.w)) * math.cos(math.radians(self.i)) )
        self.z_m = self.r * math.sin(math.radians(self.v+self.w)) * math.sin(math.radians(self.i))

        # Longitude and Latitude corrected with perturbation.
        self.lon_ecl = (math.degrees( math.atan2( self.y_m, self.x_m ) ) + self.P_long) % 360
        self.lat_ecl = math.degrees( math.atan2( self.z_m, math.sqrt(self.x_m**2+self.y_m**2) ) ) + self.P_lat
        self.r_ecl = self.r + self.P_r

        # Convert perturbed lon and lat back to geocentric coordinates
        xg = self.r_ecl*math.cos(math.radians(self.lon_ecl)) * math.cos(math.radians(self.lat_ecl))
        yg = self.r_ecl*math.sin(math.radians(self.lon_ecl)) * math.cos(math.radians(self.lat_ecl))
        zg = self.r_ecl*math.sin(math.radians(self.lat_ecl))

        # Rotate the y-z-plane by ecl, the angle of the obliquity of the ecliptic to get equatorial coordinates
        xe = xg
        ye = yg*math.cos(math.radians( self.ecl(jad) )) - zg*math.sin(math.radians( self.ecl(jad) ))
        ze = yg*math.sin(math.radians( self.ecl(jad) )) + zg*math.cos(math.radians( self.ecl(jad) ))

        # Compute Right Ascension (RA) and Declination (Dec):
        self.RA  = math.degrees( math.atan2( ye, xe ) ) % 360
        self.Decl = math.degrees( math.atan2( ze, math.sqrt(xe**2+ye**2) ) )

    def local_az_alt( self, lat, lon, utc_offset ):
        """Compute a localized azimuth and altitude, applying
        the topocentric correction to altitude.

        :param lat: latitude of observer
        :param lon: longiude of observer
        :param utc_offset: UTC time-of-day offset of observer
        :return: azimuth and altitude pair.
        """
        az, alt = self._az_alt( lat, lon, utc_offset, self.sun )
        self.az, self.alt_geoc = az, alt
        # Compute azimuthal coordinates by applying LST.
        # Topocentric vs. geocentric altitude adjustment
        mpar = math.degrees( math.asin( 1/self.r ) )
        alt_topoc = alt - mpar * math.cos(math.radians(alt))
        self.alt_topoc = alt_topoc
        return az, alt_topoc

class Position_Sun( Orbital_Elements ):
    """Position of the Sun on a given date."""
    def __init__( self, jad ):
        """Create orbital elements and compute position of the
        moon. This includes the largest perturbations.

        :param jad: Julian Astronomical Day.
        """
        super().__init__( jad )
        d= self.d
        self.N = 0.0
        self.i = 0.0
        self.w = 282.9404 + 4.70935E-5*d
        self.a = 1.000000 # AU
        self.e = 0.016709 - 1.151E-9*d
        self.M = (356.0470 + 0.9856002585*d) % 360
        self.related()
        # Eccentric Anomaly
        self.E = self.M + self.e*180/math.pi * math.sin( math.radians( self.M ) ) * (1 + self.e*math.cos( math.radians( self.M ) ) )
        x_v= math.cos( math.radians( self.E ) ) - self.e
        y_v= math.sin( math.radians( self.E ) )*math.sqrt( 1-self.e**2 )
        self.x, self.y = x_v, y_v
        self.v = math.degrees( math.atan2( y_v, x_v ) ) % 360
        self.r = math.sqrt( x_v**2 + y_v**2 )
        # True Longitude
        self.lon = self.v + self.w

        # Ecliptic Rectangular Coordinates
        self.x_s = self.r * math.cos( math.radians(self.lon) )
        self.y_s = self.r * math.sin( math.radians(self.lon) )
        self.z_s = 0 # By definition

        # Equatorial Coordinates
        self.x_e = self.x_s
        self.y_e = self.y_s * math.cos( math.radians( self.ecl(jad) ) )
        self.z_e = self.y_s * math.sin( math.radians( self.ecl(jad) ) )

        # Right Ascension and Declination
        self.RA = math.degrees( math.atan2( self.y_e, self.x_e ) ) % 360
        self.Decl= math.degrees( math.atan2( self.z_e, math.sqrt(self.x_e**2 + self.y_e**2) ) ) % 360

    def local_az_alt( self, lat, lon, utc_offset ):
        """Compute a localized azimuth and altitude.

        :param lat: latitude of observer
        :param lon: longiude of observer
        :param utc_offset: UTC time-of-day offset of observer
        :return: azimuth and altitude pair.
        """
        return self._az_alt( lat, lon, utc_offset, self )

def RA_Decl_sun( d ):
    """Right Ascension and Declination of the Sun."""
    s = Position_Sun( d )
    return s.RA, s.Decl
