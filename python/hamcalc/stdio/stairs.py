"""Stairs And Stairways
"""
import hamcalc.construction.stairs as stairs
from hamcalc.lib import AttrDict, convert
from hamcalc.stdio import *

class Display_Template:
    """Overall stair design superclass.

    Each of the six subclasses will extend or
    modify this in some way to customize it for a
    specific design case.
    """
    B= "GENERIC"
    TR= ""
    def __init__( self, unit, **args ):
        """Initalized the calculation with user's desired
        units, and the initial :func:`stairs.stair_design`
        dictionary of computed values.
        """
        self.unit= unit
        self.args= AttrDict( args )
        self.f_hr_sw= False
    def calculate_headroom( self ):
        print( "To compute stairwell SW and headroom HR dimensions, enter a value for FL." )
        F = self.unit.to_std( input_float( "ENTER: Floor thickness FL ({0})..................? ".format(self.unit.name) ) )
        if F is not None:
            F_in = stairs.INCH.from_std( F )
            self.args= stairs.stairwell_headroom( F=F_in, **self.args )
            self.f_hr_sw= True
    def headroom( self ):
        """Optional headroom calculation.
        Stairways and Open Riser Step Ladders will override this
        to call :meth`calculate_headrooom` or similar.
        Other subclasses will leave this unimplemented to
        skip headroom calculations.
        """
        pass
    def range_check( self ):
        """Optional range check.
        Stairways check the *R* value.
        """
    def write( self ):
        self.headroom()

        print( "{B:^72s}".format( B=self.B ) )
        print( )
        self.p_value()
        self.n_value()
        print( "Pitch Angle...............cdb={A:8.2f}°".format(
            A=self.args.A) )
        self.risers_2()
        print( "Spread.....................SP={L:8.2f} {unit.name} {L_ft:s}".format(
            L=convert(self.args.L,stairs.INCH,self.unit), unit=self.unit,
            L_ft=convert(self.args.L,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )
        print( "Height.....................HT={H:8.2f} {unit.name} {H_ft:s}".format(
            H=convert(self.args.H,stairs.INCH,self.unit), unit=self.unit,
            H_ft=convert(self.args.H,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )

        if self.f_hr_sw:
            print( "Floor thickness............FL={F:8.2f} {unit.name} {F_ft:s}".format(
                F=convert(self.args.F,stairs.INCH,self.unit), unit=self.unit,
                F_ft=convert(self.args.F,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )
            print( "Headroom clearance.........HR={HR:8.2f} {unit.name} {HR_ft:s}".format(
                HR=convert(self.args.HR,stairs.INCH,self.unit), unit=self.unit,
                HR_ft=convert(self.args.HR,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )
            print( "Stairwell minimum length...SW={SW:8.2f} {unit.name} {SW_ft:s}".format(
                SW=convert(self.args.SW,stairs.INCH,self.unit), unit=self.unit,
                SW_ft=convert(self.args.SW,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )

        self.handrail()
        self.bottom_rung()
        self.range_check()

    def p_value( self, **args ):
        print( "Number of {TR:.<20s}{P:5d}".format(
            TR=self.TR, P=self.args.P ) )
    def n_value( self ):
        print( "Number of risers..............{N:5d}".format(
            N=self.args.N ) )
    def risers_2( self ):
        print( "Run........................cd={T:8.2f} {unit.name} {T_ft:s}".format(
            T=convert(self.args.T,stairs.INCH,self.unit), unit=self.unit,
            T_ft=convert(self.args.T,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )
        print( "Rise.......................bc={R:8.2f} {unit.name} {R_ft:s}".format(
            R=convert(self.args.R,stairs.INCH,self.unit), unit=self.unit,
            R_ft=convert(self.args.R,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )
        print( "String.....................bd={X:8.2f} {unit.name} {X_ft:s}".format(
            X=convert(self.args.X,stairs.INCH,self.unit), unit=self.unit,
            X_ft=convert(self.args.X,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )
        print( "Stringer length............ae={Y:8.2f} {unit.name} {Y_ft:s}".format(
            Y=convert(self.args.Y,stairs.INCH,self.unit), unit=self.unit,
            Y_ft=convert(self.args.Y,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )
    def handrail( self ):
        self.args= stairs.handrail_height( **self.args )
        print( "Handrail height above nosing..{B:8.2f} {unit.name} {B_ft:s}".format(
            B=convert(self.args.B,stairs.INCH,self.unit), unit=self.unit,
            B_ft=convert(self.args.B,stairs.INCH,stairs.FOOT_INCH_FRAC) ) )
    def bottom_rung( self ):
        pass

class Display_Ramp_Inclined( Display_Template ):
    B= "INCLINED RAMP"
    TR= None
    def p_value( self ):
        pass
    def handrail( self ):
        pass

class Display_Ladder_Vertical( Display_Template ):
    B= "VERTICAL LADDER"
    TR="rungs"
    def risers_1( self ):
        pass
    def risers_2( self ):
        pass
    def handrail( self ):
        pass
    def bottom_rung( self ):
        print( "Bottom to lowest rung.......B={TBR:8.2f} {unit.name}".format(
            TBR=convert(self.args.TBR,stairs.INCH,self.unit), unit=self.unit ) )
        print( "Rise.......................bc={R:8.2f} {unit.name}".format(
            R=convert(self.args.R,stairs.INCH,self.unit), unit=self.unit ) )
        print( "Top to highest rung.........T={TBR:8.2f} {unit.name}".format(
            TBR=convert(self.args.TBR,stairs.INCH,self.unit), unit=self.unit ) )

class Display_Ladder_Inclined( Display_Template ):
    B= "INCLINED LADDER"
    TR="rungs"

class Display_Ladder_Open( Display_Template ):
    B= "OPEN-RISER STEPLADDER"
    TR="steps"
    def headroom( self ):
        self.calculate_headroom()

class Display_Stairway( Display_Template ):
    B= "STAIRWAY"
    TR="treads"
    def headroom( self ):
        self.calculate_headroom()
    def range_check( self ):
        max_code= convert( 8, stairs.INCH, self.unit )
        max_comfort= convert( 7.5, stairs.INCH, self.unit )
        if self.args.R > 8:
            print( "NOTE: Rises in excess of {0:.1f} {1:s} are not permitted by most building codes.".format( max_code, self.unit.name ) )
        elif self.args.R > 7.5:
            print( "NOTE: Rises over {0:.1f} {1:s} tend to result in steep uncomfortable stairways.".format( max_comfort, self.unit.name ) )

class Display_Ramp_Step( Display_Template ):
    B= "STEP RAMP"
    TR="ramps"

class Display_Factory:
    """An object of this class is used to determine which design
    was created and create an appropriate :class:`Display_Template`
    instance.
    """
    def choose( self, unit, **args ):
        """Choose the :class:`Display_Template` for the given design.

        :param unit: the display units.
        :param args: the various keyword arguments created
            by :func:`stairs.stair_design`
        :returns: instance of the proper subclass of :class:`Display_Template`.
        """
        if stairs.is_ramp_inclined( **args ):
            format= Display_Ramp_Inclined(unit, **args)
        elif stairs.is_ladder_vertical( **args ):
            format= Display_Ladder_Vertical(unit, **args)
        elif stairs.is_ladder_inclined( **args ):
            format= Display_Ladder_Inclined(unit, **args)
        elif stairs.is_ladder_open( **args ):
            format= Display_Ladder_Open(unit, **args)
        elif stairs.is_stairway( **args ):
            format= Display_Stairway(unit, **args)
        elif stairs.is_ramp_step( **args ):
            format= Display_Ramp_Step(unit, **args)
        else:
            raise Exception( "Logic Error" )
        return format

def design( unit ):
    H= unit.to_std( input_float( "ENTER: Level-to-Level height HT ({0})...........? ".format(unit.name) ) )
    print( "If maximum allowable spread SP been NOT determined, hit return and enter nothing." )
    L= unit.to_std( input_float( "ENTER: Maximum allowable spread SP ({0})........? ".format(unit.name) ) )
    if L is None: # No SP determined
        max_econ, max_res = stairs.max_height(unit)
        print( "Recommended maximum rise = {0:.2f} for economy, {1:.2f} for residential.".format(max_econ,max_res) )
        R= unit.to_std( input_float( "ENTER: Maximum rise desired ({0})...............? ".format( unit.name ) ) )
        if 5 <= stairs.INCH.from_std(R) <= 13.5:
            pass
        else:
            lo= unit.from_std( stairs.INCH.to_std(5.0) )
            hi= unit.from_std( stairs.INCH.to_std(13.5) )
            print( "Outside maximum range of {0:.1f} to {1:.1f}".format(lo,hi) )
            return
    else:
        R= None
    display( unit, H, L, R )

def display( unit, H, L, R ):
    # Note. Design done in inches.
    H_in= stairs.INCH.from_std( H )
    L_in= stairs.INCH.from_std( L )
    R_in= stairs.INCH.from_std( R )
    result= stairs.stair_design( H_in, L_in, R_in )

    print( result )
    Display_Factory().choose( unit, **result ).write()

print( stairs.intro() )

z=None
while z != '0':
    print("   < 1 >  Metric")
    print("   < 2 >  U.S.A./Imperial")
    print("     or")
    print("   < 0 >  to EXIT")
    z= input( "CHOICE? " )
    if z == '1':
        design( stairs.MILLIMETRE )
    elif z == '2':
        design( stairs.INCH )
