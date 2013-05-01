10 :REM'CONECALC - Cone dimension Calculator  - 08 OCT 2003
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 UL$=STRING$(80,205)
80 U1$="#####.###"
90 :REM'
100 :REM'.....title page
110 CLS
120 COLOR 15,2,0
130 PRINT " Cone Calculator"TAB(57)"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 0,7:LOCATE CSRLIN-1,26:PRINT" Algorithm by Robert Dehoney ":COLOR 7,0
160 PRINT
170 PRINT TAB(7);
180 PRINT "This program computes pattern sheet size and layout for any size"
190 PRINT TAB(7);
200 PRINT "cone and/or the cone and the pattern dimensions to fit any size"
210 PRINT TAB(7);
220 PRINT "pattern sheet."
230 PRINT
240 PRINT TAB(7);
250 PRINT "Dimensions can be any unit of measure as long as all dimensions"
260 PRINT TAB(7);
270 PRINT "are entered in the same units; x and y dimensions are measured from"
280 PRINT TAB(7);
290 PRINT "the lower left corner of the pattern sheet."
300 PRINT UL$;
310 PRINT "   To EXIT program, press 0"
320 PRINT "   To compute cone pattern layout, press 1";
330 PRINT "   To compute cone size to fit a known pattern sheet size, press 2"
340 PRINT "   To compute truncated cone pattern layout, press 3"
350 PRINT
360 Z$=INKEY$:IF Z$=""THEN 360
370 IF Z$="0"THEN CLS:RUN GO$
380 IF Z$="1"THEN 1110
390 IF Z$="2"THEN 430
400 IF Z$="3"THEN 1560
410 GOTO 360
420 :REM'
430 :REM'.....pattern layout
440 PRINT
450 INPUT " ENTER: smaller dimension of the sheet .......A=";A
460 INPUT " ENTER: larger dimension of the sheet ........B=";B
470 IF A*B THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
480 IF B<A THEN SWAP A,B
490 IF B>A*2 THEN 600
500 :REM'
510 L1=B/2:X=A/L1-1:GOSUB 1060:THETA1=PI+2*ALPHA:ANG1=THETA1*180/PI
520 C1=L1*THETA1 :D1=C1/PI:R1=D1/2:H1=SQR(L1^2-R1^2)
530 :REM'
540 L2=A:X=B/2/L2:GOSUB 1060:THETA2=2*ALPHA:ANG2=THETA2*180/PI
550 C2=L2*THETA2:D2=C2/PI:R2=D2/2:H2=SQR(L2^2-R2^2)
560 :REM'
570 L3=A:X=B/L3-1:GOSUB 1060:THETA3=ALPHA+PI/2:ANG3=THETA3*180/PI
580 C3=L3*THETA3:D3=C3/PI:R3=D3/2:H3=SQR(L3^2-R3^2)
590 :REM'
600 L4=B:X=A/L4:GOSUB 1060:THETA4=ALPHA:ANG4=THETA4*180/PI
610 C4=L4*THETA4:D4=C4/PI:R4=D4/2:H4=SQR(L4^2-R4^2)
620 :REM'
630 L5=B:X=A/2/L5:GOSUB 1060:THETA5=2*ALPHA:ANG5=THETA5*180/PI
640 C5=L5*THETA5:D5=C5/PI:R5=D5/2:H5=SQR(L5^2-R5^2)
650 :REM'
660 :REM'.....display results
670 PRINT
680 PRINT USING " Pattern sheet:  (A) ###.## in. x  (B) ###.## in.";A,B
690 PRINT
700 PRINT " Type    Height  Base Diameter  Base Circum    Radius      Arc"
710 IF B>2*A THEN GOTO 780
720 PRINT TAB(3);"1";TAB(8);USING "###.###      ";H1;D1;C1;L1;
730 PRINT USING "###.###°";ANG1
740 PRINT TAB(3);"2";TAB(8);USING "###.###      ";H2;D2;C2;L2;
750 PRINT USING "###.###°";ANG2
760 PRINT TAB(3);"3";TAB(8);USING "###.###      ";H3;D3;C3;L3;
770 PRINT USING "###.###°";ANG3
780 PRINT TAB(3);"4";TAB(8);USING "###.###      ";H4;D4;C4;L4;
790 PRINT USING "###.###°";ANG4
800 PRINT TAB(3);"5";TAB(8);USING "###.###      ";H5;D5;C5;L5;
810 PRINT USING "###.###°";ANG5
820 PRINT
830 PRINT:PRINT "  Type      Location of Arc Center "
840 IF B>2*A GOTO 970
850 PRINT "                                   B"
860 PRINT "  1  ";:PRINT USING "x= ###.###, y= ###.###";B/2,A-B/2;
870 PRINT "   ┌─────────┐"
880 PRINT "  2  ";:PRINT USING "x= ###.###, y= ###.###";B/2,0;
890 PRINT "  y│         │A"
900 PRINT "  3  ";:PRINT USING "x= ###.###, y= ###.###";B-A,0;
910 PRINT "  ││         │"
920 PRINT "  4  ";:PRINT USING "x= ###.###, y= ###.###";0,0;
930 PRINT "   └─────────┘"
940 PRINT "  5  ";:PRINT USING "x= ###.###, y= ###.###";0,A/2;
950 PRINT "     ───x   "
960 GOTO 1040
970 PRINT "                                        B"
980 PRINT "                                   ┌─────────┐"
990 PRINT "  4             x=0, y=0         y │         │A"
1000 PRINT "  5             x=0, y=a/2       │ │         │"
1010 PRINT "                                   └─────────┘"
1020 PRINT "                                    ────x     "
1030 PRINT "Note that types 1, 2, and 3 do not apply when B>2A"
1040 PRINT :LN=CSRLIN:Q=5: GOTO 1500
1050 :REM'
1060 :REM'.....Subroutine to solve for alpha
1070 IF X=1 THEN ALPHA=PI/2 :GOTO 1090
1080 ALPHA=ATN(X/SQR(1-X^2))
1090 RETURN
1100 :REM'
1110 :REM'.....enter dimensions
1120 GOSUB 1350
1130 INPUT " ENTER: cone base diameter...............D=";D
1140 INPUT " ENTER: cone height......................H=";H
1150 CLS
1160 R=D/2
1170 L=SQR(R^2+H^2)
1180 THETA=PI*D/L :DEG=THETA*180/PI :PRINT
1190 IF THETA=>PI THEN B=2*L:A=L+L*SIN((THETA-PI)/2):X=B/2:Y=A-B/2:GOTO 1220
1200 IF THETA=>PI/2 THEN A=L:B=L+L*SIN(THETA-PI/2):X=B-A:Y=0:GOTO 1220
1210 B=L:A=L*SIN(THETA) :X=0 :Y=O
1220 PRINT " CONE PATTERN "
1230 PRINT  UL$;
1240 PRINT USING " Cone base dia ............... ###.### ";D
1250 PRINT USING " Cone height ................. ###.### ";H
1260 PRINT USING " Base circumference........... ###.### ";PI*D
1270 PRINT USING " Arc angle ................... ###.###°";DEG
1280 PRINT USING " Arc radius .................. ###.### ";L
1290 PRINT USING " Arc center coordinates...  X= ###.### ";X
1300 PRINT USING "                            Y= ###.### ";Y
1310 PRINT USING " Pattern sheet ........... (A) ###.###  x (B)###.### ";A,B
1320 PRINT
1330 GOSUB 1350:GOTO 1480
1340 :REM'
1350 :REM'.....diagram
1360 COLOR 0,7
1370 Q=32
1380 LOCATE ,Q:PRINT "        B       "
1390 LOCATE ,Q:PRINT "   ┌─────────┐  "
1400 LOCATE ,Q:PRINT "  y│         │A "
1410 LOCATE ,Q:PRINT "  ││         │  "
1420 LOCATE ,Q:PRINT "   └─────────┘  "
1430 LOCATE ,Q:PRINT "    ────x       "
1440 COLOR 7,0
1450 RETURN
1460 GOTO 1560
1470 :REM'
1480 :REM'.....end
1490 PRINT:LN=CSRLIN
1500 LOCATE ,Q-2:COLOR 0,7:PRINT " Try another? (y/n) ":COLOR 7,0
1510 Z$=INKEY$:IF Z$=""THEN 1510
1520 IF Z$="y" THEN 100
1530 IF Z$="n" THEN GOSUB 2090:GOTO 100
1540 GOTO 1510
1550 :REM'
1560 :REM'.....truncated cone
1570 CLS:COLOR 7,0,0
1580 PRINT
1590 PRINT TAB(7);
1600 PRINT " A truncated cone can be made from a flat sheet of material by "
1610 PRINT TAB(7);
1620 PRINT " cutting out a truncated sector with the proper radii and arc angle"
1630 PRINT TAB(7);
1640 PRINT " and rolling it until the straight edges join. Allow extra material"
1650 PRINT TAB(7);
1660 PRINT " if an overlap is needed."
1670 PRINT UL$;
1680 INPUT "ENTER: diameter at large end...........";D1T
1690 INPUT "ENTER: diameter at small end...........";D1B
1700 IF D1B<D1T THEN SWAP D1B,D1T
1710 INPUT "ENTER: length between ends.............";H1
1720 CLS
1730 RT=D1B/2:RB=D1T/2 :H=H1 :GOSUB 2020
1740 TOP=A:BOT=0
1750 IF DEG>180 THEN Y=A-L
1760 IF DEG<180 THEN Y=L-A
1770 IF D1T>D1B THEN LE=D1T:E=D1B :ELSE LE=D1B:SE=D1T
1780 :REM'
1790 PRINT  " TRUNCATED CONE PATTERN "
1800 PRINT UL$;
1810 PRINT USING " Diameter at large end............ ###.###";LE
1820 PRINT USING " Diameter at small end............ ###.###";SE
1830 PRINT USING " Length between ends.............. ###.###";H1
1840 PRINT USING " Outer arc radius................. ###.###";L
1850 PRINT USING " Inner arc radius................. ###.###";LX
1860 PRINT USING " Arc angle........................ ###.###°";DEG
1870 PRINT USING " Minimum sheet size............(B) ###.### x (A) ###.###";B,A
1880 U$=" Location of arc centre.........x= ###.###    y= ###.###"
1890 IF DEG<180 THEN S$=" below" :ELSE S$= " above"::ELSE S$=" below"
1900 S$=S$ +" bottom of sheet"
1910 IF DEG=180 THEN S$=""
1920 PRINT USING U$;X,ABS(Y);
1930 PRINT S$
1940 PRINT USING " Location of top of sheet.......y= ###.###";TOP;:PRINT T$
1950 PRINT USING " Location of bottom of sheet....y= ###.###";ABS(BOT);
1960 PRINT:PRINT
1970 GOSUB 1350:GOTO 1480
1980 PRINT S$
1990 PRINT :LN=CSRLIN:Q=5: GOTO 1500
2000 GOSUB 2090:GOTO 100
2010 :REM'
2020 :REM'.....calculate sector pattern
2030 HX=RB*H/(RT-RB):L=SQR(RT^2+(H+HX)^2):LX=RB*L/RT
2040 THETA=2*PI*RT/L:DEG=THETA*180/PI:PRINT
2050 IF THETA=>PI THEN B=2*L:A=L+L*SIN((THETA-PI)/2):X=B/2:Y=A-B/2:GOTO 2070
2060 B=2*L*SIN(THETA/2):A=L-LX*COS(THETA/2):X=B/2:Y=0
2070 RETURN
2080 :REM'
2090 :REM'.....PRT
2100 KEY OFF:GOSUB 2170:LOCATE 25,5:COLOR 0,2
2110 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2120 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2130 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2130 :ELSE GOSUB 2170
2140 IF Z$="3"THEN RETURN
2150 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2160 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2100
2170 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
2180 CLS
