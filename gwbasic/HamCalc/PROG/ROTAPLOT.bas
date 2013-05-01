10 :REM'\hamcalc\prog\ROTAPLOT - Feb 1994, rev. 09 APR 01
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$,PROG$
50 COLOR 7,0,0
60 PI=4*ATN(1)  :REM'3.141593
70 I$="+#,###.###"
80 M$="#,###.###"
90 E$=STRING$(80,32)
100 UL$=STRING$(80,205)
110 GOTO 170
120 :REM'
130 :REM'.....erase line
140 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
150 RETURN
160 :REM'
170 :REM'.....title page
180 CLS
190 COLOR 15,2,0
200 PRINT " CARTESIAN/POLAR PLOT ROTATOR"TAB(57)"by George Murphy VE3ERP ";
210 COLOR 1,0:PRINT STRING$(80,223);
220 LOCATE 3:T=26
230 GOSUB 1510  :REM'diagram
240 COLOR 7,0
250 PRINT
260 GOSUB 1390  :REM'preface
270 PRINT UL$;
280 PRINT " Press number in < > to:"
290 PRINT UL$;
300 PRINT "   < 1 > Enter data in CARTESIAN co-ordinates"
310 PRINT "   < 2 > Enter data in POLAR co-ordinates"
320 PRINT
330 PRINT "   < 0 > EXIT"
340 Z$=INKEY$
350 IF Z$="1"THEN P$="c":GOTO 400
360 IF Z$="2"THEN P$="p":GOTO 400
370 IF Z$="0"THEN CLS:CHAIN EX$
380 GOTO 340
390 :REM'
400 CLS:COLOR 7,0,0
410 LOCATE 2
420 PRINT " To rotate plotted coordinates about "
430 PRINT " the junction * of the X and Y axis: "
440 LOCATE 1:T=51
450 GOSUB 1510  :REM'diagram
460 PRINT
470 :REM'
480 :REM'.....inputs
490 INPUT "ENTER: Rotation in degrees (minus if counter-clockwise) ";D
500 IF D<0 THEN D$="° counter-clockwise ":ELSE D$="° clockwise "
510 R=D*PI/180
520 GOSUB 130
530 COLOR 0,7:LOCATE 5
540 PRINT " Rotation = ";ABS(D);D$
550 COLOR 7,0:LOCATE 9
560 PRINT " ┌";STRING$(15,196);" Cartesion Plot ";STRING$(15,196);"┐";
570 PRINT "│┌";STRING$(8,196);" Polar Plot ";STRING$(8,196);"┐";
580 PRINT " ┌";STRING$(5,196);" rotate from ";STRING$(4,196);"┐";
590 PRINT " ┌";STRING$(5,196);" rotate to ";STRING$(5,196);"┐│";
600 PRINT SPC(12);"┌─ rotate angle ─┐";
610 PRINT TAB(7)"-x-"TAB(20)"-y-"TAB(31)"-x-"TAB(44)"-y-"TAB(50)"│";
620 PRINT TAB(55)"Vector  ┌ from ┐  ┌─ to ─┐";
630 PRINT " "+STRING$(79,196);
640 LOCATE CSRLIN-1,50:PRINT "┼"
650 N=0
660 :REM'
670 :REM'.....select plot
680 IF P$="c"THEN 880   :REM'cartesian
690 IF P$="p"THEN 710   :REM'polar
700 :REM'
710 :REM'.....polar
720 N=N+1
730 COLOR 15,4
740 LOCATE 7:PRINT " Enter Vector = 0 if no more entries "
750 LN=12+N:LOCATE LN
760 COLOR 0,7:PRINT " Point ";CHR$(N+64);
770 INPUT ": ENTER: Vector length";V
780 COLOR 7,0
790 C=CSRLIN-1:LOCATE 7:PRINT STRING$(40,32)
800 IF V=0 THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:GOTO 1630
810 COLOR 0,7:LOCATE LN,61
820 INPUT " ENTER: Angle";Z
830 COLOR 7,0
840 X=SIN(Z*PI/180)*V
850 Y=COS(Z*PI/180)*V
860 GOTO 1100
870 :REM'
880 :REM'.....cartesian
890 N=N+1
900 COLOR 15,4
910 LOCATE 7:PRINT " Enter x = z if no more entries "
920 LN=12+N:LOCATE LN
930 COLOR 0,7:PRINT " Point ";CHR$(N+64);
940 INPUT ": ENTER: x = ";Z$
950 COLOR 7,0
960 C=CSRLIN-1:LOCATE 7:PRINT STRING$(40,32)
970 X=VAL (Z$)
980 IF X=0 THEN X=9.99999993922529e-09!
990 IF Z$<>"z"THEN 1030
1000 VIEW PRINT LN TO 24:CLS:VIEW PRINT
1010 GOTO 1630
1020 :REM'
1030 :REM'.....enter y
1040 LOCATE C,41:COLOR 0,7
1050 INPUT " ENTER: y = ";Y
1060 IF Y=0 THEN Y=9.99999993922529e-09!
1070 COLOR 7,0
1080 GOSUB 130
1090 :REM'
1100 W=ATN(ABS(X)/ABS(Y))
1110 IF SGN(X)=1 THEN IF SGN(Y)=-1 THEN W=PI-W
1120 IF SGN(X)=-1 THEN IF SGN(Y)=-1 THEN W=PI+W
1130 IF SGN(X)=-1 THEN IF SGN(Y)=1 THEN W=2*PI-W
1140 H=SQR(X^2+Y^2)
1150 :REM'
1160 :REM'.....rotate
1170 A=W
1180 X1=SIN(A)*H
1190 Y1=COS(A)*H
1200 IF A>2*PI THEN B=A-2*PI :ELSE B=A
1210 P1=B*180/PI:IF P1>=360 THEN P1=P1-360
1220 IF P1<0 THEN P1=P1+360
1230 IF P1=360 THEN P1=0
1240 A=W+R
1250 X2=SIN(A)*H
1260 Y2=COS(A)*H
1270 IF A>2*PI THEN B=A-2*PI :ELSE B=A
1280 P2=B*180/PI:IF P2>=360 THEN P2=P2-360
1290 IF P2<0 THEN P2=P2+360
1300 IF P2=360 THEN P2=0
1310 :REM'
1320 :REM'.....screen print
1330 LOCATE LN
1340 PRINT USING "+######.###  +######.###";X1,Y1;
1350 PRINT USING "+######.###  +######.### │";X2,Y2;
1360 PRINT USING "######.###   ###.##°   ###.##°";H;P1;P2
1370 GOTO 670
1380 :REM'
1390 :REM'.....preface
1400 PRINT " This program rotates a plotted point or pattern of plotted point";
1410 PRINT "s about the   "
1420 PRINT " junction * of the x and y axis of the plot. The new locations ar";
1430 PRINT "e indicated in"
1440 PRINT " both cartesian and polar coordinates."
1450 PRINT
1460 PRINT " Coordinates may be entered in any unit of measure. All entries m";
1470 PRINT "ust be in the "
1480 PRINT " same units."
1490 RETURN
1500 :REM'
1510 :REM'.....diagram
1520 COLOR 0,7
1530 LOCATE ,T:PRINT "              Y «0°          "
1540 LOCATE ,T:PRINT "          -x  │  +x          "
1550 LOCATE ,T:PRINT "          +y  │  +y          "
1560 LOCATE ,T:PRINT " 270°» X───── * ─────X «90°  "
1570 LOCATE ,T:PRINT "          -x  │  +x          "
1580 LOCATE ,T:PRINT "          -y  │  -y          "
1590 LOCATE ,T:PRINT "              Y «180°        "
1600 COLOR 7,0
1610 RETURN
1620 :REM'
1630 :REM'.....end
1640 GOSUB 1660:GOTO 170
1650 :REM'
1660 :REM'.....PRT
1670 KEY OFF:GOSUB 1740:LOCATE 25,5:COLOR 0,2
1680 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1690 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1700 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1700 :ELSE GOSUB 1740
1710 IF Z$="3"THEN RETURN
1720 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1730 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1670
1740 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
