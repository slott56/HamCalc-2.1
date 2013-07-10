"""Dehoney Algorithm Index

"DEHONEY ALGORITHMS",", Program index","","RJD"
"""
from hamcalc.stdio.menu import Program_Menu, Item
import runpy

def pairs( iterable ):
    """Consume an iterable in pairs.
    If there's an odd number, the final item is paired
    with ``None``.
    """
    the_iter= iter(iterable)
    for item in the_iter:
        try:
            item2= next(the_iter)
            yield item, item2
        except StopIteration:
            yield item, None

class RJD_Menu( Program_Menu ):
    """Menu to display the RJD list of algorithms.

    This is a two-column menu with more than 40 items on it.
    It differs in minor ways from the superclas menu.
    """
    def __init__( self ):
        super().__init__( "HAMCALC ALGORTHMS BY R.J.DEHONEY" )
        self.item_list= [
        Item( "", "ANTSYN2", "Antenna Matching Network" ),
        Item( "", "AUDOSC", "Audio Oscillator" ),
        Item( "", "BATCHG", "Battery Charger" ),
        Item( "", "BRIDGE", "W'stone Bridge #1" ),
        Item( "", "BRIDGE-2","W'stone Bridge #2" ),
        Item( "", "COAXLC3", "Coax L/C Tank" ),
        Item( "", "CAPVAL", "Capacitor Measurer" ),
        Item( "", "CATENARY", "Sag in Horizontal wire" ),
        Item( "", "CMOSC3", "CMOS oscillator" ),
        Item( "", "COILEQUA", "Coil Equations" ),
        Item( "", "COILNEW", "Coil Calculator" ),
        Item( "", "COILTAP", "Coil Tap Properties" ),
        Item( "", "COMFILT", "Complementery Filters" ),
        Item( "", "CONECALC", "Cone Calculator" ),
        Item( "", "COLPOSC", "Colpitts Oscillator" ),
        Item( "", "CPLRES", "Filters Coax Stub" ),
        Item( "", "CURVEFIT", "Curve Fit Program" ),
        Item( "", "DBLBRG4", "2 Bridge Power Supply" ),
        Item( "", "DBLFB", "Double Feedback Amplifier" ),
        Item( "", "DUOPWR", "Power Supply" ),
        Item( "", "HARTOSC3", "Hartley Oscillator" ),
        Item( "", "FILTUT", "Filter Tutor" ),
        Item( "", "GAPLOT", "Capacitor Plate Design" ),
        Item( "", "HUMID", "Humidex Calculator" ),
        Item( "", "IMPANT", "Antenna Impedance" ),
        Item( "", "INLOSS", "Insertion Loss" ),
        Item( "", "LADRSOLV", "Ladder Networks" ),
        Item( "", "LOSSY", "SWR vs. Line Loss" ),
        Item( "", "MATFILT", "Matching filters" ),
        Item( "", "MISMAT", "Xmission Line Mismatch" ),
        Item( "", "NOLOSS", "Lossless L/C Circuits" ),
        Item( "", "PAIRLT", " Long-Tailed Pair" ),
        Item( "", "PHAZDIFF", "Phase Difference" ),
        Item( "", "PULSEGEN", "Pulse Generator" ),
        Item( "", "PSUP", "Power Supply Analyzer" ),
        Item( "", "PSYCHROM", "Thermodynamics" ),
        Item( "", "PSUPERF", "Power Supply Rating" ),
        Item( "", "PULSEGEN", "Pulse Generator" ),
        Item( "", "PWRDIV", "Power Divider" ),
        Item( "", "RANDNUM", "Random Numbers" ),
        Item( "", "RCLOAD2", "Matching in an R/C Load" ),
        Item( "", "QFIND5", " Q-L/C Tank Circuit" ),
        Item( "", "SEPAQ", "Series/Parallel/Q Ccts." ),
        Item( "", "SINK", "Heat Sink Fins" ),
        Item( "", "TFORM3", "L/C Net w/o Xformers" ),
        Item( "", "TURNS", "Coil Turns Calculator" ),
        Item( "", "TRISQU", "Wave Generator" ),
        ]
    def display( self ):
        """Display the RJD menu."""
        print( self.name.center(80) )
        print()
        for code_item_left, code_item_right in pairs( enumerate(self.item_list, 1) ):
            col_1= "{0:d} {1.title}".format(*code_item_left)
            if code_item_right is not None:
                col_2 = "{0:d} {1.title}".format(*code_item_right)
            else:
                col_2 = ""
            print( "{0:38s} {1:38s}".format(col_1,col_2) )
        print( "(0) EXIT this program" )
    def get_choice( self ):
        """Prompt and get the user's choice."""
        page_raw= input( "ENTER a number to continue or 0 to exit? " )
        return page_raw
    def handle_choice( self, choice ):
        if choice == '0':
            self.quit= True
        else:
            try:
                choice_num= int( choice )
            except ValueError:
                return
            if choice_num == 0:
                self.quit= True
            else:
                program= self.item_list[choice_num-1]
                runpy.run_module( 'hamcalc.stdio.' + program.name.lower(), run_name="__main__" )

def run():
    rjd= RJD_Menu()
    rjd.process()

if __name__ == "__main__":
    run()
