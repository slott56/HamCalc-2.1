"""hamcalc.construction.stairs.obj

Class definitions to implement stairs design.

Note that these calculations only work in inches.
The units, therefore, must all be converted from
input to INCH and from INCH to desired output.

The **Designers** involve a **Chain of Command** processing
sequence where a stairwell designer may fall back to another
designer.
"""
__version__ = "2.1"

import math
from hamcalc.lib import AttrDict
from collections import Callable

class Designer( Callable ):
    """The superclass for all designers."""
    def __call__( self, **args ):
        """Create a design or use the fallback."""
        self.args = AttrDict( args )
        if self.condition():
            return self.design()
        else:
            return self.fallback( **args )

    def condition( self ):
        """A filter condition: can we provide a design?"""
        return True
    def design( self ):
        """Create the complete design, returning a :class:`AttrDict`
        with all the parameters.
        """
        pass

    def _stringer( self, R, T, P ):
        """Compute the stringer details for a given design.

        :param R: rise
        :param T: run
        :param P: number of rungs, steps, ramps or treads
        :returns: X and Y
        """
        X = math.sqrt( R**2 + T** 2 )
        Y = X*P
        return X, Y

class Unrestricted_Risers( Designer ):
    """A Designer for Unrestricted Risers; L must be None."""
    def __init__( self ):
        super().__init__()
        self.fallback= Vertical_Ladder()
    def condition( self ):
        return 'L' not in self.args or self.args.L is None
    def design( self ):
        H, R = self.args.H, self.args.R
        N = int( H/R + .5 )
        P = int(N-1)
        R = H/N
        while R < 5 and N-1 != 0:
            N -= 1
            P = int(N-1)
            R = H/N
        T = 20-4*R/3
        L = P*T
        A = math.degrees( math.atan2(R,T) )
        if 17.35 <= A < 33:
            T = 25 + (33-A)/15.65 - 2*R
        X, Y = self._stringer( R, T, P )
        return AttrDict(locals())

class Vertical_Ladder( Designer ):
    """A Designer for Vertical Ladders; L must be zero."""
    def __init__( self ):
        super().__init__()
        self.fallback= Restricted_Risers()
    def condition( self ):
        return self.args.L == 0
    def design( self ):
        H = self.args.H
        P = int( H/13.5 + .5 )
        N = int(P - 1)
        TBR = (H-13.5*N)/2
        A = 90
        R = 0
        R = 13.5
        X = 0
        Y = 0
        L = 0
        return AttrDict(locals())

class Restricted_Risers( Designer ):
    """A Designer for Restricted Risers; L and H define the structure."""
    def __init__( self ):
        super().__init__()
        self.fallback= Step_Ramp()
    def condition( self ):
        if self.args.L is None: return
        A = math.degrees( math.atan2( self.args.H, self.args.L ) )
        return A > 20.45
    def design( self ):
        H, L = self.args.H, self.args.L
        A = math.degrees( math.atan2( H, L ) )
        N = int(H // 5+1)
        R = H/N
        T = 20 - 4*R/3
        while T*N-T <= L and R >= 5:
            N += 1
            R = H / N
            T = 20 - 4*R/3
        N -= 1
        P = int(N-1)
        try:
            R = H/N
        except ZeroDivisionError as e:
            return vertical_ladder(H,L)
        T = 20 - 4*R/3
        if R > 13.5 or T <= 0:
            return vertical_ladder(H,L)
        X, Y = self._stringer( R, T, P )
        return AttrDict(locals())

class Step_Ramp( Designer ):
    """A Designer for Step Ramps; L and H define the structure."""
    def __init__( self ):
        super().__init__()
        self.fallback= Inclined_Ramp()
    def condition( self ):
        if self.args.L is None: return
        N = int(self.args.H // 5)
        return N > 1
    def design( self ):
        H, L = self.args.H, self.args.L
        A = math.degrees( math.atan2( H, L ) )
        N = int(H // 5)
        P = int(N - 1)
        R = H / N
        T = L / P
        X, Y = self._stringer( R, T, P )
        return AttrDict(locals())

class Inclined_Ramp( Designer ):
    """A Designer for Inclined Ramps; L and H define the structure."""
    def design( self ):
        H, L = self.args.H, self.args.L
        A = math.degrees( math.atan2( H, L ) )
        N = int(H // 5)
        P = R = T = 0
        X, Y = self._stringer( R, T, P )
        return AttrDict(locals())

def stair_design( H, L=None, R=None ):
    """A convenience function to provide the same API as
    the function implementation.

    This creates an instance of :class:`Unrestricted_Risers`
    and uses that to start the design process.
    This may fallback to any of the other designers.
    """
    designer= Unrestricted_Risers()
    return designer( H=H, L=L, R=R )
