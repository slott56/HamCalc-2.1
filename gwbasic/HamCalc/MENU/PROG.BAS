10 :REM'\hamcalc\menu\HCAL-X   02 JUN 94 rev. 28 JAN 2008
20 CHDIR "\hamcalc\prog"
30 CLS:KEY OFF
40 COMMON EX$
50 IF X$=""THEN X$="X"
60 COLOR ,,0
70 :REM'
80 U$=STRING$(80,205)
90 DIM B$(500),C$(500)
100 ON ERROR  GOTO 230
110 COLOR 15,1
120 PRINT " H A M C A L C  Program Menu ";:COLOR 14,4:PRINT " "+X$+" ";
130 COLOR 15,1
140 PRINT TAB(57);"by George Murphy VE3ERP ";
150 COLOR 7,1
160 PRINT STRING$(80,223);
170 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3    :REM'set background colour
180 COLOR 15,1
190 PRINT
200 PRINT U$;
210 N=0:GOTO 250
220 :REM'
230 PRINT "Error ";ERR;" in line ";ERL:END
240 :REM'
250 IF X$="A"THEN Y=0:   I$="g":J$="b"
260 IF X$="B"THEN Y=40:  I$="a":J$="c"
270 IF X$="C"THEN Y=80:  I$="b":J$="d"
280 IF X$="D"THEN Y=120: I$="c":J$="e"
290 IF X$="E"THEN Y=160: I$="d":J$="f"
300 IF X$="F"THEN Y=200: I$="e":J$="g"
310 IF X$="G"THEN Y=240: I$="f":J$="h"
320 IF X$="H"THEN Y=280: I$="g":J$="a"
330 :REM'
340 FOR N=1 TO 305
350 READ B$(N),C$(N)
360 NEXT N
370 B$(301)=B$(301)+I$
380 B$(302)=B$(302)+J$
390 :REM'
400 FOR Z=1 TO 20
410 IF Z<10 THEN Z$="0#:":ELSE Z$="##:"
420 PRINT " ";USING Z$;Z;:PRINT " ";C$(Z+Y);         :REM'left hand column
430 :REM'IF X$="H"THEN 460
440 COLOR 15,1
450 PRINT TAB(41);
460 PRINT USING "##:";Z+20;:PRINT " ";C$(Z+Y+20);    :REM'right hand column
470 IF Z<20 THEN PRINT ""
480 NEXT Z
490 :REM'
500 COLOR 0,7:LOCATE 25,1:PRINT STRING$(80,32);      :REM'menu options
510 X=16:W=-X+1
520 FOR Z=1 TO 5
530 LOCATE 25,W+(X*Z)
540 COLOR 1:PRINT "██";
550 COLOR 0
560 PRINT USING "###:";40+Z;:PRINT C$(300+Z);
570 NEXT Z
580 LOCATE 25,79:COLOR 1:PRINT STRING$(2,"█");
590 LOCATE 3,2
600 COLOR 14,4
610 Z$=""
620 PRINT " TYPE one of the 2-digit numbers listed below - ";
630 PRINT "DO NOT press <ENTER>:"
640 I$=INKEY$:IF I$=""THEN 640
650 Z$=Z$+I$
660 IF LEN(Z$)<2 THEN 640 :ELSE 680
670 GOTO 640
680 P=VAL(Z$)
690 IF P=0 OR P>45 THEN 740
700 IF P>=41 AND P<=45 THEN P=P+260:GOTO 720
710 P=P+Y
720 Y$=B$(P)
730 IF B$(P)=""THEN 740 :ELSE COLOR 7,0,0:CLS:CHAIN Y$
740 LOCATE CSRLIN-1:COLOR ,1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
750 BEEP:PRINT " ";Z$;" is not a valid number...press any key to try again..."
760 IF INKEY$=""THEN 760
770 LOCATE CSRLIN-1:COLOR ,1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 580
780 :REM'
790 DATA accalc,   A.C. Circuit Calculator
800 DATA antfield, Antenna Field Strength
810 DATA antscale, Antenna Frequency Scaling
820 DATA antenna,  Antenna Length/Pruning calculator
830 DATA antmatch, Antenna Matching Networks
840 DATA page437,  ASCII Character Code Page 437
850 DATA attenpad,"Attenuators: T-Pad and Pi-Pad"
860 DATA audfilt,  Audio Bandpass Filter - Active
870 DATA lopass,   Audio Lowpass Filter(Sallen & Key)
880 DATA audpass,  Audio Filters - Passive
890 DATA rcfilt,   Audio Filters - RC Active
900 DATA audosc,   Audio Oscillator (LM 324)
910 DATA audosc2,  Audio Oscillator (LF 353)dual wave
920 DATA twintee,  Audio Oscillator (Twin-T)
930 DATA zounds,   Audio Tone Analyzer
940 DATA awgexact, A.W.G. Wire Size Calculator
950 DATA bend,     Bend Allowance - Metals
960 DATA aircore,  B.& W. Air-Core Inductors
970 DATA broadfer, Baluns - Ferrite Toroid
980 DATA bandstop, Band-Reject Filter
990 DATA bandq,    Bandwidth vs. Q
1000 DATA bandwdth,"Bandwidths - 2:1 SWR"
1010 DATA baromtr,  Barometer Reading Equivalents
1020 DATA batchg,   Battery Charger
1030 DATA dialgth,  Beam Element Diameter vs Length
1040 DATA pathfind, Beam Heading Calculator
1050 DATA bevant,   Beverage Antenna Equations
1060 DATA bobtail,  Bobtail Curtain Antenna
1070 DATA boom,     Boom Droop - Beam Antennas
1080 DATA spark,    Breakdown Voltage
1090 DATA caltoday, Calendar - Perpetual/Universal
1100 DATA calory,   Calorie Counter
1110 DATA capstray, Capacitance - Distributed (stray)
1120 DATA captance, Capacitor Design Calculator
1130 DATA gaplot,   Capacitor Plate Designer
1140 DATA capcoax,  Capacitors - Coaxial Cable
1150 DATA custcap,  Capacitors - Custom Value
1160 DATA precicap, Capacitors - Precision
1170 DATA capacval, Capacitors - Standard Values
1180 DATA capytel,  Capacitors - Telescoping Variable
1190 DATA trimr,    Capacitors - Trimmer
1200 DATA hatshape, Capacity Hat Geometric Shapes
1210 DATA capyhat,  Capacity Hats - Vertical Antennas
1220 DATA rotaplot, Cartesian/Polar Plot Rotator
1230 DATA ccdanten, CCD Antennas
1240 DATA centfreq, Centre Frequency & Wavelength
1250 DATA propcirc, Circle - Properies of
1260 DATA circfeed, Circular Waveguide Dish Feeds
1270 DATA coaxchar, Coax Cable Characteristics
1280 DATA chobal6,  Coax Cable RF Chokes & Baluns
1290 DATA coaxtrap, Coax Cable Traps
1300 DATA buxtrap , Coax Cable Hi-Reactance SuperTrap
1310 DATA cw,       Code Trainer (Morse Code)
1320 DATA coilnew,  Coil Calculator- Dehoney equations
1330 DATA coilequa, Coil Calculator- Wheeler equations
1340 DATA coilq,    Coil Q Calculator
1350 DATA coildsgn, Coil Designer
1360 DATA coilquik, Coil Q Quick Estimator
1370 DATA coiltrue, Coil Q - True vs. Apparent
1380 DATA coilnew,  Coil Tap Calculators
1390 DATA coilcpl,  Coils - Coaxially coupled
1400 DATA coilnew,  Coils in Tandem
1410 DATA conecalc, Cone Calculator
1420 DATA conjumat, Conjugate Match Calculator
1430 DATA phazdiff, Constant Phase Difference Networks
1440 DATA copwire,  Copper Wire Data
1450 DATA xover,    Crossover Networks - Loudspeakers
1460 DATA crysfilt, Crystal Ladder Filter
1470 DATA curvefit, Curve Fit program
1480 DATA cylload,  CYLOAD antenna
1490 DATA daydusk,  Daylight Dusk and Dawn Calculator
1500 DATA decibel,  Decibel Calculator
1510 DATA decifrac, Decimal/Fraction Converter
1520 DATA deciconv, Decimal Hour/Degree Converter
1530 DATA binary,   Decimal to Binary Converter
1540 DATA deltamat, Delta Match
1550 DATA diamfind, Diameter Finder
1560 DATA dielect,  Dielectric Constants
1570 DATA discone,  Discone Multiband Antenna
1580 DATA duopole,  Dual Band Short Dipole Antenna
1590 DATA seasons,  Equinoxes & Solstices
1600 DATA equiv,    Equivalent Values
1610 DATA fatdipol, Fat Dipole (broadband)
1620 DATA fibon,    Fibonacci Series
1630 DATA buttfilt, Filters - Butterworth HF
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
1820 DATA helant,   Helical Antenna - VHF/UHF
1830 DATA helreson, Helical Resonators (VHF/UHF)
1840 DATA helix,    Helical Winding
1850 DATA 3mbridge, Impedance Bridge (3-meter)
1860 DATA impednet, Impedance Matching Networks
1870 DATA impedmetr,Impedance Meter
1880 DATA antimp,   Impedance - Antennas
1890 DATA impares,  Impedance - Parallel Resonant Cct.
1900 DATA impedcct, Impedance - Reactance/Resist. Cct.
1910 DATA inducalc, Inductance Calculator
1920 DATA induloop, Inductance - Single Loops
1930 DATA induhose, Inductors - Dryer Vent Hose
1940 DATA invee,    Inverted Vee Antenna
1950 DATA jcalc,    J Calculator (Complex Impedances)
1960 DATA jaypole,  J-Pole End-Fed Zepp Antenna
1970 DATA kfactor,  K-Factor & Antenna Length (NEC-2)
1980 DATA ladder2,  Ladder Network - 2 element
1990 DATA ladrsolv, Ladder Network Analyzer
2000 DATA lamplife, Lamp Life Expectancy
2010 DATA latlong,  Latitude/Longitude Data Base
2020 DATA led,      LED Series Resistor
2030 DATA radiolos, Line-of-Sight Radio Wave
2040 DATA linkupl,  Link Coupled Tuners
2050 DATA lm317,    LM317 Voltage Regulator
2060 DATA deltload, Load Resistance Calculator
2070 DATA localrpt, Local Repeaters
2080 DATA numderiv, Logarithms to any base
2090 DATA logyag,   LOG-YAG Log-Periodic Yagi Antenna
2100 DATA loopant,  Loop Antenna Coil Inductance
2110 DATA loopxmit, Loop Antennas - Transmitting
2120 DATA loopsky,  Loop Skywire Dimensions
2130 DATA l-pad,    L-Pad Calculator
2140 DATA matchbox, Matchbox Impedance Transformer
2150 DATA matchnet, Matching Networks for Transistors
2160 DATA maxuf,    Max. Usable Frequencies (MAXIMUF)
2170 DATA mechmenu, MECHANICS Math
2180 DATA metshowr, Meteor Shower Predictor
2190 DATA meters,   Meters (Direct Current)
2200 DATA metrics,  Metric Conversions
2210 DATA microver, MicroVert very short HF Antenna
2220 DATA miniloop, MINILOOP Miniature Loop Antenna
2230 DATA miniquad, MINIQUAD Coil Shortened Antenna
2240 DATA coilamp,  Mobile Whip Antenna Coils
2250 DATA mobilmat, Mobile Antenna Matching
2260 DATA mowhip,   Mobile/Maritime Whip Antennas
2270 DATA moontrac, Moon Tracker
2280 DATA moxon,    Moxon Rectangle Antenna
2290 DATA nicad,    NiCad Battery Discharger
2300 DATA nmbrsize, Numbered Drills/Screws/Taps/Gauges
2310 DATA numsort,  Number Sorter
2320 DATA numderiv, Numbers and Functions
2330 DATA octagon,  Octagonal Loop Framework
2340 DATA octaloop, OCTALOOP Subminiature Loop Antenna
2350 DATA octaring, OCTARING Subminiature Loop Antenna
2360 DATA ocfdipol, "Off-Centre Dipole, 3-band trapless"
2370 DATA ohmslaw,  Ohm's Law Calculator
2380 DATA concur,   OP AMP Constant Current Circuit
2390 DATA opamp,    OP AMP Operational Amplifiers
2400 DATA cascamp,  OP AMPS - Cascaded
2410 DATA noisfig,  OP AMPS - Noise Figure
2420 DATA dishant,  Parabolic Dish Design
2430 DATA fotomenu, PHOTOGRAPHY Math
2440 DATA pimatch,  Pi-Network Impedance Matching
2450 DATA pipesize, Pipe Sizes - ANSI Standard
2460 DATA pixel,    Pixel Data for Scanners & Cameras
2470 DATA polygon,  Polygon Dimensions
2480 DATA potent,   Potentiometers - Custom Value
2490 DATA psup,     Power Supply Analyzer
2500 DATA pwrcct,   Power Supply Design
2510 DATA psuperf,  Power Supply Performance
2520 DATA powrxfmr, Power Transformer Design
2530 DATA pwrxfmr,  Power Transformer Winding Estimator
2540 DATA primenos, Prime Number Calculator
2550 DATA copwire,  Printed Circuit Board Traces
2560 DATA pba,      Pseudo-Brewster Angle
2570 DATA pulsegen, Pulse Generator
2580 DATA qreson,   Q Calculator - Resonant Circuits
2590 DATA foxlog,   QRP Fox Hunt Log
2600 DATA quad,     Quad Antenna Dimensions
2610 DATA quadrat,  Quadratic Equation Calculator
2620 DATA quartwav, Quarter Wave Transformer
2630 DATA radangle, Radiation Angle - Antenna
2640 DATA vertpatt, Radiation Plots - Phased Verticals
2650 DATA randnum,  Random Number Generator
2660 DATA rcconst,  R/C Time Constant
2670 DATA resistiv, Resistivity of Metals
2680 DATA dsgnmenu, Resistor/Inductor/Capacitor Ccts.
2690 DATA colcode,  Resistor Colour Code
2700 DATA resicop,  Resistors - Copper Wire Wound
2710 DATA custohm,  Resistors - Custom Value
2720 DATA precires, Resistors - Precision
2730 DATA resisval, Resistors - Standard Values
2740 DATA smeter,   S-Meter Readings vs. Power
2750 DATA wiresag,  Sag in Horizontal Wire Antennas
2760 DATA satorbit, Satellite Orbit Parameters
2770 DATA scalspd,  Scale Speed Calculator
2780 DATA schmidt,  Schmidt trigger Op Amp
2790 DATA serisect, Series-Section Transformer
2800 DATA centload, Short Centre-Loaded Dipole
2810 DATA cylload,  Short Cylinder-Loaded Dipole
2820 DATA dipol160, Short Dipole for 160/80/40 metres
2830 DATA es2b,     Short ES2B (2 band) Trap Dipole
2840 DATA shortant, Short Off-Centre-Loaded Dipole
2850 DATA shortdip, Short Multiband Dipole Array
2860 DATA simuleq,  Simultaneous Equation Calculator
2870 DATA snglwire, Single Wire Antenna Systems
2880 DATA copwire,  Skin Effect
2890 DATA skipdist, Skip Distance Calculator
2900 DATA sloper,   Sloper Antenna Dimensions
2910 DATA smithcht, Smith Chart Calculations
2920 DATA sorter,   Sorter
2930 DATA speedtd,  Speed/Time/Distance Calculator
2940 DATA stubant,  Stub Match for Antennas
2950 DATA coaxstub, Stubs - Coaxial Transmission Line
2960 DATA transtub, Stubs - Open Wire Transmiss'n Line
2970 DATA riseset,  Sunrise/Sunset Calculator
2980 DATA survey,   Surveyor's Calculator
2990 DATA swr,      SWR Calculator
3000 DATA tmatch,   T Match - Dipole to 600 - Line
3010 DATA tankcct,  Tank Circuit - Power Amplifier
3020 DATA teletube, Telescoping Aluminum Tubing
3030 DATA thermres, Thermal Resistance
3040 DATA psychrom, Thermodynamics
3050 DATA timezone, Time Zones (UTC)
3060 DATA 555timer, Timer (555 IC)
3070 DATA tinycoil, Tiny Coils
3080 DATA torotrap, Toroid Antenna Traps
3090 DATA broadfer, Toroid Baluns & Transformers
3100 DATA toroid,   Toroid Inductors
3110 DATA tracker,  Tracker - Receiver Tuned Circuits
3120 DATA powrxfmr, Transformer Design
3130 DATA xfmrnaro, Transformer - Narrow Band
3140 DATA xfmr,     Transformer Ratios
3150 DATA winding,  Transformer Winding Calculator
3160 DATA trancct,  Transistor Circuit Design
3170 DATA transmat, Transmatch Design (ZL1LE)
3180 DATA node,     Transmission line E and I nodes
3190 DATA elecleng, Transmission Line Length
3200 DATA lineloss, Transmission Line Losses
3210 DATA tranline, Transmission Line Performance
3220 DATA sqcoax,   Transmission Line - Square Coaxial
3230 DATA openwire, Transmission Line - Open Wire
3240 DATA trapole,  Trap Antenna Design
3250 DATA trapcalc, Trap Design Calculator
3260 DATA trapdsgn, Trap Dipole - 3 Band Single Trap
3270 DATA traprop,  Trap Properties Estimator
3280 DATA coaxtrap, Traps - Coaxial Cable
3290 DATA solutri,  Triangles - solution of
3300 DATA trig,     Trigonometric Functions
3310 DATA triplan,  Trip Planner
3320 DATA trunorth, True North via the Sun
3330 DATA tunecct,  Tuned Circuit Design - L/C network
3340 DATA turnrad,  Turning Radius - Beam antennas
3350 DATA tvchan,   TV Channels ( North America )
3360 DATA unitvalu, Unit Value Comparator
3370 DATA helvert,  Vertical Antenna - Helically Wound
3380 DATA varayfed, Vertical Antenna Array Feed Method
3390 DATA vfofreq,  VFO Frequency Calculator
3400 DATA voltdiv,  Voltage Divider
3410 DATA thevinin, Voltage Divider - Thevinin
3420 DATA walwart,  Wall Wart Ratings Calculator
3430 DATA wartest,  Wall Wart Properties
3440 DATA wavetrap, Wave Trap Filters
3450 DATA bridge,   Wheatstone Bridge Calculator
3460 DATA windom,   Windom Antenna
3470 DATA windchil, Wind Chill Factor
3480 DATA wireant,  Wire Antenna Index
3490 DATA wiremesh, Wire Mesh Screens - Wind Loads
3500 DATA wirecond, Wires in Conduit
3510 DATA xmtrzmat, Xmtr. Transistor Stage Coupling
3520 DATA yagi3el,  YAGI 3-Element Beam Design
3530 DATA dialgth,  YAGI Element Diameter vs. Length
3540 DATA yagispac, YAGI Element Spacing/NBS Standard
3550 DATA yagtaper, YAGI Tapered Elements
3560 DATA thruboom, YAGI Through-Boom Elements
3570 DATA yagilong, YAGI Extremely Long VHF/UHF Antenna
3580 DATA zener,    Zener Diode Voltage Regulator
3590 DATA zeppdbl,  Zepp EDZ Antenna
3600 DATA "-"
3610 DATA "-"
3620 DATA "-"
3630 DATA "-"
3640 DATA "-"
3650 DATA "-"
3660 DATA "-"
3670 DATA "-"
3680 DATA "-"
3690 DATA "-"
3700 DATA "-"
3710 DATA "-"
3720 DATA "-"
3730 DATA "-"
3740 DATA "-"
3750 DATA "-"
3760 DATA "-"
3770 DATA "-"
3780 DATA "-"
3790 DATA "-"
3800 DATA "-"
3810 DATA "-"
3820 DATA "-"
3830 DATA "-"
3840 DATA "-"
3850 DATA "-"
3860 DATA "-"
3870 DATA "-"
3880 DATA "-"
3890 DATA "-"
3900 DATA "-"
3910 DATA "-"
3920 DATA "-"
3930 DATA "-"
3940 DATA "-"
3950 DATA "-"
3960 DATA "-"
3970 DATA "-"
3980 DATA "-"
3990 :REM'DATA "-"
4000 DATA \hamcalc\menu\hcal-,Last Menu
4010 DATA \hamcalc\menu\hcal-,Next Menu
4020 DATA \hamcalc\menu\hcal,Main Menu
4030 DATA \hamcalc\prog\hamdex,Index
4040 DATA \hamcalc\prog\exit,EXIT
