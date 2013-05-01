10 :REM'FORMULAE - Formula bank - 05 APR 96 rev. 27 SEP 2008
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$<>""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 UL$=STRING$(80,205)
80 QJ=13    :REM'left margin for graphics
90 :REM'
100 COLOR 15,2
110 PRINT " FORMULA LIBRARY of Frequently Used Equations";
120 PRINT TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 PRINT " Press number in < > for:"
160 PRINT UL$;
170 PRINT "   < 1 > Formulae in metric units"
180 PRINT "   < 2 > Formulae in U.S.A./Imperial units"
190 PRINT
200 PRINT "   < 0 > EXIT"
202 IF Z$="0"THEN CLS:RUN EX$
210 Z$=INKEY$:IF Z$=""THEN 210
220 FLAG=VAL(Z$):IF FLAG<0 OR FLAG>2 THEN 210
230 IF FLAG>0 THEN 260
240 IF Z$="0"THEN CLS:RUN EX$
250 GOTO 210
260 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
270 PRINT " Press letter in < > for:"
280 PRINT UL$;
290 PRINT "   < a >  Antennas"
300 PRINT "   < b >  Capacitance"
310 PRINT "   < c >  Copper wire equations"
320 PRINT "   < d >  Decibels"
330 PRINT "   < e >  Frequency"
340 PRINT "   < f >  Impedance (transmission lines)"
350 PRINT "   < g >  Inductance"
360 PRINT "   < h >  Mathematics"
370 PRINT "   < i >  Ohm's Law / Power"
380 PRINT "   < j >  Reactance"
390 PRINT "   < k >  SWR"
400 PRINT "   < l >  Transmission line physical vs. electrical length"
410 PRINT "   < m >  Shortened antenna physical vs. electrical length"
420 Z$=INKEY$:IF Z$=""THEN 420
430 IF Z$="a"THEN GOSUB 1960:GOTO 3630
440 IF Z$="b"THEN GOSUB 1200:GOTO 3630
450 IF Z$="c"THEN GOSUB 3320:GOTO 3630
460 IF Z$="d"THEN GOSUB 820:GOTO 3630
470 IF Z$="e"THEN GOSUB 580:GOTO 3630
480 IF Z$="f"THEN GOSUB 2700:GOTO 3630
490 IF Z$="g"THEN GOSUB 1580:GOTO 3630
500 IF Z$="h"THEN GOSUB 2310:GOTO 3630
510 IF Z$="i"THEN GOSUB 970:GOTO 3630
520 IF Z$="j"THEN GOSUB 1830:GOTO 3630
530 IF Z$="k"THEN GOSUB 2510:GOTO 3630
540 IF Z$="l"THEN GOSUB 2980:GOTO 3630
550 IF Z$="m"THEN GOSUB 3170:GOTO 3630
560 GOTO 420
570 :REM'
580 :REM'.....frequency
590 CLS:COLOR 0,7
600 LOCATE ,QJ:PRINT "                                                        "
610 LOCATE ,QJ:PRINT "       300           f = frequency in MHz               "
620 LOCATE ,QJ:PRINT "  f = ─────                                             "
630 LOCATE ,QJ:PRINT "        w            w = wavelength in metres           "
640 LOCATE ,QJ:PRINT "                                                        "
650 COLOR 7,0:PRINT :COLOR 0,7
660 LOCATE ,QJ:PRINT "                                                        "
670 LOCATE ,QJ:PRINT "                     f = frequency in kHz               "
680 LOCATE ,QJ:PRINT "        1Σ6          L = inductance in µH               "
690 LOCATE ,QJ:PRINT "  f = ───────        C = capacity in pF                 "
700 LOCATE ,QJ:PRINT "      2π√(LC)        π = 3.141593                       "
710 LOCATE ,QJ:PRINT "                   1Σ6 = 1,000,000                      "
720 LOCATE ,QJ:PRINT "                                                        "
730 COLOR 7,0:PRINT :COLOR 0,7
740 LOCATE ,QJ:PRINT "                                                        "
750 LOCATE ,QJ:PRINT "                    F1 = highest frequency              "
760 LOCATE ,QJ:PRINT " Fc = √(F1 x F2)    Fc = centre frequency               "
770 LOCATE ,QJ:PRINT "                    F2 = lowest frequency               "
780 LOCATE ,QJ:PRINT "                                                        "
790 COLOR 7,0
800 RETURN
810 :REM'
820 :REM'.....decibels
830 CLS:COLOR 0,7
840 LOCATE ,QJ:PRINT "             ┌ P2 ┐    P2 = output power                "
850 LOCATE ,QJ:PRINT " dB = 10 log │────│                                     "
860 LOCATE ,QJ:PRINT "             └ P1 ┘    P1 = input power                 "
870 COLOR 7,0:PRINT :COLOR 0,7
880 LOCATE ,QJ:PRINT "             ┌ V2 ┐    V2 = output voltage              "
890 LOCATE ,QJ:PRINT " dB = 20 log │────│                                     "
900 LOCATE ,QJ:PRINT "             └ V1 ┘    V1 = input voltage               "
910 COLOR 7,0:PRINT :COLOR 0,7
920 LOCATE ,QJ:PRINT "             ┌ I2 ┐    I2 = output current              "
930 LOCATE ,QJ:PRINT " dB = 20 log │────│                                     "
940 LOCATE ,QJ:PRINT "             └ I1 ┘    I1 = input current               "
950 COLOR 7,0
960 RETURN
970 :REM'
980 :REM'.....power
990 CLS:COLOR 0,7
1000 LOCATE ,QJ:PRINT " OHM's LAW                                              "
1010 LOCATE ,QJ:PRINT "                                                        "
1020 LOCATE ,QJ:PRINT "                    E              E                    "
1030 LOCATE ,QJ:PRINT " E = IR        I = ───        R = ───                   "
1040 LOCATE ,QJ:PRINT "                    R              I                    "
1050 LOCATE ,QJ:PRINT "                                                        "
1060 LOCATE ,QJ:PRINT STRING$(56,196)
1070 LOCATE ,QJ:PRINT " POWER                                                  "
1080 LOCATE ,QJ:PRINT "                                                        "
1090 LOCATE ,QJ:PRINT " P = IE        P = power in watts                       "
1100 LOCATE ,QJ:PRINT "                                                        "
1110 LOCATE ,QJ:PRINT "      E²       E = EMF in volts                         "
1120 LOCATE ,QJ:PRINT " P = ───                                                "
1130 LOCATE ,QJ:PRINT "      R        I = current in amperes                   "
1140 LOCATE ,QJ:PRINT "                                                        "
1150 LOCATE ,QJ:PRINT " P = I²R       R = resistance in ohms                   "
1160 LOCATE ,QJ:PRINT "                                                        "
1170 COLOR 7,0
1180 RETURN
1190 :REM'
1200 :REM'.....capacitance
1210 CLS:COLOR 0,7
1220 LOCATE ,QJ:PRINT " CAPACITORS                                             "
1230 LOCATE ,QJ:PRINT "                      C = capacitance in pF             "
1240 LOCATE ,QJ:PRINT "                      A = area of one side of one       "
1250 IF FLAG=1 THEN 1280
1260 LOCATE ,QJ:PRINT "     0.2248 KA              plate in square inches      "
1270 IF FLAG=2 THEN 1290
1280 LOCATE ,QJ:PRINT "     0.0885 KA              plate in square centimetres "
1290 LOCATE ,QJ:PRINT " C = ───────── (n-1)  K = dielectric constant of        "
1300 LOCATE ,QJ:PRINT "         d                  material between plates     "
1310 IF FLAG=1 THEN 1340
1320 LOCATE ,QJ:PRINT "                      d = separation of plates in inches"
1330 IF FLAG=2 THEN 1350
1340 LOCATE ,QJ:PRINT "                      d = separation of plates in cm.   "
1350 LOCATE ,QJ:PRINT "                      n = number of plates              "
1360 COLOR 7,0:PRINT :COLOR 0,7
1370 LOCATE ,QJ:PRINT " COAXIAL CABLE                                          "
1380 LOCATE ,QJ:PRINT "                      ε = dielectric constant           "
1390 IF FLAG=1 THEN 1420
1400 LOCATE ,QJ:PRINT "       7.36 ε         C = capacitance in pF per foot    "
1410 IF FLAG=2 THEN 1430
1420 LOCATE ,QJ:PRINT "     24.147 ε         C = capacitance in pF per metre   "
1430 LOCATE ,QJ:PRINT " C = ─────────        D = ID of outer conductor         "
1440 LOCATE ,QJ:PRINT "     log (D/d)        d = OD of inner conductor         "
1450 COLOR 7,0:PRINT :COLOR 0,7
1460 LOCATE ,QJ:PRINT " CYLINDRICAL VARIABLE CAPACITOR (ε=1 if air-spaced)     "
1470 LOCATE ,QJ:PRINT "                      ε = dielectric constant           "
1480 IF FLAG=1 THEN 1510
1490 LOCATE ,QJ:PRINT "      7.354 ε         C = capacitance in pF per foot    "
1500 IF FLAG=2 THEN 1520
1510 LOCATE ,QJ:PRINT "     24.127 ε         C = capacitance in pF per metre   "
1520 LOCATE ,QJ:PRINT " C = ─────────        D = ID of outer tube              "
1530 LOCATE ,QJ:PRINT "     log (D/d)        d = OD of inner conductor         "
1540 COLOR 7,0:PRINT :COLOR 0,7
1550 COLOR 7,0
1560 RETURN
1570 :REM'
1580 :REM'.....inductance
1590 CLS:COLOR 0,7
1600 LOCATE ,QJ:PRINT "                                                        "
1610 LOCATE ,QJ:PRINT " SINGLE-LAYER AIR-CORE COIL                             "
1620 LOCATE ,QJ:PRINT "                                                        "
1630 LOCATE ,QJ:PRINT "          d²n²                                          "
1640 LOCATE ,QJ:PRINT " L = ─────────────         L = inductance in µH         "
1650 IF FLAG=1 THEN 1690
1660 LOCATE ,QJ:PRINT "       18d + 40l           d = coil diameter in inches  "
1670 LOCATE ,QJ:PRINT "                           l = coil length in inches    "
1680 IF FLAG=2 THEN 1710
1690 LOCATE ,QJ:PRINT "     45.72d+101.6l         d = coil diameter in cm.     "
1700 LOCATE ,QJ:PRINT "                           l = coil length in cm.       "
1710 LOCATE ,QJ:PRINT "                           n = number of turns          "
1720 LOCATE ,QJ:PRINT STRING$(56,196)
1730 IF FLAG=1 THEN 1760
1740 LOCATE ,QJ:PRINT "       √{ L(18d + 40l) }                                "
1750 IF FLAG=2 THEN 1770
1760 LOCATE ,QJ:PRINT "     √{ L(45.72d + 101.6l) }                            "
1770 LOCATE ,QJ:PRINT " n = ───────────────────────                            "
1780 LOCATE ,QJ:PRINT "              d                                         "
1790 LOCATE ,QJ:PRINT "                                                        "
1800 COLOR 7,0
1810 RETURN
1820 :REM'
1830 :REM'.....reactance
1840 CLS:COLOR 0,7
1850 LOCATE ,QJ:PRINT "                                                        "
1860 LOCATE ,QJ:PRINT "              XL = inductive reactance in ohms          "
1870 LOCATE ,QJ:PRINT " XL = 2πƒL    XC = capacitive reactance in ohms         "
1880 LOCATE ,QJ:PRINT "               ƒ = frequency in MHz                     "
1890 LOCATE ,QJ:PRINT "      10^6     L = inductance in µH                     "
1900 LOCATE ,QJ:PRINT " XC = ────     C = capacitance in pF                    "
1910 LOCATE ,QJ:PRINT "      2πƒC     π = 3.141593                             "
1920 LOCATE ,QJ:PRINT "                                                        "
1930 COLOR 7,0
1940 RETURN
1950 :REM'
1960 :REM'.....antenna
1970 CLS:COLOR 0,7
1980 LOCATE ,QJ:PRINT " HALF-WAVE FLAT-TOP ( 3-30 MHz )                        "
1990 LOCATE ,QJ:PRINT "                                                        "
2000 IF FLAG=1 THEN 2030
2010 LOCATE ,QJ:PRINT "     468         L = length in feet                     "
2020 IF FLAG=2 THEN 2040
2030 LOCATE ,QJ:PRINT "     143         L = length in metres                   "
2040 LOCATE ,QJ:PRINT " L = ───                                                "
2050 LOCATE ,QJ:PRINT "      f          f = frequency in Mhz                   "
2060 COLOR 7,0:PRINT :COLOR 0,7
2070 LOCATE ,QJ:PRINT " FULL-WAVE LOOP (3-30 MHz )                             "
2080 LOCATE ,QJ:PRINT "                                                        "
2090 IF FLAG=1 THEN 2120
2100 LOCATE ,QJ:PRINT "       1005    DRI = length of driven element in feet   "
2110 IF FLAG=2 THEN 2130
2120 LOCATE ,QJ:PRINT "       306.3   DRI = length of driven element in metres "
2130 LOCATE ,QJ:PRINT " DRI = ─────   REF = length of reflector                "
2140 LOCATE ,QJ:PRINT "         f     DIR = length of director                 "
2150 LOCATE ,QJ:PRINT "                 f = frequency in MHz                   "
2160 LOCATE ,QJ:PRINT "                                                        "
2170 LOCATE ,QJ:PRINT " REF = 1.025 x DRI                                      "
2180 LOCATE ,QJ:PRINT " DIR = 0.970 x DRI                                      "
2190 COLOR 7,0:PRINT :COLOR 0,7
2200 LOCATE ,QJ:PRINT " FULL-SIZE VERTICAL                                     "
2210 LOCATE ,QJ:PRINT "                                                        "
2220 IF FLAG=1 THEN 2250
2230 LOCATE ,QJ:PRINT "     234         L = length in feet                     "
2240 IF FLAG=2 THEN 2260
2250 LOCATE ,QJ:PRINT "     71.3        L = length in metres                   "
2260 LOCATE ,QJ:PRINT " L = ───                                                "
2270 LOCATE ,QJ:PRINT "      f          f = frequency in Mhz                   "
2280 COLOR 7,0
2290 RETURN
2300 :REM'
2310 :REM'.....mathematics
2320 CLS:COLOR 0,7
2330 LOCATE ,QJ:PRINT "                                                        "
2340 LOCATE ,QJ:PRINT " π = 3.141593                                           "
2350 LOCATE ,QJ:PRINT "                                                        "
2360 LOCATE ,QJ:PRINT " Circumference of circle = π x diameter                 "
2370 LOCATE ,QJ:PRINT "                                                        "
2380 LOCATE ,QJ:PRINT " Area of circle = π x radius²                           "
2390 LOCATE ,QJ:PRINT "                                                        "
2400 LOCATE ,QJ:PRINT " As used in HAMCALC:                                    "
2410 LOCATE ,QJ:PRINT "  a METER is an apparatus for measuring (e.g voltmeter)."
2420 LOCATE ,QJ:PRINT "  a METRE is a unit of measurement in the metric system."
2430 LOCATE ,QJ:PRINT "                                                        "
2440 LOCATE ,QJ:PRINT " metres = feet x .3048      feet = metres ÷ .3048       "
2450 LOCATE ,QJ:PRINT " centimetres = in. x 2.54   inches = cm ÷ 2.54          "
2460 LOCATE ,QJ:PRINT " millimetres = in. x 25.4   inches = mm ÷ 25.4          "
2470 LOCATE ,QJ:PRINT "                                                        "
2480 COLOR 7,0
2490 RETURN
2500 :REM'
2510 :REM'.....SWR
2520 CLS:COLOR 0,7
2530 LOCATE ,QJ:PRINT " SWR  (STANDING WAVE RATIO)                             "
2540 LOCATE ,QJ:PRINT "                                                        "
2550 LOCATE ,QJ:PRINT "        ┌ Pr ┐                                          "
2560 LOCATE ,QJ:PRINT "   p = √│ ── │                                          "
2570 LOCATE ,QJ:PRINT "        └ Pf ┘      p = reflection coefficient          "
2580 LOCATE ,QJ:PRINT "                                                        "
2590 LOCATE ,QJ:PRINT "       SWR-1       Pr = reflected power                 "
2600 LOCATE ,QJ:PRINT "   p = ─────                                            "
2610 LOCATE ,QJ:PRINT "       SWR+1       Pf = forward power                   "
2620 LOCATE ,QJ:PRINT "                                                        "
2630 LOCATE ,QJ:PRINT "       1 + p      SWR = standing wave ratio             "
2640 LOCATE ,QJ:PRINT " SWR = ─────                                            "
2650 LOCATE ,QJ:PRINT "       1 - p                                            "
2660 LOCATE ,QJ:PRINT "                                                        "
2670 COLOR 7,0
2680 RETURN
2690 :REM'
2700 :REM'.....impedance (transmission line)
2710 CLS:COLOR 0,7
2720 LOCATE ,QJ:PRINT " AIR-INSULATED PARALLEL CONDUCTOR LINE                  "
2730 LOCATE ,QJ:PRINT "                  ▌                                     "
2740 LOCATE ,QJ:PRINT "              2S  ▌Zo = characteristic impedance        "
2750 LOCATE ,QJ:PRINT " Zo = 276 log ─── ▌ S = c.c distance between conductors "
2760 LOCATE ,QJ:PRINT "               d  ▌ d = diameter of conductors          "
2770 LOCATE ,QJ:PRINT "                  ▌     ( S & d in same units)          "
2780 LOCATE ,QJ:PRINT "                  ▌                                     "
2790 COLOR 7,0:PRINT:COLOR 0,7
2800 LOCATE ,QJ:PRINT " AIR-INSULATED COAXIAL LINE                             "
2810 LOCATE ,QJ:PRINT "                  ▌                                     "
2820 LOCATE ,QJ:PRINT "               b  ▌Zo = characteristic impedance        "
2830 LOCATE ,QJ:PRINT " Zo = 138 log ─── ▌ b = ID of outer conductor           "
2840 LOCATE ,QJ:PRINT "               a  ▌ a = OD of inner conductor           "
2850 LOCATE ,QJ:PRINT "                  ▌     ( b & a in same units)          "
2860 LOCATE ,QJ:PRINT "                  ▌                                     "
2870 COLOR 7,0:PRINT:COLOR 0,7
2880 LOCATE ,QJ:PRINT " ANY TRANSMISSION LINE                                  "
2890 LOCATE ,QJ:PRINT "                 ▌                                      "
2900 LOCATE ,QJ:PRINT "       ┌ 1Σ6 L ┐ ▌ Zo = characteristic impedance        "
2910 LOCATE ,QJ:PRINT " Zo = √│ ───── │ ▌  L = inductance (µH) per unit length "
2920 LOCATE ,QJ:PRINT "       └   C   ┘ ▌  C = capacitance (pF) per unit length"
2930 LOCATE ,QJ:PRINT "                 ▌1Σ6 = 1,000,000                       "
2940 LOCATE ,QJ:PRINT "                 ▌                                      "
2950 COLOR 7,0
2960 RETURN
2970 :REM'
2980 :REM'.....transmission lines
2990 CLS:COLOR 0,7
3000 LOCATE ,QJ:PRINT "                                                        "
3010 LOCATE ,QJ:PRINT " TRANSMISSION LINE PHYSICAL vs. ELECTRICAL LENGTH       "
3020 LOCATE ,QJ:PRINT "                                                        "
3030 IF FLAG=1 THEN 3060
3040 LOCATE ,QJ:PRINT "     983.56 V    L = length (feet) of one wavelength    "
3050 IF FLAG=2 THEN 3070
3060 LOCATE ,QJ:PRINT "     299.79 V    L = length (metres) of one wavelength  "
3070 LOCATE ,QJ:PRINT " L = ────────    V = velocity factor (decimal value)    "
3080 LOCATE ,QJ:PRINT "         ƒ       ƒ = frequency in MHz                   "
3090 LOCATE ,QJ:PRINT "                 Σ = dielectric constant                "
3100 LOCATE ,QJ:PRINT "     1                                                  "
3110 LOCATE ,QJ:PRINT " V = ──                                                 "
3120 LOCATE ,QJ:PRINT "     √Σ                                                 "
3130 LOCATE ,QJ:PRINT "                                                        "
3140 COLOR 7,0
3150 RETURN
3160 :REM'
3170 :REM'.....shortened antennas
3180 CLS:COLOR 0,7
3190 LOCATE ,QJ:PRINT "                                                        "
3200 LOCATE ,QJ:PRINT " SHORTENED ANTENNA PHYSICAL vs. ELECTRICAL LENGTH       "
3210 LOCATE ,QJ:PRINT "                                                        "
3220 IF FLAG=1 THEN 3250
3230 LOCATE ,QJ:PRINT "     32.8 L    h = length (inches)                      "
3240 IF FLAG=2 THEN 3260
3250 LOCATE ,QJ:PRINT "     83.3 L    h = length (centimetres)                 "
3260 LOCATE ,QJ:PRINT " h = ──────    L = electrical length (degrees)          "
3270 LOCATE ,QJ:PRINT "       ƒ       ƒ = frequency in MHz                     "
3280 LOCATE ,QJ:PRINT "                                                        "
3290 COLOR 7,0
3300 RETURN
3310 :REM'
3320 :REM'.....copper wire
3330 CLS:COLOR 0,7
3340 LOCATE ,QJ:PRINT "                                                        "
3350 IF FLAG=2 THEN 3410
3360 LOCATE ,QJ:PRINT "        1                                               "
3370 LOCATE ,QJ:PRINT " R = ────────       R = ohms per kilometre              "
3380 LOCATE ,QJ:PRINT "     .1822 a²       a = radius of wire in mm.           "
3390 LOCATE ,QJ:PRINT "                                                        "
3400 IF FLAG=1 THEN 3460
3410 LOCATE ,QJ:PRINT "       1.67                                             "
3420 LOCATE ,QJ:PRINT " R = ────────       R = ohms per 1000 feet              "
3430 LOCATE ,QJ:PRINT "     (25.4a)²       a = radius of wire in decimal inches"
3440 LOCATE ,QJ:PRINT "                                                        "
3450 LOCATE ,QJ:PRINT "                                                        "
3460 LOCATE ,QJ:COLOR 7,0:PRINT STRING$(40,32):COLOR 0,7
3470 LOCATE ,QJ:PRINT "                                                        "
3480 IF FLAG=2 THEN 3510
3490 LOCATE ,QJ:PRINT "        11.68       D = diameter in millimetres         "
3500 IF FLAG=1 THEN 3520
3510 LOCATE ,QJ:PRINT "         .46        D = diameter in inches              "
3520 LOCATE ,QJ:PRINT " D = ────────────                                       "
3530 LOCATE ,QJ:PRINT "     1.1229^(n+3)   n = AWG number                      "
3540 LOCATE ,QJ:PRINT "                                                        "
3550 LOCATE ,QJ:COLOR 7,0:PRINT STRING$(40,32):COLOR 0,7
3560 LOCATE ,QJ:PRINT "                                                        "
3570 LOCATE ,QJ:PRINT "     log(.46/D)       D = diameter in inches            "
3580 LOCATE ,QJ:PRINT " n = ────────── - 3                                     "
3590 LOCATE ,QJ:PRINT "     log 1.1229       n = AWG number                    "
3600 LOCATE ,QJ:PRINT "                                                        "
3610 RETURN
3620 :REM'
3630 :REM'.....end
3640 GOSUB 3680
3650 GOTO 10
3660 END
3670 :REM'
3680 :REM'PRT
3690 KEY OFF:GOSUB 3760:LOCATE 25,5:COLOR 0,2
3700 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3710 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3720 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3720 :ELSE GOSUB 3760
3730 IF Z$="3"THEN RETURN
3740 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3750 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3690
3760 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
