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
    while True:
        b= input( "CHOICE? " )
        if b == '1':
            cyl_analysis()
            break
        elif b == '2':
            rect_analysis()
            break

def cyl_analysis():
    model= binhop.Cylindrical()
    D= input_float( "ENTER: Outlet D...............diameter =? " )
    model.draw= discharge()
    H= input_float( "ENTER: Hopper height H.................=? " )
    F= input_float( "ENTER: Bin diameter F..................=? " )
    J= input_float( "ENTER: Bin wall height J...............=? " )
    cyl_display( model, D=D, F=F, H=H, J=J  )

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

def rect_analysis():
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

def cyl_design( shape=binhop.Circle() ):
    V =   input_float( "ENTER: Required cubic capacity.......? " )
    DEG = input_float( "ENTER: Hopper slope angle (degrees)..? " )
    D =   input_float( "ENTER: Dia. of hopper opening D......? " )
    results= binhop.design_hopper( shape, V=V, N=DEG, D=D )
    print( "Minimum height M= {0:.3f}".format(results.H) )
    M = input_float( "ENTER: Desired height greater than {0:.3f}? ".format(results.H) )
    results= binhop.design_final( shape, M=M, **results )
    design_display( shape, **results )

def rect_design( shape= binhop.Square() ):
    V =   input_float( "ENTER: Required cubic capacity.......? " )
    DEG = input_float( "ENTER: Hopper slope angle (degrees)..? " )
    D =   input_float( "ENTER: Size of hopper opening D......? " )
    results= binhop.design_hopper( shape, V=V, N=DEG, D=D )
    print( "Minimum height M= {0:.3f}".format(results.H) )
    M = input_float( "ENTER: Desired height greater than {0:.3f}? ".format(results.H) )
    results= binhop.design_final( shape, M=M, **results )
    design_display( shape, **results )

def design_display( shape, **args ):
    print( "{0} HOPPERED BIN".format( shape.__class__.__name__ ) )
    print( "{name} {V_H:.3f} hopper + {V_B:.3f} bin = {V_T:.3f} Cubic Capacity of Bin and Hopper".format(name=shape.__class__.__name__, **args) )

    template= """\
Bin cross section area.............= {A:8.3f}
Top opening.......................F= {F:8.3f}
BBottom opening...................D= {D:8.3f}
Bin height........................J= {J:8.3f}
Hopper height.....................H= {H:8.3f}
Overall height....................M= {M:8.3f}
Hopper slope angle.................= {N:6.1f}°
"""
    print( template.format(**args) )

def design():
    """The :program:`binvol` program."""
    print( binhop.intro(2) )
    print()
    print( "  Press number in ( ) to indicate shape of bin:" )
    print( "(1) Round" )
    print( "(2) Rectangular" )
    while True:
        b= input( "CHOICE? " )
        if b == '1':
            cyl_design()
            break
        elif b == '2':
            rect_design()
            break

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

