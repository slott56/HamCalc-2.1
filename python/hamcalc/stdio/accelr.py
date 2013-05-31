"""Acceleration Calculator

"ACCELERATION CALCULATOR","","","ACCELR"
"G FORCE","","","ACCELR"
"""

import hamcalc.math.accelr as accelr

def solve():
    """Gather Inputs for Acceleration/Force Problems."""
    m= input( "ENTER: Mass of moving object in kg? " )
    d= input( "ENTER: Displacement in metres ? " )
    t= input( "ENTER: Duration of motion in seconds ? " )
    v_o= input( "ENTER: Velocity at START of acceleration (metres/second)? " )
    v_f= input( "ENTER: Velocity at END of acceleration (metres/second)? " )

    args = dict()
    try:
        if m: args['m']= float(m)
        if d: args['d']= float(d)
        if t: args['t']= float(t)
        if v_o: args['v_o']= float(v_o)
        if v_f: args['v_f']= float(v_f)
        display( **args )
    except ValueError as e:
        print( e )

def display( **args_r ):
    """Compute and display results."""
    args_a= accelr.accel( **args_r )
    args= accelr.force( **args_a )
    args['f_g']= args['f']/accelr.g

    print("ACCELERATION CALCULATION")
    print()

    template="""\
Mass of moving object (kilograms)..M= {m:10.3f}
Displacement (metres)..............D= {d:10.3f}
Duration of motion (seconds).......T= {t:10.3f}
Start velocity (metres/second)....Vo= {v_o:10.3f}
End velocity (metres/second)......Vf= {v_f:10.3f}
Acceleration constant (m./sec.)....A= {a:10.3f}
Acceleration force (newtons).......F= {f:10.3f}
Force (standard gravitys)............ {f_g:10.3f}

(Standard gravity <g-force> is 9.80665 metres/second²).
"""

    print( template.format(**args) )

print( accelr.intro() )

z= None
while z != '0':
    print()
    print( " ENTER 1 to continue or 0 to EXIT" )
    z= input( "Choice? " )
    if z == '1':
        solve()

