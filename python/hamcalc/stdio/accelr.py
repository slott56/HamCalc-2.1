"""Acceleration Calculator

"ACCELERATION CALCULATOR","","","ACCELR"
"G FORCE","","","ACCELR"
"""

import hamcalc.math.accelr as accelr
from hamcalc.stdio import *

def solve():
    """Gather Inputs for Acceleration/Force Problems."""
    m= input_float( "ENTER: Mass of moving object in kg? " )
    d= input_float( "ENTER: Displacement in metres ? " )
    t= input_float( "ENTER: Duration of motion in seconds ? " )
    v_o= input_float( "ENTER: Velocity at START of acceleration (metres/second)? " )
    v_f= input_float( "ENTER: Velocity at END of acceleration (metres/second)? " )

    display( m=m, d=d, t=t, v_o=v_o, v_f=v_f )

def display( **args_r ):
    """Compute and display results."""
    args_a= accelr.accel( **args_r )
    args= accelr.force( **args_a )
    args.f_g= args.f/accelr.g

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
    z= input( "CHOICE? " )
    if z == '1':
        solve()

