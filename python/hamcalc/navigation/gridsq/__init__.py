"""hamcalc.navigation.gridsq -- Grid Squares.

Test Case

>>> import hamcalc.navigation.gridsq as gridsq
>>> gridsq.latlon_2_grid( 38.98, -76.47 )
'FM18sx'
>>> lat, lon = gridsq.grid_2_latlon( "FM18sx" )
>>> round(lat, 4), round(lon, 4)
(38.9792, -76.4583)

"""
__version__ = "2.1"

import string

introduction="""\
GRID SQUARE LOCATOR (Maidenhead)                       by Dr.Thomas Clark W3IWI

  edited and enhanced for HAMCALC by George Murphy VE3ERP

         Grid squares were developed by an international group at a
       conference in Maidenhead, England, hence the name "Maidenhead"grid squares.
         Grid squares are based on latitude and longitude. Each square is
       1° high x 2° wide, further divided into sub-squares only a few
       kilometres wide. Grid squares are coded with a 2-letter/2-number/
       2-letter code (such as FN04HO). Most people just use the first four
       characters (such as FN04), which is the grid square. The last two
       letters are generally used only when it is desired to pinpoint a
       a location within a sub-square.
         This program computes the grid square code for any latitude/
       longitude in the world, or the coordinates of the approximate
       centre of any grid square or sub-square. It also computes distances
       and beam headings between specified grid squares or sub-squares.
         Coordinates need only be known within an accuracy of 0.1° which
       is about 11 km north-south, and east-west about 11 km at the
       equator, 8 km at 45° latitude, and 1 km at 85° latitude.
         All computations are in decimal degrees. To convert deg/min/sec
       coordinates to decimal degrees, run the EQIVALENT VALUES program.
         (ref. The ARRL OPERATING MANUAL, 5th Edition, pp.12-4 to 12-6)
"""

field_map="""\
            M A I D E N H E A D   G R I D   S Q U A R E   F I E L D S
                  with First Two Characters of Grid Square Code
                       Degrees West             Degrees East
               160°  120°  80°   40°    0°   40°   80°   120°  160°
80°N -90.0°N │AR│BR│CR│DR│ER│FR│GR│HR│IR║JR│KR│LR│MR│NR│OR│PR│QR│RR│
70°N -80.0°N │AQ│BQ│CQ│DQ│EQ│FQ│GQ│HQ│IQ║JQ│KQ│LQ│MQ│NQ│OQ│PQ│QQ│RQ│
60°N -70.0°N │AP│BP│CP│DP│EP│FP│GP│HP│IP║JP│KP│LP│MP│NP│OP│PP│QP│RP│ Each Field
50°N -60.0°N │AO│BO│CO│DO│EO│FO│GO│HO│IO║JO│KO│LO│MO│NO│OO│PO│QO│RO│ contains
40°N -50.0°N │AN│BN│CN│DN│EN│FN│GN│HN│IN║JN│KN│LN│MN│NN│ON│PN│QN│RN│ 100 grid
30°N -40.0°N │AM│BM│CM│DM│EM│FM│GM│HM│IM║JM│KM│LM│MM│NM│OM│PM│QM│RM│ squares,
20°N -30.0°N │AL│BL│CL│DL│EL│FL│GL│HL│IL║JL│KL│LL│ML│NL│OL│PL│QL│RL│ each being
10°N -20.0°N │AK│BK│CK│DK│EK│FK│GK│HK│IK║JK│KK│LK│MK│NK│OK│PK│QK│RK│ 2° wide x
 0°N -10.0°N │AJ│BJ│CJ│DJ│EJ│FJ│GJ│HJ│IJ║JJ│KJ│LJ│MJ│NJ│OJ│PJ│QJ│RJ│ 1° high.
                                     «EQUATOR»
 0°S -10.0°S │AI│BI│CI│DI│EI│FI│GI│HI│II║JI│KI│LI│MI│NI│OI│PI│QI│RI│
10°S -20.0°S │AH│BH│CH│DH│EH│FH│GH│HH│IH║JH│KH│LH│MH│NH│OH│PH│QH│RH│
20°S -30.0°S │AG│BG│CG│DG│EG│FG│GG│HG│IG║JG│KG│LG│MG│NG│OG│PG│QG│RG│
30°S -40.0°S │AF│BF│CF│DF│EF│FF│GF│HF│IF║JF│KF│LF│MF│NF│OF│PF│QF│RF│
40°S -50.0°S │AE│BE│CE│DE│EE│FE│GE│HE│IE║JE│KE│LE│ME│NE│OE│PE│QE│RE│
50°S -60.0°S │AD│BD│CD│DD│ED│FD│GD│HD│ID║JD│KD│LD│MD│ND│OD│PD│QD│RD│
60°S -70.0°S │AC│BC│CC│DC│EC│FC│GC│HC│IC║JC│KC│LC│MC│NC│OC│PC│QC│RC│
70°S -80.0°S │AB│BB│CB│DB│EB│FB│GB│HB│IB║JB│KB│LB│MB│NB│OB│PB│QB│RB│
80°S -90.0°S │AA│BA│CA│DA│EA│FA│GA│HA│IA║JA│KA│LA│MA│NA│OA│PA│QA│RA│
            180°  140°  100°  60°   20°   20°   60°   100°  140°  180°
"""

square_map="""\
  4-CHARACTER CODES FOR 1°x 2° GRID SQUARES WITHIN EACH 10°x 20° FIELD
              (xx = FIRST TWO letters of Grid Square Code)

┌──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐
│ xx09 │ xx19 │ xx29 │ xx39 │ xx49 │ xx59 │ xx69 │ xx79 │ xx89 │ xx99 │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ xx08 │ xx18 │ xx28 │ xx38 │ xx48 │ xx58 │ xx68 │ xx78 │ xx88 │ xx98 │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ xx07 │ xx17 │ xx27 │ xx37 │ xx47 │ xx57 │ xx67 │ xx77 │ xx87 │ xx97 │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ xx06 │ xx16 │ xx26 │ xx36 │ xx46 │ xx56 │ xx66 │ xx76 │ xx86 │ xx96 │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ xx05 │ xx15 │ xx25 │ xx35 │ xx45 │ xx55 │ xx65 │ xx75 │ xx85 │ xx95 │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ xx04 │ xx14 │ xx24 │ xx34 │ xx44 │ xx54 │ xx64 │ xx74 │ xx84 │ xx94 │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ xx03 │ xx13 │ xx23 │ xx33 │ xx43 │ xx53 │ xx63 │ xx73 │ xx83 │ xx93 │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ xx02 │ xx12 │ xx22 │ xx32 │ xx42 │ xx52 │ xx62 │ xx72 │ xx82 │ xx92 │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ xx01 │ xx11 │ xx21 │ xx31 │ xx41 │ xx51 │ xx61 │ xx71 │ xx81 │ xx91 │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ xx00 │ xx10 │ xx20 │ xx30 │ xx40 │ xx50 │ xx60 │ xx70 │ xx80 │ xx90 │
└──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘
"""

def intro():
    return introduction


def latlon_2_grid( lat, lon, level=3 ):
    """Convert lat/lon as decimal values to Grid Square Code.

    :param lat: Decimal latitude, positive north
    :param lon: Decimal longitude, positive east, negative west.
    :param level: level of deatil: 1 to 4. 1 gives a two-position
        code. 4 gives an 8-position code.
    :returns: grid square code (6-position by default.)
    """
    lon= (lon+180)/2
    lat= lat+90
    w_1, w_2 = divmod( int(lon), 10 )
    l_1, l_2 = divmod( int(lat), 10 )
    w_3, w_4 = divmod( int((lon-int(lon))*240), 10 )
    l_3, l_4 = divmod( int((lat-int(lat))*240), 10 )
    grid= [ string.ascii_uppercase[w_1], string.ascii_uppercase[l_1],
        str(w_2), str(l_2),
        string.ascii_lowercase[w_3], string.ascii_lowercase[l_3],
        str(w_4), str(l_4) ]
    grid_str= "".join( grid[:level*2] )
    return grid_str

def grid_2_latlon( grid ):
    """Convert Grid Square Code to lat and lon pair.

    Note that default center-of-square values are provided for missing
    positions.

    :param grid: 2, 4 or 6-position grid-square code.
    :returns: latitude and longitude
    """
    lon= list(grid[0::2])
    lat= list(grid[1::2])
    assert len(lon) == len(lat) and 1 <= len(lon) <= 4
    # Default values include centers of squares and subsquares.
    w = [ 0, 5, 12, 5 ]
    l = [ 0, 5, 12, 5 ]
    w[0]= string.ascii_uppercase.find(lon.pop(0).upper())
    l[0]= string.ascii_uppercase.find(lat.pop(0).upper())
    if lon:
        w[1]= int(lon.pop(0))
        l[1]= int(lat.pop(0))
    if lon:
        w[2]= string.ascii_uppercase.find(lon.pop(0).upper())
        l[2]= string.ascii_uppercase.find(lat.pop(0).upper())
    if lon:
        w[3]= int(lon.pop(0))
        l[3]= int(lat.pop(0))
    assert len(lon) == 0 and len(lat) == 0
    lon = w[0]*10 + w[1] + w[2]/24 + w[3]/240
    lat = l[0]*10 + l[1] + l[2]/24 + l[3]/240
    return lat-90, 2*lon-180
