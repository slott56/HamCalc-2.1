"""ELECTRONIC FLASH
"""
import hamcalc.audio_photo.elflash as elflash
from hamcalc.math.equiv import METRE, FOOT
from hamcalc.lib import convert
from hamcalc.stdio import *

introduction= "ELECTRONIC FLASH CALCULATOR"

def solve(find=None):
    """Gather input values for one of the various scenarios.

    :param find: The variable we're going to be finding,
        this must be one of "B", "A", "G", "D" or "F".
    """
    assert find in ( "B", "A", "G", "D", "F" )
    if find == 'B' or find == 'D' or find == 'F':
        B= None
    else:
        B= input_float( "ENTER: Beam Candle Power Seconds ..........? " )
    if find == 'A' or find == 'D' or find == 'F':
        A= None
    else:
        A= input_float( "ENTER: Film speed ......................ISO? " )
    if find == 'G':
        G= None
    else:
        G= input_float( "ENTER: Guide Number (metres)...............? " )
        if G is not None:
            G= FOOT.from_std( METRE.to_std( G ) )
        else:
            G= input_float( "ENTER: Guide Number (feet).................? " )
    if find == 'D' or find == 'B' or find == 'A':
        D= None
    else:
        D= input_float( "ENTER: Subject distance (metres) ..........? " )
        if D is not None:
            D= FOOT.from_std( METRE.to_std( D ) )
        else:
            D= input_float( "ENTER: Subject distance (feet) ............? " )
    if find == 'F' or find == 'B' or find == 'A':
        F= None
    else:
        F= input_float( "ENTER: Aperture .........................ƒ/? " )
    display( B=B, A=A, G=G, D=D, F=F )

def display( B=None, A=None, G=None, D=None, F=None ):
    """Compute and display results.

    Note that partial results are possible.

    :param F: Aperture, ƒ/
    :param G: Guide number in feet
    :param A: Film speed, ISO
    :param B: Beam Candle Power Seconds
    :param D: Subject distance in feet
    """
    results= elflash.flash( B=B, A=A, G=G, D=D, F=F )
    results.D_m= METRE.from_std( FOOT.to_std( results.D ) )

    if results.F is not None:
        if abs(results.F-int(results.F)) > .01:
            print( "Aperture ...................... ƒ/{F:<4.1f}".format(**results) )
        else:
            print( "Aperture ...................... ƒ/{F:<4.0f}".format(**results) )
    if results.G is not None:
        results.G_m= METRE.from_std( FOOT.to_std( results.G ) )
        print( "Guide Number (metres) ......... {G_m:7.1f}".format(**results) )
        print( "Guide Number (feet) ........... {G:7.1f}".format(**results) )
    if results.A is not None:
        print( "Film speed .................ISO {A:5.0f}".format(**results) )
    if results.B is not None:
        print( "Beam Candle Power Seconds ..... {B:5.0f}".format(**results) )
    if results.D is not None:
        print( "Subject distance (metres) ..... {D_m:7.1f}".format(**results) )
        print( "Subject distance (feet) ....... {D:7.1f}".format(**results) )

    if results.G is not None:
        f_template_1= "Use ƒ/{F:.<4.1f}...........{D_m:5.1f} m. ({D_f:5.1f} ft.)"
        f_template_0= "Use ƒ/{F:.<4.0f}...........{D_m:5.1f} m. ({D_f:5.1f} ft.)"
        for F, D_f in elflash.aperture_iter( results.G ):
            D_m = convert( D_f, FOOT, METRE )
            if abs(F-int(F)) > .01:
                print( f_template_1.format( D_m=D_m, D_f=D_f, F=F ) )
            else:
                print( f_template_0.format( D_m=D_m, D_f=D_f, F=F ) )

print( introduction )
z= None
while z != '0':
    print("  < 1 >  Find BCPS (Beam Candlepower Seconds) rating" )
    print("  < 2 >  Find I.S.O. rating of film" )
    print("  < 3 >  Find Guide Number" )
    print("  < 4 >  Find Subject Distance" )
    print("  < 5 >  Find Lens Aperture (ƒ/ setting)" )
    print()
    print("  < 0 >  EXIT" )
    z= input( "CHOICE? " )
    if z == '1':
        solve( find='B' )
    elif z == '2':
        solve( find='A' )
    elif z == '3':
        solve( find='G' )
    elif z == '4':
        solve( find='D' )
    elif z == '5':
        solve( find='F' )
