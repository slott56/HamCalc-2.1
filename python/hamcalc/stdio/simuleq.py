"""Simultaneous Equation Calculator

"SIMULTANEOUS EQUATION CALCULATOR","","","SIMULEQ"
"""
from hamcalc.math.curvefit import gauss
from hamcalc.stdio import *
import string

introduction= """\
 SIMULTANEOUS EQUATIONS                                  by George Murphy VE3ERP
"""

def solve( n ):
    coef_name = string.ascii_uppercase
    var_name = 'XYZW'
    for eq in range(n):
        terms= []
        for v in range(n):
            terms.append( coef_name[eq*(n+1)+v] + var_name[v] )
        print( "    " + "+ ".join(terms) + " = " + coef_name[eq*(n+1)+n] )

    matrix= []
    for eq in range(n):
        row= []
        for v in range(n):
            raw= None
            while raw is None:
                raw= input_float( coef_name[eq*(n+1)+v] + "? " )
            row.append( raw )
        raw= None
        while raw is None:
            raw= input_float( coef_name[eq*(n+1)+n] + "? " )
        row.append( raw )
        matrix.append( row )

    for row in matrix:
        terms= [ "{0!s}{1}".format( v, var_name[i] ) for i, v in enumerate(row[:-1]) ]
        print( "    {0} = {1}".format( "+ ".join(terms), row[-1] ) )

    solution = gauss( matrix )

    print()
    for i, row in enumerate(solution):
        print( "    {0} = {1}".format( var_name[i], round(row[-1],6) ) )

print( introduction )

z = None
while z != '0':
    print()
    print("   <1> Solve equation with 2 unknowns of the type (AX + BY = C)")
    print("   <2> Solve equation with 3 unknowns of the type (AX + BY + CZ = D)")
    print()
    print("   <0> EXIT")
    z = input( "CHOICE? " )
    print()
    if z == '1':
        solve(2)
    elif z == '2':
        solve(3)


