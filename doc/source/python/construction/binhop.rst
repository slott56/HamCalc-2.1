..  _construction.binhop:

binhop -- Hoppered Bins & Tanks
---------------------------------

Quirk: The legacy program chained to :program:`binvol`, a program
which doesn't appear on any menu.

We'll merge :ref:`construction.binvol` into this program's
implementation.

Legacy Output
~~~~~~~~~~~~~~~~

Introduction::

    HOPPERED BIN ANALYSIS                                  by George Murphy, VE3ERP


      │«─ F ─»│
      ┌───────┐«─┐«─┐
      │  bin  │  J  │
      └───────┤«─┤  │
       \hopper│  H  M
        \     │  │  │
         └────┘──┘«─┘
       ─»│ D  │«─

     This program calculates dimensions and cubic capacity of hoppered rectangular
     or round bins and tanks. Dimensions can be entered in any units of measure,
     bearing in mind that the calculated results will be in the same units.

     To analyze an existing bin......press 1
     To design a new bin.............press 2
     To EXIT.........................press 0

Menu item 2 runs the :program:`binvol` program.

Note that this diagram isn't the same as the center-draw diagram
in ref:`construction.binvol`.

Note that the following sample output has an error in it.

Sample Output::

      Press number in ( ) to indicate shape of bin:        (1) Round
                                                           (2) Rectangular
    ENTER: Outlet D..................width =? 3
    ENTER: Outlet D.................length =? 8
    Press number in ( ) to indicate hopper discharge:      (1) Side draw
                                                           (2) Center draw
    ENTER: Hopper height H.................=? 12
    ENTER: Bin width F.....................=? 12
    ENTER: Bin length F....................=? 12
    ENTER: Bin wall height J...............=? 12
     RECTANGULAR BIN, CENTER DRAW HOPPER


      │«─ F ─»│
      ┌───────┐«─┐«─┐
      │  bin  │  J  │
      └───────┤«─┤  │
       \hopper│  H  M
        \     │  │  │
         └────┘──┘«─┘
       ─»│ D  │«─

     Bin width .....................F=       12.000
     Bin length ....................G=       12.000
     Bin wall height ...............J=       12.000
     Hopper height .................H=       12.000
     Overall height ................M=       24.000
     Outlet width ..................D=        3.000
     Outlet length .................D=        8.000
     Bin cross-section area ..........      144.000
     Cubic capacity ..................     1728.018
     Min. hopper slope 69.4°
     Want to change hopper height and slope angle?  (y/n)

Analysis
~~~~~~~~~~

This is actually two simple calculators:

-   Rectangular bins

-   Cylindrical bins

Each bin has an optional consideration for side draw vs. center draw.
This appears to be a plug-in strategy object or mixin.

While there is some overlap between the two calculators, what's
common is more the broad outline than the details.

Rectangular
^^^^^^^^^^^^

:D: Outlet width D
:E: Outlet length D

Center draw vs. side draw choice.

..  math::

    V = D \times E

:X: Bin cross-section area

:H: Hopper height H

:F: Bin width F
:G: Bin length F

..  math::

    X = F \times G

:J: Bin wall height J

..  math::

    Z &= \dfrac{H}{3}(V+X+\sqrt{VX})+XJ \\
    M &= H + J \\
    N &= \begin{cases}
        \arctan \left(\dfrac{H}{F-D}\right) \dfrac{180}{\pi} &\text{if side} \\
        \arctan \left(\dfrac{2H}{F-D}\right) \dfrac{180}{\pi} &\text{if center}
    \end{cases}

Display.


Cylindrical
^^^^^^^^^^^^

:D: Outlet diameter D

Center draw vs. side draw choice.


..  math::

    V = \pi \left(\dfrac{D}{2}\right)^2

:H: Hopper height H

:F: Bin Diameter F

..  math::

    X = \pi \left(\dfrac{F}{2}\right)^2

:J: Bin wall height J

..  math::

    Z &= \dfrac{H}{3}(V+X+\sqrt{VX})+XJ \\
    M &= H + J \\
    N &= \begin{cases}
        \arctan \left(\dfrac{H}{F-D}\right) \dfrac{180}{\pi} &\text{if side} \\
        \arctan \left(\dfrac{2H}{F-D}\right) \dfrac{180}{\pi} &\text{if center}
    \end{cases}

:X: Bin cross-section area
:Z: Cubic Capacity
:N: Minimum hopper slope

Display.

Implementation
~~~~~~~~~~~~~~~

This is the implementation for this program, as well as
:ref:`construction.binvol`.

..  automodule:: hamcalc.construction.binhop
    :members:

Quirks
~~~~~~~

Lines 1050 to 1170 seem inaccessible and unused.
This may be code from an earlier version of :program:`binvol`, or
perhaps a version of :program:`binhop` that was some kind of **Solver**.
