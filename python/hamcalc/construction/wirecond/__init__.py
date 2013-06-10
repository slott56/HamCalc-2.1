"""hamcalc.constructure.wirecond

Wires in a Conduit.

This is a **Solver** oriented around the rather
complex packing of circles into a circular space.

..  py:function:: conduit( ID=None, OD=None, NW=None )

    Solver for conduit problems.
    This an instance of the :class:`Conduit` **Solver**.

    :param ID: Conduit inside diameter
    :param OD: Wire outside diameter
    :param NW: Number of wires.
    :returns: Dictionary with all three values.

..  note:: Complex

    This seems rather complex.
    Perhaps there's a simplification.

Test Cases:

>>> import hamcalc.construction.wirecond as wirecond
>>> b1= wirecond.conduit( ID=.75, OD=.0625 )
>>> round(b1.NW,3)
100.92
>>> b2= wirecond.conduit( NW=101, OD=.0625 )
>>> round(b2.ID,3)
0.694
>>> b3= wirecond.conduit( NW=100, ID=.75 )
>>> round(b3.OD,3)
0.067

"""
from hamcalc.lib import Solver, NoSolutionError

import math

class Geometry:
    """A superclass for the four wire-packing geometries."""
    def __init__( self, n ):
        pass
    def nw( self ):
        """Number of wires for parameter.

        :param n: parameter >= 0
        """
        pass
    def id( self, od ):
        """The diameter of a bundle.

        :param od: diameter of one wire.
        """
        pass
    def od( self, id ):
        """Largest wire size that will fill the conduit.

        :param id: diameter of the conduit.
        """
        pass
    def id_opt( self, od ):
        """An optimized bundle diameter.

        :param od: diameter of one wire.
        """
        WD= self.id( od )
        ID= 2*math.sqrt(((WD/2)**2)*1.02)
        return ID

class Geometry_1( Geometry ):
    """Geometry based on :math:`W = 3N^2+3N+1; B = (2N+1)D`"""
    def __init__( self, n ):
        self.n = n
    def nw( self ):
        return 3*self.n**2+3*self.n+1
    def id( self, od ):
        return (2*self.n+1)*od
    def od( self, id ):
        return id/(2*self.n+1)

class Geometry_2( Geometry ):
    """Geometry based on :math:`W = 3N^2+5N+2; B = (2N+2)D`"""
    def __init__( self, n ):
        self.n = n
    def nw( self ):
        return 3*self.n**2+5*self.n+2
    def id( self, od ):
        return (2*self.n+2)*od
    def od( self, id ):
        return id/(2*self.n+2)

class Geometry_3( Geometry ):
    """Geometry based on :math:`W = 3N^2+6N+3; B = \\left(1+2\\sqrt{N^2+N+\\frac{1}{3}}\\right)D`"""
    def __init__( self, n ):
        self.n = n
    def nw( self ):
        return 3*self.n**2+6*self.n+3
    def id( self, od ):
        return (1+2*math.sqrt(self.n**2+self.n+1/3))*od
    def od( self, id ):
        return id/(1+2*math.sqrt(self.n**2+self.n+1/3))

class Geometry_4( Geometry ):
    """Geometry based on :math:`W = 3N^2+7N+4; B = \\left(1+\\sqrt{4N^2+5.644N+2}\\right)D`"""
    def __init__( self, n ):
        self.n = n
    def nw( self ):
        return 3*self.n**2+7*self.n+4
    def id( self, od ):
        return (1+math.sqrt(4*self.n**2+5.644*self.n+2))*od
    def od( self, id ):
        return id/(1+math.sqrt(4*self.n**2+5.644*self.n+2))

class Conduit( Solver ):
    """Solver for conduit problems.

    It appears that there are four geometries.
    Each geometry it itself a solver for NW, ID or OD
    given a parameter value, N.
    """
    def solve( self, args ):
        """Requires two of three values:

        :param ID: the conduit inside diameter.
        :param OD: the wire's outsdie diameter.
        :param NW: the number of wires to pack into the conduit.
        :returns: dict with the missing value added.
        """

        if 'ID' in args and 'OD' in args:
            args= self.calc_nw(args)
        elif 'ID' in args and 'NW' in args:
            args= self.calc_od(args)
        elif 'OD' in args and 'NW' in args:
            args= self.calc_id(args)
        else:
            raise NoSolutionError( "Insuficient Data: {0!r}".format(args) )
        return args
    def calc_nw( self, args ):
        """Solve for NW, given ID and OD."""
        N= 0
        for step in range(1024):
            N += 0.01
            for geometry in Geometry_1,Geometry_2,Geometry_3,Geometry_4:
                g= geometry(N)
                # Bundle size finally gotten too big?
                if g.id(args.OD) >= args.ID:
                    # Previous answer was too small.
                    return args
                else:
                    args.NW= g.nw()
        raise NoSolutionError( "Can't calculate NW" )
    def calc_od( self, args ):
        """Solve for OD, given ID and NW."""
        N= 0
        for step in range(1024):
            N += 0.01
            for geometry in Geometry_1,Geometry_2,Geometry_3,Geometry_4:
                g= geometry(N)
                if g.nw() >= args.NW:
                    return args
                else:
                    args.OD= g.od(args.ID)
        raise NoSolutionError( "Can't calculate OD" )
    def calc_id( self, args ):
        """Solve for ID, given OD and NW."""
        N= 0
        for step in range(1024):
            N += 1 # Quirk? should it be 0.01 like the others?
            for geometry in Geometry_1,Geometry_2,Geometry_3,Geometry_4:
                g= geometry(N)
                if g.nw() >= args.NW:
                    return args
                else:
                    args.ID = g.id_opt( args.OD )
        raise NoSolutionError( "Can't calculate ID" )

conduit= Conduit()
