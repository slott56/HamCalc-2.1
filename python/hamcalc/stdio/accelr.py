"""Acceleration Calculator

"ACCELERATION CALCULATOR","","","ACCELR"
"G FORCE","","","ACCELR"
"""

import hamcalc.math.accelr as accelr

def solve():
    m= input( "ENTER: Mass of moving object in kg? " )
    d= input( "ENTER: Displacement in metres ? " )
    t= input( "ENTER: Duration of notion in seconds ? " )
    v_o= input( "ENTER: Velocity at START of acceleration (metres/second)? " )
    v_f= input( "ENTER: Velocity at END of acceleration (metres/second)? " )

    args = dict()
    if m: args['m']= float(m)
    if d: args['d']= float(d)
    if t: args['t']= float(t)
    if v_o: args['v_o']= float(v_o)
    if v_f: args['v_f']= float(v_f)

    args= accelr.accel( **args )
    args= accelr.force( **args )
    args['f_g']= args['f']/accelr.g

    print("ACCELERATION CALCULATION")
    print()

    print( "Mass of moving object (kilograms)..M= {m:10.3f}".format(**args) )
    print( "Displacement (metres)..............D= {d:10.3f}".format(**args) )
    print( "Duration of motion (seconds).......T= {t:10.3f}".format(**args) )
    print( "Start velocity (metres/second)....Vo= {v_o:10.3f}".format(**args) )
    print( "End velocity (metres/second)......Vf= {v_f:10.3f}".format(**args) )
    print( "Acceleration constant (m./sec.)....A= {a:10.3f}".format(**args) )
    print( "Acceleration force (newtone).......F= {f:10.3f}".format(**args) )
    print( "Force (standard gravitys)............ {f_g:10.3f}".format(**args) )
    print()
    print( "(Standard gravity <g-force> is 9.80665 metres/second²)." )

print( accelr.intro() )

z= None
while z != '0':
    print()
    print( " ENTER 1 to continue or 0 to EXIT" )
    z= input( "Choice? " )
    if z == '1':
        solve()

