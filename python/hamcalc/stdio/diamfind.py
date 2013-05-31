"""Diameter Finder"""
import math

introduction="""\
Diameter Finder                                        by George Murphy VE3ERP

            ║
  ┌───╥╥╥╥╥╥╫───┐
  │   ║║║║║║║   │«─ object being measured.
  │  ─╫╫╫╫╫╫╫─ «┼ draw a line across turns.
  │   ║║║║║║║«──┼ several turns of fishing
  └───╫╨╨╨╨╨╨───┘ line or heavy thread.
      ║


 This program measures the diameter of cylindrical objects such as coil forms,
 cables of bunched wires, etc. with micrometer accuracy when a micrometer is
 not available.
 """

def diameter():
    prompt= """\
Close-wind several turns of fishing line or thread around the object and with
a marking pen draw a line across the turns. Unwind the turns, count the dots,
straighten the line and measure the distance between the first and last dots.

Any unit of measure can be used. Results will be in the same units.
"""

    print( prompt )
    dots_raw= input( "ENTER: number of dots............................? ")
    try:
        N= float(dots_raw)
    except ValueError:
        return
    length_raw= input( "ENTER: distance between first and last dot.......? ")
    try:
        L= float(length_raw)
    except ValueError:
        return
    D= L/(math.pi*(N-1))
    print( "Diameter of object = {:7.3f}".format(D) )


print( introduction )

z = None
while z != '0':
    z= input( " ENTER 1 to continue or 0 to EXIT. " )
    if z == '1':
        diameter()
