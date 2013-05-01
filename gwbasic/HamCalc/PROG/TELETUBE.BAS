10 :REM'TELETUBE - Telescoping Aluminum Tubing - 20 JAN 94 rev. 12 NOV 97
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$
40 CLS:KEY OFF
50 COLOR 7,0,1
60 UL$=STRING$(80,205)
70 PI=3.1415929794311523!
80 DIM T(14,5)
90 R1=0.0625!                                    :REM'base radius
100 FOR Z=1 TO 14                               :REM'14 stock diameters
110 R1=R1+0.0625!                                 :REM'radius increment
120 T(Z,1)=2*R1                                 :REM'O.D.
130 T(Z,2)=0.057999998331069946!                                 :REM'wall thickness
140 T(Z,3)=17                                   :REM'Stub's gauge #
150 R2=R1-T(Z,2)                                :REM'inside radius
160 T(Z,4)=2*R2                                 :REM'I.D.
170 W=((PI*R1^2)-(PI*R2^2))*12*0.09799999743700027!             :REM'lbs. per foot
180 T(Z,5)=W
190 NEXT Z
200 :REM'
210 :REM'.....start
220 CLS
230 COLOR 15,2
240 PRINT " TELESCOPING ALUMINUM TUBING ANTENNA ELEMENTS";
250 PRINT TAB(57);"by George Murphy VE3ERP ";
260 COLOR 1,0:PRINT STRING$(80,223);
270 COLOR 7,0
280 PRINT " Press number in < > to select:"
290 PRINT UL$;
300 PRINT "  < 1 >  DISPLAY table of standard tubing sizes"
310 PRINT "  < 2 >  Construction details - typical YAGI element"
320 PRINT "  < 3 >  Convert one-piece YAGI element to tapered sections"
330 PRINT UL$;
340 PRINT "  < 0 >  EXIT"
350 Z$=INKEY$
360 IF Z$="0"THEN CLS:RUN EX$
370 IF Z$="1"THEN 420
380 IF Z$="2"THEN 750
390 IF Z$="3"THEN CLS:CHAIN"yagtaper"
400 GOTO 350
410 :REM'
420 :REM'.....tubing table
430 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
440 PRINT " STANDARD TELESCOPING TUBING SIZES "
450 PRINT " Alloy #6061-T6 Round Aluminum Tube in standard 12 ft. lengths."
460 PRINT UL$;
470 PRINT TAB(4);"O.D.";TAB(12);"I.D.";TAB(20);"Wall";
480 PRINT TAB(28);"Gauge";TAB(40);"Weight"
490 PRINT UL$;
500 FOR Z=1 TO 14
510 D=8                                :REM'denominator
520 Y=INT(T(Z,1)):Y$=STR$(Y)           :REM'integer inches
530 Y$=Y$+" ":IF Y=0 THEN Y$="   "     :REM'integer inches
540 X=(T(Z,1)-Y)*8                     :REM'fractional part
550 D1=D
560 IF X=0 THEN 610
570 IF X/2<>INT(X/2)THEN 590
580 D1=D1/2:X=X/2:GOTO 570
590 X$=RIGHT$(STR$(X),1)
600 D$=RIGHT$(STR$(D1),1)+CHR$(34)
610 PRINT Y$;
620 IF X=0 THEN PRINT CHR$(34);:GOTO 640
630 PRINT X$;"/";D$;                                            :REM'O.D.
640 PRINT TAB(11);USING "#.###";T(Z,4);:PRINT CHR$(34);         :REM'I.D.
650 PRINT TAB(20);".058"+CHR$(34);                              :REM'wall
660 PRINT TAB(29);"#17";                                        :REM'gauge
670 PRINT TAB(37);USING "#.###";T(Z,5);:PRINT " lb./ft."
680 NEXT Z
690 PRINT UL$;
700 PRINT " Note: Each of the above sizes fits snugly inside the next larger ";
710 PRINT "size."
720 GOSUB 1700
730 GOTO 210   :REM'start
740 :REM'
750 :REM'.....design elements
760 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
770 PRINT " Do you want (l)ight, (m)edium, or (h)eavy construction?  (l/m/h)"
780 Z$=INKEY$:IF Z$=""THEN 780        :REM'base tubing size
790 IF Z$="l"THEN BT=0.375!:GOTO 830
800 IF Z$="m"THEN BT=0.625!:GOTO 830
810 IF Z$="h"THEN BT=0.875!:GOTO 830
820 GOTO 780
830 INPUT " ENTER: Total overall length of element, in inches.....";EL
840 IF EL>72 THEN 910
850 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 13,4:BEEP
860 PRINT "ELEMENTS 72";CHR$(34);" LONG OR LESS CAN BE MADE FROM A SINGLE ";
870 PRINT "LENGTH OF 3/4";CHR$(34);" TUBING."
880 GOSUB 1700
890 GOTO 210   :REM'start
900 :REM'
910 TOT=0:WGT=0
920 N=1        :REM'default value
930 N=N+2:D=EL/N:IF D<=66 THEN 950
940 GOTO 930
950 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
960 PRINT TAB(16);"┌─────── Exposed Length ───────┐";
970 PRINT TAB(55);"Size";TAB(68);"Weight (lbs.)";
980 PRINT UL$;
990 TU=(N-1)/2+1            :REM'number of tubing sizes
1000 :REM'BT=.625                 'base tube size
1010 CS=72                   :REM'centre section
1020 MS=66                   :REM'intermediate section
1030 ES=(EL-CS-(N-3)*MS)/2   :REM'end section
1040 IF ES<=0 THEN N=N-2:D=EL/N:GOTO 990
1050 :REM'
1060 LN=CSRLIN:LOCATE 3:PRINT N;"sections":LOCATE LN
1070 PRINT" 1 centre sect. @ 72";CHR$(34);TAB(40);USING "####.#";CS;
1080 PRINT CHR$(34);
1090 PRINT TAB(50);USING "#.###";BT+0.125!*TU;:PRINT CHR$(34);" dia.tubing";
1100  FOR Y=1 TO 14
1110   IF T(Y,1)=BT+0.125!*TU THEN 1130
1120  NEXT Y
1130 W=T(Y,5)*6:WGT=WGT+W
1140 PRINT TAB(71);USING "##.##";W
1150 TOT=TOT+CS
1160 :REM'
1170 IF N=3 THEN 1300
1180 FOR Z=1 TO (N-3)/2
1190  PRINT " 2 mid sections @";STR$(MS);CHR$(34);" (1 each side)";
1200  PRINT TAB(40);USING"####.#";2*MS;:PRINT CHR$(34);
1210 PRINT TAB(50);USING "#.###";BT+0.125!*(TU-Z);:PRINT CHR$(34);" dia.tubing";
1220  FOR Y=1 TO 14
1230   IF T(Y,1)=BT+0.125!*(TU-Z) THEN 1250
1240  NEXT Y
1250 W=T(Y,5)*6*2:WGT=WGT+W
1260 PRINT TAB(71);USING "##.##";W
1270  TOT=TOT+2*MS
1280 NEXT Z
1290 :REM'
1300 E$=STR$(INT(ES*100)/100)
1310 PRINT" 2 end sections projecting";E$;CHR$(34);" each";
1320 PRINT ;TAB(40);USING "####.#";2*ES;
1330 PRINT CHR$(34);
1340 PRINT TAB(50);USING "#.###";BT+0.125!;:PRINT CHR$(34);" dia.tubing";
1350  FOR Y=1 TO 14
1360   IF T(Y,1)=BT+0.125! THEN 1380
1370  NEXT Y
1380 W=T(Y,5)*(ES+12)/12*2:WGT=WGT+W
1390 PRINT TAB(71);USING "##.##";W
1400 TOT=TOT+2*ES
1410 PRINT TAB(39);"────────";TAB(69);"────────"
1420 PRINT " Overall length of element";
1430 PRINT TAB(40);USING "####.#";TOT;:PRINT CHR$(34);"  (";
1440 PRINT USING "###.##";TOT/12;:PRINT " ft.)";
1450 PRINT TAB(71);USING "##.#";WGT
1460 PRINT UL$;
1470 PRINT TAB(7);
1480 PRINT "All tubing is .058";CHR$(34);" wall #6061-T6 round aluminum tubing";
1490 PRINT " available in"
1500 PRINT TAB(7);
1510 PRINT "standard 12 foot lengths."
1520 PRINT
1530 PRINT TAB(7);
1540 PRINT "All tubing sections, except end sections, are 72 inches long,"
1550 PRINT TAB(7);
1560 PRINT "(standard 12' length cut in half)."
1570 PRINT
1580 IF N=3 THEN 1640
1590 PRINT TAB(7);
1600 PRINT "Mid sections are 72 inches long with 6 inches inserted into end of"
1610 PRINT TAB(7);
1620 PRINT "adjacent tube, leaving 66 inches projecting."
1630 PRINT
1640 PRINT TAB(7);
1650 PRINT "End sections should be cut about 8 to 12 inches longer than the "
1660 PRINT TAB(7);
1670 PRINT "projecting dimension shown to allow for final tuning adjustments."
1680 GOSUB 1710
1690 GOTO 210   :REM'start
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
