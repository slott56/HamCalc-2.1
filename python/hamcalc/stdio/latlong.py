"""Latitude/Longitude Data Base

"LATITUDE & LONGITUDE DATA BASE","","","LATLONG"
"TIME ZONES",", of various locations","","LATLONG"
"""
import csv
import os
from collections import namedtuple
import re
import string
import hamcalc.navigation.distance as distance

introduction="""
                    LATITUDE and LONGITUDE DATA BASE

   Some HAMCALC programs ask you to enter the latitude and longitude
   of a location, usually your own QTH. The data base contains this
   information for many places in the world, and you may add, delete
   or edit the data at any time. Solar time zones (±UTC) are calculated
   automatically for each location.

   Enter data in decimal degrees - to the nearest 0.1 degree is close
   enough for most amateur radio applications. Enter data as follows:

   LATITUDE:  as Positive (+) values if NORTH of the equator
              as Negative (-) values if SOUTH of the equator

   LONGITUDE: as Positive (+) values if EAST of Greenwich, England
              as Negative (-) values if WEST of Greenwich, England

   If you wish to find the latitude and longitude of any location in
   the database, you need only enter the first few letters of a city,
   state or country and the program will display a list from which you
   may select the location of your choice.
"""

Place = namedtuple( "Place", "city, country, latitude, longitude" )

def load_data( db_file ):
    """Examine a sequence of files looking for the data file."""
    name = os.path.basename( db_file )
    try:
        path, _ = os.path.split( __file__ )
        alt_file_1= os.path.join( path, "..", "LATLONG", name )
        alt_file_2= os.path.join( path, "..", "..", "..", "HCALC_129", "HamCalc", "LATLONG", name )
    except NameError:
        alt_file_1= db_file
        alt_file_2= db_file

    for db_file in db_file, alt_file_1, alt_file_2:
        if not os.path.exists( db_file ): continue
        data= []
        with open( db_file ) as source:
            rdr= csv.reader( source )
            for row in rdr:
                if len(row) < 4:
                    continue
                city, country, lat, lon = row
                data.append( Place( city, country, float(lat), float(lon) ) )
        return data

def save_data( data, db_file ):
    """Save the data into the given file name."""
    if os.path.exists( db_file ):
        if os.path.exists( db_file+".bak" ):
            os.unlink( db_file+".bak" )
        os.copy( db_file, db_file+".bak" )
        with open( db_file+".tmp", "w" ) as target:
            wtr= csv.writer( target )
            wtr.writerows( data )
        os.unlink( db_file )
        os.rename( db_file+".tmp", db_file )

def add_data( data ):
    """Add a new Place to the database."""
    city= input( " ENTER: City or town...................? " )
    country= input( " ENTER: Province, State or Country.....? " )
    latitude= None
    while latitude is None:
        try:
            lat_raw= input( " ENTER: Latitude (minus if South)......? " )
            latitude= float(lat_raw)
        except ValueError:
            pass
    longitude= None
    while longitude is None:
        try:
            lon_raw= input( " ENTER: Longitude (minus if West)......? " )
            longitude= float(lon_raw)
        except ValueError:
            pass
    place= Place( city, country, latitude, longitude )
    print( "Adding", format_place( place ) )
    data.append( place )

def remove_data( target, data ):
    """Remove a Place from the database."""
    data.remove( target )

def search_place( data ):
    """Search the database for a Place."""
    print( " < 1 > City, Town, Province, State or Country" )
    print( " < 2 > Latitude and Longitude" )
    z= input( "CHOICE? " )
    if z == "1":
        target= search_name( data )
    elif z == "2":
        target= search_lat_lon( data )
    return target

def search_and_process_data( data ):
    """Search the database for a Place and update or remove it.

    ..  todo:: import pathfind and start process with selected city.
    """
    target= search_place( data )
    if target is not None:
        print( target )
        print()
        print( " (1) SELECT this listing for Great Circle calculation" )
        print( " (2) EDIT Listing" )
        print( " (3) DELETE Listing" )
        print()
        print( " (0) RETURN to menu" )
        z= input( "CHOICE? " )
        if z == "1":
            pass # Need to switch to pathfind with this city in tow.
        elif z == '2':
            remove_data( target, data )
            add_data( data )
        elif z == '3':
            confirm= ''
            while confirm not in ('y', 'n'):
                confirm= input( " Are you SURE you want to delete this place?   (y/n) " )
            if confirm == 'y':
                remove_data( target, data )

def search_name( data ):
    """Returns the Place that matches a name query."""
    name= input( " ENTER first few characters of Town, State, Country, Prefix, etc. " )
    pat_name= re.compile( name, re.I )
    matches = list( row for row in data if pat_name.match( row.city ) or pat_name.match( row.country ) )
    if len(matches) > 26:
        print( "LONG LIST -- Please enter more letters" )
        return
    return pick_from( matches )

def pick_from( matches ):
    """Pick a specific Place from a short list of places.
    """
    if matches is None or len(matches) == 0: return None
    for i, item in enumerate( matches[:26] ):
        lat, ns = detail( item.latitude, "N", "S" )
        lon, ew = detail( item.longitude, "E", "W" )
        print( " ( {0:s} ) {1.city}, {1.country} {2:4.1f}°{3} {4:5.1f}°{5}".format( string.ascii_lowercase[i], item, lat, ns, lon, ew ) )
    z= input( "ENTER letter in ( ) to select listing or nothing to return to menu? " )
    i= string.ascii_lowercase.find(z)
    if 0 <= i < len(matches):
        print( "Selected", format_place( matches[i] ) )
        return matches[i]

def search_lat_lon( data ):
    """Returns the Place that matches a lat-lon query."""
    lat_raw= input( " ENTER: Latitude (minus if South)......? " )
    try:
        lat= float(lat_raw)
    except ValueError:
        return
    lon_raw= input( " ENTER: Longitude (minus if West)......? " )
    try:
        lon= float(lon_raw)
    except ValueError:
        return
    # Sort into order by distance between lat, lon and item in database.
    by_distance= list( sorted( data, key=lambda i: distance.range_bearing(i.latitude, i.longitude, lat, lon) ) )
    return pick_from( by_distance )

def pairs( iterable ):
    """Consume an interable in pairs."""
    the_iter= iter(iterable)
    for item in the_iter:
        try:
            item2= next(the_iter)
            yield item, item2
        except StopIteration:
            yield item, None

def detail( lat_or_lon, positive, negative ):
    """Transforma a lat or lon into a number and a hemisphere."""
    return abs(lat_or_lon), positive if lat_or_lon >= 0 else negative

def format_place( place ):
    fmt= "{1:4.1f}°{2} {3:5.1f}°{4} {0.city:s}, {0.country:s}"
    lat, ns = detail( place.latitude, "N", "S" )
    lon, ew = detail( place.longitude, "E", "W" )
    return fmt.format(place, lat, ns, lon, ew)

def list_data( data ):
    data.sort( key= lambda a: (a.city, a.country) )
    for item1, item2 in pairs(data):
        column1= format_place(item1)
        if item2:
            column2= format_place(item2)
        else:
            column2= ''
        print( "{0:38s} {1:38s}".format( column1, column2 ) )

def run():
    db_file= "./LATLONG.DAT"
    data = load_data( db_file )
    z=None
    while z != '0':
        print("  < 1 >  ADD a listing")
        print("  < 2 >  FIND or EDIT a listing")
        print("  < 3 >  DISPLAY listings")
        print()
        print("  < 0 >  EXIT")
        z = input( "CHOICE? " )
        print()
        if z == "1":
            add_data( data )
        elif z == '2':
            search_and_process_data( data )
        elif z == '3':
            list_data( data )
    option = ''
    while option not in ('s', 'x'):
        option= input( "  < s > Save Changes, < x > Exit? " )
    if option == "s":
        print( "Writing", db_file )
        save_data( data, db_file )

if __name__ == "__main__":
    run()
