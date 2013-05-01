10 :REM'WAVETRAP - Wave Trap Filters - 24 FEB 96 rev. 22 NOV 1998
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="wavetrap"
40 COMMON EX$,PROG$,UH,FQ
50 CLS:KEY OFF
60 COLOR 7,0,1
70 U$="#####.###"
80 UL$=STRING$(80,205)
90 PI=3.1415929794311523!
100 DIM J$(13,2)
110 :REM'
120 DATA 2m,144,6m,50,10m,28,12m,24.89,15m,21,17m,18.063,20m,14
130 DATA 30m,10.1,40m,7,80m,3.5,160m,1.8,B'cast,1,B'cast,.55
140 FOR Z=1 TO 13:READ J$(Z,1),J$(Z,2):NEXT Z
150 GOTO 220
160 :REM'
170 :REM'.....format input line
180 LOCATE CSRLIN-1:PRINT SPC(7);
190 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;ZZ;
200 RETURN
210 :REM'
220 :REM'.....start
230 CLS
240 COLOR 15,2
250 PRINT " WAVE TRAP FILTERS";TAB(57)"by George Murphy VE3ERP ";
260 COLOR 1,0:PRINT STRING$(80,223);
270 COLOR 7,0
280 R=3:C=26:GOSUB 1320    :REM'diagram
290 PRINT
300 GOSUB 1450            :REM'preface
310 COLOR 0,7
320 LOCATE 25,22:PRINT " Press 1 to continue or 0 to quit....";
330 COLOR 7,0
340 Z$=INKEY$:IF Z$=""THEN 340
350 IF Z$="0"THEN CLS:RUN EX$
360 IF Z$="1"THEN 390
370 GOTO 340
380 :REM'
390 :REM'.....inputs
400 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
410 INPUT " ENTER: Trap frequency..........................(MHz)";F
420 FQ=F  :REM'for chaining to coil designer program
430 X=250      :REM'default reactance value
440 :REM'
450 :REM'.....calculate and screen print
460 LOCATE 3
470 U=X/(2*PI*F)
480 C=10^6/(2*PI*F*X)
490 C1=INT(C*1.100000023841858!)    :REM'variable capacitor
500 :REM'
510 PRINT "        Trap frequency...............................";USING U$;F;
520 PRINT " MHz"
530 PRINT "        Inductor L1..................................";USING U$;U;
540 PRINT " µH"
550 :REM'
560 PRINT "        Capacitance C1...............................";USING U$;C;
570 PRINT " pF"
580 :REM'
590 IF FLAG=1 THEN PRINT STRING$(80,32);:GOTO 630
600 PRINT "        Recommended variable capacitor...............";
610 PRINT USING "#####";C1;:PRINT " pF or more"
620 :REM'
630 PRINT "        Reactance....................................";USING U$;X;
640 PRINT " Ω"
650 :REM'
660 LN=CSRLIN:COLOR 0,7
670 IF REAC=1 THEN 700
680 PRINT " A reactance of from 300Ω to 450Ω is recommended for antenna traps."
690 REAC=1
700 PRINT " Do you want to re-calculate using another reactance value?  (y/n) "
710 COLOR 7,0
720 Z$=INKEY$:IF Z$=""THEN 720
730 IF Z$="n"THEN 810
740 IF Z$="y"THEN FLAG=0:GOTO 770
750 GOTO 720
760 :REM'
770 INPUT " ENTER: Reactance..............................(ohms)";X
780 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
790 GOTO 450
800 :REM'
810 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
820 COLOR 0,7
830 IF FLAG=1 THEN 850
840 PRINT " Do you want to use a standard fixed capacitor?  (y/n) ":GOTO 860
850 PRINT " Do you want to try a different fixed capacitor?  (y/n) ":GOTO 860
860 COLOR 7,0
870 Z$=INKEY$:IF Z$=""THEN 870
880 IF Z$="n"THEN 1000
890 IF Z$="y"THEN FLAG=1:GOTO 910
900 GOTO 720
910 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
920 COLOR 0,7
930 INPUT " ENTER: Value of standard capacitor, in pF....";C
940 COLOR 7,0
950 U=25330.2890625!/F^2/C
960 X=U*2*PI*F
970 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
980 GOTO 510
990 :REM'
1000 FLAG=0:REAC=0
1010 LOCATE CSRLIN-1:PRINT UL$;
1020 PRINT " Values for some other traps with a resonant reactance of";
1030 COLOR 0,7:PRINT USING "#####.### Ω ";X:COLOR 7,0
1040 PRINT TAB(4)"BAND";TAB(14)"FREQENCY";TAB(29)"L1";TAB(41)"C1"
1050 PRINT UL$;
1060 :REM'
1070    FOR Z=1 TO 13
1080 A$=J$(Z,1)
1090 IF LEN(A$)<7 THEN A$=" "+A$:GOTO 1090
1100 PRINT A$;
1110 F=VAL(J$(Z,2))
1120 U=X/(2*PI*F)
1130 C=10^6/(2*PI*F*X)
1140 PRINT TAB(10)USING "#####.###";F;
1150 PRINT " MHz";TAB(23)USING "#####.##";U;
1160 PRINT " µH";TAB(36)USING "#####.#";C;
1170 PRINT " pF";:IF Z<13 THEN PRINT ""
1180    NEXT Z
1190 GOSUB 1780
1200 COLOR 15,1:LOCATE 8,16
1210 PRINT " Want to design an air-core coil for L1?   (y/n) ";:COLOR 7,0
1220 Z$=INKEY$:IF Z$=""THEN 1220
1230 IF Z$="n"THEN 220
1240 IF Z$="y"THEN 1270
1250 GOTO 1220
1260 :REM'
1270 LOCATE 11,26
1280 COLOR 15,1:INPUT " ENTER: value of L1 (µH) ";UH
1290 COLOR 7,0:CLS:CHAIN"coildsgn"
1300 END
1310 :REM'
1320 :REM'.....diagram
1330 COLOR 0,7:LOCATE R
1340 LOCATE ,C: PRINT "                ▌            "
1350 LOCATE ,C: PRINT " ───┬──L1──┬─── ▌─────┬───── "
1360 LOCATE ,C: PRINT "    │      │    ▌     L1     "
1370 LOCATE ,C: PRINT "    └──C1──┘    ▌     │      "
1380 LOCATE ,C: PRINT "                ▌     C1     "
1390 LOCATE ,C: PRINT " ─grnd───────── ▌─grnd┴───── "
1400 LOCATE ,C: PRINT "                ▌            "
1410 LOCATE ,C: PRINT " Parallel-Tuned ▌Series-Tuned"
1420 COLOR 7,0
1430 RETURN
1440 :REM'
1450 :REM'.....preface
1460 C=7
1470 PRINT TAB(C);
1480 PRINT "  Wave traps can effectively eliminate many kinds of interference."
1490 PRINT TAB(C);
1500 PRINT "Filters of this variety are useful in trapping amateur signals at"
1510 PRINT TAB(C);
1520 PRINT "the input of TV front ends, FM tuners, and AM radios. Traps in the"
1530 PRINT TAB(C);
1540 PRINT "feeders of amateur antennas can reject commercial broadcast station"
1550 PRINT TAB(C);
1560 PRINT "signals which might otherwise overload amateur receivers."
1570 PRINT TAB(C);
1580 PRINT "  This program designs traps with a resonant reactance of 250 Ω,"
1590 PRINT TAB(C);
1600 PRINT "which can be changed if, for instance, you are designing traps for"
1610 PRINT TAB(C);
1620 PRINT "a multi-band antenna where reactances of from about 300 to 450 Ω"
1630 PRINT TAB(C);
1640 PRINT "are suitable (Q decreases and bandwidth increases with reactance)."
1650 PRINT TAB(C);
1660 PRINT "C1 can be variable to allow for fine tuning."
1670 PRINT TAB(C);
1680 PRINT "  For more details see THE ARRL ELECTRONICS DATA BOOK, 2nd Edition,"
1690 PRINT TAB(C);
1700 PRINT "pp. 5-12 and 7-12.";
1710 RETURN
1720 :REM'
1730 :REM'.....end
1740 GOSUB 1780
1750 GOTO 220
1760 END
1770 :REM'
1780 :REM'.....PRT
1790 KEY OFF:GOSUB 1860:LOCATE 25,5:COLOR 0,2
1800 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1810 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1820 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1820 :ELSE GOSUB 1860
1830 IF Z$="3"THEN RETURN
1840 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1850 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1790
1860 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
