"""MECHANICS Math
"""
from hamcalc.stdio.menu import Program_Menu, Item
import string
import runpy

class Mechanics_Menu( Program_Menu ):
    """Menu to display the Mechanics list of programs.
    """
    def __init__( self ):
        super().__init__( "M E C H A N I C S" )
        self.item_list= [

        Item( "", "beamdefl","BEAMS - Deflection in"),
        Item( "", "beamsect","BEAMS - Properties of (Start new beam design here)"),
        Item( "", "beltdriv","Belt Drives"),
        Item( "", "chain","Chain Drives"),
        Item( "", "cyl","Cylinders - Air & Hydraulic"),
        Item( "", "gearing","Gears & gearing"),
        Item( "", "binhop","Hoppered Bins & Tanks"),
        Item( "", "shaft","Shafting"),
        Item( "", "stairs","Stairs, Ladders & Ramps"),
        Item( "", "torque","Torque & Horsepower"),

        ]
    def display( self ):
        """Display the menu."""
        print( self.name.center(80) )
        print()
        for code, item in enumerate(self.item_list):
            print( "({0}) {1}".format(string.ascii_lowercase[code], item.title) )
        print( "(k) EXIT this program" )
    def get_choice( self ):
        """Prompt and get the user's choice."""
        page_raw= input( "Choice? " ).lower()
        return page_raw
    def handle_choice( self, choice ):
        if choice == 'k':
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
    mech= Mechanics_Menu()
    mech.process()

if __name__ == "__main__":
    run()
