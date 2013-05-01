"""hamcalc.math.accelr -- Acceleration Calculator

These are two **Solvers** for acceleration and force problems.

Here are some test cases

>>> from hamcalc.math.accelr import force, accel
>>> accelr.force( m=12000, a=-2.5 )
{'a': -2.5, 'm': 12000, 'f': -30000.0}
>>> accelr.force( m=12000, f=30000 )
{'a': 2.5, 'm': 12000, 'f': 30000}
>>> accel( d=50, t=6, v_o=2, a=-.25 )
{'a': -0.25, 'v_f': 0.5, 'v_o': 2, 'd': 50, 't': 6}
"""
__version__ = "2.1"

from hamcalc.lib import AttrDict

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

g = 9.806650161743164 # Newtons/kg, or m/s^2

def force( **kw ):
    """Solve f = m * a problems.

    :param m: mass (kg)
    :param a: acceleration (m/s^2)
    :param f: force in Newtons (kg m/s^s)
    :returns: Dictionary with all three values.
    """
    args= AttrDict( kw )
    if 'm' in args and 'a' in args:
        args.f = args.m * args.a
    elif 'f' in args and 'm' in args:
        args.a = args.f / args.m
    elif 'f' in args and 'a' in args:
        args.m = args.f / args.a
    return args

def accel( **kw ):
    """Solve Acceleration problems.

    Some combination of a, d, t, v_o and v_f must be provided.
    The others will be deduced.

    :param d: Displacement (in m)
    :param t: Time (in seconds)
    :param v_o: Velocity at START
    :param v_f: Velocity at END
    :param a: Acceleration (m/s^2)
    :returns: Dictionary with all values.
    """
    args= AttrDict( kw )
    # 370 IF VO*VF*T THEN A=(VF-VO)/T
    if 'a' not in args and 'v_o' in args and 'v_f' in args and 't' in args:
        args.a = (args.v_f-args.v_o)/args.t
    # 420 IF D=0 AND VO*T*A THEN D=VO*T+0.5!*A*T^2
    elif 'd' not in args and 'v_o' in args and 't' in args and 'a' in args:
        args.d = args.v_o*args.t + 0.5*args.a*args.t**2
    # 430 IF VF=0 AND VO*A*T THEN VF=VO+A*T
    elif 'v_f' not in kw and 'v_o' in kw and 't' in kw and 'a' in kw:
        args.v_f = args.v_o+args.a*args.t
    # 440 IF VO=0 AND VF*A*T THEN V0=VF-A*T
    elif 'v_o' not in kw and 'v_f' in kw and 't' in kw and 'a' in kw:
        args.v_o = args.v_f-args.a*args.t
    elif 't' not in kw and 'd' in kw and 'a' in kw:
        args.t = args.d / args.a
    return args
