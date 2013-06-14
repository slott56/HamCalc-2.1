beamdefl -- BEAMS, Deflection in
----------------------------------

Legacy Output
~~~~~~~~~~~~~~

Introduction::

     DEFLECTION in BEAMS                                     by George Murphy VE3ERP
      Ref: Machinery's Handbook, 21st Edition

     beam of any cross-section:

     Select Modulus of Elasticity by pressing letter in < >:

      < a >  ALLOY STEEL......................(   30Σ6 PSI )
      < b >  STRUCTURAL STEEL.................(   29Σ6 PSI )
      < c >  WROUGHT IRON.....................(   28Σ6 PSI )
      < d >  TYPICAL ALUMINUM EXTRUSION.......( 10.3Σ6 PSI )
      < e >  WOOD - Fir.......................( 1,76Σ4 PSI )
      < f >  WOOD - Redwood...................( 1,32Σ4 PSI )
      < g >  WOOD - Cedar, Pine, Spruce.......( 1,10Σ4 PSI )
      < h >  OTHER............................
        or
      < z >  to EXIT

     Modulus of Elasticity =    30000000 PSI for Steel Alloy

     Press < 1 > to continue or < 0 > to re-do.....
     Press letter in ( ) to define beam:

     (a) case  1: Supported both ends, uniform load
     (b) case  2: Supported both ends, load at centre
     (c) case  3: Supported both ends, load at any point
     (d) case  4: Supported both ends, two symmetrical loads

     (k) case 10: Fixed one end, uniform load (cantilever)
     (l) case 11: Fixed one end, load at other (cantilever)
     (m) case 12: Fixed one end, intermediate load (cantilever)

     (r) case 18: Fixed both ends, uniform load
     (s) case 19: Fixed both ends, load at centre
     (t) case 20: Fixed both ends, load at any point

     CANTILEVER BEAM FIXED ONE END, LOAD AT OTHER
     Steel Alloy beam of any cross-section


                                  D= (W x L^3) / (3 x E x I)
                      █ W
     ╬════════════════╛
     ║

    ENTER: Load (in pounds).....................W = ? 40
    ENTER: Moment of Inertia (in inches^4)......I = ? 24
    ENTER: Length of beam (in inches)...........L = ? 14
             Modulus of Elasticity .....................E =    30000000.0    PSI
             Moment of Inertia .........................I =          24.000 in^4
             Length of beam ............................L =          14.000 in.
             Load ......................................W =          40.0    lbs.
             Deflection at .............................D =           0.000 in.
    end
             Maximum safe deflection ......................           0.039 in.

Note that ``Σ6`` means :math:`\times 10^6`.

Analysis
~~~~~~~~~

It appears that the there are 10 equations for deflection based on
beam loading, some measurements and the modulus of elasticity.

Materials have both modullus of elasticity and pounds per cubic inch.

..  csv-table::

    "E","PCI","Material"
    "30000000","0.2833","Steel Alloy"
    "29000000","0.2833","Structural Steel"
    "28000000","0.285","Wrought Iron"
    "10300000","0.0979","Extruded Aluminum"
    "1760000","0.0162","Fir"
    "1320000","0.0162","Redwood"
    "1100000","0.0162","Cedar, Pine or Spruce"

