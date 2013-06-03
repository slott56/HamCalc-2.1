"""Guy Wires for Antenna Towers/Masts
"""
import hamcalc.construction.guywire as guywire
from hamcalc.math.equiv import FOOT, METRE

def design():
    print( "   < 1 >  Metric" )
    print( "   < 2 >  U.S.A./Imperial" )
    u_raw= input( "UNITS? " )
    if u_raw not in ( '1', '2' ): return

    unit= {'1': METRE, '2': FOOT }[u_raw]

    labels = {}
    for n, f in enumerate(guywire.J_Factor):
        labels[n+3]= f
        print( "   < {0} >  {1}".format(n+3,f) )
    tp_raw = input( "TYPE? " )
    try:
        tp= int(tp_raw)
    except ValueError:
        return
    J= guywire.J_Factor[labels[tp]]
    if J is None:
        # "Other": prompt for J
        J_raw= input( " ENTER: Maximum vertical distance between guy wire sets ({0})? ".format(unit.name) )
        try:
            J= float(J_raw)
        except ValueError:
            pass

    H_raw= input( " ENTER: Height of {0}................({1})? ".format(labels[tp],unit.name) )
    try:
        H= float(H_raw)
    except ValueError:
        return

    minimum, recommended= guywire.minimim_recommended( H )

    template_1= """\
       MINIMUM distance to anchor points..................... {1:6.2f} {0.name}
       RECOMMENDED distance to anchor points............about {2:6.2f} {0.name}
"""
    print( template_1.format( unit, minimum, recommended ) )

    R_raw= input( " ENTER: Your choice of distance to anchor points ({0}).......? ".format(unit.name) )
    try:
        R= float(R_raw)
    except ValueError:
        pass

    display( unit, H, R, J )

def display( unit, H, R, J ):
    args= dict( H=H, R=R, J=J, unit=unit )
    args = guywire.guywire_f( **args )

    summary= """\
       Number of guy wire sets............................... {N:3d}
       Guy wire anchors - distance from tower/mast........... {R:6.2f} {unit.name}
"""
    print( summary.format( **args ) )

    heading= """\
Set       Height above   Guy Wire    Tower    Non-Resonant    Anchor
No.          Ground       Length  =   End   +   Segments   +   End      Slope
"""

    line= """\
{next:2d}         {H:6.2f} {unit.name}   {GW:6.2f} {unit.name} {space:6.2f} {unit.name} {C:2d} @ {GW_C:6.2f} {unit.name}  {space:6.2f} {unit.name} {theta_d:6.2f}°±
"""
    print( heading )
    while args.next:
        print( line.format( **args ) )
        args = guywire.guywire_f( **args )

print( guywire.intro() )

z = None
while z != '0':
    z= input( "ENTER 1 to continue or 0 to EXIT? " )
    if z == '1':
        design()
