"""Barometer Reading Equivalents

"ATMOSPHERIC PRESSURE","","","BAROMTR"
"BAROMETER",", equivalent readings","","BAROMTR"
"""

import hamcalc.math.baromtr as baromtr
import string

def table():
    print( "  kPa    in.Hg    lb/in²  millibars  S.A. " )
    for kpa, in_hg, psi, mb, atm in baromtr.table():
        print( "{0:6.1f} {1:9.3f} {2:9.3f} {3:8.0f} {4:9.3f}".format(
            kpa, in_hg, psi, mb, atm ) )

    print ( """\
( in.Hg = inches of mercury, atm= standard atmospheres)
1 standard atmosphere is the pressure exerted by a 76 cm.
column of mercury at 0°C at sea level at standard gravity
of 980.6 cm/second².

 Ref. POCKET REF, pages 8-9      by Thomas J. Glover"
""" )


def equivalents():
    units= dict(
        (string.ascii_lowercase[i], u) for i, u in enumerate(baromtr.units))

    def display( value ):
        print( "ATMOSPHERIC PRESSURE EQUIVALENTS".center(80) )
        print()
        print( "{0:.<40s} {1:s}".format( "Altitude", "Sea Level" ) )
        print( "{0:.<40s}   {1:8.1f}°C      = {2:8.1f}°F".format( "Temperature", 0, 32 ) )
        print( "{0:.<40s} {1:10.3f} m/sec² = {2:8.3f} ft/sec²".format( "Standard gravity", 9.8066, 32.174 ) )
        sos_m_sec, sos_ft_sec= 331.45, 1087.4
        print( "{0:.<40s}┌ {1:9.3f} m/sec  = {2:8.3f} ft/sec".format( "Speed of sound in dry air", sos_m_sec, sos_ft_sec ) )
        sos_km_hr= sos_m_sec/10**3*3600
        sos_m_hr= sos_ft_sec/5280*3600
        print( "{0:40s}└ {1:7.1f}   km/hr  = {2:6.1f}   miles/hr".format( "", sos_km_hr, sos_m_hr) )
        print()
        for u in sorted(units):
            print( "<{0}> {1:.<35s} {2:10.3f}".format( u, units[u].__doc__, units[u].from_std(value) ) )

    display( 0 )
    u= None
    while u not in units:
        u= input( "Enter letter in < > to select an atmospheric pressure unit: " )
    value= float( input( "Enter value [{0:s}]: ".format(units[u].name) ) )
    display( units[u].to_std( value ) )

print( baromtr.intro() )

z= None
while z != '0':
    print( "Press number in < > for:" )
    print( "< 1 > Typical barometer reading equivalents" )
    print( "< 2 > Atmosphere pressure equivalents" )
    print( "< 0 > EXIT" )
    z= input( "Choice? " )
    if z == '1':
        table()
    elif z == '2':
        equivalents()
