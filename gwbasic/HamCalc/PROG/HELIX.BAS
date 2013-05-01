10 :REM'HELIX - Helical Winding - 23 JAN 94 rev. 01 AUG 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 PI=3.1415929794311523!
60 E$=STRING$(80,32)
70 E1$=STRING$(7,32)
80 UL$=STRING$(80,205)
90 U1$="####.###"
100 :REM'
110 :REM'.....start
120 CLS:T=0:P=0:N=0:LW=0:LC=0
130 COLOR 15,2
140 PRINT " HELICAL WINDINGS";TAB(57);"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 :REM'
180 GOSUB 1590
190 PRINT UL$;
200 COLOR 0,7:LOCATE CSRLIN,22
210 PRINT " Press 1 to continue or 0 to EXIT....."
220 COLOR 7,0
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN CLS:RUN EX$
250 IF Z$="1"THEN 270
260 GOTO 490
270 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
280 PRINT " Press number in < > to select preferred unit of measurement:"
290 PRINT UL$;
300 PRINT "      < 1 >  millimetres"
310 PRINT "      < 2 >  centimetres"
320 PRINT "      < 3 >  inches"
330 Z$=INKEY$:IF Z$=""THEN 330
340 IF Z$="1"THEN MM$=" millimetres":M$=" mm.":GOTO 380
350 IF Z$="2"THEN MM$=" centimetres":M$=" cm.":GOTO 380
360 IF Z$="3"THEN MM$=" inches":M$=" in.":GOTO 380
370 GOTO 330
380 VIEW PRINT 8 TO 24:CLS:VIEW PRINT:LOCATE 8
390 PRINT " Please enter all dimensions in";MM$
400 PRINT UL$;
410 PRINT " If you do not know the data requested, press <ENTER> to bypass ";
420 PRINT "the request."
430 PRINT " If the data is critical, you will be asked for it again."
440 PRINT UL$;
450 INPUT " ENTER: Filament outside diameter.........................";OD
460 IF OD=0 THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 450
470 LOCATE CSRLIN-1:PRINT E1$;:LOCATE CSRLIN,59:PRINT USING U1$;OD;:PRINT M$
480 :REM'
490 INPUT " ENTER: Winding form outside diameter.....................";CD
500 IF CD=0 THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 490
510 LOCATE CSRLIN-1:PRINT E1$;:LOCATE CSRLIN,59:PRINT USING U1$;CD;:PRINT M$
520 :REM'
530 MD=CD+OD   :REM'mean winding diameter
540 C=PI*MD    :REM'mean circumference
550 :REM'
560 IF P THEN 610
570 INPUT " ENTER: Pitch (centre-to-centre distance between turns)...";P
580 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
590 GOSUB 1340
600 :REM'
610 IF N THEN 660
620 INPUT " ENTER: Number of turns...................................";N
630 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
640 GOSUB 1340
650 :REM'
660 IF LW THEN 700
670 INPUT " ENTER: Length of helical winding.........................";LW
680 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
690 GOSUB 1340
700 :REM'
710 IF LC THEN 760
720 INPUT " ENTER: Length of filament................................";LC
730 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
740 GOSUB 1340
750 :REM'
760 IF T*P*N*LW*LC THEN 790
770 GOTO 560
780 :REM'
790 :REM'.....display
800 IF P<OD OR LW<OD*N THEN 1500
810 PRINT "        Pitch (centre-to-centre distance between turns)...";
820 PRINT USING U1$;P;:PRINT M$
830 PA=ATN(P/C)*180/3.1415929794311523!
840 PRINT "        Pitch Angle (slope of windings)...................";
850 PRINT USING U1$;PA;:PRINT "°"
860 PRINT "        Length of filament in one (1) turn................";
870 PRINT USING U1$;T;:PRINT M$
880 PRINT "        Number of turns...................................";
890 PRINT USING U1$;N
900 PRINT "        Length of helical winding.........................";
910 PRINT USING U1$;LW;:PRINT M$
920 IF M$<>" in."THEN 970
930 TPU=N/LW
940 PRINT "        Turns per inch....................................";
950 PRINT USING U1$;TPU
960 LOCATE CSRLIN-1,18:PRINT MM$
970 RA=LW/(CD+OD)
980 PRINT "        Length-to-Diameter ratio..........................";
990 PRINT USING U1$;RA;:PRINT ":1"
1000 PRINT "        Length of filament................................";
1010 PRINT USING U1$;LC;:PRINT M$
1020 PRINT UL$;
1030 VIEW PRINT 7 TO 11:CLS:VIEW PRINT
1040 LN=17:GOSUB 1710
1050 LOCATE 25,1:PRINT E$;
1060 LOCATE 25,13:COLOR 15,2
1070 PRINT " Would you like to see a helix winding table?    (y/n) ";
1080 Z$=INKEY$
1090 IF Z$="n"THEN COLOR 7,0:GOTO 110    :REM'start
1100 IF Z$="y"THEN 1130
1110 GOTO 1080
1120 :REM'
1130 :REM'.....helix winding table
1140 COLOR 7,0
1150 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1160 Y$="DISTANCES OF EACH FULL WINDING FROM END OF HELIX"
1170 PRINT TAB(INT(80-LEN(Y$))/2);Y$
1180 N$=STR$(INT(N*100+0.5!)/100)
1190 LW$=STR$(INT(LW*100)/100)
1200 X$=N$+" turn helix"+LW$+M$+" long"
1210 PRINT TAB(INT(80-LEN(X$))/2);X$
1220 X$="( Distances are in"+MM$+" )"
1230 PRINT TAB(INT(80-LEN(X$))/2);X$
1240 PRINT UL$;
1250 LN=6       :REM'line number
1260 FOR Z=1 TO N
1270  LN=LN+0.10000000149011612!                :REM'.1 = 10 numbers per line
1280   PRINT USING "#####.##";Z*P;
1290  IF LN>=24 THEN GOSUB 1710:CLS:LN=0
1300 NEXT Z
1310 GOSUB 1710
1320 GOTO 110   :REM'start
1330 :REM'
1340 :REM'.....calculate
1350 IF T=0 AND P*C<>0 THEN T=SQR(P^2+C^2):GOTO 1340    :REM'T= length of 1 turn
1360 IF T=0 AND LC*N<>0 THEN T=LC/N:GOTO 1340
1370 IF P=0 AND LW*N<>0 THEN P=LW/N:GOTO 1340 :REM'P= pitch
1380 IF P=0 AND C*T<>0 AND T>=C THEN P=SQR(T^2-C^2):GOTO 1340
1390 IF N=0 AND LW*P<>0 THEN N=LW/P:GOTO 1340 :REM'N= number of turns
1400 IF N=0 AND LC*T<>0 THEN N=LC/T:GOTO 1340
1410 IF N=0 AND LC*LW<>0 THEN N=SQR(LC^2-LW^2)/C:GOTO 1340
1420 IF LW=0 AND P*N<>0 THEN LW=P*N           :REM'LW= length of helical winding
1430 IF LC=0 AND T*N<>0 THEN LC=T*N:GOTO 1340 :REM'LC= length of conductor
1440 IF P*OD>0 AND P<OD THEN 1500
1450 IF T*C>0 AND T<=C THEN 1500
1460 IF T*MD>0 AND T<PI*MD THEN 1500
1470 IF LC*LW>0 AND LC<LW THEN 1500
1480 RETURN
1490 :REM'
1500 :REM'.....error warning
1510 BEEP:PRINT " ";:COLOR 11,4
1520 PRINT " NOT POSSIBLE - TRY AGAIN ! "
1530 COLOR 7,0
1540 PRINT " Press any key........"
1550 IF INKEY$=""THEN 1550
1560 GOTO 110   :REM'start
1570 END
1580 :REM'
1590 :REM'.....preface
1600 TB=8
1610 PRINT TAB(TB);
1620 PRINT "This program computes the geometric parameters and dimensions of"
1630 PRINT TAB(TB);
1640 PRINT "a filament wound in the form of a helix of constant diameter with"
1650 PRINT TAB(TB);
1660 PRINT "equal spacing between turns as, for instance, in the case of a"
1670 PRINT TAB(TB);
1680 PRINT "spiral wound antenna element."
1690 RETURN
1700 :REM'
1710 :REM'PRT
1720 KEY OFF:GOSUB 1790:LOCATE 25,5:COLOR 0,2
1730 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1740 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1750 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1750 :ELSE GOSUB 1790
1760 IF Z$="3"THEN RETURN
1770 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1780 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1720
1790 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
