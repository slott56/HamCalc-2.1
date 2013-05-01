10 :REM'BOBTAIL - Vertical Antenna Array - 28 JUL 96 rev. 08 JUL 07
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,0
50 UL$=STRING$(80,205)
60 U$="####.###"
70 PI=3.1415929794311523!
80 JJ=1/(4*PI^2)*10^6
90 :REM'
100 COLOR 15,2
110 PRINT " BOBTAIL CURTAIN VERTICAL ANTENNA ARRAY";
120 PRINT TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 :REM'
160 :REM'.....start
170 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
180 GOSUB 1030     :REM'diagram
190 PRINT UL$;
200 :REM'
210 LOCATE 23,24:COLOR 0,7
220 PRINT " Press 1 to continue or 0 to EXIT ";
230 COLOR 7,0
240 Z$=INKEY$:IF Z$=""THEN 240
250 IF Z$="0"THEN CLS:RUN EX$
260 IF Z$="1"THEN 290
270 GOTO 240
280 :REM'
290 :REM'.....data input
300 VIEW PRINT 14 TO 24:CLS:VIEW PRINT:LOCATE 14
310 INPUT " ENTER: Centre frequency (MHz) of band of interest....";F
320 A=473/F           :REM'feet
330 B=225/F           :REM'feet
340 COLOR 0,7
350 PRINT "  The L/C ratio of the matching network should be fairly low to ";
360 PRINT "provide good    ";
370 PRINT "  loading characteristics. Start with a reactance of 450 ohms. If ";
380 PRINT "calculated    ";
390 PRINT "  values of C1 or L1 are unsuitable choose another ";
400 PRINT "reactance, preferably lower. ";
410 COLOR 7,0
420 INPUT " ENTER: Reactance XC=XL (ohms) =......................";X
430 C=10^6/(2*PI*F*X)    :REM'initial capacitor value
440 :REM'
450 COLOR 0,7
460 PRINT " Select a variable capacitor with a maximum value greater than";
470 PRINT INT(C)+1;"pF for C1:"
480 COLOR 7,0
490 INPUT " ENTER: Maximum capacitance of C1 (pF)................";C1
500 VIEW PRINT 14 TO 24:CLS:VIEW PRINT:LOCATE 14
510 PRINT " Frequency of interest.......................";USING U$;F;
520 PRINT " MHz"
530 PRINT " Length of each of 2 phasing lines A.........";USING U$;A;
540 PRINT " ft. (";USING U$;A*0.30480000376701355!;:PRINT " m.)"
550 PRINT " Length of each of 3 vertical radiators B....";USING U$;B;
560 PRINT " ft. (";USING U$;B*0.30480000376701355!;:PRINT " m.)"
570 PRINT " Max. capacitance of variable capacitor C1...";USING U$;C1;
580 PRINT " pF"
590 CMAX=C1               :REM'maximum capacitance
600 CMID=10^6/(2*PI*F*X)  :REM'mid capacitance
610 CMIN=C1*0.10000000149011612!            :REM'minimum capacitance
620 IF CMID<C1 THEN 670
630  BEEP:COLOR 0,7:PRINT " CAPACITOR MUST BE LARGER THAN";INT(CMID)+1;"pF "
640 COLOR 7,0:PRINT " Press any key to start over..."
650 IF INKEY$=""THEN 650
660 GOTO 100
670 L=JJ/F^2/CMID
680 PRINT " Inductor L1.................................";
690 COLOR 0,7:PRINT USING U$;L;:COLOR 7,0:PRINT " µH"
700 PRINT " With C1 set at...............";
710 LOCATE ,28:PRINT USING U$;CMIN;:PRINT " pF(10%)";
720 P$=STR$(INT(CMID/CMAX*100)):P$=RIGHT$(P$,LEN(P$)-1)
730 COLOR 0,7:LOCATE ,46:PRINT USING U$;CMID;:COLOR 7,0:PRINT " pF(";P$;"%)";
740 LOCATE ,64:PRINT USING U$;CMAX;:PRINT " pF(100%)";
750 FMAX=SQR(JJ/CMIN/L)
760 FMID=SQR(JJ/CMID/L)
770 FMIN=SQR(JJ/CMAX/L)
780 PRINT "  Resonant frequency is....";
790 LOCATE ,28:PRINT USING U$;FMAX;:PRINT " MHz";
800 COLOR 0,7:LOCATE ,46:PRINT USING U$;FMID;:COLOR 7,0:PRINT " MHz";
810 LOCATE ,64:PRINT USING U$;FMIN;:PRINT " MHz";
820 X1=2*PI*FMAX*L
830 X2=2*PI*FMID*L
840 X3=2*PI*FMIN*L
850 PRINT "  Reactances XC & XL are...";
860 LOCATE ,28:PRINT USING U$;X1;:PRINT " ohms";
870 COLOR 0,7:LOCATE ,46:PRINT USING U$;X2;:COLOR 7,0:PRINT " ohms";
880 LOCATE ,64:PRINT USING U$;X3;:PRINT " ohms"
890 PRINT UL$;
900 PRINT " Adjust C1 for resonance; adjust tap";
910 PRINT " on L1 for minimum SWR; re-adjust C1."
920 PRINT " The height for the horizontal portion should be slightly greater ";
930 PRINT "than B.";
940 GOSUB 1180
950 COLOR 0,7:LOCATE 25,13
960 PRINT " Do you want to try other values for L1 and C1?   (y/n) ";
970 COLOR 7,0
980 Z$=INKEY$:IF Z$=""THEN 980
990 IF Z$="n"THEN 160
1000 IF Z$="y"THEN VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE 17:GOTO 340
1010 GOTO 980
1020 :REM'
1030 :REM'.....diagram
1040 T=12:COLOR 0,7
1050 LOCATE ,T:PRINT "  ┌─────────── A ───────────┬─────────── A ───────────┐  "
1060 LOCATE ,T:PRINT "  │«─ 3 vertical radiators─»│─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ »│  "
1070 LOCATE ,T:PRINT "  │                         │                         │  "
1080 LOCATE ,T:PRINT "  B                         B                         B  "
1090 LOCATE ,T:PRINT "  │          tap ─»┌───┐ L1 │                         │  "
1100 LOCATE ,T:PRINT "  │                │ ┌∩∩∩∩∩┐│   ┌ matching network    │  "
1110 LOCATE ,T:PRINT "  │ 50Ω coax ─» ══╤╝ │     ├┘ «─┤ located at base of  │  "
1120 LOCATE ,T:PRINT "    feed line     ├──┴──╫──┘    └ vertical element       "
1130 LOCATE ,T:PRINT "                  │     C1 (variable)                    "
1140 LOCATE ,T:PRINT "                \\┴\\ «─ earth ground                    "
1150 COLOR 7,0
1160 RETURN
1170 :REM'
1180 :REM'PRT
1190 KEY OFF:GOSUB 1260:LOCATE 25,5:COLOR 0,2
1200 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1210 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1220 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1220 :ELSE GOSUB 1260
1230 IF Z$="3"THEN RETURN
1240 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1250 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1190
1260 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
