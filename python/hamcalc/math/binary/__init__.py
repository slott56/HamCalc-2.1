"""hamcalc.math.binary -- Decimal to Binary conversion.

Test Cases

>>> binary( 97, bits=24 )
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1]

"""

def intro():
    print( "Binary Converter                                 by R.J.Dehoney IEEE")
    print()
    print( " This program finds the binary representation of a decimal number." )
    print( " It is limited to 24 binary digits (decimal 16777216)." )
    print( )

def bit_iter( n ):
    """Iterate through binary representation from LSB.

    :param n: positive number for which to develop the bits.
    :returns: bits from LSB to MSB.
    """
    assert n >= 0
    while n != 0:
        n, lsb = divmod( n, 2 )
        yield lsb

def binary( n, bits=24 ):
    """Compute a tuple with the bits in the binary representation
    of a number *n*.

    :param n: positive number for which to develop the bits.
    :returns: tuple with bits
    """
    value = [ 0 for i in range(bits) ]
    for i, lsb in enumerate( bit_iter(n) ):
        value[bits-i-1]= lsb
    return tuple(value)
