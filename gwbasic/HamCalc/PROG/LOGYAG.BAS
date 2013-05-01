10 :REM'LOGYAG   Log-Periodic Yagi Array - 03 MAR 95 rev. 06 FEB 1999
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$,PROG$,DIMN$,A,B,C
40 CLS:KEY OFF
50 COLOR 7,0,1
60 U1$="###.###"
70 U2$="##.###"
80 UL$=STRING$(80,205)
90 PI=4*ATN(1)
100 :REM'
110 :REM'.....start
120 CLS
130 COLOR 15,2
140 PRINT " LOG-YAG Log-Periodic Yagi Antenna";
150 PRINT TAB(57);"by George Murphy VE3ERP ";
160 COLOR 1,0:PRINT STRING$(80,223);
170 COLOR 7,0
180 :REM'GOSUB 1990      'standard antenna preface
190 PRINT UL$;
200 GOSUB 1750      :REM'notes
210 Z$=INKEY$:IF Z$=""THEN 210
220 IF Z$="0"THEN CLS:RUN EX$
230 IF Z$="1"THEN 260
240 GOTO 210
250 :REM'
260 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
270 PRINT " Press number in < > to choose standard units of measure:"
280 PRINT UL$;
290 PRINT "   < 1 >  Metric"
300 PRINT "   < 2 >  U.S.A./Imperial"
310 Z$=INKEY$
320 IF Z$="1"THEN UM=0.30480000376701355!:UM$="m":GOTO 350
330 IF Z$="2"THEN UM=1:UM$="'":GOTO 350
340 GOTO 310
350 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
360 GOTO 420
370 :REM'
380 :REM'.....erase previous line
390 LOCATE CSRLIN-1:PRINT:LOCATE CSRLIN-1
400 RETURN
410 :REM'
420 :REM'.....start
430 LOCATE 3
440 INPUT " ENTER: Low edge of band (MHz)................";FL
450 GOSUB 380
460 PRINT "        Low edge of band......................";USING U1$;FL;
470 PRINT " MHz"
480 INPUT " ENTER: High edge of band (MHz)...............";FH
490 GOSUB 380
500 PRINT "        High edge of band.....................";USING U1$;FH;
510 PRINT " MHz"
520 B=FH/FL
530 PRINT "        Operating bandwidth...................";USING U1$;B
540 BS=1.149999976158142!*B
550 PRINT "        Structure bandwidth (log cell array)..";USING U1$;BS
560 INPUT " ENTER: Number of driven elements.............";N
570 DIM DE(N,3)
580 GOSUB 380
590 PRINT "        Number of driven elements.............";USING "###";N;
600 PRINT "     "
610 K=1/(BS^(1/(N-1)))
620 PRINT "        Design constant.....................τ=";USING U1$;K
630 :REM'
640 Z1=0.20000000298023224!/(1-K)  :REM'cotangent of apex half-angle
650 Z2=1/Z1      :REM'tangent of apex half-angle
660 Z3=ATN(Z2)   :REM'apex half-angle in radians
670 :REM'
680 DEG=Z3*180/PI
690 PRINT "        Apex half-angle.......................";USING U1$;DEG;
700 PRINT "°"
710 WMAX=984/FL
720 PRINT "        Free-space wavelength.................";USING U1$;WMAX*UM;
730 PRINT UM$
740 L=(0.25!*(1-1/BS)*Z1)*WMAX
750 PRINT "        Log cell boom length..................";USING U1$;L*UM;
760 PRINT UM$;" ( El. 1 to El.";N;")"
770 :REM'
780 :REM'.....element lengths
790 DE(1,1)=492/FL
800  FOR Z=2 TO N
810   DE(Z,1)=K*DE(Z-1,1)
820  NEXT Z
830 :REM'
840 :REM'.....element spacing
850 DE(1,2)=0.5!*(DE(1,1)-DE(2,1))*Z1:DE(1,3)=DE(1,2)
860  FOR Z=2 TO N-1
870   DE(Z,2)=K*DE(Z-1,2)
880   DE(Z,3)=DE(Z-1,3)+DE(Z,2)    :REM'total distance from element #1
890  NEXT Z
900 :REM'
910 :REM'.....reflector
920 LREF=509.6000061035156!/FL
930 DREF=84/FL
940 :REM'
950 :REM'.....director
960 LDIR=450.79998779296875!/FL
970 DDIR=148/FL
980 :REM'
990 BOOM=L+DREF+DDIR     :REM'boom length
1000 :REM'
1010 :REM'.....screen print
1020 PRINT "        Reflector length......................";USING U1$;LREF*UM;
1030 PRINT UM$
1040 PRINT UL$;
1050 LN=CSRLIN-1
1060 FOR Z=1 TO N
1070 Z$=RIGHT$(STR$(Z),LEN(STR$(Z))-1)
1080 IF LEN(Z$)<2 THEN Z$=" "+Z$
1090 LN=LN+1
1100  PRINT "        Element #";Z$;" length....................";
1110 PRINT USING U1$;DE(Z,1)*UM;
1120  PRINT UM$;" @";
1130 IF Z=1 THEN PRINT USING U1$;DREF*UM;:PRINT UM$;" from Reflector":GOTO 1190
1140  IF DE(Z-1,2)=0 THEN PRINT "":GOTO 1190
1150  PRINT USING U1$;DE(Z-1,3)*UM;
1160 PRINT UM$;" from # 1";
1170 IF LN<22 THEN PRINT "":GOTO 1190
1180 GOSUB 2050:CLS:LN=0
1190 NEXT Z
1200 :REM'
1210  PRINT "        Director length.......................";USING U1$;LDIR*UM;
1220  PRINT UM$;" @";
1230  PRINT USING U1$;DDIR*UM;
1240 PRINT UM$;" from #";Z-1
1250 PRINT "        Reflector-to-Director distance........";USING U1$;BOOM*UM;
1260 PRINT UM$;" (total boom length)"
1270 GOSUB 2050
1280 CLS
1290 :REM'
1300 :REM'.....diagram
1310 U=5       :REM'length of 1/2 element
1320 PRINT " DIRECTOR";TAB(40-U-2);STRING$(U+2,196);" ";STRING$(U+2,196)
1330 LOCATE CSRLIN-1,36:PRINT"«"USING U2$;LDIR*UM;:PRINT UM$;"»"
1340 PRINT TAB(40);"│"
1350 PRINT TAB(40);"│   ";USING U2$;DDIR*UM;:PRINT UM$
1360 PRINT TAB(40);"│"
1370 LN=4
1380 :REM'
1390    FOR Z=N TO 1 STEP-1
1400 LN=LN+1
1410 U=U+1:IF U>25 THEN U=25
1420 PRINT " Element #";Z;TAB(40-U);STRING$(U,"─");"│";STRING$(U,196)
1430 LOCATE CSRLIN-1,36:PRINT"«"USING U2$;DE(Z,1)*UM;:PRINT UM$;"»"
1440 LN=LN+1:PRINT TAB(40);"│   ";
1450 X=DE(Z-1,2)*UM:IF X THEN PRINT USING U2$;DE(Z-1,2)*UM;:PRINT UM$;
1460 IF LN<22 THEN PRINT "":GOTO 1480
1470 GOSUB 2050:CLS:LN=0
1480    NEXT Z
1490 IF LN=0 THEN 1510
1500 LOCATE CSRLIN-1
1510 PRINT TAB(40);"│"
1520 PRINT TAB(40);"│   ";USING U2$;DREF*UM;:PRINT UM$
1530 U=U+2
1540 PRINT " REFLECTOR";TAB(40-U);STRING$(U,196);" ";STRING$(U,196);
1550 LOCATE CSRLIN,36:PRINT"«"USING U2$;LREF*UM;:PRINT UM$;"»";
1560 COLOR 15,1
1570 LOCATE 1,56:PRINT " Log-Periodic Yagi for   "
1580 LOCATE 2,56:PRINT "                         "
1590 U$="####.###"
1600 IF FL<10^3 THEN U$="###.###"
1610 IF FL<10^2 THEN U$="##.###"
1620 IF FL<10 THEN U$="#.###"
1630 LOCATE 2,56:PRINT " ";USING U$;FL;:PRINT " - ";USING U$;FH;:PRINT " MHz"
1640 COLOR 7,0
1650 GOSUB 2050
1660 CLS:LOCATE 12:PRINT " Want to find minimum turning radius?  (y/n) "
1670 Z$=INKEY$:IF Z$=""THEN 1670
1680 IF Z$="n"THEN 1720
1690 IF Z$="y"THEN 1700
1700 A=BOOM:B=LREF/2:C=LDIR/2:DIMN$="feet":PROG$="logyag":CHAIN"turnrad"
1710 GOTO 1670
1720 ERASE DE:GOTO 110   :REM'start
1730 END
1740 :REM'
1750 :REM'.....notes
1760 TB=7
1770 PRINT TAB(TB);
1780 PRINT "This program does all the calculations pertaining to the article"
1790 PRINT TAB(TB);
1800 PRINT "'The Log-Yag Array' as it appears in the ARRL ANTENNA ANTHOLOGY,"
1810 PRINT TAB(TB);
1820 PRINT "publication No.36, page 49."
1830 PRINT
1840 PRINT TAB(TB);
1850 PRINT "While not absolutely necessary, the diagrams in this article might"
1860 PRINT TAB(TB);
1870 PRINT "be useful when designing a LOG-YAG."
1880 PRINT
1890 PRINT TAB(TB);
1900 PRINT "For a complete dissertation on LPDA (Log-Periodic Dipole Array)"
1910 PRINT TAB(TB);
1920 PRINT "antennas see any recent edition of the ARRL ANTENNA BOOK."
1930 PRINT UL$;
1940 COLOR 0,7:LOCATE CSRLIN,22
1950 PRINT " Press 1 to continue or 0 to EXIT....."
1960 COLOR 7,0
1970 RETURN
1980 :REM'
1990 :REM'.....preface
2000 OPEN"I",1,"\hamcalc\docfiles\antenna.doc"
2010 IF EOF(1)THEN 2030
2020 INPUT#1,NOTE$:PRINT "   ";NOTE$:GOTO 2010
2030 CLOSE:RETURN
2040 :REM'
2050 :REM'PRT
2060 KEY OFF:GOSUB 2130:LOCATE 25,5:COLOR 0,2
2070 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2080 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2090 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2090 :ELSE GOSUB 2130
2100 IF Z$="3"THEN RETURN
2110 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2120 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2060
2130 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
