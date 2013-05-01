10 :REM'TINYCOIL - Coils Wound on Nylon Screws - 07 JUN 96 rev. 15 JAN 03
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 U$="#####.###"
60 PI=4*ATN(1)
70 UL$=STRING$(80,205)
80 DIM GA(40)
90 DIM T$(9,4)
100 :REM'
110 DATA #8,32,.164,.1437,    #10,24,.19,.1629,  1/4,20,.25,.2175
120 DATA 5/16,18,.3125,.2764, 3/8,16,.375,.3344, 1/2,13,.5,.45
130 DATA 5/8,11,.625,.566,    3/4,10,.75,.6850,  1,8,1,.9188
140 FOR Z=1 TO 9:FOR Y=1 TO 4:READ T$(Z,Y):NEXT Y:NEXT Z
150 :REM'
160 :REM'.....AWG calculator
170 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
180 FOR Z=1 TO 40
190 N=Z+3
200 GA(Z)=0.46000000834465027!/K^N
210 NEXT Z
220 :REM'
230 :REM'.....start
240 CLS
250 COLOR 15,2
260 PRINT " TINY COILS ";
270 PRINT TAB(57)"by George Murphy VE3ERP ";
280 COLOR 1,0:PRINT STRING$(80,223);
290 COLOR 7,0
300 GOSUB 1470   :REM'preface
310 COLOR 0,7:LOCATE ,22
320 PRINT " Press 1 to continue or 0 to EXIT....."
330 COLOR 7,0
340 Z$=INKEY$:IF Z$=""THEN 340
350 IF Z$="0"THEN CLS:CHAIN EX$
360 IF Z$="1"THEN 460
370 GOTO 30
380 GOTO 460
390 :REM'
400 :REM'.....format input line
410 IF ZZ=AWG THEN X$="#####":ELSE X$=U$
420 LOCATE CSRLIN-1:PRINT SPC(7);
430 LOCATE CSRLIN,47:PRINT STRING$(6,".");USING X$;ZZ;
440 RETURN
450 :REM'
460 :REM'.....input data
470 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
480 INPUT " ENTER: Wire gauge (range #14 to #26 AWG).......(AWG)";AWG
490 IF AWG<14 OR AWG>26 THEN BEEP:GOTO 470
500 ZZ=AWG:GOSUB 400:PRINT " AWG bare wire"
510 WD=GA(AWG)
520 W$="        Wire diameter...............................    #.###"
530 W$=W$+CHR$(34)+" (AWG ##":PRINT USING W$;WD,AWG;:PRINT ")"
540  FOR Z=1 TO 9
550  T=VAL(T$(Z,2))     :REM'threads per inch
560  P=1/T              :REM'pitch
570  IF WD/P>=0.46000000834465027! AND WD/P<=0.6000000238418579! THEN 690
580 NEXT Z
590 IF WD/P>0.6000000238418579! THEN 610
600 IF WD/P<0.46000000834465027! THEN 650
610 PRINT " WIRE TOO LARGE to fit small screw threads.....Press any key....."
620 IF INKEY$=""THEN 620
630 GOTO 460
640 :REM'
650 PRINT " WIRE TOO SMALL for screw thread spacing.....Press any key....."
660 IF INKEY$=""THEN 660
670 GOTO 460
680 :REM'
690  OD=VAL(T$(Z,3))
700 PRINT "        Coil form - machine screw thread............";USING U$;OD;
710 PRINT CHR$(34);" (";T$(Z,1);"-";T$(Z,2);" thread)"
720 U1$="#####"
730 PRINT "        Turns per inch..............................";USING U1$;T
740 PRINT "        Pitch (i.e. turn spacing c.c.)..............";USING U$;P;
750 PRINT CHR$(34)
760 GAP=P-WD
770 PRINT "        Gap between turns...........................";USING U$;GAP;
780 PRINT CHR$(34)
790  DP=WD/P
800 PRINT "        Wire diameter-to-pitch ratio................";USING U$;DP;
810 PRINT ":1"
820  R0=VAL(T$(Z,4))/2
830  R1=WD/2
840  S1=TAN(30*PI/180)*P/4
850  S2=S1*2:S3=R1-S2:S4=S3*2
860  R3=R0+S1+S4
870  D=R3*2
880 PRINT "        Coil pitch diameter.........................";USING U$;D;
890 PRINT CHR$(34)
900 PRINT :LN=CSRLIN:LOCATE ,8:COLOR 0,7
910 PRINT " Want to estimate approximate length and number of turns?  (y/n)"
920 COLOR 7,0
930 Z$=INKEY$:IF Z$=""THEN 930
940  IF Z$="n"OR Z$="y"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
950  IF Z$="n"THEN 1660
960  IF Z$="y"THEN 980
970 GOTO 930
980 INPUT " ENTER: Inductance..............................(µH)";UH
990 ZZ=UH:GOSUB 400:PRINT " µH"
1000  R=D/2          :REM'D=coil pitch diameter
1010  K1=R^2*T^2/UH  :REM'T=turns per inch   UH=inductance in uH
1020  K2=10+SQR(100+36*R*K1)
1030  L=K2/2/K1
1040 PRINT "        Coil length.................................";USING U$;L;
1050 PRINT CHR$(34)
1060 N=L/P
1070 PRINT "        Number of turns.............................";USING U$;N;
1080  LD=L/D
1090 PRINT "        Coil length-to-diameter ratio...............";
1100  IF LD>4 THEN COLOR 14,6
1110 PRINT USING "#####.##:1 ";LD
1120 COLOR 7,0
1130  AMT=PI*D*N
1140 PRINT "        Amount of wire in coil (excluding leads)....";USING X$;AMT;
1150 PRINT CHR$(34)
1160 PRINT
1170 IF LD>4 THEN GOSUB 1290:GOTO 1200
1180 IF LD<0.4000000059604645! THEN GOSUB 1400:GOTO 1200
1190 :REM'
1200 PRINT :LOCATE ,8:COLOR 0,7
1210 PRINT " Want to change inductance?   (y/n)":COLOR 7,0
1220 Z$=INKEY$:IF Z$=""THEN 1220
1230 IF Z$="n"THEN 1260
1240 IF Z$="y"THEN 1270
1250 GOTO 1220
1260 VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 1660
1270 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 980
1280 :REM'
1290 COLOR 14,0:PRINT TAB(M);
1300 PRINT "Many amateur radio applications require a length-to-diameter ratio"
1310 PRINT TAB(M);
1320 PRINT "of about 4:1 or less. If the ratio shown above is more than 4:1"
1330 PRINT TAB(M);
1340 PRINT "you might want to try again, selecting a larger wire size or a"
1350 PRINT TAB(M);
1360 PRINT "smaller inductance."
1370 COLOR 7,0
1380 RETURN
1390 :REM'
1400 COLOR 14:PRINT TAB(M);
1410 PRINT "Length-to-diameter ratio should be 0.4:1 or greater. Try again,"
1420 PRINT TAB(M);
1430 PRINT "using a smaller wire size or larger inductance."
1440 COLOR 7,0
1450 RETURN
1460 :REM'
1470 :REM'.....preface
1480 M=7
1490 PRINT TAB(M);
1500 PRINT "Machine screws are excellent small coil winding mandrels, providing"
1510 PRINT TAB(M);
1520 PRINT "automatic turn spacing for those of us who are all thumbs and fuzzy"
1530 PRINT TAB(M);
1540 PRINT "vision when it comes to winding tiny coils."
1550 PRINT
1560 PRINT TAB(M);
1570 PRINT "Wind the coil in the grooves of the screw thread and wrap the coil"
1580 PRINT TAB(M);
1590 PRINT "in a couple of layers of transparent library tape before unscrewing"
1600 PRINT TAB(M);
1610 PRINT "the form from the coil."
1620 PRINT TAB(M);
1630 PRINT
1640 RETURN
1650 :REM'
1660 :REM'.....end
1670 GOSUB 1700
1680 GOTO 230
1690 :REM'
1700 :REM'PRT
1710 KEY OFF:GOSUB 1780:LOCATE 25,5:COLOR 0,2
1720 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1730 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1740 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1740 :ELSE GOSUB 1780
1750 IF Z$="3"THEN RETURN
1760 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1770 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1710
1780 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
