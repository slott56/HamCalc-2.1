10 :REM'INDUHOSE - Inductance of dryer hose - 15 NOV 94 rev. 04 MAR 1999
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COLOR 7,0,1
50 :REM'
60 :REM'.....start
70 CLS
80 GOSUB 1130    :REM'preface text
90 LOCATE 25,23
100 COLOR 0,7
110 PRINT " Press 1 to continue or 0 to EXIT ";
120 COLOR 7,0
130 Z$=INKEY$:IF Z$="" THEN 130
140 IF Z$="0"THEN CLS:RUN EX$
150 IF Z$="1"THEN 170
160 GOTO 130
170 GOSUB 1610   :REM'dump screen
180 :REM'
190 CLS
200 D=4.125!         :REM'coil diameter
210 L=4.125!         :REM'coil default length
220 U1$="#####.###"
230 UL$=STRING$(80,205)
240 E$=STRING$(80,32)
250 I=0     :REM'increment counter(for debugging purposes only)
260 :REM'
270 :REM'.....inductance input
280 COLOR 15,2
290 PRINT " INDUCTORS - Made From 4";CHR$(34);" Flexible Dryer Vent Hose";
300 PRINT TAB(57);"by George Murphy VE3ERP ";
310 COLOR 1,0:PRINT STRING$(80,223);
320 COLOR 0,7
330 PRINT " DESIGN PARAMETERS: "
340 COLOR 7,0
350 :REM'
360 INPUT " ENTER: Inductance ( 46.2 µH to 1145.9 µH )....";U
370 IF U=0 THEN 390
380 IF U>=46.20000076293945! AND U<=1145.9000244140625! THEN 410
390 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 360
400 :REM'
410 :REM'.....calculate
420 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
430 IF L=0 AND N*U<>0 THEN L=(D^2*N^2/U-18*D)/40
440 IF N=0 AND L*U<>0 THEN N=SQR((U*(18*D+40*L))/D^2)
450 IF U=0 AND L*N<>0 THEN U=D^2*N^2/(18*D+40*L)
460 I=I+1     :REM'increment counter
470 IF L*N*U THEN 490
480 :REM'
490  IF L<1.649999976158142! THEN L=1.649999976158142!:N=0:GOTO 440
500  IF L>8.25! THEN L=8.25!:N=0:GOTO 440
510 R=L/D     :REM'length-to-diameter ratio
520  IF R<0.5! THEN L=0.5!*D:N=0:GOTO 440
530  IF R>2 THEN L=2*D:N=0:GOTO 440
540 T=N/L     :REM'turns per inch
550  IF T<10 THEN L=N/10:N=0:GOTO 440
560  IF T>20 THEN L=N/20:N=0:GOTO 440
570 S=L/N     :REM'turn spacing
580 :REM'
590 :REM'.....screen print
600 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
610 COLOR 0,7:PRINT " DESIGN PARAMETERS: ":COLOR 7,0
620 :REM'
630 PRINT "        Inductance...........................";USING U1$;U;
640 PRINT " µH"
650 PRINT "        Coil diameter........................";USING U1$;D;
660 PRINT CHR$(34)
670 PRINT "        Coil length..........................";USING U1$;L;
680 PRINT CHR$(34)
690 R=L/D
700 PRINT "        Length-to-Diameter ratio.............";USING U1$;R;
710 PRINT ":1";
720 IF R>2 THEN COLOR 15,6:PRINT " * ";
730 IF R<0.4000000059604645! THEN COLOR 15,6:PRINT " ** ";
740 COLOR 7,0:PRINT ""
750 PRINT "        Number of turns......................";USING U1$;N
760 T=N/L
770 PRINT "        Turns per inch.......................";USING U1$;T
780 S=L/N
790 PRINT "        Turn spacing.........................";USING U1$;S;
800 PRINT CHR$(34);
810 PRINT UL$;
820 :REM'
830 :REM'.....end
840 IF N=INT(N)THEN 1030
850 COLOR 15,1:LOCATE 22,8
860 PRINT " Do you want to adjust design for";CINT(N);"full turns?   (y/n)";
870 PRINT STRING$(13,32)
880 COLOR 7,0
890 Z$=INKEY$
900 IF Z$="n"THEN LOCATE CSRLIN-1:PRINT E$;:GOTO 1030
910 IF Z$="y"THEN LOCATE CSRLIN-1:PRINT E$;:GOTO 940
920 GOTO 890
930 :REM'
940 :REM'.....recalculate length
950 N=CINT(N)
960 L=((D^2*N^2/U)-(18*D))/40
970 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11
980 PRINT
990 COLOR 0,7:PRINT " DESIGN ADJUSTED FOR";N;"FULL TURNS: "
1000 COLOR 7,0
1010 GOTO 630
1020 :REM'
1030 :REM'.....quit
1040 VIEW PRINT 20 TO 24:CLS:VIEW PRINT:LOCATE 21
1050 PRINT " Dryer Vent coils tend to be somewhat lossy. To reduce losses ";
1060 PRINT "remove all fabric"
1070 PRINT " covering & secure coil turns by gluing to 3 longitudinal ";
1080 PRINT "dowels."
1090 GOSUB 1610
1100 N=0:GOTO 30   :REM'start
1110 END
1120 :REM'
1130 :REM'.....preface
1140 COLOR 0,7:PRINT " DRYER HOSE INDUCTORS ":COLOR 7,0
1150 TB=8
1160 PRINT
1170 PRINT TAB(TB);
1180 PRINT "  Most flexible dryer hoses have a 4-1/8 inch diameter spiral wire"
1190 PRINT TAB(TB);
1200 PRINT "skeleton designed to fit over a 4.00 inch O.D. vent pipe. This"
1210 PRINT TAB(TB);
1220 PRINT "program designs 4.125 inch diameter coils made from this type and"
1230 PRINT TAB(TB);
1240 PRINT "size of dryer vent hose."
1250 PRINT TAB(TB);
1260 PRINT "  Most dryer hoses can be compressed to about 20 Turns-Per-Inch."
1270 PRINT TAB(TB);
1280 PRINT "10 T.P.I. has been arbitrarily selected as the minimum allowable"
1290 PRINT TAB(TB);
1300 PRINT "T.P.I. for the close-wound coil design formulae to retain"
1310 PRINT TAB(TB);
1320 PRINT "reasonable accuracy."
1330 PRINT TAB(TB);
1340 PRINT "  This program designs close-wound coils from 10 to 20 T.P.I. which"
1350 PRINT TAB(TB);
1360 PRINT "limits coil length to the range of from 1.65 to 8.25 inches."
1370 PRINT TAB(TB);
1380 PRINT "  The program initially assumes a coil length-to-diameter ratio"
1390 PRINT TAB(TB);
1400 PRINT "of 1:1, which will provide an acceptable Q for most amateur radio"
1410 PRINT TAB(TB);
1420 PRINT "applications. The initial default coil length of 4.125 inches is"
1430 PRINT TAB(TB);
1440 PRINT "automatically recalculated as required to fit within the T.P.I."
1450 PRINT TAB(TB);
1460 PRINT "limitations described above."
1470 PRINT TAB(TB);
1480 PRINT "  The program has been calibrated to design coils in the range"
1490 PRINT TAB(TB);
1500 PRINT "of 33.1 µH to 1145.9 µH within the generally accepted length-to-"
1510 PRINT TAB(TB);
1520 PRINT "diameter ratio limits of from 0.5:1 to 2.0:1."
1530 PRINT TAB(TB);
1540 PRINT "  Connections to the coil should be made with clamp type fittings"
1550 PRINT TAB(TB);
1560 PRINT "or binding posts because the spring steel wire in the coil and"
1570 PRINT TAB(TB);
1580 PRINT "the thin plastic hose fabric do not take too kindly to soldering."
1590 RETURN
1600 :REM'
1610 :REM'PRT
1620 KEY OFF:GOSUB 1690:LOCATE 25,5:COLOR 0,2
1630 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1640 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1650 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1650 :ELSE GOSUB 1690
1660 IF Z$="3"THEN RETURN
1670 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1680 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1620
1690 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
