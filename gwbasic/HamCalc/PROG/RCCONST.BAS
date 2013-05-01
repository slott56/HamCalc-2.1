10 :REM'RCCONST - 15 APR 92 rev.12 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 LB=2.7179999351501465!                               :REM'natural log base
80 U$="######,###.###"
90 U0$="######,###.#"
100 U1$="#,###.###"
110 U2$="#####,###.#"
120 U3$="#,###.#"
130 UL$=STRING$(80,205)
140 E$=STRING$(80,32)
150 T$=" RC CONSTANT"+STRING$(44,32)+"by George Murphy VE3ERP "
160 :REM'
170 :REM'.....start
180 VIEW PRINT:CLS:E#=0:R#=0:C#=0:T#=0
190 COLOR 15,2
200 PRINT T$;
210 COLOR 1,0:PRINT STRING$(80,223);
220 COLOR 7,0
230 GOTO 360
240 :REM'
250 :REM'.....schematic
260 COLOR 0,7
270 LOCATE Y+1,X:PRINT "       R        "
280 LOCATE Y+2,X:PRINT " E ──\/\/\──┬ V "
290 LOCATE Y+3,X:PRINT "            │   "
300 LOCATE Y+4,X:PRINT "          C═╪═  "
310 LOCATE Y+5,X:PRINT "            │   "
320 LOCATE Y+6,X:PRINT " - ─────────┴   "
330 COLOR 7,0
340 RETURN
350 :REM'
360 :REM'.....print schematic
370 X=33:Y=2:GOSUB 250
380 PRINT UL$;
390 PRINT
400 :REM'
410 :REM'.....print text
420 TB=8            :REM'tab for text
430 GOSUB 1720      :REM'text block
440 PRINT
450 PRINT UL$;
460 COLOR 0,7:LOCATE CSRLIN,22:PRINT " Press 1 to continue or 0 to EXIT....."
470 COLOR 7,0
480 Z$=INKEY$:IF Z$=""THEN 480
490 IF Z$="0"THEN CLS:CHAIN GO$
500 IF Z$="1"THEN 530
510 GOTO 480
520 :REM'
530 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
540 :REM'.....inputs
550 :REM'..E# = potential of charging source in volts
560 IF E#=0 THEN GOSUB 730
570 IF E#=0 THEN INPUT " ENTER: Input voltage...............E= ";E#:GOSUB 780
580 :REM'..R# = series resistance
590 IF R#=0 THEN GOSUB 730
600 IF R#=0 THEN INPUT " ENTER: Resistance in ohms..........R= ";R#:GOSUB 780
610 :REM'..C# = capacity in farads
620 IF C#=0 THEN GOSUB 730
630 IF C#=0 THEN INPUT " ENTER: Capacitance (µF)........... C= ";C
640 IF C#=0 AND C>0 THEN C#=C/1000000.0!:GOSUB 780
650 :REM'..T# = Time constant in seconds
660 IF T#=0 THEN GOSUB 730
670 IF T#=0 THEN INPUT " ENTER: Time constant in seconds...RC= ";T#:GOSUB 780
680 :REM'
690 IF R#>0 AND C#>0 AND E#>0 AND V#>0 AND T#>0 THEN 850  :REM'all data OK
700 VIEW PRINT 10 TO 24:CLS:VIEW PRINT:LOCATE 10
710 GOTO 530               :REM'go back for more data
720 :REM'
730 LOCATE CSRLIN+1
740 PRINT " (Press ENTER if unknown....)"
750 LOCATE CSRLIN-2
760 RETURN
770 :REM'
780 :REM'.....compile input data
790 IF T#=0 AND R#>0 AND C#>0 THEN T#=R#*C#:RETURN
800 IF R#=0 AND C#>0 AND T#>0 THEN R#=T#/C#:RETURN
810 IF C#=0 AND R#>0 AND T#>0 THEN C#=T#/R#:RETURN
820 IF V#=0 AND E#>0 THEN V#=E#*(1-LB^-1):RETURN
830 RETURN
840 :REM'
850 :REM'.....display
860 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
870 PRINT " Time constant.............. RC =";USING U$;T#;
880 PRINT " seconds"
890 PRINT " Input voltage............... E =";USING U0$;E#;
900 PRINT "   volts"
910 PRINT " Resistor.................... R =";USING U0$;R#;
920 PRINT "   ohms"
930 PRINT " Capacitor................... C =";USING U0$;C#*1000000.0!;
940 PRINT "   µF"
950 PRINT UL$;
960 :REM'....
970 N=4*T#/16            :REM'divide (3 x time constant) into 16 increments
980 SEC=0                :REM'start at zero seconds
990 FOR Z=1 TO 16
1000 IF Z=4 OR Z=8 OR Z=12 OR Z=16 THEN COLOR 0,7 :ELSE COLOR 7,0
1010   SEC=SEC+N            :REM'time in seconds after initiating charging current
1020   EMF=E#*(1-LB^(-SEC/T#))
1030   PRINT " EMF at V after ";USING U1$;SEC;
1040   PRINT " sec.  =";USING U0$;EMF;:PRINT " v.  ";
1050 IF Z=16 THEN PRINT " (";Z/4;"x RC )";:GOTO 1070
1060 IF Z=4 OR Z=8 OR Z=12 THEN PRINT " (";Z/4;"x RC )" :ELSE PRINT ""
1070 NEXT Z
1080 COLOR 7,0
1090 X=64:Y=7:GOSUB 250    :REM'print schematic
1100 GOSUB 1860
1110 :REM'
1120 :REM'.....substitution option
1130 LOCATE 25,1:PRINT E$;:LOCATE 25,1
1140 COLOR 0,7
1150 PRINT " Do you want to substitute other values for R or C?    (y/n) ";
1160 COLOR 7,0
1170 Z$=INKEY$
1180 IF Z$="y"OR Z$="Y"THEN 1220
1190 IF Z$="n"OR Z$="N"THEN 1320
1200 GOTO 1170
1210 :REM'
1220 :REM'.....substitute R or C
1230 COLOR 15,6
1240 LOCATE 25,1
1250 PRINT " Which component do you want to change, R or C?        (r/c) ";
1260 COLOR 7,0
1270 Z$=INKEY$
1280 IF Z$="R"OR Z$="r"THEN R#=0:T#=0:GOTO 530
1290 IF Z$="C"OR Z$="c"THEN C#=0:T#=0:GOTO 530
1300 GOTO 1270
1310 :REM'
1320 :REM'.....display discharge option
1330 COLOR 15,6
1340 LOCATE 25,1
1350 PRINT " Do you want to display a Discharge Rate table?        (y/n) ";
1360 COLOR 7,0
1370 Z$=INKEY$
1380 IF Z$="n"OR Z$="N"THEN 170
1390 IF Z$="y"OR Z$="Y"THEN 1420
1400 GOTO 1370
1410 :REM'
1420 :REM'.....display discharge times
1430 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1440 PRINT " Discharge rate of a  ";:PRINT USING U2$;C#*1000000.0!;
1450 PRINT " µF capacitor"
1460 PRINT " with a full charge of";:PRINT USING U2$;E#;
1470 PRINT " volts"
1480 PRINT " discharging through a";:PRINT USING U2$;R#;
1490 PRINT " Ω resistor:";
1500 PRINT TAB(49);"Time Constant RC =";USING U1$;T#;:PRINT " sec.";
1510 PRINT UL$;
1520 SEC=0                :REM'start at zero seconds
1530 PRINT " Capacitor EMF at start";TAB(37);"=";USING U3$;E#;:PRINT " v."
1540 FOR Z=1 TO 16
1550  IF Z=4 OR Z=8 OR Z=12 OR Z=16 THEN COLOR 0,7 :ELSE COLOR 7,0
1560  SEC=SEC+N            :REM'time in seconds after initiating charging current
1570  V=E#*(LB^(-SEC/T#))                   :REM'EMF of capacitor
1580  MA=V/R#*1000                          :REM'current in mA
1590  V$="#####.###"
1600  IF MA>0.009999999776482582! THEN V$="#####.##"
1610  IF MA>0.10000000149011612! THEN V$="#####.#"
1620  IF MA>1 THEN V$="#####"
1630  PRINT " Discharge rate after ";USING U3$;SEC;
1640  PRINT " sec.  =";USING U3$;V;:PRINT " v.@";USING V$;MA;:PRINT " mA.";
1650  IF Z=16 THEN PRINT " (";Z/4;"x RC )";:GOTO 1670
1660  IF Z=4 OR Z=8 OR Z=12 THEN PRINT " (";Z/4;"x RC )" :ELSE PRINT ""
1670 NEXT Z
1680 COLOR 7,0
1690 GOSUB 1860
1700 GOTO 170   :REM'start
1710 :REM'
1720 :REM'.....text block
1730 PRINT TAB(TB);
1740 PRINT "The product of R in ohms times C in farads is called the Time"
1750 PRINT TAB(TB);
1760 PRINT "Constant of the circuit and is the time in seconds required to"
1770 PRINT TAB(TB);
1780 PRINT "charge the capacitor C to 63.2% of the supply voltage E."
1790 PRINT
1800 PRINT TAB(TB);
1810 PRINT "If a charged capacitor is discharged through a resistor the same"
1820 PRINT TAB(TB);
1830 PRINT "time constant applies for the decay of the capacitor voltage V."
1840 RETURN
1850 :REM'
1860 :REM'PRT
1870 KEY OFF:GOSUB 1940:LOCATE 25,5:COLOR 0,2
1880 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1890 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1900 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1900 :ELSE GOSUB 1940
1910 IF Z$="3"THEN RETURN
1920 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1930 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1870
1940 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
