"""Wires in Conduit
"""
import hamcalc.construction.wirecond as wirecond
from hamcalc.lib import AttrDict

def solve():

    params= AttrDict()

    id_raw= input(" ENTER: conduit inside diameter? " )
    try:
        params.ID= float(id_raw)
    except ValueError:
        pass

    od_raw= input(" ENTER: wire/cable outside diameter? " )
    try:
        params.OD= float(od_raw)
    except ValueError:
        pass

    nw_raw= input(" ENTER: number of wires/cables? " )
    try:
        params.NW= float(nw_raw)
    except ValueError:
        pass

    result= wirecond.conduit( **params )

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

