"""Smith Chart Calculations
"""
from hamcalc.stdio.menu import Program_Menu, Item
import string
import runpy

class Smith_Chart( Program_Menu ):
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
    def display( self ):
        """Display the menu."""
        print( self.name.center(80) )
        print()
        for code, item in enumerate(self.item_list):
            print( "({0}) {1}".format(string.ascii_lowercase[code], item.title) )
        print( "(z) EXIT this program" )
    def get_choice( self ):
        """Prompt and get the user's choice."""
        page_raw= input( "Choice? " ).lower()
        return page_raw
    def handle_choice( self, choice ):
        if choice == 'z':
            self.quit= True
        else:
            choice_num= string.ascii_lowercase.find( choice )
            if choice_num == -1: return
            program= self.item_list[choice_num]
            runpy.run_module( 'hamcalc.stdio.' + program.name, run_name="__main__" )
    def process( self ):
        self.quit= False
        super().process()

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
