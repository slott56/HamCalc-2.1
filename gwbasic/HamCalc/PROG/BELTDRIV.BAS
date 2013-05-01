10 :REM'BELTDRIV : 3 DEC 85  rev. 01 JUN 2010
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$
40 CLS:KEY OFF
50 PI=4*ATN(1)
60 COLOR 7,0,4
70 U$="###.###":U1$="######.###"
80 UL$=STRING$(80,205)
90 E$=STRING$(80,32)
100 T$=" BELT DRIVES (V-belts/Gear belts) "
110 COLOR 11,1:PRINT T$;TAB(57);"by George Murphy VE3ERP ";
120 COLOR 4,0:PRINT STRING$(80,"▀");
130 COLOR 7,0
140 :REM'
150 :REM'.....start
160 PRINT " Press number in < > to select: "
170 PRINT UL$;
180 PRINT "  < 1 >  Pulleys known"
190 PRINT "  < 2 >  Pulleys unknown, R.P.M.'s known"
200 PRINT UL$;
210 PRINT "  < 0 >  Exit"
220 Z$=INKEY$
230 IF Z$="1"THEN 280
240 IF Z$="2"THEN 370
250 IF Z$="0"THEN CHAIN "mechmenu"
260 GOTO 220
270 :REM'
280 :REM'.....pulleys known
290 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
300 INPUT " ENTER: Pitch dia. - Pulley A  (in.)...";D
310 INPUT " ENTER: Pitch dia. - Pulley B  (in.)...";E
320 COLOR 7,0
330 IF E>D THEN SWAP D,E
340 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
350 LOCATE 5:GOTO 890
360 :REM'
370 :REM'.....pulleys unknown
380 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
390 INPUT " ENTER: Known R.P.M. ................";X
400 INPUT " ENTER: Sought R.P.M. ...............";Y
410 COLOR 7,0
420 R1=Y/X
430 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
440 PRINT " Known  R.P.M. ......................";USING U1$;X
450 PRINT " Sought R.P.M. ......................";USING U1$;Y
460 PRINT:PRINT " Enter the pitch diameters of a few standard pulleys:"
470 PRINT
480 PRINT " ( Press [ENTER] to end your list )"
490 N=0:NL=11:PRINT
500 COLOR 0,3
510 INPUT " ENTER Pitch diameter ........";Z
520 IF Z=0 THEN 540
530 N=N+1:A(N)=Z:GOTO 510
540 COLOR 7,0
550 VIEW PRINT 6 TO 24:CLS:VIEW PRINT:LOCATE 6
560 PRINT " Theoretical pulley pitch diameter combinations are:":PRINT
570 FOR Z=1 TO N:W=96+Z
580 P=A(Z)/R1:Q=A(Z)*R1
590 PRINT " (";CHR$(W);")";USING U$;A(Z);:PRINT " &";
600 COLOR 15,3:PRINT USING U$;P;:COLOR 7,0
610 COLOR 15,3:PRINT TAB(40)"(";CHR$(W+N);")";USING U$;Q;:COLOR 7,0
620 PRINT " &";:PRINT USING U$;A(Z)
630 NEXT Z:PRINT
640 PRINT " Press letter in ( ) to select a combination where the hi-lited";
650 PRINT " pulley is close to a stock pitch diameter"
660 Z$=INKEY$
670 IF Z$<>""THEN 690
680 GOTO 660
690 IF Z$<>""THEN T=ASC(Z$)-96:IF T>= 1 AND T<=Z-1+N THEN 710
700 GOTO 660
710 IF T>N THEN B=T-N :ELSE B=T
720 W=A(B)
730 IF T>N THEN V=W*R1 :ELSE V=W/R1
740 IF X>Y AND V>W THEN SWAP V,W
750 IF X<Y AND V<W THEN SWAP V,W
760 VIEW PRINT 5 TO 24:CLS:VIEW PRINT:LOCATE 6
770 PRINT " You have selected the combination of";USING U$;V;
780 PRINT " &";USING U$;W:PRINT
790 IF V=A(B)THEN T=W :ELSE T=V
800 COLOR 0,3
810 PRINT " ENTER: Pitch dia. of standard pulley that is close to ";USING U$;T;
820 PRINT " ";:INPUT Z
830 COLOR 7,0
840 IF T=W THEN W=Z :ELSE V=Z
850 Y=V/W*X
860 D=V:E=W:IF E>D THEN SWAP D,E
870 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
880 PRINT " Other  R.P.M. ......................";USING U1$;Y
890 PRINT " Pitch diameter - small pulley.......";USING U1$;E
900 PRINT " Pitch diameter - large pulley.......";USING U1$;D
910 R=D/E:G=(D+E)/2+E:IF R>=3 THEN G=2*D
920 I=(D+E)/2+0.5!
930 PRINT " Minimum c.c.(in.)...................";USING U1$;I
940 PRINT " Ideal   c.c.(in.)(V-belt drives)....";USING U1$;G
950 LOCATE 10,1:COLOR 0,3:INPUT " ENTER: Desired c.c.distance (in.)...";C
960 COLOR 7,0:VIEW PRINT 10 TO 24:CLS:VIEW PRINT
970 IF C<I THEN 950
980 LOCATE 9,1:PRINT " Desired c.c.(in.)...................";USING U1$;C
990 V=PI/2*(D+E)
1000 W=(D-E)^2/(4*C)
1010 M=2*C+V+W
1020 LOCATE 11,1:PRINT " Design Belt length (in.)............";USING U1$;M
1030 LOCATE 12,1
1040 COLOR 0,3
1050 LOCATE 12,1:COLOR 0,3:INPUT " ENTER: Nearest standard belt (in.)..";L
1060 COLOR 7,0
1070 F=4*L-(2*PI*(D+E))
1080 H=32*(D-E)^2
1090 IF F^2<H THEN 1120
1100 C=(F+SQR(F^2-H))/16
1110 IF C>=I THEN 1150
1120 PRINT" BELT TOO SHORT - Try a longer belt! ( Press SPACE BAR to continue )"
1130 Z$=INKEY$:IF Z$=" "THEN C1=12:C2=12:C3=13:GOSUB 130:GOTO 1030
1140 GOTO 1130
1150 VIEW PRINT 12 TO 24:CLS:VIEW PRINT:LOCATE 10
1160 PRINT " Actual  c.c.(in.)...................";USING U1$;C
1170 LOCATE 12,1
1180 PRINT " Length of standard belt to use .....";USING U1$;L
1190 IF X+Y=0 THEN 1360
1200 LOCATE 14,1
1210 COLOR 0,3
1220 PRINT " ( Press [ENTER] if not applicable)"
1230 INPUT " ENTER: Drive horsepower ............";HP
1240 COLOR 7,0
1250 VIEW PRINT 13 TO 24:CLS:VIEW PRINT:LOCATE 13
1260 IF HP THEN PRINT " Horsepower .........................";USING U1$;HP
1270 VL=0.26179999113082886!*E*X
1280 PRINT " Velocity (ft./min.) of belt(s)......";USING U1$;VL
1290 TN=33000.0!*HP/VL
1300 IF HP THEN PRINT " Tension  (lbs.) on belt(s)..........";USING U1$;TN
1310 T1=TN*E/2
1320 IF HP THEN PRINT " In./lb. torque - small pulley shaft ";USING U1$;T1
1330 T2=TN*D/2
1340 IF HP THEN PRINT " In./lb. torque - large pulley shaft ";USING U1$;T2
1350 :REM'
1360 PRINT UL$;
1370 GOSUB 1400
1380 CLS:CHAIN"mechmenu"
1390 :REM'
1400 :REM'PRT
1410 KEY OFF:GOSUB 1480:LOCATE 25,5:COLOR 0,2
1420 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1430 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1440 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1440 :ELSE GOSUB 1480
1450 IF Z$="3"THEN RETURN
1460 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1470 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1410
1480 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
