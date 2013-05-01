"""hamcalc.electronics.decibel -- Decibel Calculator

These are three **Solvers** for decibel problems in power, voltage or current.

Here are some test cases:

>>> import hamcalc.electronics.decibel as decibel
>>> decibel.voltage( f_1=13.2, f_2=12 )
{'db': -0.8278537031645, 'f_1': 13.2, 'f_2': 12}
>>> decibel.current( f_1=2.3, db=2 )
{'db': 2, 'f_1': 2.3, 'f_2': 2.8955284471265843}
>>> decibel.power( f_2=800, db=5 )
{'db': 5, 'f_1': 252.98221281347034, 'f_2': 800}
>>> decibel.WATT.dBm( decibel.MILLIWATT.to_std(900) )
29.542689153465723
>>> decibel.VOLT.dBm(decibel.VOLT.to_std(12.36))
34.85093343076822
>>> decibel.AMP.dBm(decibel.AMP.to_std(2.3))
54.22452082278453

"""
__version__ = "2.1"

from hamcalc.lib import AttrDict, Standard_Unit, Unit
from collections import Callable
import math

introduction = """\
 DECIBEL CALCULATOR                                      by George Murphy VE3ERP
"""

class Error( Exception ):
    pass

def intro():
    """Returns the text from the introductory page."""
    return introduction

class VOLT( Standard_Unit ):
    """Volt"""
    name= "V"
    @staticmethod
    def dBm( value ):
        return 20*math.log10( value/0.2236 )

class MILLIVOLT( Unit ):
    """Millivolt"""
    standard= VOLT
    name= "mV"
    factor= 1000

class MICROVOLT( Unit ):
    """Microvolt"""
    standard= VOLT
    name= "µV"
    factor= 1000000

class AMP( Standard_Unit ):
    """Ampere"""
    name= "A"
    @staticmethod
    def dBm( value ):
        return 20*math.log10( 50*value/0.2236 )

class MILLIAMP( Unit ):
    """Milliampere"""
    standard= AMP
    name= "mA"
    factor= 1000

class MICROAMP( Unit ):
    """Microampere"""
    standard= AMP
    name= "µA"
    factor= 1000000

class WATT( Standard_Unit ):
    """Watt"""
    name= "W"
    @staticmethod
    def dBm( value ):
        return 20*math.log10( math.sqrt(50*value)/0.2236 )

class MILLIWATT( Unit ):
    """Milliwatt"""
    standard= WATT
    name= "mW"
    factor= 1000

class MICROWATT( Unit ):
    """Microwatt"""
    standard= WATT
    name= "µW"
    factor= 1000000

class DB_Solver( Callable ):
    """Superclass for all dB solvers. This handles the generic
    case.

    This is a callable object, an instance is created and used
    as follows::

        >>> voltage= DB_Solver( M=20 )
        >>> voltage( f_1= 13.2, f_2= 12 )
        {'db': -0.8278537031645, 'f_1': 13.2, 'f_2': 12}

    Similar solvers can be built for Power or Current.
    """
    def __init__( self, M=10 ):
        """Initialize this solver with the "M" factor, 10 or 20."""
        self.M= M
    def __call__( self, **kw ):
        """Solve decibel problems.

        :param f_1: source measurement
        :param f_2: load measurement
        :param db: db of difference
        :returns: Dictionary with all three values.
        """
        args= AttrDict( kw )
        if 'f_1' in args and 'f_2' in args:
            args.db = self.M*math.log10(args.f_2/args.f_1)
        elif 'f_1' in args and 'db' in args:
            args.f_2 = args.f_1 * 10**( args.db/self.M )
        elif 'f_2' in args and 'db' in args:
            args.f_1 = args.f_2 * 10**( -args.db/self.M )
        return args

power= DB_Solver()
voltage= DB_Solver( M=20 )
current= DB_Solver( M=20 )
