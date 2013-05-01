10 :REM'3MBRIDGE - Impedance Bridge (3-meter) - 10 NOV 97 rev. 04 DEC 1997
20 ON ERROR  GOTO 1320
30 KEY OFF
40 COLOR 7,0,1
50 IF EX$=""THEN EX$="EXIT"
60 PROG$="3mbridge"
70 COMMON EX$,PROG$,RC
80 PI=3.1415929794311523!
90 U$="####.# "
100 :REM'
110 :REM'.....start
120 CLS:COLOR 15,2
130 PRINT " IMPEDANCE BRIDGE (3-meter)";TAB(61)"by Peter Dodd G3LDO ";
140 PRINT STRING$(80,32);
150 LOCATE CSRLIN-1,13
160 PRINT "edited and enhanced for HAMCALC by George Murphy VE3ERP"
170 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
180 GOSUB 1410        :REM'diagram
190 PRINT: GOSUB 1520 :REM'intro
200 PRINT: COLOR 0,7:PRINT " Press number in ( ) for:":COLOR 7,0
210 :REM'
220 PRINT "      (1) Solution of unknown impedance Z"
230 PRINT "      (2) Bridge operation"
240 PRINT "      (3) Values of Rr and Cr"
250 PRINT "      (4) Schematic of a practical 3-meter Z bridge"
260 PRINT "      (5) WD8KBK Antenna Impedance Calculator"
270 PRINT
280 PRINT "      (0) EXIT";
290 COLOR 15,2:LOCATE 25,1
300 PRINT " From the RSGB book THE ANTENNA EXPERIMENTER'S HANDBOOK, ";
310 PRINT "2nd edition, chapter 2 ";
320 COLOR 7,0
330 Z$=INKEY$:IF Z$=""THEN 330
340 :REM'IF ASC(Z$)<48 OR ASC(Z$)>52 THEN 320
350 IF Z$="0"THEN RUN EX$
360 IF Z$="1"THEN 430
370 IF Z$="2"THEN 1670
380 IF Z$="3"THEN 1920
390 IF Z$="4"THEN 2380
400 IF Z$="5"THEN CLS:CHAIN"antimp"
410 GOTO 330
420 :REM'
430 :REM'.....find Z
440 CLS:GOSUB 1410
450 ENO=0
460 INPUT " ENTER: Characteristic impedance of antenna feedline (ohms)";CHZ
470 FTR=50/CHZ:B=CHZ*FTR
480 V$=" 10 x voltmeter reading "
490 PRINT " ENTER:";V$;"Ea...(A)";:INPUT A:A=A*FTR
500 PRINT SPC(12);"Feedline impedance Er...(B)=";B;"Ω"
510 PRINT " ENTER:";V$;"Ezc..(C)";:INPUT C:C=C*FTR
520 PRINT " ENTER:";V$;"Ec...(D)";:INPUT D:D=D*FTR
530 PRINT " ENTER:";V$;"Ez...(E)";:INPUT E:E=E*FTR
540 VIEW PRINT 7 TO 24:CLS:VIEW PRINT:LOCATE 8
550 PRINT TAB(18)"IMPEDANCE OF ANTENNA FED WITH";CHZ;"Ω FEEDLINE:"
560 PRINT
570 PRINT " If there is more than one line of data below then the data has ";
580 PRINT "been corrected."
590 PRINT " Bottom line indicates corrected data used to determine impedance."
600 PRINT
610 LOCATE CSRLIN,2
620 PRINT "Ea (A)=";USING U$;A;
630 PRINT "│ Er (B)=";USING U$;B;
640 PRINT "│ Ecz (C)=";USING U$;C;
650 PRINT "│ Ec (D)=";USING U$;D;
660 PRINT "│ Ez (E)=";USING U$;E
670 :REM'
680 F=(B^2+C^2-A^2)/(2*B*C)
690 IF F=0 THEN G=PI/2:GOTO 720
700 G=ATN(SQR(1/F^2-1)):IF F<0 THEN G=PI-G
710 :REM'
720 H=(C^2+D^2-E^2)/(2*C*D)
730 IF H=0 THEN J=PI/2:GOTO 760
740 J=ATN(SQR(1/H^2-1)):IF H<0 THEN J=PI-J
750 :REM'
760 K=(A^2+B^2-C^2)/(2*A*B)
770 IF K=0 THEN L=PI/2:GOTO 800
780 L=ATN(SQR(1/K^2-1)):IF K<0 THEN L=PI-L
790 :REM'
800 M=(D^2+E^2-C^2)/(2*D*E)
810 IF M=0 THEN N=PI/2:GOTO 840
820 N=ATN(SQR(1/M^2-1)):IF M<0 THEN N=PI-N
830 :REM'
840 Q=ATN(B/D)
850 T=B/SIN(Q)
860 :REM'
870 ZZ=(T^2+E^2-A^2)/(2*T*E)
880 IF ZZ=0 THEN P=PI/2:GOTO 910
890 P=ATN(SQR(1/ZZ^2-1)):IF ZZ<0 THEN P=PI-P
900 :REM'
910 S=P-Q
920 IF (L+Q)>(PI/2) THEN S=(2*PI)-(P+Q)
930 IF H>0 THEN X1=D-A*SIN(L) :ELSE X1=D+A*SIN(L)
940 X2=E*M
950 X3=E*COS(S)
960 R1=A*K-B
970 R2=E*SIN(N)
980 R3=E*SIN(S)
990 X=(X1+X2+X3)/3
1000 R=(R1+R2+R3)/3
1010 V1=ABS(X1-X)
1020 V2=ABS(X2-X)
1030 V3=ABS(X3-X)
1040 W1=ABS(R1-R)
1050 W2=ABS(R2-R)
1060 W3=ABS(R3-R)
1070 IF V1>=V2 THEN 1090
1080 IF V2>=V3 THEN EX=V2:GOTO 1110
1090 IF V1>=V3 THEN EX=V1:GOTO 1110
1100 EX=V3
1110 IF W1>=W2 THEN 1140
1120 IF W2>=W3 THEN ER=W2:GOTO 1170
1130 ER=W3
1140 IF W1>=W3 THEN ER=W1:GOTO 1170
1150 ER=W3
1160 :REM'
1170 SN=SGN(X)
1180 IF X>=0 THEN P$="+j":GOTO 1200
1190 X=-X:P$="-j"
1200 EX=INT(10*EX+0.5!)/10
1210 ER=INT(10*ER+0.5!)/10
1220 R=INT(10*R+0.5!)/10
1230 X=INT(10*X+0.5!)/10
1240 COLOR 0,7:LOCATE ,27
1250 PRINT " IMPEDANCE =";R;P$;ABS(X);"Ω ":COLOR 7,0
1260 COLOR 0,7
1270 PRINT " Error Tolerances:":COLOR 7,0
1280 PRINT "   Resistance component: ";R;"±";ER;"Ω"
1290 PRINT "   Reactance  component: ";X*SN;"±";EX;"Ω"
1300 GOTO 2880
1310 :REM'
1320 :REM'.....error trapping
1330 ENO=ENO+1
1340 IF ENO >10 THEN BEEP:GOTO 1380
1350 IF ERL=700 AND ERR=5 THEN C=C+1:RESUME 610
1360 IF ERL=890 AND ERR=5 THEN D=D+1:RESUME 610
1370 PRINT "Error";ERR;"in line";ERL:END
1380 COLOR 14,4:LOCATE ,23
1390 PRINT" ERROR IN DATA CANNOT BE CORRECTED ";:COLOR 7,0:GOTO 2880
1400 :REM'
1410 :REM'.....diagram
1420 COLOR 0,7:I=16
1430 LOCATE ,I:PRINT " 3 - M E T E R   I M P E D A N C E   B R I D G E "
1440 LOCATE ,I:PRINT "                 │« Er »│« Ec »│                 "
1450 LOCATE ,I:PRINT "                 │  Rr  │  Cr  │                 "
1460 LOCATE ,I:PRINT "           ┌─────┬─/\/\─┬──┤├──┬────── feedline  "
1470 LOCATE ,I:PRINT " Generator ≈    Ea     Ecz    Ez       to        "
1480 LOCATE ,I:PRINT "           └─────┴──────┴──────┴────── unknown Z "
1490 COLOR 7,0
1500 RETURN
1510 :REM'
1520 :REM'.....intro
1530 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11
1540 TB=7
1550 PRINT TAB(TB);
1560 PRINT "An unknown impedance Z is compared to a reference impedance fixed"
1570 PRINT TAB(TB);
1580 PRINT "by the values of Rr & Cr, and the ratio is indicated by 3 voltmeter"
1590 PRINT TAB(TB);
1600 PRINT "readings Ea, Ecz and Ez. Additional reading Er allows calibration"
1610 PRINT TAB(TB);
1620 PRINT "of the reference capacitor and reading Ec permits several solutions"
1630 PRINT TAB(TB);
1640 PRINT "for the unknown impedance."
1650 RETURN
1660 :REM'
1670 :REM'.....operation
1680 VIEW PRINT 10 TO 24:CLS:VIEW PRINT:LOCATE 11
1690 PRINT TAB(TB);
1700 PRINT "Measure RF voltages using diode probes and a digital voltmeter."
1710 PRINT TAB(TB);
1720 PRINT "The RF generator can be a QRP transmitter. Record all readings as"
1730 PRINT TAB(TB);
1740 PRINT "values that are 10 x the voltmeter reading."
1750 PRINT
1760 PRINT TAB(TB);
1770 PRINT "1. Connect voltmeter to read Er."
1780 PRINT
1790 PRINT TAB(TB);
1800 PRINT "2. Set generator to lowest power level and switch on."
1810 PRINT
1820 PRINT TAB(TB);
1830 PRINT "3. Increase power until voltmeter reads 5.0v. Record this as ";
1840 PRINT CHR$(34);"50";CHR$(34);"."
1850 PRINT
1860 PRINT TAB(TB);
1870 PRINT "4. Record readings of Ea, Ecz, Ez and Ec as values that are 10 x"
1880 PRINT TAB(TB);
1890 PRINT "the voltmeter readings."
1900 GOTO 2880
1910 :REM'
1920 :REM'.....R/C values
1930 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11
1940 PRINT TAB(TB);
1950 PRINT "The value of Rr and reactance of Cr should be as close as possible"
1960 PRINT TAB(TB);
1970 PRINT "to the characteristic impedance of the feed line. Press any key to"
1980 PRINT TAB(TB);
1990 PRINT "compute the values of Rr and Cr . . . . "
2000 IF INKEY$=""THEN 2000
2010 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11
2020 INPUT " ENTER: Frequency in ...........................(MHz)";FQ
2030 INPUT " ENTER: Characteristic impedance of feedline ..(ohms)";CHZ
2040 CAP=10^6/(2*PI*CHZ*FQ)
2050 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11
2060 PRINT "        Frequency ...................................";FQ;"MHz"
2070 PRINT "        Characteristic impedance of feedline ........";CHZ;"Ω"
2080 PRINT "        Value of R ..................................";CHZ;"Ω"
2090 PRINT "        Reactance of C ..............................";CHZ;"Ω"
2100 PRINT "        Value of C ..................................";CAP;"pF"
2110 PRINT
2120 PRINT TAB(TB);
2130 PRINT "For maximum flexibility of the bridge, mount Rr and Cr for each"
2140 PRINT TAB(TB);
2150 PRINT "frequency/feedline combination of interest on a plug-in module."
2160 PRINT
2170 PRINT TAB(TB);
2180 PRINT "The closer Rr and Cr are to the above values the more accurate the"
2190 PRINT TAB(TB);
2200 PRINT "bridge will be. You can use the closest standard values, or you can"
2210 PRINT TAB(TB);
2220 PRINT "assemble standard components in parallel to obtain custom values."
2230 PRINT
2240 COLOR 15,1:LOCATE ,TB-1
2250 PRINT " Do you want to assemble a custom value Rr or Cr ?  (y/n) ";
2260 COLOR 7,0
2270 Z$=INKEY$:IF Z$=""THEN 2270
2280 IF Z$="n"THEN LOCATE CSRLIN-1:PRINT STRING$(80,32);:GOTO 2880
2290 IF Z$="y"THEN 2310
2300 GOTO 2270
2310 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE ,TB-1
2320 COLOR 15,2:PRINT " Do you want custom Rr or custom Cr ?  (r/c) ";:COLOR 7,0
2330 Z$=INKEY$:IF Z$=""THEN 2330
2340 IF Z$="r"THEN CLS:RC=CHZ:CHAIN"custohm"
2350 IF Z$="c"THEN CLS:RC=CAP:CHAIN"custcap"
2360 GOTO 2330
2370 :REM'
2380 :REM'.....schematic
2390 CLS
2400 COLOR 0,7:I=1
2410 LOCATE ,I:PRINT "   3 - M E T E R   I M P E D A N C E   B R I D G E    "
2420 LOCATE ,I:PRINT "       R1          Rr         Cr                      "
2430 LOCATE ,I:PRINT "  ───┬─\/\───┬──«──\/\───┬────┤├──»──┬───────────┬──  "
2440 LOCATE ,I:PRINT " A   │       │           └»┐         │ ┌──>├─┬─┤├┘  B "
2450 LOCATE ,I:PRINT "  ─┐ └─\/\──┬┴───>├─┬─┤├──┬┴──>├─┬─┤├┘ │  D5 │ C5 ┌─  "
2460 LOCATE ,I:PRINT "   │   R2   │    D2 │ C2  │   D4 │ C4  │     │    │   "
2470 LOCATE ,I:PRINT "   │        │       └\/\┐ │      └\/\┐ │ ┌\/\┘    │   "
2480 LOCATE ,I:PRINT "   │   R3   │        R5 │ │       R7 │ │ │ R8     │   "
2490 LOCATE ,I:PRINT "   │ ┌─\/\──┴─┤├─┬─┤<─┐ │ └┤├─┬─┤<─┐ │ │ │        │   "
2500 LOCATE ,I:PRINT "   ▀ ▀        C1 │ D1 ▀ │  C3 │ D3 ▀ │ ▀ │   ┌▀   ▀   "
2510 LOCATE ,I:PRINT "                 └\/\┐  │     └\/\┐  │   │   │        "
2520 LOCATE ,I:PRINT "                  R4 │  │      R6 │  │   │   │        "
2530 LOCATE ,I:PRINT "                     °+ °+        °+ °+  °+  °-       "
2540 LOCATE ,I:PRINT "                     Ea Er       Ecz Ez  Ec com       "
2550 LOCATE ,I:PRINT "                    └───── meter terminals ────┘      "
2560 LOCATE ,I:PRINT "                         or selector switch           "
2570 COLOR 7,0
2580 LOCATE 2
2590 LOCATE ,56:PRINT "A - QRP transmitter"
2600 PRINT
2610 LOCATE ,56:PRINT "B - Transmission line to"
2620 LOCATE ,56:PRINT "     unknown impedance"
2630 PRINT
2640 LOCATE ,56:PRINT "▀ - Chassis ground"
2650 PRINT
2660 LOCATE ,56:PRINT "« » Plug-in points"
2670 PRINT
2680 LOCATE ,56:PRINT "R1,R2  15 Ω 2 watt"
2690 LOCATE ,56:PRINT "R3     20 Ω 5 watt"
2700 LOCATE ,56:PRINT "R4-R8  1 MΩ"
2710 LOCATE ,56:PRINT "C1-C5  1000 pF"
2720 LOCATE ,56:PRINT "D1-D5  1N191 diode"
2730 LOCATE 18
2740 PRINT TAB(TB);
2750 PRINT "Rr and Cr comprise the reference impedance module. To determine"
2760 PRINT TAB(TB);
2770 PRINT "values of Rr & Cr press 3 now, then select item (3) from the menu."
2780 PRINT
2790 PRINT TAB(TB);
2800 PRINT "For construction details and a full description of this equipment"
2810 PRINT TAB(TB);
2820 PRINT "see ";CHR$(34)"THE ANTENNA EXPERIMENTER'S GUIDE";CHR$(34);
2830 PRINT ", 2nd edition, chapter 2, by"
2840 PRINT TAB(TB);
2850 PRINT "Peter Dodd G3LDO, published by the Radio Society of Great Britain"
2860 GOTO 2880
2870 :REM'
2880 :REM'.....end
2890 GOSUB 2910:GOTO 110
2900 :REM'
2910 :REM'PRT
3000 KEY OFF:GOSUB 3070:LOCATE 25,5:COLOR 0,2
3010 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3020 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3030 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3030 :ELSE GOSUB 3070
3040 IF Z$="3"THEN RETURN
3050 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3060 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3000
3070 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
