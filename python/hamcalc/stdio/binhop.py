"""Bins and Hoppers

"BINS",", round or square","","BINHOP"
"BINS",", side or center draw hopper","","BINHOP"
"HOPPERED BINS AND RANKS","","","BINHOP"
"""
import hamcalc.construction.binhop as binhop
from hamcalc.stdio import *

def discharge():
    print( "Press number in ( ) to indicate hopper discharge:" )
    print( "(1) Side draw" )
    print( "(2) Center draw" )
    draw= None
    while draw is None:
        y= input( "CHOICE? " )
        if y == '1': draw= binhop.Side()
        if y == '2': draw= binhop.Center()
    return draw

def analyze():
    """The :program:`binhop` program."""
    print( "  Press number in ( ) to indicate shape of bin:" )
    print( "(1) Round" )
    print( "(2) Rectangular" )
    model= None
    while model is None:
        b= input( "CHOICE? " )
        if b == '1':
            model= binhop.Cylindrical()
            D= input_float( "ENTER: Outlet D...............diameter =? " )
            model.draw= discharge()
            H= input_float( "ENTER: Hopper height H.................=? " )
            F= input_float( "ENTER: Bin diameter F..................=? " )
            J= input_float( "ENTER: Bin wall height J...............=? " )
            cyl_display( model, D=D, F=F, H=H, J=J  )
        elif b == '2':
            model= binhop.Rectangular()
            D= input_float( "ENTER: Outlet D..................width =? " )
            E= input_float( "ENTER: Outlet D.................length =? " )
            D, E = min(D,E), max(D,E)
            model.draw= discharge()
            H= input_float( "ENTER: Hopper height H.................=? " )
            F= input_float( "ENTER: Bin width F.....................=? " )
            G= input_float( "ENTER: Bin length F....................=? " )
            J= input_float( "ENTER: Bin wall height J...............=? " )
            F, G = min(F,G), max(F,G)
            rect_display( model, D=D, E=E, F=F, G=G, H=H, J=J )

def cyl_display( model, **args ):
    result= model( **args )
    template= """\
 Bin diameter ..................F= {F:14,.3f}
 Bin wall height ...............J= {J:14,.3f}
 Hopper height .................H= {H:14,.3f}
 Overall height ................M= {M:14,.3f}
 Outlet diameter ...............D= {D:14,.3f}
 Bin cross-section area .......... {X:14,.3f}
 Cubic capacity .................. {Z:14,.3f}
 Min. hopper slope................ {N:12,.1f}°
"""
    print( template.format(**result) )

def rect_display( model, **args ):
    result= model( **args )
    template= """\
 Bin width .....................F= {F:14,.3f}
 Bin length ....................G= {G:14,.3f}
 Bin wall height ...............J= {J:14,.3f}
 Hopper height .................H= {H:14,.3f}
 Overall height ................M= {M:14,.3f}
 Outlet width ..................D= {D:14,.3f}
 Outlet length .................D= {E:14,.3f}
 Bin cross-section area .......... {X:14,.3f}
 Cubic capacity .................. {Z:14,.3f}
 Min. hopper slope................ {N:12,.1f}°
"""
    print( template.format(**result) )

def design():
    """The :program:`binvol` program."""
    pass

print( binhop.intro() )
z= ''
while z != '0':
    print(" To analyze an existing bin......press 1")
    print(" To design a new bin.............press 2")
    print(" To EXIT.........................press 0")
    z= input( "CHOICE? " )
    if z == '1':
        analyze()
    elif z == '2':
        design()

