"""Graphs

"GRAPHS",", graph generator","","GRAPHS"
"""

from turtle import *
import math

class Graph:
    """Use :mod:`turtle` to superimpose one or more graphs
    of connected lines or points on a common set of coordinates.
    """
    def __init__( self, include_zero=False ):
        self.point_sets= []
        self.line_sets= []
        self.x_max= 0 if include_zero else None
        self.x_min= 0 if include_zero else None
        self.y_max= 0 if include_zero else None
        self.y_min= 0 if include_zero else None
    def gather_max_min( self, points ):
        """Gather x and y maxima and mimima."""
        x, y = points[0]
        if self.x_max is None:
            self.x_max= x
        if self.x_min is None:
            self.x_min= x
        if self.y_max is None:
            self.y_max= y
        if self.y_min is None:
            self.y_min= y
        self.x_max= max( self.x_max, max( x for x, y in points ) )
        self.x_min= min( self.x_min, min( x for x, y in points ) )
        self.y_max= max( self.y_max, max( y for x, y in points ) )
        self.y_min= min( self.y_min, min( y for x, y in points ) )
    def set_points( self, points, color="black", size=4 ):
        """Set another collection of points with a common color and size."""
        self.gather_max_min( points )
        self.point_sets.append( (color, size, points) )
    def set_line( self, points, color="black", size=1 ):
        """Set another line or curve with a common color and size."""
        self.gather_max_min( points )
        self.line_sets.append( (color, size, points) )

    def draw_line(self, x1, y1, x2, y2):
        """Draw a simple line."""
        penup()
        goto(x1,y1)
        pendown()
        goto(x2, y2)

    def draw_coords( self, x_min, y_min, x_max, y_max ):
        """Draw the coordinate system: two lines and four labels."""
        self.draw_line( x_min, 0, x_max, 0 )
        self.draw_line( 0, y_min, 0, y_max )
        x_offset= (x_max-x_min)*.0625
        y_offset= (y_max-y_min)*.0625
        penup()
        goto( x_min, -y_offset )
        write( "{0:.3f}".format(x_min), font=("Helvetica", 10, "bold") )
        penup()
        goto( x_max, -y_offset,  )
        write( "{0:.3f}".format(x_max), font=("Helvetica", 10, "bold") )
        penup()
        goto( -x_offset, y_min )
        write( "{0:.3f}".format(y_min), font=("Helvetica", 10, "bold") )
        penup()
        goto( -x_offset, y_max )
        write( "{0:.3f}".format(y_max), font=("Helvetica", 10, "bold") )

    def draw_label( self, text ):
        """Draw the overall label."""
        x, y = (self.x_max+self.x_min)/2, self.y_min-self.y_size*.0625,
        penup()
        goto(x,y)
        write( text, align="center", font=("Helvetica", 12, "bold") )

    def display( self, label ):
        """Display the given graphs.
        """
        self.x_size= (self.x_max - self.x_min)*1.25
        x_low = self.x_min - self.x_size*.125
        x_high = self.x_max + self.x_size*.125

        self.y_size= (self.y_max - self.y_min)*1.25
        y_low = self.y_min - self.y_size*.125
        y_high = self.y_max + self.y_size*.125

        reset()
        speed(0)
        hideturtle()
        title( label )

        setworldcoordinates( x_low, y_low, x_high, y_high )
        self.draw_coords( self.x_min, self.y_min, self.x_max, self.y_max )

        # Plot the various sets of Data Points
        for color, size, points in self.point_sets:
            for x, y in points:
                penup()
                goto(x,y)
                dot(size,color)

        # Plot the various lines
        for color, size, points in self.line_sets:
            old_pen= pen()
            pen( pensize=size, pencolor= color )
            x, y = points[0]
            penup()
            goto(x, y)
            pendown()
            for x, y in points[1:]:
                goto(x,y)
            penup()
            pen( old_pen )

        self.draw_label( label )

        hideturtle()
        mainloop()

def eval_string_expr( function, x_min, x_max, steps=128 ):
    """Use :func:`eval` to evaluate a string expression
    using only :mod:`__builtins__` and :mod:`math`.
    The expression must expect ``x`` as a variable.
    It will be evaluated for :math:`x_{min} \leq x < x_{max}`
    in the given number of steps.
    """
    globals= {'__builtins__':__builtins__,'math':math}
    y_min = y_max = eval(function,globals,{'x':x_min})
    x_step= (x_max-x_min)/steps
    points= []
    for i in range(steps):
        x= x_min+i*x_step
        y= eval(function,globals,{'x':x})
        points.append( (x,y) )
    return points

def run():
    print( " This program generates a graph of any Y=f(X) equation" )
    print( " All builtin functions and the moth library are avilable." )
    globals= {'__builtins__':__builtins__,'math':math}
    function=None
    while function is None:
        try:
            function= input( "ENTER function of x: " )
            x_min= float(input( "ENTER: minimum value of X? " ))
            x_max= float(input( "ENTER: maximum value of X? " ))
            test= eval( function, globals, {'x':x_min} )
        except Exception as e:
            print( e )
            function= None
    print( "Close the 'y={0}' window to exit this program.".format(function) )

    points= eval_string_expr( function, x_min, x_max )
    #points= eval_string_expr( 'x**2+x-1', -5, +5, )
    #points= eval_string_expr( 'math.sin(math.exp(x))', -math.pi, +math.pi, )
    g= Graph()
    g.set_points( points )
    g.display( 'y='+function )

if __name__ == "__main__":
    run()
