"""Curve Fit program

"FIT CURVE PROGRAM","","","CURVEFIT"
"""
import hamcalc.math.curvefit as curvefit
from hamcalc.stdio.graphs import Graph
from turtle import *

class CurveFit_Problem:
    """Gather user input to complete the various parts of
    a curvefit problem:

    1.  Points
    2.  Transformation Funcion and arguments
    3.  Order of polynomial
    4.  Minization.
    """
    def __init__( self ):
        self.points = []
        self.func_name= None
        self.func_args= {}
        self.order= 0
        self.minimize= None

    def good( self ):
        """Do we have all the parts of the problem?"""
        return all( (
            len(self.points) >= 2,
            self.func_name is not None,
            all( a_v is not None for a_v in self.func_args.values() ),
            1 <= self.order < 5,
            self.order <= len(self.points),
            self.minimize in ( 'abs', 'rel' ),
        ) )

    def setup( self ):
        """Problem setup, gather the various bits of information."""
        self.func_name= None
        self.func_args= {}
        self.order= 0
        self.minimize= None
        while not self.good():
            try:
                self.get_points()
                self.get_function()
                self.get_order()
                self.get_minimization()
            except Exception as e:
                print( e )

    def get_points( self ):
        """Get the set of data points."""
        choice= None
        while choice != '0':
            print( "Item: (X, Y)" )
            for i, p in enumerate(self.points):
                print( "{0:4d}: {1:s}".format(i,p) )
            choice= input( "<1> Add | <2> Change | <3> Delete | <0> Done? " )
            if choice == "1":
                print( "Add item" )
                x= float(input( "ENTER X " ))
                y= float(input( "ENTER Y " ))
                self.points.append( (x,y) )
            elif choice == "2":
                i= int( input( "Change item? " ))
                if 0 <= i < len(self.points):
                    x= float(input( "ENTER X " ))
                    y= float(input( "ENTER Y " ))
                    self.points[i]= (x,y)
                else:
                    print( "Bad item item: 0 <= {0} < {1}".format(i,len(self.points)) )
            elif choice == "3":
                i= int( input( "Delete item? " ))
                if 0 <= i < len(points):
                    self.points.delete( i )

    def get_function( self ):
        """Get the transformation function and any needed arguments."""
        while self.func_name is None:
            print( "(1) Z=X  (2) Z=(X+K)^P  (3) Z=LOG(X+K)  (4) Z=EXP(X*K)" )
            func_num= input( "Enter number of desired relation " )
            try:
                self.func_name, self.func_args = {
                    '1': ("NULL",{}),
                    '2': ('POW',{'k':None,'p':None}),
                    '3': ('LOG',{'k':None}),
                    '4': ('EXP',{'k':None}) }[func_num]
                for var_name in self.func_args:
                    value= float(input( "ENTER {0} ".format(var_name) ) )
                    self.func_args[var_name]= value
            except (KeyError, ValueError) as e:
                print(e)

    def get_order( self ):
        """Get the order of the polynomial. 1 is a line."""
        self.order= int(input( "ENTER order of polynomial (1, 2, 3, or 4) " ))
        if self.order > len(self.points):
            print( "Insufficient data pairs" )

    def get_minimization( self ):
        """Get the minimization goal."""
        while self.minimize not in ( 'abs', 'rel' ):
            min_raw = input( "ENTER 1 to minimize relative error, 2 to minimize absolute error " )
            try:
                self.minimize= { '1': 'rel', '2': 'abs' }[min_raw]
            except KeyError as e:
                print(e)

print( curvefit.intro() )

problem= CurveFit_Problem()
z = None
while z != '0':

    print( " To run program......press <1> " )
    print( " To exit.............press <0> " )
    z = input( "Choice? " )
    if z == '1':
        # Phase 1 - setup the problem
        problem.setup()

        # Phase 3 - solve
        C = curvefit.fit( problem.points, problem.func_name,
            problem.func_args, problem.order+1, problem.minimize )
        print( C )

        # Phase 4 - display
        data_xform= curvefit.data_transform( problem.points, problem.func_name, problem.func_args )
        computed= []
        print( "        X        Y data   Y calculated    Error   % Error" )
        for x,y in data_xform:
            y_f= sum( (c*x**i for i, c in enumerate(C)) )
            err = float("NaN") if y == 0 else (y-y_f)/y
            print( "{0:9f}     {1:9f}      {2:9f} {3:8f} {4:9.3%}".format(x, y, y_f, y-y_f, err) )
            computed.append( (x,y_f) )

        C_5= C[:] + [ 0.0 for i in range(len(C),5) ]
        print( "Y=A+B*Z+C*Z^2+D*Z^3+E*Z^4" )
        print( "A = {0:f}, B = {1:f}, C = {2:f}, D = {3:f}, E = {4:f}".format(*C_5) )

        term = [ "{0:.3f}".format(C[0]), "{0:.3f}*X".format(C[1]) ] + [ "{1:.3f}*X**{0:.0f}".format( i+2, c ) for i, c in enumerate( C[2:] ) ]
        equation= "Y = " + " + ".join( term )
        print( equation )
        print()

        # Phase 5 - graph
        g= Graph()
        g.set_points( data_xform )
        g.set_line( computed )
        g.display( equation )
        print( "Close the '{0}' window when done.".format(equation) )
