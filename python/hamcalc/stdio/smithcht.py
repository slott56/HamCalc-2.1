"""Smith Chart Calculations
"""
from hamcalc.stdio.menu import QT_Menu, Item
import string
import runpy

class Smith_Chart( QT_Menu ):
    """Menu to display the Smith Chart Calculations list of programs.
    """
    def __init__( self ):
        super().__init__( "SMITH CHART CALCULATIONS" )
        self.item_list= [

            Item( "", "antfield", "Antenna Field Strength" ),
            Item( "", "coaxchar", "Coaxial Cable Characteristics" ),
            Item( "", "coilq", "Coil Q Calculator" ),
            Item( "", "conjumat", "Conjugate Match Calculator" ),
            Item( "", "hairpin", "Hairpin Match for Yagis" ),
            Item( "", "serisect", "Series-Section Transformer" ),
            Item( "", "stubant", "Stub Match for Antennas" ),
            Item( "", "swr", "SWR Calculator" ),
            Item( "", "transmat", "Transmatch Design" ),
            Item( "", "elecleng", "Transmission Line Length" ),
            Item( "", "lineloss", "Transmission Line Losses" ),
            Item( "", "tranline", "Transmission Line Performance" ),
            Item( "", "transtub", "Transmission Line Stubs" ),
            Item( "", "xmtrzmat", "Xmtr Transistor Stage Coupling" ),

        ]

def run():
    intro="""\
The following HAMCALC programs may be useful for calculating data
that you might otherwise seek using a Smith Chart.

"MicroSmith", a comprehensive Smith Chart graphics and tabular
software program by Wes Haywood, W7ZOI, is available from the ARRL.
"""
    print( intro )
    mech= Smith_Chart()
    mech.process()

if __name__ == "__main__":
    run()
