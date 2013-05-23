"""Grid Square Locator (Maidenhead)

"GRID SQUARE LOCATOR",", Maidenhead squares","","GRIDSQ"
"MAIDENHEAD GRID SQUARES","","","GRIDSQ"
"""
import hamcalc.math.trig as trig
import hamcalc.navigation.gridsq as gridsq
import hamcalc.navigation.distance as distance
import hamcalc.navigation.solar as solar
import datetime

def grid_square():
    today = datetime.datetime.now(tz=solar.utc)

    home= None
    while home is None:
        mode= input( "Home QTH (c)oordinates, (g)rid, or (q)uit?     (c/g/q) " ).lower()
        if mode == 'q':
            return
        elif mode == 'c':
            try:
                lat_raw= input( "ENTER: Latitude in decimal degrees (+° if North, -° if South)? " )
                lat= float( lat_raw )
                lon_raw= input( "ENTER: Longitude in decimal degrees (+° if East, -° if West)? " )
                lon= float( lon_raw )
            except ValueError:
                pass
            grid= gridsq.latlon_2_grid( lat, lon )
            home= grid
            lat_home, lon_home= lat, lon
        elif mode == 'g':
            grid_raw= input( "ENTER: Grid square code (enter 2, 4, or all 6 characters)? " )
            lat, lon = gridsq.grid_2_latlon( grid_raw )
            home= grid_raw
            lat_home, lon_home= lat, lon

    rise, _, set = solar.rise_transit_set( lat, lon, today )
    print( "Home", home, gridsq.grid_2_latlon(home), rise, set )

    R= None
    while R is None:
        dist_choice= input( "Choose: DX in (k)ilometers, (s)tatute miles or (n)autical miles?   (k/s/n) " ).lower()
        if dist_choice == 'k':
            R = distance.KM
        elif dist_choice == 's':
            R = distance.SM
        elif dist_choice == 'n':
            R = distance.NM

    count= 0
    while True:
        mode= input( "Away QTH (c)oordinates, (g)rid, or (q)uit?     (c/g/q) " ).lower()
        if mode == 'q':
            break
        elif mode == 'c':
            try:
                lat_raw= input( "ENTER: Latitude in decimal degrees (+° if North, -° if South)? " )
                lat= float( lat_raw )
                lon_raw= input( "ENTER: Longitude in decimal degrees (+° if East, -° if West)? " )
                lon= float( lon_raw )
            except ValueError:
                continue
            grid= gridsq.latlon_2_grid( lat, lon )
        elif mode == 'g':
            grid= input( "ENTER: Grid square code (enter 2, 4, or all 6 characters)? " )
            lat, lon = gridsq.grid_2_latlon( grid )
        count += 1

        dx_range = distance.great_circle_distance( lat_home, lon_home, lat, lon, R )
        rx_bearing = distance.great_circle_bearing( lat_home, lon_home, lat, lon )

        rise, _, set = solar.rise_transit_set( lat, lon, today )
        print( count, grid, lat, lon, dx_range, rx_bearing, rise, set )

print( gridsq.intro )
z= None
while z != '0':
    z= input( "1 to continue, 2 for world chart, or 0 to EXIT..." )
    if z == '1':
        grid_square()
    elif z == '2':
        print( gridsq.field_map )
        input( "Enter to continue" )
        print( gridsq.square_map )

