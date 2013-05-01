10 :REM'\hamcalc\menu\HCAL-X   02 JUN 94 rev. 26 JAN 2010
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
1150 DATA cmosc3,   CMOS Oscillator
1160 DATA coaxchar, Coax Cable Characteristics
1170 DATA coaxlc3,  Coax Cable L/C Tank
1180 DATA chokbal,  Coax Cable RF Chokes & Baluns
1190 DATA coaxtrap, Coax Cable Traps
1200 DATA buxtrap , Coax Cable Hi-Reactance SuperTrap
1210 DATA cw,       Code Trainer (Morse Code)
1220 DATA coilnew,  Coil Calculator- Dehoney equations
1230 DATA coilequa, Coil Calculator- Wheeler equations
1240 DATA coilq,    Coil Q Calculator
1250 DATA coildsgn, Coil Designer
1260 DATA coilquik, Coil Q Quick Estimator
1270 DATA coiltrue, Coil Q - True vs. Apparent
1280 DATA coilnew,  Coil Tap Calculators
1290 DATA coiltap,  Coil Tap Properties
1300 DATA turns,    Coil Turns Calculator
1310 DATA coilcpl,  Coils - Coaxially coupled
1320 DATA coilnew,  Coils in Tandem
1330 DATA coilin,   Coils - Insulated Wire
1340 DATA colposc,  Colpitts FET Oscillator
1350 DATA conecalc, Cone Calculator
1360 DATA conjumat, Conjugate Match Calculator
1370 DATA phazdiff, Constant Phase Difference Networks
1380 DATA copwire,  Copper Wire Data
1390 DATA xover,    Crossover Networks - Loudspeakers
1400 DATA crysfilt, Crystal Ladder Filter
1410 DATA curvefit, Curve Fit program
1420 DATA cylload,  CYLOAD antenna
1430 DATA daydusk,  Daylight Dusk and Dawn Calculator
1440 DATA decibel,  Decibel Calculator
1450 DATA decifrac, Decimal/Fraction Converter
1460 DATA deciconv, Decimal Hour/Degree Converter
1470 DATA binary,   Decimal to Binary Converter
1480 DATA rjd,      Dehoney Algorithm Index
1490 DATA deltamat, Delta Match
1500 DATA diamfind, Diameter Finder
1510 DATA dielect,  Dielectric Constants
1520 DATA discone,  Discone Multiband Antenna
1530 DATA duopole,  Dual Band Short Dipole Antenna
1540 DATA seasons,  Equinoxes & Solstices
1550 DATA elspec,   Electromagnetic Spectrum
1560 DATA fatdipol, Fat Dipole (broadband)
1570 DATA fibon,    Fibonacci Series
1580 DATA buttfilt, Filters - Butterworth HF
1590 DATA comfile   Filters - Complementary
1600 DATA cplres,   Filters - Coupled Resonator
1610 DATA filtrlc,  Filters - Passive R/L/C
1620 DATA filstrip, Filters - Stripline Bandpass
1630 DATA finance,  Financial Calculators
1640 DATA fishbone, Fishbone Antenna
1650 DATA foldipol, Folded Dipole - 300- Twin-Lead
1660 DATA zostepup, Folded Dipole - Zo Step-Up Ratios
1670 DATA formulae, Formula Library
1680 DATA fusewire, Fuses - Emergency
1690 DATA g5rv,     G5RV Multiband Antenna
1700 DATA gammatch, Gamma Match
1710 DATA graphs,   Graphs
1720 DATA pathfind, Great Circle Paths & Distances
1730 DATA gridsq,   Grid Square Locator (Maidenhead)
1740 DATA guywires, Guy Wires for Antenna Towers/Masts
1750 DATA hairpin,  Hairpin Beta-Match for Yagis
1760 DATA halfloop, Half-Loop Low Profile Antenna
1770 DATA hambands, Ham Band Edge & Centre Frequencies
1780 DATA harmonic, Harmonic Frequencies
1790 DATA hartosc,  Hartly FET Oscillator
1800 DATA hotbox,   Heat Dissipation
1810 DATA sink,     Heat Sink Fins
1820 DATA helant,   Helical Antenna - VHF/UHF
1830 DATA helreson, Helical Resonators (VHF/UHF)
1840 DATA helix,    Helical Winding
1850 DATA qtrap,    High Q Antenna Traps
1860 DATA humid,    Humidex Calculator
1870 DATA 3mbridge, Impedance Bridge (3-meter)
1880 DATA impednet, Impedance Matching Networks
1890 DATA impedmetr,Impedance Meter
1900 DATA antimp,   Impedance - Antennas
1910 DATA impares,  Impedance - Parallel Resonant Cct.
1920 DATA impedcct, Impedance - Reactance/Resist. Cct.
1930 DATA inducalc, Inductance Calculator
1940 DATA induloop, Inductance - Single Loops
1950 DATA induhose, Inductors - Dryer Vent Hose
1960 DATA inloss,   Insertion Loss
1970 DATA invee,    Inverted Vee Antenna
1980 DATA jcalc,    J Calculator (Complex Impedances)
1990 DATA jaypole,  J-Pole End-Fed Zepp Antenna
2000 DATA kfactor,  K-Factor & Antenna Length (NEC-2)
2010 DATA ladder2,  Ladder Network - 2 element
2020 DATA ladrsolv, Ladder Network Analyzer
2030 DATA lamplife, Lamp Life Expectancy
2040 DATA latlong,  Latitude/Longitude Data Base
2050 DATA led,      LED Series Resistor
2060 DATA radiolos, Line-of-Sight Radio Wave
2070 DATA linkupl,  Link Coupled Tuners
2080 DATA lm317,    LM317 Voltage Regulator
2090 DATA deltload, Load Resistance Calculator
2100 DATA localrpt, Local Repeaters
2110 DATA zounds,   Music Math & Sounds
2120 DATA numderiv, Logarithms to any base
2130 DATA logyag,   LOG-YAG Log-Periodic Yagi Antenna
2140 DATA pairlt,   Long-Tailed Pair
2150 DATA loopant,  Loop Antenna Coil Inductance
2160 DATA loopxmit, Loop Antennas - Transmitting
2170 DATA loopsky,  Loop Skywire Dimensions
2180 DATA l-pad,    L-Pad Calculator
2190 DATA brick,    Masonry Estimator
2200 DATA matchbox, Matchbox Impedance Transformer
2210 DATA matchnet, Matching Networks for Transistors
2220 DATA maxuf,    Max. Usable Frequencies (MAXIMUF)
2230 DATA mechmenu, MECHANICS Math
2240 DATA metshowr, Meteor Shower Predictor
2250 DATA meters,   Meters (Direct Current)
2260 DATA metrics,  Metric Conversions
2270 DATA metnom,   Metronome
2280 DATA microver, MicroVert very short HF Antenna
2290 DATA miniloop, MINILOOP Miniature Loop Antenna
2300 DATA miniquad, MINIQUAD Coil Shortened Antenna
2310 DATA coilamp,  Mobile Whip Antenna Coils
2320 DATA mobilmat, Mobile Antenna Matching
2330 DATA mowhip,   Mobile/Maritime Whip Antennas
2340 DATA moontrac, Moon Tracker
2350 DATA moxon,    Moxon Rectangle Antenna
2360 DATA zounds,   Musical Math & Sounds
2370 DATA nicad,    NiCad Battery Discharger
2380 DATA nmbrsize, Numbered Drills/Screws/Taps/Gauges
2390 DATA numsort,  Number Sorter
2400 DATA numderiv, Numbers and Functions
2410 DATA octagon,  Octagonal Loop Framework
2420 DATA octaloop, OCTALOOP Subminiature Loop Antenna
2430 DATA octaring, OCTARING Subminiature Loop Antenna
2440 DATA ocfdipol, "Off-Centre Dipole, 3-band trapless"
2450 DATA ohmslaw,  Ohm's Law Calculator
2460 DATA concur,   OP AMP Constant Current Circuit
2470 DATA opamp,    OP AMP Operational Amplifiers
2480 DATA cascamp,  OP AMPS - Cascaded
2490 DATA noisfig,  OP AMPS - Noise Figure
2500 DATA dishant,  Parabolic Dish Design
2510 DATA pedom,    Pedometer
2520 DATA fotomenu, PHOTOGRAPHY Math
2530 DATA pitnet,  Pi and T Networks
2540 DATA pipesize, Pipe Sizes - ANSI Standard
2550 DATA pixel,    Pixel Data for Scanners & Cameras
2560 DATA polygon,  Polygon Dimensions
2570 DATA potent,   Potentiometers - Custom Value
2580 DATA psup,     Power Supply Analyzer
2590 DATA pwrcct,   Power Supply Design
2600 DATA dblbrg4,  Power Supply - Double Bridge
2610 DATA psuperf,  Power Supply Performance
2620 DATA powrxfmr, Power Transformer Design
2630 DATA pwrxfmr,  Power Transformer Winding Estimator
2640 DATA primenos, Prime Number Calculator
2650 DATA copwire,  Printed Circuit Board Traces
2660 DATA pba,      Pseudo-Brewster Angle
2670 DATA pulsegen, Pulse Generator
2680 DATA qreson,   Q Calculator - Resonant Circuits
2690 DATA foxlog,   QRP Fox Hunt Log
2700 DATA qmeas,    Q of L/C Tank Circuit
2710 DATA quad,     Quad Antenna Dimensions
2720 DATA quadrat,  Quadratic Equation Calculator
2730 DATA quartwav, Quarter Wave Transformer
2740 DATA radangle, Radiation Angle - Antenna
2750 DATA vertpatt, Radiation Plots - Phased Verticals
2760 DATA randnum,  Random Number Generator
2770 DATA rcconst,  R/C Time Constant
2780 DATA react,    Reactance Programs
2790 DATA dsgnmenu, Resistor/Inductor/Capacitor Ccts.
2800 DATA colcode,  Resistor Colour Code
2810 DATA resicop,  Resistors - Copper Wire Wound
2820 DATA custohm,  Resistors - Custom Value
2830 DATA precires, Resistors - Precision
2840 DATA resisval, Resistors - Standard Values
2850 DATA smeter,   S-Meter Readings vs. Power
2860 DATA catenary, Sag in Horizontal Wire Antennas
2870 DATA satorbit, Satellite Orbit Parameters
2880 DATA scalspd,  Scale Speed Calculator
2890 DATA schmidt,  Schmidt trigger Op Amp
2900 DATA serisect, Series-Section Transformer
2910 DATA centload, Short Centre-Loaded Dipole
2920 DATA cylload,  Short Cylinder-Loaded Dipole
2930 DATA dipol160, Short Dipole for 160/80/40 metres
2940 DATA es2b,     Short ES2B (2 band) Trap Dipole
2950 DATA shortant, Short Off-Centre-Loaded Dipole
2960 DATA shortdip, Short Multiband Dipole Array
2970 DATA simuleq,  Simultaneous Equation Calculator
2980 DATA snglwire, Single Wire Antenna Systems
2990 DATA copwire,  Skin Effect
3000 DATA skipdist, Skip Distance Calculator
3010 DATA sloper,   Sloper Antenna Dimensions
3020 DATA smithcht, Smith Chart Calculations
3030 DATA sorter,   Sorter
3040 DATA speedtd,  Speed/Time/Distance Calculator
3050 DATA stubant,  Stub Match for Antennas
3060 DATA coaxstub, Stubs - Coaxial Transmission Line
3070 DATA transtub, Stubs - Open Wire Transmiss'n Line
3080 DATA riseset,  Sunrise/Sunset Calculator
3090 DATA survey,   Surveyor's Calculator
3100 DATA swr,      SWR Calculator
3110 DATA t2fd,     T2FD Tilted Folded Dipole
3120 DATA tmatch,   T Match - Dipole to 600 - Line
3130 DATA tankcct,  Tank Circuit - Power Amplifier
3140 DATA teletube, Telescoping Aluminum Tubing
3150 DATA thermres, Thermal Resistance
3160 DATA psychrom, Thermodynamics
3170 DATA timeq,    Time Quiz
3180 DATA timezone, Time Zones (UTC)
3190 DATA 555timer, Timer (555 IC)
3200 DATA tinycoil, Tiny Coils
3210 DATA torotrap, Toroid Antenna Traps
3220 DATA broadfer, Toroid Baluns & Transformers
3230 DATA toroid,   Toroid Inductors
3240 DATA tracker,  Tracker - Receiver Tuned Circuits
3250 DATA powrxfmr, Transformer Design
3260 DATA xfmrnaro, Transformer - Narrow Band
3270 DATA xfmr,     Transformer Ratios
3280 DATA winding,  Transformer Winding Calculator
3290 DATA trancct,  Transistor Circuit Design
3300 DATA transmat, Transmatch Design (ZL1LE)
3310 DATA chokbal,  Transmission Line Choke
3320 DATA elecleng, Transmission Line Length
3330 DATA lineloss, Transmission Line Losses
3340 DATA mismat,   Transmission Line Mismatch
3350 DATA node,     Transmission Line Node Locator
3360 DATA tranline, Transmission Line Performance
3370 DATA sqcoax,   Transmission Line - Square Coaxial
3380 DATA openwire, Transmission Line - Open Wire
3390 DATA qline2,   Transmission Line Q
3400 DATA trapole,  Trap Antenna Design
3410 DATA trapcalc, Trap Design Calculator
3420 DATA trapdsgn, Trap Dipole - 3 Band Single Trap
3430 DATA traprop,  Trap Properties Estimator
3440 DATA coaxtrap, Traps - Coaxial Cable
3450 DATA solutri,  Triangles - solution of
3460 DATA trig,     Trigonometric Functions
3470 DATA triplan,  Trip Planner
3480 DATA trunorth, True North via the Sun
3490 DATA tunecct,  Tuned Circuit Design - L/C network
3500 DATA turnrad,  Turning Radius - Beam antennas
3510 DATA tvchan,   TV Channels ( North America )
3520 DATA unitvalu, Unit Value Comparator
3530 DATA helvert,  Vertical Antenna - Helically Wound
3540 DATA varayfed, Vertical Antenna Array Feed Method
3550 DATA vfofreq,  VFO Frequency Calculator
3560 DATA voltdiv,  Voltage Divider
3570 DATA thevinin, Voltage Divider - Thevinin
3580 DATA walwart,  Wall Wart Ratings Calculator
3590 DATA wartest,  Wall Wart Properties
3600 DATA wavetrap, Wave Trap Filters
3610 DATA bridge,   Wheatstone Bridge Calculator
3620 DATA windom,   Windom Antenna
3630 DATA windchil, Wind Chill Factor
3640 DATA wireant,  Wire Antenna Index
3650 DATA wiremesh, Wire Mesh Screens - Wind Loads
3660 DATA wirecond, Wires in Conduit
3670 DATA xmtrzmat, Xmtr. Transistor Stage Coupling
3680 DATA yagi3el,  YAGI 3-Element Beam Design
3690 DATA dialgth,  YAGI Element Diameter vs. Length
3700 DATA yagispac, YAGI Element Spacing/NBS Standard
3710 DATA yagtaper, YAGI Tapered Elements
3720 DATA thruboom, YAGI Through-Boom Elements
3730 DATA yagilong, YAGI Extremely Long VHF/UHF Antenna
3740 DATA zener,    Zener Diode Voltage Regulator
3750 DATA zeppdbl,  Zepp (extended double) Antenna
3760 DATA zepp,     Zepp Multi-band antenna
3770 DATA "-","-"
3790 DATA "-","-"
3800 DATA "-","-"
3810 DATA "-","-"
3820 DATA "-","-"
3830 DATA "-","-"
