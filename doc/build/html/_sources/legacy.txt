..  _`legacy`:

##################
The HamCalc Legacy
##################

The Hamcalc legacy is 449 individual program files and 85,431 lines of GW-Basic
programming.

This section contains a detailed review of the available menus and indexes.
It includes a summary of the various subject areas into which the programs
should be classified.

User Menu
=========

There's a simplex index in :file:`MENU/HAMCAL-X.BAS`. This is the main menu of calculations available. Note that several of the 'MENU' programs repeat
this list or a similar list.

::

    640 DATA accalc,   A.C. Circuit Calculator
    650 DATA accelr,   Acceleration Calculator
    660 DATA antfield, Antenna Field Strength
    670 DATA antscale, Antenna Frequency Scaling
    680 DATA impant,   Antenna Impedance Calculator
    690 DATA antenna,  Antenna Length/Pruning calculator
    700 DATA antsyn2,  Antenna Matching Networks
    710 DATA arch,     Arch Calculator
    720 DATA page437,  ASCII Character Code Page 437
    730 DATA attenpad,"Attenuators: T-Pad and Pi-Pad"
    740 DATA audfilt,  Audio Bandpass Filter - Active
    750 DATA lopass,   Audio Lowpass Filter(Sallen & Key)
    760 DATA audpass,  Audio Filters - Passive
    770 DATA rcfilt,   Audio Filters - RC Active
    780 DATA audosc,   Audio Oscillator (LM 324)
    790 DATA audosc2,  Audio Oscillator (LF 353)dual wave
    800 DATA twintee,  Audio Oscillator (Twin-T)
    810 DATA zounds,   Audio Programs
    820 DATA awgexact, A.W.G. Wire Size Calculator
    830 DATA bend,     Bend Allowance - Metals
    840 DATA aircore,  B.& W. Air-Core Inductors
    850 DATA broadfer, Baluns - Ferrite Toroid
    860 DATA bandstop, Band-Reject Filter
    870 DATA bandq,    Bandwidth vs. Q
    880 DATA bandwdth,"Bandwidths - 2:1 SWR"
    890 DATA baromtr,  Barometer Reading Equivalents
    900 DATA batchg,   Battery Charger
    910 DATA dialgth,  Beam Element Diameter vs Length
    920 DATA pathfind, Beam Heading Calculator
    930 DATA bevant,   Beverage Antenna Equations
    940 DATA bobtail,  Bobtail Curtain Antenna
    950 DATA boom,     Boom Droop - Beam Antennas
    960 DATA spark,    Breakdown Voltage
    970 DATA caltoday, Calendar - Perpetual/Universal
    980 DATA calory,   Calorie Counter
    990 DATA capstray, Capacitance - Distributed (stray)
    1000 DATA captance, Capacitor Design Calculator
    1010 DATA capval,   Capacitor Measurer
    1020 DATA gaplot,   Capacitor Plate Designer
    1030 DATA capcoax,  Capacitors - Coaxial Cable
    1040 DATA custcap,  Capacitors - Custom Value
    1050 DATA precicap, Capacitors - Precision
    1060 DATA capacval, Capacitors - Standard Values
    1070 DATA capytel,  Capacitors - Telescoping Variable
    1080 DATA trimr,    Capacitors - Trimmer
    1090 DATA hatshape, Capacity Hat Geometric Shapes
    1100 DATA capyhat,  Capacity Hats - Vertical Antennas
    1110 DATA rotaplot, Cartesian/Polar Plot Rotator
    1120 DATA ccdanten, CCD Antennas
    1130 DATA centfreq, Centre Frequency & Wavelength
    1140 DATA centrif,  Centrifugal/Centripetel Force
    1150 DATA propcirc, Circle - Properies of
    1160 DATA circfeed, Circular Waveguide Dish Feeds
    1170 DATA clamp,    Clamping Voltage Calculator
    1180 DATA clarky,   Clark Y Airfoil
    1190 DATA cmosc3,   CMOS Oscillator
    1200 DATA coaxchar, Coax Cable Characteristics
    1210 DATA coaxlc3,  Coax Cable L/C Tank
    1220 DATA chokbal,  Coax Cable RF Chokes & Baluns
    1230 DATA coaxtrap, Coax Cable Traps
    1240 DATA buxtrap , Coax Cable Hi-Reactance SuperTrap
    1250 DATA cw,       Code Trainer (Morse Code)
    1260 DATA coilnew,  Coil Calculator- Dehoney equations
    1270 DATA coilequa, Coil Calculator- Wheeler equations
    1280 DATA coilq,    Coil Q Calculator
    1290 DATA coildsgn, Coil Designer
    1300 DATA coilquik, Coil Q Quick Estimator
    1310 DATA coiltrue, Coil Q - True vs. Apparent
    1320 DATA coilnew,  Coil Tap Calculators
    1330 DATA coiltap,  Coil Tap Properties
    1340 DATA turns,    Coil Turns Calculator
    1350 DATA coilcpl,  Coils - Coaxially coupled
    1360 DATA coilnew,  Coils in Tandem
    1370 DATA coilin,   Coils - Insulated Wire
    1380 DATA colposc,  Colpitts FET Oscillator
    1390 DATA conecalc, Cone Calculator
    1400 DATA conjumat, Conjugate Match Calculator
    1410 DATA phazdiff, Constant Phase Difference Networks
    1420 DATA copwire,  Copper Wire Data
    1430 DATA elecost,  Cost of Electricity
    1440 DATA xover,    Crossover Networks - Loudspeakers
    1450 DATA crysfilt, Crystal Ladder Filter
    1460 DATA curvefit, Curve Fit program
    1470 DATA cylload,  CYLOAD antenna
    1480 DATA daydusk,  Daylight Dusk and Dawn Calculator
    1490 DATA decibel,  Decibel Calculator
    1500 DATA decifrac, Decimal/Fraction Converter
    1510 DATA deciconv, Decimal Hour/Degree Converter
    1520 DATA binary,   Decimal to Binary Converter
    1530 DATA rjd,      Dehoney Algorithm Index
    1540 DATA deltamat, Delta Match
    1550 DATA diamfind, Diameter Finder
    1560 DATA dielect,  Dielectric Constants
    1570 DATA discone,  Discone Multiband Antenna
    1580 DATA duopole,  Dual Band Short Dipole Antenna
    1590 DATA trisqu,   Dual Op Amp Wave Generator
    1600 DATA seasons,  Equinoxes & Solstices
    1610 DATA elspec,   Electromagnetic Spectrum
    1620 DATA fatdipol, Fat Dipole (broadband)
    1630 DATA fibon,    Fibonacci Series
    1640 DATA filtut,   Filter Tutor
    1650 DATA buttfilt, Filters - Butterworth HF
    1660 DATA comfilt,  Filters - Complementary
    1670 DATA cplres,   Filters - Coupled Resonator
    1680 DATA matfilt,  Filters - Impedance Matching
    1690 DATA filtrlc,  Filters - Passive R/L/C
    1700 DATA filstrip, Filters - Stripline Bandpass
    1710 DATA finance,  Financial Calculators
    1720 DATA fishbone, Fishbone Antenna
    1730 DATA foldipol, Folded Dipole - 300- Twin-Lead
    1740 DATA zostepup, Folded Dipole - Zo Step-Up Ratios
    1750 DATA formulae, Formula Library
    1760 DATA fusewire, Fuses - Emergency
    1770 DATA g5rv,     G5RV Multiband Antenna
    1780 DATA gammatch, Gamma Match
    1790 DATA graphs,   Graphs
    1800 DATA pathfind, Great Circle Paths & Distances
    1810 DATA gridsq,   Grid Square Locator (Maidenhead)
    1820 DATA guywires, Guy Wires for Antenna Towers/Masts
    1830 DATA hairpin,  Hairpin Beta-Match for Yagis
    1840 DATA halfloop, Half-Loop Low Profile Antenna
    1850 DATA hambands, Ham Band Edge & Centre Frequencies
    1860 DATA harmonic, Harmonic Frequencies
    1870 DATA hartosc,  Hartley FET Oscillator
    1880 DATA hotbox,   Heat Dissipation
    1890 DATA sink,     Heat Sink Fins
    1900 DATA helant,   Helical Antenna - VHF/UHF
    1910 DATA helreson, Helical Resonators (VHF/UHF)
    1920 DATA helix,    Helical Winding
    1930 DATA qtrap,    High Q Antenna Traps
    1940 DATA humid,    Humidex Calculator
    1950 DATA 3mbridge, Impedance Bridge (3-meter)
    1960 DATA impednet, Impedance Matching Networks
    1970 DATA impedmetr,Impedance Meter
    1980 DATA antimp,   Impedance - Antennas
    1990 DATA impares,  Impedance - Parallel Resonant Cct.
    2000 DATA impedcct, Impedance - Reactance/Resist. Cct.
    2010 DATA inducalc, Inductance Calculator
    2020 DATA induloop, Inductance - Single Loops
    2030 DATA induhose, Inductors - Dryer Vent Hose
    2040 DATA inloss,   Insertion Loss
    2050 DATA invee,    Inverted Vee Antenna
    2060 DATA involute, Involute of a Circle
    2070 DATA jcalc,    J Calculator (Complex Impedances)
    2080 DATA jaypole,  J-Pole End-Fed Zepp Antenna
    2090 DATA kfactor,  K-Factor & Antenna Length (NEC-2)
    2100 DATA ladant,   Ladder Line Antenna
    2110 DATA ladder2,  Ladder Network - 2 element
    2120 DATA ladrsolv, Ladder Network Analyzer
    2130 DATA lamplife, Lamp Life Expectancy
    2140 DATA latlong,  Latitude/Longitude Data Base
    2150 DATA led,      LED Series Resistor
    2160 DATA radiolos, Line-of-Sight Radio Wave
    2170 DATA linkupl,  Link Coupled Tuners
    2180 DATA lm317,    LM317 Voltage Regulator
    2190 DATA deltload, Load Resistance Calculator
    2200 DATA localrpt, Local Repeaters
    2210 DATA zounds,   Music Math & Sounds
    2220 DATA numderiv, Logarithms to any base
    2230 DATA logyag,   LOG-YAG Log-Periodic Yagi Antenna
    2240 DATA pairlt,   Long-Tailed Pair
    2250 DATA loopant,  Loop Antenna Coil Inductance
    2260 DATA loopxmit, Loop Antennas - Transmitting
    2270 DATA loopsky,  Loop Skywire Dimensions
    2280 DATA l-pad,    L-Pad Calculator
    2290 DATA brick,    Masonry Estimator
    2300 DATA matchbox, Matchbox Impedance Transformer
    2310 DATA matchnet, Matching Networks for Transistors
    2320 DATA maxuf,    Max. Usable Frequencies (MAXIMUF)
    2330 DATA mechmenu, MECHANICS Math
    2340 DATA metshowr, Meteor Shower Predictor
    2350 DATA meters,   Meters (Direct Current)
    2360 DATA metrics,  Metric Conversions
    2370 DATA metnom,   Metronome
    2380 DATA microver, MicroVert very short HF Antenna
    2390 DATA miniloop, MINILOOP Miniature Loop Antenna
    2400 DATA miniquad, MINIQUAD Coil Shortened Antenna
    2410 DATA coilamp,  Mobile Whip Antenna Coils
    2420 DATA mobilmat, Mobile Antenna Matching
    2430 DATA mowhip,   Mobile/Maritime Whip Antennas
    2440 DATA moontrac, Moon Tracker
    2450 DATA moxon,    Moxon Rectangle Antenna
    2460 DATA zounds,   Musical Math & Sounds
    2470 DATA nicad,    NiCad Battery Discharger
    2480 DATA nmbrsize, Numbered Drills/Screws/Taps/Gauges
    2490 DATA numsort,  Number Sorter
    2500 DATA numderiv, Numbers and Functions
    2510 DATA octagon,  Octagonal Loop Framework
    2520 DATA octaloop, OCTALOOP Subminiature Loop Antenna
    2530 DATA octaring, OCTARING Subminiature Loop Antenna
    2540 DATA ocfdipol, "Off-Centre Dipole, 3-band trapless"
    2550 DATA ohmslaw,  Ohm's Law Calculator
    2560 DATA concur,   OP AMP Constant Current Circuit
    2570 DATA opamp,    OP AMP Operational Amplifiers
    2580 DATA trisqu,   OP AMP Wave Generator
    2590 DATA cascamp,  OP AMPS - Cascaded
    2600 DATA noisfig,  OP AMPS - Noise Figure
    2610 DATA dishant,  Parabolic Dish Design
    2620 DATA pedom,    Pedometer
    2630 DATA fotomenu, PHOTOGRAPHY Math
    2640 DATA pitnet,   Pi and T Networks
    2650 DATA pipesize, Pipe Sizes - ANSI Standard
    2660 DATA pixel,    Pixel Data for Scanners & Cameras
    2670 DATA polygon,  Polygon Dimensions
    2680 DATA potent,   Potentiometers - Custom Value
    2690 DATA psup,     Power Supply Analyzer
    2700 DATA pwrcct,   Power Supply Design
    2710 DATA dblbrg4,  Power Supply - Double Bridge
    2720 DATA psuperf,  Power Supply Performance
    2730 DATA powrxfmr, Power Transformer Design
    2740 DATA pwrxfmr,  Power Transformer Winding Estimator
    2750 DATA primenos, Prime Number Calculator
    2760 DATA copwire,  Printed Circuit Board Traces
    2770 DATA pba,      Pseudo-Brewster Angle
    2780 DATA pulsegen, Pulse Generator
    2790 DATA qreson,   Q Calculator - Resonant Circuits
    2800 DATA qfind4,   Q Measurement - L/C Tank Circuit
    2810 DATA foxlog,   QRP Fox Hunt Log
    2820 :REM'DATA qmeas,    Q of L/C Tank Circuit
    2830 DATA quad,     Quad Antenna Dimensions
    2840 DATA quadrat,  Quadratic Equation Calculator
    2850 DATA quartwav, Quarter Wave Transformer
    2860 DATA radangle, Radiation Angle - Antenna
    2870 DATA vertpatt, Radiation Plots - Phased Verticals
    2880 DATA randnum,  Random Number Generator
    2890 DATA react,    Reactance Programs
    2900 DATA dsgnmenu, Resistor/Inductor/Capacitor Ccts.
    2910 DATA colcode,  Resistor Colour Code
    2920 DATA resicop,  Resistors - Copper Wire Wound
    2930 DATA custohm,  Resistors - Custom Value
    2940 DATA precires, Resistors - Precision
    2950 DATA resisval, Resistors - Standard Values
    2960 DATA smeter,   S-Meter Readings vs. Power
    2970 DATA catenary, Sag in Horizontal Wire Antennas
    2980 DATA satorbit, Satellite Orbit Parameters
    2990 DATA scalspd,  Scale Speed Calculator
    3000 DATA schmidt,  Schmidt trigger Op Amp
    3010 DATA serisect, Series-Section Transformer
    3020 DATA centload, Short Centre-Loaded Dipole
    3030 DATA cylload,  Short Cylinder-Loaded Dipole
    3040 DATA dipol160, Short Dipole for 160/80/40 metres
    3050 DATA es2b,     Short ES2B (2 band) Trap Dipole
    3060 DATA shortant, Short Off-Centre-Loaded Dipole
    3070 DATA shortdip, Short Multiband Dipole Array
    3080 DATA shuttle,  Shuttle
    3090 DATA simuleq,  Simultaneous Equation Calculator
    3100 DATA snglwire, Single Wire Antenna Systems
    3110 DATA copwire,  Skin Effect
    3120 DATA skipdist, Skip Distance Calculator
    3130 DATA sloper,   Sloper Antenna Dimensions
    3140 DATA smithcht, Smith Chart Calculations
    3150 DATA sorter,   Sorter
    3160 DATA speedtd,  Speed/Time/Distance Calculator
    3170 DATA stubant,  Stub Match for Antennas
    3180 DATA coaxstub, Stubs - Coaxial Transmission Line
    3190 DATA transtub, Stubs - Open Wire Transmiss'n Line
    3200 DATA riseset,  Sunrise/Sunset Calculator
    3210 DATA survey,   Surveyor's Calculator
    3220 DATA swr,      SWR Calculator
    3230 DATA t2fd,     T2FD Tilted Folded Dipole
    3240 DATA tmatch,   T Match - Dipole to 600 - Line
    3250 DATA tankcct,  Tank Circuit - Power Amplifier
    3260 DATA teletube, Telescoping Aluminum Tubing
    3270 DATA thermres, Thermal Resistance
    3280 DATA psychrom, Thermodynamics
    3290 DATA timeq,    Time Quiz
    3300 DATA timezone, Time Zones (UTC)
    3310 DATA 555timer, Timer (555 IC)
    3320 DATA tinycoil, Tiny Coils
    3330 DATA torotrap, Toroid Antenna Traps
    3340 DATA broadfer, Toroid Baluns & Transformers
    3350 DATA toroid,   Toroid Inductors
    3360 DATA tracker,  Tracker - Receiver Tuned Circuits
    3370 DATA powrxfmr, Transformer Design
    3380 DATA xfmrnaro, Transformer - Narrow Band
    3390 DATA xfmr,     Transformer Ratios
    3400 DATA winding,  Transformer Winding Calculator
    3410 DATA trancct,  Transistor Circuit Design
    3420 DATA transmat, Transmatch Design (ZL1LE)
    3430 DATA chokbal,  Transmission Line Choke
    3440 DATA elecleng, Transmission Line Length
    3450 DATA lineloss, Transmission Line Losses
    3460 DATA mismat,   Transmission Line Mismatch
    3470 DATA node,     Transmission Line Node Locator
    3480 DATA tranline, Transmission Line Performance
    3490 DATA sqcoax,   Transmission Line - Square Coaxial
    3500 DATA openwire, Transmission Line - Open Wire
    3510 DATA qline2,   Transmission Line Q
    3520 DATA trapole,  Trap Antenna Design
    3530 DATA trapcalc, Trap Design Calculator
    3540 DATA trapdsgn, Trap Dipole - 3 Band Single Trap
    3550 DATA traprop,  Trap Properties Estimator
    3560 DATA coaxtrap, Traps - Coaxial Cable
    3570 DATA solutri,  Triangles - solution of
    3580 DATA trig,     Trigonometric Functions
    3590 DATA triplan,  Trip Planner
    3600 DATA trunorth, True North via the Sun
    3610 DATA tunecct,  Tuned Circuit Design - L/C network
    3620 DATA turnrad,  Turning Radius - Beam antennas
    3630 DATA tvchan,   TV Channels ( North America )
    3640 DATA unitvalu, Unit Value Comparator
    3650 DATA helvert,  Vertical Antenna - Helically Wound
    3660 DATA varayfed, Vertical Antenna Array Feed Method
    3670 DATA vfofreq,  VFO Frequency Calculator
    3680 DATA voltdiv,  Voltage Divider
    3690 DATA thevinin, Voltage Divider - Thevinin
    3700 DATA walker,   Walker
    3710 DATA walwart,  Wall Wart Ratings Calculator
    3720 DATA wartest,  Wall Wart Properties
    3730 DATA wavetrap, Wave Trap Filters
    3740 DATA bridge,   Wheatstone Bridge Calculator
    3750 DATA windom,   Windom Antenna
    3760 DATA windchil, Wind Chill Factor
    3770 DATA wireant,  Wire Antenna Index
    3780 DATA wiremesh, Wire Mesh Screens - Wind Loads
    3790 DATA wirecond, Wires in Conduit
    3800 DATA xmtrzmat, Xmtr. Transistor Stage Coupling
    3810 DATA yagi3el,  YAGI 3-Element Beam Design
    3820 DATA dialgth,  YAGI Element Diameter vs. Length
    3830 DATA yagispac, YAGI Element Spacing/NBS Standard
    3840 DATA yagtaper, YAGI Tapered Elements
    3850 DATA thruboom, YAGI Through-Boom Elements
    3860 DATA yagilong, YAGI Extremely Long VHF/UHF Antenna
    3870 DATA zener,    Zener Diode Voltage Regulator
    3880 DATA zeppdbl,  Zepp (extended double) Antenna
    3890 DATA zepp,     Zepp Multi-band antenna

Quick Table Menu
==================

Additionally, several programs, like :file:`PROG/QUIKTABL.BAS` include
their own submenu of features.

::

    180 PRINT "  (a) A.W.G. wire sizes"
    190 PRINT "  (b) Circles - properties of"
    200 PRINT "  (c) Decibels"
    210 PRINT "  (d) Decimal numbers to degrees/minutes/seconds"
    220 PRINT "  (e) Decimals to fractions"
    230 PRINT "  (f) Degrees to radians"
    240 PRINT "  (g) Degrees/minutes/seconds to decimal"
    250 PRINT "  (h) Equivalent values"
    260 PRINT "  (i) Fractions to decimals"
    270 PRINT "  (j) Logarithms"
    280 PRINT "  (k) Numbers - functions of"
    290 PRINT "  (l) Powers of numbers"
    300 PRINT "  (m) Prime numbers"
    310 PRINT "  (n) Radians to degrees"
    320 PRINT "  (o) Reciprocals of numbers"
    330 PRINT "  (p) Roots of numbers"
    340 PRINT "  (q) Temperature"
    350 PRINT "  (r) Triangles - solution of"
    360 PRINT "  (s) Trigonometric functions"

With this mapping from menu item to program.

::

    410 IF Z$="z"THEN CHAIN"\hamcalc\menu\hcal"
    420 IF Z$="a"THEN CHAIN"awgexact"
    430 IF Z$="b"THEN CHAIN"propcirc"
    440 IF Z$="c"THEN CHAIN"decibel"
    450 IF Z$="d"OR Z$="g"THEN CHAIN"deciconv"
    460 IF Z$="e"OR Z$="i"THEN CHAIN"decifrac"
    470 IF Z$="f" OR Z$="h"OR Z$="n"OR Z$="q"THEN CHAIN"equiv"
    480 IF Z$="j"OR Z$="k"OR Z$="l"OR Z$="l"OR Z$="o"OR Z$="p"THEN CHAIN"numderiv"
    490 IF Z$="m"THEN CHAIN"primenos"
    500 IF Z$="r"THEN CHAIN"solutri"
    510 IF Z$="s"THEN CHAIN"trig"

Complete Cross Reference
=========================

There's a complete cross-reference buried in :file:`INDEX/HAMDEX.FIL`.

..  csv-table::

    Heading,Subheading,Note,Program
    " VARIABLE CAPACITOR",", plate shape designer","","VACAP"
    "? SURGE PROTECTION","","","CLAMP"
    "A.C. CIRCUIT BASICS","","","ACCALC"
    "A.W.G. WIRE SIZE CALCULATOR","","","AWGEXACT"
    "ACCELERATION CALCULATOR","","","ACCELR"
    "ACCELERATION",", Graphic Demonstration","","WALKER"
    "AIR CYLINDERS","","","MECHMENU"
    "AIRFOIL",", Clark Y","","CLARKY"
    "ALIGNMENT",", receiver tuned circuits","","TRACKER"
    "ALK FACTOR",", antennas","","ANTENNA"
    "ALUMINUM TUBING",", specifications","","TELETUBE"
    "ALUMINUM TUBING",", tapered Yagi elements","","YAGTAPER"
    "AMMETERS","","","METERS"
    "AMPLIFIER",", double feedback","","DBLFB"
    "AMPLIFIER",", power",", tank circuit","TANKCCT"
    "AMPLIFIERS",", operational",", solid state","OPAMP"
    "ANGLE CONVERSION",", degrees/minutes/seconds","","EQUIV"
    "ANGLE CONVERSION",", degrees/radians","","EQUIV"
    "ANGLE OF RADIATION",", antennas","","RADANGLE"
    "ANTENNA ALK FACTOR","","","ANTENNA"
    "ANTENNA ELEMENT LENGTHS","","","ANTENNA"
    "ANTENNA FIELD STRENGTH","","","ANTFIELD"
    "ANTENNA FREQUENCY SCALING","","","ANTSCALE"
    "ANTENNA HEIGHT",", recommended minimum","","ANTENNA"
    "ANTENNA IMPEDANCE BRIDGE",", (3-meter)","","3MBRIDGE"
    "ANTENNA IMPEDANCE",", measured from transmission line","","ANTIMP"
    "ANTENNA IMPEDANCE",", measured with a transmatch","","TRANSMAT"
    "ANTENNA INDEX",", wire antennas","","WIREANT"
    "ANTENNA K-FACTOR & LENGTH",", (NEC-2 model)","","KFACTOR"
    "ANTENNA MATCHING NETWORKS",", equivalent circuits","","ANTMATCH"
    "ANTENNA TRAP DESIGN","","","TRAPOLE"
    "ANTENNA TRAP PROPERTIES","","","TRAPROP"
    "ANTENNA TRAPS",", High Q","","QTRAP"
    "ANTENNA TRAPS",", wave trap filters","","WAVETRAP"
    "ANTENNA",", 3 band",", single trap dipole","TRAPDSGN"
    "ANTENNA",", Balcony whip","","MOWHIP"
    "ANTENNA",", Beverage","","BEVANT"
    "ANTENNA",", Bobtail curtain","","BOBTAIL"
    "ANTENNA",", CCD",", (Controlled Current Distribution)","CCDANTEN"
    "ANTENNA",", Capacitance loaded",", horizontal or vertical","CCDANTEN"
    "ANTENNA",", Coaxial cable traps","","COAXTRAP"
    "ANTENNA",", Dipole",", shortened to fit restricted space","SHORTANT"
    "ANTENNA",", Dipole",", broadband","FATDIPOL"
    "ANTENNA",", Dipole",", cylinder-loaded","CYLLOAD"
    "ANTENNA",", Dipole",", off-centre loaded","SHORTANT"
    "ANTENNA",", Dipole",", off-centre fed, 3-band trapless","OCFDIPOL"
    "ANTENNA",", Dipole",", centre-loaded","CENTLOAD"
    "ANTENNA",", Dipole",", multiband for restricted space","SHORTDIP"
    "ANTENNA",", Dipole",", shortened, for 160/80/40 m.","DIPOL160"
    "ANTENNA",", Discone","","DISCONE"
    "ANTENNA",", Dual Band Short Dipole","","DUOPOLE"
    "ANTENNA",", Dual band",", dipole or monopole","TRAPOLE"
    "ANTENNA",", Element size & length","","ANTENNA"
    "ANTENNA",", Fishbone","","FISHBONE"
    "ANTENNA",", Folded dipole",", 300Í twin-lead","FOLDIPOL"
    "ANTENNA",", G5RV multiband dipole","","G5RV"
    "ANTENNA",", Hairpin beta-match","","HAIRPIN"
    "ANTENNA",", Half-loop","","HALFLOOP"
    "ANTENNA",", Helical",", VHF/UHF","HELANT"
    "ANTENNA",", Inverted vee","","INVEE"
    "ANTENNA",", J-pole","","JAYPOLE"
    "ANTENNA",", Ladder line","","LADANT"
    "ANTENNA",", Length & pruning calculator","","ANTENNA"
    "ANTENNA",", Log-periodic Yagi","","LOGYAG"
    "ANTENNA",", Loop",", inductance calculator","LOOPANT"
    "ANTENNA",", Loop",", transmitting","LOOPXMIT"
    "ANTENNA",", Loop skywire","","LOOPSKY"
    "ANTENNA",", Miniature loop","","MINILOOP"
    "ANTENNA",", Mobile/maritime whip","","MOWHIP"
    "ANTENNA",", Monopole, very short HF","","MICROVER"
    "ANTENNA",", Moxon Rectangle","","MOXON"
    "ANTENNA",", Multi-band Zepp","","ZEPP"
    "ANTENNA",", N.V.I.S. Quad","","QUAD"
    "ANTENNA",", Parabolic dish reflector","","DISHANT"
    "ANTENNA",", Phased vertical array","","VERTPATT"
    "ANTENNA",", Physical length vs. frequency/wavelength","","ANTENNA"
    "ANTENNA",", Pruning calculator","","ANTENNA"
    "ANTENNA",", Quad",", coil-shortened for restricted space","MINIQUAD"
    "ANTENNA",", Quad design","","QUAD"
    "ANTENNA",", SWR at feed point","","LINELOSS"
    "ANTENNA",", Single wire","","SNGLWIRE"
    "ANTENNA",", Sloper","","SLOPER"
    "ANTENNA",", Stub match","","STUBANT"
    "ANTENNA",", Subminiature loop","","OCTALOOP"
    "ANTENNA",", T match for 600 Í line","","TMATCH"
    "ANTENNA",", Toroid traps","","TOROTRAP"
    "ANTENNA",", Trap",", dipole or monopole","TRAPOLE"
    "ANTENNA",", Tri-band",", no traps or loading coils","OCFDIPOL"
    "ANTENNA",", Vertical",", dual band trap","TRAPOLE"
    "ANTENNA",", Vertical",", helically wound","HELVERT"
    "ANTENNA",", Vertical",", with capacity hat","CAPYHAT"
    "ANTENNA",", Vertical array",", feed method","VARAYFED"
    "ANTENNA",", Whip","","MOWHIP"
    "ANTENNA",", Windom","","WINDOM"
    "ANTENNA",", Yagi",", extremely long","YAGILONG"
    "ANTENNA",", Yagi",", element spacing","YAGISPAC"
    "ANTENNA",", Yagi 3-element beam","","YAGI3EL"
    "ANTENNA",", Zepp",", double extended","ZEPPDBL"
    "ANTENNA",", dual band trap","","TRAPOLE"
    "ARCH CALCULATOR","","","ARCH"
    "ASCII CHARACTERS",", Code Page 437","","PAGE437"
    "ATMOSPHERIC PRESSURE","","","BAROMTR"
    "ATTENUATION",", due to SWR","","SWR"
    "ATTENUATORS",", T-Pad and Pi-Pad","","ATTENPAD"
    "AUDIO FILTER",", Op Amp","","AUDFILT"
    "AUDIO FILTER",", band-pass","","AUDFILT"
    "AUDIO FILTER",", low-pass",", Sallen & Key","LOPASS"
    "AUDIO FILTER",", passive","","AUDPASS"
    "AUDIO OSCILLATOR (TWIN-T)","","","TWINTEE"
    "AUDIO OSCILLATOR",", LM 324","","AUDOSC"
    "AUDIO OSCILLATOR",", code prectice",", 555 CMOSC timer","PRACOSC"
    "AUDIO OSCILLATOR",", dual tone","","AUDOSC2"
    "AUDIO TONES","","","ZOUNDS"
    "AUTEK Z METER",", conversion of readings","","AUTEK2"
    "B.& W. INDUCTORS","","","AIRCORE"
    "BALUN",", coaxial cable","","SERISECT"
    "BALUN",", ferrite toroidal","","BROADFER"
    "BAND-REJECT FILTER","","","BANDSTOP"
    "BANDPASS FILTER",", audio op amp","","AUDFILT"
    "BANDWIDTH VS. Q","","","BANDQ"
    "BANDWIDTHS",", 2:1 SWR","","BANDWDTH"
    "BAROMETER",", equivalent readings","","BAROMTR"
    "BATTERY PACK",", Ni-Cad",", discharger","NICAD"
    "BATTERY SCHEDULE","","","BATTERY"
    "BEAM ANTENNAS",", turning radius","","TURNRAD"
    "BEAM ELEMENT DIA. VS LENGTH","","","DIALGTH"
    "BEAM HEADING CALCULATOR","","","PATHFIND"
    "BEAMS",", properties of","","MECHMENU"
    "BELLOWS",", photographic","","FOTOMENU"
    "BELT DRIVES","","","MECHMENU"
    "BEND ALLOWANCE",", metals","","BEND"
    "BETA-MATCH",", hairpin",", for Yagi antenna","HAIRPIN"
    "BEVERAGE ANTENNA EQUATIONS","","","BEVANT"
    "BINARY NUMBERS","","","BINARY"
    "BINS",", round or square","","BINHOP"
    "BINS",", side or center draw hopper","","BINHOP"
    "BOBTAIL CURTAIN ANTENNA","","","BOBTAIL"
    "BOOM DROOP",", beam antennas","","BOOM"
    "BREAK-IN MODULE","","","QSK"
    "BREAKDOWN VOLTAGE","","","SPARK"
    "BREWSTER ANGLE","","","PBA"
    "BRIDGE (WHEATSTONE #1)",", Calculator","","BRIDGE"
    "BRIDGE",", impedance,",", 3-meter","3MBRIDGE"
    "BUTTERWORTH FILTER",", low-pass audio","","LOPASS"
    "BUTTERWORTH FILTERS",", HF","","BUTTFILT"
    "C/R/L/ NETWORK SOLVER","","","LADRSOLV"
    "C/R/L/CIRCUITS","","","DSGNMENU"
    "CALENDAR",", perpetual","","CALTODAY"
    "CALORIE COUNTER","","","CALORY"
    "CAPACITANCE",", distributed (stray)","","CAPSTRAY"
    "CAPACITANCE",", in A.C. circuits","","ACCALC"
    "CAPACITANCE",", self",", in coils","COILTRUE"
    "CAPACITOR MEASURER","","","CAPVAL"
    "CAPACITORS",", custom value",", parallel ganged","CUSTCAP"
    "CAPACITORS",", design calculator","","CAPTANCE"
    "CAPACITORS",", homebrew","","CAPTANCE"
    "CAPACITORS",", in series and parallel","","SERIPARA"
    "CAPACITORS",", precise values","","PRECICAP"
    "CAPACITORS",", precision",", made from coaxial cable","CAPCOAX"
    "CAPACITORS",", standard values","","CAPACVAL"
    "CAPACITORS",", telescoping variable","","CAPYTEL"
    "CAPACITORS",", trimmer","","CAPTRIM"
    "CAPACITORS",", variable",", plate shape designer","VACAP"
    "CAPACITY HATS",", for vertical antennas","","CAPYHAT"
    "CAPACITY HATS",", geometric shapes","","HATSHAPE"
    "CARTESIAN/POLAR PLOT ROTATOR","","","ROTAPLOT"
    "CASCADED OP AMPS","","","CASCAMP"
    "CATENARY SAG",", horizontal wire","","CATENARY"
    "CCD ANTENNAS",", (controlled current distribution)","","CCDANTEN"
    "CENTRE FREQUENCIES",", ham bands","","HAMBANDS"
    "CENTRE FREQUENCY & WAVELENGTH","","","CENTFREQ"
    "CENTRIFUGAL/CENTRIPETAL FORCE","","","CENTRIF"
    "CHAIN DRIVES","","","MECHMENU"
    "CHEBYSHEV FILTER",", low-pass audio","","LOPASS"
    "CHOKES, RF",", coaxial cable","","CHOKBAL"
    "CIRCLE",", involute of","","INVOLUTE"
    "CIRCLE",", properties of","","PROPCIRC"
    "CIRCULAR WAVEGUIDE DISH FEEDS","","","CIRCFEED"
    "CLAMPING VOLTAGE CALCULATOR","","","CLAMP"
    "CLARK Y AIRFOIL","","","CLARKY"
    "CLOCK HOURS",", display",", conversion from decimal hours","HOURS"
    "CLOCK TIMES",", Quiz","","TIMEQ"
    "CLOCK",", (screen saver)","","LOGOCLOK"
    "CMOS OSCILLATOR","","","CMOSC3"
    "COAXIAL CABLE CAPACITORS","","","CAPCOAX"
    "COAXIAL CABLE CHARACTERISTICS","","","COAXCHAR"
    "COAXIAL CABLE FAULT LOCATOR","","","COAXCHAR"
    "COAXIAL CABLE MATCHING TRANSFORMER",", Series-Section","","SERISECT"
    "COAXIAL CABLE RF CHOKES",", RF chokes","","CHOKBAL"
    "COAXIAL CABLE STUBS","","","COAXSTUB"
    "COAXIAL CABLE SUPERTRAP",", hi-reactance","","BUXTRAP"
    "COAXIAL CABLE TRAPS",", for antennas","","COAXTRAP"
    "CODE PAGE 437",", ASCII characters","","PAGE437"
    "CODE PRACTICE OSCILLATOR","","","PRACOSC"
    "CODE TRAINER",", (CW)","","CW"
    "COIL FORMS",", from plastic pipe","","COILDSGN"
    "COIL FORMS",", miniature","","\HAMCALC\PROG\TINYCOIL"
    "COIL Q CALCULATOR","","","COILQ"
    "COIL Q QUICK ESTIMATOR","","","COILQUIK"
    "COIL Q",", True vs. Apparent","","COILTRUE"
    "COIL SELF-CAPACITANCE","","","COILTRUE"
    "COIL TAP CALCULATOR","","","COILNEW"
    "COIL TURNS CALCULATOR","","","TURNS"
    "COILS",", Insulated wire","","COILIN"
    "COILS",", close-wound",", equation calculator","COILEQUA"
    "COILS",", close-wound",", design of","COILDSGN"
    "COILS",", coaxially coupled","","COILCPL"
    "COILS",", commercial",", (Barker & Williamson)","AIRCORE"
    "COILS",", helical winding calculator","","HELIX"
    "COILS",", in L/C tuned circuits","","TUNECCT"
    "COILS",", in tandem","","COILNEW"
    "COILS",", made from dryer vent hose","","INDUHOSE"
    "COILS",", mobile whip","","COILAMP"
    "COILS",", shielded","","HELRESON"
    "COILS",", tapped",", properties","COILTAP"
    "COILS",", tapped",", feedline matching","SNGLWIRE"
    "COILS",", tapped","","COILNEW"
    "COILS",", wound on Nylon screws","","TINYCOIL"
    "COLOUR CODES",", resistors","","COLCODE"
    "COLPITTS FET OSCILLATOR","","","COLPOSC"
    "COMPLEMENTARY FILTERS","","","COMFILT"
    "COMPLEX IMPEDANCES",", J calculator","","JCALC"
    "COMPOUND INTEREST CALCULATOR","","","FINANCE"
    "CONDUIT",", wire capacity","","WIRECOND"
    "CONE CALCULATOR","","","CONECALC"
    "CONJUGATE MATCH CALCULATOR","","","CONJUMAT"
    "CONSTANT CURRENT OP AMP","","","CONCUR"
    "CONSTANT PHASE DIFFERENCE NETWORKS","","","PHAZDIFF"
    "CONVERSION",", between different units of same value","","EQUIV"
    "CONVERSION",", fraction to decimal",", decimal to fraction","DECIFRAC"
    "CONVERSION",", frequencies/wavelengths","","EQUIV"
    "CONVERSION",", metric to Imperial",", Imperial to metric","METRICS"
    "CONVERSION",", units of distance","","EQUIV"
    "CONVERSION",", units of time","","EQUIV"
    "COPPER WIRE TABLES","","","COPWIRE"
    "COST OF ELECTRICITY","","","ELECOST"
    "COUPLED RESONATOR","","","CPLRES"
    "COUPLING",", Pi-network","","PIMATCH"
    "COUPLING",", transistor stages",", transmitters","XMTRZMAT"
    "CROSSOVER NETWORKS",", loudspeakers","","XOVER"
    "CRYSTAL LADDER FILTERS","","","CRYSFILT"
    "CURRENT CAPACITY",", copper wire","","COPWIRE"
    "CURRENT CAPACITY",", transformers","","WINDING"
    "CURRENT",", dB gain/loss","","DECIBEL"
    "CURVE FIT PROGRAM","","","CURVEFIT"
    "CW PROGRAMS",", (Morse code)","","CW"
    "CYLINDER-LOADED DIPOLE","","","CYLLOAD"
    "CYLINDERS",", air & hydraulic","","MECHMENU"
    "CYLOAD ANTENNA","","","CYLLOAD"
    "DAYLIGHT DUSK & DAWN","","","DAYDUSK"
    "DAYS BETWEEN DATES","","","CALTODAY"
    "DAYS-BETWEEN-DATES CALCULATOR","","","FINANCE"
    "DECIBEL",", power, voltage and current gain/loss calculator","","DECIBEL"
    "DECIMAL VALUES",", convert to fractions","","DECIFRAC"
    "DECIMAL/SEXIGESIMAL CONVERSION","","","DECICONV"
    "DEGREES/MINUTES/SECONDS ","","","EQUIV"
    "DEHONEY ALGORITHMS",", Program index","","RJD"
    "DELTA MATCH","","","DELTAMAT"
    "DEPRECIATION SCHEDULE CALCULATOR","","","FINANCE"
    "DERIVATIVES OF NUMBERS","","","NUMDERIV"
    "DIAMETER FINDER","","","DIAMFIND"
    "DIELECTRIC CONSTANTS","","","DIELECT"
    "DIELECTRIC MATERIAL",", capacitors","","CAPTANCE"
    "DIELECTRIC MATERIAL",", coaxial cables","","COAXCHAR"
    "DIGITAL CAMERAS & SCANNERS","","","PIXEL"
    "DIGITAL CLOCK","","","BIGNUM"
    "DIMENSIONS",", decimal/fractional","","DECIFRAC"
    "DIPOLE",", short",", 160/80/40 metres","DIPOL160"
    "DISCHARGER",", Ni-Cad batteries","","NICAD"
    "DISCONE ANTENNA","","","DISCONE"
    "DISH",", parabolic reflector","","DISHANT"
    "DISTANCE",", as a function of speed and time","","SPEEDTD"
    "DISTANCE",", between locations","","PATHFIND"
    "DISTRIBUTED CAPACITANCE","","","CAPSTRAY"
    "DOUBLE FEEDBACK AMPLIFIER","","","DBLFB"
    "DRILL SIZES","","","NMBRSIZE"
    "DRIVES",", belt","","\HAMCALC\MECHCALC\MECHMENU"
    "DRIVES",", chain","","\HAMCALC\MECHCALC\MECHMENU"
    "DROOP",", boom",", beam antennas","BOOM"
    "DRYER VENT HOSE INDUCTORS","","","INDUHOSE"
    "DUAL OP AMP WAVE GENERATOR","","","TRISQU"
    "ELECTICAL VS. PHYSICAL LENGTH","","","EQUIV"
    "ELECTRICAL LENGTH",", transmission line","","ELECLENG"
    "ELECTRICITY COST","","","ELECOST"
    "ELECTROMAGNETIC SPECTRUM","","","ELSPEC"
    "ELECTRONIC FLASH","","","\HAMCALC\PROG\FOTOMENU"
    "ELECTRONIC KEYBOARD","","","ZOUNDS"
    "ELEMENT SPACING",", Yagi antennas",", NBS standard","YAGISPAC"
    "EQUATION",", quadratic","","QUADRAT"
    "EQUATIONS",", frequently used formulas","","FORMULAE"
    "EQUINOXES","","","SEASONS"
    "EQUIVALENT UNITS",", of same value","","EQUIV"
    "EQUIVALENTS",", series/parallel/Q units","","SEPAG"
    "ES2B 2 BAND TRAP DIPOLE","","","ES2B"
    "EXPOSURE CALCULATOR",", photographic","","\HAMCALC\FOTOCALC\FOTOMENU"
    "EXTENSION RINGS AND BELLOWS",", photographic","","\HAMCALC\FOTOCALC\FOTOMENU"
    "FAT DIPOLE",", broadbanded","","FATDIPOL"
    "FIBONACCI SERIES","","","FIBON"
    "FIELD STRENGTH",", antennas","","ANTFIELD"
    "FILTER COILS",", shielded","","HELRESON"
    "FILTER TUTOR","","","FILTUT"
    "FILTERS",", Butterworth",", HF low-pass, high-pass & band-pass","BUTTFILT"
    "FILTERS",", L/C networks",", with no transformers","TFORM3"
    "FILTERS",", Pi and T Networks","","PITNET"
    "FILTERS",", RC active","","RCFILT"
    "FILTERS",", active low-pass",", Sallen & Key","LOPASS"
    "FILTERS",", audio",", Butterworth/Chebyshev/elliptic","AUDPASS"
    "FILTERS",", bandpass",", Op Amp","AUDFILT"
    "FILTERS",", complementary","","COMFILT"
    "FILTERS",", coupled resonator","","CPLRES"
    "FILTERS",", crystal ladder","","CRYSFILT"
    "FILTERS",", helical resonator","","HELRESON"
    "FILTERS",", impedance matching","","MATFILT"
    "FILTERS",", insertion loss","","INLOSS"
    "FILTERS",", passive",", R/L/C","FILTRLC"
    "FILTERS",", passive",", band-reject","BANDSTOP"
    "FILTERS",", photographic","","\HAMCALC\PROG\FOTOMENU"
    "FILTERS",", stripline bandpass",", for VHF/UHF","FILSTRIP"
    "FILTERS",", wave trap","","WAVETRAP"
    "FINANCIAL CALCULATORS","","","FINANCE"
    "FISHBONE ANTENNA","","","FISHBONE"
    "FIT CURVE PROGRAM","","","CURVEFIT"
    "FOCUS CALCULATOR",", photographic","","\HAMCALC\FOTOCALC\FOTOMENU"
    "FOLDED DIPOLE",", 300Í twin-lead","","FOLDIPOL"
    "FOLDED DIPOLE",", impedance step-up ratios","","ZOSTEPUP"
    "FOLDED DIPOLE",", terminated","","T2FD"
    "FORMULA LIBRARY",", frequently used equations","","FORMULAE"
    "FOX HUNT LOG",", QRP","","FOXLOG"
    "FRACTIONS",", convert to decimal values","","DECIFRAC"
    "FREQUENCIES",", amateur bands","","HAMBANDS"
    "FREQUENCIES",", audio","","ZOUNDS"
    "FREQUENCIES",", harmonic","","HARMONIC"
    "FREQUENCY",", centre","","CENTFREQ"
    "FREQUENCY",", convert to wavelength","","EQUIV"
    "FREQUENCY",", in A.C. circuits","","ACCALC"
    "FRETS",", stringed instruments","","ZOUNDS"
    "FUNCTIONS OF NUMBERS","","","NUMDERIV"
    "FUSES",", emergency","","FUSEWIRE"
    "G FORCE","","","ACCELR"
    "G5RV MULTIBAND DIPOLE ANTENNA","","","G5RV"
    "GAIN",", Op Amps","","OPAMP"
    "GAMMA MATCH","","","GAMMATCH"
    "GAUGES OF SHEET METAL","","","NMBRSIZE"
    "GEARS AND GEARING","","","MECHMENU"
    "GRAPHS",", graph generator","","GRAPHS"
    "GREAT CIRCLE CALCULATOR","","","PATHFIND"
    "GRID SQUARE LOCATOR",", Maidenhead squares","","GRIDSQ"
    "GUITAR FRETS","","","ZOUNDS"
    "GUITAR TUNER","","","ZOUNDS"
    "GUY WIRES",", for antenna towers and masts","","GUYWIRES"
    "HAIRPIN MATCH",", beta-match",", Yagi Antenna","HAIRPIN"
    "HALF-LOOP ANTENNA","","","HALFLOOP"
    "HAM BAND EDGE & CENTRE FREQUENCIES","","","HAMBANDS"
    "HARD DRIVE",", copy HAMCALC to","","HCINSTAL"
    "HARMONIC FREQUENCIES","","","HARMONIC"
    "HARMONICS",", affecting television channels","","TVCHAN"
    "HARTLY FET OSCILLATOR","","","HARTOSC"
    "HEARING TEST","","","ZOUNDS"
    "HEAT SINK FINS",", thermal resistance","","SINK"
    "HEAT SINKS",", thermal resistance","","THERMRES"
    "HELICAL ANTENNA",", VHF/UHF","","HELANT"
    "HELICAL RESONATORS",", shielded",", networks & filters","HELRESON"
    "HELICAL WINDINGS","","","HELIX"
    "HELICALLY WOUND VERTICAL ANTENNA","","","HELVERT"
    "HESAT DISSIPATION",", metal boxes","","HOTBOX"
    "HIGH Q ANTENNA TRAPS","","","QTRAP"
    "HOPPERED BINS AND RANKS","","","BINHOP"
    "HORIZON",", radio","","RADIOLOS"
    "HORSEPOWER",", vs. torque","","MECHMENU"
    "HOURS",", conversion",", decimal to clock display","DECICONV"
    "HUMIDEX CALCULATOR","","","HUMID"
    "HYDRAULIC CYLINDERS","","","MECHMENU"
    "IMPEDANCE BRIDGE",", (3-meter)","","3MBRIDGE"
    "IMPEDANCE BRIDGE",", using a transmatch","","TRANSMAT"
    "IMPEDANCE CALCULATOR",", Complex Impedances","","JCALC"
    "IMPEDANCE MATCHBOX","","","MATCHBOX"
    "IMPEDANCE MATCHING NETWORKS","","","IMPEDNET"
    "IMPEDANCE MATCHING",", L-pad","","L-PAD"
    "IMPEDANCE MATCHING",", PI-Network","","PIMATCH"
    "IMPEDANCE MATCHING",", conjugate","","CONJUMAT"
    "IMPEDANCE MATCHING",", transformers","","XFMR"
    "IMPEDANCE MATCHING",", transistor stages","","MATCHNET"
    "IMPEDANCE MATCHING",", transmitter stages","","XMTRZMAT"
    "IMPEDANCE METER","","","IMPEDMETR"
    "IMPEDANCE STEP-UP RATIOS",", folded dipoles","","ZOSTEPUP"
    "IMPEDANCE",", R/C, R/L, L/C, R/L/C circuits","","DSGNMENU"
    "IMPEDANCE",", antennas",", measured from transmission line","ANTIMP"
    "IMPEDANCE",", coaxial cable","","COAXCHAR"
    "IMPEDANCE",", impedance matchbox","","MATCHBOX"
    "IMPEDANCE",", in A.C. circuits","","ACCALC"
    "IMPEDANCE",", open-wire transmission line","","OPENWIRE"
    "IMPEDANCE",", parallel-resonant circuit","","IMPARES"
    "IMPEDANCE",", reactance/resistance circuits","","IMPEDCCT"
    "IMPEDANCE",", transmission lines","","SWR"
    "INCHES-PER-VOLT",", transformer windings","","WINDING"
    "INDUCTANCE CALCULATOR","","","INDUCALC"
    "INDUCTANCE",", coils",", single layer","INDUCALC"
    "INDUCTANCE",", coils",", multi layer","INDUCALC"
    "INDUCTANCE",", coils in tandem","","COILCPL"
    "INDUCTANCE",", flat copper strip","","INDUCALC"
    "INDUCTANCE",", in A.C. circuits","","ACCALC"
    "INDUCTANCE",", loop antenna","","LOOPANT"
    "INDUCTANCE",", of a coil","","TUNECCT"
    "INDUCTANCE",", single loops","","INDULOOP"
    "INDUCTANCE",", straight copper wire","","INDUCALC"
    "INDUCTANCE",", tapped coils","","COILTAP"
    "INDUCTANCE",", transmission line section","","INDUCALC"
    "INDUCTORS",", L/C tuned circuits","","TUNECCT"
    "INDUCTORS",", commercial",", (Barker & Williamson)","AIRCORE"
    "INDUCTORS",", helical winding","","HELIX"
    "INDUCTORS",", in series and parallel","","SERIPARA"
    "INDUCTORS",", inductively loaded antennas","","SHORTANT"
    "INDUCTORS",", large value","","INDUHOSE"
    "INDUCTORS",", made from dryer vent hose","","INDUHOSE"
    "INDUCTORS",", single layer air-core",", design of","TUNECCT"
    "INDUCTORS",", toroid core","","TOROID"
    "INSERTION LOSS","","","INLOSS"
    "INSERTION LOSS",", lossless L/C circuits","","NOLOSS"
    "INSTALL HAMCALC ON A HARD DRIVE","","","CPYHCAL"
    "INTEREST RATE CALCULATORS","","","FINANCE"
    "INTERFERENCE",", television channels","","TVCHAN"
    "INVERTED VEE ANTENNA","","","INVEE"
    "INVOLUTE OF A CIRCLE","","","INVOLUTE"
    "J CALCULATOR",", complex impedances","","JCALC"
    "J-POLE",", end-fed zepp antenna","","JAYPOLE"
    "K FACTOR",", antenna",", ARRL standards","ANTENNA"
    "K-FACTOR",", antenna",", (NEC-2 model)","KFACTOR"
    "KEYBOARD",", electronic","","ZOUNDS"
    "L-PAD DESIGN","","","L-PAD"
    "L/C LOSSLESS CIRCUITS","","","NOLOSS"
    "L/C NETWORK",", tuned circuit","","TUNECCT"
    "L/C NETWORKS",", NO TRANSFORMERS","","TFORM3"
    "L/C TANK",", Coaxial cable","","COAXLC3"
    "L/C/R/ NETWORK SOLVER","","","LADRSOLV"
    "L/C/R/CIRCUITS","","","DSGNMENU"
    "LADDER LINE ANTENNA","","","LADANT"
    "LADDER LINE",", (open-wire transmission line)","","OPENWIRE"
    "LADDER MATCHING NETWORKS","","","TRANSMAT"
    "LADDER NETWORK SOLVER","","","LADRSOLV"
    "LADDER NETWORK",", 2 element","","LADDER2"
    "LADDERS",", step","","\HAMCALC\MECHCALC\MECHMENU"
    "LAMP LIFE EXPECTANCY","","","LAMPLIFE"
    "LATITUDE & LONGITUDE DATA BASE","","","LATLONG"
    "LED",", voltage dropping resistor","","LED"
    "LENSES",", photographic","","FOTOMENU"
    "LIGHT",", speed of","","ANTENNA"
    "LINE LOSS",", transmission lines","","LINELOSS"
    "LINE-OF-SIGHT RADIO WAVES","","","RADIOLOS"
    "LINK COUPLED TUNERS","","","LINKUPL"
    "LINKWITZ SPEAKER EQUALIZER","","","SPEAKR"
    "LM317 VOLTAGE REGULATOR","","","LM317"
    "LOAD RESISTANCE CALCULATOR","","","DELTLOAD"
    "LOCAL REPEATERS","","","LOCALRPT"
    "LOG-YAG YAGI ANTENNA","","","LOGYAG"
    "LOGARITHMS","","","NUMDERIV"
    "LOGGING PROGRAM",", QRP Fox Hunt","","FOXLOG"
    "LONG-TAILED PAIR","","","PAIRLT"
    "LOOP ANTENNA",", Ted Hart W5QJR","","MINILOOP"
    "LOOP ANTENNA",", inductance calculator","","LOOPANT"
    "LOOP ANTENNA",", subminiature","","OCTALOOP"
    "LOOP ANTENNAS",", transmitting","","LOOPXMIT"
    "LOOP SKYWIRE ANTENNA","","","LOOPSKY"
    "LOSSES",", in coaxial cable","","COAXCHAR"
    "LOSSES",", insertion","","INLOSS"
    "LOSSES",", mismatch","","MISMAT"
    "LOSSES",", transmission line","","LINELOSS"
    "LOSSLES L/C CIRCUTS","","","NOLOSS"
    "LOTTERY NUMBERS","","","RANDNUM"
    "LOW PASS AUDIO FILTER",", Sallen & Key","","LOPASS"
    "LPDA YAGI ANTENNA DESIGN","","","LOGYAG"
    "LUMPED CONSTANT",", dipole antennas","","SHORTANT"
    "LUMPED CONSTANT",", vertical mobile whip","","MOWHIP"
    "MACHINE SCREWS","","","NMBRSIZE"
    "MAIDENHEAD GRID SQUARES","","","GRIDSQ"
    "MARITIME WHIP ANTENNAS","","","MOWHIP"
    "MARKUP/MARKDOWN CALCULATOR","","","FINANCE"
    "MASONRY ESTIMATOR","","","BRICK"
    "MAST HEIGHT",", inverted vee antenna","","INVEE"
    "MASTS",", guy wires","","GUYWIRES"
    "MATCH",", T match for dipoles","","TMATCH"
    "MATCH",", conjugate","","CONJUMAT"
    "MATCH",", delta","","DELTAMAT"
    "MATCH",", gamma","","GAMMATCH"
    "MATCH",", stub",", for antennas","STUBANT"
    "MATCHBOX IMPEDANCE TRANSFORMER","","","MATCHBOX"
    "MATCHING NETWORKS",", Pi-section","","PIMATCH"
    "MATCHING NETWORKS",", antenna","","ANTSYN2"
    "MATCHING NETWORKS",", impedance","","IMPEDNET"
    "MATCHING NETWORKS",", transistors","","MATCHNET"
    "MATCHING NETWORKS",", transmitter","","XMTRZMAT"
    "MATCHING NETWORKS",", with no tranformers","","TFORM3"
    "MATCHING STUBS",", antenna","","STUBANT"
    "MATCHING STUBS",", coaxial line","","COAXSTUB"
    "MATCHING STUBS",", open-wire line","","TRANSTUB"
    "MATCHING TRANSFORMER",", broadband toroidal","","BROADFER"
    "MATCHING TRANSFORMER",", narrow band","","XFMRNARO"
    "MATCHING TRANSFORMER",", series-section","","SERISECT"
    "MATCHING",", impedance",", L-pad","L-PAD"
    "MATCHING",", impedance",", Pi-network","PIMATCH"
    "MATCHING",", mobile antennas","","MOBILMAT"
    "MATHEMATICS",", of a circle","","PROPCIRC"
    "MAXIMUM USABLE FREQUENCIES",", (MUF)","","MAXUF"
    "MECHANICS MATH","","","\HAMCALC\PROG\MECHMENU"
    "METALS",", resistivity of","","RESISTIV"
    "METEOR SHOWER PREDICTOR","","","METSHOWR"
    "METER SHUNTS & MULTIPLIERS","","","METERS"
    "METRIC CONVERSIONS","","","METRICS"
    "METRONME","","","METNOM"
    "MICROVERT",", very short HF anntenna","","MICROVER"
    "MINILOOP",", miniature loop antenna","","MINILOOP"
    "MINIQUAD",", coil-shortened Quad antenna","","MINIQUAD"
    "MISMATCH",", transmission lines","","MISMAT"
    "MOBILE ANTENNA MATCHING",", L-network","","MOBILMAT"
    "MOBILE WHIP ANTENNA COILS","","","COILAMP"
    "MOBILE WHIP ANTENNA",", design of","","MOWHIP"
    "MOON TRACKER","","","MOONTRAC"
    "MORSE CODE TRAINER","","","CW"
    "MORTGAGE CALCULATOR","","","FINANCE"
    "MOTION CALCULATOR",", photographic","","\HAMCALC\FOTOCALC\FOTOMENU"
    "MOXON RECTANGLE ANTENNA","","","MOXON"
    "MULTI-VIBRATORS",", astable & free-running","","555TIMER"
    "MULTIBAND SHORT DIPOLES","","","SHORTDIP"
    "MUSIC",", math & sounds","","ZOUNDS"
    "N.V.I.S. QUAD ANTENNA","","","QUAD"
    "NARROW-BAND TRANSFORMER","","","XFMRNARO"
    "NETWORK SOLVER",", ladder networks","","LADRSOLV"
    "NETWORKS",", antenna matching","","ANTSYN2"
    "NETWORKS",", impedance matching",", Pi-network","PITNET"
    "NETWORKS",", impedance matching",", L-pad","L-PAD"
    "NETWORKS",", transistor matching","","MATCHNET"
    "NI-CAD BATTERY DISCHARGER","","","NICAD"
    "NODE LOCATER",", Transmission line","","NODE"
    "NOISE FIGURE",", Op Amps","","NOISFIG"
    "NORTH",", determined by noon sun","","TRUNORTH"
    "NUMBER SORTER","","","SORTER"
    "NUMBERED DRILLS / SCREWS / GAUGES","","","NMBRSIZE"
    "NUMBERS & FUNCTIONS","","","NUMDERIV"
    "NUMBERS",", Random generator","","RANDNUM"
    "NYLON SCREWS",", as coil forms","","TINYCOIL"
    "OCTAGONAL LOOP FRAMEWORK","","","OCTAGON"
    "OCTALOOP",", subminiature loop antenna","","OCTALOOP"
    "OCTARING",", subminiature loop antenna","","OCTARING"
    "OFF-CENTRE-FED DIPOLE","","","OCFDIPOL"
    "OHM'S LAW","","","OHMSLAW"
    "OP AMP AUDIO FILTER",", (#741 Op Amp)","","AUDFILT"
    "OP AMP",",  Sqare & Triangle Wave Generator","","TRISQU"
    "OP AMP",", Constant current circuit","","CONCUR"
    "OP AMP",", Schmidt trigger","","SCHMIDT"
    "OP AMPS ",", Noise Figure","","NOISFIG"
    "OP AMPS",", Cascaded",",  ","CASCAMP"
    "OPEN-WIRE TRANSMISSION LINE","","","OPENWIRE"
    "OPERATIONAL ( OP AMP ) AMPLIFIERS","","","OPAMP"
    "ORBIT CALCULATOR",", satellite","","SATORBIT"
    "OSCILLATOR",", CMOS","","CMOSC3"
    "OSCILLATOR",", Colpitts FET","","COLPOSC"
    "OSCILLATOR",", Hartly FET","","HARTOSC"
    "OSCILLATOR",", Schmidt","","PULSEGEN"
    "OSCILLATOR",", audio",", Twin-T","TWINTEE"
    "OSCILLATOR",", audio, LM324","","AUDOSC"
    "OSCILLATOR",", audio, dual tone","","AUDOSC2"
    "OSCILLATOR",", code practice","","PRACOSC"
    "PARABOLIC ANTENNA",", circular waveguide feeds","","CIRCFEED"
    "PARABOLIC DISH REFLECTOR","","","DISHANT"
    "PARALLEL-RESONANT CIRCUIT",", impedance","","IMPARES"
    "PC BOARD TRACES","","","COPWIRE"
    "PEDOMETER","","","PEDOM"
    "PHASE ANGLE",", R/C, R/L, L/C, R/L/C circuits","","DSGNMENU"
    "PHASE ANGLE",", in A.C. circuits","","ACCALC"
    "PHASE DIFFERENCE NETWORKS","","","PHAZDIFF"
    "PHASED VERTICAL ARRAY",", radiation pattern","","VERTPATT"
    "PHOTOCOPIER",", image size calculator","","FOTOMENU"
    "PHOTOGRAPHY MATH","","","\HAMCALC\PROG\FOTOMENU"
    "PI-NETWORK",", impedance matching","","PITNET"
    "PI-PAD ATTENUATORS","","","ATTENPAD"
    "PIPE SIZES",", ANSI Standard","","PIPESIZE"
    "PIXEL CALCULATOR",", digital cameras & scanners","","PIXEL"
    "PLOT ROTATOR",", cartesian/polar","","ROTAPLOT"
    "POLYGON DIMENSIONS","","","POLYGON"
    "POTENTIOMETER",", custom value","","POTENT"
    "POWER AMPLIFIER",", tank circuit","","TANKCCT"
    "POWER DIVIDER","","","PWRDIV"
    "POWER FACTOR",", in A.C. circuits","","ACCALC"
    "POWER SUPPLY ANALYZER","","","PSUP"
    "POWER SUPPLY DESIGN","","","PWRCCT"
    "POWER SUPPLY PERFORMANCE","","","PSUPERF"
    "POWER SUPPLY",", double bridge","","DBLBRG4"
    "POWER SUPPLY",", dual output","","DBLBRG4"
    "POWER TRANSFORMER DESIGN","","","PWRXFMR"
    "POWER VS. S-METER READINGS","","","SMETER"
    "POWER",", dB gain/loss","","DECIBEL"
    "POWER",", watts",", (Ohm's Law)","OHMSLAW"
    "PRIME NUMBERS","","","PRIMENOS"
    "PRINTED CIRCUIT BOARD TRACES","","","\HAMCALC\PROG\COPWIRE"
    "PROPERTIES OF BEAMS","","","MECHMENU"
    "PRUNING",", antenna","","ANTENNA"
    "PSEUDO-BREWSTER ANGLE","","","PBA"
    "PULSE GENERATOR","","","PULSEGEN"
    "PUNCTURE VOLTAGE",", dielectric materials","","CAPTANCE"
    "Q CALCULATOR",", coils","","COILQ"
    "Q FACTOR OF L/C COMPONENTS","","","QFACTOR"
    "Q VS. BANDWIDTH","","","BANDQ"
    "Q",", L/C networks","","TUNECCT"
    "Q",", L/C tank circuit","","QFIND5"
    "Q",", coils",", True vs. Apparent","COILTRUE"
    "Q",", insertion loss","","INLOSS"
    "Q",", resonant circuits","","QRESON"
    "Q",", series and parallel circuits","","SEPAQ"
    "Q",", transmission lines","","QLINE2"
    "QRP FOX HUNT LOG","","","FOXLOG"
    "QSK BREAK-IN MODULE","","","QSK"
    "QUAD ANTENNA DIMENSIONS","","","QUAD"
    "QUAD ANTENNA FOR RESTRICTED SPACE","","","MINIQUAD"
    "QUADRATIC EQUATIONS","","","QUADRAT"
    "QUARTER-WAVE TRANSFORMER","","","QUARTWAV"
    "QUIKTABLES","","","QUIKTABL"
    "R/C TIME CONSTANT","","","RCCONST"
    "R/L/C CIRCUITS","","","DSGNMENU"
    "R/L/C NETWORK SOLVER","","","LADRSOLV"
    "RADAR SCREEN",", local repeaters","","LOCALRPT"
    "RADIATION ANGLE",", Antennas","","RADANGLE"
    "RADIATION PLOTS",", phased vertical antennas","","VERTPATT"
    "RADIO HORIZON","","","RADIOLOS"
    "RANDOM NUMBER GENERATOR","","","RANDNUM"
    "RANDOM WIRE ANTENNA","","","SNGLWIRE"
    "RATIOS",", transformer windings","","XFMR"
    "RC ACTIVE FILTERS","","","RCFILT"
    "REACTANCE PROGRAMS","","","REACT"
    "REACTANCE",", in A.C. circuits","","ACCALC"
    "REACTANCES",", unlike",", in series or parallel","SERIPARA"
    "REACTIVE IMPEDANCE","","","IMPEDCCT"
    "REFLECTOR",", parabolic","","DISHANT"
    "REFLECTORS",", wire mesh","","WIREMESH"
    "REMOTE SIGNAL LAMP","","","REMSIG"
    "REPEATERS",", directory and locator","","LOCALRPT"
    "RESISTANCE",", copper wire","","COPWIRE"
    "RESISTANCE",", load",", calculator","DELTLOAD"
    "RESISTIVE IMPEDANCE","","","IMPEDCCT"
    "RESISTIVITY OF METALS","","","RESISTIV"
    "RESISTOR/INDUCTOR/CAPACITOR CIRCUITS","","","DSGNMENU"
    "RESISTORS",", colour codes","","COLCODE"
    "RESISTORS",", copper wire wound",", low value","RESICOP"
    "RESISTORS",", custom value",", parallel ganged","CUSTOHM"
    "RESISTORS",", in series and parallel","","SERIPARA"
    "RESISTORS",", precise values","","PRECIRES"
    "RESISTORS",", standard values","","RESISVAL"
    "RESONATOR",", helical","","HELRESON"
    "RF CHOKES",", coaxial cable","","CHOBAL6"
    "RF RESISTANCE",", copper wire","","COPWIRE"
    "S-METER READINGS VS. POWER","","","SMETER"
    "SAG",", in horizontally suspended wire","","CATENARY"
    "SATELLITE ORBIT CALCULATOR","","","SATORBIT"
    "SCALE SPEED CALCULATOR","","","SCALSPD"
    "SCALING",", antenna dimensions","","ANTSCALE"
    "SCANNER PIXEL CALCULATOR","","","PIXEL"
    "SCHMIDT TRIGGER OP AMP","","","SCHMIDT"
    "SCREEN SAVER",", (analog clock)","","LOGOCLOK"
    "SCREEN SAVER",", (digital clock)","","BIGNUM"
    "SCREEN SAVER",", (shuttle)","","SHUTTLE"
    "SCREEN SAVER",", (walker)","","WALKER"
    "SCREENING",", wire mesh","","WIREMESH"
    "SCREW SIZES","","","NMBRSIZE"
    "SEASONS","","","SEASONS"
    "SERIES & PARALLEL COMPONENTS","","","SERIPARA"
    "SERIES-SECTION MATCHING TRANSFORMER","","","SERISECT"
    "SEXIGESIMAL/DECIMAL CONVERSION","","","DECICONV"
    "SHAFTS AND SHAFTING","","","MECHMENU"
    "SHEET METAL GAUGES","","","NMBRSIZE"
    "SHORT DIPOLE",", ES2B 2 band","","ES2B"
    "SHORT DIPOLE",", centre coil-loaded","","CENTLOAD"
    "SHORT DIPOLE",", cylinder end-loaded","","CYLLOAD"
    "SHORT DIPOLE",", dual band","","DUOPOLE"
    "SHORT DIPOLE",", for 160/80/40 metres","","DIPOL160"
    "SHORT DIPOLE",", off-centre coil loaded","","SHORTANT"
    "SHORT HF MONOPOLE",", vertical or horizontal","","MICROVER"
    "SHORT MULTIBAND DIPOLE ARRAY","","","SHORTDIP"
    "SHUNTS",", meter","","METERS"
    "SIDETONE GENERATOR","","","CW"
    "SIGNAL LAMP",", remote","","REMSIG"
    "SIMULTANEOUS EQUATION CALCULATOR","","","SIMULEQ"
    "SINGLE WIRE ANTENNA SYSTEM","","","SNGLWIRE"
    "SKIN EFFECT","","","COPWIRE"
    "SKIP DISTANCE CALCULATOR","","","SKIPDIST"
    "SLOPER ANTENNA","","","SLOPER"
    "SMITH CHART CALCULATIONS","","","SMITHCHT"
    "SOLSTICES","","","SEASONS"
    "SORTER",", alphanumeric characters","","SORTER"
    "SPARK GAP","","","SPARK"
    "SPEAKER ANALYZER","","","SPEAKR"
    "SPEAKER CROSSOVER NETWORKS","","","XOVER"
    "SPECTRUM",", electromagnetic","","ELSPEC"
    "SPEED CHASE","","","SPEEDTD"
    "SPEED OF LIGHT","","","ANTENNA"
    "SPEED",", as a function of time and distance","","SPEEDTD"
    "SQUARE AND TRIANGLE WAVE GENERATOR","","","TRISQU"
    "SQUARE COAXIAL TRANMISSION LINE","","","SQCOAX"
    "SQUARE CONDUCTOR OPEN-WIRE LINES","","","OPENWIRE"
    "STAIRS AND STAIRWAYS","","","MECHMENU"
    "STOPWATCH","","","WATCH"
    "STRANDED COPPER CONDUCTORS","","","COPWIRE"
    "STRETCH",", in horizontally suspended wire","","WIRESAG"
    "STRIPLINE FILTERS",", for VHF/UHF","","FILSTRIP"
    "STUB MATCH",", for antennas","","COAXCHAR"
    "STUBS",", coaxial cable transmission lines","","COAXSTUB"
    "STUBS",", open-wire transmission lines","","TRANSTUB"
    "SUNRISE/SUNSET CALCULATOR","","","RISESET"
    "SUPPORT WIRES",", towers & masts","","GUYWIRES"
    "SURGE PROTECTION","","","CLAMP"
    "SURVEYOR'S CALCULATOR","","","SURVEY"
    "SWR CALCULATOR","","","SWR"
    "SWR VS. ATTENUATION","","","ATTENU"
    "T MATCH",", dipole to 600 Í line","","TMATCH"
    "T NETWORKS","","","PITNET"
    "T-PAD ATTENUATORS","","","ATTENPAD"
    "T2FD TERMINATED FOLDED DIPOLE","","","T2FD"
    "TANK CIRCUIT",", power amplifier","","TANKCCT"
    "TANK",", L/C coaxial cable","","COAXLC3"
    "TAP DRILL SIZES","","","NMBRSIZE"
    "TAPERED YAGI ELEMENTS","","","YAGTAPER"
    "TAPPED COIL PROPERTIES","","","COILTAP"
    "TAPPED COILS",", design of","","COILNEW"
    "TAPPED COILS",", feedline matching",", single wire antenna","SNGLWIRE"
    "TELESCOPING TUBING SIZES","","","TELETUBE"
    "TELESCOPING VARIABLE CAPACITOR","","","CAPYTEL"
    "TEMPERATURE CONVERSION",", fahrenheit / celsius","","EQUIV"
    "THERMAL RESISTANCE","","","THERMRES"
    "THERMODYNAMICS","","","PSYCHROM"
    "TIME DELAY",", R/C constant","","RCCONST"
    "TIME PAYMENT CALCULATOR","","","FINANCE"
    "TIME QUIZ","","","TIMEQ"
    "TIME ZONE CALCULATOR","","","TIMEZONE"
    "TIME ZONES",", of various locations","","LATLONG"
    "TIME",", as a function of speed and distance","","SPEEDTD"
    "TIMER",", metronome","","METNOM"
    "TIMER",", one-shot or variable delay",", ( #555 IC )","555TIMER"
    "TINY COILS",", wound on machine screw forms","","TINYCOIL"
    "TITLER",", photo slides or videos","","\HAMCALC\FOTOCALC\FOTOMENU"
    "TONE GENERATOR","","","ZOUNDS"
    "TOROID ANTENNA TRAPS","","","TOROTRAP"
    "TOROID FERRITE BALUN","","","BROADFER"
    "TOROID INDUCTORS","","","TOROID"
    "TORQUE",", vs. horsepower","","MECHMENU"
    "TOWERS",", guy wires","","GUYWIRES"
    "TRACKER",", Receiver Tuned Circuits","","TRACKER"
    "TRANSFORMER DESIGN",", power transformers","","PWRXFMR"
    "TRANSFORMER RATIOS","","","XFMR"
    "TRANSFORMER WINDINGS CALCULATOR","","","WINDING"
    "TRANSFORMER",", broadband",", ferrite toroidal","BROADFER"
    "TRANSFORMER",", impedance matching","","XFMR"
    "TRANSFORMER",", matchbox impedance","","MATCHBOX"
    "TRANSFORMER",", narrowband","","XFMRNARO"
    "TRANSFORMER",", quarter-wave","","QUARTWAV"
    "TRANSFORMER",", series-section","","SERISECT"
    "TRANSISTOR CIRCUIT DESIGN","","","TRANCCT"
    "TRANSISTOR MATCHING NETWORKS","","","MATCHNET"
    "TRANSISTOR STAGE COUPLING",", transmitters","","XMTRZMAT"
    "TRANSMATCH DESIGN (ZL1LE)","","","TRANSMAT"
    "TRANSMATCH",", single wire antennas","","SNGLWIRE"
    "TRANSMISSION LINE LENGTH","","","ELECLENG"
    "TRANSMISSION LINE LOSSES","","","LINELOSS"
    "TRANSMISSION LINE MISMATCH","","","MISMAT"
    "TRANSMISSION LINE NODE LOCATER","","","NODE"
    "TRANSMISSION LINE PERFORMANCE","","","TRANLINE"
    "TRANSMISSION LINE Q","","","QLINE2"
    "TRANSMISSION LINE STUBS",", coaxial cable","","COAXSTUB"
    "TRANSMISSION LINE STUBS",", open-wire line","","TRANSTUB"
    "TRANSMISSION LINE",", square coaxial","","SQCOAX"
    "TRANSMISSION LINES",", coaxial cable","","COAXCHAR"
    "TRANSMISSION LINES",", open-wire","","OPENWIRE"
    "TRANSMITTER STAGE COUPLING",", (transistor stages)","","XMTRZMAT"
    "TRAP ANTENNA DESIGN","","","TRAPOLE"
    "TRAP DESIGN CALCLATOR","","","TRAPCALC"
    "TRAP PROPERTY ESTIMATOR","","","TRAPROP"
    "TRAPS",", High Q Antenna","","QTRAP"
    "TRAPS",", antenna",", air-core coil","WAVETRAP"
    "TRAPS",", antenna",", toroid inductor","TOROTRAP"
    "TRAPS",", coaxial cable","","COAXTRAP"
    "TRAPS",", coaxial cable SuperTrap",", hi-reactance","BUXTRAP"
    "TRAPS",", design calculator","","TRAPCALC"
    "TRAPS",", wave trap filters","","WAVETRAP"
    "TRIANGLE WAVE GENERATOR","","","TRISQU"
    "TRIANGLES",", solution of","","SOLUTRI"
    "TRIGONOMETRIC FUNCTIONS","","","TRIG"
    "TRIMMER CAPACITORS","","","CAPTRIM"
    "TRIP PLANNER","","","TRIPLAN"
    "TROMBONE CAPACITOR","","","CAPYTEL"
    "TRUE NORTH VIA THE SUN","","","TRUNORTH"
    "TUBING",", aluminum","","TELETUBE"
    "TUBING",", antenna elements","","ANTENNA"
    "TUNED CIRCUIT DESIGN",", L/C network","","TUNECCT"
    "TUNERS",", link coupled","","LINKUPL"
    "TURNING RADIUS - BEAMS","","","TURNRAD"
    "TV CHANNELS",", (N.America)","","TVCHAN"
    "UNIT VALUE COMPARATOR","","","UNITVALU"
    "UTC",", Coordinated Universal Time","","TIMEZONE"
    "VACUUM TUBE TANK CIRCUIT","","","TANKCCT"
    "VARIABLE CAPACITOR",", plate shape designer","","VACAP"
    "VARIABLE CAPACITOR",", telescoping","","CAPYTEL"
    "VELOCITY FACTOR",", coaxial cable","","COAXCHAR"
    "VELOCITY FACTOR",", open-wire lines","","OPENWIRE"
    "VELOCITY FACTOR",", transmission lines","","ELECLENG"
    "VELOCITY OF LIGHT","","","ANTENNA"
    "VERTICAL ANTENNA ARRAY",", feed method","","VARAYFED"
    "VERTICAL ANTENNA",", dual band trap","","TRAPOLE"
    "VERTICAL ANTENNA",", mobile/maritime whip","","MOWHIP"
    "VERTICAL ANTENNA",", short helically wound","","HELVERT"
    "VERTICAL ANTENNA",", short with capacity hat","","CAPYHAT"
    "VFO FREQUENCY CALCULATOR","","","VFOFREQ"
    "VOLT-AMPERE VALUE",", in A.C. circuits","","ACCALC"
    "VOLTAGE BREAKDOWN","","","SPARK"
    "VOLTAGE DIVIDED",", Thevinin","","THEVININ"
    "VOLTAGE DIVIDER",", 2 resistors","","VOLTDIV"
    "VOLTAGE DIVIDER",", R/C, R/L, L/C circuits","","DSGNMENU"
    "VOLTAGE DROP",", in long runs of copper wire","","COPWIRE"
    "VOLTAGE REGULATOR",", LM317 IC","","LM317"
    "VOLTAGE REGULATOR",", zener diode","","ZENER"
    "VOLTAGE",", A.C.circuits","","ACCALC"
    "VOLTAGE",", clamping","","CLAMP"
    "VOLTAGE",", dB gain/loss","","DECIBEL"
    "VOLTMETERS","","","METERS"
    "VSWR",", lossless L/C circuits","","NOLOSS"
    "VSWR",", transmission lines","","MISMAT"
    "WALKER",", screen saver","","WALKER"
    "WALL WART RATINGS CALCULATOR","","","WALWART"
    "WALLWART TEST PROGRAM","","","WARTEST"
    "WATTS",", (Ohm's Law)","","OHMSLAW"
    "WAVE GENERATOR",", Suare & Triangle","","TRISQU"
    "WAVE TRAP FILTERS","","","WAVETRAP"
    "WAVEGUIDES",", parabolic dish circular feeds","","CIRCFEED"
    "WAVELENGTH",", audio frequencies","","ZOUNDS"
    "WAVELENGTH",", centre","","CENTFREQ"
    "WAVELENGTH",", convert to frequency","","EQUIV"
    "WEIGHT",", copper wire","","COPWIRE"
    "WHEATSTONE BRIDGE #1",", Calculator","","BRIDGE"
    "WHEATSTONE BRIDGE #2",", Calculator","","BRIDGE-2"
    "WHIP ANTENNA COILS","","","COILAMP"
    "WHIP ANTENNA",", mobile/maritime","","MOWHIP"
    "WIND CHILL FACTOR","","","WINDCHIL"
    "WINDINGS CALCULATOR",", single layer coils","","HELIX"
    "WINDINGS CALCULATOR",", transformers","","WINDING"
    "WINDINGS RATIO",", transformers","","XFMR"
    "WINDINGS",", L/C network coils","","TUNECCT"
    "WINDOM ANTENNA","","","WINDOM"
    "WIRE ANTENNA INDEX","","","WIREANT"
    "WIRE INCHES-PER-VOLT",", transformers","","WINDING"
    "WIRE MESH SCREENS","","","WIREMESH"
    "WIRE SIZE CALCULATOR","","","AWGEXACT"
    "WIRE SPACING",", open-wire transmission line","","OPENWIRE"
    "WIRE TABLES","","","COPWIRE"
    "WIRE WOUND RESISTORS","","","RESICOP"
    "WIRE",", Copperweld","","WIRESAG"
    "WIRE",", hard drawn copper","","WIRESAG"
    "WIRE",", stretching and sagging","","WIRESAG"
    "WIRES IN CONDUIT","","","WIRECOND"
    "YAGI 3-ELEMENT BEAM","","","YAGI3EL"
    "YAGI ANTENNA",", log-periodic array","","LOGYAG"
    "YAGI ELEMENT DIAMETER VS LENGTH","","","DIALGTH"
    "YAGI ELEMENT SPACING",", NBS standard","","YAGISPAC"
    "YAGI TAPERED ELEMENTS",", (telescoped aluminum tubing)","","YAGTAPER"
    "YAGI THROUGH-BOOM ELEMENTS","","","THRUBOOM"
    "YAGI",", extremely long","","YAGILONG"
    "YAGI",", hairpin beta-match","","HAIRPIN"
    "ZENER DIODE VOLTAGE REGULATOR","","","ZENER"
    "ZEPP MULTI-BAND ANTENNA","","","ZEPP"
    "ZEPP",", double extended","","ZEPPDBL"


Subject Areas
=============

There appear to be the following subject areas.

1.  Radio Engineering

2.  Radio Operations

#.  General Electronics

#.  Construction including Plumbing and Electrical and Mechanical

#.  Mathematics and Physics including Unit Conversions

#.  Navigation and Astronomy

#.  Calendrical Calculations

#.  Audio and Photography

#.  Software Engineering, including ASCII codes and other algorithms

#.  Other, including finance and nutrition

The idea is to partition all 449 programs into one of these higher-level subject areas.

This should be more useful than the purely alphabetical organization originally
used in HamCalc.
