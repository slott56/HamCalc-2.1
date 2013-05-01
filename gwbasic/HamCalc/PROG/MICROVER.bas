10 :REM'MICROVER - Microvert Antenna - 30 SEP 2004
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 UL$=STRING$(80,205)
80 :REM'
90 :REM'.....title page
100 CLS:COLOR 15,2,1
110 PRINT " DL7PE MicroVert HF Antenna";TAB(57);"by George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 LOCATE CSRLIN-1,20
140 COLOR 15,2:PRINT" Antenna design by Juergen Schaefer DL7PE "
150 COLOR 7,0,0:PRINT
160 GOSUB 1250    :REM'diagram
170 GOSUB 2650
180 :REM'.....menu
190 COLOR 7,0,0:CLS:PRINT  "MENU:"
200 PRINT UL$;
210 PRINT " To run program..........press 4"
220 PRINT " For description.........press 5"
230 PRINT " For construction notes..press 6"
240 PRINT " For equations...........press 7"
250 PRINT " To EXIT.................press 0"
260 X$=INKEY$:IF X$=""THEN 260
270 IF X$="4"THEN COLOR 7,0,0:CLS:GOTO 340
280 IF X$="5"THEN COLOR 7,0,0:CLS:GOSUB 1490:GOSUB 2650:GOTO 190
290 IF X$="6"THEN COLOR 7,0,0:CLS:GOSUB 1880:GOSUB 2650:GOTO 190
300 IF X$="7"THEN COLOR 7,0,0:CLS:GOSUB 2260:GOSUB 2650:GOTO 190
310 IF X$="0"THEN COLOR 7,0,0:CLS:CHAIN EX$
320 GOTO 260
330 :REM'
340 :REM'.....start
350 CLS:GOSUB 1250
360 PRINT
370 INPUT "ENTER: Design Frequency (MHz)";F
380 W=300/F                 :REM'wavelength
390 IF F<=30 THEN 450 :ELSE BEEP:CLS
400 PRINT "The MicroVert is not designed for frequencies higher than 30 MHz!"
410 PRINT ".....press any key....."
420 Z$=INKEY$:IF Z$<>""THEN CLS:GOTO 340
430 GOTO 420
440 :REM'
450 LS=4700/F    :REM'radiator length in millimetres
460 LSM=LS/1000  :REM'radiator length in metres
470 COLOR 0,7
480 PRINT " Radiator diameter is not critical - 25.4mm (1 in.) is suggested."
490 COLOR 7,0
500 INPUT "ENTER: Radiator outside diameter (mm)";RD:D=RD
510 INPUT "ENTER: Radiator wall thickness (mm)";T
520 DM=D/1000                   :REM'radiator O.D. in metres
530 ID=RD-(2*T)                 :REM'radiator I.D. in mm.
540 NATLOG=LOG(0.574999988079071!*(LSM/DM))   :REM'natural log
550 COMLOG=NATLOG/LOG(10)       :REM'common log
560 C=19.100000381469727!*LSM*(1/(COMLOG))     :REM'capacitance in pF
570 L=(159/F)^2/C               :REM'inductance in uH
580 UH=L                        :REM'inductance in uH for coil equations
590 LR=58/F                     :REM'counterpoise length in metres
600 CLS
610 COLOR 0,7:PRINT " DL7PE MicroVert HF Antenna ":COLOR 7,0
620 PRINT UL$;
630 PRINT USING " Frequency / band...... #####.### MHz (###.### m )";F,W
640 PRINT USING " Radiator O.D.......... #####.## mm   (###.### in)";D,D/25.399999618530273!
650 PRINT USING " Radiator I.D.......... #####.## mm   (###.### in)";ID,ID/25.399999618530273!
660 PRINT UL$;
670 PRINT USING " Radiator length....... #####.## mm   (###.### in)";LS,LS/25.399999618530273!
680 PRINT USING " Radiator capacitance.. #####.## pF";C
690 PRINT USING " Coil inductance....... #####.## µH";L
700 PRINT USING " Counterpoise length... #####.## m    (###.### ft)";LR,LR/0.30480000376701355!
710 PRINT
720 LN=CSRLIN:GOSUB 2650:LOCATE LN
730 LOCATE LN:COLOR 0,7:PRINT " Recalculate? (y/n) ":COLOR 7,0
740 Z$=INKEY$:IF Z$=""THEN 740
750 IF Z$="y"THEN CLS:GOTO 340
760 IF Z$="n"OR Z$="N"THEN LOCATE LN:GOTO 780
770 GOTO 740
780 COLOR 0,7:PRINT" Design a coil?  (y/n) ":COLOR 7,0
790 Z$=INKEY$:IF Z$=""THEN 790
800 IF Z$="n"THEN 180
810 IF Z$="y"THEN LOCATE LN:GOTO 840
820 GOTO 790
830 :REM'
840 :REM'.....coil
850 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
860 GOSUB 2490:LOCATE 11:COLOR 0,7
870 PRINT " Choose a coil form to fit inside the radiator "
880 COLOR 7,0
890 INPUT "ENTER: Coil form O.D. (mm)";D:D=D/25.399999618530273!
900 PRINT " (Wind coil with solid enamelled copper wire)"
910 INPUT "ENTER: Wire diameter (mm)";W:W=W/25.399999618530273!
920 R=((D/2+W/2))   :REM'coil radius
930 CD=2*R          :REM'coil diameter
940 T=1/W           :REM'turns per inch
950 Q=R^2*T^2/UH:L=ABS(-10-SQR(100+36*R*Q))/2/Q
960 L=ABS(-10-SQR(100+36*R*Q))/2/Q
970 N=L*T
980 WR=PI*CD*N*25.399999618530273!/10^3   :REM'wire required in metres
990 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11:PRINT UL$;
1010 PRINT "COIL:"
1020 PRINT USING" Wire diameter......... ####.## mm    (###.### in)";W*25.399999618530273!,W
1030 PRINT USING" Coil form diameter.... ####.## mm    (###.### in)";D*25.399999618530273!,D
1040 PRINT USING" Coil pitch diameter... ####.## mm    (###.### in)";CD*25.399999618530273!,CD
1050 PRINT USING" Coil length........... ####.## mm    (###.### in)";L*25.399999618530273!,L
1060 PRINT USING" Turns per inch........ ####.## ";T;:PRINT "close wound"
1070 PRINT USING" Number of turns....... ####.## ";N
1080 PRINT USING" Wire required......... ####.## m     (###.### ft)";WR,WR/0.30480000376701355!
1090 PRINT
1100 IF D*25.399999618530273!<ID THEN 1120
1110 BEEP:PRINT " Coil form O.D.is greater than radiator I.D.":GOTO 1150
1120 F=ID-(D*25.399999618530273!)
1130 PRINT " Coil form fits inside radiator with clearance all around of";
1140 PRINT USING "###.## mm.";F/2
1150 LN=CSRLIN:COLOR 0,7:PRINT " Try another Coil?  (y/n) ":COLOR 7,0
1160 Z$=INKEY$:IF Z$=""THEN 1160
1170 IF Z$="y"THEN LN=11:GOTO 840
1180 IF Z$="n"THEN LOCATE LN:PRINT UL$;:GOTO 1210
1190 GOTO 1160
1200 PRINT UL$;
1210 PRINT " Program developed in collaboration with Jose Amador, CO2JA & ";
1220 PRINT "Arnie Coro, CO2KK.";
1230 GOSUB 2650:GOTO 180
1240 :REM'
1250 :REM'.....diagram
1260 COLOR 0,7:Y=18
1270 LOCATE,Y:PRINT "             MicroVert ANTENNA                "
1280 LOCATE,Y:PRINT "   ║«───adjustment element (alum. tubing)     "
1290 LOCATE,Y:PRINT "  │║│   insulated from radiator               "
1300 LOCATE,Y:PRINT "  │║│                                         "
1310 LOCATE,Y:PRINT "  │ │«─ capacitive radiator (alum. tubing)    "
1320 LOCATE,Y:PRINT "  │ │    (either vertical or horizontal)      "
1330 LOCATE,Y:PRINT "  │ │    (length to suit design frequency)    "
1340 LOCATE,Y:PRINT "  │ │                                         "
1350 LOCATE,Y:PRINT "  │┌┼── PVC pipe coil form inside radiator    "
1360 LOCATE,Y:PRINT "  │║│                                         "
1370 LOCATE,Y:PRINT " ┌┤║│                                         "
1380 LOCATE,Y:PRINT " └─█«───reactance coil                        "
1390 LOCATE,Y:PRINT "   █─┐ ┌braid left open (no connection)       "
1400 LOCATE,Y:PRINT "  ┌─»║«┘                                      "
1410 LOCATE,Y:PRINT "  │  ║«─resonant counterpoise (50 Ω coax)     "
1420 LOCATE,Y:PRINT "  L  ║  length L to suit design frequency     "
1430 LOCATE,Y:PRINT "  │  ║                                        "
1440 LOCATE,Y:PRINT "  └─»╚╗╔╗╔╗«─RF choke (8 turns 50 Ω coax)     "
1450 LOCATE,Y:PRINT "      ╚╝╚╝╚═─»any length 50 Ω coax to station "
1460 COLOR 7,0
1470 RETURN
1480 :REM'
1490 :REM'.....description
1500 PRINT " DL7PE MicroVert HF Antenna Description"
1510 PRINT " REF:<www.antennex.com> `Double Pack Volume 3' CD, Archives IV(76)";
1520 PRINT " and V(34).  "
1530 PRINT UL$;
1540 PRINT " Typical maximum radiator lengths:  80m. band -  1.34 m. ( 53 in.)"
1550 PRINT "                                    40m. band -  0.67 m. ( 27 in.)"
1560 PRINT "                                    20m. band -  0.34 m. ( 14 in.)"
1570 PRINT "                                    10m. band -  0.16 m. (  7 in.)"
1580 PRINT UL$;
1590 PRINT " The MicroVert is an extremely short monopole that can be mounted ";
1600 PRINT "at any angle "
1610 PRINT " from vertical to horizontal. It has a high radiation resistance (";
1620 PRINT "about 30 Ω)  "
1630 PRINT " and is thus very efficient. No special counterpoise is required a";
1640 PRINT "part from the"
1650 PRINT " coaxial feeder cable. Feed point resistance at resonance is about";
1660 PRINT " 50 Ω so no  "
1670 PRINT " transmatch (antenna tuner) is required. Unlike mobile/maritime wh";
1680 PRINT "ips that use "
1690 PRINT " the metallic content of the vehicle body for a counterpoise there";
1700 PRINT " is no need  "
1710 PRINT " for a high Q large diameter heavy conductor loading coil, thus al";
1720 PRINT "lowing a wide"
1730 PRINT " bandwidth compact coil, close wound with relatively small enamell";
1740 PRINT "ed wire.     "
1750 PRINT UL$;
1760 PRINT " The efficiancy of a 1 ft. long 20m. MicroVert is comparable with ";
1770 PRINT "a 5 ft. dia. "
1780 PRINT " small circular loop antenna. Gain is -6 to -12 dBd below a full s";
1790 PRINT "ize dipole.  "
1800 PRINT UL$;
1810 PRINT " Polarization is either vertical or horizontal, depending on insta";
1820 PRINT "llation.     "
1830 PRINT " Radiation pattern is near that of an isotropic antenna.          "
1840 PRINT UL$;
1850 PRINT " For user reports visit <www.t-online.de/home/dl7pe/afu.htm>";
1860 RETURN
1870 :REM'
1880 :REM'.....construction notes
1890 CLS
1900 PRINT TAB(31)"CONSTRUCTION NOTES"
1910 PRINT UL$;
1920 PRINT " RADIATOR: 25.4mm(1 in) alum. tubing recommended. Drill 3mm(1/8 in";
1930 PRINT ") holes near "
1940 PRINT "top and bottom to allow escape of condensation.                   "
1950 PRINT UL$;
1960 PRINT " ADJUSTMENT ELEMENT: 15mm(5/8 in.) alum. tubing about 150mm(6 in) ";
1970 PRINT "long. Wrap 2 "
1980 PRINT "rings of electrical tape at one end to provide a snug friction fit";
1990 PRINT " inside the"
2000 PRINT "radiator tube. Adjust projection of element past end of radiator f";
2010 PRINT "or minimum   "
2020 PRINT "SWR at design frequency. Enclose entire outer end of radiator with";
2030 PRINT " heat shrink "
2040 PRINT "tubing and coat thoroughly with sealant.                          "
2050 PRINT UL$;
2060 PRINT " COIL FORM: PVC pipe, to fit snugly inside the radiator. Emclose c";
2070 PRINT "oil and"
2080 PRINT "bottom of radiator with heat shrink tubing.          "
2090 PRINT UL$;
2100 PRINT " REACTANCE COIL: Solid copper enamelled wire, close wound.        "
2110 PRINT UL$;
2120 PRINT " COAXIAL CABLE: Use only high quality RG58 cable with high density";
2130 PRINT " shielding.  "
2140 PRINT UL$;
2150 PRINT " COUNTERPOISE: Clamp to bottom end of coil form. Enclose entire bo";
2160 PRINT "ttom end of  "
2170 PRINT "radiator and coil form in heat shrink tubing or wrap with tape and";
2180 PRINT " coat        "
2190 PRINT "liberally with sealant.                                           "
2200 PRINT UL$;
2210 PRINT " RF CHOKE: 8 turns of the coaxial feedline wound on a piece of PVC";
2220 PRINT " pipe. "
2230 PRINT UL$;
2240 RETURN
2250 :REM'
2260 :REM'.....equations
2270 PRINT "DL7PE MicroVert HF Antenna Equations formulated by Juergen Schaefer"
2280 PRINT UL$;
2290 PRINT "F=   Frequency (MHz)"
2300 PRINT
2310 PRINT "D=   radiator outside diameter in millimetres"
2320 PRINT
2330 PRINT "Dm=  radiator outside diameter in metres"
2340 PRINT
2350 PRINT "Ls=  4700/F                          radiator length in millimetres"
2360 PRINT
2370 PRINT "Lsm= Ls/1000                         radiator length in metres"
2380 PRINT
2390 PRINT "C=   19.1 x Lsm x 1/{log[.575 x (Lsm/Dm)]} pF"
2400 PRINT
2410 PRINT "L=   (159/F)^2/C µH"
2420 PRINT
2430 PRINT "LR=  58/F                            counterpoise length in metres"
2440 PRINT UL$;
2450 PRINT "Standard well known equations are used for the coil design."
2460 PRINT "HamCalc's 'Coil Equation Calculator' program is recommended."
2470 RETURN
2480 END
2490 :REM'.....PVC pipe
2500 Y=44:LOCATE 11,Y
2510 LOCATE LN,Y:PRINT "PVC pipe trade size ┌───── O.D.────┐"
2520 LOCATE ,Y+12:PRINT "1/8in   0.405in   10.3mm"
2530 LOCATE ,Y+12:PRINT "1/4in   0.545in   13.7mm"
2540 LOCATE ,Y+12:PRINT "3/8in   0.675in   17.1mm"
2550 LOCATE ,Y+12:PRINT "1/2in   0.840in   21.3mm"
2560 LOCATE ,Y+12:PRINT "3/4in   1.050in   26.7mm"
2570 LOCATE ,Y+12:PRINT "1  in   1.315in   33.4mm"
2580 LOCATE ,Y+12:PRINT "1¼ in   1.660in   42.2mm"
2590 LOCATE ,Y+12:PRINT "1½ in   1.900in   48.3mm"
2600 LOCATE ,Y+12:PRINT "2  in   2.375in   60.3mm"
2610 LOCATE ,Y+12:PRINT "2½ in   2.875in   73.0mm"
2620 LOCATE ,Y+12:PRINT "3  in   3.500in   88.9mm"
2630 RETURN
2640 :REM'
2650 :REM'.....PRT
2660 KEY OFF:GOSUB 2730:LOCATE 25,5:COLOR 0,2
2670 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2680 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2690 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2690 :ELSE GOSUB 2730
2700 IF Z$="3"THEN RETURN
2710 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2720 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2660
2730 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
