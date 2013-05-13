"""Library of common HamCalc features.

-   Attribute Dictionary to support the **Solver** design. This is an extended
    implementation of :class:`dict` that supports attribute references,
    and requires all keys be proper Python variable names.

-   Units and Unit Conversions.

-   Utility functions for degree and radian conversions.

"""
from collections import namedtuple
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
        return value/class_.factor
    @classmethod
    def from_std( class_, value ):
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

    We can use this to "wrap" an argument dictionay and make access slightly more pleasant.

    The requirement that the keys be valid Python variable names is
    trivially met when this is used for ``**args`` in a function.

    ::

        def function( **args ):
            args= AttrDict( args )
            if args.d is None and args.r is not None and args.t is not None:
                args.d = args.r * args.t
            return args

    Or

    ::

        def function( **args ):
            args= AttrDict( args )
            if 'd' not in args and 'r' in args and 't' in args:
                args.d = args.r * args.t
            return args

    """
    def __getattr__( self, name ):
        return self.get(name,None)
    def __setattr__( self, name, value ):
        self[name]= value
