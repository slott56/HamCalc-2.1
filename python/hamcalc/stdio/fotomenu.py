"""PHOTOGRAPHY Math
"""
from hamcalc.stdio.menu import QT_Menu, Item
import string
import runpy

class Photography_Menu( QT_Menu ):
    """Menu to display the Photography list of programs.
    """
    def __init__( self ):
        super().__init__( "  F O T O C A L C  " )
        self.item_list= [

        Item( "", "elflash", "ELECTRONIC FLASH" ),
        Item( "", "exposure", "EXPOSURE" ),
        Item( "", "lensring", "EXTENSION RINGS and BELLOWS" ),
        Item( "", "filter", "FILTERS" ),
        Item( "", "focus", "FOCUSING" ),
        Item( "", "lenses", "LENSES" ),
        Item( "", "fotocopy", "PHOTOCOPIER IMAGE SIZE" ),
        Item( "", "fotomove", "SUBJECTS IN MOTION" ),
        Item( "", "titler", "TITLER" ),
        Item( "", "pixel", "DIGITAL CAMERAS & SCANNERS" ),

        ]

def run():
    mech= Photography_Menu()
    mech.process()

if __name__ == "__main__":
    run()
