10 :REM'\hamcalc\menu\HCAL-X   02 JUN 94 rev..24 NOV 2009
20 :REM'CHDIR "\hamcalc\prog"
30 CLS:KEY OFF
40 COMMON EX$
50 IF X$=""THEN X$="X"
60 COLOR ,,0
70 :REM'
80 U$=STRING$(80,205)
90 DIM B$(350),C$(350)
100 ON ERROR  GOTO 220
110 PRINT " H A M C A L C  Program Menu ";:COLOR 14,4:PRINT " "+X$+" ";
120 COLOR 15,1
130 PRINT TAB(57);"by George Murphy VE3ERP ";
140 COLOR 7,1
150 PRINT STRING$(80,223);
160 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3    :REM'set background colour
170 COLOR 15,1
180 PRINT
190 PRINT U$;
200 N=0:GOTO 240
210 :REM'
220 PRINT "Error ";ERR;" in line ";ERL:END
230 :REM'
240 IF X$="A"THEN Y=0:   I$="g":J$="b"
250 IF X$="B"THEN Y=40:  I$="a":J$="c"
260 IF X$="C"THEN Y=80:  I$="b":J$="d"
270 IF X$="D"THEN Y=120: I$="c":J$="e"
280 IF X$="E"THEN Y=160: I$="d":J$="f"
290 IF X$="F"THEN Y=200: I$="e":J$="g"
300 IF X$="G"THEN Y=240: I$="f":J$="h"
310 IF X$="H"THEN Y=280: I$="g":J$="a"
320 :REM'
330 FOR N=1 TO 320
340 READ B$(N),C$(N)
350 NEXT N
360 :REM'B$(321)=B$(321)+I$
370 :REM'B$(322)=B$(322)+J$
380 :REM'
390 FOR Z=1 TO 20
400 IF Z<10 THEN Z$="0#:":ELSE Z$="##:"
410 PRINT " ";USING Z$;Z;:PRINT " ";C$(Z+Y);         :REM'left hand column
420 COLOR 15,1
430 PRINT TAB(41);
440 PRINT USING "##:";Z+20;:PRINT " ";C$(Z+Y+20);    :REM'right hand column
450 IF Z<20 THEN PRINT ""
460 NEXT Z
470 :REM'
480 COLOR 0,7:LOCATE 25,1:PRINT STRING$(80,32);      :REM'menu options
490 X=16:W=-X+1
500 FOR Z=1 TO 5
510 LOCATE 25,W+(X*Z)
520 COLOR 1:PRINT "██";
530 COLOR 0
540 PRINT USING "###:";40+Z;:PRINT B$(318+Z);
550 NEXT Z
560 LOCATE 25,79:COLOR 1:PRINT STRING$(2,"█");
570 LOCATE 3,2
580 COLOR 14,4
590 Z$=""
600 PRINT " TYPE one of the 2-digit numbers listed below - ";
610 PRINT "DO NOT press <ENTER>:"
620 I$=INKEY$:IF I$=""THEN 620
630 Z$=Z$+I$
640 IF LEN(Z$)<2 THEN 620 :ELSE 660
650 GOTO 620
660 P=VAL(Z$)
670 IF P>=41 AND P<=45 THEN Y$=B$(280+P):GOTO 720
680 IF P=0 OR P>45 THEN 730
690 IF P>=43 AND P<=45 THEN P=P+280
700 P=P+Y
710 Y$=B$(P)
720 IF Y$=""OR Y$="-"THEN 730 :ELSE COLOR 7,0,0:CLS:CHAIN Y$
730 LOCATE 3:COLOR ,1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
740 BEEP:PRINT " ";Z$;" is not a valid number...press any key to try again..."
750 IF INKEY$=""THEN 750
760 LOCATE CSRLIN-1:COLOR ,1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 560
770 :REM'.......Data
780 DATA accalc,   A.C. Circuit Calculator
790 DATA antfield, Antenna Field Strength
800 DATA antscale, Antenna Frequency Scaling
810 DATA impant,   Antenna Impedance Calculator
820 DATA antenna,  Antenna Length/Pruning calculator
830 DATA antmatch, Antenna Matching Networks
840 DATA arch,     Arch Calculator
850 DATA page437,  ASCII Character Code Page 437
860 DATA attenpad,"Attenuators: T-Pad and Pi-Pad"
870 DATA audfilt,  Audio Bandpass Filter - Active
880 DATA lopass,   Audio Lowpass Filter(Sallen & Key)
890 DATA audpass,  Audio Filters - Passive
900 DATA rcfilt,   Audio Filters - RC Active
910 DATA audosc,   Audio Oscillator (LM 324)
920 DATA audosc2,  Audio Oscillator (LF 353)dual wave
930 DATA twintee,  Audio Oscillator (Twin-T)
940 DATA zounds,   Audio Programs
950 DATA awgexact, A.W.G. Wire Size Calculator
960 DATA bend,     Bend Allowance - Metals
970 DATA aircore,  B.& W. Air-Core Inductors
980 DATA broadfer, Baluns - Ferrite Toroid
990 DATA bandstop, Band-Reject Filter
1000 DATA bandq,    Bandwidth vs. Q
1010 DATA bandwdth,"Bandwidths - 2:1 SWR"
1020 DATA baromtr,  Barometer Reading Equivalents
1030 DATA batchg,   Battery Charger
1040 DATA dialgth,  Beam Element Diameter vs Length
1050 DATA pathfind, Beam Heading Calculator
1060 DATA bevant,   Beverage Antenna Equations
1070 DATA bobtail,  Bobtail Curtain Antenna
1080 DATA boom,     Boom Droop - Beam Antennas
1090 DATA spark,    Breakdown Voltage
1100 DATA caltoday, Calendar - Perpetual/Universal
1110 DATA calory,   Calorie Counter
1120 DATA capstray, Capacitance - Distributed (stray)
1130 DATA captance, Capacitor Design Calculator
1140 DATA capval,   Capacitor Measurer
1150 DATA gaplot,   Capacitor Plate Designer
1160 DATA capcoax,  Capacitors - Coaxial Cable
1170 DATA custcap,  Capacitors - Custom Value
1180 DATA precicap, Capacitors - Precision
1190 DATA capacval, Capacitors - Standard Values
1200 DATA capytel,  Capacitors - Telescoping Variable
1210 DATA trimr,    Capacitors - Trimmer
1220 DATA hatshape, Capacity Hat Geometric Shapes
1230 DATA capyhat,  Capacity Hats - Vertical Antennas
1240 DATA rotaplot, Cartesian/Polar Plot Rotator
1250 DATA ccdanten, CCD Antennas
1260 DATA centfreq, Centre Frequency & Wavelength
1270 DATA propcirc, Circle - Properies of
1280 DATA circfeed, Circular Waveguide Dish Feeds
1290 DATA clamp,    Clamping Voltage Calculator
1300 DATA cmosc3,   CMOS Oscillator
1310 DATA coaxchar, Coax Cable Characteristics
1320 DATA coaxlc3,  Coax Cable L/C Tank
1330 DATA chokbal,  Coax Cable RF Chokes & Baluns
1340 DATA coaxtrap, Coax Cable Traps
1350 DATA buxtrap , Coax Cable Hi-Reactance SuperTrap
1360 DATA cw,       Code Trainer (Morse Code)
1370 DATA coilnew,  Coil Calculator- Dehoney equations
1380 DATA coilequa, Coil Calculator- Wheeler equations
1390 DATA coilq,    Coil Q Calculator
1400 DATA coildsgn, Coil Designer
1410 DATA coilquik, Coil Q Quick Estimator
1420 DATA coiltrue, Coil Q - True vs. Apparent
1430 DATA coilnew,  Coil Tap Calculators
1440 DATA coiltap,  Coil Tap Properties
1450 DATA turns,    Coil Turns Calculator
1460 DATA coilcpl,  Coils - Coaxially coupled
1470 DATA coilnew,  Coils in Tandem
1480 DATA coilin,   Coils - Insulated Wire
1490 DATA colposc,  Colpitts FET Oscillator
1500 DATA conecalc, Cone Calculator
1510 DATA conjumat, Conjugate Match Calculator
1520 DATA phazdiff, Constant Phase Difference Networks
1530 DATA copwire,  Copper Wire Data
1540 DATA xover,    Crossover Networks - Loudspeakers
1550 DATA crysfilt, Crystal Ladder Filter
1560 DATA curvefit, Curve Fit program
1570 DATA cylload,  CYLOAD antenna
1580 DATA daydusk,  Daylight Dusk and Dawn Calculator
1590 DATA decibel,  Decibel Calculator
1600 DATA decifrac, Decimal/Fraction Converter
1610 DATA deciconv, Decimal Hour/Degree Converter
1620 DATA binary,   Decimal to Binary Converter
1630 DATA rjd,      Dehoney Algorithm Index
1640 DATA deltamat, Delta Match
1650 DATA diamfind, Diameter Finder
1660 DATA dielect,  Dielectric Constants
1670 DATA discone,  Discone Multiband Antenna
1680 DATA duopole,  Dual Band Short Dipole Antenna
1690 DATA seasons,  Equinoxes & Solstices
1700 DATA elspec,   Electromagnetic Spectrum
1710 DATA fatdipol, Fat Dipole (broadband)
1720 DATA fibon,    Fibonacci Series
1730 DATA buttfilt, Filters - Butterworth HF
1740 DATA cplres,   Filters - Coupled Resonator
1750 DATA filtrlc,  Filters - Passive R/L/C
1760 DATA filstrip, Filters - Stripline Bandpass
1770 DATA finance,  Financial Calculators
1780 DATA fishbone, Fishbone Antenna
1790 DATA foldipol, Folded Dipole - 300- Twin-Lead
1800 DATA zostepup, Folded Dipole - Zo Step-Up Ratios
1810 DATA formulae, Formula Library
1820 DATA fusewire, Fuses - Emergency
1830 DATA g5rv,     G5RV Multiband Antenna
1840 DATA gammatch, Gamma Match
1850 DATA graphs,   Graphs
1860 DATA pathfind, Great Circle Paths & Distances
1870 DATA gridsq,   Grid Square Locator (Maidenhead)
1880 DATA guywires, Guy Wires for Antenna Towers/Masts
1890 DATA hairpin,  Hairpin Beta-Match for Yagis
1900 DATA halfloop, Half-Loop Low Profile Antenna
1910 DATA hambands, Ham Band Edge & Centre Frequencies
1920 DATA harmonic, Harmonic Frequencies
1930 DATA hartosc,  Hartly FET Oscillator
1940 DATA hotbox,   Heat Dissipation
1950 DATA sink,     Heat Sink Fins
1960 DATA helant,   Helical Antenna - VHF/UHF
1970 DATA helreson, Helical Resonators (VHF/UHF)
1980 DATA helix,    Helical Winding
1990 DATA qtrap,    High Q Antenna Traps
2000 DATA humid,    Humidex Calculator
2010 DATA 3mbridge, Impedance Bridge (3-meter)
2020 DATA impednet, Impedance Matching Networks
2030 DATA impedmetr,Impedance Meter
2040 DATA antimp,   Impedance - Antennas
2050 DATA impares,  Impedance - Parallel Resonant Cct.
2060 DATA impedcct, Impedance - Reactance/Resist. Cct.
2070 DATA inducalc, Inductance Calculator
2080 DATA induloop, Inductance - Single Loops
2090 DATA induhose, Inductors - Dryer Vent Hose
2100 DATA inloss,   Insertion Loss
2110 DATA invee,    Inverted Vee Antenna
2120 DATA jcalc,    J Calculator (Complex Impedances)
2130 DATA jaypole,  J-Pole End-Fed Zepp Antenna
2140 DATA kfactor,  K-Factor & Antenna Length (NEC-2)
2150 DATA ladder2,  Ladder Network - 2 element
2160 DATA ladrsolv, Ladder Network Analyzer
2170 DATA lamplife, Lamp Life Expectancy
2180 DATA latlong,  Latitude/Longitude Data Base
2190 DATA led,      LED Series Resistor
2200 DATA radiolos, Line-of-Sight Radio Wave
2210 DATA linkupl,  Link Coupled Tuners
2220 DATA lm317,    LM317 Voltage Regulator
2230 DATA deltload, Load Resistance Calculator
2240 DATA localrpt, Local Repeaters
2250 DATA zounds,   Music Math & Sounds
2260 DATA numderiv, Logarithms to any base
2270 DATA logyag,   LOG-YAG Log-Periodic Yagi Antenna
2280 DATA pairlt,   Long-Tailed Pair
2290 DATA loopant,  Loop Antenna Coil Inductance
2300 DATA loopxmit, Loop Antennas - Transmitting
2310 DATA loopsky,  Loop Skywire Dimensions
2320 DATA l-pad,    L-Pad Calculator
2330 DATA brick,    Masonry Estimator
2340 DATA matchbox, Matchbox Impedance Transformer
2350 DATA matchnet, Matching Networks for Transistors
2360 DATA maxuf,    Max. Usable Frequencies (MAXIMUF)
2370 DATA mechmenu, MECHANICS Math
2380 DATA metshowr, Meteor Shower Predictor
2390 DATA meters,   Meters (Direct Current)
2400 DATA metrics,  Metric Conversions
2410 DATA metnom,   Metronome
2420 DATA microver, MicroVert very short HF Antenna
2430 DATA miniloop, MINILOOP Miniature Loop Antenna
2440 DATA miniquad, MINIQUAD Coil Shortened Antenna
2450 DATA coilamp,  Mobile Whip Antenna Coils
2460 DATA mobilmat, Mobile Antenna Matching
2470 DATA mowhip,   Mobile/Maritime Whip Antennas
2480 DATA moontrac, Moon Tracker
2490 DATA moxon,    Moxon Rectangle Antenna
2500 DATA zounds,   Musical Math & Sounds
2510 DATA nicad,    NiCad Battery Discharger
2520 DATA nmbrsize, Numbered Drills/Screws/Taps/Gauges
2530 DATA numsort,  Number Sorter
2540 DATA numderiv, Numbers and Functions
2550 DATA octagon,  Octagonal Loop Framework
2560 DATA octaloop, OCTALOOP Subminiature Loop Antenna
2570 DATA octaring, OCTARING Subminiature Loop Antenna
2580 DATA ocfdipol, "Off-Centre Dipole, 3-band trapless"
2590 DATA ohmslaw,  Ohm's Law Calculator
2600 DATA concur,   OP AMP Constant Current Circuit
2610 DATA opamp,    OP AMP Operational Amplifiers
2620 DATA cascamp,  OP AMPS - Cascaded
2630 DATA noisfig,  OP AMPS - Noise Figure
2640 DATA dishant,  Parabolic Dish Design
2650 DATA pedom,    Pedometer
2660 DATA fotomenu, PHOTOGRAPHY Math
2670 DATA pitnet,  Pi and T Networks
2680 DATA pipesize, Pipe Sizes - ANSI Standard
2690 DATA pixel,    Pixel Data for Scanners & Cameras
2700 DATA polygon,  Polygon Dimensions
2710 DATA potent,   Potentiometers - Custom Value
2720 DATA psup,     Power Supply Analyzer
2730 DATA pwrcct,   Power Supply Design
2740 DATA dblbrg4,  Power Supply - Double Bridge
2750 DATA psuperf,  Power Supply Performance
2760 DATA powrxfmr, Power Transformer Design
2770 DATA pwrxfmr,  Power Transformer Winding Estimator
2780 DATA primenos, Prime Number Calculator
2790 DATA copwire,  Printed Circuit Board Traces
2800 DATA pba,      Pseudo-Brewster Angle
2810 DATA pulsegen, Pulse Generator
2820 DATA qreson,   Q Calculator - Resonant Circuits
2830 DATA foxlog,   QRP Fox Hunt Log
2840 DATA qmeas,    Q of L/C Tank Circuit
2850 DATA quad,     Quad Antenna Dimensions
2860 DATA quadrat,  Quadratic Equation Calculator
2870 DATA quartwav, Quarter Wave Transformer
2880 DATA radangle, Radiation Angle - Antenna
2890 DATA vertpatt, Radiation Plots - Phased Verticals
2900 DATA randnum,  Random Number Generator
2910 DATA rcconst,  R/C Time Constant
2920 DATA react,    Reactance Programs
2930 DATA resistiv, Resistivity of Metals
2940 DATA dsgnmenu, Resistor/Inductor/Capacitor Ccts.
2950 DATA colcode,  Resistor Colour Code
2960 DATA resicop,  Resistors - Copper Wire Wound
2970 DATA custohm,  Resistors - Custom Value
2980 DATA precires, Resistors - Precision
2990 DATA resisval, Resistors - Standard Values
3000 DATA smeter,   S-Meter Readings vs. Power
3010 DATA catenary, Sag in Horizontal Wire Antennas
3020 DATA satorbit, Satellite Orbit Parameters
3030 DATA scalspd,  Scale Speed Calculator
3040 DATA schmidt,  Schmidt trigger Op Amp
3050 DATA serisect, Series-Section Transformer
3060 DATA centload, Short Centre-Loaded Dipole
3070 DATA cylload,  Short Cylinder-Loaded Dipole
3080 DATA dipol160, Short Dipole for 160/80/40 metres
3090 DATA es2b,     Short ES2B (2 band) Trap Dipole
3100 DATA shortant, Short Off-Centre-Loaded Dipole
3110 DATA shortdip, Short Multiband Dipole Array
3120 DATA simuleq,  Simultaneous Equation Calculator
3130 DATA snglwire, Single Wire Antenna Systems
3140 DATA copwire,  Skin Effect
3150 DATA skipdist, Skip Distance Calculator
3160 DATA sloper,   Sloper Antenna Dimensions
3170 DATA smithcht, Smith Chart Calculations
3180 DATA sorter,   Sorter
3190 DATA speedtd,  Speed/Time/Distance Calculator
3200 DATA watch,    Stopwatch
3210 DATA stubant,  Stub Match for Antennas
3220 DATA coaxstub, Stubs - Coaxial Transmission Line
3230 DATA transtub, Stubs - Open Wire Transmiss'n Line
3240 DATA riseset,  Sunrise/Sunset Calculator
3250 DATA survey,   Surveyor's Calculator
3260 DATA swr,      SWR Calculator
3270 DATA t2fd,     T2FD Tilted Folded Dipole
3280 DATA tmatch,   T Match - Dipole to 600 - Line
3290 DATA tankcct,  Tank Circuit - Power Amplifier
3300 DATA teletube, Telescoping Aluminum Tubing
3310 DATA thermres, Thermal Resistance
3320 DATA psychrom, Thermodynamics
3330 DATA timeq,    Time Quiz
3340 DATA timezone, Time Zones (UTC)
3350 DATA 555timer, Timer (555 IC)
3360 DATA tinycoil, Tiny Coils
3370 DATA torotrap, Toroid Antenna Traps
3380 DATA broadfer, Toroid Baluns & Transformers
3390 DATA toroid,   Toroid Inductors
3400 DATA tracker,  Tracker - Receiver Tuned Circuits
3410 DATA powrxfmr, Transformer Design
3420 DATA xfmrnaro, Transformer - Narrow Band
3430 DATA xfmr,     Transformer Ratios
3440 DATA winding,  Transformer Winding Calculator
3450 DATA trancct,  Transistor Circuit Design
3460 DATA transmat, Transmatch Design (ZL1LE)
3470 DATA chokbal,  Transmission Line Choke
3480 DATA elecleng, Transmission Line Length
3490 DATA lineloss, Transmission Line Losses
3500 DATA mismat,   Transmission Line Mismatch
3510 DATA node,     Transmission Line Node Locator
3520 DATA tranline, Transmission Line Performance
3530 DATA sqcoax,   Transmission Line - Square Coaxial
3540 DATA openwire, Transmission Line - Open Wire
3550 DATA qline2,   Transmission Line Q
3560 DATA trapole,  Trap Antenna Design
3570 DATA trapcalc, Trap Design Calculator
3580 DATA trapdsgn, Trap Dipole - 3 Band Single Trap
3590 DATA traprop,  Trap Properties Estimator
3600 DATA coaxtrap, Traps - Coaxial Cable
3610 DATA solutri,  Triangles - solution of
3620 DATA trig,     Trigonometric Functions
3630 DATA triplan,  Trip Planner
3640 DATA trunorth, True North via the Sun
3650 DATA tunecct,  Tuned Circuit Design - L/C network
3660 DATA turnrad,  Turning Radius - Beam antennas
3670 DATA tvchan,   TV Channels ( North America )
3680 DATA unitvalu, Unit Value Comparator
3690 DATA helvert,  Vertical Antenna - Helically Wound
3700 DATA varayfed, Vertical Antenna Array Feed Method
3710 DATA vfofreq,  VFO Frequency Calculator
3720 DATA voltdiv,  Voltage Divider
3730 DATA thevinin, Voltage Divider - Thevinin
3740 DATA walwart,  Wall Wart Ratings Calculator
3750 DATA wartest,  Wall Wart Properties
3760 DATA wavetrap, Wave Trap Filters
3770 DATA bridge,   Wheatstone Bridge Calculator
3780 DATA windom,   Windom Antenna
3790 DATA windchil, Wind Chill Factor
3800 DATA wireant,  Wire Antenna Index
3810 DATA wiremesh, Wire Mesh Screens - Wind Loads
3820 DATA wirecond, Wires in Conduit
3830 DATA xmtrzmat, Xmtr. Transistor Stage Coupling
3840 DATA yagi3el,  YAGI 3-Element Beam Design
3850 DATA dialgth,  YAGI Element Diameter vs. Length
3860 DATA yagispac, YAGI Element Spacing/NBS Standard
3870 DATA yagtaper, YAGI Tapered Elements
3880 DATA thruboom, YAGI Through-Boom Elements
3890 DATA yagilong, YAGI Extremely Long VHF/UHF Antenna
3900 DATA zener,    Zener Diode Voltage Regulator
3910 DATA zeppdbl,  Zepp (extended double) Antenna
3920 DATA zepp,     Zepp Multi-band antenna
3930 DATA "-"
3940 DATA "-"
3950 DATA "-"
3960 DATA "-"
3970 DATA "-"
3980 DATA "Last Menu"
3990 DATA "Next Menu"
4000 DATA "Main Menu"
4010 DATA \prog\hamdex,Index
4020 DATA \prog\exit,EXIT
