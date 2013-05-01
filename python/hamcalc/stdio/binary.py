"""Decimal to Binary Converter

"BINARY NUMBERS","","","BINARY"
"""

from hamcalc.math.binary import binary

print( binary.intro() )

while True:
    w0_raw= input( "ENTER: Decimal number to be converted or 0 to Quit? " )
    if len(w0_raw) == 0: break
    w0= int(w0_raw)
    if w0 == 0: break
    bits= binary( w0 )
    print( "24 bit Binary representation of {0:d}".format(w0) )
    for b in bits:
        print( b, end='' )
    print()
    print()
