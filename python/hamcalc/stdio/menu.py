"""Menu.

Displays menus, accepts choices, and executes programs.

The default behavior is to be run from the :program:`intro` application.

If the menu was run from the command line, then it will run the intro
program with the ``menu=False`` parameter to prevent recursively invoking the menu.

Application Programs
====================

Note that we don't trivially import the modules because we've adopted a
scripting style for "main programs" that doesn't work well with ``import``.

..  note:: We Could But We Don't

    We could demand that each application use a main program hook.

    ::

        if __name__ == "__main__":
            run()

    It's only two lines of code.

    But. The point is to encourage recreational programming, and this
    is sometimes too much fussy overhead.

Instead, we parse each omdule to extract the docstring comment. From this
comment we determine two things.

-   The program name is the first line.

-   The Hamdex indexing information is the rest of the docstring.
    This is expected to be in the same CSV format as the legacy
    :file:`INDEX/HAMDEX.FIL` file.

    ::

        "Heading",", Subheading",", note"

    Yes, the extra commas were part of the legacy. They're optional.

All of the programs in the stdio directory except :program:`menu` and :program:`intro` are examined. These two programs are treated specially.

Other Programs
==================

This program imports and runs the :program:`intro` program.

The following other programs are simply incorporated into this one.

::

    720 DATA /hamcalc/prog/quiktabl,QuikTables
    830 DATA /hamcalc/prog/helphint,READ ME
    850 DATA /hamcalc/prog/newsince,Recent program additions & upgrades
    870 DATA /hamcalc/prog/zexit,EXIT

The following program is explicitly referenced.

::

    840 DATA /hamcalc/prog/logoclok,Clock Screen Saver

..  note:: Why Are These Special?

    These "other" programs are like :program:`intro`: they're not proper calculations. They're just overhead.

    However.

    :program:`intro` is special in that it's called out by the external .BAT file as being the "entry point".

    Therefore, :program:`intro` needs to be left around as a visible artifact.

    The other programs, (``helphint``, ``newsince`` and ``zexit``) seem to have
    no stand-alone life.

Quick Tables
=============

The "QuikTables" program, :file:`quiktabl`, specifically lists a few other
programs that bypass the ordinary menu structure. Here's the list.

::

    Item( "", "awgexact", "A.W.G. wire sizes" ),
    Item( "", "propcirc", "Circles - properties of" ),
    Item( "", "decibel", "Decibels" ),
    Item( "", "deciconv", "Decimal numbers to degrees/minutes/seconds" ),
    Item( "", "decifrac", "Decimals to fractions" ),
    Item( "", "equiv", "Degrees to radians" ),
    Item( "", "deciconv", "Degrees/minutes/seconds to decimal" ),
    Item( "", "equiv", "Equivalent values" ),
    Item( "", "decifrac", "Fractions to decimals" ),
    Item( "", "numderiv", "Logarithms" ),
    Item( "", "numderiv", "Numbers - functions of" ),
    Item( "", "numderiv", "Powers of numbers" ),
    Item( "", "primenos", "Prime numbers" ),
    Item( "", "equiv", "Radians to degrees" ),
    Item( "", "numderiv", "Reciprocals of numbers" ),
    Item( "", "numderiv", "Roots of numbers" ),
    Item( "", "equiv", "Temperature" ),
    Item( "", "solutri", "Triangles - solution of" ),
    Item( "", "trig", "Trigonometric functions" ),

Data Files
==========

This program reads and displays two documentation files.

-   The change log file.  :file:`/hamcalc/docfiles/newsince.rtf`

-   The ackowledgements file.  :file:`/hamcalc/docfiles/acknow.fil`

"""
__version__ = "129"
__release__ = "25 JAN 2011"

import os
import ast
import runpy
from collections import namedtuple
import string
import csv
import hamcalc.stdio.intro

class Item:
    """A menu Item is a runnable program.
    This will have a path, a name, and a docstring.

    The docstring is further parsed into the title and the hamdex indexing phrases.
    """
    def __init__( self, path, name, docstring ):
        self.path= path
        self.name= name
        self.docstring= docstring
        self.title, self.hamdex = Item.parse_docstring( self.docstring )
    @staticmethod
    def parse_docstring( docstring ):
        """Parse a docstring.

        Line 1 is the title.

        All other lines are CSV lines with Hamdex index information.
        Generally, in the form "Heading", "Subheading", "Notes", "Program"
        We discard the fourth column, if present.

        Also, old-style Hamdex had commas in the data:

        ::

            "BAROMETER",", equivalent readings","","BAROMTR"

        This is silly; we don't need the comma.

        We collapse the Hamdex index items into a single string.
        """
        lines= docstring.splitlines()
        title= lines[0]
        hamdex= []
        rdr= csv.reader( lines[1:] )
        for line in rdr:
            if len(line) == 0: continue
            index= ", ".join( txt if txt[0] != ',' else txt[1:].strip() for txt in line[:3] if len(txt) != 0 )
            hamdex.append( index )
        return title, hamdex

def module_iter( omit=('intro','menu') ):
    """Iterator over the module files, excluding certain names."""
    directory, _ = os.path.split( __file__ )
    for path, dirs, files in os.walk( directory ):
        for f in files:
            name, ext = os.path.splitext( f )
            if name.startswith( "__" ): continue
            if name in omit: continue
            if ext.endswith( ".py" ):
                yield os.path.abspath( os.path.join( path, f ) )

def mod_docstring_iter( ):
    """Iterator over the module names and docstrings; to create menu Items."""
    for module_name in module_iter():
        path, full_name = os.path.split( module_name )
        name, ext = os.path.splitext( full_name )
        with open(module_name) as source:
            module= ast.parse( source.read() )
            # get docstring, assuming it's the first String in the module
            docstring, title, hamdex= "", "", ""
            for stmt in module.body:
                if isinstance( stmt, ast.Expr ) and isinstance( stmt.value, ast.Str ):
                    docstring= stmt.value.s
                    break
            yield Item( module_name, name, docstring )

def helphint():
    text="""\
 IMPORTANT! PLEASE READ THE INSTRUCTIONS PROVIDED WITH THE HAMCALC PROGRAM!

 Most of these programs ask you to input data. If you are asked to enter some
data that you don't know, or that you want the computer to tell YOU, just
press the <ENTER> key to by-pass the question.

 Some of the data asked for is essential. In this case the computer will keep
hounding you for it no matter how many times you try to dodge the question.
Don't worry if you by-pass a question you feel you should have answered. The
computer will ask it again if it is something the computer really needs.

 If a prompt begins with the word ENTER then type in the data and press the
<ENTER> key. If you are prompted to PRESS a key then just press the indicated
key. There is no need to press <ENTER> as well.

 If something goes wrong press the CTRL key and hold it down while you press
the PAUSE/BREAK key. This will halt the program and a 'Break' message will
appear on the screen. Then press the F2 key to re-start the program from the
beginning, or the F10 key to return to GWBASIC. You can try this right now if
you wish, just to see how it works . . . . .
"""
    print( text )
    input( "Continue?" )

def newsince():
    """The change log.

    ..   todo:: Display the change log file.
        :file:`/hamcalc/docfiles/newsince.rtf`
    """
    pass

def zexit():
    """The exit message.

    ..  todo:: Build this from the ackowledgements file.
        :file:`/hamcalc/docfiles/acknow.fil`
    """
    text= """\
      HAMCALC could never have been what and where it is without the
      encouragement and input in terms of friendship, time, and expertise
      from many people worldwide, especially

  Tom Atkins VE3CDM, IARU Region II       Goran Hosinsky, EA8YU, Canary Islands
  Prof. Walter Banzhaf, U.of Hartford     Prof. Larry Huelsman, U.of Arizona
  Dr. J.H.R. Beaujon, PJ2HB, Neth.Ant.    Harold Kane, W2AHW, USA
  Dr. Ing Boutsen, ON1ABU, U.of Brussels  Roel Koekoek, PA0RBK, Holland
  Al Buxton, W8NX, USA                    David LaHay, VE7FVW, Canada
  L.B. Cebik, W4RNL, USA                  Erik Madsen, OZ8EM, Denmark
  Robert J. Dehoney, IEEE, USA            Rich Moseson, W2VU, USA
  Doug DeMaw, W1FB, USA                   Jimmy Mistry, VU2IJ, India
  Bob Dunn, VE3ATK, Canada                Gary O'Neil, N3GO, USA
  Dr. Brian Egan, ZL1LE, New Zealand      Dr. Val Pristavko, EW1AAA, Belarus
  Istvan Ehmann, HA7VE, U.of Budapest     Dr. James Resh, Michigan State U.
  Bob Eldridge, VE7BS, Canada             Joe Southward, VE3SCY, Canada
  Mark Ellison, VA2MKE, Canada            Bob Stein, W6NBI, USA
  Günter Hoch, DL6WU, Germany             Hal Wright, W9UYA, USA

      and most especially my wonderful wife Anne, who has forgiven me for
      letting HAMCALC turn what started out to be a part-time retirement
      project into a most pleasurable (and almost full-time) occupation.
"""
    print( text )

def logoclok():
    runpy.run_module( 'hamcalc.stdio.logoclok' )

class Menu:
    """Show a menu, pick an item.

    For a top-level menu, that reveals a sub-menu.
    For a sub-menu, that executes a program.
    """
    def __init__( self, name ):
        self.name= name
        self.quit= False
        self.finished= False
    def display( self ):
        raise Exception( "Not Implemented" )
    def get_choice( self ):
        raise Exception( "Not Implemented" )
    def handle_choice( self, choice ):
        """May set self.quit or self.finished."""
        raise Exception( "Not Implemented" )
    def process( self ):
        self.finished= False
        while not self.finished and not self.quit:
            self.display()
            choice= self.get_choice()
            self.handle_choice( choice )
        return self.quit

class Top_Menu( Menu ):
    """The top-level menu.

    Picking an item here shows a sub-menu."""
    def __init__( self, quicktables, item_list ):
        super().__init__( "" )
        self.quicktables= quicktables
        self.item_list= item_list
    def display( self ):
        """Display the top-level menu."""
        print( "H  A  M  C  A  L  C     Version {0:3s},{1:14s}   by George Murphy VE3ERP".format(__version__,__release__).center(80) )
        print( "PAINLESS MATH for RADIO AMATEURS".center(80) )
        print( "M A I N    M E N U".center(80) )
        print()
        print( "(z)  QuickTables" )
        for code, item in enumerate(self.item_list):
            print( "({0})  {1}".format(string.ascii_lowercase[code], item.name) )
        print( "(j)  INDEX" )
        print( "(k)  READ ME" )
        print( "(l)  Clock Screen Saver" )
        print( "(m)  Recent program additions & upgrades" )
        print( "(n)  EXIT " )
        print( '"Aversion to mathematics is not an acquired distaste - it comes naturally"'.center(80) )
    def get_choice( self ):
        """Prompt and get the user's choice."""
        page_raw= input( "Choice? " ).lower()
        return page_raw
    def handle_choice( self, choice ):
        """Handle the user's choice."""
        global hamdex
        if choice == 'z':
            # quick tables -- special menu
            self.quicktables.process()
        elif choice == 'j':
            hamdex.process()
        elif choice == 'k':
            # Display the Readme .RTF file
            helphint()
        elif choice == 'l':
            # Run some other program
            logoclok()
        elif choice == 'm':
            # Display the change log file
            newsince()
        elif choice == 'n':
            self.quit= True
        else:
            page= string.ascii_lowercase.find( choice )
            if 0 <= page < len(self.item_list):
                program_menu= self.item_list[page]
                program_menu.process()
                self.quit= program_menu.quit

class Program_Menu( Menu ):
    """The program menu.

    Picking an item runs a program."""
    def __init__( self, name, item_list ):
        super().__init__( name )
        self.item_list= item_list
    def display( self ):
        """Display the two-column program menu."""
        print( " H A M C A L C  Program Menu {0}                           by George Murphy VE3ERP".format( self.name ) )
        for i in range( min(20, len(self.item_list) ) ):
            print( "{0:02d} {1.title:32s}".format(i, self.item_list[i]), end='' )
            if i+20 < len(self.item_list):
                print( "{0:02d} {1.title:32s}".format(i+20, self.item_list[i+20]), end='' )
            print()
        print( "41:MENU   42:INDEX   43:EXIT" )
    def get_choice( self ):
        """Prompt and get the user's choice."""
        program_num= None
        while program_num is None:
            program_raw= input( "Program to run? " )
            try:
                program_num= int( program_raw )
            except ValueError:
                pass
        return program_num
    def handle_choice( self, choice ):
        """Handle the user's choice."""
        global hamdex
        if choice == 41:
            self.finished= True
        elif choice == 42:
            hamdex.process()
        elif choice == 43:
            self.quit= True
        else:
            try:
                program= self.item_list[choice]
            except IndexError:
                return
            runpy.run_module( 'hamcalc.stdio.' + program.name )

class Topic_Index( Menu ):
    """The Hamdex topic index.

    Picking an item runs a program.

    Each page is 24 rows of one-letter codes: ``<a>-<x>`` plus
    a additional menu items for navigation

    ``1-NEXT PAGE │2-PREVIOUS PAGE │3-ANOTHER PAGE │4-EXIT``

    The "ANOTHER PAGE" prompt gets a starting letter to be
    used to filter the programs in the index.

    Note that programs are listed multiple times if they
    have multiple Hamdex index lines in their docstring.
    """
    def __init__( self, item_list ):
        super().__init__( "" )
        self.item_dict= dict()
        for item in item_list:
            count= 0
            for ham in item.hamdex:
                self.item_dict[ham]= item
                count += 1
            if count == 0:
                self.item_dict[item.title]= item
        self.item_list= list(sorted(self.item_dict.keys()))
    def display( self ):
        for i, item in enumerate(self.item_list[self.count:self.count+24]):
            print( "<{0}> {1}".format( string.ascii_lowercase[i], item ) )
        print( "1-NEXT PAGE │2-PREVIOUS PAGE │3-ANOTHER PAGE │4-EXIT" )
    def get_choice( self ):
        choice= input( "Choice? " )
        return choice
    def handle_choice( self, choice ):
        if choice == '1':
            self.count = self.count+24 if self.count+24 < len(self.item_list) else 0
        elif choice == '2':
            self.count = self.count-24 if self.count-24 >= 0 else len(self.item_list)-24
        elif choice == '3':
            self.filter= input( "ENTER LETTER AT WHICH YOU WANT AN INDEX PAGE TO BEGIN? " ).upper()
            for i, item in enumerate(self.item_list):
                if item[0].upper() >= self.filter:
                    self.count= i
                    break
        elif choice == '4':
            self.quit= True
        else:
            choice_num= string.ascii_lowercase.find( choice )
            if choice_num == -1: return
            index= self.count + choice_num
            program= self.item_dict[self.item_list[index]]
            runpy.run_module( 'hamcalc.stdio.' + program.name )
    def process( self ):
        self.count= 0
        super().process()

class QT_Menu( Menu ):
    """The QuikTabl menu."""
    def __init__( self ):
        super().__init__( "QuikTables                                              by George Murphy VE3ERP" )
        self.item_list= [
        Item( "", "awgexact", "A.W.G. wire sizes" ),
        Item( "", "propcirc", "Circles - properties of" ),
        Item( "", "decibel", "Decibels" ),
        Item( "", "deciconv", "Decimal numbers to degrees/minutes/seconds" ),
        Item( "", "decifrac", "Decimals to fractions" ),
        Item( "", "equiv", "Degrees to radians" ),
        Item( "", "deciconv", "Degrees/minutes/seconds to decimal" ),
        Item( "", "equiv", "Equivalent values" ),
        Item( "", "decifrac", "Fractions to decimals" ),
        Item( "", "numderiv", "Logarithms" ),
        Item( "", "numderiv", "Numbers - functions of" ),
        Item( "", "numderiv", "Powers of numbers" ),
        Item( "", "primenos", "Prime numbers" ),
        Item( "", "equiv", "Radians to degrees" ),
        Item( "", "numderiv", "Reciprocals of numbers" ),
        Item( "", "numderiv", "Roots of numbers" ),
        Item( "", "equiv", "Temperature" ),
        Item( "", "solutri", "Triangles - solution of" ),
        Item( "", "trig", "Trigonometric functions" ),
         ]
    def display( self ):
        """Display the QuickTable menu."""
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
            runpy.run_module( 'hamcalc.stdio.' + program.name )
    def process( self ):
        self.quit= False
        super().process()

def run( intro=True ):
    """Examine the STDIO path to locate all programs, build a two-tier index
    and a "flat" Hamdex index.

    Present a menu of available programs, get the user's choice, run the requested program.
    """
    global hamdex
    if intro:
        hamcalc.stdio.intro.run( menu=False )

    # Find all programs
    all_programs= list( mod_docstring_iter() )
    # Group into 40-program subsets.
    page_group_iter= ( all_programs[i:i+40] for i in range(0, len(all_programs), 40 ) )
    # Build Program_Menu instances for each subset.
    pages= [ Program_Menu( "Program Menu {0}  ( {1}-{2} )".format(
        string.ascii_uppercase[i//40], pg[0].title[:3], pg[-1].title[:3] ), pg ) for i, pg in enumerate(page_group_iter) ]
    # Build the special Quick Tables menu.
    quick_tables= QT_Menu()
    # Build a top-level menu from the Quick Tables and the Pages
    menu= Top_Menu( quick_tables, pages )
    # Also build the flat index.
    hamdex= Topic_Index( all_programs )

    menu.process()
    zexit()

if __name__ == "__main__":
    run()
