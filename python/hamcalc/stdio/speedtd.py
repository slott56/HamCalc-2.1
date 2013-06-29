"""Speed/Time/Distance Calculations

"DISTANCE",", as a function of speed and time","","SPEEDTD"
"SPEED",", as a function of time and distance","","SPEEDTD"
"TIME",", as a function of speed and distance","","SPEEDTD"
"""
import hamcalc.math.equiv as equiv
import hamcalc.math.deciconv as deciconv
import hamcalc.math.speedtd as speedtd
from hamcalc.stdio import *
import string
import runpy

distance= [
    equiv.MILLIMETRE, equiv.CENTIMETRE,
    equiv.INCH, equiv.FOOT,
    equiv.METRE, equiv.KILOMETRE,
    equiv.MILE, equiv.NAUTICAL_MILE ]

time= [
    equiv.SECOND, equiv.MINUTE, equiv.HOUR ]

def get_unit( dimension, collection ):
    z= ''
    while z == '':
        for i, unit in enumerate( collection ):
            print( "   < {0} >  {1}".format( string.ascii_lowercase[i], unit.__doc__ ) )
        z= input( "ENTER letter in < > to select Unit of {0}? ".format(dimension) )
        i = string.ascii_lowercase.find( z )
        if 0 <= i < len(collection):
            return collection[i]
        else:
            z= ''

def solve_fvd(D, d_unit, T, t_unit):
    if d_unit == equiv.KILOMETRE:
        v_unit= equiv.LITER
        rd_unit= equiv.KPL
    else:
        v_unit= equiv.GALLON
        rd_unit= equiv.MPG

    # fuel rate per distance
    R= input_float( "ENTER fuel rate {0}? ".format( rd_unit.name ) )
    # fuel rate per hour?
    # total fuel
    V= input_float( "ENTER fuel volume {0}? ".format( v_unit.name ) )

    rvd= speedtd.fuel_volume_distance( D=D, T=T, R=R, V=V )

    print( "Fuel Efficiency {0:6.2f} {1}".format(rvd.R, rd_unit.name) )
    print( "Fuel Required   {0:6.2f} {1}".format(rvd.V, v_unit.name) )
    print( "Fuel Use        {0:6.2f} {1}/hr.".format(rvd.V/rvd.T, v_unit.name) )

def solve_dst():
    d_unit= get_unit( "Distance", distance )
    t_unit= get_unit( "Time", time )
    if d_unit == equiv.NAUTICAL_MILE and t_unit == equiv.HOUR:
        s_unit_name= "knots"
    else:
        s_unit_name= "{0}/{1}".format(d_unit.name,t_unit.name)

    D= input_float( "ENTER Distance ({0})? ".format(d_unit.name) )
    S= input_float( "ENTER Speed ({0})? ".format(s_unit_name) )
    T= input_float( "ENER Time ({0})? ".format(t_unit.name) )

    dst= speedtd.speed_time_distance( D=D, S=S, T=T )
    tm= t_unit.to_std( dst.T )
    hrs= equiv.HOUR.from_std( tm )
    hms= deciconv.HR_MIN_SEC.from_std( hrs )

    print( "SPEED {0:14,.2f} {1}".format( dst.S, s_unit_name ) )
    print( "TIME  {0}".format( hms ) )
    print( "     ={0:14,.2f} hr.".format( equiv.HOUR.from_std( tm ) ) )
    print( "     ={0:14,.2f} min.".format( equiv.MINUTE.from_std( tm ) ) )
    print( "     ={0:14,.2f} sec.".format( equiv.SECOND.from_std( tm ) ) )
    print( "DISTANCE {0:14.2f} {1}".format( dst.D, d_unit.name ) )
    print()

    # Relevant for equiv.KILOMETRE, equiv.MILE, equiv.NAUTICAL_MILE
    z= ''
    while z not in ('y', 'n'):
        z= input( "Want to calculate fuel consumption?   (y/n)" )
    if z == 'y':
        solve_fvd( dst.D, d_unit, dst.T, t_unit )

print( speedtd.intro() )

z = ''
while z != '0':
    print( "  < 1 >  RUN Speed, Time & Distance Calculator" )
    print( "  < 2 >  Run Speed Chase program" )
    print( "  < 0 >  EXIT" )
    z = input( "CHOICE? " )
    if z == '1':
        solve_dst()
    elif z == '2':
        runpy.run_module( 'hamcalc.stdio.chase' )



