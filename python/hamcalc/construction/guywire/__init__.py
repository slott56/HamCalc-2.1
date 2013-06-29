"""hamcalc.construction.guywire

This module creates two **Solver** instances.

..  py:function:: guywire_f( H=None, J=None, R=None )

    Solve guy wire problems. This an instance of the :class:`GuyWire` **Solver** in imperial units.

    :param H: height in feet
    :param J: Structure Type J Factor
    :param R: distance from base in feet
    :returns: Dict with all values.

..  py:function:: guywire_m( H=None, J=None, R=None )

    Solve guy wire problems. This an instance of the :class:`GuyWire` **Solver** in
    metric units.

    :param H: height in metres
    :param J: Structure Type J Factor
    :param R: distance from base in metres
    :returns: Dict with all values.


The unit-specific versions are necessary for two reasons.
First, because the
renonance check is for multiples of 16' and 22'.
Metric tower designs must be have this resonance
check done in feet, hence the explicit conversions.

Second, the stand-off is a fixed 1'. This becomes 30.48 cm
in the metric version.

Test Case

>>> import hamcalc.construction.guywire as guywire
>>> min, rec = guywire.minimim_recommended( 12 )
>>> round(min,2)
6.93
>>> round(rec,2)
9.6
>>> J= guywire.J_Factor['Amateur Radio type tower']
>>> args= guywire.guywire_f( H=12, R=9, J=J )
>>> args.next
1
>>> args.H
12
>>> round(args.L,1)
15.0
>>> args.space
1.0
>>> args.C
1
>>> round(args.GW,1)
13.0
>>> round(args.theta_d,2)
53.13
>>> args= guywire.guywire_f( **args )
>>> args.next is None
True

"""
__version__ = "2.1"

import math
from collections import OrderedDict
from hamcalc.lib import Solver, NoSolutionError
from hamcalc.math.equiv import FOOT, METRE

introduction="""\
GUY WIRES for Antenna Towers and Masts                  by George Murphy VE3ERP

       To support a typical Ham beam antenna this program calculates:
       - Number of guy wire sets required for any given tower/mast height.
       - Height above ground for the attachment of each set of guy wires.
       - Distance from the tower/mast to the guy wire anchors.
       - Quantity and length of non-resonant segments in each guy wire.
       - Total length of each guy wire.

       The calculations assume three wires per set spaced 120° apart, with
       three anchor points - each anchoring one wire of each guy wire set.

                                 TYPICAL GUY WIRE
                            ( ■ = Attachment Fitting )
                            ( ∞ = Egg Insulator      )
                │«─────────────── Centre Section ───────────────»│
                │ (may need to be cut into separate non-resonant │
                │      segments connected by egg insulators)     │
  Tower ■──────∞───────────────∞────────────────∞───────────────∞──────■ Anchor
        »│30 cm.│«                slope down ──>                »│30 cm.│«
        »│12 in.│«                                              »│12 in.│«
         │«────────────────────────── Length ──────────────────────────»│

     The required number of supporting guy wire sets for a tower or
   mast depends on the height of the structure and the minimum spacing
   between guy wire sets recommended for the type of structure and
   local icing and wind conditions. Typical minimum spacings assumed
   by the program are conservative and may be considered as applicable
   for close to 'worst case' site conditions.
     To avoid possible mechanical resonance in the structure that may
   cause it to have a tendency to vibrate, the sets of guys should NOT
   be spaced at equal vertical intervals on the structure.
     The recommended distance of anchor points from the structure is
   about 80% of the structure height. Anchor distances of less than
   58% of the height should be considered as being unsafe.
     This program performs all the calculations required to meet these
   criteria.

"""

def intro():
    return introduction

J_Factor = OrderedDict(
    ( ("Amateur Radio type tower", 35),
    ("TV antenna type tower", 20),
    ("thinwall pipe or tubing mast", 12),
    ("supporting structure", None),
    )
)

def minimim_recommended( H ):
    """Compute minimum and recommended distance from base.

    :param H: height.
    :returns: Minimum and recommended distances.
    """
    return H/math.sqrt(3), .8*H

class GuyWire( Solver ):
    """Solver for Guy Wire problems.
    This must be instantiated with proper units.
    """
    def __init__( self, unit=None ):
        self.unit= unit if unit is not None else FOOT
        self.space = unit.from_std( FOOT.to_std( 1 ) ) # Spacing.
        self.r_1 = 16 # Feet
        self.r_2 = 22 # Feet
    def solve( self, args ):
        """Compute various Guywire Parameters.

        :param H: height
        :param J: Structure Type J Factor
        :param R: distance from base.
        """
        if 'next' not in args or args.next is None:
            # First solution
            args.theta_r = math.atan2( args.H, args.R )
            args.N= 1
            TOP= args.H-args.R*math.tan( args.theta_r*(args.N-1) )
            while TOP > args.J:
                args.N += 1
                TOP= args.H-args.R*math.tan( args.theta_r*(args.N-1) )
            args.A_I_r = args.theta_r/args.N
            args.theta_d = math.degrees( args.theta_r )
            args.A_I_d = math.degrees( args.A_I_r )
            args.next= 0
        # Return next solution
        args.next += 1
        if args.next > args.N:
            args.next= None
            return args
        args.A_r = args.next * args.A_I_r
        args.A_d = math.degrees( args.A_r )
        args.E = args.R * math.tan( args.A_r )
        args.L = math.sqrt( args.R**2 + args.E**2 )
        args.space= self.space
        args.GW = args.L - 2*args.space # Feet
        # set args.C based on resonance rule.
        for args.C in range(1,16):
            if self.resonant( args.GW/args.C ):
                continue
            else:
                break
        args.GW_C= args.GW/args.C
        return args
    def resonant( self, Y ):
        """Check resonance for all integer wire lengths "near" Y.

        "To prevent any resonance cut the guy wire so that no section displays a length in feet that can be evenly divided by 16 or 22"

        :param Y: is a guy-wire length.
        :return: True if any integer X "near" Y has X%16 or X%22
        """
        Y_f = int(FOOT.from_std( Y ))
        for X in range( int( .95*Y_f+.5 ), int(1.05*Y_f+.5) ):
            if X%self.r_1 == 0 or X%self.r_2 == 0:
                return True
        return False

guywire_f= GuyWire( FOOT )
guywire_m= GuyWire( METRE )
