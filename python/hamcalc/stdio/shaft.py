"""Shafts and Shafting
"""
import hamcalc.construction.shaft as shaft
from hamcalc.stdio import *

model_map = {
    '1': shaft.main_shaft,
    '2': shaft.pulley_shaft,
    '3': shaft.stub_shaft,
    }

def display( model, **args ):
    result= model( **args )
    template= """\
Minimum shaft diameter (in.).. {D:10,.3f}
Shaft R.P.M. ................. {N:10,.3f}
Maximum horsepower ........... {H:10,.3f}
"""
    if "L" in result:
        template += """\
Max. inches between bearings.. {L:10,.3f}
"""

    print( template.format( **result ) )

print( shaft.intro() )
z = None
while z != '0':
    print( "(1)  Main shaft" )
    print( "(2)  Shaft with pulleys" )
    print( "(3)  Stub shaft" )
    print( )
    print( "(0)  EXIT" )
    z= input( "CHOICE? " )
    if z in model_map:
        N = input_float( "Shaft R.P.M. .................? " )
        D = input_float( "Shaft diameter (in) ..........? " )
        H = input_float( "Horsepower ...................? " )
        display( model_map[z], N=N, D=D, H=H )

