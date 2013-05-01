10 :REM'HELVERT - Helically Wound Vertical Antenna - 04 DEC 95 rev.08 MAR 2010
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 PI=3.1415929794311523!
60 E$=STRING$(79,32)
70 UL$=STRING$(80,205)
80 U1$="#####.###"
90 U2$="#####"
100 U3$="#####.#"
110 DIM T(25,3)
120 :REM'
130 :REM'.....start
140 CLS
150 COLOR 15,2
160 PRINT " VERTICAL ANTENNA, HELICALLY WOUND";
170 PRINT TAB(57);"by George Murphy VE3ERP ";
180 COLOR 1,0:PRINT STRING$(80,223);
190 COLOR 7,0
200 GOSUB 1860       :REM'preface
210 COLOR 0,7:LOCATE 25,22
220 PRINT " Press 1 to continue or 0 to EXIT.....";
230 COLOR 7,0
240 Z$=INKEY$:IF Z$=""THEN 230
250 IF Z$="0"THEN CLS:RUN EX$
260 IF Z$="1"THEN 280
270 GOTO 240
280 GOSUB 2340       :REM'screen dump
290 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
300 GOSUB 330        :REM'diagram
310 GOTO 580         :REM'start
320 :REM'
330 :REM'.....diagram
340 COLOR 0,7
350 LN=2:T=22
360 LOCATE LN+ 1,T:PRINT "      ┌»      ┌─╥─┐«── capacity hat    "
370 LOCATE LN+ 2,T:PRINT "      │         ║  (aluminum pie plate)"
380 LOCATE LN+ 3,T:PRINT "      │         ║                      "
390 LOCATE LN+ 4,T:PRINT " Element Lgth.  ║«── helically wound   "
400 LOCATE LN+ 5,T:PRINT "      │         ║    vertical element  "
410 LOCATE LN+ 6,T:PRINT "      │         ║  C1  L1              "
420 LOCATE LN+ 7,T:PRINT "      └»        ╙──╫──∩∩∩──┬──« 50     "
430 LOCATE LN+ 8,T:PRINT "                        C2═╪═   ohm    "
440 LOCATE LN+ 9,T:PRINT "   ground rod──»╓──────────┴──« feeder "
450 LOCATE LN+10,T:PRINT " \\\\\\\\\\\\\\\║\\\\\\ ground \\\\\\\ "
460 LOCATE LN+11,T:PRINT " ═══════════════╩════════════════      "
470 LOCATE LN+12,T:PRINT " «────────── radials ───────────»      "
480 COLOR 7,0
490 PRINT UL$;
500 RETURN
510 :REM'
520 :REM'.....format input line
530 IF ZZ=Q OR ZZ=RL THEN U$=U3$ :ELSE U$=U1$
540 LOCATE CSRLIN-1:PRINT SPC(7);
550 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;ZZ;
560 RETURN
570 :REM'
580 :REM'.....start
590 PRINT TAB(4);
600 PRINT "Do you want to input data in (m)etric or (i)mperial units?  (m/i)"
610 UM$=INKEY$:IF UM$=""THEN 610
620 IF UM$="m"OR UM$="i"THEN 630 :ELSE 610
630 VIEW PRINT 16 TO 24:CLS:VIEW PRINT:LOCATE 16
640 :REM'
650 :REM'.....input frequency
660 INPUT " ENTER: Frequency of interest...................(MHz)";FQ
670 ZZ=FQ:GOSUB 520:PRINT " MHz"
680 :REM'
690 :REM'.....compute wavelength
700 V=299793077.0#*10^-6    :REM'speed of light
710 WL=V/FQ   :REM'wavelength
720 PRINT "        Wavelength...................................";USING U1$;WL;
730 PRINT " metres"
740 :REM'
750 :REM'.....compute minimum element length
760 ML=WL*0.05000000074505806!   :REM'minimum element length in metres
770 IF UM$="m"THEN UM=1:M$="m.":ELSE UM=0.30480000376701355!:M$="ft."
780 ZZ=ML/UM+0.0010000000474974513!
790 PRINT "        MINIMUM element length.......................";USING U1$;ZZ;
800 PRINT " ";M$
810 ZZ=WL/4/UM
820 PRINT "        MAXIMUM element length.......................";USING U1$;ZZ;
830 PRINT " ";M$
840 :REM'
850 :REM'.....input desired element length
860 IF UM$="m"THEN M$=".(m.)":ELSE M$="(ft.)"
870 PRINT " ENTER: Length of vertical element..............";M$;:INPUT EL
880 ZZ=EL:GOSUB 520:IF UM$="m"THEN PRINT " m.":ELSE PRINT " ft."
890 IF UM$="i"THEN EL=EL*0.30480000376701355!
900 IF EL>=ML AND EL<WL/2 THEN 930
910 LOCATE CSRLIN-1:PRINT E$:LOCATE CSRLIN-1:GOTO 850
920 :REM'
930 :REM'.....compute radial length
940 RA=1.0499999523162842!*EL
950 IF UM$="m"THEN R=RA :ELSE R=RA/0.30480000376701355!
960 PRINT "        Length of radials............................";USING U1$;R;
970 IF UM$="m"THEN PRINT " m.":ELSE PRINT " ft."
980 :REM'
990 :REM'.....input element diameter
1000 IF UM$="m"THEN M$="(mm.)":ELSE M$="(in.)"
1010 PRINT "        Diameter of vertical element............";M$;:INPUT DI
1020 ZZ=DI:GOSUB 520:IF UM$="m"THEN PRINT " mm.":ELSE PRINT " in."
1030 IF UM$="i"THEN DI=DI*25.399999618530273!
1040 :REM'
1050 :REM'.....compute wire length
1060 WI=WL/2       :REM'length of ½ wavelength of wire
1070 IF UM$="m"THEN L=WI :ELSE L=WI/0.30480000376701355!
1080 PRINT "        Approximate length of winding wire required..";USING U1$;L;
1090 IF UM$="m"THEN M$=" m.":ELSE M$=" ft."
1100 PRINT M$
1110 :REM'
1120 :REM'.....compute number of turns
1130 C=PI*DI*1.0099999904632568!/10^3     :REM'circumference, with 1% allowance for wire thickness
1140 N=SQR(WI^2-EL^2)/C    :REM'number of turns
1150 NT=INT(N+0.05000000074505806!)         :REM'nearest even number
1160 PRINT "        Number of turns..............................";USING U2$;NT;
1170 :REM'
1180 :REM'.....compute pitch
1190 PT=EL/NT*10^3        :REM'pitch in mm.
1200 IF UM$="m"THEN P=PT :ELSE P=PT/25.399999618530273!
1210 PRINT " spaced @";USING "####.##";P;
1220 IF UM$="m"THEN M$=" mm.":ELSE M$=" in."
1230 PRINT M$;
1240 GOSUB 2340   :REM'screen dump
1250 VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE 17
1260 :REM'
1270 :REM'.....input Q and RL
1280 INPUT " ENTER: Loaded Q (suggested range: 1-5)..............";Q
1290 ZZ=Q:GOSUB 520:PRINT ""
1300 INPUT " ENTER: Feed impedance (if unknown, enter 5)......(Ω)";RL
1310 LOCATE CSRLIN-1,23:PRINT STRING$(25,".")
1320 ZZ=RL:GOSUB 520:PRINT " Ω"
1330 GOSUB 1360
1340 GOTO 1420
1350 :REM'
1360 :REM'.....SUBROUTINE to compute component values
1370 XC1=Q*RL:               C1=1/(2*PI*FQ*XC1)*10^6
1380 XC2=50*SQR(RL/(50-RL)): C2=1/(2*PI*FQ*XC2)*10^6
1390 XL1=XC1+RL*50/XC2:      L1=XL1/(2*PI*FQ)
1400 RETURN
1410 :REM'
1420 :REM'.....print component values
1430 PRINT "        Capacitor C1.................................";USING U2$;C1;
1440 PRINT " pF"
1450 PRINT "        Capacitor C2.................................";USING U2$;C2;
1460 PRINT " pF"
1470 PRINT "        Inductor L1..................................";USING U1$;L1;
1480 PRINT " µH"
1490 GOSUB 2340    :REM'screen dump
1500 :REM'
1510 :REM'.....table of component values
1520 CLS
1530 T=0:N=0
1540 FOR Q=1 TO 5
1550 FOR RL=2 TO 10 STEP 2
1560 GOSUB 1360
1570 N=N+1
1580 T(N,1)=C1:T(N,2)=C2:T(N,3)=L1
1590 NEXT RL
1600 NEXT Q
1610 IF UM$="i"THEN L$=" ft.":ELSE L$=" m."
1620 PRINT " Radiation  ║";TAB(16);FQ;"MHz VERTICAL HELICAL ANTENNA,";
1630 PRINT USING "###.##";EL/UM;:PRINT L$;" LONG"
1640 PRINT " Resistance ║";TAB(33);"L-NETWORK VALUES"
1650 PRINT " (Impedance)║";
1660 PRINT TAB(17);"Q=1";TAB(28);"Q=2";TAB(39);"Q=3";TAB(50);"Q=4";TAB(61);"Q=5"
1670 PRINT UL$;
1680 LOCATE CSRLIN-1,13:PRINT "╩"
1690 FOR Z=1 TO 5
1700 X=2*Z
1710 PRINT TAB(9);
1720 PRINT USING "###########";T(Z,1),T(Z+5,1),T(Z+10,1),T(Z+15,1),T(Z+20,1);
1730 PRINT "  «── C1 (pF)"
1740 PRINT USING "###";X;:PRINT " ohms";         :REM'radiation resistance
1750 PRINT TAB(9);
1760 PRINT USING "###########";T(Z,2),T(Z+5,2),T(Z+10,2),T(Z+15,2),T(Z+20,2);
1770 PRINT "  «── C2 (pF)"
1780 PRINT TAB(9);
1790 PRINT USING "#######.###";T(Z,3),T(Z+5,3),T(Z+10,3),T(Z+15,3),T(Z+20,3);
1800 PRINT "  «── L1 (µH)"
1810 PRINT UL$;
1820 NEXT Z
1830 GOTO 2290
1840 END
1850 :REM'
1860 :REM'.....preface notes
1870 T=7
1880 PRINT TAB(T);
1890 PRINT "   A physically short, quarter-wavelength, helically wound vertical"
1900 PRINT TAB(T);
1910 PRINT "antenna wound on an insulating pole can be worked against an"
1920 PRINT TAB(T);
1930 PRINT "above-ground wire radial system (four or more radials) or a ground"
1940 PRINT TAB(T);
1950 PRINT "mount system where the radials are buried or lying on the ground."
1960 PRINT TAB(T);
1970 PRINT "   The physical length of such an antenna can be as little as about"
1980 PRINT TAB(T);
1990 PRINT "1/20 of a wavelength at the operating frequency. Regardless of the"
2000 PRINT TAB(T);
2010 PRINT "physical length its electrical length will be about 1/4 wavelength"
2020 PRINT TAB(T);
2030 PRINT "when wound with approximately 1/2 wavelength of wire, with turns"
2040 PRINT TAB(T);
2050 PRINT "equally spaced along the length of the antenna form."
2060 PRINT TAB(T);
2070 PRINT "   A capacity hat is required to lower the Q to an acceptable"
2080 PRINT TAB(T);
2090 PRINT "level. A loaded Q of about 1-5 is desirable to provide adequate"
2100 PRINT TAB(T);
2110 PRINT "bandwidth. The radiation resistance will be quite low - about"
2120 PRINT TAB(T);
2130 PRINT "2-10 ohms, therefore an L-Network should be installed at the"
2140 PRINT TAB(T);
2150 PRINT "antenna base to provide a match to a 50 ohm feeder."
2160 PRINT TAB(T);
2170 PRINT "   All shortened antennas of this type are narrow-band devices,"
2180 PRINT TAB(T);
2190 PRINT "therefore adjustments should be for operation in the centre of the"
2200 PRINT TAB(T);
2210 PRINT "frequency spread of interest."
2220 PRINT
2230 PRINT TAB(T);
2240 PRINT "   For a detailed discussion of this type of antenna, see the"
2250 PRINT TAB(T);
2260 PRINT "ARRL Antenna Book, 17th edition, pages 6-18 and 6-19."
2270 RETURN
2280 :REM'
2290 :REM'......end
2300 GOSUB 2340
2310 GOTO 130
2320 END
2330 :REM'
2340 :REM'.....PRT
2350 KEY OFF:GOSUB 2420:LOCATE 25,5:COLOR 0,2
2360 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2370 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2380 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2380 :ELSE GOSUB 2420
2390 IF Z$="3"THEN RETURN
2400 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2410 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2350
2420 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
