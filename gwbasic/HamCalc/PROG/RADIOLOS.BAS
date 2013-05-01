10 :REM'RADIOLOS - 14 OCT 86 rev. 18 DEC 1998
20 :REM'
30 :REM'ADAPTED FROM THE FOLLOWING ARTICLE from QST, July 1983:
40 :REM'   RADIO LINE-OF-SIGHT
50 :REM'   by W6ZGN, Jack Priedigkeit
60 :REM'   441 Sherwood Way, Menlo Park CA 94025
70 :REM'
80 CLS:KEY OFF
90 IF EX$=""THEN EX$="EXIT"
100 COLOR 7,0,1
110 UL$=STRING$(80,205)
120 DIM TXT$(20)
130 :REM'
140 :REM'.....start
150 CLS
160 COLOR 15,2
170 PRINT " LINE-of-SIGHT RADIO WAVES";
180 PRINT TAB(57);"by George Murphy VE3ERP ";
190 COLOR 1,0:PRINT STRING$(80,223);
200 COLOR 7,0
210 GOSUB 1810    :REM'preface
220 PRINT UL$;
230 PRINT " Press number in < > to choose standard units of measure:"
240 PRINT UL$;
250 PRINT "  < 1 >  Metric"
260 PRINT "  < 2 >  U.S.A./Imperial"
270 PRINT UL$;
280 PRINT "    or Press < 0 > to EXIT....."
290 M$=INKEY$
300 IF M$="0"THEN CLS:RUN EX$
310 IF M$="1"THEN D$="km.":H$="m.":GOTO 340
320 IF M$="2"THEN D$="mi.":H$="ft.":GOTO 340
330 GOTO 290
340 PRINT UL$;
350 PRINT " Press number in < > to:"
360 PRINT UL$;
370 PRINT "  < 3 >  RUN Radio Line-of-Sight program"
380 PRINT "  < 4 >  RUN Radio Horizon program"
390 PRINT UL$;
400 Z$=INKEY$
410 IF Z$="3"THEN 670
420 IF Z$="4"THEN 450
430 GOTO 400
440 :REM'
450 :REM'.....radio horizon
460 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
470 PRINT " (if the data asked for is the data you are seeking, press <ENTER>)"
480 PRINT
490 PRINT " ENTER: Height of antenna above average terrain (";H$;").....";
500 INPUT H:IF H$="m."THEN H=H/0.30480000376701355!
510 IF H<>0 THEN D=SQR(2*H):GOTO 560
520 PRINT " ENTER: Distance of antenna from radio horizon (";D$;")......";
530 INPUT D:IF D$="Km."THEN D=D*0.6213700175285339!
540 IF D<>0 THEN H=D^2/2:GOTO 560
550 GOTO 490
560 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
570 PRINT " Height of antenna above average terrain...";USING "#####.#";H;
580 PRINT " feet  (";
590 PRINT USING "####.#";H*0.30480000376701355!;:PRINT " metres)"
600 PRINT " Approximate distance to radio horizon.....";USING"#####.#";D;
610 PRINT " miles (";
620 PRINT USING "####.#";D*1.6093469858169556!;:PRINT " Km.   )"
630 PRINT UL$;
640 LN=6:GOSUB 1950         :REM'screen dump
650 GOTO 140   :REM'start
660 :REM'
670 :REM'.....radio line-of sight
680 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
690 GOSUB 1490       :REM'preface
700 IF INKEY$=""THEN 700
710 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
720 H1$="("+H$+")"
730 IF LEN(H1$)<11 THEN H1$=H1$+".":GOTO 730
740 PRINT " ENTER: Elevation of antenna A ";H1$;:INPUT A
750 X=A:GOSUB 1240:IF M$="1"THEN A=A/0.30480000376701355!
760 PRINT " ENTER: Elevation of antenna B ";H1$;:INPUT B
770 X=B:GOSUB 1240:IF M$="1"THEN B=B/0.30480000376701355!
780 D1$="("+D$+")"
790 IF LEN(D1$)<11 THEN D1$=D1$+".":GOTO 790
800 PRINT " ENTER: Separation ";D1$;"............";:INPUT D
810 X=D:GOSUB 1240:IF M$="1"THEN D=D*0.6213712096214294!
820 INPUT " ENTER: K factor (if other than 1.33).....";Z
830 IF Z=0 THEN P=1.3300000429153442! :ELSE P=Z
840 X=P:GOSUB 1240
850 COLOR 7,0
860 CLS
870 COLOR 2,2:PRINT STRING$(80,32);
880 COLOR 15,2:LOCATE 1,14
890 PRINT " LINE-of-SIGHT RADIO WAVE PATH with K-factor of";P""
900 COLOR 1,0:PRINT STRING$(80,223);
910 COLOR 7,0
920 PRINT "Plot  from Antenna A";TAB(31)"from Antenna B";
930 PRINT TAB(50)"Elevation of ray path"
940 PRINT UL$;
950 N=18                :REM'number of plots
960 LO=A+9.999999747378752e-05!:FLAG=0   :REM'factors for low point calculation
970 C=A-B
980 K=1.5!*P
990 L=D^2/K
1000 IF ABS(C)>L THEN 1140
1010 E=0.75!*P*C/D+D/2
1020 H=A-E^2/K
1030 :REM'
1040 FOR Y=0 TO N
1050 G=Y*D/N
1060 Q=G-E
1070 J=H+Q^2/K
1080 GOSUB 1300           :REM'print line
1090 NEXT Y
1100 PRINT UL$;
1110 LN=24:GOSUB 1950      :REM'screen dump
1120 GOTO 140   :REM'start
1130 :REM'
1140 M=C/D+D/K
1150 FOR Y=0 TO N
1160 G=Y*D/N
1170 J=A-M*G+G^2/K
1180 GOSUB 1300           :REM'print line
1190 NEXT Y
1200 PRINT UL$;
1210 LN=24:GOSUB 1950
1220 CLS:RUN EX$
1230 :REM'
1240 :REM'.....format display
1250 LOCATE CSRLIN-1,1:PRINT STRING$(7,32)
1260 LOCATE CSRLIN-1,42
1270 PRINT X;SPACE$(10)
1280 RETURN
1290 :REM'
1300 U$="#####,.##"
1310 IF J<0 THEN COLOR 0,7:CO=1::ELSE COLOR 7,0
1320 IF M$="1"THEN GG=G/0.6213712096214294! :ELSE GG=G
1330 IF M$="1"THEN DD=D/0.6213712096214294! :ELSE DD=D
1340 IF M$="1"THEN JJ=J*0.30480000376701355! :ELSE JJ=J
1350 PRINT Y+1;
1360 PRINT TAB(5)USING U$;GG;:PRINT " ";D$;
1370 IF Y=9 THEN PRINT TAB(20)"(mid-way)";
1380 PRINT TAB(29)USING U$;ABS(DD-GG);:PRINT " ";D$;
1390 PRINT TAB(53)USING U$;JJ;:PRINT " ";H$;
1400 IF JJ<0 THEN LOCATE CSRLIN,67:PRINT "(underground)";
1410 IF FLAG THEN 1430
1420 IF J>LO THEN LOCATE CSRLIN-1,67:PRINT"  LOW POINT  ":FLAG=1
1430 IF Y=0 THEN LOCATE CSRLIN,67:PRINT "(Antenna A)":GOTO 1470
1440 IF Y=N THEN LOCATE CSRLIN,67:PRINT "(Antenna B)":GOTO 1470
1450 PRINT ""
1460 LO=J
1470 RETURN
1480 :REM'
1490 :REM'.....preface
1500 TB=8      :REM'tab for text
1510 PRINT TAB(TB);
1520 PRINT "This program will ask you for a K factor. The K factor accounts"
1530 PRINT TAB(TB);
1540 PRINT "for refraction of radio waves close to the surface of the earth."
1550 PRINT TAB(TB);
1560 PRINT "For antenna towers less than a couple of thousand feet above the"
1570 PRINT TAB(TB);
1580 PRINT "surface a K factor of 1.33 is usually adequate for most line-of-"
1590 PRINT TAB(TB);
1600 PRINT "sight calculations over average terrain."
1610 PRINT
1620 PRINT TAB(TB);
1630 PRINT "The program will plot the elevation of the ray path at 19 points"
1640 PRINT TAB(TB);
1650 PRINT "along the path between two antennas of any height."
1660 PRINT
1670 PRINT TAB(TB);
1680 PRINT "The elevations shown as minus quantities are the below-ground"
1690 PRINT TAB(TB);
1700 PRINT "depths of the line-of-sight path."
1710 PRINT
1720 PRINT TAB(TB);
1730 PRINT "This program is an expanded version of the original program by"
1740 PRINT TAB(TB);
1750 PRINT "Jack Priedigkeit W6ZGN."
1760 PRINT
1770 PRINT TAB(TB);
1780 PRINT "Press any key to continue......."
1790 RETURN
1800 :REM'
1810 :REM'.....preface
1820 T=7
1830 PRINT TAB(T);
1840 PRINT "This program computes the height above ground of a radio wave at"
1850 PRINT TAB(T);
1860 PRINT "several points along its path between two antennas, assuming the"
1870 PRINT TAB(T);
1880 PRINT "ground between the antennas is level. The program also computes"
1890 PRINT TAB(T);
1900 PRINT "the distance from the top of an antenna to the radio horizon over"
1910 PRINT TAB(T);
1920 PRINT "level ground."
1930 RETURN
1940 :REM'
1950 :REM'PRT
1960 KEY OFF:GOSUB 2030:LOCATE 25,5:COLOR 0,2
1970 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1980 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1990 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1990 :ELSE GOSUB 2030
2000 IF Z$="3"THEN RETURN
2010 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2020 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1960
2030 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
