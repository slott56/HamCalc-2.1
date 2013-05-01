10 :REM'\hamcalc\menu\HCAL-X   02 JUN 94 rev. 14 JUN 2010
20 CHDIR "\hamcalc\prog"
30 CLS:KEY OFF
40 COMMON EX$,Z$
50 IF EX$=""THEN EX$="exit"
60 IF X$=""THEN X$="X"
70 :REM'
80 U$=STRING$(80,205)
90 DIM B$(500),C$(500)
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
260 IF X$="I"THEN Y=320
270  FOR N=1 TO 360
280  READ B$(N),C$(N)
290  NEXT N
300 LOCATE 5
310 FOR Z=1 TO 20
320 IF Z<10 THEN Z$="0#:":ELSE Z$="##:"
330 PRINT " ";USING Z$;Z;:PRINT " ";C$(Z+Y);         :REM'left hand column
340 PRINT TAB(41);
350 PRINT USING "##:";Z+20;:PRINT " ";C$(Z+Y+20);    :REM'right hand column
360 IF Z<20 THEN PRINT ""
370 NEXT Z
380 :REM'
390 LOCATE 25,1:PRINT STRING$(80,32);      :REM'menu options
400 LOCATE 25   :REM'.....bottom line
410 LOCATE ,40:COLOR 0,7:PRINT" 41:MENU  ";" 42:INDEX  ";" 43:EXIT ";
420 COLOR 7,0:LOCATE 3,2  :REM'....header
430 Z$=""
440 COLOR 0,7:PRINT " TYPE one of the 2-digit numbers listed below - ";
450 PRINT "DO NOT press <ENTER>:";
460 COLOR 7,0:PRINT U$;
470 I$=INKEY$:IF I$=""THEN 470
480 Z$=Z$+I$
490 IF LEN(Z$)<2 THEN 470 :ELSE 520
500 IF VAL(Z$)>43 GOTO 600
510 GOTO 470
520 P=VAL(Z$)
530 IF P>43 THEN 600
540 IF P=41 THEN CLS:CHAIN"\hamcalc\menu\hcal"
550 IF P=42 THEN CLS:CHAIN"\hamcalc\prog\hamdex"
560 IF P=43 THEN CLS:RUN "exit"
570 P=P+Y
580 Y$=B$(P)
590 IF Y$=""OR Y$="-"THEN 600 :ELSE COLOR 7,0,0:CLS:CHAIN Y$
600 LOCATE 3:COLOR 7,0:PRINT STRING$(80,32);:LOCATE CSRLIN-1:COLOR 0,7
610 BEEP:PRINT " ";Z$;" is not a valid number...press any key to try again..."
620 IF INKEY$=""THEN 620 :ELSE 420
630 :REM'.......DATA
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
3900 DATA "-","-"
3910 DATA "-","-"
3920 DATA "-","-"
3930 DATA "-","-"
3940 DATA "-","-"
3950 DATA "-","-"
3960 DATA "-","-"
3970 DATA "-","-"
3980 DATA "-","-"
3990 DATA "-","-"
4000 DATA "-","-"
4010 DATA "-","-"
4020 DATA "-","-"
4030 DATA "-","-"
4040 DATA "-","-"
4050 DATA "-","-"
4060 DATA "-","-"
4070 DATA "-","-"
4080 DATA "-","-"
4090 DATA "-","-"
4100 DATA "-","-"
4110 DATA "-","-"
4120 DATA "-","-"
4130 DATA "-","-"
4140 DATA "-","-"
4150 DATA "-","-"
4160 DATA "-","-"
4170 DATA "-","-"
4180 DATA "-","-"
4190 DATA "-","-"
4200 DATA "-","-"
4210 DATA "-","-"
4220 DATA "-","-"
4230 DATA "-","-"
