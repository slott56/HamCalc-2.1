"""Scale Speed Calculator

"SCALE SPEED CALCULATOR","","","SCALSPD"
"""
from hamcalc.stdio import *

intro= """\
SCALE SPEED                                             by George Murphy VE3ERP

 This program calculates the scale speed of a scale model travelling over a
 full scale distance in real time.
"""

def scalspd():
    F = input_float( "ENTER: scale of model......     1:? " )
    R = input_float( "ENTER: Full scale distance in inches? " )
    T = input_float( "ENTER: Travel time in seconds? " )
    display( F, R, T )

def display( F, R, T ):
    D= R*F
    I_sec= D/T
    F_sec= I_sec/12
    F_min= F_sec*60
    F_hr= F_min*60
    M_hr= F_hr/5280
    template= """\
Scale of model..........       1 :{F:3.0f}
Full scale distance..... {R:10.1f} inches
                       = {D:10,.1f} scale inches
Travel time............. {T:10,.1f} seconds
Scale speed............= {I_sec:10,.1f} scale inches per second
                       = {F_sec:10,.1f} scale feet per second
                       = {F_min:10,.1f} scale feet per minute
                       = {F_hr:10,.1f} scale feet per hour
                       = {M_hr:10,.1f} scale miles per hour
"""
    print( template.format( **locals() ) )

print( intro )

z= None
while z != '0':
    z= input( "ENTER <1> to run program or <0> to EXIT? " )
    if z == '1':
        scalspd()
