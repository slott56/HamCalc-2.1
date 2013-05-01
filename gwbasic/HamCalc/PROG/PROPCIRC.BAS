10 :REM'PROPCIRC - 17 DEC 93 rev. 07 JUN 2002
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,0
70 UL$=STRING$(80,205)
80 U$="###,###.###"
90 P=3.1415929794311523!
100 ON ERROR  GOTO 200
110 :REM'
120 :REM'.....start
130 CLS:R=0:D=0:CF=0:AR=0:A=0:C=0:AC=0:B=0
140 COLOR 15,1
150 PRINT " PROPERTIES OF THE CIRCLE";TAB(61);"by George C. Murphy ";
160 COLOR 5,0:PRINT STRING$(80,223);
170 COLOR 7,0
180 GOTO 280
190 :REM'
200 :REM'.....error trap
210 BEEP
220 PRINT "You may have entered a combination of factors that ";
230 PRINT "is not possible."
240 PRINT:PRINT "Press any key to start over."
250 IF INKEY$=""THEN 250
260 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 120
270 :REM'
280 :REM'.....display text
290 GOSUB 1220     :REM'text
300 COLOR 0,7:LOCATE 25,24
310 PRINT " Press 1 to RUN or 0 to EXIT.....";
320 COLOR 7,0
330 Z$=INKEY$:IF Z$=""THEN 330
340 IF Z$="0"THEN CLS:CHAIN GO$
350 IF Z$="1"THEN 370
360 GOTO 330
370 GOSUB 1690     :REM'screen dump
380 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
390 PRINT " If you do not know the following, press <ENTER>"
400 PRINT UL$;
410 :REM'
420 :REM'.....inputs
430 IF  R=0 THEN INPUT " ENTER: Radius of circle ";R:D=2*R:GOSUB 560
440 IF  D=0 THEN INPUT " ENTER: Diameter of circle ";D:R=D/2:GOSUB 560
450 IF CF=0 THEN INPUT " ENTER: Cicumference of circle ";CF:GOSUB 560
460 IF AR=0 THEN INPUT " ENTER: Area of circle ";AR:GOSUB 560
470 IF A THEN 540
480 PRINT " (Enter 360 if chord, sector & segment data not required)"
490 IF  A=0 THEN INPUT " ENTER: Angle between radials ";Q:A=Q*P/180:GOSUB 560
500 IF A THEN 420
510 IF  C=0 THEN INPUT " ENTER: Length of chord AB ";C:GOSUB 560
520 IF AC=0 THEN INPUT " ENTER: Length of arc AB ";AC:GOSUB 560
530 IF  B=0 THEN INPUT " ENTER: Height if segment ";B:GOSUB 560
540 IF AC*D*CF*AR*A*R*C*B THEN 990 :ELSE GOSUB 560:GOTO 420
550 :REM'
560 :REM'.....calculate properties
570 VIEW PRINT 5 TO 24:CLS:VIEW PRINT:LOCATE 5
580 FOR Y=1 TO 21
590 IF B=0  AND A=P     THEN B=0:GOSUB 800
600 IF AR=0 AND R<>0    THEN AR=P*R^2:D=2*R:CF=P*D
610 IF D=0  AND R<>0    THEN D=2*R
620 IF CF=0 AND R<>0    THEN CF=P*2*R
630 IF AC=0 AND A*R<>0  THEN AC=A*R
640 IF A=0  AND AC*R<>0 THEN A=AC/R
650 IF A=0  AND R*C<>0  THEN Z=C/2/R:A=2*ATN(Z/SQR(-Z*Z+1))
660 IF R=0  AND A*B<>0  THEN R=B/(1-COS(A/2))
670 IF R=0  AND B*C<>0  THEN R=(4*B^2+C^2)/(8*B):A=2*(P-(2*(ATN((C/2)/B))))
680 IF C=0  AND B*R<>0  THEN C=2*(SQR(2*B*R-B^2))
690 IF C=0  AND A*R<>0  THEN C=2*R*SIN(A/2)
700 IF B=0  AND R*C<>0  THEN B=R-0.5!*(SQR(4*R^2-C^2))
710 IF B=0  AND A*C<>0  THEN B=C/2*TAN(A/4)
720 IF B=0  AND A*R<>0  THEN B=2*R*(SIN(A/4)^2)
730 IF R=0  AND AR<>0   THEN R=SQR(AR/P)
740 IF R=0  AND CF<>0   THEN R=CF/(2*P)
750 IF R=0  AND A*AC<>0 THEN R=AC/A
760 IF A=0  AND AC*B<>0 THEN GOSUB 850
770 IF A=0  AND AC*C<>0 THEN GOSUB 920
780 NEXT Y:RETURN
790 :REM'
800 IF C*1 THEN D=C:R=D/2
810 IF D*1 THEN C=D:R=D/2
820 IF R*1 THEN D=2*R:C=D
830 RETURN
840 :REM'
850 :REM'.....solve angle A by iteration if AC (arc) and B (height) known
860 Z=10*P/180
870 A=A+Z:X=A*B/(1-COS(A/2))
880 IF ABS(X-AC)<=X*9.999999974752427e-07! THEN RETURN
890 IF X<AC THEN A=A-Z:Z=Z/10
900 GOTO 870
910 :REM'
920 :REM'.....solve angle A by iteration if AC (arc) and C (chord) known
930 Z=10*P/180:J=2*AC/C
940 A=A+Z:X=A/SIN(A/2)
950 IF ABS(X-J)<=X*9.999999974752427e-07! THEN RETURN
960 IF X>J THEN A=A-Z:Z=Z/10
970 GOTO 940
980 :REM'
990 :REM'.....display data
1000 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1010 D$=" units"
1020 PRINT " Radius / Length of radials...";USING U$;R;:PRINT D$
1030 PRINT " Diameter.....................";USING U$;D;:PRINT D$
1040 PRINT " Circumference................";USING U$;CF;:PRINT D$
1050 PRINT " Area of full circle..........";USING U$;AR;:PRINT D$;"²"
1060 IF Q =360 THEN 1150
1070 PRINT " Angle between radials........";USING U$;A*180/P;:PRINT "°"
1080 PRINT " Length of chord AB...........";USING U$;ABS(C);:PRINT D$
1090 PRINT " Length of arc AB.............";USING U$;AC;:PRINT D$
1100 PRINT " Height of segment............";USING U$;B;:PRINT D$
1110 SC=P*R^2*A/(2*P)
1120 SG=SC-((R-B)*C/2)
1130 PRINT " Area of segment..............";USING U$;SG;:PRINT D$;"²"
1140 PRINT " Area of sector...............";USING U$;SC;:PRINT D$;"²"
1150 PRINT UL$;
1160 PRINT " All calculated values are rounded of to nearest 1/1000 unit."
1170 PRINT UL$;
1180 LN=16
1190 GOSUB 1690
1200 GOTO 120
1210 :REM'
1220 :REM'.....text block
1230 TB=7     :REM'tab for text
1240 PRINT TAB(TB);
1250 PRINT "Draw a circular clock face. Mark 3 points on the circle: A at 10"
1260 PRINT TAB(TB);
1270 PRINT "o'clock, B at 2 o'clock, C at the centre of the circle. Draw lines"
1280 PRINT TAB(TB);
1290 PRINT "from A to B, B to C, and C to A."
1300 PRINT UL$;
1310 PRINT TAB(TB);
1320 PRINT "The following definitions apply to this diagram:"
1330 PRINT TAB(TB);
1340 PRINT "════════════════════════════════════════════════"
1350 PRINT TAB(TB);
1360 PRINT "RADIAL - any line drawn between the centre of a circle and any"
1370 PRINT TAB(TB);
1380 PRINT "  point on the circumference. Lines AC and BC are radials."
1390 PRINT TAB(TB);
1400 PRINT "CHORD - a straight line drawn between any two points on the"
1410 PRINT TAB(TB);
1420 PRINT "  circumference. Line AB is a chord."
1430 PRINT TAB(TB);
1440 PRINT "ARC - that part of the circumference which lies between any two"
1450 PRINT TAB(TB);
1460 PRINT "  points. The curved line between A and B is an arc."
1470 PRINT TAB(TB);
1480 PRINT "ANGLE - the angle in degrees between 2 radials that terminate at"
1490 PRINT TAB(TB);
1500 PRINT "  the ends of a chord or arc. (angle ACB on your sketch)."
1510 PRINT TAB(TB);
1520 PRINT "SECTOR - the pie shaped figure formed by two radials and the arc"
1530 PRINT TAB(TB);
1540 PRINT "  joining their ends."
1550 PRINT TAB(TB);
1560 PRINT "SEGMENT - the figure formed by a chord and an arc joining the two"
1570 PRINT TAB(TB);
1580 PRINT "  ends of the chord."
1590 PRINT TAB(TB);
1600 PRINT "HEIGHT (of segment) - the distance between the midpoints of the"
1610 PRINT TAB(TB);
1620 PRINT "  arc and the chord that form a segment."
1630 PRINT TAB(TB);
1640 PRINT "DIMENSIONS can be entered in any unit of measure, as long as the"
1650 PRINT TAB(TB);
1660 PRINT "  same unit is used for all dimensions.";
1670 RETURN
1680 :REM'
1690 :REM'PRT
1700 KEY OFF:GOSUB 1770:LOCATE 25,5:COLOR 0,2
1710 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1720 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1730 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1730 :ELSE GOSUB 1770
1740 IF Z$="3"THEN RETURN
1750 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1760 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1700
1770 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
