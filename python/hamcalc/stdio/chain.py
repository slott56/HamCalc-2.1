"""Chain

"DRIVES",", chain","","\HAMCALC\MECHCALC\MECHMENU"
"CHAIN DRIVES","","","MECHMENU"
"""
import hamcalc.construction.chain as chain
from hamcalc.stdio import *

def chain_design( X=None, Y=None, A=None, B=None, M=None ):
    if A is None:
        A= input_int( "No. of teeth in sprocket A ..........? " )
    if B is None:
        B= input_int( "No. of teeth in sprocket B ..........? " )
    if A is None or B is None: return
    A, B = max(A,B), min(A,B)
    while M is None:
        c_raw= input( "ENTER: Chain No., or pitch in decimal inches ...? " )
        if c_raw in chain.material:
            M= chain.material[c_raw]
        else:
            try:
                P= float( c_raw )
            except ValueError as e:
                print(e)
                return
            for ch in chain.material:
                if abs(ch.P-P) < 0.001:
                    M= ch
                    break
            print( "NO SUCH CHAIN {0!r}".format(c_raw) )

    V_1, I, S, R= chain.design_sprocket_distances( A, B, M )

    # Show inputs so far...
    print( "Chain Number .............. {0:6s}".format(M.name) )
    print( "Chain pitch   (inches)..... {0:10,.3f}".format(M.P) )
    print( "SMALL SPROCKET-No.teeth.... {0:6d}".format(A) )
    print( "              -Pitch dia... {0:10,.3f}".format(I) )
    if X:
        print( "              -R.P.M. ..... {0:10,.3f}".format(X) )
    print( "LARGE SPROCKET-No.teeth.... {0:6d}".format(B) )
    print( "              -Pitch dia... {0:10,.3f}".format(S) )
    if Y:
        print( "              -R.P.M. ..... {0:10,.3f}".format(Y) )
    print( "Ratio ..................... {0:10,.3f}:1".format(R) )
    print( "Minimum c.c.  (inches)..... {0:10,.3f}".format(V_1) )

    # Get desired center-to-center distance.
    V_2= input_float( "ENTER desired approx. c.c. ........? " )
    if V_2 is None: return

    C, L, L_P = chain.final_sprocket_distance( A, B, M, V_2 )
    print( "Actual  c.c.  (inches)..... {0:10,.3f}".format(C) )
    print( "Chain length  (inches)..... {0:10,.3f}".format(L_P) )
    print( "Chain length  (pitches).... {0:10,.3f}".format(L) )

def sprocket_design():
    X= input_float( "RPM Sprocket A ..................? " )
    Y= input_float( "RPM Sprocket B ..................? " )
    if X is None or Y is None: return
    X, Y = max(X,Y), min(X,Y)
    if X/Y >= 6:
        print( "Ratio greater than 6:1 not recommended !" )
        print( "Try an intermediate jack shaft with the following R.P.M.'s :" )
        Z = math.sqrt( X/Y )
        print( "{0:10,.3f} {1:10,.3f} {2:10,.3f}".format( Y, Y*Z, X ) )
        print( "Double {0:6.3f}:1 reduction".format(Z) )
        return
    W= input_int( "Minimum teeth, small sprocket ...? " )
    if W < 17:
        print( "Less than 17 teeth not advised" )
    choices= [ row for row in chain.sprocket_choice_iter( X, Y, W ) ]
    for a, b, exact in choices:
        print( "{0:4d}&{1:4d}{2:s}".format(a, b, "*" if exact else "") )
    confirm = '0'
    while confirm == '0':
        B= input_int( "Choose a small sprocket ... how many teeth? " )
        if B < 17:
            print( "Less than 17 teeth not advised" )
        A_B, R, E_J, K_D = chain.design_sprocket_size( X, Y, B )
        A, B = A_B
        E, J = E_J
        K, D = K_D
        if abs(E-K) < 0.1:
            print( "With", B, "T.&", A, "T.sprockets, RPM's are", round(E), "&", round(J), "*" )
        else:
            print( "With", B, "T.&", A, "T.sprockets , RPM's are either", round(E), "&", round(J), "or", round(K), "&", round(D) )
        confirm= input( "ENTER 0 to choose another combination" )
    if abs(E-K) >= 0.1:
        print( "RPM options are: (a) {0:10,.3f}: {1:10,.3f}".format(E,J) )
        print( "                 (b) {0:10,.3f}: {1:10,.3f}".format(K,D) )
        z = None
        while z not in ('a', 'b'):
            z = input( " ENTER letter in ( ) to select RPM option.........? " ).lower()
        if z == 'a':
            X, Y = E, J
        elif z == 'b':
            X, Y = K, D
    else:
        X, Y = E, J

    H= input_float( "ENTER: Drive horsepower.....? " )
    if H is None:
        chain_design( X, Y, A, B )
        return

    chains = list( chain.design_chain_iter( A, B, X, Y, H ) )

    confirm= '0'
    while confirm == '0':
        M, NS = chains.pop(0)
        print( "This drive requires", NS, "strand" if NS == 1 else "strands", "of #", M.name, "chain" )
        confirm= input( "ENTER 0 to choose another combination" )
    chain_design( X, Y, A, B, M )

    print( "Chain Number .............. {0:6s}".format(M.name) )
    print( "Tensile strength (lbs.) ... {0:10.0f}".format(M.TS) )
    print( "Drive horsepower .......... {0:10,.3f}".format(H) )

    # tension and torque.
    Q, T_A, T_B = chain.tension_torque( A, B, X, Y, H, M )
    print( "Chain tension (lbs.)....... {0:10,.3f}".format(Q) )
    print( "In.Lb., small sprkt.shaft.. {0:10,.3f}".format(T_B) )
    print( "In.Lb., large sprkt.shaft.. {0:10,.3f}".format(T_A) )

    print(  "Number of strands ......... {0:6d}".format(NS) )


print( chain.intro() )
z=None
while z != '0':
    print( "  (1)  Sprockets known    - chain data required" )
    print( "  (2)  Shaft speeds known - sprocket & chain data required" )
    print( "  (0)  Exit")
    z= input( "CHOICE? " )
    if z == '1':
        chain_design()
    elif z == '2':
        sprocket_design()
