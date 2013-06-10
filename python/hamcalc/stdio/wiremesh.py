"""Wire Mesh Screens -- Wind Loads

"REFLECTORS",", wire mesh","","WIREMESH"
"SCREENING",", wire mesh","","WIREMESH"
"WIRE MESH SCREENS","","","WIREMESH"
"""
import hamcalc.construction.wiremesh as wiremesh
from hamcalc.lib import convert
from hamcalc.math.equiv import INCH, MILLIMETRE, SQ_METRE, SQ_FOOT
from hamcalc.math.centrif import KILOGRAM, POUND_MASS
from hamcalc.navigation.satorbit import KPH, MPH, MPM, KNOT, MPS

def solve():
    a_raw= input("ENTER: c.c. Distance across mesh opening.......(in.)? ")
    try:
        A= float(a_raw)
    except ValueError as e:
        print( e )
        return
    d_raw= input("ENTER: Wire diameter...........................(in.)? ")
    try:
        D= float(d_raw)
    except ValueError as e:
        print( e )
        return
    sa_raw=input("ENTER: Screen area.............................(ft²)? ")
    try:
        SA= float(sa_raw)
    except ValueError as e:
        print( e )
        return
    template = """\
ENTER: {0:.<45s} {1:8.3f} in. {2:8.1f} mm
ENTER: {3:.<45s} {4:8.3f} in. {5:8.1f} mm
ENTER: {6:.<45s} {7:8.3f} ft² {8:8.1f} m²
"""
    print( template.format(
        "c.c. Distance across mesh opening", A, convert(A,INCH,MILLIMETRE),
        "Wire diameter", D, convert(D,INCH,MILLIMETRE),
        "Screen area", SA, convert(SA,SQ_FOOT,SQ_METRE),
        )
    )
    display( A, D, SA )

def display( A, D, SA ):
    wm= wiremesh.mesh( A, D, SA )
    summary= """\
        Weight of this area of mesh: aluminum wire... {0:5.1f} lb.  {1:8.1f} kg
                                    steel wire......  {2:5.1f} lb.  {3:8.1f} kg
                                    copper wire.....  {4:5.1f} lb.  {5:8.1f} kg
       Percent of screen area filled by wire........  {6:6.1%}
       Wind vane area (screen area filled by wire)..  {7:5.1f} ft²  {8:8.1f} m²
"""
    print( summary.format(
        wm.TV*wiremesh.Al_lb_cu_in, convert(wm.TV*wiremesh.Al_lb_cu_in, POUND_MASS, KILOGRAM),
        wm.TV*wiremesh.Cu_lb_cu_in, convert(wm.TV*wiremesh.Cu_lb_cu_in, POUND_MASS, KILOGRAM),
        wm.TV*wiremesh.S_lb_cu_in,  convert(wm.TV*wiremesh.S_lb_cu_in, POUND_MASS, KILOGRAM),
        wm.FF,
        wm.FA, convert(wm.FA, SQ_FOOT, SQ_METRE),
        )
    )
    print("Wind load on this area of vertical mesh at various wind speeds:")
    detail= "   @ {W_k:2.0f} knots = {W_mph:2.0f} mph = {W_kph:3.0f} km/hr = Beaufort {W_b:2.0f}...  {Y_lb:6.1f} lb.   {Y_n:6.1f} kg"
    for x in range(1,12):
        k = (x+1)*5
        f = wiremesh.force( A=.25, D=.0625, SA=12, W_k= k )
        print( detail.format(**f) )

print( wiremesh.intro() )
z= None
while z != '0':
    z= input( "ENTER 1 to continue or 0 to quit.... " )
    if z == '1':
        solve()
