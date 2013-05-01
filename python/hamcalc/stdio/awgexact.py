"""AWG wire size calculator

"A.W.G. WIRE SIZE CALCULATOR","","","AWGEXACT"
"WIRE SIZE CALCULATOR","","","AWGEXACT"
"""

import hamcalc.electronics.awgexact as awgexact
import string
import runpy

def table():
    data = list(awgexact.table())
    naughts= data[:4]
    other= data[4:]
    for gauge, inch in naughts:
        print( '{0:5s} {1:8.7f}"'.format(gauge,inch) )
    for i in range(14):
        print( '{0:5s} {1:8.7f}"'.format(*other[i]), end='' )
        print( '            {0:5s} {1:8.7f}"'.format(*other[i+14]), end='' )
        if i+28 < len(other):
            print( '            {0:5s} {1:8.7f}"'.format(*other[i+28]), end= '' )
        print()

    print()
    print ( """\
 In the A.W.G. system, each size is 1.122932 times the diameter of the next
 smaller size, based on an original concept of 40 sizes in arithmetic
 progression ranging from .460 in.(#0000) to .005 in.(#36).
""" )

def inch_to_awg():
    raw= input( "ENTER: Wire diameter (inches) or 0 to quit....? " )
    if len(raw) == 0: return
    try:
        d= float(raw)
    except ValueError as e:
        print( e )
        return
    if d == 0.0: return
    inch= d
    diameter= awgexact.INCH.to_std( inch )
    awg= awgexact.AWG.from_std( diameter )
    mm= awgexact.MM.from_std( diameter)
    print( "{0:8.7f} in. ({1:3.2f}mm) diameter = AWG {2}".format( inch, mm, awg ) )

def mm_to_awg():
    raw= input( "ENTER: Wire diameter (mm) or 0 to quit....? " )
    if len(raw) == 0: return
    try:
        d= float(raw)
    except ValueError as e:
        print( e )
        return
    if d == 0.0: return
    mm= d
    diameter= awgexact.MM.to_std( mm )
    awg= awgexact.AWG.from_std( diameter )
    inch= awgexact.INCH.from_std( diameter )
    print( "{0:8.7f} in. ({1:3.2f}mm) diameter = AWG {2}".format(inch, mm, awg) )

def awg_to_inch_mm():
    raw= input( "ENTER: Any AWG value, #0000 to #40...? " )
    if len(raw) == 0: return
    awg= raw
    diameter= awgexact.AWG.to_std( raw )
    inch= awgexact.INCH.from_std( diameter )
    mm= awgexact.MM.from_std( diameter )
    print( "AWG {2} = {0:8.7f} in. = {1:3.2f}mm".format(inch, mm, awg) )

print( awgexact.intro() )

z= None
while z != '0':
    print( "Press number in < > for:" )
    print( "< 1 > Display table of AWG sizes" )
    print( "< 2 > Run Copper Wire Data program" )
    print( "< 3 > Find AWG size of ANY wire diameter" )
    print( "< 4 > Find AWG size of METRIC wire" )
    print( "< 5 > Find diameter of any AWG value" )
    print()
    print( "< 0 > EXIT" )
    z= input( "? " )
    if z == '1':
        table()
    elif z == '2':
        runpy( 'hamcalc.stdio.copwire' )
    elif z == '3':
        inch_to_awg()
    elif z == '4':
        mm_to_awg()
    elif z == '5':
        awg_to_inch_mm()
