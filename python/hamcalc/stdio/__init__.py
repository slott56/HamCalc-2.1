"""HamCalc STDIO Applications.

Plus some utility functions to emulate some of the GW-basic quirks.
"""
__version__ = "2.1"

def input_convert( prompt='', convert=str ):
    """Distinguish between kinds of input.

    1.  Valid value of the given type (int, float, str, etc.)
    2.  No input -- simply hitting enter -- a ``None`` is returned.
        An exception is **not** raised, because this is
        legitimate user behavior that is handled politely
        by :class:`hamcalc.lib.AttrDict`.

    Invalid values (i.e., :exc:`ValueError` from
    the conversion function) are handled here by
    reprompting for the input.

    Other exceptions (e.g., :exc:`EOFError`) are left as proper
    exceptions.

    The objective here is to emulate **aspects** of quirky
    GW-Basic behavior. But not **all** of the quirks.
    Legacy programs often "0" input ambiguously.
    It could be the result of "no input" or it could be an input
    value of 0. In a few cases, special 1E-6 values
    were used to be "effectively zero" to distinguish
    no input from an actual zero.

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

def input_list_int( prompt='', count=2 ):
    """Input a comma-separated list of integer values.
    """
    values= []
    while len(values) != count:
        values= input_convert( prompt,
            lambda txt: list( map( int, txt.split(',') ) ) )
    return values

def input_list_float( prompt='', count=2 ):
    """Input a comma-separated list of float values.
    """
    values= []
    while len(values) != count:
        values= input_convert( prompt,
        lambda txt: list( map( float, txt.split(',') ) ) )
    return values
