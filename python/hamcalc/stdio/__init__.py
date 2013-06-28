"""HamCalc STDIO Applications.

Plus some utility functions to emulate some of the GW-basic quirks.
"""
__version__ = "2.1"

def input_convert( prompt='', convert=str ):
    """Distinguish between kinds of input.

    1. Valid value of the given type (int, float, str, etc.)
    2. No input; a ``None`` is returned.

    Other exceptions (e.g., EOF) are left as proper
    exceptions.

    The objective is to emulate elements of quirky
    GW-Basic behavior. But not **all** of the quirks.
    The legacy programs treated "0" ambiguously.
    It could be "no input" or it could be an input
    value of 0. In a few cases, special 1E-6 values
    were used to be "effectively zero".

    :param prompt: the prompt string
    :param convert: the conversion function to apply
    """
    value= None
    while value is None:
        raw= input( prompt )
        if raw:
            try:
                value= convert( raw )
            except ValueError as e:
                print( e )
        else:
            return
    return value

def input_int( prompt='' ):
    """Input an integer value.
    """
    return input_convert( prompt, int )

def input_float( prompt='' ):
    """Input a floating-point value.
    """
    return input_convert( prompt, float )

def input_list_int( prompt='' ):
    """Input a comma-separated list of integer values.
    """
    return input_convert( prompt,
        lambda txt: list( map( int, txt.split(',') ) ) )

def input_list_float( prompt='' ):
    """Input a comma-separated list of float values.
    """
    return input_convert( prompt,
        lambda txt: list( map( float, txt.split(',') ) ) )
