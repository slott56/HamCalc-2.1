"""Exposure Calculator

"EXPOSURE CALCULATOR",", photographic","","\HAMCALC\FOTOCALC\FOTOMENU"
"""
import hamcalc.audio_photo.exposure as exposure
from hamcalc.stdio import *

def camera():
    print( "CAMERA EXPOSURES" )
    print()
    C= input_float( "ENTER: Footcandles (if known) .....? " )
    I= input_float( "ENTER: Film Speed ..............ISO? " )
    S_text= input( "ENTER: Exposure (sec. e.g. 1/60)...? " )
    if len(S_text) == 0:
        S= None
    elif "/" in S_text:
        n,d= map( int, S_text.split('/') )
        S= n/d
    else:
        S= float(S_text)
    F= input_float( "ENTER: Aperture .................ƒ/? " )
    display_camera( C=C, I=I, S=S, F=F )

def display_camera( C=None, I=None, S=None, F=None ):
    results= exposure.camera( C=C, I=I, S=S, F=F )
    print( "EQUIVALENT EXPOSURES" )
    template= """\
Footcandles ................{C:5.0f}
Film Speed ..............ISO{I:5.0f}
Exposure (sec. e.g. 1/60).1/{S_I:<.0f} {S:f} sec.
Aperture .................ƒ/{F:<.1f}

for {C} Footcandles of illumination with ISO {I} film ( EV {EV} )
"""
    results.S_I = int(1/S)
    print( template.format( **results ) )

    row= """\
{S_1:10.4f} sec. @ ƒ/{F_1:<4.1f}      | {S_2:10.4f} sec. @ ƒ/{F_2:<4.1f}"""
    for f_s_1, f_s_2 in zip(
        exposure.aperture_iter( results ),
        exposure.exposure_iter( results ) ):
        F_1, S_1 = f_s_1
        F_2, S_2 = f_s_2
        print( row.format( F_1=F_1, S_1=S_1, F_2=F_2, S_2=S_2 ) )

def enlarger():
    print( "ENLARGER EXPOSURES" )
    print()
    print( " KNOWN EXPOSURE DATA FOR A GIVEN IMAGE" )
    print( " NOTE: All dimensional data must be in the same units, e.g. inches, millimetres." )
    F_O= input_float( "ENTER: Aperture ..............ƒ/? " )
    S_text= input( "ENTER: Exposure (sec. e.g. 1/60)? " )
    if len(S_text) == 0:
        S_O= None
    elif "/" in S_text:
        n,d= map( int, S_text.split('/') )
        S_O= n/d
    else:
        S_O= float(S_text)

    L_O= input_float( "ENTER: Image length..........? " )
    W_O= input_float( "ENTER: Image width ..........? " )
    H_O= input_float( "ENTER: Lens height (if known)? " )

    print( " EXPOSURE DATA FOR NEW IMAGE" )

    L = input_float( "ENTER: Image length ............? " )
    W = input_float( "ENTER: Image width .............? " )
    F = input_float( "ENTER: Aperture...............ƒ/? " )
    S_text=  input( "ENTER: Exposure (sec. e.g. 1/60)? " )
    if len(S_text) == 0:
        S= None
    elif "/" in S_text:
        n,d= map( int, S_text.split('/') )
        S= n/d
    else:
        S= float(S_text)

    display_enlarger( F_O=F_O, S_O=S_O, L_O=L_O, W_O=W_O,
        H_O=H_O, L=L, W=W, F=F, S=S )

def display_enlarger( F_O=None, S_O=None, L_O=None, W_O=None,
        H_O=None, L=None, W=None, F=None, S=None ):
    results= exposure.enlarger( F_O=F_O, S_O=S_O, L_O=L_O, W_O=W_O,
        H_O=H_O, L=L, W=W, F=F, S=S )
    results.S_I = int(1/S)

    template= """\
  Image.........  {L} x {W}
  Exposure......  1/{S_I} ({S:.4f}) seconds @ ƒ/{F:.1f}
"""
    print( template.format(**results) )

def filter():
    print( "EXPOSURE FACTOR / FILTER FACTOR" )
    print()
    S_text= input( "ENTER: Exposure without factor (sec. e.g. 1/60)...? " )
    if len(S_text) == 0:
        S= None
    elif "/" in S_text:
        n,d= map( int, S_text.split('/') )
        S= n/d
    else:
        S= float(S_text)
    F= input_float( "ENTER: Aperture without factor .................ƒ/? " )
    X= input_float( "ENTER: Exposure / Filter factor ..................? " )
    display_filter( S=S, F=F, X=X )

def display_filter( S=None, F=None, X=None ):
    S_I_f, F_f = exposure.filter( S=S, F=F, X=X )
    template= "1/{S_I} ({S:.4f}) sec. @ ƒ/{F:<4.1f}"
    print( "New Exposure with factor ..." )
    print( template.format( S_I= S_I_f, S=1/S_I_f, F=F ) )
    print( "or...." )
    print( template.format( S_I= 1/S, S=S, F=F_f ) )

print( "EXPOSURE CALCULATOR" )

z=None
while z != '0':
    print( "< 1 >  CAMERA exposures" )
    print( "< 2 >  ENLARGER exposures" )
    print( "< 3 >  EXPOSURE / FILTER factor" )
    print()
    print( "< 0 >  EXIT" )
    z= input( "CHOICE? " )
    if z == '1':
        camera()
    elif z == '2':
        enlarger()
    elif z == '3':
        filter()
