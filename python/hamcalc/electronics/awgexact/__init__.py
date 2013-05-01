"""hamcalc.electronics.awgexact -- AWG wire size calculator

There are three AWG Units:

-   AWG String guage numbers from #0000 (#4/0) to #40

-   Inches

-   Millimeters

Note that converting a diameter in inches will retrieve a Gauge string
that's perhaps smaller than the requested size.

Ths includes is a **Table** of values, as well.

Here are some test cases.

>>> import hamcalc.electronics.awgexact as awgexact
>>> awgexact.AWG.to_std( "#0" )
0.32486074024297096
>>> awgexact.AWG.to_std( "#0000" )
0.46
>>> awgexact.AWG.to_std( "#36" )
0.005000000000000004
>>> awgexact.MM.from_std( 0.005 )
0.127
>>> awgexact.AWG.from_std( 0.005 )
'#36'
>>> awgexact.AWG.from_std( 0.006 )
'#34'
>>> awgexact.AWG.to_std( "#34" )
0.006304883590044074

"""
__version__ = "2.1"

introduction = """\
 A.W.G. WIRE SIZE CALCULATOR                             by George Murphy VE3ERP

 This program computes precise theoretical diameters of A.W.G. wire to seven
 decimal places. Due to manufacturing tolerances, actual wire diameters are
 held to only the first 3 or 4 decimal places.
"""

from hamcalc.lib import Unit, Standard_Unit, convert
import math

class Error( Exception ):
    pass

def intro():
    """Returns the text from the introductory page."""
    return introduction

class INCH( Standard_Unit ):
    """Inch"""
    name= 'in'

class MM( Unit ):
    """Millimeter"""
    standard= INCH
    name= 'mm'
    factor= 25.4

class AWG( Unit ):
    """AWG Gauge"""
    standard= INCH
    name= "AWG"
    K = (0.460/0.0050)**(1/39)
    @classmethod
    def to_std( class_, value ):
        """Compute inches from AWG Gauge."""
        if value in ( '#0000', '#4/0', '0000', '4/0' ):
            g= 0
        elif value in ( '#000', '#3/0', '000', '3/0' ):
            g= 1
        elif value in ( '#00', '#2/0', '00', '2/0' ):
            g= 2
        elif value in ( '#0', '#1/0', '0', '1/0' ):
            g= 3
        else:
            if value[0] == "#": value= value[1:]
            g= 3+int(value)
        d= 0.460/(class_.K**g)
        return d
    @classmethod
    def from_std( class_, value ):
        """Compute approximate AWG Gauge from inches.
        This will return the next smaller size in the event that the measuremnt isn't an exact AWG gauge.
        """
        g=int(math.log(0.460/value)/(math.log(class_.K)))
        if g < 3:
            return "#" + (4-g)*"0"
        else:
            return "#" + str(g-3)

def table( ):
    """Yields a sequence of sizes in AWG Gauge and Inches.

    :return: tuple of AWG # and Inches.
    """
    gauges = ["#0000", "#000", "#00", "#0"] + [ "#{0}".format(i) for i in range(1,41) ]
    for gauge in gauges:
        diameter= AWG.to_std( gauge )
        inch= INCH.from_std( diameter )
        yield gauge, inch
