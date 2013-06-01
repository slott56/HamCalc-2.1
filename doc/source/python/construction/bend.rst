bend -- Bend Allowance, Metals
--------------------------------

Legacy Output
~~~~~~~~~~~~~~


Introduction::

    BEND ALLOWANCE, Metal                                   By George Murphy VE3ERP

         leg         leg
     │«── A ─»│«C»│«─ B ─»│     █▀▀▀▀▀▀▀ A
     ┌────────┬─┬─┬───────┐     █ L
     │    bend─»| |       │     █
     └────────┴─┴─┴───────┘     B
      BLANK BEFORE BENDING    »│T│«
     T = Thickness of material
     R = Bending radius to inside face of blank
     L = Included angle of bend
     C = Bend allowance

     In bending metal the problem is to find the length of straight stock required
     for each bend; then these lengths are added to the lengths of the straight
     sections to obtain the total length of the material before bending.
             (Machinery's Handbook, revised 21st edition, page 1928).

     Bend allowance for pipe or tubing = radius to centreline of the material x
     included angle in degrees x 0.01745.
            (Machinery's Handbook, revised 21st edition, page 2335).

Sample Output.

(Numeric values aren't correct.)

::

     ENTER: Material thickness (in.)....................T=? .125
     ENTER: Inside radius to face of material (in.).....R=? 3
     ENTER: Included angle of bend (degrees)............L=? 90
     Material thickness.......T=   3.2 mm =  0.125 in.
     Inside radius of bend....R=  76.2 mm =  3.000 in.
     Included angle...........L=  90.0 degrees
     Bending allowance C:
      For brass & soft copper................................  15.0 mm =  0.592 in.
      For half-hard copper & brass, soft steel, & aluminum...  15.3 mm =  0.604 in.
      For bronze, hard copper, cold rolled & spring steel....  15.6 mm =  0.612 in.

Analysis
~~~~~~~~~~

Brass and soft copper: :math:`0.55T+\frac{\pi}{2}R`

Half-hard copper & brass, soft steel, & aluminum: :math:`0.64T+\frac{\pi}{2}R`

Bronze, hard copper, cold rolled & spring steel: :math:`0.71T+\frac{\pi}{2}R`

Plus unit conversions from inches or millimeters.

And nice ASCII art diagrams.
