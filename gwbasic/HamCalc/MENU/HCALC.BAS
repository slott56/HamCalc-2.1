10 :REM'\hamcalc\menu\HCAL-X   02 JUN 94 rev. 02 FEB 2008
20 CHDIR "\hamcalc\prog"
30 CLS:KEY OFF
40 COMMON EX$
50 IF X$=""THEN X$="X"
60 COLOR ,,0
70 :REM'
80 U$=STRING$(80,205)
90 DIM B$(350),C$(350)
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
340 FOR N=1 TO 325
350 READ B$(N),C$(N)
360 NEXT N
370 B$(321)=B$(321)+I$
380 B$(322)=B$(322)+J$
390 :REM'
400 FOR Z=1 TO 20
410 IF Z<10 THEN Z$="0#:":ELSE Z$="##:"
420 PRINT " ";USING Z$;Z;:PRINT " ";C$(Z+Y);         :REM'left hand column
430 COLOR 15,1
440 PRINT TAB(41);
450 PRINT USING "##:";Z+20;:PRINT " ";C$(Z+Y+20);    :REM'right hand column
460 IF Z<20 THEN PRINT ""
470 NEXT Z
480 :REM'
490 COLOR 0,7:LOCATE 25,1:PRINT STRING$(80,32);      :REM'menu options
500 X=16:W=-X+1
510 FOR Z=1 TO 5
520 LOCATE 25,W+(X*Z)
530 COLOR 1:PRINT "██";
540 COLOR 0
550 PRINT USING "###:";40+Z;:PRINT C$(320+Z);
560 NEXT Z
570 LOCATE 25,79:COLOR 1:PRINT STRING$(2,"█");
580 LOCATE 3,2
590 COLOR 14,4
600 Z$=""
610 PRINT " TYPE one of the 2-digit numbers listed below - ";
620 PRINT "DO NOT press <ENTER>:"
630 I$=INKEY$:IF I$=""THEN 630
640 Z$=Z$+I$
650 IF LEN(Z$)<2 THEN 630 :ELSE 670
660 GOTO 630
670 P=VAL(Z$)
680 IF P>=41 AND P<=45 THEN Y$=B$(280+P):GOTO 730
690 IF P=0 OR P>45 THEN 740
700 IF P>=43 AND P<=45 THEN P=P+280
710 P=P+Y
720 Y$=B$(P)
730 IF Y$=""OR Y$="-"THEN 740 :ELSE COLOR 7,0,0:CLS:CHAIN Y$
740 LOCATE 3:COLOR ,1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
750 BEEP:PRINT " ";Z$;" is not a valid number...press any key to try again..."
760 IF INKEY$=""THEN 760
770 LOCATE CSRLIN-1:COLOR ,1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 570
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
1270 DATA clamp,    Clamping Voltage Calculator
1280 DATA coaxchar, Coax Cable Characteristics
1290 DATA chobal6,  Coax Cable RF Chokes & Baluns
1300 DATA coaxtrap, Coax Cable Traps
1310 DATA buxtrap , Coax Cable Hi-Reactance SuperTrap
1320 DATA cw,       Code Trainer (Morse Code)
1330 DATA coilnew,  Coil Calculator- Dehoney equations
1340 DATA coilequa, Coil Calculator- Wheeler equations
1350 DATA coilq,    Coil Q Calculator
1360 DATA coildsgn, Coil Designer
1370 DATA coilquik, Coil Q Quick Estimator
1380 DATA coiltrue, Coil Q - True vs. Apparent
1390 DATA coilnew,  Coil Tap Calculators
1400 DATA coilcpl,  Coils - Coaxially coupled
1410 DATA coilnew,  Coils in Tandem
1420 DATA conecalc, Cone Calculator
1430 DATA conjumat, Conjugate Match Calculator
1440 DATA phazdiff, Constant Phase Difference Networks
1450 DATA copwire,  Copper Wire Data
1460 DATA xover,    Crossover Networks - Loudspeakers
1470 DATA crysfilt, Crystal Ladder Filter
1480 DATA curvefit, Curve Fit program
1490 DATA cylload,  CYLOAD antenna
1500 DATA daydusk,  Daylight Dusk and Dawn Calculator
1510 DATA decibel,  Decibel Calculator
1520 DATA decifrac, Decimal/Fraction Converter
1530 DATA deciconv, Decimal Hour/Degree Converter
1540 DATA binary,   Decimal to Binary Converter
1550 DATA deltamat, Delta Match
1560 DATA diamfind, Diameter Finder
1570 DATA dielect,  Dielectric Constants
1580 DATA discone,  Discone Multiband Antenna
1590 DATA duopole,  Dual Band Short Dipole Antenna
1600 DATA seasons,  Equinoxes & Solstices
1610 DATA equiv,    Equivalent Values
1620 DATA fatdipol, Fat Dipole (broadband)
1630 DATA fibon,    Fibonacci Series
1640 DATA buttfilt, Filters - Butterworth HF
1650 DATA filtrlc,  Filters - Passive R/L/C
1660 DATA filstrip, Filters - Stripline Bandpass
1670 DATA finance,  Financial Calculators
1680 DATA fishbone, Fishbone Antenna
1690 DATA foldipol, Folded Dipole - 300- Twin-Lead
1700 DATA zostepup, Folded Dipole - Zo Step-Up Ratios
1710 DATA formulae, Formula Library
1720 DATA fusewire, Fuses - Emergency
1730 DATA g5rv,     G5RV Multiband Antenna
1740 DATA gammatch, Gamma Match
1750 DATA graphs,   Graphs
1760 DATA pathfind, Great Circle Paths & Distances
1770 DATA gridsq,   Grid Square Locator (Maidenhead)
1780 DATA guywires, Guy Wires for Antenna Towers/Masts
1790 DATA hairpin,  Hairpin Beta-Match for Yagis
1800 DATA halfloop, Half-Loop Low Profile Antenna
1810 DATA hambands, Ham Band Edge & Centre Frequencies
1820 DATA harmonic, Harmonic Frequencies
1830 DATA helant,   Helical Antenna - VHF/UHF
1840 DATA helreson, Helical Resonators (VHF/UHF)
1850 DATA helix,    Helical Winding
1860 DATA 3mbridge, Impedance Bridge (3-meter)
1870 DATA impednet, Impedance Matching Networks
1880 DATA impedmetr,Impedance Meter
1890 DATA antimp,   Impedance - Antennas
1900 DATA impares,  Impedance - Parallel Resonant Cct.
1910 DATA impedcct, Impedance - Reactance/Resist. Cct.
1920 DATA inducalc, Inductance Calculator
1930 DATA induloop, Inductance - Single Loops
1940 DATA induhose, Inductors - Dryer Vent Hose
1950 DATA invee,    Inverted Vee Antenna
1960 DATA jcalc,    J Calculator (Complex Impedances)
1970 DATA jaypole,  J-Pole End-Fed Zepp Antenna
1980 DATA kfactor,  K-Factor & Antenna Length (NEC-2)
1990 DATA ladder2,  Ladder Network - 2 element
2000 DATA ladrsolv, Ladder Network Analyzer
2010 DATA lamplife, Lamp Life Expectancy
2020 DATA latlong,  Latitude/Longitude Data Base
2030 DATA led,      LED Series Resistor
2040 DATA radiolos, Line-of-Sight Radio Wave
2050 DATA linkupl,  Link Coupled Tuners
2060 DATA lm317,    LM317 Voltage Regulator
2070 DATA deltload, Load Resistance Calculator
2080 DATA localrpt, Local Repeaters
2090 DATA numderiv, Logarithms to any base
2100 DATA logyag,   LOG-YAG Log-Periodic Yagi Antenna
2110 DATA loopant,  Loop Antenna Coil Inductance
2120 DATA loopxmit, Loop Antennas - Transmitting
2130 DATA loopsky,  Loop Skywire Dimensions
2140 DATA l-pad,    L-Pad Calculator
2150 DATA matchbox, Matchbox Impedance Transformer
2160 DATA matchnet, Matching Networks for Transistors
2170 DATA maxuf,    Max. Usable Frequencies (MAXIMUF)
2180 DATA mechmenu, MECHANICS Math
2190 DATA metshowr, Meteor Shower Predictor
2200 DATA meters,   Meters (Direct Current)
2210 DATA metrics,  Metric Conversions
2220 DATA microver, MicroVert very short HF Antenna
2230 DATA miniloop, MINILOOP Miniature Loop Antenna
2240 DATA miniquad, MINIQUAD Coil Shortened Antenna
2250 DATA coilamp,  Mobile Whip Antenna Coils
2260 DATA mobilmat, Mobile Antenna Matching
2270 DATA mowhip,   Mobile/Maritime Whip Antennas
2280 DATA moontrac, Moon Tracker
2290 DATA moxon,    Moxon Rectangle Antenna
2300 DATA nicad,    NiCad Battery Discharger
2310 DATA nmbrsize, Numbered Drills/Screws/Taps/Gauges
2320 DATA numsort,  Number Sorter
2330 DATA numderiv, Numbers and Functions
2340 DATA octagon,  Octagonal Loop Framework
2350 DATA octaloop, OCTALOOP Subminiature Loop Antenna
2360 DATA octaring, OCTARING Subminiature Loop Antenna
2370 DATA ocfdipol, "Off-Centre Dipole, 3-band trapless"
2380 DATA ohmslaw,  Ohm's Law Calculator
2390 DATA concur,   OP AMP Constant Current Circuit
2400 DATA opamp,    OP AMP Operational Amplifiers
2410 DATA cascamp,  OP AMPS - Cascaded
2420 DATA noisfig,  OP AMPS - Noise Figure
2430 DATA dishant,  Parabolic Dish Design
2440 DATA fotomenu, PHOTOGRAPHY Math
2450 DATA pimatch,  Pi-Network Impedance Matching
2460 DATA pipesize, Pipe Sizes - ANSI Standard
2470 DATA pixel,    Pixel Data for Scanners & Cameras
2480 DATA polygon,  Polygon Dimensions
2490 DATA potent,   Potentiometers - Custom Value
2500 DATA psup,     Power Supply Analyzer
2510 DATA pwrcct,   Power Supply Design
2520 DATA psuperf,  Power Supply Performance
2530 DATA powrxfmr, Power Transformer Design
2540 DATA pwrxfmr,  Power Transformer Winding Estimator
2550 DATA primenos, Prime Number Calculator
2560 DATA copwire,  Printed Circuit Board Traces
2570 DATA pba,      Pseudo-Brewster Angle
2580 DATA pulsegen, Pulse Generator
2590 DATA qreson,   Q Calculator - Resonant Circuits
2600 DATA foxlog,   QRP Fox Hunt Log
2610 DATA quad,     Quad Antenna Dimensions
2620 DATA quadrat,  Quadratic Equation Calculator
2630 DATA quartwav, Quarter Wave Transformer
2640 DATA radangle, Radiation Angle - Antenna
2650 DATA vertpatt, Radiation Plots - Phased Verticals
2660 DATA randnum,  Random Number Generator
2670 DATA rcconst,  R/C Time Constant
2680 DATA resistiv, Resistivity of Metals
2690 DATA dsgnmenu, Resistor/Inductor/Capacitor Ccts.
2700 DATA colcode,  Resistor Colour Code
2710 DATA resicop,  Resistors - Copper Wire Wound
2720 DATA custohm,  Resistors - Custom Value
2730 DATA precires, Resistors - Precision
2740 DATA resisval, Resistors - Standard Values
2750 DATA smeter,   S-Meter Readings vs. Power
2760 DATA wiresag,  Sag in Horizontal Wire Antennas
2770 DATA satorbit, Satellite Orbit Parameters
2780 DATA scalspd,  Scale Speed Calculator
2790 DATA schmidt,  Schmidt trigger Op Amp
2800 DATA serisect, Series-Section Transformer
2810 DATA centload, Short Centre-Loaded Dipole
2820 DATA cylload,  Short Cylinder-Loaded Dipole
2830 DATA dipol160, Short Dipole for 160/80/40 metres
2840 DATA es2b,     Short ES2B (2 band) Trap Dipole
2850 DATA shortant, Short Off-Centre-Loaded Dipole
2860 DATA shortdip, Short Multiband Dipole Array
2870 DATA simuleq,  Simultaneous Equation Calculator
2880 DATA snglwire, Single Wire Antenna Systems
2890 DATA copwire,  Skin Effect
2900 DATA skipdist, Skip Distance Calculator
2910 DATA sloper,   Sloper Antenna Dimensions
2920 DATA smithcht, Smith Chart Calculations
2930 DATA sorter,   Sorter
2940 DATA speedtd,  Speed/Time/Distance Calculator
2950 DATA stubant,  Stub Match for Antennas
2960 DATA coaxstub, Stubs - Coaxial Transmission Line
2970 DATA transtub, Stubs - Open Wire Transmiss'n Line
2980 DATA riseset,  Sunrise/Sunset Calculator
2990 DATA survey,   Surveyor's Calculator
3000 DATA swr,      SWR Calculator
3010 DATA tmatch,   T Match - Dipole to 600 - Line
3020 DATA tankcct,  Tank Circuit - Power Amplifier
3030 DATA teletube, Telescoping Aluminum Tubing
3040 DATA thermres, Thermal Resistance
3050 DATA psychrom, Thermodynamics
3060 DATA timezone, Time Zones (UTC)
3070 DATA 555timer, Timer (555 IC)
3080 DATA tinycoil, Tiny Coils
3090 DATA torotrap, Toroid Antenna Traps
3100 DATA broadfer, Toroid Baluns & Transformers
3110 DATA toroid,   Toroid Inductors
3120 DATA tracker,  Tracker - Receiver Tuned Circuits
3130 DATA powrxfmr, Transformer Design
3140 DATA xfmrnaro, Transformer - Narrow Band
3150 DATA xfmr,     Transformer Ratios
3160 DATA winding,  Transformer Winding Calculator
3170 DATA trancct,  Transistor Circuit Design
3180 DATA transmat, Transmatch Design (ZL1LE)
3190 DATA elecleng, Transmission Line Length
3200 DATA lineloss, Transmission Line Losses
3210 DATA node,     Transmission Line Node Locator
3220 DATA tranline, Transmission Line Performance
3230 DATA sqcoax,   Transmission Line - Square Coaxial
3240 DATA openwire, Transmission Line - Open Wire
3250 DATA trapole,  Trap Antenna Design
3260 DATA trapcalc, Trap Design Calculator
3270 DATA trapdsgn, Trap Dipole - 3 Band Single Trap
3280 DATA traprop,  Trap Properties Estimator
3290 DATA coaxtrap, Traps - Coaxial Cable
3300 DATA solutri,  Triangles - solution of
3310 DATA trig,     Trigonometric Functions
3320 DATA triplan,  Trip Planner
3330 DATA trunorth, True North via the Sun
3340 DATA tunecct,  Tuned Circuit Design - L/C network
3350 DATA turnrad,  Turning Radius - Beam antennas
3360 DATA tvchan,   TV Channels ( North America )
3370 DATA unitvalu, Unit Value Comparator
3380 DATA helvert,  Vertical Antenna - Helically Wound
3390 DATA varayfed, Vertical Antenna Array Feed Method
3400 DATA vfofreq,  VFO Frequency Calculator
3410 DATA voltdiv,  Voltage Divider
3420 DATA thevinin, Voltage Divider - Thevinin
3430 DATA walwart,  Wall Wart Ratings Calculator
3440 DATA wartest,  Wall Wart Properties
3450 DATA wavetrap, Wave Trap Filters
3460 DATA bridge,   Wheatstone Bridge Calculator
3470 DATA windom,   Windom Antenna
3480 DATA windchil, Wind Chill Factor
3490 DATA wireant,  Wire Antenna Index
3500 DATA wiremesh, Wire Mesh Screens - Wind Loads
3510 DATA wirecond, Wires in Conduit
3520 DATA xmtrzmat, Xmtr. Transistor Stage Coupling
3530 DATA yagi3el,  YAGI 3-Element Beam Design
3540 DATA dialgth,  YAGI Element Diameter vs. Length
3550 DATA yagispac, YAGI Element Spacing/NBS Standard
3560 DATA yagtaper, YAGI Tapered Elements
3570 DATA thruboom, YAGI Through-Boom Elements
3580 DATA yagilong, YAGI Extremely Long VHF/UHF Antenna
3590 DATA zener,    Zener Diode Voltage Regulator
3600 DATA zeppdbl,  Zepp EDZ Antenna
3610 :REM'DATA "-"
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
3990 DATA "-"
4000 DATA "-"
4010 DATA "-"
4020 DATA "-"
4030 DATA "-"
4040 DATA "-"
4050 DATA "-"
4060 DATA "-"
4070 DATA "-"
4080 DATA "-"
4090 DATA "-"
4100 DATA "-"
4110 DATA "-"
4120 DATA "-"
4130 DATA "-"
4140 DATA "-"
4150 DATA "-"
4160 DATA "-"
4170 DATA "-"
4180 DATA "-"
4190 DATA "-"
4200 DATA "-"
4210 DATA "-"
4220 DATA "-"
4230 DATA "-"
4240 DATA "-"
4250 DATA "-"
4260 DATA "-"
4270 DATA "-"
4280 DATA "-"
4290 DATA "-"
4300 DATA "-"
4310 DATA "-"
4320 DATA "-"
4330 DATA "-"
4340 DATA "-"
4350 DATA "-"
4360 DATA "-"
4370 DATA "-"
4375 DATA "-"
4380 DATA \hamcalc\menu\hcal-,Last Menu
4390 DATA \hamcalc\menu\hcal-,Next Menu
4400 DATA \hamcalc\menu\hcal,Main Menu
4410 DATA \hamcalc\prog\hamdex,Index
4420 DATA \hamcalc\prog\exit,EXIT
