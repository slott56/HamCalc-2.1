"""Belt Drives

"DRIVES",", belt","","\HAMCALC\MECHCALC\MECHMENU"
"BELT DRIVES","","","MECHMENU"
"""
import hamcalc.construction.beltdriv as beltdriv
import string

def belt_design( D=None, E=None ):
    """Belt-length design."""
    if D is None:
        try:
            raw_d= input("ENTER: Pitch dia. - Pulley A  (in.)...? ")
            D= float(raw_d)
        except ValueError as e:
            print( e )
            return
    if E is None:
        try:
            raw_e= input("ENTER: Pitch dia. - Pulley B  (in.)...? ")
            E= float(raw_e)
        except ValueError as e:
            print( e )
            return
    if D < E: D, E = E, D
    print( "Pitch diameter - small pulley....... {0:8.3f}".format(E) )
    print( "Pitch diameter - large pulley....... {0:8.3f}".format(D) )

    I, G = beltdriv.design_pulley_distances( D, E )
    print( "Minimum c.c.(in.)................... {0:8.3f}".format(I) )
    print( "Ideal   c.c.(in.)(V-belt drives).... {0:8.3f}".format(G) )
    try:
        raw_c= input( "ENTER: Desired c.c.distance (in.)...? " )
        C= float(raw_c)
    except ValueError as e:
        print( e )
        return
    M= beltdriv.design_belt_length( D, E, C )
    print( "Design Belt length (in.)............ {0:8.3f}".format(M) )
    try:
        raw_l= input( "ENTER: Nearest standard belt (in.)..? " )
        L= float(raw_l)
    except ValueError as e:
        print( e )
        return
    C= None
    while C is None:
        try:
            C= beltdriv.final_pulley_distance( D, E, L )
        except beltdriv.BeltTooShort as e:
            print( "BELT TOO SHORT - Try a longer belt!" )
            continue
    print( "Actual  c.c.(in.)................... {0:8.3f}".format(C) )
    print( "Length of standard belt to use ..... {0:8.3f}".format(L) )

def diameters():
    """Produce a sequence of pulley diameters."""
    print("Enter the pitch diameters of a few standard pulleys:")
    print("(Press [ENTER] to end your list)")
    for x in range(12):
        try:
            raw_p= input( "ENTER Pitch diameter ........? " )
            if len(raw_p) == 0: return
            P= float(raw_p)
            yield P
        except ValueError as e:
            print(e)

def pulley_design():
    """Complete pulley system design."""
    try:
        x_raw= input( "ENTER: Known R.P.M. ................? " )
        X= float(x_raw)
        y_raw= input( "ENTER: Sought R.P.M. ...............? " )
        Y= float(y_raw)
    except ValueError as e:
        print( e )
        return
    print()
    A= list(diameters())
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
    try:
        if W in A:
            raw_v= input( "ENTER: Pitch dia. of standard pulley that is close to {0:8.3f}? ".format(V) )
            V= float(raw_v)
        else:
            raw_w= input( "ENTER: Pitch dia. of standard pulley that is close to {0:8.3f}? ".format(W) )
            W= float(raw_w)
    except ValueError as e:
        print( e )
        return

    # Compute actual Y RPM from chosen pulleys.
    Y = X * W/V
    print( "Other  R.P.M. ...................... {0:8.3f}".format(Y) )

    belt_design( W, V )

    # Torque based on X, W, V and Horsepower
    try:
        raw_hp= input( "ENTER: Drive horsepower ............? " )
        HP= float( raw_hp )
    except ValueError as e:
        print( e )
        return

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
