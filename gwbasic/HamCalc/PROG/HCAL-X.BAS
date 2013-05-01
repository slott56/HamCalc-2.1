10 :REM'\hamcalc\menu\HCAL-X   02 JUN 94 rev. 14 MAR 2010
20 CHDIR "\hamcalc\prog"
30 CLS:KEY OFF
40 COMMON EX$,Z$
50 IF EX$=""THEN EX$="exit"
60 IF X$=""THEN X$="X"
70 :REM'
80 U$=STRING$(80,205)
90 DIM B$(400),C$(400)
100 ON ERROR  GOTO 160
110 COLOR 7,0
120 PRINT " H A M C A L C  Program Menu ";X$;TAB(57);"by George Murphy VE3ERP ";
130 PRINT U$;
140 N=0:GOTO 180
150 :REM'
160 PRINT "Error ";ERR;" in line ";ERL:END
170 :REM'
180 IF X$="A"THEN Y=0
190 IF X$="B"THEN Y=40
200 IF X$="C"THEN Y=80
210 IF X$="D"THEN Y=120
220 IF X$="E"THEN Y=160
230 IF X$="F"THEN Y=200
240 IF X$="G"THEN Y=240
250 IF X$="H"THEN Y=280
255 IF X$="I"THEN Y=320
260  FOR N=1 TO 320
270  READ B$(N),C$(N)
280  NEXT N
290 LOCATE 5
300 FOR Z=1 TO 20
310 IF Z<10 THEN Z$="0#:":ELSE Z$="##:"
320 PRINT " ";USING Z$;Z;:PRINT " ";C$(Z+Y);         :REM'left hand column
330 PRINT TAB(41);
340 PRINT USING "##:";Z+20;:PRINT " ";C$(Z+Y+20);    :REM'right hand column
350 IF Z<20 THEN PRINT ""
360 NEXT Z
370 :REM'
380 LOCATE 25,1:PRINT STRING$(80,32);      :REM'menu options
390 LOCATE 25   :REM'.....bottom line
400 LOCATE ,40:COLOR 0,7:PRINT" 41:MENU  ";" 42:INDEX  ";" 43:EXIT ";
410 COLOR 7,0:LOCATE 3,2  :REM'....header
420 Z$=""
430 COLOR 0,7:PRINT " TYPE one of the 2-digit numbers listed below - ";
440 PRINT "DO NOT press <ENTER>:";
450 COLOR 7,0:PRINT U$;
460 I$=INKEY$:IF I$=""THEN 460
470 Z$=Z$+I$
480 IF LEN(Z$)<2 THEN 460 :ELSE 510
490 IF VAL(Z$)>43 GOTO 590
500 GOTO 460
510 P=VAL(Z$)
520 IF P>43 THEN 590
530 IF P=41 THEN CLS:CHAIN"\hamcalc\menu\hcal"
540 IF P=42 THEN CLS:CHAIN"\hamcalc\prog\hamdex"
550 IF P=43 THEN CLS:RUN "exit"
560 P=P+Y
570 Y$=B$(P)
580 IF Y$=""OR Y$="-"THEN 590 :ELSE COLOR 7,0,0:CLS:CHAIN Y$
590 LOCATE 3:COLOR 7,0:PRINT STRING$(80,32);:LOCATE CSRLIN-1:COLOR 0,7
600 BEEP:PRINT " ";Z$;" is not a valid number...press any key to try again..."
610 IF INKEY$=""THEN 610 :ELSE 410
620 :REM'.......DATA
630 DATA accalc,   A.C. Circuit Calculator
640 DATA antfield, Antenna Field Strength
650 DATA antscale, Antenna Frequency Scaling
660 DATA impant,   Antenna Impedance Calculator
670 DATA antenna,  Antenna Length/Pruning calculator
680 DATA antmatch, Antenna Matching Networks
690 DATA arch,     Arch Calculator
700 DATA page437,  ASCII Character Code Page 437
710 DATA attenpad,"Attenuators: T-Pad and Pi-Pad"
720 DATA audfilt,  Audio Bandpass Filter - Active
730 DATA lopass,   Audio Lowpass Filter(Sallen & Key)
740 DATA audpass,  Audio Filters - Passive
750 DATA rcfilt,   Audio Filters - RC Active
760 DATA audosc,   Audio Oscillator (LM 324)
770 DATA audosc2,  Audio Oscillator (LF 353)dual wave
780 DATA twintee,  Audio Oscillator (Twin-T)
790 DATA zounds,   Audio Programs
800 DATA awgexact, A.W.G. Wire Size Calculator
810 DATA bend,     Bend Allowance - Metals
820 DATA aircore,  B.& W. Air-Core Inductors
830 DATA broadfer, Baluns - Ferrite Toroid
840 DATA bandstop, Band-Reject Filter
850 DATA bandq,    Bandwidth vs. Q
860 DATA bandwdth,"Bandwidths - 2:1 SWR"
870 DATA baromtr,  Barometer Reading Equivalents
880 DATA batchg,   Battery Charger
890 DATA dialgth,  Beam Element Diameter vs Length
900 DATA pathfind, Beam Heading Calculator
910 DATA bevant,   Beverage Antenna Equations
920 DATA bobtail,  Bobtail Curtain Antenna
930 DATA boom,     Boom Droop - Beam Antennas
940 DATA spark,    Breakdown Voltage
950 DATA caltoday, Calendar - Perpetual/Universal
960 DATA calory,   Calorie Counter
970 DATA capstray, Capacitance - Distributed (stray)
980 DATA captance, Capacitor Design Calculator
990 DATA capval,   Capacitor Measurer
1000 DATA gaplot,   Capacitor Plate Designer
1010 DATA capcoax,  Capacitors - Coaxial Cable
1020 DATA custcap,  Capacitors - Custom Value
1030 DATA precicap, Capacitors - Precision
1040 DATA capacval, Capacitors - Standard Values
1050 DATA capytel,  Capacitors - Telescoping Variable
1060 DATA trimr,    Capacitors - Trimmer
1070 DATA hatshape, Capacity Hat Geometric Shapes
1080 DATA capyhat,  Capacity Hats - Vertical Antennas
1090 DATA rotaplot, Cartesian/Polar Plot Rotator
1100 DATA ccdanten, CCD Antennas
1110 DATA centfreq, Centre Frequency & Wavelength
1120 DATA propcirc, Circle - Properies of
1130 DATA circfeed, Circular Waveguide Dish Feeds
1140 DATA clamp,    Clamping Voltage Calculator
1150 DATA clarky,   Clark Y Airfoil
1160 DATA cmosc3,   CMOS Oscillator
1170 DATA coaxchar, Coax Cable Characteristics
1180 DATA coaxlc3,  Coax Cable L/C Tank
1190 DATA chokbal,  Coax Cable RF Chokes & Baluns
1200 DATA coaxtrap, Coax Cable Traps
1210 DATA buxtrap , Coax Cable Hi-Reactance SuperTrap
1220 DATA cw,       Code Trainer (Morse Code)
1230 DATA coilnew,  Coil Calculator- Dehoney equations
1240 DATA coilequa, Coil Calculator- Wheeler equations
1250 DATA coilq,    Coil Q Calculator
1260 DATA coildsgn, Coil Designer
1270 DATA coilquik, Coil Q Quick Estimator
1280 DATA coiltrue, Coil Q - True vs. Apparent
1290 DATA coilnew,  Coil Tap Calculators
1300 DATA coiltap,  Coil Tap Properties
1310 DATA turns,    Coil Turns Calculator
1320 DATA coilcpl,  Coils - Coaxially coupled
1330 DATA coilnew,  Coils in Tandem
1340 DATA coilin,   Coils - Insulated Wire
1350 DATA colposc,  Colpitts FET Oscillator
1360 DATA conecalc, Cone Calculator
1370 DATA conjumat, Conjugate Match Calculator
1380 DATA phazdiff, Constant Phase Difference Networks
1390 DATA copwire,  Copper Wire Data
1400 DATA xover,    Crossover Networks - Loudspeakers
1410 DATA crysfilt, Crystal Ladder Filter
1420 DATA curvefit, Curve Fit program
1430 DATA cylload,  CYLOAD antenna
1440 DATA daydusk,  Daylight Dusk and Dawn Calculator
1450 DATA decibel,  Decibel Calculator
1460 DATA decifrac, Decimal/Fraction Converter
1470 DATA deciconv, Decimal Hour/Degree Converter
1480 DATA binary,   Decimal to Binary Converter
1490 DATA rjd,      Dehoney Algorithm Index
1500 DATA deltamat, Delta Match
1510 DATA diamfind, Diameter Finder
1520 DATA dielect,  Dielectric Constants
1530 DATA discone,  Discone Multiband Antenna
1540 DATA duopole,  Dual Band Short Dipole Antenna
1550 DATA seasons,  Equinoxes & Solstices
1560 DATA elspec,   Electromagnetic Spectrum
1570 DATA fatdipol, Fat Dipole (broadband)
1580 DATA fibon,    Fibonacci Series
1590 DATA filtut,   Filter Tutor
1600 DATA buttfilt, Filters - Butterworth HF
1610 DATA comfilt,  Filters - Complementary
1620 DATA cplres,   Filters - Coupled Resonator
1630 DATA matfilt,  Filters - Impedance Matching
1640 DATA filtrlc,  Filters - Passive R/L/C
1650 DATA filstrip, Filters - Stripline Bandpass
1660 DATA finance,  Financial Calculators
1670 DATA fishbone, Fishbone Antenna
1680 DATA foldipol, Folded Dipole - 300- Twin-Lead
1690 DATA zostepup, Folded Dipole - Zo Step-Up Ratios
1700 DATA formulae, Formula Library
1710 DATA fusewire, Fuses - Emergency
1720 DATA g5rv,     G5RV Multiband Antenna
1730 DATA gammatch, Gamma Match
1740 DATA graphs,   Graphs
1750 DATA pathfind, Great Circle Paths & Distances
1760 DATA gridsq,   Grid Square Locator (Maidenhead)
1770 DATA guywires, Guy Wires for Antenna Towers/Masts
1780 DATA hairpin,  Hairpin Beta-Match for Yagis
1790 DATA halfloop, Half-Loop Low Profile Antenna
1800 DATA hambands, Ham Band Edge & Centre Frequencies
1810 DATA harmonic, Harmonic Frequencies
1820 DATA hartosc,  Hartley FET Oscillator
1830 DATA hotbox,   Heat Dissipation
1840 DATA sink,     Heat Sink Fins
1850 DATA helant,   Helical Antenna - VHF/UHF
1860 DATA helreson, Helical Resonators (VHF/UHF)
1870 DATA helix,    Helical Winding
1880 DATA qtrap,    High Q Antenna Traps
1890 DATA humid,    Humidex Calculator
1900 DATA 3mbridge, Impedance Bridge (3-meter)
1910 DATA impednet, Impedance Matching Networks
1920 DATA impedmetr,Impedance Meter
1930 DATA antimp,   Impedance - Antennas
1940 DATA impares,  Impedance - Parallel Resonant Cct.
1950 DATA impedcct, Impedance - Reactance/Resist. Cct.
1960 DATA inducalc, Inductance Calculator
1970 DATA induloop, Inductance - Single Loops
1980 DATA induhose, Inductors - Dryer Vent Hose
1990 DATA inloss,   Insertion Loss
2000 DATA invee,    Inverted Vee Antenna
2010 DATA involute, Involute of a Circle
2020 DATA jcalc,    J Calculator (Complex Impedances)
2030 DATA jaypole,  J-Pole End-Fed Zepp Antenna
2040 DATA kfactor,  K-Factor & Antenna Length (NEC-2)
2050 DATA ladant,   Ladder Line Antenna
2060 DATA ladder2,  Ladder Network - 2 element
2070 DATA ladrsolv, Ladder Network Analyzer
2080 DATA lamplife, Lamp Life Expectancy
2090 DATA latlong,  Latitude/Longitude Data Base
2100 DATA led,      LED Series Resistor
2110 DATA radiolos, Line-of-Sight Radio Wave
2120 DATA linkupl,  Link Coupled Tuners
2130 DATA lm317,    LM317 Voltage Regulator
2140 DATA deltload, Load Resistance Calculator
2150 DATA localrpt, Local Repeaters
2160 DATA zounds,   Music Math & Sounds
2170 DATA numderiv, Logarithms to any base
2180 DATA logyag,   LOG-YAG Log-Periodic Yagi Antenna
2190 DATA pairlt,   Long-Tailed Pair
2200 DATA loopant,  Loop Antenna Coil Inductance
2210 DATA loopxmit, Loop Antennas - Transmitting
2220 DATA loopsky,  Loop Skywire Dimensions
2230 DATA l-pad,    L-Pad Calculator
2240 DATA brick,    Masonry Estimator
2250 DATA matchbox, Matchbox Impedance Transformer
2260 DATA matchnet, Matching Networks for Transistors
2270 DATA maxuf,    Max. Usable Frequencies (MAXIMUF)
2280 DATA mechmenu, MECHANICS Math
2290 DATA metshowr, Meteor Shower Predictor
2300 DATA meters,   Meters (Direct Current)
2310 DATA metrics,  Metric Conversions
2320 DATA metnom,   Metronome
2330 DATA microver, MicroVert very short HF Antenna
2340 DATA miniloop, MINILOOP Miniature Loop Antenna
2350 DATA miniquad, MINIQUAD Coil Shortened Antenna
2360 DATA coilamp,  Mobile Whip Antenna Coils
2370 DATA mobilmat, Mobile Antenna Matching
2380 DATA mowhip,   Mobile/Maritime Whip Antennas
2390 DATA moontrac, Moon Tracker
2400 DATA moxon,    Moxon Rectangle Antenna
2410 DATA zounds,   Musical Math & Sounds
2420 DATA nicad,    NiCad Battery Discharger
2430 DATA nmbrsize, Numbered Drills/Screws/Taps/Gauges
2440 DATA numsort,  Number Sorter
2450 DATA numderiv, Numbers and Functions
2460 DATA octagon,  Octagonal Loop Framework
2470 DATA octaloop, OCTALOOP Subminiature Loop Antenna
2480 DATA octaring, OCTARING Subminiature Loop Antenna
2490 DATA ocfdipol, "Off-Centre Dipole, 3-band trapless"
2500 DATA ohmslaw,  Ohm's Law Calculator
2510 DATA concur,   OP AMP Constant Current Circuit
2520 DATA opamp,    OP AMP Operational Amplifiers
2530 DATA cascamp,  OP AMPS - Cascaded
2540 DATA noisfig,  OP AMPS - Noise Figure
2550 DATA dishant,  Parabolic Dish Design
2560 DATA pedom,    Pedometer
2570 DATA fotomenu, PHOTOGRAPHY Math
2580 DATA pitnet,  Pi and T Networks
2590 DATA pipesize, Pipe Sizes - ANSI Standard
2600 DATA pixel,    Pixel Data for Scanners & Cameras
2610 DATA polygon,  Polygon Dimensions
2620 DATA potent,   Potentiometers - Custom Value
2630 DATA psup,     Power Supply Analyzer
2640 DATA pwrcct,   Power Supply Design
2650 DATA dblbrg4,  Power Supply - Double Bridge
2660 DATA psuperf,  Power Supply Performance
2670 DATA powrxfmr, Power Transformer Design
2680 DATA pwrxfmr,  Power Transformer Winding Estimator
2690 DATA primenos, Prime Number Calculator
2700 DATA copwire,  Printed Circuit Board Traces
2710 DATA pba,      Pseudo-Brewster Angle
2720 DATA pulsegen, Pulse Generator
2730 DATA qreson,   Q Calculator - Resonant Circuits
2740 DATA foxlog,   QRP Fox Hunt Log
2750 DATA qmeas,    Q of L/C Tank Circuit
2760 DATA quad,     Quad Antenna Dimensions
2770 DATA quadrat,  Quadratic Equation Calculator
2780 DATA quartwav, Quarter Wave Transformer
2790 DATA radangle, Radiation Angle - Antenna
2800 DATA vertpatt, Radiation Plots - Phased Verticals
2810 DATA randnum,  Random Number Generator
2820 DATA react,    Reactance Programs
2830 DATA dsgnmenu, Resistor/Inductor/Capacitor Ccts.
2840 DATA colcode,  Resistor Colour Code
2850 DATA resicop,  Resistors - Copper Wire Wound
2860 DATA custohm,  Resistors - Custom Value
2870 DATA precires, Resistors - Precision
2880 DATA resisval, Resistors - Standard Values
2890 DATA smeter,   S-Meter Readings vs. Power
2900 DATA catenary, Sag in Horizontal Wire Antennas
2910 DATA satorbit, Satellite Orbit Parameters
2920 DATA scalspd,  Scale Speed Calculator
2930 DATA schmidt,  Schmidt trigger Op Amp
2940 DATA serisect, Series-Section Transformer
2950 DATA centload, Short Centre-Loaded Dipole
2960 DATA cylload,  Short Cylinder-Loaded Dipole
2970 DATA dipol160, Short Dipole for 160/80/40 metres
2980 DATA es2b,     Short ES2B (2 band) Trap Dipole
2990 DATA shortant, Short Off-Centre-Loaded Dipole
3000 DATA shortdip, Short Multiband Dipole Array
3010 DATA simuleq,  Simultaneous Equation Calculator
3020 DATA snglwire, Single Wire Antenna Systems
3030 DATA copwire,  Skin Effect
3040 DATA skipdist, Skip Distance Calculator
3050 DATA sloper,   Sloper Antenna Dimensions
3060 DATA smithcht, Smith Chart Calculations
3070 DATA sorter,   Sorter
3080 DATA speedtd,  Speed/Time/Distance Calculator
3090 DATA stubant,  Stub Match for Antennas
3100 DATA coaxstub, Stubs - Coaxial Transmission Line
3110 DATA transtub, Stubs - Open Wire Transmiss'n Line
3120 DATA riseset,  Sunrise/Sunset Calculator
3130 DATA survey,   Surveyor's Calculator
3140 DATA swr,      SWR Calculator
3150 DATA t2fd,     T2FD Tilted Folded Dipole
3160 DATA tmatch,   T Match - Dipole to 600 - Line
3170 DATA tankcct,  Tank Circuit - Power Amplifier
3180 DATA teletube, Telescoping Aluminum Tubing
3190 DATA thermres, Thermal Resistance
3200 DATA psychrom, Thermodynamics
3210 DATA timeq,    Time Quiz
3220 DATA timezone, Time Zones (UTC)
3230 DATA 555timer, Timer (555 IC)
3240 DATA tinycoil, Tiny Coils
3250 DATA torotrap, Toroid Antenna Traps
3260 DATA broadfer, Toroid Baluns & Transformers
3270 DATA toroid,   Toroid Inductors
3280 DATA tracker,  Tracker - Receiver Tuned Circuits
3290 DATA powrxfmr, Transformer Design
3300 DATA xfmrnaro, Transformer - Narrow Band
3310 DATA xfmr,     Transformer Ratios
3320 DATA winding,  Transformer Winding Calculator
3330 DATA trancct,  Transistor Circuit Design
3340 DATA transmat, Transmatch Design (ZL1LE)
3350 DATA chokbal,  Transmission Line Choke
3360 DATA elecleng, Transmission Line Length
3370 DATA lineloss, Transmission Line Losses
3380 DATA mismat,   Transmission Line Mismatch
3390 DATA node,     Transmission Line Node Locator
3400 DATA tranline, Transmission Line Performance
3410 DATA sqcoax,   Transmission Line - Square Coaxial
3420 DATA openwire, Transmission Line - Open Wire
3430 DATA qline2,   Transmission Line Q
3440 DATA trapole,  Trap Antenna Design
3450 DATA trapcalc, Trap Design Calculator
3460 DATA trapdsgn, Trap Dipole - 3 Band Single Trap
3470 DATA traprop,  Trap Properties Estimator
3480 DATA coaxtrap, Traps - Coaxial Cable
3490 DATA solutri,  Triangles - solution of
3500 DATA trig,     Trigonometric Functions
3510 DATA triplan,  Trip Planner
3520 DATA trunorth, True North via the Sun
3530 DATA tunecct,  Tuned Circuit Design - L/C network
3540 DATA turnrad,  Turning Radius - Beam antennas
3550 DATA tvchan,   TV Channels ( North America )
3560 DATA unitvalu, Unit Value Comparator
3570 DATA helvert,  Vertical Antenna - Helically Wound
3580 DATA varayfed, Vertical Antenna Array Feed Method
3590 DATA vfofreq,  VFO Frequency Calculator
3600 DATA voltdiv,  Voltage Divider
3610 DATA thevinin, Voltage Divider - Thevinin
3620 DATA walwart,  Wall Wart Ratings Calculator
3630 DATA wartest,  Wall Wart Properties
3640 DATA wavetrap, Wave Trap Filters
3650 DATA bridge,   Wheatstone Bridge Calculator
3660 DATA windom,   Windom Antenna
3670 DATA windchil, Wind Chill Factor
3680 DATA wireant,  Wire Antenna Index
3690 DATA wiremesh, Wire Mesh Screens - Wind Loads
3700 DATA wirecond, Wires in Conduit
3710 DATA xmtrzmat, Xmtr. Transistor Stage Coupling
3720 DATA yagi3el,  YAGI 3-Element Beam Design
3730 DATA dialgth,  YAGI Element Diameter vs. Length
3740 DATA yagispac, YAGI Element Spacing/NBS Standard
3750 DATA yagtaper, YAGI Tapered Elements
3760 DATA thruboom, YAGI Through-Boom Elements
3770 DATA yagilong, YAGI Extremely Long VHF/UHF Antenna
3780 DATA zener,    Zener Diode Voltage Regulator
3790 DATA zeppdbl,  Zepp (extended double) Antenna
3800 DATA zepp,     Zepp Multi-band antenna
3810 DATA "-","-"
3820 DATA
