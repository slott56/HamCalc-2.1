10 :REM'WIRESAG - Sag in long spans of wire - 24 JAN 94 rev. 17 SEP 2002
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 DIM W(9,4)       :REM'wire data
60 PI=4*ATN(1)
70 UL$=STRING$(80,205)
80 DATA 4,.2043
90 DATA 6,.1620
100 DATA 8,.1285
110 DATA 10,.1019
120 DATA 12,.0808
130 DATA 14,.0641
140 DATA 16,.0508
150 DATA 18,.0403
160 DATA 20,.0320
170 :REM'
180 FOR Z=1 TO 9
190 READ W(Z,1)        :REM'AWG size
200 READ W(Z,2)        :REM'wire diameter
210 R=W(Z,2)/2         :REM'wire radius
220 W(Z,4)=3.1415929794311523!*R^2*12000*0.32100000977516174!    :REM'lbs./1000 ft. hard-drawn copper
230 W(Z,3)=W(Z,4)*0.9160000085830688!                :REM'lbs./1000 ft. copperweld
240 NEXT Z
250 :REM'
260 :REM'start
270 CLS
280 COLOR 15,2
290 PRINT " WIRE SAG in Horizontal Wire Antennas";
300 PRINT TAB(57);"by George Murphy VE3ERP ";
310 COLOR 1,0:PRINT STRING$(80,223);
320 COLOR 7,0:T=7
330 PRINT TAB(T);
340 PRINT "Ref. The ARRL Antenna Book, 18th edition, pp. 20-2, 20-3"
350 PRINT
360 PRINT TAB(T);
370 PRINT "The curve made by a flexible entity (e.g., cord, chain, cable,"
380 PRINT TAB(T);
390 PRINT "wire, etc.) hanging freely between two points of suspension not"
400 PRINT TAB(T);
410 PRINT "necessarily of the same height is called a catenary curve. When"
420 PRINT TAB(T);
430 PRINT "the suspension points are of the same height the catenary curve is"
440 PRINT TAB(T);
450 PRINT "a parabola."
460 PRINT
470 PRINT TAB(T);
480 PRINT "This program assumes a horizontal wire antenna with ends suspended"
490 PRINT TAB(T);
500 PRINT "at the same height."
510 PRINT
520 PRINT TAB(T);
530 PRINT"The amount of sag calculated by this program should be increased by"
540 PRINT TAB(T);
550 PRINT"a factor of from about 1.5 to 2.0 if an unsupported heavy feeder"
560 PRINT TAB(T);
570 PRINT"line is suspended from the antenna, especially near the centre."
580 PRINT
590 COLOR 7:LOCATE CSRLIN,22:COLOR 0,7
600 PRINT " Press 1 to continue or 0 to EXIT.....":COLOR 7,0
610 Z$=INKEY$:IF Z$=""THEN 610
620 IF Z$="0"THEN CLS:RUN EX$
630 IF Z$="1"THEN 650
640 GOTO 610
650 COLOR 7,0
660 :REM'
670 :REM'.....start
680 GOSUB 1770      :REM'text
690 GOSUB 2240      :REM'screen dump
700 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
710 PRINT " Press number in < > to choose standard units of measure:"
720 PRINT UL$;
730 PRINT "  < 1 >  Metric"
740 PRINT "  < 2 >  U.S.A./Imperial"
750 PRINT UL$;
760 Z$=INKEY$:IF Z$=""THEN 760
770 M=VAL(Z$):IF M=1 OR M=2 THEN 800
780 GOTO 760
790 :REM'
800 IF M=1 THEN M=2:GOTO 820
810 IF M=2 THEN M=1:GOTO 820
820 IF M=2 THEN M$="metres":ELSE M$="feet"
830 PRINT " ENTER: Length of wire to be suspended between supports, in ";M$;
840 INPUT Z:LW=Z/2      :REM'LW=one half the distance between supports
850 IF M=2 THEN FT=LW*3.2808001041412354! :ELSE FT=LW
860 CLS
870 COLOR 1,2:PRINT STRING$(80,223);
880 COLOR 2,2:PRINT STRING$(80,32);
890 COLOR 15,2:LOCATE CSRLIN-1,6
900 PRINT " RECOMMENDED MINIMUM SAG in a HORIZONTAL WIRE ANTENNA";LW*2;M$;" long "
910 COLOR 2,1:PRINT STRING$(80,223);
920 COLOR 7,0
930 PRINT "Wire      │┌────────── COPPERWELD ──────────┐│┌────── HARD-DRAWN COPPER ───────┐";
940 PRINT "Size  Wire│ lbs./   Wire  ┌───Recommended───┐│ lbs./   Wire  ┌───Recommended───┐";
950 PRINT "AWG#  Dia.│ M ft.  Weight   Tension     Sag  │ M ft.. Weight   Tension     Sag"
960 PRINT UL$;
970 LOCATE CSRLIN-1,11:PRINT "╪":LOCATE CSRLIN-1,46:PRINT "╪"
980 FOR Z=1 TO 9
990 AWG=W(Z,1)
1000 PRINT USING "##";AWG;
1010 DIA=W(Z,2)
1020 IF M=1 THEN PRINT "  ";USING ".####";DIA;:PRINT CHR$(34);"│";
1030 IF M=2 THEN PRINT USING "###.##";DIA*25.399999618530273!;:PRINT "mm│";
1040 PRINT USING "####.#";W(Z,3);
1050 A=PI*(DIA/2)^2                 :REM'cross section area
1060 SF=0.1289999932050705!                        :REM'sag factor
1070 :REM'
1080 W1=W(Z,3)*FT/1000              :REM'weight - copperweld
1090 E1=15000                       :REM'modulus for copperweld
1100 F1=E1*A                        :REM'tension for copperweld
1110 S1=W1^2/A*SF/F1                :REM'sag for copperweld
1120 D1=2*SQR((FT/2)^2-(4/3*S1^2))  :REM'distance between supports
1130 :REM'
1140 W2=W(Z,4)*FT/1000              :REM'weight - hard-drawn copper
1150 E2=6350                        :REM'modulus for hard-drawn copper
1160 F2=E2*A                        :REM'tension for hard-drawn copper
1170 S2=W2^2/A*SF/F2                :REM'sag for hard-drawn copper
1180 IF(FT/2)^2<(4/3*S2^2)THEN BEEP:GOTO 1650
1190 D2=2*SQR((FT/2)^2-(4/3*S2^2))  :REM'distance between supports
1200 :REM'
1210 U$="####.#"
1220 IF M=1 THEN PRINT TAB(18);USING U$;W1;:PRINT " lb";
1230 IF M=2 THEN PRINT TAB(18);USING U$;W1/2.2046000957489014!;:PRINT " Kg";
1240 IF M=1 THEN PRINT TAB(28);USING U$;F1;:PRINT " lb";
1250 IF M=2 THEN PRINT TAB(28);USING U$;F1/2.024600028991699!;:PRINT " Kg";
1260 IF M=1 THEN PRINT TAB(37);USING U$+"#";S1;:PRINT "' │";
1270 IF M=2 THEN PRINT TAB(37);USING U$+"#";S1*0.30480000376701355!;:PRINT "m │";
1280 PRINT USING "####.#";W(Z,4);
1290 IF M=1 THEN PRINT TAB(53);USING U$;W2;:PRINT " lb";
1300 IF M=2 THEN PRINT TAB(53);USING U$;W2/2.024600028991699!;:PRINT " Kg";
1310 IF M=1 THEN PRINT TAB(63);USING U$;F2;:PRINT " lb";
1320 IF M=2 THEN PRINT TAB(63);USING U$;F2/2.2046000957489014!;:PRINT " Kg";
1330 IF M=1 THEN PRINT TAB(72);USING U$+"#";S2;:PRINT "'"
1340 IF M=2 THEN PRINT TAB(72);USING U$+"#";S2*0.30480000376701355!;:PRINT "m ";
1350 NEXT Z
1360 :REM'
1370 PRINT UL$;
1380 LOCATE CSRLIN-1,11:PRINT "╪":LOCATE CSRLIN-1,46:PRINT "╪"
1390 PRINT "Lgth./Sag:";TAB(11);"│";
1400 SR1=FT*2/S1:SP1=S1/(FT*2)*100
1410 SR2=FT*2/S2:SP2=S2/(FT*2)*100
1420 A=SR1:GOSUB 1710
1430 PRINT "ratio=";USING A$;A;:PRINT ":1";
1440 A=SP1:GOSUB 1710
1450 PRINT "  sag= ";USING A$+"#";A;:PRINT "% of lgth.";
1460 PRINT TAB(46);"│";
1470 A=SR2:GOSUB 1710
1480 PRINT "ratio=";USING A$;A;:PRINT ":1";
1490 A=SP2:GOSUB 1710
1500 PRINT "  sag= ";USING A$+"#";A;:PRINT "% of lgth.";
1510 PRINT UL$;
1520 LOCATE CSRLIN-1,11:PRINT "╧":LOCATE CSRLIN-1,46:PRINT "╪"
1530 IF M=2 THEN X=D1/3.2808001041412354!:X$="m" :ELSE X=D1:X$="'"
1540 PRINT "Horizontal Distance end-to-end:";TAB(37);USING "####.##";X*2;
1550 PRINT X$;" │";
1560 IF M=2 THEN X=D2/3.2808001041412354!:X$="m" :ELSE X=D2:X$="'"
1570 PRINT TAB(72);USING "####.##";X*2;:PRINT X$;
1580 PRINT UL$;
1590 LOCATE CSRLIN-1,46:PRINT "╧"
1600 PRINT "NOTE: All calculated values have been rounded-off."
1610 PRINT UL$;
1620 GOSUB 2240
1630 GOTO 260   :REM'start
1640 :REM'
1650 :REM'.....excessive length
1660 VIEW PRINT 8 TO 24:CLS:VIEW PRINT:LOCATE 10
1670 PRINT " NOT RECOMMENDED!  Sag exceeds practical limit....press any key...."
1680 IF INKEY$=""THEN 1680
1690 GOTO 260   :REM'start
1700 :REM'
1710 :REM'.....format
1720 A$="###.#"
1730 IF A<100 THEN A$="##.#"
1740 IF A<10 THEN A$="#.#"
1750 RETURN
1760 :REM'
1770 :REM'.....text block
1780 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1790 TB=7     :REM'tab for text
1800 PRINT TAB(TB);
1810 PRINT "  The sag in a horizontal wire is the distance between the centre"
1820 PRINT TAB(TB);
1830 PRINT "of the wire and an imaginary line drawn between its ends. The"
1840 PRINT TAB(TB);
1850 PRINT "minimum amount of sag should be such that the tension in the wire"
1860 PRINT TAB(TB);
1870 PRINT "due to its own weight does not exceed 10% of the breaking point of"
1880 PRINT TAB(TB);
1890 PRINT "of the wire. This will allow for additional normal stresses due to"
1900 PRINT TAB(TB);
1910 PRINT "wind and ice loading and lightweight feedlines without stretching"
1920 PRINT TAB(TB);
1930 PRINT "the wire."
1940 PRINT TAB(TB);
1950 PRINT "  Decreasing the recommended sag by pulling the wire tighter"
1960 PRINT TAB(TB);
1970 PRINT "increases the tension, causing the wire to stretch and change its"
1980 PRINT TAB(TB);
1990 PRINT "electrical properties at RF frequencies as well as lowering its"
2000 PRINT TAB(TB);
2010 PRINT "breaking point. This can start a continuing cycle of further"
2020 PRINT TAB(TB);
2030 PRINT "sagging of the weakened wire due to its own weight and retightening"
2040 PRINT TAB(TB);
2050 PRINT "to reduce the sag until the recurring over-stressing of the"
2060 PRINT TAB(TB);
2070 PRINT "increasingly weakened wire causes it to break under normal loads."
2080 PRINT TAB(TB);
2090 PRINT "  Contrary to a popular misconception, reducing the wire size does"
2100 PRINT TAB(TB);
2110 PRINT "not reduce the recommended amount of sag. While the overall weight"
2120 PRINT TAB(TB);
2130 PRINT "will be reduced the lower breaking point of the smaller wire will"
2140 PRINT TAB(TB);
2150 PRINT "result in the recommended sag remaining the same."
2160 PRINT TAB(TB);
2170 PRINT "  Do not use aluminum or soft copper wire for antennas. To meet the"
2180 PRINT TAB(TB);
2190 PRINT "design criteria expressed above, excessively large and unsightly"
2200 PRINT TAB(TB);
2210 PRINT "amounts of sag would be required."
2220 RETURN
2230 :REM'
2240 :REM'PRT
2250 KEY OFF:GOSUB 2320:LOCATE 25,5:COLOR 0,2
2260 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2270 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2280 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2280 :ELSE GOSUB 2320
2290 IF Z$="3"THEN RETURN
2300 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2310 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2250
2320 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
