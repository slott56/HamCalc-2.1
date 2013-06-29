"""Belt Drives

"DRIVES",", belt","","\HAMCALC\MECHCALC\MECHMENU"
"BELT DRIVES","","","MECHMENU"
"""
import hamcalc.construction.beltdriv as beltdriv
from hamcalc.stdio import *
import string

def belt_design( D=None, E=None ):
    """Belt-length design."""
    if D is None:
        D = input_float("ENTER: Pitch dia. - Pulley A  (in.)...? ")
    if E is None:
        E = input_float("ENTER: Pitch dia. - Pulley B  (in.)...? ")
    if D is None or E is None: return
    if D < E: D, E = E, D

    print( "Pitch diameter - small pulley....... {0:8.3f}".format(E) )
    print( "Pitch diameter - large pulley....... {0:8.3f}".format(D) )
    I, G = beltdriv.design_pulley_distances( D, E )

    print( "Minimum c.c.(in.)................... {0:8.3f}".format(I) )
    print( "Ideal   c.c.(in.)(V-belt drives).... {0:8.3f}".format(G) )
    C= input_float( "ENTER: Desired c.c.distance (in.)...? " )
    if C is None: return
    M= beltdriv.design_belt_length( D, E, C )

    print( "Design Belt length (in.)............ {0:8.3f}".format(M) )
    L= input_float( "ENTER: Nearest standard belt (in.)..? " )

    C= None
    while C is None:
        try:
            C= beltdriv.final_pulley_distance( D, E, L )
        except beltdriv.BeltTooShort as e:
            print( "BELT TOO SHORT - Try a longer belt!" )
            continue
    print( "Actual  c.c.(in.)................... {0:8.3f}".format(C) )
    print( "Length of standard belt to use ..... {0:8.3f}".format(L) )

def input_diameter_iter():
    """Produce a sequence of pulley diameters."""
    print("Enter the pitch diameters of a few standard pulleys:")
    print("(Press [ENTER] to end your list)")
    for x in range(12):
        P= input_float( "ENTER Pitch diameter ........? " )
        if P is None: return
        yield P

def pulley_design():
    """Complete pulley system design."""
    X= input_float( "ENTER: Known R.P.M. ................? " )
    Y= input_float( "ENTER: Sought R.P.M. ...............? " )
    print()
    A= list(input_diameter_iter())
    choices= list(beltdriv.pulley_choice_iter( X, Y, *A ))
    menu= string.ascii_lowercase[:len(choices)]
    for i, pair in enumerate( choices ):
        print( " (", menu[i], ") ", pair )
    z= ' '
    while z not in menu:
        z = input( "ENTER a combination where the pulleys are close to stock pitch diameters? " ).lower()
    W, V= choices[menu.find(z)]

    # One of the two is in the "A" list.
    # The other was calculated and must be replaced with a standard size.
    if W in A:
        V= input_float( "ENTER: Pitch dia. of standard pulley that is close to {0:8.3f}? ".format(V) )
    else:
        W= input_float( "ENTER: Pitch dia. of standard pulley that is close to {0:8.3f}? ".format(W) )
    if W is None or V is None: return

    # Compute actual Y RPM from chosen pulleys.
    Y = X * W/V
    print( "Other  R.P.M. ...................... {0:8.3f}".format(Y) )

    belt_design( W, V )

    # Torque based on X, W, V and Horsepower
    HP= input_float( "ENTER: Drive horsepower ............? " )
    if HP is None: return

    V, T, T_E, T_D = beltdriv.tension_torque( W, V, X, HP )
    print( "Velocity (ft./min.) of belt(s)...... {0:8.3f}".format(V) )
    print( "Tension  (lbs.) on belt(s).......... {0:8.3f}".format(T) )
    print( "In./lb. torque - small pulley shaft  {0:8.3f}".format(T_E) )
    print( "In./lb. torque - large pulley shaft  {0:8.3f}".format(T_D) )

print( beltdriv.intro() )
z= None
while z != '0':
    print(" Press number in < > to select:")
    print()
    print("  < 1 >  Pulleys known" )
    print("  < 2 >  Pulleys unknown, R.P.M.'s known")
    print()
    print("  < 0 >  Exit")
    z= input( "CHOICE? " )
    if z == '1':
        belt_design()
    elif z == '2':
        pulley_design()
