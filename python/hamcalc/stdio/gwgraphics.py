"""GW Graphics Demo

Define a graphics class that allows relatively simple
transcription from GW-Basic to Python.

::

    g= GWGraphics()
    g.SCREEN( 8 )
    g.PRINT( "something" )
    g.LOCATE 3, 12 ); g.PRINT( "something" )
    g.LINE( a, b, x, y, pattern=&H0x5555 )
    g.CIRCLE( x, y, radius=r )
    g.PSET( x, y )
    g.display( "title" )

This handles the quirky aspect-ratio issues that GW-Basic programs
have. Simply transcribe the aspect-ratio math directly. This class
will "reverse" the aspect-ratio on the **vertical** axis so that the
diagrams display correctly.

To help debug, you can enable logging.

::

    import logging

::

    if __name__ == "__main__":
        logging.basicConfig( stream=sys.stderr, level=logging.WARN )
        run()
        logging.shutdown()

"""
import turtle
import math
import logging
import sys

class GWGraphics():
    """Note (0,0) is top-left. (319,199) is below and to the right.

    In mode 8, with a 4:3 aspect ratio, screens are described
    as 640x200. This turns out to look like 640x480.
    If square pixels had been used, this would not even exist.

    Therefore, we have to adjust GWBasic coordinates from
    GWBasic 640x200 with 4:3 pixels to modern square pixel 640x480.

    Only two of the various screen modes is actually supported:
    mode 8 and mode 9.
    """
    colors = {
        0: "Black",
        1: "Blue",
        2: "Green",
        3: "Cyan",
        4: "Red",
        5: "Magenta",
        6: "Brown",
        7: "White",
        8: "Gray",
        9: "Light Blue",
        10: "Light Green",
        11: "Light Cyan",
        12: "Red", # "Light Red",
        13: "Magenta", # "Light Magenta",
        14: "Yellow",
        15: "White", # "High-intensity White",
    }
    def __init__( self ):
        self.log= logging.getLogger( "hamcalc." + self.__class__.__name__ )
    def SCREEN( self, mode ):
        """
        SCREEN 0 ● Text mode only

        SCREEN 1 ● 320 × 200 pixel medium-resolution graphics ● 80 x 25 text

        SCREEN 2 ● 640 × 200 pixel high-resolution graphics ● 40 × 25 text

        SCREEN 7 ● 320 × 200 pixel medium-resolution graphics ● 40 × 25 text

        SCREEN 8 ● 640 × 200 pixel high-resolution graphics ● 80 × 25 text

        SCREEN 9 ● 640 × 350 pixel enhanced-resolution graphics ● 80 × 25 text

        SCREEN 10 ● 640 × 350 enhanced-resolution graphics ● 80 × 25 text
        """
        if mode == 8:
            # Officially 640x200 with rectangular pixels, appears as 640x480.
            turtle.setup( width=640, height=480 )
            turtle.setworldcoordinates(0,0,640,480)
            self.aspect_v = (200/640)*(4/3)
        elif mode == 9:
            # Official 640x350 with rectangular pixels, appears 640x480.
            turtle.setup( width=640, height=480 )
            turtle.setworldcoordinates(0,0,640,480)
            self.aspect_v = (350/640)*(4/3)
    def PRINT( self, text ):
        turtle.write( text, font=('Courier', 14) )
        self.log.debug( "PRINT %r", text )
    def LOCATE( self, row=None, col=None ):
        """Row and Column are -- strictly speaking -- optional.
        If unspecified then we're moving horizontally or vertically
        only.
        """
        x, y = turtle.pos()
        x, y = col*8 if col is not None else x, row*8 if row is not None else y
        turtle.penup()
        turtle.goto( x, y/self.aspect_v )
        self.log.debug( "GOTO %r %r", x, y/self.aspect_v )
    def LINE( self, x1, y1, x2, y2, box=False, fill=False, pattern=0xffff ):
        """Numerous variants. The first coordinates can be omitted.
        A "STEP" option moves incrementally instead of absolutely.

        ..  todo:: Support all variants of LINE
        """
        turtle.penup()
        turtle.goto( x1, y1/self.aspect_v )
        turtle.pendown()
        turtle.goto( x2, y2/self.aspect_v )
        if box:
            # draw entire box
            pass
        if fill:
            # fill entire box
            pass
        self.log.debug( "LINE %r %r %r %r", x1, y1/self.aspect_v, x2, y2/self.aspect_v )
    def CIRCLE( self, x, y, r, start=None, end=None ):
        """Draw a circle or arc of a circle.
        It appears that in GW, start is relative to "up", measured CCW around.

        By using -r and -angles, it appears that turtle graphics follows
        GW Basic.

        The turtle starts at the bottom, actually. So we have to penup draw
        180° of circle just to get to where GW Basic starts.
        """
        turtle.penup()
        turtle.goto( x, y/self.aspect_v+r)
        if start is None or end is None:
            turtle.pendown()
            turtle.circle( -r )
            self.log.debug( "CIRCLE %r %r %r", x, y/self.aspect_v+r, r )
        else:
            # Draw from top CCW to start with penup
            turtle.penup()
            turtle.circle( -r, extent=-math.degrees(start) )
            # Draw to start to end with pendown.
            turtle.pendown()
            turtle.circle( -r, extent=-math.degrees(end-start) )
            self.log.debug( "ARC %r %r %r %r %r %r %r", x, y/self.aspect_v+r, r, start, end, math.degrees(start), math.degrees(start+end) )

    def PSET( self, x, y ):
        """Draw a point."""
        turtle.penup()
        turtle.goto(x,y/self.aspect_v)
        turtle.dot(2)
        self.log.debug( "PSET %r %r", x, y/self.aspect_v )
    def COLOR( self, fg, bg=None ):
        turtle.pencolor( self.colors[fg] )
    def display( self, text ):
        """Display the finished graphic until the window is closed.

        Might be better to display until key click or mouse click.
        """
        turtle.title( text )
        turtle.ht()
    def wait( self ):
        turtle.mainloop()
