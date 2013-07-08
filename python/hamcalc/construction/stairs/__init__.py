"""hamcalc.construction.stairs

There are two implementations of :mod:`hamcalc.construction.stairs`.

-   The default implementation is a (relatively) complex set of functions
    that simply step through the design process.

-   An alternate implementation is a slightly more flexible (but more complex)
    object-oriented **Chain of Command** implementation.

We have the following cases for display.

-   Angle of 90°: Vertical Ladder. H= 6, L= 0.

-   Angle of 77° to 90°: Inclined Ladder. 80°: H= 6, L= 1.058

-   Angle of 48.37° to 77°: Open-Riser Step Ladder. 60°: H = 6, L= 3.464

-   Angle of 20.45° to 48.37°: Stairway. 30°: H= 6, L= 10.39

-   Angle less than 20.45°: Step Ramp; if H < 5, then inclined Ramp. 20°: H=6, L=16.48. And.  15° H=5, L=18.66.

The decision tree for design, however, has only four cases for design.

-   Vertical Ladder

-   Ramp (step or inclined)

-   Restricted Length Risers, which may devolve to a ladder.

-   Unrestricted Length Risers

Units, BTW, are inches for this module.

Test Case 1: Unrestricted length riser

>>> import hamcalc.construction.stairs as stairs
>>> s_u= stairs.stair_design( 72, R=8.0 )
>>> round(s_u.A,3)
40.601
>>> round(s_u.N,3)
9
>>> round(s_u.T,3)
9.333
>>> round(s_u.X,3)
12.293
>>> round(s_u.Y,3)
98.342
>>> round(s_u.R,3)
8.0
>>> round(s_u.P,3)
8

Test Case 2: Ladder

>>> l= stairs.stair_design( 72, 0 )
>>> round(l.A,2)
90
>>> round(l.P,3)
5
>>> round(l.X,3)
0
>>> round(l.R,3)
13.5
>>> round(l.P,3)
5

Test Case 3: Step Ladder

>>> sl= stairs.stair_design( 72, 12.696 )
>>> round(sl.A,2)
80.0
>>> round(sl.N,3)
14
>>> round(sl.R,3)
5.143
>>> round(sl.X,3)
14.113
>>> round(sl.Y,3)
183.472
>>> round(sl.P,3)
13
>>> round(sl.T,3)
13.143

Test Case 4: Inclined Ladder
There is one design with several different displays.
Once you've designed the ladder, the distinction between
step ladder and inclined ladder seems to be the difference
between "steps" and "rungs."

>>> il= stairs.stair_design( 72, 41.568 )
>>> round(il.A,2)
60.0
>>> round(il.N,3)
14
>>> round(il.R,3)
5.143
>>> round(il.X,3)
14.113
>>> round(il.Y,3)
183.472
>>> round(il.P,3)
13
>>> round(il.T,3)
13.143

Test Case 5: Restricted Stairway
Again, with essentially one design and multiple displays,
this looks like designs.

>>> s= stairs.stair_design( 72, 124.68 )
>>> round(s.A,2)
30.01
>>> round(s.N,3)
14
>>> round(s.R,3)
5.143
>>> round(s.X,3)
14.113
>>> round(s.Y,3)
183.472
>>> round(s.P,3)
13
>>> round(s.T,3)
13.143

Test Case 6: Step Ramp
A distinctive design.

>>> sr= stairs.stair_design( 72, 197.76 )
>>> round(sr.A,2)
20.01
>>> round(sr.N,3)
14
>>> round(sr.R,3)
5.143
>>> round(sr.X,3)
16.058
>>> round(sr.Y,3)
208.756
>>> round(sr.P,3)
13
>>> round(sr.T,3)
15.212

Test Case 7: Inclined Ramp

>>> ir= stairs.stair_design( 60, 223.92)
>>> round(ir.A,2)
15.0
>>> round(ir.N,3)
12
>>> round(ir.R,3)
5.0
>>> round(ir.X,3)
20.961
>>> round(ir.Y,3)
230.576
>>> round(ir.P,3)
11
>>> round(ir.T,3)
20.356

Test Case for Stairwell and Headroom

>>> s_u.F = 8
>>> swhr= stairs.stairwell_headroom( **s_u )
>>> round(swhr.SW, 3 )
74.667
>>> round(swhr.HR, 3 )
64.0

"""
__version__ = "2.1"

from hamcalc.construction.stairs.func import *
from hamcalc.math.decifrac import INCH, MILLIMETRE, FOOT, METRE, FOOT_INCH_FRAC

introduction="""\
STAIRS, LADDERS & RAMPS                                     by George C. Murphy

 FL    │«─────── SP ──────»│
  ├»═══╪═══╗«──── SW ─────»╔══ «┐
 ┌┴»═══╪═══╝           ╔═══╝e   │
 │     │           ╔═══╝        │
 HR    │       ╔═══╝           HT
 └─────┼» c╔═══╝d    BASIC      │
       ╔═══╝b       ELEMENTS    │
    ═══╝a «─────────────────────┘
"""
def intro():
    return introduction

stairway_pic="""\
         │«── Run ──»│
     ┌───┼──────────»╔════
     │   │           ╚═╦══ «─┐
   Rise  │     Riser──»║     │
     │   │ Tread─┐     ║   Rise
     └──»╔═══════╪═════╣
         ╚═╦═══════════╝ «───┘
Nosing──»│ │«── Run ──»│"
"""

stepladder_pic="""\
      ──»│ Run │«──
         │     ╔══════╗«─┐
         │     ╚════╪═╝  │
         │     Step─┘  Rise
         │ ┌─Step        │
Nosing──»╔═╪════╗«───────┘
         ╚══════╝
      ──»│      │«── 3"- 5"
"""

inclined_ladder_pic="""\
   ──»│ Run │«──
  ┌───┼───» ▄ «──Rung
  │   │
Rise  │
  │   │
  └─» ▄ «── Rung
"""

vertical_ladder_pic="""\
  ┌─────» ┌─»┌─┐ Top
  │      T└─»│▄│
  │          │ │
  │       ┌─»│▄│
 HT     Rise │ │
  │       └─»│▄│«─Rungs
  │          │ │
  │      B┌─»│▄│
  └─────» └─»└─┘ Bottom
"""

step_ramp_pic="""\
  │«──────── SP ─────────»│
  │                       │
  │       │«─Run─»│       ╔═ «─┐
  │Rise┌──┼──────»╔═══════╝    │
  │    └─»╔══╤════╝            HT
  ╔═══════╝  └──Ramp           │
 ═╝ «──────────────────────────┘
"""

inclined_ramp_pic="""\
      │«───── SP ─────»│
      │                │
  ┌───┼──────────────» ▄
 HT   │                C
  └─» ▄.................
      A                B
Inclined ramp between A & C
"""

def max_height( unit ):
    """Returns the maximum height for economy and residential construction.

    :param unit: Current units (either INCH or MILLIMETRE)
    :returns: pair with maximum height for economy
        and maximum height for residential purposes.
    """
    max_economy= INCH.to_std( 7.5 )
    max_residential= INCH.to_std( 8 )
    return unit.from_std( max_economy ), unit.from_std( max_residential )


def stairwell_headroom( **args ):
    """Requires the following arguments.

    :T: run
    :R: rise
    :N: no.of full risers
    :F: Floor Thickness, FL

    Updates args with "HR" and "SW".

    :SW:    Stairwell Dimension
    :HR:    Headroom Dimension
    """
    args= AttrDict( args )
    if 'F' not in args: return args
    try:
        Z = min( Z for Z in range(1,args.N+1) if Z*args.R-args.F >= 75 )
    except ValueError:
        Z = args.N
    args.HR = Z*args.R-args.F
    #args.X = args.N-Z # Legacy Quirk
    args.SW = (Z-1)*args.T
    return args

def handrail_height( **args ):
    """Compute handrail height. Requires the following arguments.

    :A: Angle in degrees.

    Updates args with

    :B: Handrail height.
    """
    args= AttrDict( args )
    if 48 < args.A <= 90:
        args.B = 34+(args.A-48.4)/41.6*14
    elif 39.2 < args.A <= 48:
        args.B = 33+(args.A-39.2)/9.2
    elif 24 < args.A <= 39.2:
        args.B = 33
    else:
        # assert A <= 24
        args.B = 33+(24-args.A)/8
    return args

def is_ramp_inclined( **args ):
    """Does this design reflect an inclined ramp?"""
    return args['P'] == 0

def is_ladder_vertical( **args ):
    """Does this design reflect a vertical ladder?"""
    return args['A'] == 90

def is_ladder_inclined( **args ):
    """Does this design reflect an inclined ladder?"""
    return 77 <= args['A'] < 90

def is_ladder_open( **args ):
    """Does this design reflect an open stepladder?"""
    return 48.37 <= args['A'] < 77

def is_stairway( **args ):
    """Does this design reflect a stairway?"""
    return 20.45 <= args['A'] < 48.37

def is_ramp_step( **args ):
    """Does this design reflect a step ramp?"""
    return args['A'] < 20.45
