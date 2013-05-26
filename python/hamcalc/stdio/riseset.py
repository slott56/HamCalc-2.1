"""Sunrise/Sunset Calculator

"SUNRISE/SUNSET CALCULATOR","","","RISESET"
"""
import hamcalc.navigation.solar as solar
from hamcalc.navigation.solar.timezone import utc
from hamcalc.stdio.daydusk import get_lat_lon_tz_date
from hamcalc.lib import AttrDict
import datetime
import runpy
import string
import math

introduction = """\
 SUNRISE / SUNSET                                        by George Murphy VE3ERP

      This program calculates sunrise and sunset times anywhere on earth
      by entering the latitude and longitude of the desired location.

      Related data can also be calculated using Hamcalc's `Daylight, Dusk
      and Dawn Calculator' program.
"""

class Polar:
    """ASCII art polar plot."""
    def __init__( self, r=7, aspect=2.4 ):
        self.r= r
        self.aspect= aspect
        self.ys = [ r-row for row in range(2*r+1) ] #   +7 to  -7
        self.xs = [ col-18 for col in range(round(r*aspect*2)+1) ] # -18 to +18
        self.plot = dict(
            ( (y,x), '█' ) for y in self.ys for x in self.xs
        )
        self.label_left= {}
        self.label_right= {}
        for y in self.ys:
            self.plot[y,0] = '│'
        for x in self.xs:
            self.plot[0,x] = '─'
        self.text( '  N  ',  r, -2 )
        self.text( '  S  ', -r, -2 )
        self.text( '  W  ', 0, -round(r*aspect*2) )
        self.text( '  E  ', 0,  round(r*aspect*2)-4 )
        self.text( ' AZIMUTH ', 0, -4 )
        H = math.sqrt(self.r**2/2)
        self.text( ' NW ', int(H), -round(H*aspect) )
        self.text( ' NE ', int(H), round(H*aspect)-4 )
        self.text( ' SW ', -int(H), -round(H*aspect) )
        self.text( ' SE ', -int(H), round(H*aspect)-4 )
    def text( self, text, y, x ):
        for offset, char in enumerate(text):
            self.plot[y,x+offset] = char
    def x_y( self, range, bearing ):
        bearing_r= math.radians( bearing-90 )
        x = round( range * self.aspect * math.cos( bearing_r ) )
        y = round( range * math.sin( bearing_r ) )
        return x, y
    def point( self, char, distance, bearing ):
        x, y = self.x_y( distance, bearing )
        self.text( char, y, x )
    def left_label( self, text, bearing ):
        x, y = self.x_y( self.r, bearing )
        self.label_left[y]= text
    def right_label( self, text, bearing ):
        x, y = self.x_y( self.r, bearing )
        self.label_right[y]= text
    def image( self ):
        return [ self._row_image(y) for y in self.ys ]
    def _row_image( self, y ):
        return "{0:>20s} {1:s} {2:s}".format(
            self.label_left.get(y,''),
            ''.join( self.plot[y,x] for x in self.xs ),
            self.label_right.get(y,''),
        )

def display( latitude, longitude, tz, date_time ):
    """Display various sunrise, sunset details.

    ..  todo:: Confirm this output.

    :param latitude: Latitude of observer
    :param longitude: longitude of observer
    :param tz: timezone of observer
    :param date_time: datetime object with date to display
    """
    rise, transit, set = solar.rise_transit_set( latitude, longitude, date_time )
    detl_rise= solar.Position_Sun( latitude, longitude, rise )
    detl_set= solar.Position_Sun( latitude, longitude, set )

    template= string.Template("""\
======================================== SUNRISE ====== SUNSET ====== DAYLIGHT
 Local SOLAR Time....................... ${lst_rise}   ${lst_set}  ${daylight} hrs.
 Local ${std} Time......................... ${std_rise}     ${std_set}
 UNIVERSAL COORDINATED Time (UTC/GMT)... ${utc_rise}     ${utc_set}
 Declination of Earth's axis............ ${decl_rise}° ${decl_set}°
===============================================================================
""" )

    dst_offset= date_time.dst()
    data = dict(
        lst_rise= detl_rise.X_hms,
        std_rise= rise.astimezone(tz).strftime("%H:%H:%S"),
        utc_rise= rise.astimezone(utc).strftime("%H:%H:%S"),

        lst_set= detl_rise.Y_hms,
        std_set= set.astimezone(tz).strftime("%H:%H:%S"),
        utc_set= set.astimezone(utc).strftime("%H:%H:%S"),

        std = tz.tzname(date_time),
        decl_rise= "",
        decl_set= "",
        daylight= "{0:4.2f}".format(detl_rise.AA/60),
    )

    print( template.substitute( data ) )

    r = Polar(r=7)
    r.point( "*", 7, detl_rise.AH )
    r.right_label( "SUNRISE @ {0:.0f}°".format(detl_rise.AH),  detl_rise.AH )
    r.point( "*", 7, detl_set.AH )
    r.left_label( "SUNSET @ {0:.0f}°".format(detl_set.AH), detl_set.AH )
    for line in r.image():
        print( line )

def run():
    print( introduction )
    z= ''
    while z != '0':
        print("   < 1 > run this program" )
        print("   < 2 > run Sunrise/Sunset program")
        print("   < 0 >  EXIT" )
        z= input( "CHOICE? " )
        if z == '1':
            latitude, longitude, tz, date_time = get_lat_lon_tz_date()
            display( latitude, longitude, tz, date_time )
        elif z == '2':
            runpy.run_module( 'hamcalc.stdio.riseset' )

if __name__ == "__main__":
    run()
