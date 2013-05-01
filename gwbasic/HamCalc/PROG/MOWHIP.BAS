10 :REM'MOWHIP - mobile/whip antenna - 13 JAN 94 rev. 26 NOV 2010
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="mowhip"
40 COMMON EX$,PROG$,U,UH,FQ,WHIP
50 CLS:KEY OFF
60 COLOR 7,0,1
70 DIM S(9,7)  :REM'single element data
80 DIM D(9,8)  :REM'double element data
90 UL$=STRING$(80,205)
100 U1$="#####.##"
110 U2$="#####.###"
120 U3$="#####.####"
130 A$=STRING$(7,32)
140 B$=STRING$(19,".")
150 C$=STRING$(80,32)
160 PI=3.1415929794311523!
170 GOTO 230
180 :REM'
190 :REM'.....erase line
200 LOCATE CSRLIN-1:PRINT C$;:LOCATE CSRLIN-1
210 RETURN
220 :REM'
230 :REM'.....start
240 CLS:F=0
250 COLOR 15,2
260 PRINT " MOBILE/MARITIME HF WHIP ANTENNAS";
270 PRINT TAB(57);"by George Murphy VE3ERP ";
280 COLOR 1,0:PRINT STRING$(80,223);
290 COLOR 7,0
300 X=17:LOCATE 3:GOSUB 560
310 X=42:LOCATE 3:GOSUB 430
320 PRINT UL$;
330 GOSUB 3200   :REM'preface
340 COLOR 0,7:LOCATE 25,22
350 PRINT " Press 1 to continue or 0 to EXIT.... ";
360 COLOR 7,0
370 Z$=INKEY$:IF Z$=""THEN 370
380 IF Z$="0"THEN CLS:RUN EX$
390 IF Z$="1"THEN 690
400 GOTO 370
410 :REM'
420 :REM'.....diagrams
430 COLOR 0,7
440 LOCATE ,X:PRINT "     DOUBLE ELEMENT    "
450 LOCATE ,X:PRINT "  ┌» ╥                 "
460 LOCATE ,X:PRINT "  H2 ║«─upper element  "
470 LOCATE ,X:PRINT "  └»┌╨┐«─loading coil  "
480 LOCATE ,X:PRINT "  ┌»└╥┘                "
490 LOCATE ,X:PRINT "  H1 ║«─lower element  "
500 LOCATE ,X:PRINT "  └» ╨─ «┐feed         "
510 LOCATE ,X:PRINT "     ┌─ «┘point        "
520 LOCATE ,X:PRINT "    \┴\«─vehicle body  "
530 COLOR 7,0
540 RETURN
550 :REM'
560 COLOR 0,7
570 LOCATE ,X:PRINT "     SINGLE ELEMENT    "
580 LOCATE ,X:PRINT "  ┌» ╥                 "
590 LOCATE ,X:PRINT "  │  ║                 "
600 LOCATE ,X:PRINT "  H1 ║«─single element "
610 LOCATE ,X:PRINT "  │  ║                 "
620 LOCATE ,X:PRINT "  └»┌╨┐«─loading coil  "
630 LOCATE ,X:PRINT "    └─┴ «┐feed         "
640 LOCATE ,X:PRINT "     ┌─ «┘point        "
650 LOCATE ,X:PRINT "    \┴\«─vehicle body  "
660 COLOR 7,0
670 RETURN
680 :REM'
690 :REM'.....input data
700 VIEW PRINT 13 TO 24:CLS:VIEW PRINT:LOCATE 13
710 PRINT " Do you want to input data in (c)entimetres or (i)nches?     (c/i)"
720 Z$=INKEY$:IF Z$=""THEN 720
730 IF Z$="c"THEN UM$="cm.":UM=2.5399999618530273!:GOTO 770
740 IF Z$="i"THEN UM$="in.":UM=1:GOTO 770
750 GOTO 720
760 :REM'
770 GOSUB 190
780 PRINT " Do you want to design a (s)ingle or (d)ouble element whip?  (s/d)"
790 I$=INKEY$:IF I$=""THEN 790
800 IF I$="s"OR I$="d"THEN X=2:GOTO 810 :ELSE 790
810 IF I$="d"THEN Z$=" DOUBLE ":ELSE Z$=" SINGLE "
820 CLS:IF I$="d"THEN GOSUB 430 :ELSE GOSUB 560
830 LOCATE 1:PRINT Z$;"ELEMENT MOBILE/MARITIME WHIP"
840 :REM'
850 LOCATE 11
860 INPUT "ENTER: Frequency of operation (0.495 - 30 MHz)........(MHz)";F
870 IF F<0.4950000047683716! OR F>30 THEN GOSUB 190:GOTO 850
880 GOSUB 190
890 LOCATE 2,26:PRINT "Operating frequency........";USING U2$;F;
900 PRINT " MHz =";USING "#####.##";300/F;:PRINT " m."
910 :REM'
920 LOCATE 11
930 PRINT" ENTER: Diameter of element H1...................("UM$;")";
940 INPUT DH1:DH1=DH1/UM
950 IF DH1=0 THEN GOSUB 190:GOTO 920
960 GOSUB 190
970 LOCATE 4,26:PRINT "Diameter of element H1.....";USING U1$;DH1*2.5399999618530273!;
980 PRINT " cm.  =";USING "####.##";DH1;:PRINT " in."
990 IF I$="s"THEN 1200
1000 :REM'
1010 LOCATE 11
1020 PRINT" ENTER: Diameter of element H2...................("UM$;")";
1030 INPUT DH2:DH2=DH2/UM
1040 IF DH1=0 THEN GOSUB 190:GOTO 1010
1050 GOSUB 190:LOCATE 6,26
1060 LOCATE 6,26:PRINT "Diameter of element H2.....";USING U1$;DH2*2.5399999618530273!;
1070 PRINT " cm.  =";USING "####.##";DH2;:PRINT " in."
1080 :REM'
1090 H=45  :REM'max.elec.lgth in degrees
1100 LMAX=984*H/F/360*12  :REM'max.length in inches
1110 LOCATE 11
1120 COLOR 0,7:PRINT " Maximum length H1+H2:";USING U1$;LMAX*2.5399999618530273!;
1130 PRINT " cm. =";USING U1$;LMAX;:PRINT " in. =";H;"elec.degrees "
1140 COLOR 7,0
1150 PRINT " ENTER: Your choice of total length H1+H2....(";UM$;")";:INPUT Z
1160 Z=Z/UM     :REM'length in inches
1170 H=Z/12/984*F*360   :REM'length in electrical degrees
1180 RR=H^2/312
1190 :REM'
1200 :REM'.....computation
1210 IF I$="s"THEN 1240
1220 IF I$="d"THEN 1920
1230 :REM'
1240 :REM'.....single element
1250 FOR Z=5 TO 45 STEP 5
1260 GOSUB 1800  :REM'equations
1270  S(Z/5,1)=Z                    :REM'length in electrical degrees
1280  S(Z/5,2)=H1*2.5399999618530273!              :REM'length in centimetres
1290  S(Z/5,3)=H1                   :REM'length in inches
1300  S(Z/5,4)=RR
1310  S(Z/5,5)=KM
1320  S(Z/5,6)=XL
1330  S(Z/5,7)=UH
1340 NEXT Z
1350 :REM'
1360 :REM'.....screen display
1370 LOCATE 10
1380 PRINT UL$;
1390 LOCATE CSRLIN-1,1:PRINT "╒";:LOCATE ,30:PRINT"╤";:LOCATE ,54:PRINT "╤";:
1400 LOCATE ,68:PRINT "╤";:LOCATE ,(80):PRINT "╕";
1410 LOCATE CSRLIN-1,33:PRINT " TYPICAL VALUES "
1420 PRINT "│┌──────── Length H1 ───────┐";TAB(30)"│ Radiation";
1430 PRINT TAB(42)"│  Antenna";TAB(54)"│   Antenna";TAB(68)"│  Loading";
1440 PRINT TAB(80)"│";
1450 PRINT "│ deg│     cm.   │     in.";TAB(30)"│ Resistance";
1460 PRINT TAB(42)"│ Impedance";TAB(54)"│  Reactance";TAB(68)"│   Coil";
1470 PRINT TAB(80)"│";
1480 FOR Z=1 TO 9:FOR Y=1 TO 7
1490 IF Y=1 THEN U$="│ ##°"
1500 IF Y=2 THEN U$="│#######.##"
1510 IF Y=3 THEN U$=" │#######.##"
1520 IF Y=4 OR Y=5 THEN U$=" │#####.## Ω"
1530 IF Y=6 THEN U$=" │-j#####.## Ω"
1540 IF Y=7 THEN U$=" │####.## µH"
1550 PRINT USING U$;S(Z,Y);
1560 NEXT Y:PRINT " │";
1570 NEXT Z
1580 PRINT :COLOR 0,7:PRINT " to select length.....press 3 ":COLOR 7,0
1590 GOSUB 3440   :REM'PRT options
1600 :REM'
1610 :REM'.....select an antenna
1620 LOCATE 23
1630 PRINT " ENTER: Your choice of length H1.....(";UM$;")";:INPUT L:L=L/UM
1640 Z=L/12/984*F*360  :REM'length in degrees
1650 LOCATE 5,26:PRINT SPC(54);     :REM'erase H1 length display
1660 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11
1670 GOSUB 1800        :REM'solve equations
1680 Z1=Z:GOSUB 2710   :REM'screen printout
1690 GOSUB 3440        :REM'hard copy
1700 LOCATE 25,1:PRINT C$;:LOCATE 23:COLOR 0,7
1710 :REM'
1720 PRINT " Do you want to try another length?   (y/n) "
1730 COLOR 7,0
1740 Z$=INKEY$:IF Z$=""THEN 1740
1750 IF Z$="n"THEN GOSUB 190:GOTO 3080
1760 IF Z$="y"THEN GOSUB 190:GOTO 1610
1770 GOTO 1740
1780 END
1790 :REM'
1800 :REM'.....single element equations
1810 I=1                            :REM'1 ampere base current
1820 H1=984*Z/(F*360)*12            :REM'length of H1 in inches
1830 A=Z/2*I                        :REM'area in degree-amperes
1840 K=Z^2/(312*A^2)                :REM'K=.0128
1850 RR=K*A^2                       :REM'radiation resistance in ohms
1860 KM=60*(LOG(2*H1/(DH1/2))-1)    :REM'mean characteristic impedance
1870 DR=Z*PI/180                    :REM'elec. length in radians
1880 XL=KM*(1/TAN(DR))              :REM'inductive reactance required
1890 UH=XL/(2*PI*F)                 :REM'inductor value in µH
1900 RETURN
1910 :REM'
1920 :REM'.....double element
1930 VIEW PRINT 10 TO 24:CLS:VIEW PRINT:LOCATE 10
1940 PRINT UL$;
1950 LOCATE CSRLIN-1,1:PRINT "╒";:LOCATE ,30:PRINT"╤";:LOCATE ,59:PRINT "╤";:
1960 LOCATE ,68:PRINT "╤";:LOCATE ,(80):PRINT "╕";
1970 LOCATE CSRLIN-1,33:PRINT " TYPICAL VALUES "
1980 PRINT "│┌──────── Length H1 ───────┐";TAB(30);
1990 PRINT "│┌──────── Length H2 ───────┐";
2000 PRINT TAB(59);"│Radiat'n│  Loading";
2010 PRINT TAB(80)"│";
2020 PRINT "│   deg  │   cm.   │   in.";TAB(30);
2030 PRINT "│   deg  │   cm.   │   in.";
2040 PRINT TAB(59)"│ Resis.";TAB(68)"│   Coil";
2050 PRINT TAB(80)"│";
2060 FOR Z=1 TO 9
2070 GOSUB 2540   :REM'solve equations
2080  D(Z,1)=H1                :REM'H1 in degrees
2090  D(Z,3)=H1N               :REM'H1 in inches
2100  D(Z,2)=H1N*2.5399999618530273!          :REM'H1 in cm.
2110  D(Z,4)=H2                :REM'H2 in degrees
2120  D(Z,6)=H2N               :REM'H2 in inches
2130  D(Z,5)=H2N*2.5399999618530273!          :REM'H2 in cm.
2140  D(Z,7)=RR
2150  D(Z,8)=UH
2160 NEXT Z
2170 :REM'
2180 :REM'.....screen display
2190 LOCATE 9,26:PRINT "Sum of lengths H1 + H2.....";USING U1$;(H1N+H2N)*2.5399999618530273!;
2200 PRINT " cm.  =";USING "####.##";H1N+H2N;:PRINT " in."
2210 LOCATE 13
2220 FOR Z=1 TO 9:FOR Y=1 TO 8
2230 IF Y=1 OR Y=4 THEN U$="│###.##° "
2240 IF Y=2 OR Y=3 OR Y=5 OR Y=6 THEN U$="│#####.## "
2250 IF Y=7 THEN U$="│##.## Ω "
2260 IF Y=8 THEN U$="│####.## µh "
2270 PRINT USING U$;D(Z,Y);
2280 NEXT Y:PRINT "│";
2290 NEXT Z
2300 PRINT :COLOR 0,7:PRINT " to select length.....press 3 ":COLOR 7,0
2310 GOSUB 3440
2320 :REM'
2330 :REM'.....select an antenna
2340 LOCATE 23
2350 PRINT " ENTER: Your choice of length H1.....(";UM$;")";:INPUT Z:Z=Z/UM
2360 H1=Z/12/984*F*360     :REM'length in electrical degrees
2370 LOCATE 5,26:PRINT SPC(54);     :REM'erase H1 length display
2380 LOCATE 7,26:PRINT SPC(54);     :REM'erase H2 length display
2390 LOCATE 9,26:PRINT SPC(54);     :REM'erase H1+h2 length display
2400 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11
2410 GOSUB 2570          :REM'solve equations
2420 Z1=H1:Z2=H2:GOSUB 2710    :REM'screen printout
2430 GOSUB 3440                :REM'PRT options
2440 LOCATE 25,1:PRINT C$;:LOCATE 23:COLOR 0,7
2450 :REM'
2460 PRINT " Do you want to try another?   (y/n) "
2470 COLOR 7,0
2480 Z$=INKEY$:IF Z$=""THEN 2480
2490 IF Z$="n"THEN GOSUB 190:GOTO 3080
2500 IF Z$="y"THEN GOSUB 190:GOTO 2330
2510 GOTO 1740
2520 END
2530 :REM'
2540 :REM'.....double element equations
2550 H1=H*Z/10                           :REM'H1 electrical lengths in degrees
2560 :REM'
2570 H2=H-H1                             :REM'H2 electrical lengths in degrees
2580 H1N=984*H1/(F*360)*12               :REM'H1 length in inches
2590 H2N=984*H2/(F*360)*12               :REM'H2 length in inches
2600 DR1=H1*PI/180                       :REM'H1 elec. length in radians
2610 DR2=H2*PI/180                       :REM'H2 elec. length in radians
2620 A=0.5!*(H1*(1+COS(DR1))+H2*COS(DR1))  :REM'area in degree-amperes
2630 K=0.012799999676644802!                             :REM'K=.0128
2640 RR=K*A^2                            :REM'radiation resistance in ohms
2650 KM1=60*(LOG(2*H1N/(DH1/2))-1)       :REM'H1 mean characteristic impedance
2660 KM2=60*(LOG(2*H2N/(DH2/2))-1)       :REM'H2 mean characteristic impedance
2670 XL=KM2/TAN(DR2)-KM1*TAN(DR1)        :REM'inductive reactance required
2680 UH=XL/(2*PI*F)                      :REM'inductor value in µH
2690 RETURN
2700 :REM'
2710 :REM'.....specification printout
2720 VIEW PRINT 10 TO 24:CLS:VIEW PRINT:LOCATE 10
2730 PRINT UL$;
2740 PRINT " Length H1 (electrical degrees)....H1=";USING U2$;Z1;:PRINT "°"
2750 IF I$="s"THEN 2770
2760 PRINT " Length H2 (electrical degrees)....H2=";USING U2$;Z2;:PRINT "°"
2770 PRINT " Degree-ampere area.................A=";USING U3$;A
2780 PRINT " K constant.........................K=";USING U3$;K
2790 PRINT " Radiation resistance..............RR=";USING U2$;RR;:PRINT " Ω"
2800 IF I$="s"THEN 2840
2810 PRINT " H1 characteristic impedance......Km1=";USING U2$;KM1;:PRINT " Ω"
2820 PRINT " H2 characteristic impedance......Km2=";USING U2$;KM2;:PRINT " Ω"
2830 GOTO 2850
2840 PRINT " H1 characteristic impedance.......Km=";USING U2$;KM;:PRINT " Ω"
2850 PRINT " Capacitive reactance..............XL=";USING U2$;XL;:PRINT " Ω"
2860 PRINT " Loading coil inductance.............=";USING U2$;UH;:PRINT " µH"
2870 :REM'RC1=XL/50:  EF1=RR/(RR+RC1)*100
2880 :REM'RC2=XL/300: EF2=RR/(RR+RC2)*100
2890 :REM'RC3=XL/450: EF3=RR/(RR+RC3)*100
2900 :REM'PRINT " Coil loss resistance: Q50 coil....RC=";USING U2$;RC1;:PRINT " Ω";
2910 :REM'PRINT USING ", Radiation efficiency= ##.##%";EF1
2920 :REM'PRINT "                     : Q300 coil...RC=";USING U2$;RC2;:PRINT " Ω";
2930 :REM'PRINT USING ", Radiation efficiency= ##.##%";EF2
2940 :REM'PRINT "                     : Q450 coil...RC=";USING U2$;RC3;:PRINT " Ω";
2950 :REM'PRINT USING ", Radiation efficiency= ##.##%";EF3
2960 IF I$="d"THEN 3000
2970 LOCATE 5,26:PRINT "Length of element H1.......";USING U1$;H1*2.5399999618530273!;
2980 PRINT " cm.  =";USING "####.##";H1;:PRINT " in."
2990 GOTO 3060
3000 LOCATE 5,26:PRINT "Length of element H1.......";USING U1$;H1N*2.5399999618530273!;
3010 PRINT " cm.  =";USING "####.##";H1N;:PRINT " in."
3020 LOCATE 7,26:PRINT "Length of element H2.......";USING U1$;H2N*2.5399999618530273!;
3030 PRINT " cm.  =";USING "####.##";H2N;:PRINT " in."
3040 LOCATE 9,26:PRINT "Sum of lengths H1 + H2.....";USING U1$;(H1N+H2N)*2.5399999618530273!;
3050 PRINT " cm.  =";USING "####.##";H1N+H2N;:PRINT " in."
3060 RETURN
3070 :REM'
3080 :REM'.....end
3090 COLOR 0,7
3100 PRINT " Do you want to design this coil?   (y/n) "
3110 COLOR 7,0
3120 Z$=INKEY$:IF Z$=""THEN 3120
3130 IF Z$="n"THEN GOSUB 190:GOTO 3170
3140 IF Z$="y"THEN CLS:U=UH:FQ=F:WHIP=1:CHAIN"coildsgn"
3150 GOTO 3120
3160 GOSUB 3440
3170 GOTO 230   :REM'start
3180 END
3190 :REM'
3200 :REM'.....preface
3210 TB=7
3220 PRINT TAB(TB);
3230 PRINT "This program purposely omits end effect calculation to ensure that"
3240 PRINT TAB(TB);
3250 PRINT "an antenna is electrically overlength. This is so that resonance at"
3260 PRINT TAB(TB);
3270 PRINT "the design frequency can be obtained easily by removing a turn or"
3280 PRINT TAB(TB);
3290 PRINT "two from the loading coil."
3300 PRINT
3310 PRINT TAB(TB);
3320 PRINT "Optimum loading coil Q is attained when the coil Length/Diameter"
3330 PRINT TAB(TB);
3340 PRINT "ratio is at or near 0.5. Diameter of loading coil conductor"
3350 PRINT TAB(TB);
3360 PRINT "(wire or tubing) should be as large as practicable. Loading coil"
3370 PRINT TAB(TB);
3380 PRINT "turns should be removed, NOT shorted, for tuning purposes."
3390 PRINT
3400 PRINT TAB(TB);
3410 PRINT "(Ref. THE ARRL ANTENNA BOOK, 18th Edition, pages 16-5 TO 16-11)"
3420 RETURN
3430 :REM'
3440 :REM'.....PRT
3450 KEY OFF:GOSUB 3520:LOCATE 25,5:COLOR 0,2
3460 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3470 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3480 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3480 :ELSE GOSUB 3520
3490 IF Z$="3"THEN RETURN
3500 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3510 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3450
3520 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
