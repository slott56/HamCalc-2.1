"""Beam Deflection

"BEAMS",", properties of","","MECHMENU"
"PROPERTIES OF BEAMS","","","MECHMENU"
"""
import hamcalc.construction.beamdefl as beamdefl
from hamcalc.lib import AttrDict, NoSolutionError
import string

class Beam:
    """One the various beam deflection cases.
    Each has slightly different inputs and displays.

    There's a common overall structure, however,
    reflected in this superclass.
    """
    def __init__( self ):
        self.args = AttrDict()
    def set_material( self, material ):
        """Set the material modulus of elasticity.

        :param material: Instance of hamcalc.construction.beamdefl.Material
        """
        self.material= material
        self.args.E= self.material.E
    def set_cross_section( self, AR ):
        """Set a beam cross-section for estimating material weight.

        :param AR: Cross-section area; units in^2.
        """
        self.args.AR= AR
    def input( self ):
        """Gather input values.
        This will invoke :meth:`input_additional` to gather additional
        values for beam models with additional inputs.
        """
        print( "ENTER known values, leave unknown value blank." )
        try:
            w_raw= input( "ENTER: Load (in pounds).....................W = ? " )
            if w_raw: self.args.W= float(w_raw)

            i_raw= input( "ENTER: Moment of Inertia (in inches^4)......I = ? " )
            if i_raw: self.args.I= float(i_raw)

            l_raw= input( "ENTER: Length of beam (in inches)...........L = ? " )
            if l_raw: self.args.L= float(l_raw)

            self.input_additional()

            d_raw= input( "ENTER: Deflection (in inches)...............D = ? " )
            if d_raw: self.args.D= float(d_raw)
        except ValueError as e:
            print( e )
            raise
    def input_additional( self ):
        """Gather any additional inputs required."""
        pass
    def display( self ):
        """Display the results of the calculation."""
        try:
            self.args= self.solver( **self.args )
        except NoSolutionError as e:
            print( e )
            return

        if 'AR' in self.args and 'L' in self.args:
            self.args.wt= material.PCI * args.L * args.AR

        self.args.pos= self.solver.positions

        print()
        print( self.solver.__class__.__doc__ )
        print( self.material.name, "beam of any cross-section" )

        text= self.render_template()
        print( text )
    def render_template( self ):
        """Build the template and then render using the current
        values of self.args.

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

class Beam_1( Beam ):
    """Supported both ends, uniform load"""
    solver= beamdefl.Case_1()

class Beam_2( Beam ):
    """Supported both ends, load at centre"""
    solver= beamdefl.Case_2()

class Beam_3( Beam ):
    """Supported both ends, load at any point"""
    solver= beamdefl.Case_3()
    def input_additional( self ):
        a_raw= input( "ENTER: Load distance from nearest end.......A = ? " )
        if a_raw: self.args.A= float(a_raw)

class Beam_4( Beam ):
    """Supported both ends, two symmetrical loads"""
    solver= beamdefl.Case_4()
    def input_additional( self ):
        a_raw= input( "ENTER: Load distance from nearest end.......A = ? " )
        if a_raw: self.args.A= float(a_raw)

class Beam_10( Beam ):
    """Fixed one end, uniform load (cantilever)"""
    solver= beamdefl.Case_10()

class Beam_11( Beam ):
    """Fixed one end, load at other (cantilever)"""
    solver= beamdefl.Case_11()

class Beam_12( Beam ):
    """Fixed one end, intermediate load (cantilever)"""
    solver= beamdefl.Case_12()
    def input_additional( self ):
        a_raw= input( "ENTER: Load distance from fixed end........AA = ? " )
        if a_raw: self.args.AA= float(a_raw)

class Beam_18( Beam ):
    """Fixed both ends, uniform load"""
    solver= beamdefl.Case_18()

class Beam_19( Beam ):
    """Fixed both ends, load at centre"""
    solver= beamdefl.Case_19()

class Beam_20( Beam ):
    """Fixed both ends, load at any point"""
    solver= beamdefl.Case_20()
    def input_additional( self ):
        a_raw= input( "ENTER: Load distance from nearest end.......A = ? " )
        if a_raw: self.args.AA= float(a_raw)

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
        name= input( "Name" )
        e= float( input( "Elasticity" ) )
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
        ('a', Beam_1(), ),
        ('b', Beam_2(), ),
        ('c', Beam_3(), ),
        ('d', Beam_4(), ),
        (' ', None, ),
        ('k', Beam_10(), ),
        ('l', Beam_11(), ),
        ('m', Beam_12(), ),
        (' ', None, ),
        ('r', Beam_18(), ),
        ('s', Beam_19(), ),
        ('t', Beam_20(), ),
    ]
    for label, model in model_list:
        if model is None:
            print()
            continue
        print( ' (', label, ') ', model.__class__.__doc__ )
    models= []
    while len(models) != 1:
        z= input( "ENTER beam? " ).lower()
        models= [ model for label, model in model_list if label == z ]
    return models[0]

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
        model.set_material( material )
        model.input()
        model.display()
