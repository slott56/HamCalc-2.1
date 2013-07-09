"""hamcalc.construction.torque

Solve The Velocity-RPM-Diameter problems, as well as
Torque-Force-Horsepower based on Velocity, RPM or Diameter.

This is a single **Solver** for both sets of rules.

..  py:function:: torque( R=None, D=None, T=None, H=None, W=None, V=None )

    Solve torque problems. This an instance of the :class:`Torque` **Solver**.

    :param R: R.P.M.
    :param D: Pitch dia.(gear/sprkt.)
    :param T: Torque (in.lb.)
    :param H: Horsepower
    :param W: Force in lb.(belt/chain tension)
    :param V: Velocity (feet/min.)

    :returns: Dictionary with **all** values computed.

Test Cases:

>>> import hamcalc.construction.torque as torque
>>> t1 = torque.torque( R=1700, H=80, T=1431, D=54 )
>>> round(t1.W,3)
109.848
>>> round(t1.V,3)
24033.184

The velocity, *V*, seems high, but this *is* the correct value.

"""
from hamcalc.lib import Solver, NoSolutionError
import math

def intro():
    return """\
TORQUE & HORSEPOWER                                     by George Murphy VE3ERP
"""

class Torque( Solver ):
    """Solver for Torque problems.
    """
    def solve( self, args ):
        """Solve torque problems.

        :param R: R.P.M.
        :param D: Pitch dia.(gear/sprkt.)
        :param T: Torque (in.lb.)
        :param H: Horsepower
        :param W: Force in lb.(belt/chain tension)
        :param V: Velocity (feet/min.)

        :returns: Dictionary with **all** values computed.
        """
        while not all( ('R' in args, 'D' in args, 'T' in args,
            'H' in args, 'W' in args, 'V' in args ) ):
            # Calculate or break
            if 'V' not in args and 'D' in args and 'R' in args:
                args.V = math.pi/12 * args.D * args.R
            elif 'R' not in args and 'V' in args and 'D' in args:
                args.R = V / (math.pi/12) / D
            elif 'D' not in args and 'V' in args and 'R' in args:
                args.D = V / (math.pi/12) / R

            elif 'T' not in args and 'W' in args and 'D' in args:
                args.T = args.W*args.D/2
            elif 'H' not in args and 'T' in args and 'R' in args:
                args.H = args.T*args.R/63025
            elif 'T' not in args and 'H' in args and 'R' in args:
                args.T = 63025*args.H/args.R
            elif 'R' not in args and 'H' in args and 'T' in args:
                args.T = 63025*args.H/args.T

            elif 'H' not in args and 'W' in args and 'V' in args:
                args.H = args.W*args.V/33000
            elif 'W' not in args and 'H' in args and 'V' in args:
                args.W = 33000*args.H/args.V

            else:
                raise NoSolutionError( "Can't compute", args )
                # break # Nothing more to do.
        return args

torque = Torque()
