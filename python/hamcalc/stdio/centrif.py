"""Centrifugal/Centripetel Force

"CENTRIFUGAL/CENTRIPETAL FORCE","","","CENTRIF"
"""

import hamcalc.math.centrif as centrif

def solver():
    args= dict()
    force_raw= input(" ENTER: Force in newtons? ")
    if len(force_raw) != 0:
        args['F']= float( force_raw )
    mass_raw= input(" ENTER: Mass in kilograms? ")
    if len(mass_raw) != 0:
        args['M']= float( mass_raw )
    velocity_raw= input(" Velocity in metres/second? ")
    if len(velocity_raw) != 0:
        args['V']= float( velocity_raw )
    radius_raw= input(" Radius of orbit in metres? ")
    if len(radius_raw) != 0:
        args['R']= float( radius_raw )
    args= centrif.centrif( **args )

    f_n= centrif.NEWTON.to_std( args.F )
    f_lb_f= centrif.POUND_FORCE.from_std( f_n )
    print(" Force........... {0:8.3f} N  =    {1:8.3f} lb_f".format(f_n, f_lb_f) )
    m_kg= centrif.KILOGRAM.to_std( args.M )
    m_lb_m= centrif.POUND_MASS.from_std( m_kg )
    print(" Mass............ {0:8.3f} kg =    {1:8.3f} lb_m".format(m_kg,m_lb_m) )
    v_msec= centrif.M_PER_SEC.to_std( args.V )
    v_fsec= centrif.FT_PER_SEC.from_std( v_msec )
    print(" Velocity........ {0:8.3f} m/sec = {1:8.3f} ft/sec".format(v_msec,v_fsec) )
    r_m= centrif.METRE.to_std( args.R )
    r_ft= centrif.FOOT.from_std( r_m )
    print(" Orbital Radius.. {0:8.3f} m =     {1:8.3f} ft".format(r_m,r_ft) )

print( centrif.intro() )

z=None
while z != '0':
    z= input( "ENTER 1 to continue, 0 to EXIT? " )
    if z == '1':
        solver()
