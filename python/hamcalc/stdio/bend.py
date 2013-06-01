"""Bend Allowance, Metals
"""
from hamcalc.math.equiv import INCH, MILLIMETRE
import math

def bend( unit ):
    t_raw= input(" ENTER: Material thickness ({0}.)....................T=? ".format(unit.name) )
    try:
        T= unit.to_std( float(t_raw) )
    except ValueError:
        return
    r_raw= input(" ENTER: Inside radius to face of material ({0}.).....R=? ".format(unit.name) )
    try:
        R= unit.to_std( float(r_raw) )
    except ValueError:
        return
    l_raw= input(" ENTER: Included angle of bend (degrees)............L=? " )
    try:
        L= float(l_raw)
    except ValueError:
        return
    C_1 = 0.55*T + math.pi/2*R
    C_2 = 0.64*T + math.pi/2*R
    C_3 = 0.71*T + math.pi/2*R
    display( T, R, L, C_1, C_2, C_3 )

def display( T, R, L, C_1, C_2, C_3 ):
    template= """\
 Material thickness.......T= {T_mm:5.1f} mm = {T_in:6.3f} in.
 Inside radius of bend....R= {R_mm:5.1f} mm = {R_in:6.3f} in.
 Included angle...........L= {L:5.1f}°
 Bending allowance C:
  For brass & soft copper................................ {C_1_mm:5.1f} mm = {C_1_in:6.3f} in.
  For half-hard copper & brass, soft steel, & aluminum... {C_2_mm:5.1f} mm = {C_2_in:6.3f} in.
  For bronze, hard copper, cold rolled & spring steel.... {C_3_mm:5.1f} mm = {C_3_in:6.3f} in.
"""

    print( template.format(
        T_in= INCH.from_std(T), T_mm= MILLIMETRE.from_std(T),
        R_in= INCH.from_std(R), R_mm= MILLIMETRE.from_std(R),
        L=L,
        C_1_in= INCH.from_std(C_1), C_1_mm= MILLIMETRE.from_std(C_1),
        C_2_in= INCH.from_std(C_2), C_2_mm= MILLIMETRE.from_std(C_2),
        C_3_in= INCH.from_std(C_3), C_3_mm= MILLIMETRE.from_std(C_3),
        ) )

introduction="""\
BEND ALLOWANCE, Metal                                   By George Murphy VE3ERP

     leg         leg
 │«── A ─»│«C»│«─ B ─»│     █▀▀▀▀▀▀▀ A
 ┌────────┬─┬─┬───────┐     █ L
 │    bend─»| |       │     █
 └────────┴─┴─┴───────┘     B
  BLANK BEFORE BENDING    »│T│«
 T = Thickness of material
 R = Bending radius to inside face of blank
 L = Included angle of bend
 C = Bend allowance

 In bending metal the problem is to find the length of straight stock required
 for each bend; then these lengths are added to the lengths of the straight
 sections to obtain the total length of the material before bending.
         (Machinery's Handbook, revised 21st edition, page 1928).

 Bend allowance for pipe or tubing = radius to centreline of the material x
 included angle in degrees x 0.01745.
        (Machinery's Handbook, revised 21st edition, page 2335).
"""

print( introduction )
z=None
while z != '0':
    print( " (1) Run program with dimensions in millimetres" )
    print( " (2) Run program with dimensions in inches" )
    print( " (0) EXIT" )
    z= input( "CHOICE? " )
    if z == "1":
        bend( MILLIMETRE )
    elif z == "2":
        bend( INCH )
