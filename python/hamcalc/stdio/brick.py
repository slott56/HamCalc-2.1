"""Masonry Estimator
"""
from hamcalc.math.equiv import INCH, MILLIMETRE, SQ_METRE, SQ_FOOT
import math

def brick( d_unit, a_unit ):
    a_raw= input(" ENTER: Panel length ({0}.)....................A=? ".format(d_unit.name) )
    try:
        A= d_unit.to_std( float(a_raw) )
    except ValueError:
        return
    b_raw= input(" ENTER: Panel height ({0}.)....................B=? ".format(d_unit.name) )
    try:
        B= d_unit.to_std( float(b_raw) )
    except ValueError:
        return

    l_raw= input(" ENTER: Brick/block length ({0}.)..............L=? ".format(d_unit.name) )
    try:
        L= d_unit.to_std( float(l_raw) )
    except ValueError:
        return
    h_raw= input(" ENTER: Brick/block height ({0}.)..............H=? ".format(d_unit.name) )
    try:
        H= d_unit.to_std( float(h_raw) )
    except ValueError:
        return
    j_raw= input(" ENTER: Width of mortar joints ({0}.)..........J=? ".format(d_unit.name) )
    try:
        J= d_unit.to_std( float(j_raw) )
    except ValueError:
        return

    display( d_unit, a_unit, A, B, L, H, J )

def display( d_unit, a_unit, A, B, L, H, J ):

    A_T= A*B # Total Area
    A_U= (L+J)*(H+J) # Unit Area
    B_C= math.ceil( A/(L+J) )
    N= int( A_T/A_U )
    N_C= int( B/(H+J) )

    template= """\
Panel area................... {A_T:9.3f} {a_unit.name}
Panel length...............A= {A:9.3f} {d_unit.name}
Panel height...............B= {B:9.3f} {d_unit.name}
Brick/block length.........L= {L:9.3f} {d_unit.name}
Brick/block height.........H= {H:9.3f} {d_unit.name}
Bricks/blocks per course..... {B_C:5.0f} (approximate)(depends on pattern)
Width of mortar joints....... {J:9.3f} {d_unit.name}
Number of bricks/blocks...... {N:5.0f} (approximate)

Height B contains {N_C:.0f} courses
"""

    print( template.format(
        a_unit= a_unit, d_unit= d_unit,
        A_T= a_unit.from_std(A_T),
        A= d_unit.from_std(A),
        B= d_unit.from_std(B),
        L= d_unit.from_std(L),
        H= d_unit.from_std(H),
        J= d_unit.from_std(J),
        B_C= B_C,
        N= N,
        N_C= N_C
        ) )

introduction="""\
MASONRY ESTIMATOR                                       by George Murphy VE3ERP

 │«──── A ────»│
 ┌─┬───┬───┬───┐«─┐
 ├─┴─┬─┴─┬─┴─┬─┤  │
 ├─┬─┴─┬─┴─┬─┴─┤  B
 ├─┴─┬─┴─┬─┴─┬─┤  │
 └───┴───┴───┴─┘«─┘
  Typical Panel

│«L»│
┌───┐«┐H
└───┘«┘
Brick/Block
Dimensions

 This program estimates quantities and dimensions for brick/block panels.
"""

print( introduction )
z=None
while z != '0':
    print( " (1) Run program with dimensions in millimetres" )
    print( " (2) Run program with dimensions in inches" )
    print( " (0) EXIT" )
    z= input( "CHOICE? " )
    if z == "1":
        brick( MILLIMETRE, SQ_METRE )
    elif z == "2":
        brick( INCH, SQ_FOOT )
