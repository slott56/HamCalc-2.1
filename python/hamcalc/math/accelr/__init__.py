"""hamcalc.math.accelr -- Acceleration Calculator

These are two **Solvers** for acceleration and force problems.

Here are some test cases

>>> import hamcalc.math.accelr as accelr
>>> accelr.force( m=12000, a=-2.5 )
{'a': -2.5, 'm': 12000, 'f': -30000.0}
>>> accelr.force( m=12000, f=30000 )
{'a': 2.5, 'm': 12000, 'f': 30000}
>>> a=accelr.accel( d=50, t=6, v_o=2, a=-.25 )
>>> a.a
-0.25
>>> a.v_f
0.5
>>> a.v_o
2
>>> a.d
50
>>> a.t
6

"""
__version__ = "2.1"

from hamcalc.lib import AttrDict, Solver

introduction = """\
 ACCELERATION                                            by George Murphy VE3ERP

 This program calculates force of acceleration using these equations:

 F=MA, where Force = Mass x Acceleration.
 d=vot+½at²
 vf=vo+at
 vf²-vo²=2ad
 where d=displacement, vo=original velocity, vf=final velocity, t=time in
 seconds and 'a' is a constant calculated by the program.

 Force of acceleration is calculated in kilogams and Standard Gravitys (g's).
"""

class Error( Exception ):
    pass

def intro():
    """Returns the text from the introductory page."""
    return introduction

g = 9.80665 # Newtons/kg, or m/s^2

class Force( Solver ):
    """Solver class for :math:`f=m \\times a` problems."""
    def solve( self, args ):
        """Solve :math:`f=m \\times a` problems.

        :param m: mass (e.g., kg)
        :param a: acceleration (e.g., m/s^2)
        :param f: force in Newtons (e.g., kg m/s^s)
        :returns: Dictionary with all three values.
        """
        if 'm' in args and 'a' in args:
            args.f = args.m * args.a
        elif 'f' in args and 'm' in args:
            args.a = args.f / args.m
        elif 'f' in args and 'a' in args:
            args.m = args.f / args.a
        else:
            raise Error( "Insufficient data: {0}".format(args.keys()) )
        return args

force= Force()

class Acceleration( Solver ):
    """Solver class for acceleration problems."""
    def solve( self, args ):
        """Solve Acceleration problems.

        Some combinations of a, d, t, v_o and v_f must be provided.

        -   v_o, v_f and t gives us a
        -   v_o, t and a gives us v_f
        -   v_f, t and a gives us v_o
        -   d and a give us t

        :param d: Displacement (in m)
        :param t: Time (in seconds)
        :param v_o: Velocity at START
        :param v_f: Velocity at END
        :param a: Acceleration (m/s^2)
        :returns: Dictionary with all values.
        """
        # 370 IF VO*VF*T THEN A=(VF-VO)/T
        if 'a' not in args and 'v_o' in args and 'v_f' in args and 't' in args:
            args.a = (args.v_f-args.v_o)/args.t
        # 420 IF D=0 AND VO*T*A THEN D=VO*T+0.5!*A*T^2
        elif 'd' not in args and 'v_o' in args and 't' in args and 'a' in args:
            args.d = args.v_o*args.t + 0.5*args.a*args.t**2
        # 430 IF VF=0 AND VO*A*T THEN VF=VO+A*T
        elif 'v_f' not in args and 'v_o' in args and 't' in args and 'a' in args:
            args.v_f = args.v_o+args.a*args.t
        # 440 IF VO=0 AND VF*A*T THEN V0=VF-A*T
        elif 'v_o' not in args and 'v_f' in args and 't' in args and 'a' in args:
            args.v_o = args.v_f-args.a*args.t
        elif 't' not in args and 'd' in args and 'a' in args:
            args.t = args.d / args.a
        else:
            raise Error( "Insufficient data: {0}".format(args.keys()) )
        return args

accel= Acceleration()
