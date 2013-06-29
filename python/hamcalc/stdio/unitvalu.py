"""Unit Value Comparator

"UNIT VALUE COMPARATOR","","","UNITVALU"
"""
import string
from hamcalc.stdio import *

introduction = """\
 UNIT VALUE COMPARATOR                                   by George Murphy VE3ERP

 This program calculates Value per Unit (V/U) of one or more samples of any

 given V/U combination, and sorts them for comparison. Typical V/U combinations
 are:

                     kw/hr          ohms/ft.       dB/watt
                     lb./sq.ft.     mi./hr.        cents/kg.

                or any other V/U combination you wish to specify.
"""

def gather( unit, value ):
    """Gathers a sequence of (i,u,v) triples.

    :param unit: Unit name
    :param value: Value name
    :returns: sequence of (i,u,v) triples.
    """
    print( "Item   Value {0:6s} Units {1:6s}   {2:s}".format(
        "("+value+")", "("+unit+")", value+" per "+unit ) )
    count= 0
    uv_list= []
    while True:
        item= string.ascii_uppercase[count]
        print( "Item {0}: ".format(item) )
        u = input_float( "ENTER: Number of ({0}) units? ".format(unit) )
        if u is None: break
        v = input_float( "ENTER: Value ({0})? ".format(value) )
        if v is None: break
        uv_list.append( (item,u,v) )
        print( "{0:4s} {1:12f} {2:12f} = {3:12f}".format(item,v,u,v/u) )
        count += 1
        z= ''
        while z not in ( 'a', 'n' ):
            z = input( "Want (a)nother or (n)o more?   (a/n) " )
        if z == 'n': break
    return uv_list

def report( uv_list, unit, value ):
    """Reports the sequence of (i,u,v) triples.

    :param uv_list: sequence of (i,u,v) triples.
    :param unit: Unit name
    :param value: Value name
    """
    def ratio( iuv):
        return iuv[2]/iuv[1]
    uv_list.sort( key=ratio  )
    i_min, u_min, v_min = min( uv_list, key=ratio )
    i_max, u_max, v_max = max( uv_list, key=ratio )
    print( "Item   Value {0:6s} Units {1:6s}   {2:12s} % of {3}   % of {4}".format(
        "("+value+")", "("+unit+")", value+" per "+unit, i_min, i_max ) )
    for i, u, v in uv_list:
        print( "{0:4s} {1:12f} {2:12f} = {3:12f}  {4:7.1%} {5:7.1%}".format(i,v,u,v/u,(v/u)/(v_max/u_max),(v/u)/(v_min/u_min)) )

print( introduction )
value = input( "ENTER: The term (plural) you wish used to express value (V)? " )
unit = input( "ENTER: The term (singular) you wish used to express units (U)? " )
data= gather( unit, value )
report( data, unit, value )
