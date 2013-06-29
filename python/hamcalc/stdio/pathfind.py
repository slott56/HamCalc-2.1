"""Great Circle Paths & Distances

"DISTANCE",", between locations","","PATHFIND"
"GREAT CIRCLE CALCULATOR","","","PATHFIND"
"BEAM HEADING CALCULATOR","","","PATHFIND"
"""
import hamcalc.navigation.distance as distance
import hamcalc.stdio.latlong as latlong
from hamcalc.stdio import *
from hamcalc.math.equiv import MILE, NAUTICAL_MILE, KILOMETRE, METRE
import runpy

introduction="""\
 GREAT CIRCLE PATHS, BEARINGS and DISTANCES              by George Murphy VE3ERP
       This program calculates Great Circle paths, bearings and distances
       between any two points on earth, including those on or very close
       to the same meridian, the equator, or the earth's poles. Several
       intermediate points are also calculated as an aid in plotting the
       path on a flat chart or map drawn in any projection. Solar time
       difference between the two end points is also shown.

       Also included is a data base of over 500 locations that can be
       inserted into the program, and which can be edited by the user.
"""

note="""\
NOTE:

Enter latitude and longitude as decimal degrees, to the nearest 1/10th of a
degree, e.g. 47.3 for 48°20'. If you enter data with more than one place of
decimals the data entered will be used in all calculations, even though all
data displayed will be rounded-off to the nearest 1/10th degree.

1/10th of a degree longitude is equal to about 11 kilometres at the equator,
less than 6 Km. at 60° latitude.
"""

def pathfind():
    data = latlong.load_data( latlong.DB_file )

    print("  < n >  Nautical miles" )
    print("  < s >  Statute miles" )
    print("  < k >  Kilometres" )
    u_name= None
    while u_name not in ('n', 's', 'k'):
        u_name= input("UNITS? " )
    if u_name == 'n':
        units, r = NAUTICAL_MILE, distance.NM
    elif u_name == 'm':
        units, r = MILE, distance.MI
    elif u_name == 'k':
        units, r = KILOMETRE, distance.KM
    print( note )
    a_latitude, a_longitude = get_point( "A", data )
    b_latitude, b_longitude = get_point( "B", data )
    display_great_circle( a_latitude, a_longitude, b_latitude, b_longitude, units, r )

def get_point( label, database ):
    target= None
    latitude= longitude= None
    while latitude is None and target is None:
        print( "(ENTER nothing to search lat-long database.)" )
        latitude= input_float( "ENTER: Latitude (minus if South) of {0} ? ".format(label) )
        if latitude is None:
            target= latlong.search_place(database)
    if target is None:
        longitude= input_float( "ENTER: Longitude (minus if West) of {0} ? ".format(label))
    else:
        latitude, longitude = target.latitude, target.longitude
    return latitude, longitude

def lat_lon_str( lat, lon ):
    return "{0:4.1f}°{1} {2:5.1f}°{3}".format(
        abs(lat), "N" if lat >= 0 else "S",
        abs(lon), "E" if lon >= 0 else "W" )

def display_great_circle( a_latitude, a_longitude, b_latitude, b_longitude, units, unit_r):

    dist = distance.great_circle_distance(  a_latitude, a_longitude, b_latitude, b_longitude, unit_r )
    bearing = distance.great_circle_bearing( a_latitude, a_longitude, b_latitude, b_longitude )
    print( )
    print( "        Path between A  .....................................   {0}" .format( lat_lon_str(a_latitude, a_longitude) ) )
    print( "        Solar zone UTC{0}".format( int(a_longitude/15) ) )
    print( "                 and B  .....................................   {0}" .format( lat_lon_str(b_latitude, b_longitude) ) )
    print( "        Solar zone UTC{0}".format( int(b_longitude/15) ) )
    print( "        Great Circle distance ( {1:14s} ).... {0:6.1f}".format(dist, units.__doc__) )
    diff = int(b_longitude/15) - int(a_longitude/15)
    h, m = divmod( diff*60, 60 )
    print( "        Solar Time difference (hr:min)..........      {0:02d}:{1:02d}".format(h,m) )
    print( "                     Bearing from A .........................    {0:6.2f}°" .format(bearing))
    print( "                     Bearing from B .........................    {0:6.2f}°" .format(180-bearing))
    print( )
    print( " To A                         INTERMEDIATE  PLOTS                        To B")
    print( "   └─«{0:^11s}«─ Bearing«─ ┌── From Plot ──┐ ─»Bearing ─»{0:^11s}»─┘".format(units.__doc__) )
    total= 0
    r= dist/10
    for s in range(11):
        theta= distance.great_circle_bearing( a_latitude, a_longitude, b_latitude, b_longitude )
        pt= distance.great_circle_destination( a_latitude, a_longitude, r, theta, unit_r )
        print( "{0:9d}   {1:6.1f} {2:5.1f}°  «─  {3:^16s} ─» {4:5.1f}°   {5:6.1f}".format(s, total, bearing, lat_lon_str(*pt), (180+bearing)%180, dist-total ) )
        a_latitude, a_longitude = pt
        total += r

print( introduction )
z= None
while z != '0':
    print( "  < 1 >  RUN program" )
    print( "  < 2 >  VIEW/EDIT/SEARCH data files (Latitude/Longitude Data Base) " )
    print( "  < 0 >  EXIT" )
    z = input( "CHOICE? " )
    if z == "1":
        pathfind()
    elif z == "2":
        runpy.run_module( 'hamcalc.stdio.latlong', run_name="__main__" )


