"""hamcalc.construction.beamdefl

A family of **Solver** classes to handle 10 beam deflection cases.

Plus definitions of modulus of elasticity for some common construction
materials.

The materials are a module global, :data:`material`.

..  csv-table::

    "Material","E","PCI"
    "Steel Alloy","30000000","0.2833"
    "Structural Steel","29000000","0.2833"
    "Wrought Iron","28000000","0.285"
    "Extruded Aluminum","10300000","0.0979"
    "Fir","1760000","0.0162"
    "Redwood","1320000","0.0162"
    "Cedar, Pine or Spruce","1100000","0.0162"

Test Cases for Materials

>>> import hamcalc.construction.beamdefl as beamdefl
>>> beamdefl.material["Pine"]
Material(name='Pine', E=1100000, PCI=0.0162)


Test Cases for BEAM SUPPORTED BOTH ENDS, UNIFORM LOAD

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C1= beamdefl.Case_1()
>>> a=C1( W=100, I=15, L=36, E=1760000.0 )
>>> round(a.D,3)
0.002
>>> round(a.MD,3)
0.1
>>> a
{'MD': 0.1, 'E': 1760000.0, 'D': 0.0023011363636363637, 'I': 15, 'L': 36, 'W': 100}
>>> b=C1( D=0.0023, I=15, L=36, E=1760000.0 )
>>> round(b.W,0)
100.0
>>> c=C1( D=0.0023, W=100, L=36, E=1760000.0 )
>>> round(c.I,3)
15.007
>>> d=C1( D=0.0023, W=100, I=15, E=1760000.0 )
>>> round(d.L,3)
35.994

Test Cases for BEAM SUPPORTED BOTH ENDS, LOAD AT CENTRE

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C2= beamdefl.Case_2()
>>> a=C2( W=100, I=5, L=36, E=1760000.0 )
>>> round(a.D,3)
0.011
>>> round(a.MD,3)
0.1
>>> b=C2( D=0.011, I=5, L=36, E=1760000.0 )
>>> round(b.W,0)
100.0
>>> c=C2( D=0.011, W=100, L=36, E=1760000.0 )
>>> round(c.I,3)
5.021
>>> d=C2( D=0.011, W=100, I=5, E=1760000.0 )
>>> round(d.L,3)
35.951

Test Cases for BEAM SUPPORTED BOTH ENDS, LOAD AT ANY POINT

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C3= beamdefl.Case_3()
>>> a=C3( W=250, I=1.5, L=36, E=10300000.0, A=30 )
>>> round(a.D,3)
0.005
>>> round(a.MD,3)
0.1
>>> b=C3( D=0.005, I=1.5, L=36, E=10300000.0, A=30 )
>>> round(b.W,0)
258.0
>>> c=C3( D=0.005, W=250, L=36, E=10300000.0, A=30 )
>>> round(c.I,3)
1.456
>>> d=C3( D=0.005, W=250, I=1.5, E=10300000.0, A=30, B=6 )
>>> round(d.L,3)
34.951

Test Cases for BEAM SUPPORTED BOTH ENDS, TWO SYMMETRICAL LOADS

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C4= beamdefl.Case_4()
>>> a=C4( W=350, I=1.5, L=36, E=10300000.0, A=30 )
>>> round(a.D,3)
0.008
>>> round(a.D1,3)
-0.041
>>> round(a.MD,3)
0.1
>>> b=C4( D=0.008, I=1.5, L=36, E=10300000.0, A=30 )
>>> round(b.W,0)
343.0
>>> c=C4( D1=-0.041, I=1.5, L=36, E=10300000.0, A=30 )
>>> round(c.W,0)
352.0

Test Cases for CANTILEVER BEAM FIXED ONE END, UNIFORM LOAD

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C10= beamdefl.Case_10()
>>> a=C10( W=450, I=1.5, L=36, E=10300000.0 )
>>> round(a.D,3)
0.17
>>> round(a.MD,3)
0.1
>>> b=C10( D=0.17, I=1.5, L=36, E=10300000.0 )
>>> round(b.W,0)
450.0
>>> c=C10( D=0.17, W=450, L=36, E=10300000.0 )
>>> round(c.I,3)
1.499
>>> d=C10( D=0.17, W=450, I=1.5, E=10300000.0 )
>>> round(d.L,3)
36.01

Test Cases for CANTILEVER BEAM FIXED ONE END, LOAD AT OTHER

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C11= beamdefl.Case_11()
>>> a=C11( W=550, I=1.5, L=36, E=10300000.0 )
>>> round(a.D,3)
0.554
>>> round(a.MD,3)
0.1
>>> b=C11( D=0.554, I=1.5, L=36, E=10300000.0 )
>>> round(b.W,0)
550.0
>>> c=C11( D=0.554, W=550, L=36, E=10300000.0 )
>>> round(c.I,3)
1.499
>>> d=C11( D=0.554, W=550, I=1.5, E=10300000.0 )
>>> round(d.L,3)
36.008

Test Cases for BEAM FIXED AT ONE END, INTERMEDIATE LOAD

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C12= beamdefl.Case_12()
>>> a=C12( W=350, I=1.5, E=10300000.0, L=36, AA=30 )
>>> round(a.D,3)
0.204
>>> round(a.D1,3)
0.326
>>> round(a.MD,3)
0.1

Test Cases for BEAM FIXED BOTH ENDS, UNIFORM LOAD

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C18= beamdefl.Case_18()
>>> a=C18( W=650, I=1.5, E=10300000.0, L=36 )
>>> round(a.D,3)
0.005
>>> b=C18( D=0.005, I=1.5, L=36, E=10300000.0 )
>>> round(b.W,0)
636.0
>>> c=C18( D=0.005, W=650, L=36, E=10300000.0 )
>>> round(c.I,3)
1.533
>>> d=C18( D=0.005, W=650, I=1.5, E=10300000.0 )
>>> round(d.L,3)
35.736

Test Cases for BEAM FIXED BOTH ENDS, LOAD AT CENTRE

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C19= beamdefl.Case_19()
>>> a=C19( W=750, I=1.5, E=10300000.0, L=36 )
>>> round(a.D,3)
0.012
>>> b=C19( D=0.012, I=1.5, L=36, E=10300000.0 )
>>> round(b.W,0)
763.0
>>> c=C19( D=0.012, W=750, L=36, E=10300000.0 )
>>> round(c.I,3)
1.475
>>> d=C19( D=0.012, W=750, I=1.5, E=10300000.0 )
>>> round(d.L,3)
36.206

Test Cases for BEAM FIXED BOTH ENDS, LOAD AT ANY POINT

>>> import hamcalc.construction.beamdefl as beamdefl
>>> C20= beamdefl.Case_20()
>>> a=C20( W=850, I=1.5, E=10300000.0, L=36, A=30 )
>>> round(a.D,3)
0.002
>>> b=C20( D=0.0023, I=1.5, L=36, E=10300000.0, A=30 )
>>> round(b.W,0)
853.0
>>> c=C20( D=0.0023, W=850, L=36, E=10300000.0, A=30 )
>>> round(c.I,3)
1.495
>>> d=C20( D=0.0023, W=850, I=1.5, E=10300000.0, A=30, B=6 )
>>> round(d.L,3)
35.96

"""
from hamcalc.lib import Solver, NoSolutionError
from collections import namedtuple, OrderedDict
import math

def intro():
    return """\
DEFLECTION in BEAMS                                     by George Murphy VE3ERP
 Ref: Machinery's Handbook, 21st Edition
"""

Material= namedtuple( "Material", ["name","E","PCI"] )

material_list = [
    Material("Steel Alloy", 30000000, 0.2833),
    Material("Structural Steel", 29000000, 0.2833),
    Material("Wrought Iron", 28000000, 0.285),
    Material("Extruded Aluminum", 10300000, 0.0979),
    Material("Fir", 1760000, 0.0162),
    Material("Redwood", 1320000, 0.0162),
    Material("Cedar", 1100000, 0.0162),
    Material("Pine", 1100000, 0.0162),
    Material("Spruce", 1100000, 0.0162),
]

material = OrderedDict(
    (m.name,m) for m in material_list
)

class BeamSolver( Solver ):
    """Superclass for beam deflection solvers."""
    def __call__( self, *args, **kw ):
        result= super().__call__( *args, **kw )
        if result: self.args= result
        self.set_max_defl()
        return self.args
    def set_max_defl( self ):
        """Compute maximum deflection."""
        self.args.MD= self.args.L/360

class Case_1( BeamSolver ):
    """BEAM SUPPORTED BOTH ENDS, UNIFORM LOAD
    D= (5/384) x (W x L^3) / (E x I)
    """
    positions= "centre",""
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :D: Deflection (in inches)
        """
        if self.args_contains( "W", "L", "E", "I" ):
            args.D = 5*args.W*args.L**3/(384*args.E*args.I)
        elif self.args_contains( "D", "E", "I", "L" ):
            args.W = args.D*384*args.E*args.I/(5*args.L**3)
        elif self.args_contains( "D", "W", "E", "L" ):
            args.I = args.W*5*args.L**3/(args.D*384*args.E)
        elif self.args_contains( "D", "W", "E", "I" ):
            args.L = (args.D*384*args.E*args.I/(5*args.W))**(1/3)
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args

class Case_2( BeamSolver ):
    """BEAM SUPPORTED BOTH ENDS, LOAD AT CENTRE
    D= (W x L^3) / (48 x E x I)
    """
    positions= "load",""
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :D: Deflection (in inches)
        """
        if self.args_contains( "W", "L", "E", "I" ):
            args.D = args.W*args.L**3/(48*args.E*args.I)
        elif self.args_contains( "D", "E", "I", "L" ):
            args.W = args.D*48*args.E*args.I/args.L**3
        elif self.args_contains( "D", "W", "E", "L" ):
            args.I = args.W*args.L**3/(args.D*48*args.E)
        elif self.args_contains( "D", "W", "E", "I" ):
            args.L = (args.D*48*args.E*args.I/args.W)**(1/3)
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args

class Case_3( BeamSolver ):
    """BEAM SUPPORTED BOTH ENDS, LOAD AT ANY POINT
    D= (W x A^2 x B^2) / (3 x E x I x L)
    """
    positions= "load",""
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :D: Deflection (in inches)
        :A: Load distance from nearest end
        :B: Load distance from farthest end
        """
        if "A" in args and "L" in args:
            args.B = args.L - args.A

        if self.args_contains( "W", "A", "B", "E", "I", "L" ):
            args.D= args.W*args.A**2*args.B**2/(3*args.E*args.I*args.L)
        elif self.args_contains( "D", "E", "I", "L", "A", "B" ):
            args.W= args.D*3*args.E*args.I*args.L/(args.A**2*args.B**2)
        elif self.args_contains( "D", "E", "I", "L", "W", "B" ):
            args.A= math.sqrt(args.D*3*args.E*args.I*args.L/(args.W*args.B**2))
        elif self.args_contains( "W", "A", "B", "D", "E", "L" ):
            args.I= args.W*args.A**2*args.B**2/(args.D*3*args.E*args.L)
        elif self.args_contains( "W", "A", "B", "D", "E", "I" ):
            args.L= args.W*args.A**2*args.B**2/(args.D*3*args.E*args.I)
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args

class Case_4( BeamSolver ):
    """BEAM SUPPORTED BOTH ENDS, TWO SYMMETRICAL LOADS
    at centre: D= (W x A) / (24 x E x I) x (3 x L^2 - 4 x A^2)
    at loads: D1= (W x A^2) / (6 x E x I) x (3 x L - 4 x A)
    """
    positions= "centre", "loads"
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :A: Load distance from nearest end
        :D: Deflection (in inches) at center
        :D1: Deflection (in inches) at loads

        ..  todo:: Solve for I or L.
        """
        if self.args_contains( "W", "A", "L", "E", "I" ):
            args.D= args.W*args.A*(3*args.L**2-4*args.A**2)/(24*args.E*args.I)
            args.D1= args.W*args.A**2*(3*args.L-4*args.A)/(6*args.E*args.I)
        elif self.args_contains( "D", "A", "L", "E", "I" ):
            args.W= args.D/(args.A*(3*args.L**2-4*args.A**2)/(24*args.E*args.I))
        elif self.args_contains( "D1", "A", "L", "E", "I" ):
            args.W= args.D1/(args.A**2*(3*args.L-4*args.A)/(6*args.E*args.I))
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args

class Case_10( BeamSolver ):
    """CANTILEVER BEAM FIXED ONE END, UNIFORM LOAD
    D= (W x L^3) / (8 x E x I)
    """
    positions= "end", ""
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :D: Deflection (in inches)
        """
        if self.args_contains( "W", "L", "E", "I" ):
            args.D = args.W*args.L**3/(8*args.E*args.I)
        elif self.args_contains( "D", "E", "I", "L" ):
            args.W = args.D*8*args.E*args.I/args.L**3
        elif self.args_contains( "D", "W", "E", "L" ):
            args.I = args.W*args.L**3/(args.D*8*args.E)
        elif self.args_contains( "D", "W", "E", "I" ):
            args.L = (args.D*8*args.E*args.I/args.W)**(1/3)
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args

class Case_11( BeamSolver ):
    """CANTILEVER BEAM FIXED ONE END, LOAD AT OTHER
    D= (W x L^3) / (3 x E x I)
    """
    positions= "end", ""
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :D: Deflection (in inches)
        """
        if self.args_contains( "W", "L", "E", "I" ):
            args.D = args.W*args.L**3/(3*args.E*args.I)
        elif self.args_contains( "D", "E", "I", "L" ):
            args.W = args.D*3*args.E*args.I/args.L**3
        elif self.args_contains( "D", "W", "E", "L" ):
            args.I = args.W*args.L**3/(args.D*3*args.E)
        elif self.args_contains( "D", "W", "E", "I" ):
            args.L = (args.D*3*args.E*args.I/args.W)**(1/3)
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args

class Case_12( BeamSolver ):
    """BEAM FIXED AT ONE END, INTERMEDIATE LOAD
    at load: D= (W x AA^3) / (3 x E x I)
    at end: D1= (W x AA^2) / (6 x E x I) x (2 x AA + 3 x BB)
    """
    positions= "load", "end"
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :D: Deflection (in inches)
        :AA: Load distance from fixed end
        :BB: Load distance from free end
        """
        if "AA" in args and "L" in args:
            args.BB = args.L - args.AA

        if self.args_contains( "W", "AA", "BB", "E", "I" ):
            args.D =(args.W*args.AA**3)/(3*args.E*args.I)
            args.D1=(args.W*args.AA**2)/(6*args.E*args.I)*(2*args.AA+6*args.BB)
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args

class Case_18( BeamSolver ):
    """BEAM FIXED BOTH ENDS, UNIFORM LOAD
    D= (W x L^3) / (384 x E x I)
    """
    positions= "centre", ""
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :D: Deflection (in inches)
        """
        if self.args_contains( "W", "L", "E", "I" ):
            args.D = args.W*args.L**3/(384*args.E*args.I)
        elif self.args_contains( "D", "E", "I", "L" ):
            args.W = args.D*384*args.E*args.I/(args.L**3)
        elif self.args_contains( "D", "W", "E", "L" ):
            args.I = args.W*args.L**3/(args.D*384*args.E)
        elif self.args_contains( "D", "W", "E", "I" ):
            args.L = (args.D*384*args.E*args.I/args.W)**(1/3)
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args

class Case_19( BeamSolver ):
    """BEAM FIXED BOTH ENDS, LOAD AT CENTRE
    D= (W x L^3) / (192 x E x I)
    """
    positions= "load", ""
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :D: Deflection (in inches)
        """
        if self.args_contains( "W", "L", "E", "I" ):
            args.D = args.W*args.L**3/(192*args.E*args.I)
        elif self.args_contains( "D", "E", "I", "L" ):
            args.W = args.D*192*args.E*args.I/(args.L**3)
        elif self.args_contains( "D", "W", "E", "L" ):
            args.I = args.W*args.L**3/(args.D*192*args.E)
        elif self.args_contains( "D", "W", "E", "I" ):
            args.L = (args.D*192*args.E*args.I/args.W)**(1/3)
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args

class Case_20( BeamSolver ):
    """BEAM FIXED BOTH ENDS, LOAD AT ANY POINT
    D= (W x A^3 x B^3)) / (3 x E x I x L^3)
    """
    positions= "load", ""
    def solve( self, args ):
        """
        :W: Weight (Load in pounds)
        :I: Inertia (Moment of Inertia in inches^4)
        :L: Length (in inches)
        :E: Elasticity Modulus (in PSI)
        :D: Deflection (in inches)
        :A: Load distance from nearest end
        :B: Load distance from farthest end
        """
        if "A" in args and "L" in args:
            args.B = args.L - args.A

        if self.args_contains( "W", "A", "B", "E", "I", "L" ):
            args.D= args.W*args.A**3*args.B**3/(3*args.E*args.I*args.L**3)
        elif self.args_contains( "D", "E", "I", "L", "A", "B" ):
            args.W= args.D*3*args.E*args.I*args.L**3/(args.A**3*args.B**3)
        elif self.args_contains( "D", "E", "I", "L", "W", "B" ):
            args.A= (args.D*3*args.E*args.I*args.L**3/(args.W*args.B**3))**(1/3)
        elif self.args_contains( "W", "A", "B", "D", "E", "L" ):
            args.I= args.W*args.A**3*args.B**3/(args.D*3*args.E*args.L**3)
        elif self.args_contains( "W", "A", "B", "D", "E", "I" ):
            args.L= (args.W*args.A**3*args.B**3/(args.D*3*args.E*args.I))**(1/3)
        else:
            raise NoSolutionError( "No usable combination of inputs in {0!r}".format(args) )
        return args
