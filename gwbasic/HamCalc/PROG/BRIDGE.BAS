10 :REM'BRIDGE - Wheatstone Bridge Calculator - 08 AUG 95  rev. 20 SEP 2010
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=" "THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 U$="######,###"
80 V$="######,###.###"
90 UL$=STRING$(80,205)
100 GOTO 230
110 :REM'
120 :REM'.....abbreviate resistor input line
130 LOCATE CSRLIN-1:PRINT SPC(7);
140 X=Z:X$=" Ω      "
150 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;X;:PRINT X$
160 RETURN
170 :REM'
180 :REM'.....format input line
190 LOCATE CSRLIN-1:PRINT SPC(7);
200 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;Z;
210 RETURN
220 :REM'
230 :REM'.....start......
240 COLOR 15,2
250 PRINT " BRIDGE (Wheatstone) CALCULATOR";TAB(57);"by George Murphy VE3ERP ";
260 COLOR 1,0:PRINT STRING$(80,223);
270 COLOR 7,0
280 PRINT " Press number in < > to"
290 PRINT UL$;
300 PRINT "   < 1 > Run resistive bridge calculator"
310 PRINT
320 PRINT "   < 2 > Calculate sensitivity of a resistive bridge"
330 PRINT "         (ref: Electronics Instrumentation And Measurement"
340 PRINT "               David A. Bell, Reston Publishing Co., pp.136,137)"
350 PRINT
360 PRINT "   < 0 > EXIT"
370 Z$=INKEY$:IF Z$=""THEN 370
380 IF Z$="1"THEN CHAIN"wheatsto"
390 IF Z$="2"THEN 1050
400 IF Z$="0"THEN RUN GO$
410 GOTO 380
420 :REM'
430 :REM'.....analysis
440 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
450 :REM'.....diagram
460 T=30
470 COLOR 0,7
480 LOCATE ,T:PRINT "                     "
490 LOCATE ,T:PRINT "          V+         "
500 LOCATE ,T:PRINT "     R1   │   R2     "
510 LOCATE ,T:PRINT "  ┌─/\/\/─┴─/\/\/─┐  "
520 LOCATE ,T:PRINT "  │      R5       │  "
530 LOCATE ,T:PRINT "  ├─────/\/\/─────┤  "
540 LOCATE ,T:PRINT "  │  R3       R4  │  "
550 LOCATE ,T:PRINT "  └─/\/\/─┬─/\/\/─┘  "
560 LOCATE ,T:PRINT "          │          "
570 LOCATE ,T:PRINT "          V-         "
580 LOCATE ,T:PRINT "                     "
590 COLOR 7,0
600 PRINT UL$;
610 COLOR 0,7:LOCATE CSRLIN,22
620 PRINT " Press 1 to continue or 0 to exit....."
630 COLOR 7,0
640 Z$=INKEY$:IF Z$=""THEN 640
650 IF Z$="0"THEN CLS:RUN EX$
660 IF Z$="1"THEN 670
670 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
680 :REM'
690 :REM'.....input data
700 INPUT " ENTER: Resistance R1..........................(ohms)";R1
710 Z=R1:GOSUB 120
720 INPUT " ENTER: Resistance R2..........................(ohms)";R2
730 Z=R2:GOSUB 120
740 INPUT " ENTER: Resistance R3..........................(ohms)";R3
750 Z=R3:GOSUB 120
760 INPUT " ENTER: Resistance R4..........................(ohms)";R4
770 Z=R4:GOSUB 120
780 INPUT " ENTER: Resistance R5..........................(ohms)";R5
790 Z=R5:GOSUB 120
800 INPUT " ENTER: Source Voltage V......................(volts)";VT
810 Z=VT:GOSUB 180:PRINT " volts"
820 :REM'
830 :REM'.....calculation
840 RTH=(R1*R3/(R1+R3))+(R2*R4/(R2+R4))
850 VTH=(R1*VT/(R1+R3))-(R2*VT/(R2+R4))
860 V5=R5*VTH/(R5+RTH)
870 I5=ABS(V5/R5)
880 IF I5>=1 THEN Y=I5:Y$=" amps"
890 IF I5<1 THEN Y=I5*10^3:Y$=" mA."
900 :REM'
910 PRINT "        Current through R5...........................";
920 PRINT USING V$;Y;:PRINT Y$
930 PRINT "        Voltage drop across R5.......................";
940 PRINT USING V$;ABS(V5);:PRINT " volts"
950 :REM'
960 IF V5=0 THEN 1430
970 IF V5<0 THEN A$=CHR$(174)+CHR$(174):ELSE A$=CHR$(175)+CHR$(175)
980 LOCATE 8,T+ 4:PRINT A$
990 LOCATE 8,T+15:PRINT A$
1000 LOCATE 13,15
1010 :REM'
1020 PRINT "Current thru R5 is in the direction of the ";A$;" arrows"
1030 GOTO 1430
1040 :REM'
1050 :REM'.....sensitvity
1060 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1070 GOSUB 1280
1080 PRINT
1090 INPUT " ENTER: Resistance P (kΩ)...................";Z:GOSUB 1240:P=Z
1100 INPUT " ENTER: Resistance Q (kΩ)...................";Z:GOSUB 1240:Q=Z
1110 INPUT " ENTER: Resistance R (kΩ)...................";Z:GOSUB 1240:R=Z
1120 INPUT " ENTER: Resistance S (kΩ)...................";Z:GOSUB 1240:S=Z
1130 INPUT " ENTER: Supply Eb (volts)...................";Z:GOSUB 1240:EB=Z
1140 INPUT " ENTER: Meter sensitivity (µA/mm)...........";Z:GOSUB 1240:UA=Z
1150 INPUT " ENTER: Meter internal resistance Rg (kΩ)...";Z:GOSUB 1240:RG=Z
1160 RI=1/(1/P+1/R)+1/(1/Q+1/S) :REM'internal resistance
1170 PRINT USING "        Internal resistance r (kΩ).......... ###,###.###";RI
1180 VV=UA*(RI+RG) :REM'Vr-Vs
1190 PRINT USING "        Vr - Vs (mV)........................ ###,###.###";VV
1200 Y=VV/10^3/EB
1210 D=((R+P)*(Y+S/(Q+S))-R)*10^3  :REM'minimum change in kΩ
1220 PRINT USING "        Minimum detectable change in R...... ###,###.### Ω";D;
1230 GOTO 1430
1240 LOCATE CSRLIN-1:PRINT STRING$(8,32);
1250 LOCATE ,45:PRINT USING " ###,###.# ";Z
1260 RETURN
1270 :REM'
1280 COLOR 0,7:Z=12
1290 LOCATE ,Z:PRINT "        Resistance Bridge (Wheatstone) Sensitivity       "
1300 LOCATE ,Z:PRINT "   ┌─┬─────────┐  [G]= Galvanometer                      "
1310 LOCATE ,Z:PRINT "   │ │         │  ─o─= Galvanometer terminal     ──»Ig   "
1320 LOCATE ,Z:PRINT "   │ P ┌─[G]─┐ Q                         ┌───────o──┐    "
1330 LOCATE ,Z:PRINT "  Eb ├─o«┐+┌»o─┤    ┌─P─┐       ┌─Q─┐    r          Rg   "
1340 LOCATE ,Z:PRINT "   │ R  Vr Vs  S    │   ├o«─r─»o┤   │   +│          │    "
1350 LOCATE ,Z:PRINT "   │ │«──┘-└──»│    ├─R─┘       └─S─┤  Vr-Vs       [G]   "
1360 LOCATE ,Z:PRINT "   └─┴─────────┘    └───────────────┘   -└───────o──┘    "
1370 LOCATE ,Z:PRINT " Open cct.voltage  Internal resistance     Thevenin      "
1380 LOCATE ,Z:PRINT " @ meter is Vr-Vs     r=P║R + Q║S       Equivalent cct.  "
1390 LOCATE ,Z:PRINT "                                                         "
1400 COLOR 7,0
1410 RETURN
1420 :REM'
1430 :REM'.....end
1440 GOSUB 1470
1450 CLS:GOTO 230
1460 :REM'
1470 :REM'PRT
1480 KEY OFF:GOSUB 1550:LOCATE 25,5:COLOR 0,2
1490 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1500 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1510 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1510 :ELSE GOSUB 1550
1520 IF Z$="3"THEN RETURN
1530 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1540 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1480
1550 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
