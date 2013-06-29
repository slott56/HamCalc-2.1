"""Decimal to Binary Converter

"BINARY NUMBERS","","","BINARY"
"""

import hamcalc.math.binary as binary
from hamcalc.stdio import *

print( binary.intro() )

while True:
    w0= input_int( "ENTER: Decimal number to be converted [empty input to quit]? " )
    if w0 is None: break
    bits= binary.binary( w0 )
    print( "24 bit Binary representation of {0:d}".format(w0) )
    for b in bits:
        print( b, end='' )
    print()
    print()
