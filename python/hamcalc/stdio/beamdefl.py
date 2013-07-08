"""Beam Deflection

"BEAMS",", properties of","","MECHMENU"
"PROPERTIES OF BEAMS","","","MECHMENU"
"""
import hamcalc.construction.beamdefl as beamdefl
from hamcalc.lib import AttrDict, NoSolutionError
from hamcalc.stdio import *
import string

class Deflection:
    """One the various beam deflection cases.
    Each has slightly different inputs and displays.

    There's a common overall structure, however,
    reflected in this superclass.

    :data solver: An instance of :class:`hamcalc.construction.beamdefl.Deflection`
    """
    variables = [
        ('W', 'Load (in pounds)'),
        ('I', 'Moment of Inertia (in inches^4)'),
        ('L', 'Length of beam (in inches)'),
        ('D', 'Deflection (in inches)'),
    ]
    solver = None # Some Beam Deflection case
    def __init__( self ):
        self.args = AttrDict()
    def set_material( self, material ):
        """Set the material modulus of elasticity.

        :param material: Instance of hamcalc.construction.beamdefl.Material
        """
        self.material= material
        self.args.E= self.material.E
    def set_cross_section( self, AR, I ):
        """Set a beam cross-section for estimating material weight.

        :param AR: Cross-section area; units in^2.
        :param I: Moment of Inertia; units inches^4
        """
        self.args.AR= AR
        self.args.I= I
    def input( self ):
        """Gather missing input values.
        Uses :data:`variables` for the list of variables to gather.
        """
        for var, prompt in self.variables:
            if var not in self.args:
                self.args[var] = input_float( "ENTER {0:.<32s}? ".format(prompt) )

    def display( self ):
        """Display the results of the calculation."""
        try:
            self.args= self.solver( **self.args )
        except NoSolutionError as e:
            print( e )
            return

        if 'AR' in self.args and 'L' in self.args:
            self.args.wt= self.material.PCI * self.args.L * self.args.AR

        self.args.pos= self.solver.positions

        print()
        print( self.solver.__class__.__doc__ )
        print( self.material.name, "beam of any cross-section" )

        text= self.render_template()
        print( text )
    def render_template( self ):
        """Build the template and then render using the current
        values of self.args.

        ..  todo:: Redesign this.

            The number of **if** statements used
            to render the output is unconscionable.

        :returns: text to display.
        """
        t= """\
Modulus of Elasticity .....................E = {E:14,.1f}   PSI
Moment of Inertia .........................I = {I:16,.3f} in^4
Length of beam ............................L = {L:16,.3f} in.
Load ......................................W = {W:14,.1f}   lbs.
"""
        if "wt" in self.args:
            t+= """\
Approximate weight of beam.................. = {wt:14,.1f}  lbs.
"""

        if "A" in self.args:
            t+= """\
Distance - load to nearest end of beam.....A = {A:16,.3f} in.
"""
        if "B" in self.args:
            t += """\
Distance - load to farthest end of beam....B = {B:16,.3f} in.
"""

        if "AA" in self.args:
            t += """\
Distance - load to fixed end of beam......AA = {AA:16,.3f} in.
"""

        if "BB" in self.args:
            t += """\
Distance - load to free end of beam.......BB = {BB:16,.3f} in.
"""

        t += """\
Deflection at {pos[0]:.<6s}.......................D = {D:16,.3f} in.
"""

        if "D1" in self.args:
            t += """\
Deflection at {pos[1]:.<6s}......................D1 = {D1:16,.3f} in.
"""

        t += """\
Maximum safe deflection ...................... {MD:16,.3f} in.
"""

        try:
            text= t.format(**self.args)
            return text
        except KeyError as e:
            print( "Missing Key:", e )
            print( self.args )
            return ""

class Deflection_1( Deflection ):
    """Supported both ends, uniform load"""
    solver= beamdefl.Case_1()

class Deflection_2( Deflection ):
    """Supported both ends, load at centre"""
    solver= beamdefl.Case_2()

class Deflection_3( Deflection ):
    """Supported both ends, load at any point"""
    variables= Deflection.variables[:-1] + [
        ('A', 'Load distance from nearest end' ),
    ] + Deflection.variables[-1:]
    solver= beamdefl.Case_3()

class Deflection_4( Deflection ):
    """Supported both ends, two symmetrical loads"""
    variables= Deflection.variables[:-1] + [
        ('A', 'Load distance from nearest end' ),
    ] + Deflection.variables[-1:]
    solver= beamdefl.Case_4()

class Deflection_10( Deflection ):
    """Fixed one end, uniform load (cantilever)"""
    solver= beamdefl.Case_10()

class Deflection_11( Deflection ):
    """Fixed one end, load at other (cantilever)"""
    solver= beamdefl.Case_11()

class Deflection_12( Deflection ):
    """Fixed one end, intermediate load (cantilever)"""
    variables= Deflection.variables[:-1] + [
        ('A', 'Load distance from fixed end' ),
    ] + Deflection.variables[-1:]
    solver= beamdefl.Case_12()

class Deflection_18( Deflection ):
    """Fixed both ends, uniform load"""
    solver= beamdefl.Case_18()

class Deflection_19( Deflection ):
    """Fixed both ends, load at centre"""
    solver= beamdefl.Case_19()

class Deflection_20( Deflection ):
    """Fixed both ends, load at any point"""
    variables= Deflection.variables[:-1] + [
        ('AA', 'Load distance from nearest end' ),
    ] + Deflection.variables[-1:]
    solver= beamdefl.Case_20()

def pick_material():
    """Pick the material to get the modulus of elasticity. and weight.

    :returns: hamcalc.construction.beamdefl.Material instance
    """
    menu= string.ascii_lowercase[:len(beamdefl.material)+1]
    print( "Select Modulus of Elasticity by pressing letter in < >:" )
    for i, m in enumerate( beamdefl.material ):
        print( " <", menu[i], ">", m )
    print( " <", menu[-1], ">", "OTHER" )
    print( " <", "z", ">", "to EXIT" )
    position= -1
    while position == -1:
        z= input( "ENTER material? " ).lower()
        if z == 'z': return
        position= menu.find(z)
    if position == len(beamdefl.material):
        name= input_str( "Name" )
        e= input_float( "Elasticity" )
        material= beamdefl.Material( name, e, 0 )
    else:
        name= list(beamdefl.material.keys())[position]
        material= beamdefl.material[name]
    print( "Modulus of Elasticity = ", material.E, "PSI for", material.name )
    return material

def pick_beam_model():
    """Pick a specific beam model from the available list."""
    print( " Press letter in ( ) to define beam:" )
    model_list = [
        ('a', Deflection_1(), ),
        ('b', Deflection_2(), ),
        ('c', Deflection_3(), ),
        ('d', Deflection_4(), ),
        (' ', ' ', ),
        ('k', Deflection_10(), ),
        ('l', Deflection_11(), ),
        ('m', Deflection_12(), ),
        (' ', ' ', ),
        ('r', Deflection_18(), ),
        ('s', Deflection_19(), ),
        ('t', Deflection_20(), ),
    ]
    for label, model in model_list:
        if model == ' ':
            print()
            continue
        elif model is None:
            print( ' (', label, ') ', "EXIT" )
        print( ' (', label, ') ', model.__class__.__doc__ )
    models= []
    while len(models) != 1:
        z= input( "ENTER beam? " ).lower()
        if z == ' ': continue
        models= [ model for label, model in model_list if label == z ]
    return models[0]

def run( ar=None, i=None ):

    print( beamdefl.intro() )

    z= '0'
    while z == '0':
        print()
        material= pick_material()
        if material is None: break
        print( " ENTER < 1 > to continue or < 0 > to re-do" )
        z= input( "CHOICE? " )
        if z == '0': continue
        elif z == '1':
            model = pick_beam_model()
            if ar is not None:
                model.set_cross_section( ar, i )
            model.set_material( material )
            model.input()
            model.display()

if __name__ == "__main__":
    run()
