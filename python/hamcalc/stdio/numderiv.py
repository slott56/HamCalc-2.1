"""Numbers and Functions, Logarithms to any base

"DERIVATIVES OF NUMBERS","","","NUMDERIV"
"FUNCTIONS OF NUMBERS","","","NUMDERIV"
"LOGARITHMS","","","NUMDERIV"
"NUMBERS & FUNCTIONS","","","NUMDERIV"
"""

import math

functions= [
    ("Number", lambda x: x),
    ("Square", lambda x: x**2),
    ("Cube", lambda x: x**3),
    ("Square root", lambda x: math.sqrt(x) ),
    ("Cube root", lambda x: x**(1/3) ),
    ("Reciprocal", lambda x: 1/x ),
    ("Natural logarithm", lambda x: math.log(x) ),
    ("Common logarithm", lambda x: math.log(x,10) ),
    ]

anti_logs= [
    ("Value of logarithm", lambda x: x),
    ("Antilogarithm if natural log", lambda x: math.exp(x) ),
    ("Antilogarithm if common log", lambda x: 10**x ),
    ]

def eval_functions( prompt, func_list ):
    n_raw= input( prompt )
    if len(n_raw) == 0: return
    n= float(n_raw)
    print( " Functions of {0:f}".format(n) )
    for name, func in func_list:
        try:
            value= func(n)
        except ValueError as e:
            value= float("NaN")
        print( "{0:.<40s} {1:f}".format( name, value ) )

def logs():
    b_raw= input( "ENTER: Value of Base? " )
    if len(b_raw) == 0: return
    b= float(b_raw)
    n_raw= input( "ENTER: Number (or 0 to quit)? " )
    if len(n_raw) == 0: return
    n= float(n_raw)
    if n == 0: return
    value= math.log( n, b )
    print( "log {0:f} (base {1:f})= {2:f}".format( n, b, value ) )

print( "NUMBERS and FUNCTIONS                                       by George C. Murphy" )

z= None
while z != '0':
    print( "   < 1 >  Powers, roots, reciprocals & logarithms")
    print( "   < 2 >  Antilogarithms")
    print( "   < 3 >  Logarithms to any base")
    print()
    print( "   < 0 >  EXIT")

    z= input( "Choice? " )
    if z == '1': eval_functions( "ENTER: Number to be analyzed........? ", functions )
    elif z == '2': eval_functions( "ENTER: Value of logarithm.   ....? ", anti_logs )
    elif z == '3': logs()

