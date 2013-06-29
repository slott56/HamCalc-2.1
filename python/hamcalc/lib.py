"""Library of common HamCalc features.

-   Attribute Dictionary to support the **Solver** design. This is an extended
    implementation of :class:`dict` that supports attribute references,
    and requires all keys be proper Python variable names.

-   Units and Unit Conversions.

-   Utility functions for degree and radian conversions.

"""
__version__ = "2.1"

from collections import namedtuple
from collections import Callable
import math

class Unit:
    """Generic definition of a unit.
    This unit is not the "standard" used for conversions.
    This is converted to a standard or a standard is converted to this.

    ::

        class X( Unit ):
            '''X full name'''
            name= "x" # Abbreviation
            factor= 123.45

    Create a standard value from input in units of X.

    ::

        m_std= X.to_std( value )

    Convert a standard value into units of X.

    ::

        m_x= X.from_std( m_std )

    Note that for Temperature, a simple "factor" isn't appropriate and the
    :meth:`to_std` and :meth:`from_std` need to be overridden.

    For all subclasses, the long version of the unit's name should
    be the docstring.
    """
    factor= 1.0
    standard= None # Reference to the StandardUnit
    name= "" # Abbreviation of the unit's name.
    @classmethod
    def to_std( class_, value ):
        if value is None: return None
        return value/class_.factor
    @classmethod
    def from_std( class_, value ):
        if value is None: return None
        return value*class_.factor

class UnitMeta(type):
    """Metaclass for Standard_Unit's to insert a circular reference.
    That way ``SomeStandardUnit.standard is SomeStandardUnit``.
    """
    def __new__(mcs, name, bases, dict):
        new_class= type.__new__(mcs, name, bases, dict)
        new_class.standard = new_class
        return new_class

class Standard_Unit( Unit, metaclass=UnitMeta ):
    """The standard unit used for conversions.
    Other units will convert to this.
    This will convert to other units.

    This is still a unit, but a conversion factor is not used.

    For all subclasses, the long version of the unit's name should
    be the docstring.
    """
    name= "" # Abbreviation of the unit's name
    @classmethod
    def to_std( class_, value ):
        return value
    @classmethod
    def from_std( class_, value ):
        return value

def convert( value, unit, *to ):
    """Convert a value from one set of units to another.

    :param value: A value, measured in the source unit.
    :param unit: A subclass of :class:`Unit` describing value.
    :param to: Subclasses of :class:`Unit`. If only a single
        unit is supplied, then a single value is returned;
        If multiple units are supplied, a tuple of values
        is returned.
    :return: value converted to the defined units.
    """
    std_value= unit.to_std( value )
    if len(to) == 1:
        converted= to[0].from_std( std_value )
    else:
        converted= tuple( u.from_std(std_value) for u in to )
    return converted

class AttrDict( dict ):
    """Mixin attribute access to a dictionary.

    We use this to "wrap" an argument dictionay and make access
    slightly more pleasant.

    This class requires each keys be a valid Python variable name.
    This is trivially met when this is initialized
    with the ``**args`` of a function.

    Also, this class won't set a value to ``None``. Setting
    a key's value to ``None`` is the same as deleting it from
    the collection of arguments.  This allows the variable
    to work politely with :func:`hamcalc.stdio.input_convert`.

    Typical use

    ::

        def function( **args ):
            args= AttrDict( args )
            if 'd' not in args and 'r' in args and 't' in args:
                args.d = args.r * args.t
            return args

    Examples:

    >>> from hamcalc.lib import AttrDict
    >>> args= dict( arg1=3, arg2=5 )
    >>> args= AttrDict( args )
    >>> 'arg1' in args
    True
    >>> args.arg1
    3
    >>> 'sum' in args
    False
    >>> args.sum = args.arg1 + args.arg2
    >>> args.sum
    8
    >>> args['sum']
    8
    >>> args.arg1= None
    >>> 'arg1' in args
    False
    >>> args.unused= None
    >>> 'usused' in args
    False

    >>> a2= AttrDict( dict( a=7, b=None, c=11 ) )
    >>> 'a' in a2
    True
    >>> 'b' in a2
    False

    """
    def __init__( self, *args, **kw ):
        super().__init__()
        if len(args) == 1:
            adict= args[0]
            for k in adict:
                if adict[k] is not None:
                    self[k]= adict[k]
        for k in kw:
            if kw[k] is not None:
                self[k]= kw[k]
    def __getattr__( self, name ):
        return self.get(name,None)
    def __setattr__( self, name, value ):
        if value is None:
            try:
                del self[name]
            except KeyError as e:
                pass # Never existed, that's okay.
        else:
            self[name]= value

class NoSolutionError( Exception ):
    """A :class:`Solver` could not find a proper solution."""
    pass

class Solver( Callable ):
    """An abstract **Solver** which accepts a cluster
    of keywords and returns a dictionary.

    This allows a **Solver** to be configured
    with parameters or options. For example,
    units can be configured into a solver, allowing
    one solver class to have two instances
    which handle metric and imperical units.

    A subclass must override the :meth:`solve`
    method.
    """
    def __call__( self, **kw ):
        self.args= AttrDict( kw )
        result= self.solve( self.args )
        if result: return result
        else: return self.args
    def args_contains( self, *names ):
        return all( n in self.args for n in names )
    def solve( self, args ):
        """Override this method to accept an AttrDict
        of arguments and return a revised AttrDict
        with additional values.

        :param args: AttrDict with argument values.
        :returns: AttrDict with revised values.
        """
        raise NotImplementedError
