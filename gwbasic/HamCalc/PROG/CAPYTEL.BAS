10 :REM'CAPYTEL - CAPACITOR, Telescoping - 29 JAN 06 rev. 01 JAN 2008
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$,CC
50 CLS:KEY OFF
60 COLOR 7,0,0
70 PI=3.1415929794311523!
80 LF=1/LOG(10)  :REM'=.4343(Factor to covert natural log to log base 10)
90 U1$="####.###"
100 U2$="#########"
110 U3$="########"
120 UL$=STRING$(80,205)
130 X$=STRING$(80,32)
140 DIM P$(16,5)    :REM'pipe sizes
150 DIM T$(16,5)    :REM'tubing sizes
160 :REM'
170 DATA 1/4,.375,.128,    3/8,.5,.035,     1/2,.625,.04,     5/8,.75,.042
180 DATA 3/4,.875,.045,    1,1.125,.05,     1-1/4,1.375,.055, 1-1/2,1.625,.06
190 DATA 2,2.125,.07,      2-1/2,2.625,.08, 3,3.125,.09,      3-1/2,3.625,.1
200 DATA 4,4.125,.11,      5,5.125,.125,    6,6.125,.14,      8,8.125,.2
210 FOR X=1 TO 16:FOR Y=1 TO 3:READ P$(X,Y):NEXT Y:NEXT X
220 :REM'
230 DATA 1/4,.25,.058,     3/8,.375,.058,   1/2,.5,.058,      5/8,.625,.058
240 DATA 3/4,.75,.058,     7/8,.875,.058,   1,1,.058,         1-1/8,1.125,.058
250 DATA 1-1/4,1.25,.058,  1-3/8,1.375,.058,1-1/2,1.5,.058,   1-5/8,1.625,.058
260 DATA 1-3/4,1.75,.058,  1-7/8,1.875,.058,2,2,.065,         2-1/4,2.25,.065
270 FOR X=1 TO 16:FOR Y=1 TO 3:READ T$(X,Y):NEXT Y:NEXT X
280 GOTO 380
290 :REM'
300 VIEW PRINT 16 TO 24:CLS:VIEW PRINT:LOCATE 16
310 RETURN
320 :REM'
330 :REM'.....format display
340 LOCATE CSRLIN-1:PRINT SPC(7);
350 LOCATE CSRLIN,45:PRINT STRING$(5,".");USING U1$;ZZ;
360 RETURN
370 :REM'
380 :REM'.....start
390 CLS:M=0:C=0:OD=0:ID=0:D=0:A=0:L=0:BV=0:E=0:DIA=0:CF=0
400 COLOR 15,2
410 PRINT " CAPACITOR, Telescoping Variable";
420 PRINT TAB(57);"by George Murphy VE3ERP ";
430 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
440 GOSUB 1630     :REM'diagram
450 GOSUB 1820
460 PRINT
470 GOSUB 3370     :REM'text
480 :REM'
490 LOCATE 25,22:COLOR 0,7
500 PRINT " Press 1 to continue or 0 to EXIT.....";
510 COLOR 7,0
520 Z$=INKEY$:IF Z$=""THEN 520
530 IF Z$="0"THEN CLS:CHAIN GO$
540 IF Z$="1"THEN 560
550 GOTO 520
560 GOSUB 300
570 :REM'
580 LOCATE CSRLIN-1:PRINT X$;
590 PRINT TAB(7);
600 PRINT "Do you want to enter dimensions in (c)entimetres or (i)nches?  (c/i)"
610 Z$=INKEY$:IF Z$=""THEN 610
620 IF Z$="c"THEN D$="CENTIMETRES":M$="cm.":M=2.5399999618530273!:GOTO 650
630 IF Z$="i"THEN D$="INCHES":M$="in.":M=1:GOTO 650
640 GOTO 610
650 GOSUB 300
660 :REM'
670 IF VC THEN E=VC*10^3:GOTO 700
680 INPUT " ENTER: Max. voltage potential between elements (0 if don't care) ";E
690 IF E=0 THEN 780
700 AIR=E/21/10^3
710 GOSUB 300
720 LOCATE 16,8:COLOR 0,7
730 PRINT " Air gap between elements must be at least";
740 PRINT USING "##.###";AIR*M;:PRINT " ";M$;" @";E;"volts "
750 COLOR 7,0:PRINT
760 PRINT TAB(26);"Press any key to continue....."
770 IF INKEY$=""THEN 770
780 GOSUB 300
790 :REM'
800 PRINT
810 :REM'LN=CSRLIN:FOR J=1 TO 2:LOCATE J:PRINT X$;:NEXT J:LOCATE LN
820 PRINT " Press number in ( ) to:"
830 IF ID*OD*CC<>0 THEN C=CC:Z$="1":GOTO 930
840 IF VC OR CC THEN 880
850 PRINT "   (1) Specify capacitance and find overlap"
860 PRINT "   (2) Specify overlap and find capacitance"
870 IF ID*OD<>0 THEN 910
880 PRINT "   (3) Select standard Type L Hard copper pipe sizes for elements"
890 PRINT "   (4) Select standard aluminum tubing sizes for elements"
900 PRINT "   (0) Quit or start over"
910 Z$=INKEY$:IF Z$=""THEN 910
920 IF CC THEN 950
930 IF Z$="1"THEN GOSUB 300:GOTO 1070
940 IF Z$="2"THEN GOSUB 300:GOTO 1020
950 IF ID*OD<>0 THEN 990
960 IF Z$="3"THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 1880
970 IF Z$="4"THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 2620
980 IF Z$="0"THEN 380
990 GOTO 910
1000 :REM'
1010 :REM'.....input data
1020 PRINT " ENTER: Length of element overlap...........(";M$;")";:INPUT L
1030 L=L/M
1040 ZZ=L:GOSUB 330:PRINT " in. =";USING U1$;L*2.5399999618530273!;:PRINT " cm."
1050 GOSUB 1270:GOTO 1120
1060 :REM'
1070 IF C<>0 THEN 1100
1080 INPUT " ENTER: Desired capacitance..................(pF)";C
1090 ZZ=C:GOSUB 330:PRINT " pF"
1100 GOSUB 1270
1110 :REM'
1120 IF OD=0 THEN 1140
1130 PRINT "        Inner element Outside Diameter......(";M$;")";:GOTO 1150
1140 PRINT " ENTER: Inner element Outside Diameter......(";M$;")";:INPUT OD
1150 OD=OD/M
1160 ZZ=OD:GOSUB 330:PRINT " in. =";USING U1$;OD*2.5399999618530273!;:PRINT " cm."
1170 GOSUB 1270
1180 :REM'
1190 IF ID=0 THEN 1210
1200 PRINT "        Outer element Inside Diameter.......(";M$;")";:GOTO 1220
1210 PRINT " ENTER: Outer element Inside Diameter.......(";M$;")";:INPUT ID
1220 ID=ID/M
1230 ZZ=ID:GOSUB 330:PRINT " in. =";USING U1$;ID*2.5399999618530273!;:PRINT " cm."
1240 GOSUB 1270
1250 GOTO 380
1260 :REM'
1270 :REM'.....calculation
1280 IF C=0 AND ID*OD*L>0 THEN C=7.354000091552734!/(LOG(ID/OD)*LF)*L/12:GOTO 1270
1290 IF L=0 AND ID*OD*C>0 THEN L=12*C/(7.354000091552734!/(LOG(ID/OD)*LF)):GOTO 1270
1300 IF D=0 AND ID*OD>0   THEN D=(ID-OD)/2:GOTO 1270     :REM'air gap
1310 IF C*D*ID*OD*L THEN 1350
1320 RETURN
1330 :REM'
1340 MV=21   :REM'mils per volt for air dielectric
1350 BV=MV*D*10^3    :REM'breakdown voltage
1360 GOSUB 300:IF SM$=""THEN 1380
1370 LOCATE ,7:COLOR 7,0:PRINT " "+NAM$+":":COLOR 7,0
1380 PRINT "        Capacitance..............................";USING U1$;C;
1390 PRINT " pF"
1400 PRINT "        Length of element overlap................";USING U1$;L;
1410 PRINT " in. =";USING U1$;L*2.5399999618530273!;:PRINT " cm."
1420 PRINT "        Calibration of travel........each 10 pF =";USING U1$;L/C*10;
1430 PRINT " in. =";USING U1$;L/C*10*2.5399999618530273!;:PRINT " cm."
1440 PRINT SM$;:LOCATE CSRLIN,9
1450 PRINT "INNER element OUTSIDE Diameter...........";USING U1$;OD;
1460 PRINT " in. =";USING U1$;OD*2.5399999618530273!;:PRINT " cm."
1470 PRINT LG$;:LOCATE CSRLIN,9
1480 PRINT "OUTER element INSIDE Diameter............";USING U1$;ID;
1490 PRINT " in. =";USING U1$;ID*2.5399999618530273!;:PRINT " cm."
1500 PRINT "        Air space between element surfaces.......";USING U1$;D;
1510 PRINT " in. =";USING U1$;D*2.5399999618530273!;:PRINT " cm."
1520 PRINT "        Approximate breakdown voltage............";USING U3$;BV;
1530 PRINT " v.";
1540 IF SM$=""THEN 1580
1550 LOCATE 15,2:PRINT "Nom."
1560 LOCATE 16,2:PRINT "Size"
1570 :REM'
1580 :REM'.....end
1590 GOSUB 3520
1600 GOTO 380
1610 END
1620 :REM'
1630 :REM'.....diagram
1640 COLOR 0,7
1650 T=13
1660 LOCATE ,T:PRINT "                                                       "
1670 LOCATE ,T:PRINT "  insulating caps fastened to outer element ─┐         "
1680 LOCATE ,T:PRINT "                                             │         "
1690 LOCATE ,T:PRINT "           │«───────── overlap ─────────»│   │         "
1700 LOCATE ,T:PRINT "  ┌┐       │    determines capacitance   ┌┐  │         "
1710 LOCATE ,T:PRINT "  │╘╤═════╤╤════════════════════════════╤╛│«─┘         "
1720 LOCATE ,T:PRINT "  │ │     │╘╤═══════════════════════════╧═╧═════════╕  "
1730 LOCATE ,T:PRINT "  │ │  ┌─»│ │      «─ sliding inner element ─»      │  "
1740 LOCATE ,T:PRINT "  │ │  │  │╒╧═══════════════════════════╤═╤═════════╛  "
1750 LOCATE ,T:PRINT "  │╒╧══╪══╧╧════════════════════════════╧╕│            "
1760 LOCATE ,T:PRINT "  └┘   │                                 └┘            "
1770 LOCATE ,T:PRINT "       └─ sliding insulator fastened to inner element  "
1780 LOCATE ,T:PRINT "                                                       "
1790 COLOR 7,0
1800 RETURN
1810 :REM'
1820 COLOR 7,1
1830 LOCATE ,T:PRINT "       Program suggested by Harold Kane, W2AHW         "
1840 LOCATE ,T:PRINT "       (ref. F.E.Terman Handbook, 1943, p.119)         "
1850 COLOR 7,0
1860 RETURN
1870 :REM'
1880 :REM'.....pipe sizes
1890 INC=1     :REM'increment between inner and outer pipe sizes
1900 :REM'
1910 CLS
1920 IF INC=1 THEN INC$=" VOLTAGE RATINGS"
1930 IF INC=-1 THEN INC$=" CAPACITANCES"
1940 NAM$="American standard Type L Hard copper pipe"
1950 PRINT TAB(17)NAM$
1960 PRINT
1970 PRINT TAB(17)"All decimal dimensions below are in ";D$
1980 PRINT UL$;
1990 LOCATE CSRLIN-1,39:PRINT "╤"
2000 LOCATE CSRLIN-1,49:PRINT "╤"
2010 LOCATE CSRLIN-1,58:PRINT "╤"
2020 LOCATE CSRLIN-1,69:PRINT "╤"
2030 PRINT TAB(7)"Nominal";TAB(39)"│fits into";TAB(49)"│with air";
2040 PRINT TAB(58)"│ Overlap ";TAB(69)"│ Maximum";
2050 PRINT TAB(8)"size";TAB(18)"O.D.";TAB(26)"Wall";TAB(34)"I.D.";
2060 PRINT TAB(39)"│pipe size";TAB(49)"│ gap of";TAB(58)"│pF per ";M$;
2070 PRINT TAB(69)"│  Volts"
2080 PRINT UL$;
2090 LOCATE CSRLIN-1,39:PRINT "╧"
2100 LOCATE CSRLIN-1,49:PRINT "╧"
2110 LOCATE CSRLIN-1,58:PRINT "╧"
2120 LOCATE CSRLIN-1,69:PRINT "╧"
2130 :REM'
2140   FOR Z=1 TO 14
2150 IF INC=1  THEN K=Z       :REM'increment between pipe sizes
2160 IF INC=-1 THEN K=Z+1     :REM'increment between pipe sizes
2170 Z$=P$(Z,1):OD=VAL(P$(Z,2)):WAL=VAL(P$(Z,3))
2180 ID=OD-2*WAL
2190 IF (INC=-1 AND Z>=13)OR(INC=1 AND Z=14)THEN 2210
2200 PRINT TAB(2)"(";CHR$(96+Z);")";
2210 PRINT TAB(8)Z$;CHR$(34);
2220 PRINT TAB(14)USING U1$;OD*M;
2230 PRINT USING U1$;WAL*M;
2240 PRINT USING U1$;ID*M;
2250 IF(INC=1 AND Z=14)OR(INC=-1 AND Z>=13)THEN 2360
2260   FOR Y=Z+1 TO 15
2270     J=VAL(P$(Y,2))-2*VAL(P$(Y,3))
2280     IF J>VAL(P$(K,2)) THEN 2300
2290   NEXT Y
2300 P$(Z,4)=STR$(J)
2310 P$(Z,5)=P$(Y,1)
2320 GAP=(J-OD)/2
2330 PRINT TAB(42)P$(Y,1);CHR$(34);TAB(49)USING U1$;GAP*M;
2340 CI=7.354000091552734!/(LOG(J/OD)*LF)/12  :REM'capacity per inch
2350 PRINT " ";USING U1$;CI/M;:PRINT " pF";USING U3$;GAP*21*10^3
2360   NEXT Z
2370 :REM'
2380 PRINT TAB(2)"(";CHR$(96+Z);") List pipe combinations with HIGHER";INC$
2390 PRINT TAB(2)"(";CHR$(97+Z);") RETURN TO MENU"
2400 IF E=0 THEN 2440    :REM'breakdown voltage
2410 COLOR 15,1:LOCATE 24,15:PRINT " Note: Minimum air gap for";E;"volts is";
2420 PRINT USING "##.###";AIR*M;:PRINT M$;
2430 :REM'
2440 COLOR 0,7:LOCATE 25,15
2450 PRINT " Press a letter in ( ) to choose one of the above...";
2460 COLOR 7,0
2470 Z$=INKEY$:IF Z$=""THEN 2470
2480 IF ASC(Z$)<97 OR ASC(Z$)>112 THEN 2470
2490 IF Z$="m"THEN 2470
2500 IF Z$="l"AND INC=-1 THEN 2470
2510 Z=ASC(Z$)-96
2520 OD=VAL(P$(Z,2)):ID=VAL(P$(Z,4))
2530 SM$=" "+P$(Z,1)+CHR$(34)
2540 LG$=" "+P$(Z,5)+CHR$(34)
2550 IF Z=15 THEN INC=INC*-1:GOTO 1910
2560 IF Z=16 THEN OD=0:ID=0    :REM'return to menu
2570 CLS:LOCATE 3
2580 GOSUB 1630  :REM'diagram
2590 GOTO 800
2600 END
2610 :REM'
2620 :REM'.....aluminum tubing
2630 INC=1     :REM'increment between inner and outer tube sizes
2640 :REM'
2650 CLS
2660 IF INC=1 THEN INC$=" VOLTAGE RATINGS"
2670 IF INC=-1 THEN INC$=" CAPACITANCES"
2680 NAM$="6061-T6(61S-T6) Round Aluminum Tube"
2690 NAM$=NAM$+" with .058"+CHR$(34)+" (#17 ga.) wall"
2700 PRINT " Standard Sizes of "+NAM$;
2710 PRINT " Order tube by O.D. and wall thickness (e.g. 1/2";CHR$(34);" x ";
2720 PRINT ".058";CHR$(34);" wall)."
2730 PRINT TAB(17)"All decimal dimensions below are in ";D$
2740 PRINT UL$;
2750 LOCATE CSRLIN-1,39:PRINT "╤"
2760 LOCATE CSRLIN-1,49:PRINT "╤"
2770 LOCATE CSRLIN-1,58:PRINT "╤"
2780 LOCATE CSRLIN-1,69:PRINT "╤"
2790 PRINT TAB(7)"Nominal";TAB(39)"│fits into";TAB(49)"│with air";
2800 PRINT TAB(58)"│ Overlap ";TAB(69)"│ Maximum";
2810 PRINT TAB(8)"size";TAB(18)"O.D.";TAB(26)"Wall";TAB(34)"I.D.";
2820 PRINT TAB(39)"│tube size";TAB(49)"│ gap of";TAB(58)"│  pF/";M$;
2830 PRINT TAB(69)"│  Volts"
2840 PRINT UL$;
2850 LOCATE CSRLIN-1,39:PRINT "╧"
2860 LOCATE CSRLIN-1,49:PRINT "╧"
2870 LOCATE CSRLIN-1,58:PRINT "╧"
2880 LOCATE CSRLIN-1,69:PRINT "╧"
2890 :REM'
2900   FOR Z=1 TO 14
2910 IF INC=1  THEN K=Z+1     :REM'increment between tube sizes
2920 IF INC=-1 THEN K=Z+2     :REM'increment between tube sizes
2930 Z$=T$(Z,1):OD=VAL(T$(Z,2)):WAL=VAL(T$(Z,3))
2940 ID=OD-2*WAL
2950 IF (INC=1 AND Z>12)OR(INC=-1 AND Z>11)THEN 2970
2960 PRINT TAB(2)"(";CHR$(96+Z);")";
2970 PRINT TAB(8)Z$;CHR$(34);
2980 PRINT TAB(14)USING U1$;OD*M;
2990 PRINT USING U1$;WAL*M;
3000 PRINT USING U1$;ID*M;
3010 IF INC=-1 AND Z>11 THEN 3130
3020 IF INC=1 AND Z>12 THEN 3130
3030   FOR Y=Z+1 TO 15
3040     J=VAL(T$(Y,2))-2*VAL(T$(Y,3))
3050     IF J>VAL(T$(K,2)) THEN 3070
3060   NEXT Y
3070 T$(Z,4)=STR$(J)
3080 T$(Z,5)=T$(Y,1)
3090 GAP=(J-OD)/2
3100 PRINT TAB(42)T$(Y,1);CHR$(34);TAB(49)USING U1$;GAP*M;
3110 CI=7.354000091552734!/(LOG(J/OD)*LF)/12  :REM'capacity per inch
3120 PRINT " ";USING U1$;CI/M;:PRINT " pF";USING U3$;GAP*21*10^3
3130   NEXT Z
3140 :REM'
3150 PRINT TAB(2)"(";CHR$(96+Z);") List tube combinations with HIGHER";INC$
3160 PRINT TAB(2)"(";CHR$(97+Z);") RETURN TO MENU"
3170 IF E=0 THEN 3210    :REM'breakdown voltage
3180 COLOR 15,1:LOCATE 24,15:PRINT " Note: Minimum air gap for";E;"volts is";
3190 PRINT USING "##.###";AIR*M;:PRINT M$;
3200 :REM'
3210 COLOR 0,7:LOCATE 25,15
3220 PRINT " Press a letter in ( ) to choose one of the above...";
3230 COLOR 7,0
3240 Z$=INKEY$:IF Z$=""THEN 3240
3250 IF ASC(Z$)<97 OR ASC(Z$)>112 THEN 3240
3260 Z=ASC(Z$)-96
3270 OD=VAL(T$(Z,2)):ID=VAL(T$(Z,4))
3280 SM$=" "+T$(Z,1)+CHR$(34)
3290 LG$=" "+T$(Z,5)+CHR$(34)
3300 IF Z=15 THEN INC=INC*-1:GOTO 2650
3310 IF Z=16 THEN OD=0:ID=0    :REM'return to menu
3320 CLS:LOCATE 3
3330 GOSUB 1630  :REM'diagram
3340 GOTO 800
3350 END
3360 :REM'
3370 :REM'.....text
3380 Q=7
3390 PRINT TAB(Q);
3400 PRINT "Variable capacitors can be constructed from two telescoping pieces"
3410 PRINT TAB(Q);
3420 PRINT"of metal pipe or tubing as shown in the diagram. Provide small holes"
3430 PRINT TAB(Q);
3440 PRINT "or slots in the end caps and sliding insulator for free passage of"
3450 PRINT TAB(Q);
3460 PRINT "air to prevent the assembly from becoming a pneumatic piston."
3470 PRINT
3480 PRINT TAB(Q);
3490 PRINT "Inner element actuation is left up to the builder's ingenuity.";
3500 RETURN
3510 :REM'
3520 :REM'PRT
3530 KEY OFF:GOSUB 3600:LOCATE 25,5:COLOR 0,2
3540 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3550 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3560 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3560 :ELSE GOSUB 3600
3570 IF Z$="3"THEN RETURN
3580 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3590 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3530
3600 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
