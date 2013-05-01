10 :REM'OPAMP - Operational Amplifiers - 03 AUG 95 rev.12 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 DIM R(25)
60 PI=3.1415929794311523!
70 E$=STRING$(79,32)
80 UL$=STRING$(80,205)
90 U$="######,###"
100 V$="######,###.#"
110 W$="######,###.###"
120 :REM'
130 DATA 10,11,12,13,15,16,18,20,22,24,27,30,33,36,39
140 DATA 43,47,51,56,62,68,75,82,91,100
150 FOR Z=0 TO 24:READ R(Z):NEXT Z
160 GOTO 310
170 :REM'
180 :REM'.....find nearest standard resistor
190 M=0.10000000149011612!              :REM'multiplier
200 RX=ABS(RX)
210 FOR Z=1 TO 24
220 RLO=R(Z-1)*M      :REM'low resistor
230 RHI=R(Z)*M        :REM'high resistor
240 IF RX=RLO THEN 290
250 IF RX>RLO AND RX<RHI THEN 260 :ELSE 280
260 IF RX<(RLO+RHI)/2 THEN RX=RLO :ELSE RX=RHI
270 GOTO 290
280 NEXT Z:M=M*10:GOTO 210
290 RETURN
300 :REM'
310 :REM'.....start................................
320 COLOR 15,2
330 PRINT " OP AMPS (Operational Amplifiers)";
340 PRINT TAB(57);"by George Murphy VE3ERP ";
350 COLOR 1,0:PRINT STRING$(80,223);
360 COLOR 7,0
370 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
380 T=1:GOSUB 630    :REM'diagram 1
390 T=26:GOSUB 790   :REM'diagram 2
400 T=55:GOSUB 950   :REM'diagram 3
410 COLOR 0,7
420 FOR Z=3 TO 12:LOCATE Z,25:PRINT "│":LOCATE Z,54:PRINT"│":NEXT Z
430 COLOR 7,0
440 LOCATE 13:PRINT UL$;
450 PRINT " Ref. ";CHR$(34);"Programs for Electronic Circuit Design";CHR$(34);
460 PRINT " by David Leithauser,"
470 PRINT "       Radio Shack Cat.No. 62-1054, pages 77-84"
480 PRINT UL$;
490 PRINT " Press one of the numbers in < > above ";
500 PRINT "to select basic Op-Amp circuit"
510 PRINT "  - or -"
520 PRINT " Press 0 to EXIT"
530 PRINT UL$;
540 Z$=INKEY$
550 IF Z$="0"THEN CLS:RUN EX$
560 IF VAL(Z$)>=1 AND VAL(Z$)<=3 THEN 580
570 GOTO 540
580 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
590 IF Z$="1"THEN T=29:GOSUB 630:GOTO 1110
600 IF Z$="2"THEN T=27:GOSUB 790:GOTO 1410
610 IF Z$="3"THEN T=27:GOSUB 950:GOTO 1790
620 :REM'
630 :REM'.....inverting
640 COLOR 15,2
650 LOCATE  3,T:PRINT "  <1> INVERTING OP-AMP   "
660 LOCATE  4,T:PRINT " without input capacitor "
670 COLOR 0,7
680 LOCATE  5,T:PRINT "              R2         "
690 LOCATE  6,T:PRINT "           ┌\/\/\┐       "
700 LOCATE  7,T:PRINT "       R1  │┌───┐│       "
710 LOCATE  8,T:PRINT " in ─\/\/\─┴┤-  ││       "
720 LOCATE  9,T:PRINT "            │   ├┴─ out  "
730 LOCATE 10,T:PRINT "   ┌─\/\/\──┤+  │        "
740 LOCATE 11,T:PRINT "   │   R3   └───┘        "
750 LOCATE 12,T:PRINT " \\┴\\grnd               "
760 COLOR 7,0
770 RETURN
780 :REM'
790 :REM'.....inverting with input capacitor
800 COLOR 15,2
810 LOCATE  3,T:PRINT "    <2> INVERTING OP-AMP     "
820 LOCATE  4,T:PRINT "    with input capacitor     "
830 COLOR 0,7
840 LOCATE  5,T:PRINT "                  R2         "
850 LOCATE  6,T:PRINT "               ┌\/\/\┐       "
860 LOCATE  7,T:PRINT "     C1    R1  │┌───┐│       "
870 LOCATE  8,T:PRINT " in ──╫──\/\/\─┴┤-  ││       "
880 LOCATE  9,T:PRINT "                │   ├┴─ out  "
890 LOCATE 10,T:PRINT "       ┌─\/\/\──┤+  │        "
900 LOCATE 11,T:PRINT "       │   R3   └───┘        "
910 LOCATE 12,T:PRINT "     \\┴\\grnd               "
920 COLOR 7,0
930 RETURN
940 :REM'
950 :REM'.....non-inverting
960 COLOR 15,2
970 LOCATE  3,T:PRINT " <3> NON-INVERTING OP-AMP ";
980 LOCATE  4,T:PRINT "                          ";
990 COLOR 0,7
1000 LOCATE  5,T:PRINT "                          ";
1010 LOCATE  6,T:PRINT "              ┌───┐       ";
1020 LOCATE  7,T:PRINT " in ──────────┤+  │       ";
1030 LOCATE  8,T:PRINT "              │   ├┬─ out ";
1040 LOCATE  9,T:PRINT "     ┌─\/\/\─┬┤-  ││      ";
1050 LOCATE 10,T:PRINT "     │   R1  │└───┘│      ";
1060 LOCATE 11,T:PRINT "     │       └\/\/\┘      ";
1070 LOCATE 12,T:PRINT "   \\┴\\grnd    R2        ";
1080 COLOR 7,0
1090 RETURN
1100 :REM'
1110 :REM'.....inverting, without input capacitor
1120 LOCATE 13:PRINT UL$;
1130 IF RS THEN 1150
1140 INPUT "ENTER: Source resistance in ohms...................";RS:GOSUB 1230
1150 IF R1 THEN 1170
1160 INPUT "ENTER: Value of R1 in ohms.........................";R1:GOSUB 1230
1170 IF R2 THEN 1190
1180 INPUT "ENTER: Value of R2 in ohms.........................";R2:GOSUB 1230
1190 IF G THEN 1210
1200 INPUT "ENTER: Desired amplifier gain......................";G:GOSUB 1230
1210 VIEW PRINT 14 TO 24:CLS:LOCATE 14:GOTO 1130
1220 :REM'
1230 G=ABS(G)
1240 FOR Z=1 TO 4
1250 IF RS=0 AND R1*R2*G<>0 THEN RS=R2/G-R1
1260 IF R1=0 AND RS*R2*G<>0 THEN R1=R2/G-RS:  RX=R1:GOSUB 180:R1=RX
1270 IF R2=0 AND RS*R1*G<>0 THEN R2=G*(RS+R1):RX=R2:GOSUB 180:R2=RX
1280 IF G=0 AND RS*R1*R2<>0 THEN G=R2/(RS+R1)
1290 IF RS*R1*R2*G THEN 1320
1300 NEXT Z
1310 RETURN
1320 VIEW PRINT 14 TO 24:CLS:VIEW PRINT:LOCATE 14
1330 R3=(RS+R1)*R2/(RS+R1+R2):RX=R3:GOSUB 180:R3=RX
1340 PRINT " Source resistance...........";USING U$;RS;:PRINT " Ω"
1350 PRINT " R1..........................";USING U$;R1;:PRINT " Ω"
1360 PRINT " R2..........................";USING U$;R2;:PRINT " Ω"
1370 PRINT " R3..........................";USING U$;R3;:PRINT " Ω"
1380 PRINT " Amplifier gain..............";USING V$;-G
1390 GOTO 2010
1400 :REM'
1410 :REM'.....inverting, with input capacitor
1420 LOCATE 13:PRINT UL$;
1430 IF RS THEN 1470
1440 INPUT "ENTER: Source resistance in ohms...................";RS
1450 IF RS THEN GOSUB 1590:GOTO 1470
1460 LOCATE CSRLIN-1:PRINT E$:LOCATE CSRLIN -1:GOTO 1440
1470 IF R1 THEN 1490
1480 INPUT "ENTER: Value of R1 in ohms.........................";R1:GOSUB 1590
1490 IF R2 THEN 1510
1500 INPUT "ENTER: Value of R2 in ohms.........................";R2:GOSUB 1590
1510 IF C THEN 1540
1520 INPUT "ENTER: Value of C1 in microfarads (mF).............";C
1530 C=C/10^6:GOSUB 1590   :REM'capacitance in farads
1540 IF F THEN 1570
1550 INPUT "ENTER: Cutoff frequency (kHz)......................";F
1560 F=F*10^3:GOSUB 1590   :REM'frequency in hertz
1570 VIEW PRINT 14 TO 24:CLS:VIEW PRINT:LOCATE 14:GOTO 1430
1580 :REM'
1590 FOR Z=1 TO 5
1600 IF R1=0 AND RS*F*C<>0      THEN R1=1/(2*PI*F*C)-RS:RX=R1:GOSUB 180:R1=RX
1610 IF R2=0 AND G*R1*RS*F*C<>0 THEN R2=G*SQR((RS+R1)+1/((2*PI)^2*F^2*C^2)):RX=R2:GOSUB 180:R2=RX
1620 IF R3=0 AND R2<>0          THEN R3=R2:RX=R3:GOSUB 180:R3=RX
1630 IF G=0 AND R2*RS*R1*F*C<>0 THEN G=-R2/SQR((RS+R1)^2+1/((2*PI)^2*F^2*C^2))
1640 IF F=0 AND RS*R1*C<>0      THEN F=1/(2*PI*(RS+R1)*C)
1650 IF C=0 AND RS*R1*F<>0      THEN C=1/(2*PI*(RS+R1)*F)
1660 IF R1*R2*R3*C*F*G          THEN 1690
1670 NEXT Z
1680 RETURN
1690 VIEW PRINT 14 TO 24:CLS:VIEW PRINT:LOCATE 14
1700 PRINT " Source resistance...........";USING U$;RS;:PRINT " Ω"
1710 PRINT " R1..........................";USING U$;R1;:PRINT " Ω"
1720 PRINT " R2..........................";USING U$;R2;:PRINT " Ω"
1730 PRINT " R3..........................";USING U$;R3;:PRINT " Ω"
1740 PRINT " C1..........................";USING W$;C*10^6;:PRINT " mF"
1750 PRINT " Cutoff frequency............";USING W$;F/10^3;:PRINT " kHz"
1760 PRINT " Amplifier Gain..............";USING V$;G
1770 GOTO 2010
1780 :REM'
1790 :REM'.....non-inverting
1800 LOCATE 13:PRINT UL$;
1810 IF R1 THEN 1830
1820 INPUT "ENTER: Value of R1 in ohms.........................";R1:GOSUB 1880
1830 IF R2 THEN 1850
1840 INPUT "ENTER: Value of R2 in ohms.........................";R2:GOSUB 1880
1850 IF G THEN 1870
1860 INPUT "ENTER: Desired amplifier gain......................";G:GOSUB 1880
1870 VIEW PRINT 14 TO 24:CLS:LOCATE 14:GOTO 1810
1880 FOR Z=1 TO 4
1890 IF G=0 AND R1*R2<>0    THEN G=1+R2/R1
1900 IF R2=0 AND G*R1<>0    THEN R2=(G-1)*R1:RX=R2:GOSUB 180:R2=RX
1910 IF R1=0 AND G*R2<>0    THEN R1=R2/(G-1):RX=R1:GOSUB 180:R1=RX
1920 IF G*R1*R2             THEN 1950
1930 NEXT Z
1940 RETURN
1950 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 15
1960 PRINT " R1..........................";USING U$;R1;:PRINT " Ω"
1970 PRINT " R2..........................";USING U$;R2;:PRINT " Ω"
1980 PRINT " Amplifier gain..............";USING V$;G
1990 GOTO 2010
2000 :REM'
2010 :REM'.....end
2020 LOCATE 22
2030 PRINT " Calculated resistors have been rounded-off to the nearest";
2040 PRINT " standard values"
2050 GOSUB 2090
2060 R1=0:R2=0:R3=0:C=0:F=0:G=0
2070 CLS:GOTO 310
2080 :REM'
2090 :REM'PRT
2100 KEY OFF:GOSUB 2170:LOCATE 25,5:COLOR 0,2
2110 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2120 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2130 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2130 :ELSE GOSUB 2170
2140 IF Z$="3"THEN RETURN
2150 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2160 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2100
2170 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
