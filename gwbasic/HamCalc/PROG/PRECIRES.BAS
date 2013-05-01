10 :REM'PRECIRES - Precision Resistor - 07 SEP 94 rev. 23 NOV 2000
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON PROG$,EX$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 DIM R(25)            :REM'resistors
80 UL$=STRING$(80,205)  :REM'underline
90 ER$=STRING$(80,32)   :REM'erase
100 U1$="########,##.#"
110 U2$="#########.###"
120 U3$="#########.##"+" "
130 U4$="#######,###"+"  "
140 U5$="####.#"
150 O$=" Ω"
160 VIEW PRINT 3 TO 23:CLS:VIEW PRINT
170 DATA 10,11,12,13,15,16,18,20,22,24,27,30,33,36,39
180 DATA 43,47,51,56,62,68,75,82,91,100
190 FOR Z=0 TO 24:READ R(Z):NEXT Z
200 :REM'
210 :REM'.....start
220 CLS
230 COLOR 15,2
240 PRINT " PRECISION RESISTOR";TAB(57);"by George Murphy VE3ERP ";
250 COLOR 1,0:PRINT STRING$(80,"▀");
260 COLOR 7,0
270 :REM'
280 :REM'.....diagram
290 T=24       :REM'tab
300 COLOR 0,7
310 LOCATE  3,T:PRINT "                                   "
320 LOCATE  4,T:PRINT "  │«─────────── R ─────────────»│  "
330 LOCATE  5,T:PRINT "  │                             │  "
340 LOCATE  6,T:PRINT "  │    ┌──────/\/\/\/──────┐    │  "
350 LOCATE  7,T:PRINT "       │        Ra         │       "
360 LOCATE  8,T:PRINT "  X────┤                   ├────Y  "
370 LOCATE  9,T:PRINT "       │                   │       "
380 LOCATE 10,T:PRINT "       └──────/\/\/\/──────┘       "
390 LOCATE 11,T:PRINT "                Rb                 "
400 COLOR 7,0
410 LOCATE 12:PRINT UL$;
420 IF R THEN 660
430 :REM'
440 M=7
450 PRINT TAB(M);
460 PRINT "This program calculates the values of two standard value resistors"
470 PRINT TAB(M);
480 PRINT "Ra and Rb which, when connected in parallel, will result in a net"
490 PRINT TAB(M);
500 PRINT "resistance R that will be within very close tolerances of almost any"
510 PRINT TAB(M);
520 PRINT "value you want."
530 PRINT UL$;
540 :REM'
550 :REM'.....inputs
560 COLOR 0,7:LOCATE CSRLIN,22
570 PRINT " Press 1 to continue or 0 to EXIT.....":COLOR 7,0
580 Z$=INKEY$:IF Z$=""THEN 580
590 IF Z$="0"THEN CLS:CHAIN GO$
600 IF Z$="1"THEN 630
610 GOTO 580
620 :REM'
630 VIEW PRINT 13 TO 24:CLS:VIEW PRINT:LOCATE 13
640 PRINT " ENTER:";
650 :REM'
660 LOCATE CSRLIN,8
670 COLOR 14,4
680 PRINT " Sought precise resistance R between X & Y ......(ohms)=";
690 COLOR 7,0
700 IF R THEN PRINT:GOTO 720 :ELSE INPUT R  :REM'if R chained from another program
710 IF R=0 THEN LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:GOTO 550
720 IF R<10 THEN 970
730 LOCATE CSRLIN-1:PRINT STRING$(7,32)
740 LOCATE CSRLIN-1,55:COLOR 14,4:PRINT "......R ="
750 LOCATE CSRLIN-1,64:PRINT USING U1$;R;:PRINT O$:COLOR 7,0
760 :REM'
770 :REM'.....find next larger standard resistor
780 M=0.10000000149011612!                   :REM'multiplier
790 :REM'
800 FOR Z=1 TO 24
810  RA=R(Z)*M             :REM'Ra= standard resistor
820  IF RA=R THEN 880
830  IF RA>=R THEN 1060    :REM'exit for/next loop
840 NEXT Z
850 M=M*10
860 GOTO 800               :REM'run loop again
870 :REM'
880 :REM'.....standard resistor entered
890 BEEP:PRINT
900 COLOR 0,7
910 LOCATE CSRLIN,17:PRINT " ...... This is a standard resistor value ...... "
920 LOCATE CSRLIN,17:PRINT " ................ Press any key ................ "
930 COLOR 7,0
940 IF INKEY$=""THEN 940
950 GOTO 2150   :REM'end
960 :REM'
970 :REM'.....resistor <10 ohms entered
980 BEEP:PRINT :COLOR 0,7
990 PRINT " For precision resistors less than 10 Ω refer to the "
1000 PRINT " HAMCALC program RESISTORS - COPPER WIRE WOUND.      "
1010 PRINT " .................. Press any key .................. "
1020 COLOR 7,0
1030 IF INKEY$=""THEN 1030
1040 GOTO 2150  :REM'start
1050 :REM'
1060 PRINT "        Value of next standard resistor greater than R.....Ra =";
1070 PRINT USING U4$;RA;:PRINT O$
1080 :REM'
1090 RX=R*RA/(RA-R)         :REM'parallel resistor
1100 :REM'
1110 :REM'.....find nearest standard resistor
1120 M=1                    :REM'multiplier
1130 :REM'
1140 FOR Z=1 TO 24
1150  RH=R(Z)*M             :REM'RS= next higher standard resistor
1160  IF RH>=RX THEN 1210
1170 NEXT Z
1180 M=M*10
1190 GOTO 1140               :REM'run loop again
1200 :REM'
1210 RL=R(Z-1)*M            :REM'next lower standard resistor
1220 RM=(RL+RH)/2           :REM'median value
1230 IF RX<RM THEN RB=RL
1240 IF RX>=RM THEN RB=RH
1250 :REM'
1260 :REM'.....display results
1270 PRINT "        Value of parallel resistor to obtain R precisely..... =";
1280 PRINT USING U1$;RX;:PRINT O$
1290 :REM'
1300 PRINT "        Value of closest standard parallel resistor........Rb =";
1310 PRINT USING U4$;RB;:PRINT O$
1320 :REM'
1330 RC=1/(1/RA+1/RB)
1340 PRINT "       ";
1350 COLOR 15,0
1360 PRINT " RESISTANCE OF Ra & Rb IN PARALLEL BETWEEN X & Y....Rc =";
1370 PRINT USING U1$;RC;:PRINT O$
1380 COLOR 7,0
1390 :REM'
1400 D=ABS(R-RC)/R*100
1410 COLOR 14,4:LOCATE CSRLIN,8
1420 PRINT " DIVERGENCE of Rc from R.............................. =";
1430 PRINT USING U2$;D;:PRINT " %"
1440 COLOR 7,0
1450 :REM'
1460 IF E=-1 THEN 1800                :REM'if E chained from another program
1470 IF E<>0 THEN PRINT :GOTO 1590    :REM'if E chained from another program
1480 COLOR 15,1:LOCATE CSRLIN,8
1490 PRINT " Do you want to calculate current through Ra & Rb ?  (y/n) ";
1500 COLOR 7,0
1510 Z$=INKEY$
1520 IF Z$="n"OR Z$="N"THEN 1560
1530 IF Z$="y"OR Z$="Y"THEN 1590
1540 GOTO 1510
1550 :REM'
1560 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:PRINT UL$;:GOSUB 1880
1570 GOTO 2150   :REM'end
1580 :REM'
1590 :REM'.....calculate current
1600 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
1610 PRINT " ENTER: Voltage drop between X & Y..........................E =";
1620 IF E THEN PRINT :GOTO 1630 :ELSE INPUT E
1630 LOCATE CSRLIN-1:PRINT STRING$(7,32)
1640 LOCATE CSRLIN-1,64:PRINT USING U2$;E;:PRINT " v."
1650 :REM'
1660 I=E/RA:GOSUB 1830
1670 PRINT "        Current through Ra @............................I(Ra) =";
1680 PRINT USING U2$;II;:PRINT V$
1690 P=I*E:LOCATE CSRLIN-1,29:PRINT USING"#####.###";P;:PRINT " watts"
1700 :REM'
1710 I=E/RB:GOSUB 1830
1720 PRINT "        Current through Rb @............................I(Rb) =";
1730 PRINT USING U2$;II;:PRINT V$
1740 P=I*E:LOCATE CSRLIN-1,29:PRINT USING"#####.###";P;:PRINT " watts"
1750 :REM'
1760 I=E/RC:GOSUB 1830
1770 PRINT "        Total current between X and Y...................I(Rc) =";
1780 PRINT USING U3$;II;:PRINT V$
1790 :REM'
1800 PRINT UL$;:GOSUB 1880
1810 GOTO 2150   :REM'end
1820 :REM'
1830 :REM'.....unit of current
1840 IF I>=1 THEN II=I:V$=" A."
1850 IF I<1 THEN II=I*10^3:V$=" mA"
1860 RETURN
1870 :REM'
1880 :REM'.....add to diagram
1890 :REM'
1900 N=1
1910 IF 10^N<=R THEN N=N+1:GOTO 1910
1920 COLOR 7,0
1930 X1=RA:X1$=" Ω"
1940 IF RA>10^3 THEN X1=RA/10^3:X1$=" kΩ"
1950 IF RA>10^6 THEN X1=RA/10^6:X1$=" megΩ"
1960 :REM'
1970 X2=RB:X2$=" Ω"
1980 IF RB>10^3 THEN X2=RB/10^3:X2$=" kΩ"
1990 IF RB>10^6 THEN X2=RB/10^6:X2$=" megΩ"
2000 :REM'
2010 X3=RC:X3$="Ω"
2020 IF RC>10^3 THEN X3=RC/10^3:X3$="kΩ"
2030 IF RC>10^6 THEN X3=RC/10^6:X3$="megΩ"
2040 X3=INT(X3*10^3+0.5!)/10^3
2050 N=1
2060 IF 10^N<X3 THEN N=N+1:GOTO 2060
2070 UX$=STRING$(N,"#")+".###"
2080 :REM'
2090 COLOR 14,4
2100 LOCATE 4,T+10:PRINT " Rc= ";USING UX$;X3;:PRINT " ";X3$
2110 LOCATE 7,T+10:PRINT " Ra=";USING U5$;X1;:PRINT X1$
2120 LOCATE 11,T+10:PRINT " Rb=";USING U5$;X2;:PRINT X2$
2130 COLOR 7,0
2140 :REM'
2150 :REM'.....end
2160 GOSUB 2220
2170 IF EX$<>GO$ THEN CLS:CHAIN GO$
2180 E=0:R=0:RA=0:RB=0:RC=0:RH=0:RX=0
2190 GOTO 210
2200 END
2210 :REM'
2220 :REM'PRT
2230 KEY OFF:GOSUB 2300:LOCATE 25,5:COLOR 0,2
2240 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2250 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2260 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2260 :ELSE GOSUB 2300
2270 IF Z$="3"THEN RETURN
2280 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2290 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2230
2300 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
