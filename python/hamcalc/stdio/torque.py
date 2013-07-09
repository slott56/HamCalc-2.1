"""Torque & Horsepower

"HORSEPOWER",", vs. torque","","MECHMENU"
"TORQUE",", vs. horsepower","","MECHMENU"
"""
import hamcalc.construction.torque as torque
from hamcalc.stdio import *

def solve():
    print( "ENTER factors if known or Press [ENTER] if unknown." )
    R= input_float( "R.P.M. ....................? " )
    D= input_float( "Pitch dia.(gear/sprkt.) ...? " )
    T= input_float( "Torque (in.lb.) ...........? " )
    H= input_float( "Horsepower ................? " )
    W= input_float( "Force in lb.(belt/chain tension) ? " )
    V= input_float( "Velocity (feet/min.) ......? " )
    display( R=R, D=D, T=T, H=H, W=W, V=V )

def display( R=None, D=None, T=None, H=None, W=None, V=None ):
    """
    :param R: R.P.M.
    :param D: Pitch dia.(gear/sprkt.)
    :param T: Torque (in.lb.)
    :param H: Horsepower
    :param W: Force in lb.(belt/chain tension)
    :param V: Velocity (feet/min.)
    """
    result= torque.torque( R=R, D=D, T=T, H=H, W=W, V=V )
    template= """\
TORQUE, H.P. & R.P.M. SPECIFICATIONS

R.P.M. .................... {R:10,.3f}
Pitch dia.(gear/sprkt.) ... {D:10,.3f}
Torque (in.lb.) ........... {T:10,.3f}
Horsepower ................ {H:10,.3f}
Force / Tension (lb.)...... {W:10,.3f}
Velocity (feet/min.) ...... {V:10,.3f}
"""
    print( template.format( **result ) )

print( torque.intro() )
z=None
while z != '0':
    print( " < 1 > Torque, horsepower & RPM program" )
    print( " < 0 > Exit" )
    z= input( "CHOICE? " )
    if z == "1":
        solve()

