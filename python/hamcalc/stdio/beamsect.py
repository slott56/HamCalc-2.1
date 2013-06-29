"""Beam Section

"BEAMS",", properties of","","MECHMENU"
"PROPERTIES OF BEAMS","","","MECHMENU"
"""
import hamcalc.construction.beamsect as beamsect
import hamcalc.stdio.beamdefl as beamdefl
from hamcalc.lib import AttrDict, NoSolutionError
from hamcalc.stdio import *
import string

class Section:
    """One the various beam section cases.
    Each has slightly different inputs and displays.

    There's a common overall structure, however,
    reflected in this superclass.

    :data solver: An instance of :class:`hamcalc.construction.beamsect.Section`
    :data variables: A list of 2-tuples with variable namd and prompt.
    """
    variables= [
        ('B', 'Width of base of section' ),
        ('D', 'Height of section' ),
    ]
    solver = None # Some Beam Section
    def __init__( self ):
        self.args = AttrDict()
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

        print()
        print( self.solver.__class__.__doc__ )

        text= self.render_template()
        print( text )
        print()
        d= None
        while d not in ('y','n'):
            d= input( "Do you want to determine deflection of this beam under load? (y/n)? " ).lower()
        if d == 'y':
            beamdefl.run( ar=self.args.A, i=self.args.I )

    def render_template( self ):
        """Build the template and then render using the current
        values of self.args.

        :returns: text to display.
        """

        t= ''
        for var, prompt in self.variables:
            t += "      {1:.<38s}{0:s}= {2:10.3f} in.\n".format(
                var, prompt, self.args[var] )
        t += """\
      Cross section area of section......... {A:10.3f} in²
      Moment of Inertia....(in inches^4).... {I:10.3f}
      Section Modulus......(in inches^3).... {Z:10.3f}
      Radius of Gyration.................... {K:10.3f} in.
"""

        try:
            text= t.format(**self.args)
            return text
        except KeyError as e:
            print( "Missing Key:", e )
            print( self.args )
            return ""

class Section_1( Section ):
    """Solid Rectangular Beam"""
    variables= [
        ('B', 'Width of base of section' ),
        ('D', 'Height of section' ),
    ]
    solver= beamsect.Beam_1()

class Section_2( Section ):
    """Solid Triangular Beam (flat bottom)"""
    variables= [
        ('B', 'Width of base of section' ),
        ('D', 'Height of section' ),
    ]
    solver= beamsect.Beam_2()

class Section_3( Section ):
    """Hollow Rectangular Box Beam"""
    variables= [
        ('B', 'Width of base of section' ),
        ('D', 'Height of section' ),
        ('T_1', 'Thickness of sidewalls' ),
        ('T_2', 'Thickness of top & bottom walls' ),
    ]
    solver= beamsect.Beam_3()

class Section_4( Section ):
    """Solid Cylindrical Beam"""
    variables= [
        ('D', 'Diameter of section' ),
    ]
    solver= beamsect.Beam_4()

class Section_5( Section ):
    """Hollow Tubular Beam"""
    variables= [
        ('D', 'Outside diameter of section' ),
        ('D_1', 'Inside diameter of section' ),
    ]
    solver= beamsect.Beam_5()

class Section_6( Section ):
    """I-Section Built-Up Beam"""
    variables= [
        ('B', 'Width of top & bottom flanges' ),
        ('D', 'Height of section' ),
        ('S', 'Thickness of top & bottom flanges' ),
        ('T', 'Thickness of vertical web' ),
    ]
    solver= beamsect.Beam_6()

class Section_7( Section ):
    """H-Section Built-Up Beam"""
    variables= [
        ('B', 'Width across outside of vertical legs' ),
        ('D', 'Height of vertical legs' ),
        ('S', 'Thickness of vertical legs' ),
        ('T', 'Thickness of horizontal web' ),
    ]
    solver= beamsect.Beam_7()

class Section_8( Section ):
    """[-Section Built-Up Beam"""
    variables= [
        ('B', 'Width of horizontal legs' ),
        ('D', 'Vertical height of section' ),
        ('S', 'Thickness of horizontal legs' ),
        ('T', 'Thickness of vertical web' ),
    ]
    solver= beamsect.Beam_8()

class Section_9( Section ):
    """U-Section Built-Up Beam"""
    variables= [
        ('B', 'Width of base of section' ),
        ('D', 'Height of section' ),
        ('S', 'Thickness of base web' ),
        ('T', 'Thickness of vertical legs' ),
    ]
    solver= beamsect.Beam_9()

class Section_10( Section ):
    """T-Section Built-Up Beam"""
    variables= [
        ('B', 'Width of horizontal flange' ),
        ('D', 'Height of section' ),
        ('S', 'Thickness of horizontal flange' ),
        ('T', 'Thickness of vertical web' ),
    ]
    solver= beamsect.Beam_10()

def pick_beam_model():
    """Pick a specific beam model from the available list."""
    print( " Press letter in ( ) to define beam:" )
    model_list = [
        ('a', Section_1(), ),
        ('b', Section_2(), ),
        ('c', Section_3(), ),
        ('d', Section_4(), ),
        ('e', Section_5(), ),
        ('f', Section_6(), ),
        ('g', Section_7(), ),
        ('h', Section_8(), ),
        ('i', Section_9(), ),
        ('j', Section_10(), ),
        ('k', None ),
    ]
    for label, model in model_list:
        if model is None:
            print( ' (', label, ') ', 'EXIT' )
        else:
            print( ' (', label, ') ', model.__class__.__doc__ )
    models= []
    while len(models) != 1:
        z= input( "ENTER beam? " ).lower()
        models= [ model for label, model in model_list if label == z ]
    return models[0]

def run():
    print( beamsect.intro() )

    z= '0'
    while z == '0':
        print()
        model = pick_beam_model()
        if model is None: break
        model.input()
        model.display()

if __name__ == "__main__":
    run()
