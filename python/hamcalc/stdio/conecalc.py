"""Cone Calculator

"CONE CALCULATOR","","","CONECALC"
"""
import hamcalc.construction.conecalc as conecalc
from collections import defaultdict

picture= """\
     B
 ┌─────────┐
y│         │A
││         │
 └─────────┘
  ────x
"""


def cone_to_sheet():
    d_raw= input(" ENTER: cone base diameter...............D=? " )
    try:
        D= float(d_raw)
    except ValueError:
        return
    h_raw= input(" ENTER: cone height......................H=? " )
    try:
        H= float(h_raw)
    except ValueError:
        return
    results= conecalc.cone( D=D, H=H )

    template="""\
Cone base dia ............... {D:7.3f}
Cone height ................. {H:7.3f}
Base circumference........... {C:7.3f}
Arc angle ................... {theta_d:7.3f}°
Arc radius .................. {L:7.3f}
Arc center coordinates...  X= {X:7.3f}
                           Y= {Y:7.3f}
Pattern sheet ........... (A) {A:7.3f} x (B) {B:7.3f}
"""

    print("CONE PATTERN")
    print()
    print( template.format( **results ) )
    print()
    print( picture )

def sheet_to_cone():
    print( picture )
    a_raw= input(" ENTER: smaller dimension of the sheet .......A=? " )
    try:
        A= float(a_raw)
    except ValueError:
        return
    b_raw= input(" ENTER: larger dimension of the sheet ........B=? " )
    try:
        B= float(b_raw)
    except ValueError:
        return
    report= [ defaultdict( str ) for d in range(6) ]
    results= conecalc.cone( A=A, B=B )
    report[results.next] = results
    while results.next:
        results= conecalc.cone( **results )
        report[results.next if results.next is not None else 5] = results
    print( report[1] )
    print( report[2] )
    print( report[3] )
    print( report[4] )
    print( report[5] )

    template= """\
Pattern sheet:  (A) {3.A:6.2f} in. x  (B) {3.B:6.2f} in.

Type    Height  Base Diameter  Base Circum    Radius      Arc

1       {1.H:7.3f}      {1.D:7.3f}      {1.C:7.3f}      {1.L:7.3f}      {1.theta_d:7.3f}
2       {2.H:7.3f}      {2.D:7.3f}      {2.C:7.3f}      {2.L:7.3f}      {2.theta_d:7.3f}
3       {3.H:7.3f}      {3.D:7.3f}      {3.C:7.3f}      {3.L:7.3f}      {3.theta_d:7.3f}
4       {4.H:7.3f}      {4.D:7.3f}      {4.C:7.3f}      {4.L:7.3f}      {4.theta_d:7.3f}
5       {5.H:7.3f}      {5.D:7.3f}      {5.C:7.3f}      {5.L:7.3f}      {5.theta_d:7.3f}

Type      Location of Arc Center
                                    B
1         X = {1.X:7.3f}; Y = {1.Y:7.3f}   ┌─────────┐
2         X = {2.X:7.3f}; Y = {2.Y:7.3f}  y│         │A
3         X = {3.X:7.3f}; Y = {3.Y:7.3f}  ││         │
4         X = {4.X:7.3f}; Y = {4.Y:7.3f}   └─────────┘
5         X = {5.X:7.3f}; Y = {5.Y:7.3f}     ───x
"""

    print( template.format( *report ) )


trunc_intro="""\
    A truncated cone can be made from a flat sheet of material by
    cutting out a truncated sector with the proper radii and arc angle
    and rolling it until the straight edges join. Allow extra material
    if an overlap is needed.
"""

def truncated_cone_to_sheet():
    print( trunc_intro )
    d_b_raw= input( "ENTER: diameter at large end...........? ")
    try:
        D_B = float( d_b_raw )
    except ValueError:
        return
    d_t_raw= input( "ENTER: diameter at small end...........? ")
    try:
        D_T = float( d_t_raw )
    except ValueError:
        return
    h_raw= input( "ENTER: length between ends.............? ")
    try:
        H = float( h_raw )
    except ValueError:
        return

    if D_B < D_T:
        D_B, D_T = D_T, D_B
    assert D_B >= D_T
    results= conecalc.truncated_cone( D_B=D_B, D_T=D_T, H=H )

    template= """\
Diameter at large end............ {LE:7.3f}
Diameter at small end............ {SE:7.3f}
Length between ends.............. {H:7.3f}
Outer arc radius................. {L:7.3f}
Inner arc radius................. {L_X:7.3f}
Arc angle........................ {theta_d:7.3f}°
Minimum sheet size............(B) {B:7.3f} x (A) {A:7.3f}
Location of arc centre.........x= {X:7.3f}   y=  {Y:7.3f} {relative} bottom of sheet
Location of top of sheet.......y= {TOP:7.3f}
Location of bottom of sheet....y= {BOT:7.3f}
"""

    print("TRUNCATED CONE PATTERN")
    print()
    print( template.format( **results ) )
    print()
    print( picture )


print( conecalc.intro() )
z= None
while z != '0':
    print("   To EXIT program, press 0" )
    print("   To compute cone pattern layout, press 1" )
    print("   To compute cone size to fit a known pattern sheet size, press 2" )
    print("   To compute truncated cone pattern layout, press 3" )
    z = input( "CHOICE? " )
    if z == '1':
        cone_to_sheet()
    elif z == '2':
        sheet_to_cone()
    elif z == '3':
        truncated_cone_to_sheet()


