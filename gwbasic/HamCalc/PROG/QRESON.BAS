10 :REM'QRESON - Q Calculator, Resonant Circuits - 19 JUL 1998 rev. 30 MAR 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 PROG$="qreson"
50 COMMON EX$,PROG$
60 COLOR 7,0,0
70 PI=4*ATN(1)  :REM'3.141593
80 UL$=STRING$(80,205)
90 :REM'
100 :REM'.....title page
110 X=0:R=0:RL=0:Q=0:QU=0:QL=0:F=0:BW=0:E=0:EX=0:A=0:N=0:D=0
120 CLS
130 COLOR 15,2
140 PRINT " Q CALCULATOR, Resonant Circuits"TAB(57)"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 :REM'
180 :REM'.....start
190 PRINT " This program solves resonant circuit Q equations as set forth in ";
200 PRINT "the 1997 ARRL";
210 PRINT " HANDBOOK for RADIO AMATEURS, pages 6.36 to 6.41"
220 PRINT
230 PRINT " When asked to enter a value that is unknown, press [ENTER] to by-";
240 PRINT "pass the";
250 PRINT " question. If the value is critical, it will either be calculated ";
260 PRINT "for you or"
270 PRINT " asked for again."
280 PRINT UL$;
290 PRINT " Press number in < > for:"
300 PRINT UL$;
310 PRINT "  < 1 > Parallel-Resonant Circuits"
320 PRINT "  < 2 > Series-Resonant Circuits"
330 PRINT "  < 3 > Series/Parallel Conversion"
340 PRINT "  < 4 > Parallel/Series Conversion"
350 PRINT "  < 5 > Bandwidth vs. Frequency"
360 PRINT "  < 6 > Voltage drop across components in series-resonant circuits"
370 PRINT "  < 7 > DC resistance of a copper wire coil"
380 PRINT "  < 8 > Q Calculator - single-layer close-wound coils"
390 PRINT "  < 0 > EXIT"
400 M$=INKEY$:IF M$=""THEN 400
410 IF M$="1"THEN LN=3:GOSUB 520:GOTO 560
420 IF M$="2"THEN LN=3:GOSUB 520:GOTO 790
430 IF M$="3"THEN LN=3:GOSUB 520:GOTO 2130
440 IF M$="4"THEN LN=3:GOSUB 520:GOTO 2390
450 IF M$="5"THEN LN=3:GOSUB 520:GOTO 1340
460 IF M$="6"THEN LN=3:GOSUB 520:GOTO 1590
470 IF M$="7"THEN LN=3:GOSUB 520:GOTO 1800
480 IF M$="8"THEN CLS:CHAIN"coilq"
490 IF M$="0"THEN CLS:RUN EX$
500 GOTO 400
510 :REM'
520 :REM'.....clear window
530 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
540 RETURN
550 :REM'
560 :REM'.....parallel-resonant
570 PRINT " PARALLEL-RESONANT CIRCUIT"
580 PRINT UL$;
590 LN=CSRLIN
600 IF X THEN 630
610 PRINT " ENTER: Reactance of each inductive/capacitive component...(ohms)";
620 INPUT X:GOSUB 720
630 IF RL THEN 660
640 PRINT " ENTER: Parallel load resistance ..........................(ohms)";
650 INPUT RL:GOSUB 720
660 IF QL THEN 690
670 PRINT " ENTER: Circuit loaded Q ........................................";
680 INPUT QL:GOSUB 720
690 GOSUB 520:LOCATE LN
700 GOTO 600
710 :REM'
720 :REM'.....calculate
730 IF QL=0 AND X*RL<>0 THEN QL=RL/X:GOTO 720
740 IF X=0 AND QL*RL<>0 THEN X=RL/QL:GOTO 720
750 IF RL=0 AND QL*X<>0 THEN RL=X*QL:GOTO 720
760 IF QL*X*RL<>0 THEN LN=5:GOSUB 520:GOTO 1020
770 RETURN
780 :REM'
790 :REM'.....series-resonant
800 PRINT " SERIES-RESONANT CIRCUIT"
810 PRINT UL$;
820 LN=CSRLIN
830 IF X THEN 860
840 PRINT " ENTER: Reactance of each inductive/capacitive component...(ohms)";
850 INPUT X:GOSUB 950
860 IF R THEN 890
870 PRINT " ENTER: Circuit loss resistance ...........................(ohms)";
880 INPUT R:GOSUB 950
890 IF QU THEN 920
900 PRINT " ENTER: Unloaded Q ..............................................";
910 INPUT QU:GOSUB 950
920 GOSUB 520:LOCATE LN
930 GOTO 830
940 :REM'
950 :REM'.....calculate
960 IF QU=0 AND X*R<>0 THEN QU=X/R:GOTO 950
970 IF X=0 AND QU*R<>0 THEN X=QU*R:GOTO 950
980 IF R=0 AND QU*X<>0 THEN R=X/QU:GOTO 950
990 IF QU*X*R<>0 THEN LN=5:GOSUB 520:GOTO 1020
1000 RETURN
1010 :REM'
1020 :REM'.....display
1030 LN=5:GOSUB 520
1040 IF RL=0 THEN 1060
1050 PRINT USING " Parallel load resistance .............. #####.### Ω";RL
1060 IF X=0 THEN 1090
1070 PRINT USING " Reactance of inductive component ......+#####.### Ω";X
1080 PRINT USING " Reactance of capacitive component...... #####.### Ω";-X
1090 IF R=0 THEN 1110
1100 PRINT USING " Circuit loss resistance ............... #####.### Ω";R
1110 IF Q=0 OR QU+QL THEN 1130
1120 PRINT USING " Q ..................................... #####.###";Q
1130 IF QL=0 THEN 1150
1140 PRINT USING " Circuit loaded Q ...................... #####.###";QL
1150 IF QU=0 THEN 1170
1160 PRINT USING " Unloaded Q ............................ #####.###";QU
1170 IF F=0 THEN 1190
1180 PRINT USING " Frequency ............................. #####.### MHz";F/10^3
1190 IF BW=0 THEN 1210
1200 PRINT USING " Bandwidth ............................. #####.### kHz";BW
1210 IF EX=0 THEN 1230
1220 PRINT USING " Voltage across reactive component ..... #####.### volts";EX
1230 IF E=0 THEN 1250
1240 PRINT USING " Source voltage ........................ #####.### volts";E
1250 LN=CSRLIN
1260 GOSUB 2640:GOSUB 2550:LOCATE LN
1270 IF BW OR EX THEN 100
1280 COLOR 0,7:PRINT " Do you want a Bandwidth calculation?  (y/n) ":COLOR 7,0
1290 Z$=INKEY$:IF Z$=""THEN 1290
1300 IF Z$="n"THEN 100
1310 IF Z$="y"THEN GOSUB 520:GOTO 1390
1320 GOTO 1290
1330 :REM'
1340 :REM'.....bandwidth
1350 PRINT " BANDWIDTH vs. FREQUENCY"
1360 PRINT UL$;
1370 LN=CSRLIN
1380 :REM'
1390 IF QU THEN Q=QU
1400 IF QL THEN Q=QL
1410 IF Q THEN 1440
1420 PRINT " ENTER: Circuit Q ...............................................";
1430 INPUT Q:GOSUB 1520
1440 IF F THEN 1470
1450 PRINT " ENTER: Frequency ..........................................(MHz)";
1460 INPUT F:GOSUB 1520
1470 IF BW THEN 1500
1480 PRINT " ENTER: Bandwidth ..........................................(kHz)";
1490 INPUT BW:GOSUB 1520
1500 GOSUB 520:GOTO 1410
1510 :REM'
1520 :REM'.....calculate
1530 IF F=0 AND BW*Q<>0 THEN F=BW*Q:GOTO 1520
1540 IF BW=0 AND F*Q<>0 THEN BW=F/Q:GOTO 1520
1550 IF Q=0 AND BW*F<>0 THEN Q=F/BW:GOTO 1520
1560 IF Q*F*BW<>0 THEN GOSUB 520:GOTO 1020
1570 RETURN
1580 :REM'
1590 :REM'.....voltage drop
1600 PRINT " VOLTAGE DROP ACROSS COMPONENTS in SERIES-RESONANT CIRCUITS"
1610 PRINT UL$;
1620 IF QU THEN 1650
1630 PRINT " ENTER: Circuit Q ...............................................";
1640 INPUT QU:GOSUB 1730
1650 IF E THEN 1680
1660 PRINT " ENTER: Source voltage ..........................................";
1670 INPUT E:GOSUB 1730
1680 IF EX THEN 1710
1690 PRINT " ENTER: Voltage across reactive component .......................";
1700 INPUT EX:GOSUB 1730
1710 LN=5:GOSUB 520:LOCATE LN:GOTO 1620
1720 :REM'
1730 :REM'.....calculate
1740 IF EX=0 AND QU*E<>0 THEN EX=QU*E:GOTO 1730
1750 IF QU=0 AND EX*E<>0 THEN QU=EX/E:GOTO 1730
1760 IF E=0 AND EX*QU<>0 THEN E=EX/QU:GOTO 1730
1770 IF EX*QU*E<>0 THEN 1020
1780 RETURN
1790 :REM'
1800 :REM'.....DC resistance
1810 PRINT " DC RESISTANCE of a COPPER WIRE COIL"
1820 PRINT UL$;:COLOR 0,7
1830 PRINT " Do you want to enter data in (m)illimetres or (i)nches?";
1840 PRINT " (Press m or i) "
1850 COLOR 7,0
1860 I$=INKEY$:IF I$=""THEN 1860
1870 IF I$="m"THEN UM=1   :I$="mm.":GOTO 1900
1880 IF I$="i"THEN UM=25.399999618530273!:I$="in.":GOTO 1900
1890 GOTO 1860
1900 LN=5:GOSUB 530
1910 IF N THEN 1940
1920 INPUT " ENTER: Number of turns..................";N
1930 IF N*A*D THEN 2030
1940 IF A THEN 1970
1950 PRINT " ENTER: Wire diameter...............("I$")";:INPUT A:A=A/2*UM
1960 IF N*A*D THEN 2030
1970 IF D THEN 2000
1980 PRINT " ENTER: Coil diameter...............("I$")";:INPUT D:D=D*UM
1990 IF N*A*D THEN 2030
2000 IF D THEN 1900
2010 GOTO 1900
2020 :REM'
2030 L=PI*D*N  :REM'length in mm
2040 OHM=L/10^3/(PI*A^2*58)
2050 LN=5:GOSUB 530
2060 PRINT USING " Number of turns.... ####.#  ";N
2070 PRINT USING " Wire diameter...... ####.## mm = ###.### in.";2*A,2*A/25.399999618530273!
2080 PRINT USING " Coil diameter...... ####.## mm = ###.### in.";D,D/25.399999618530273!
2090 PRINT USING " Length of wire..... ####.## cm = ###.### in.";L/10,L/25.399999618530273!
2100 PRINT USING " DC resistance...... ####.### Ω";OHM
2110 GOSUB 2380:GOTO 110
2120 :REM'
2130 :REM'.....series\parallel conversion
2140 RS=0:XS=0:Q=0:RP=0:XP=0
2150 CLS:KEY OFF
2160 PRINT" SERIES/PARALLEL CONVERSION"
2170 PRINT " "STRING$(32,205)
2180 PRINT  " (ref. QST January 2010, page 55)"
2190 PRINT
2200 LN=CSRLIN
2210 IF RS=0 THEN INPUT " ENTER: Rs (0 if unknown)";RS
2220 IF XS=0 THEN INPUT " ENTER: Xs (0 if unknown)";XS
2230 IF XS*RS THEN Q=XS/RS
2240 IF Q=0 THEN INPUT " ENTER: Q (0 if unknown)";Q
2250 IF Q*RS THEN RP=(1+Q^2)*RS:XS=Q*RS
2260 IF Q*XS THEN XP=(1+1/Q^2)*XS:RS=XS/Q
2270 IF Q*RP*XP THEN 2290
2280 GOTO 2210
2290 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
2300 PRINT
2310 PRINT USING " Rs= ####.### Ω";RS
2320 PRINT USING " Xs= ####.### Ω";XS
2330 PRINT
2340 PRINT USING " RP= ######.## Ω";RP
2350 PRINT USING " XP= ######.## Ω";XP
2360 PRINT USING " Q = ######.##";Q
2370 GOSUB 2640:GOTO 100
2380 :REM'
2390 :REM'.....parallel\series conversion
2400 RP=0:XP=0:Q=0:RP=0:XP=0
2410 CLS:KEY OFF
2420 PRINT" PARALLEL\SERIES CONVERSION"
2430 PRINT " "STRING$(32,205)
2440 PRINT  " (ref. QST January 2010, page 55)"
2450 PRINT
2460 LN=CSRLIN
2470 IF RP=0 THEN INPUT " ENTER: Rp (0 if unknown)";RP
2480 IF XP=0 THEN INPUT " ENTER: Xp (0 if unknown)";XP
2490 IF XP*RP THEN Q=RP/XP
2500 IF Q=0 THEN INPUT " ENTER: Q (0 if unknown)";Q
2510 IF Q*RP THEN RS=RP/(1+Q^2):XP=RP/Q :XS=Q*RS :GOTO 2530
2520 IF Q*XP THEN XS=XP/(1+1/Q^2):RP=Q*XP :RS=XS/Q
2530 IF Q*RP*XP THEN 2550
2540 GOTO 2470
2550 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
2560 PRINT
2570 PRINT USING " Rp= #######.## Ω";RP
2580 PRINT USING " Xp= #######.## Ω";XP
2590 PRINT
2600 PRINT USING " Rs= ####.### Ω";RS
2610 PRINT USING " Xs= ####.### Ω";XS
2620 PRINT USING " Q = ####.###";Q
2630 :REM'
2640 :REM'.....end
2650 GOSUB 2660:GOTO 10
2655 :REM'
2660 :REM'.....PRT
2670 KEY OFF:GOSUB 2740:LOCATE 25,5:COLOR 0,2
2680 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2690 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2700 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2700 :ELSE GOSUB 2740
2710 IF Z$="3"THEN RETURN
2720 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2730 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2670
2740 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
