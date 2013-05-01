10 :REM'YAGISPAC - Yagi Element Spacing - 27 MAR 96 rev.13 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 U$="####.###"
60 UL$=STRING$(80,205)
70 DIM B(6,3)
80 :REM'
90 DATA .4,7.1,3,  .8,9.2,5,  1.2,10.2,6,  2.2,12.25,12,  3.2,13.4,17
100 DATA 4.2,14.2,15
110 FOR Z=1 TO 6:FOR Y=1 TO 3:READ B(Z,Y):NEXT Y:NEXT Z
120 GOTO 190
130 :REM'
140 :REM'.....format input line
150 LOCATE CSRLIN-1:PRINT SPC(7);
160 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;ZZ;
170 RETURN
180 :REM'
190 :REM'.....start
200 CLS
210 COLOR 15,2
220 PRINT " YAGI ELEMENT SPACING (VHF/UHF)";TAB(57)"by George Murphy VE3ERP ";
230 COLOR 1,0:PRINT STRING$(80,223);
240 COLOR 7,0
250 GOSUB 1380            :REM'preface
260 COLOR 0,7
270 PRINT
280 LOCATE ,22:PRINT " Press 1 to continue or 0 to quit....";
290 COLOR 7,0
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="0"THEN CLS:RUN EX$
320 IF Z$="1"THEN 350
330 GOTO 300
340 :REM'
350 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
360 PRINT "        U.S.A. NATIONAL BUREAU of STANDARDS RECOMMENDED DIMENSIONS:"
370 PRINT UL$;
380 INPUT " ENTER: Centre frequency of band of interest....(Mhz)";CF
390 ZZ=CF:GOSUB 140:PRINT " MHz"
400 WL=300/CF
410 PRINT "        Wavelength...................................";USING U$;WL;
420 PRINT " metres"
430 PRINT UL$;
440 PRINT " Press number in ( ) to select antenna:"
450 PRINT UL$;
460 PRINT TAB(11)"GAIN";TAB(30)"B O O M   L E N G T H"
470    FOR Z=1 TO 6
480 DB=B(Z,2)
490 LM=B(Z,1)*WL:LF=LM/0.30480000376701355!
500 EL=B(Z,3)
510 PRINT " (";Z;")";TAB(7);USING "####.##";DB;
520 PRINT " dB";USING "######.###";LM;
530 PRINT " m.(";USING "###.###";LF;
540 PRINT " ft.) with";USING "###";EL;
550 PRINT " elements"
560    NEXT Z
570 :REM'
580 Z$=INKEY$:IF Z$=""THEN 580
590 Z=VAL(Z$)
600 IF Z>=1 AND Z<=6 THEN 610 :ELSE 580
610 VIEW PRINT 7 TO 24:CLS:VIEW PRINT:LOCATE 7
620 PRINT "        Number of elements...........................";
630 PRINT USING "####";B(Z,3)
640 PRINT "        Boom distance from first to last element.....";
650 PRINT USING "####.##";B(Z,1);:PRINT " x wavelength"
660 PRINT "        Gain.........................................";
670 PRINT USING "####.##";B(Z,2);:PRINT " dB"
680 PRINT UL$;
690 X=B(Z,1)             :REM'multiplier
700 DB=B(Z,2)            :REM'gain
710 EL=B(Z,3)            :REM'number of elements
720 LM=X*WL:LF=LM/0.30480000376701355!  :REM'boom length
730 A=0.20000000298023224!*WL              :REM'reflector spacing in m.
740 B=(LM-A)/(EL-2)      :REM'all other element spacings
750 R=11:C=37-EL*2
760 GOSUB 950
770 FOR J=1 TO EL-3:GOSUB 1090:NEXT J
780 GOSUB 1230
790 COLOR 7,0
800 C=C+5:LOCATE R+1
810 LOCATE ,C:PRINT "R = Reflector"
820 LOCATE ,C:PRINT "D = Driven Element"
830 LOCATE ,C:PRINT "d = Directors (";EL-2;")"
840 LOCATE ,C:PRINT "R to last d =";USING "###.###";LM;
850 PRINT " m.=";USING "###.###";LF;
860 PRINT " ft."
870 LOCATE ,C:PRINT "A =";SPC(11);USING "##.###";A;:PRINT " m.=";
880 PRINT USING "###.###";A/0.30480000376701355!;:PRINT " ft."
890 LOCATE ,C:PRINT "B =";SPC(11);USING "##.###";B;:PRINT " m.=";
900 PRINT USING "###.###";B/0.30480000376701355!;:PRINT " ft."
910 PRINT
920 GOSUB 1480
930 GOTO 1620
940 :REM'
950 :REM'.....diagram 1
960 COLOR 0,7
970 LOCATE R
980 LOCATE ,C:PRINT "    "
990 LOCATE ,C:PRINT " R D"
1000 LOCATE ,C:PRINT " │ ║"
1010 LOCATE ,C:PRINT " │ ║"
1020 LOCATE ,C:PRINT " ╪═╬"
1030 LOCATE ,C:PRINT " │A║"
1040 LOCATE ,C:PRINT " │ ║"
1050 LOCATE ,C:PRINT "    "
1060 COLOR 7,0
1070 C=C+2
1080 RETURN
1090 :REM'.....diagram 2
1100 COLOR 0,7
1110 LOCATE R
1120 C=C+2
1130 LOCATE ,C:PRINT "  "
1140 LOCATE ,C:PRINT " d"
1150 LOCATE ,C:PRINT " │"
1160 LOCATE ,C:PRINT " │"
1170 LOCATE ,C:PRINT "═╪"
1180 LOCATE ,C:PRINT " │"
1190 LOCATE ,C:PRINT "B│"
1200 LOCATE ,C:PRINT "  "
1210 COLOR 7,0
1220 RETURN
1230 :REM'.....diagram 3
1240 COLOR 0,7
1250 LOCATE R
1260 C=C+2
1270 LOCATE ,C:PRINT "   "
1280 LOCATE ,C:PRINT " d "
1290 LOCATE ,C:PRINT " │ "
1300 LOCATE ,C:PRINT " │ "
1310 LOCATE ,C:PRINT "═╪ "
1320 LOCATE ,C:PRINT " │ "
1330 LOCATE ,C:PRINT "B│ "
1340 LOCATE ,C:PRINT "   "
1350 COLOR 7,0
1360 RETURN
1370 :REM'
1380 :REM'.....preface
1390 T=7
1400 PRINT TAB(T);
1410 PRINT "This program computes element spacings and boom lengths developed"
1420 PRINT TAB(T);
1430 PRINT "by the U.S.A. National Bureau of Standards (NBS) for optimum VHF"
1440 PRINT TAB(T);
1450 PRINT "and UHF Yagi-antenna performance."
1460 RETURN
1470 :REM'
1480 :REM'.....element note
1490 T=7
1500 PRINT TAB(T);
1510 PRINT "Absolute element lengths are dependent upon the element diameter,"
1520 PRINT TAB(T);
1530 PRINT "placement on boom, whether or not the elements are insulated from"
1540 PRINT TAB(T);
1550 PRINT "the boom and whether element diameters are constant or tapered."
1560 PRINT TAB(T);
1570 PRINT "Additional design data are available in the ARRL ANTENNA BOOK and"
1580 PRINT TAB(T);
1590 PRINT "the ARRL ELECTRONICS DATA BOOK, 2nd Edition, pages 7-09 to 7-11."
1600 RETURN
1610 :REM'
1620 :REM'.....end
1630 GOSUB 1670
1640 GOTO 190
1650 END
1660 :REM'
1670 :REM'.....PRT
1680 KEY OFF:GOSUB 1750:LOCATE 25,5:COLOR 0,2
1690 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1700 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1710 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1710 :ELSE GOSUB 1750
1720 IF Z$="3"THEN RETURN
1730 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1740 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1680
1750 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
