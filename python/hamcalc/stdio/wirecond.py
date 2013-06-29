"""Wires in Conduit
"""
import hamcalc.construction.wirecond as wirecond
from hamcalc.stdio import *

def solve():

    ID= input_float(" ENTER: conduit inside diameter? " )
    OD= input_float(" ENTER: wire/cable outside diameter? " )
    NW= input_float(" ENTER: number of wires/cables? " )

    result= wirecond.conduit( ID=ID, OD=OD, NW=NW )

    print()
    print( "WIRES/CABLES PACKED IN A CONDUIT" )
    template= """\
{1:.<32s} {0.NW:6,.0f}
{2:.<32s} {0.OD:10,.3f}
{3:.<32s} {0.ID:10,.3f}
"""
    print( template.format(result,
        "number of wires/cables",
        "wire/cable outside diameter",
        "conduit inside diameter",) )
    print()

    print( " ╔═══════════════╗ " )
    print( " ║ W A R N I N G ║ " )
    print( " ╚═══════════════╝ " )
    print()
    print( wirecond.warn() )

print( wirecond.intro() )
z=None
while z != '0':
    z= input( "ENTER  1 to continue or 0 to EXIT... " )
    if z == '1':
        solve()

