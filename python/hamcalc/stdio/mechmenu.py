"""MECHANICS Math
"""
from hamcalc.stdio.menu import QT_Menu, Item
import string
import runpy

class Mechanics_Menu( QT_Menu ):
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

def run():
    mech= Mechanics_Menu()
    mech.process()

if __name__ == "__main__":
    run()
