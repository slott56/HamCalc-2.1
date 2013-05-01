10 :REM'TANKCCT - Power Amplifier - 11 AUG 95 rev.13 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 U$="#####.###"
60 UL$=STRING$(80,205)
70 E$=STRING$(80,32)
80 PI=3.1415929794311523!
90 DIM CF(11,2)     :REM'centre frequencies of HF bands
100 DATA 0, 160, 80, 40, 30, 20, 17, 15, 12, 10, 1
110 DATA 1.8, 1.9, 3.75, 7.15, 10.125, 14.175
120 DATA 18.118, 21.225, 24.94, 28.85, 29.7
130 FOR Z=1 TO 11:READ CF(Z,1):NEXT Z
140 FOR Z=1 TO 11:READ CF(Z,2):NEXT Z
150 :REM'
160 :REM'.....start
170 CLS:CTUN=0:R1=0:R2=0:Q=0:F=0
180 COLOR 15,2
190 PRINT " TANK CIRCUIT - Power Amplifier (Vacuum Tube Type)";
200 PRINT TAB(57);"by George Murphy VE3ERP ";
210 COLOR 1,0:PRINT STRING$(80,223);
220 COLOR 7,0
230 GOSUB 1540:PRINT UL$;      :REM'diagram
240 LN=CSRLIN
250 GOSUB 1710                 :REM'preface
260 COLOR 0,7:LOCATE 25,22
270 PRINT " Press 1 to continue or 0 to EXIT.....";
280 COLOR 7,0
290 Z$=INKEY$:IF Z$=""THEN 290
300 IF Z$="0"THEN CLS:RUN EX$
310 IF Z$="1"THEN 330
320 GOTO 290
330 GOSUB 2100                 :REM'dump screen
340 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
350 GOTO 420
360 :REM'
370 :REM'.....format input line
380 LOCATE CSRLIN-1:PRINT SPC(7);
390 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;Z;
400 RETURN
410 :REM'
420 :REM'.....data input
430 PRINT TAB(T);
440 PRINT "C1 should not be less than 35 pF for vacuum variable capacitors."
450 PRINT TAB(T);
460 PRINT "C1 should not be less than 45-50 pF for air variable capacitors."
470 INPUT " ENTER: Minimum capacitance of C1................(pF)";CTUN
480 IF CTUN=0 THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 470
490 VIEW PRINT 9 TO 24:CLS:VIEW PRINT:LOCATE 9
500 PRINT "        Minimum capacitance of C1....................";USING U$;CTUN;
510 PRINT " pF"
520 INPUT " ENTER: INPUT resistance R1....................(ohms)";R1
530 IF R1=0 THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 520
540 Z=R1:GOSUB 370:PRINT " Ω"
550 INPUT " ENTER: LOAD  resistance R2....................(ohms)";R2
560 IF R2=0 THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 550
570 Z=R2:GOSUB 370:PRINT " Ω"
580 :REM'
590 MIN1=R1/R2-1:MIN2=R2\R1-1
600 IF MIN1>MIN2 THEN MIN=MIN1 :ELSE MIN=R2
610 QMIN=SQR(MIN)+0.0010000000474974513!
620 :REM'
630 PRINT "        Minimum circuit operating Q..................";USING U$;QMIN
640 INPUT " ENTER: Desired circuit operating Q..................";Q
650 IF Q<QMIN THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 640
660 QO=Q
670 Z=QO:GOSUB 370:PRINT ""
680 :REM'
690 INPUT " ENTER: Operating Frequency.....................(MHz)";F
700 IF F=0 THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 690
710 Z=F:GOSUB 370:PRINT " MHz"
720 :REM'
730 :REM'.....calculate values
740 Q1=(R1*QO-SQR(R1*R2*QO^2-(R1-R2)^2))/(R1-R2)
750 Q2=QO-Q1
760 XC1=R1/Q1
770 XC2=R2/Q2
780 XL=R1*QO/(Q1^2+1)
790 C1=1/(2*PI*F*XC1)*10^6
800 C2=1/(2*PI*F*XC2)*10^6
810 L=XL/(2*PI*F)
820 IF C1<CTUN-9.999999747378752e-05! THEN 1010
830 PRINT "        Input Q......................................";USING U$;Q1
840 PRINT "        Output Q.....................................";USING U$;Q2
850 PRINT "        Reactance - Capacitor C1.....................";USING U$;XC1
860 Z=XC1:GOSUB 370:PRINT " Ω"
870 PRINT "        Reactance - Capacitor C2.....................";USING U$;XC2
880 Z=XC2:GOSUB 370:PRINT " Ω"
890 PRINT "        Reactance - Inductor L1......................";USING U$;XL
900 Z=XL:GOSUB 370:PRINT " Ω"
910 PRINT "        Capacitor C1.................................";USING U$;C1;
920 PRINT " pF"
930 PRINT "        Capacitor C2.................................";USING U$;C2;
940 PRINT " pF"
950 PRINT "        Inductor L1..................................";USING U$;L;
960 PRINT " µH"
970 PRINT "        Actual circuit operating Q...................";USING U$;QO
980 GOSUB 2100
990 GOTO 1070
1000 :REM'
1010 :REM'.....recalculate QO if c1<minimum pF
1020 XC1=1/(2*PI*F*CTUN)*10^6
1030 Q1=R1/XC1
1040 QO=Q1+Q2
1050 GOTO 730
1060 :REM'
1070 :REM'.....table of values
1080 COLOR 0,7
1090 LOCATE 3,1:PRINT R1;"Ω"
1100 LOCATE 4,1:PRINT " in »"
1110 LOCATE 3,40:PRINT R2;"Ω"
1120 COLOR 7,0
1130 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1140 PRINT TAB(16);"TYPICAL CONTROL SETTINGS for the HF AMATEUR BANDS"
1150 PRINT "  Band";
1160 PRINT TAB(13);"MHz";TAB(24);"C1 (pF)";TAB(42);"C2 (pF)";
1170 PRINT TAB(61);"L1 (µH)";TAB(74);"Q"
1180 PRINT UL$;
1190 QO=Q
1200 :REM'
1210 :REM'.....start loop
1220 FOR Z=1 TO 11
1230 :REM'
1240 Q1=(R1*QO-SQR(R1*R2*QO^2-(R1-R2)^2))/(R1-R2)
1250 Q2=QO-Q1
1260 XC1=R1/Q1
1270 XC2=R2/Q2
1280 XL=R1*QO/(Q1^2+1)
1290 FQ=CF(Z,2)
1300 K1=(1/(2*PI*FQ*XC1))*10^6
1310 K2=(1/(2*PI*FQ*XC2))*10^6
1320 IF K1<CTUN-9.999999747378752e-05! THEN 1480
1330 LL=(XL/(2*PI*FQ))
1340 IF CF(Z,1)=0 THEN PRINT " (max.)";:GOTO 1370
1350 IF CF(Z,1)=1 THEN PRINT " (min.)";:GOTO 1370
1360 PRINT USING "#####";CF(Z,1);
1370 PRINT TAB(8);USING U$;CF(Z,2);
1380 PRINT TAB(24);USING "#####";K1;
1390 PRINT TAB(42);USING "#####";K2;
1400 PRINT TAB(59);USING "#####.##";LL;
1410 PRINT TAB(73);USING "##.#";QO;
1420 IF Z=1 OR Z=10 THEN PRINT "  "+STRING$(74,196):GOTO 1440
1430 IF Z<11 THEN PRINT ""
1440 NEXT Z
1450 :REM'.....end of loop
1460 GOTO 2050
1470 :REM'
1480 :REM'.....recalculate if K1<minimum pF
1490 XC1=1/(2*PI*FQ*CTUN)*10^6
1500 Q1=R1/XC1
1510 QO=Q1+Q2
1520 GOTO 1240
1530 :REM'
1540 :REM'.....diagram
1550 LN=CSRLIN:T=3:T1=50
1560 LOCATE LN+0,T1:PRINT "Cb:    blocking capacitor"
1570 LOCATE LN+1,T1:PRINT "C1,C2: variable capacitors"
1580 LOCATE LN+2,T1:PRINT "L1:    variable inductor or"
1590 LOCATE LN+3,T1:PRINT "         tapped coil"
1600 LOCATE LN+4,T1:PRINT "rfc:   RF choke"
1610 LOCATE LN
1620 COLOR 0,7
1630 PRINT TAB(T);" R1         Cb      L1                R2    "
1640 PRINT TAB(T);"   ┌─────┬──╫──┬───∩∩∩∩───┬─────┬──» output "
1650 PRINT TAB(T);" ──┴──  rfc   ═╪═C1    C2═╪═   rfc          "
1660 PRINT TAB(T);" plate   │     │tune  load│     │           "
1670 PRINT TAB(T);"        +HV  \\┴\\      \\┴\\ \\┴\\ chassis "
1680 COLOR 7,0
1690 RETURN
1700 :REM'
1710 :REM'.....preface
1720 T=7
1730 PRINT TAB(T);
1740 PRINT"  You will be asked to enter the input resistance (plate impedance)"
1750 PRINT TAB(T);
1760 PRINT"which for most tetrode amplifier tubes is in the order of from"
1770 PRINT TAB(T);
1780 PRINT"1500 to 2500 ohms. You will also be asked to enter the output (load)"
1790 PRINT TAB(T);
1800 PRINT"resistance (typically the input impedance of the antenna system)."
1810 PRINT TAB(T);
1820 PRINT"  You must also enter the desired Q of the tank circuit. A low Q is"
1830 PRINT TAB(T);
1840 PRINT"desirable for best efficiency, but yields poor harmonic suppression."
1850 PRINT TAB(T);
1860 PRINT"High Q keeps the harmonic levels low but tank efficiency suffers."
1870 PRINT TAB(T);
1880 PRINT"A value of Q=12 is a reasonable and popular compromise. Generally,"
1890 PRINT TAB(T);
1900 PRINT"values of up to about Q=25 are acceptable."
1910 PRINT TAB(T);
1920 PRINT"  To provide enough capacitance for tuning, C1 should not be less"
1930 PRINT TAB(T);
1940 PRINT"than 35-50 pF. If the program calculates a lesser value the Q of the"
1950 PRINT TAB(T);
1960 PRINT"circuit will be recalculated to increase C1 to a pre-determined"
1970 PRINT TAB(T);
1980 PRINT"minimum value."
1990 PRINT TAB(T);
2000 PRINT "   (This program is based on design data and formulae presented in"
2010 PRINT TAB(T);
2020 PRINT"the 1994 ARRL HANDBOOK for RADIO AMATEURS, starting on page 15-3)."
2030 RETURN
2040 :REM'
2050 :REM'.....end
2060 GOSUB 2100
2070 GOTO 160   :REM'start
2080 END
2090 :REM'
2100 :REM'PRT
2110 KEY OFF:GOSUB 2180:LOCATE 25,5:COLOR 0,2
2120 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2130 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2140 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2140 :ELSE GOSUB 2180
2150 IF Z$="3"THEN RETURN
2160 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2170 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2110
2180 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
