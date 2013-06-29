"""Equivalent Values

"Degrees to radians","","","equiv"
"Equivalent values","","","equiv"
"Radians to degrees","","","equiv"
"Temperature","","","equiv"

"""

import hamcalc.math.equiv as equiv
from hamcalc.stdio import *
import runpy
from collections import Callable

class Equivalence( Callable ):
    """General **Equivalence** among a list of individual Unit classes.
    """
    def __call__( self, name, *unit_list ):
        self.menu( unit_list )

        measure_raw= input( "ENTER: number in ( ) to select base unit:" )
        if len(measure_raw) == 0: return
        unit= self.get_measure( measure_raw, unit_list )
        if unit is None:
            measure= self.handle_alt_units( )
        else:
            measure= self.handle_value( unit )
        if measure is None: return
        self.display( measure, unit, unit_list )

    def handle_alt_units( self ):
        pass

    def menu( self, unit_list ):
        for i, u in enumerate( unit_list ):
            print( "  ( {0:d} )  {1.__doc__:.<20s}({1.name:s})".format( i, u ) )

    def get_measure( self, measure_raw, unit_list ):
        try:
            measure_num= int( measure_raw )
            unit= unit_list[measure_num]
            return unit
        except (ValueError, IndexError):
            return

    def handle_value( self, unit ):
        value= input_float( "ENTER: How many {0.__doc__}...? ".format(unit) )
        if value is None: return
        measure= unit.to_std( value )
        return measure

    def display( self, measure, unit, unit_list ):
        u= unit_list[0]
        print( "   {0:12.4f} {1.__doc__:.<20s}({1.name:s})".format(u.from_std(measure),u) )
        for u in unit_list[1:]:
            print( " = {0:12.4f} {1.__doc__:.<20s}({1.name:s})".format(u.from_std(measure),u) )

class Frequency_Wavelength( Equivalence ):
    def menu( self, unit_list ):
        super().menu( unit_list )
        self.wavelength= len(unit_list)
        print( "  ( {0:d} )  {1:.<20s}({2:s})".format( self.wavelength, "Wavelength", "m" ) )
    def handle_alt_units( self ):
        value= input_float( "ENTER: How many {0}...? ".format("Wavelength") )
        if value is None: return
        args= equiv.freq_wavelength( l=value )
        measure= equiv.HERTZ.to_std( args.f )
        return measure
    def display( self, measure, unit, unit_list ):
        super().display( measure, unit, unit_list )
        args= equiv.freq_wavelength( f=measure )
        print( " = {0:12.4f} {1.__doc__:.<20s}({1.name:s})".format(equiv.METRE.from_std(args.l),equiv.METRE) )

equivalence= Equivalence()

frequency_wavelength = Frequency_Wavelength()

def equiv_values():
    print( "ENTER letter in < > to determine equivalent values of: " )
    print( "  < a >  Capacitance" )
    print( "  < b >  Current" )
    print( "  < c >  Degrees / Minutes / Seconds" )
    print( "  < d >  Degrees / Radians" )
    print( "  < e >  Frequencies/Wavelengths" )
    print( "  < f >  Inductance" )
    print( "  < g >  Length / Distance" )
    print( "  < h >  Transmission Line Length" )
    print( "  < i >  Resistance" )
    print( "  < j >  Temperature" )
    print( "  < k >  Time" )
    print( "  < l >  Sexigesimal/decimal converter" )
    print( "  < m >  Miles per imperial gallon / kilometres per litre" )
    print( "  < n >  Electrical length / Physical length" )
    print()
    print( "  < z >  Exit Program" )
    unit_raw= input( "Units? " )
    if len(unit_raw) == 0: return
    if unit_raw == 'a':
        name, unit_list= 'Capacitance', equiv.unit_map['capacitance']
        equivalence( name, *unit_list )
    elif unit_raw == 'b':
        name, unit_list= 'Current', equiv.unit_map['current']
        equivalence( name, *unit_list )
    elif unit_raw == 'c':
        runpy.run_module( 'hamcalc.stdio.deciconv' )
    elif unit_raw == 'd':
        name, unit_list= 'Degrees / Radians', equiv.unit_map['degrees']
        equivalence( name, *unit_list )
    elif unit_raw == 'e':
        name, unit_list= 'Frequencies/Wavelengths', equiv.unit_map['frequency']
        frequency_wavelength( name, *unit_list )
    elif unit_raw == 'f':
        name, unit_list= 'Inductance', equiv.unit_map['inductance']
        equivalence( name, *unit_list )
    elif unit_raw == 'g':
        name, unit_list= 'Length / Distance', equiv.unit_map['length']
        equivalence( name, *unit_list )
    elif unit_raw == 'h':
        runpy.run_module( 'hamcalc.stdio.elecleng' )
    elif unit_raw == 'i':
        name, unit_list= 'Resistance', equiv.unit_map['resistance']
        equivalence( name, *unit_list )
    elif unit_raw == 'j':
        name, unit_list= 'Temperature', equiv.unit_map['temperature']
        equivalence( name, *unit_list )
    elif unit_raw == 'k':
        name, unit_list= 'Time', equiv.unit_map['time']
        equivalence( name, *unit_list )
    elif unit_raw == 'l':
        runpy.run_module( 'hamcalc.stdio.deciconv' )
    elif unit_raw == 'm':
        name, unit_list= 'Miles per imperial gallon / kilometres per litre', equiv.unit_map['mpg']
        equivalence( name, *unit_list )
    elif unit_raw == 'n':
        runpy.run_module( 'hamcalc.stdio.elecleng' )
    return unit_raw

print( equiv.intro() )

z= None
while z != 'z':
    z = equiv_values()
