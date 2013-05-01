10 :REM'GUYWIRES - for Antenna Towers - 14 MAR 95 rev.11 APR 97
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COLOR 7,0,1
50 PI=3.1415929794311523!
60 UL$=STRING$(80,205)
70 U0$="##"
80 U1$="####.##"
90 U2$="####"
100 U3$="#.##"
110 U4$="###.##"
120 U5$="###.#"
130 :REM'
140 :REM'.....start
150 CLS:LAST=0
160 COLOR 15,2
170 PRINT " GUY WIRES for Antenna Towers and Masts";
180 PRINT TAB(57);"by George Murphy VE3ERP ";
190 COLOR 1,0:PRINT STRING$(80,223);
200 COLOR 7,0
210 GOSUB 1470    :REM'preface & diagram
220 COLOR 7,0
230 CL=CSRLIN:VIEW PRINT CL TO 24:CLS:VIEW PRINT:LOCATE CL
240 COLOR 0,7:LOCATE 25,22
250 PRINT " Press 1 to continue or 0 to EXIT.....";
260 COLOR 7,0
270 Z$=INKEY$:IF Z$=""THEN 270
280 IF Z$="0"THEN CLS:RUN EX$
290 IF Z$="1"THEN 310
300 GOTO 270
310 GOSUB 2260    :REM'hardcopy
320 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
330 GOSUB 1940    :REM'general notes
340 PRINT UL$;
350 PRINT " Press number in < > to choose standard units of measure:"
360 PRINT UL$;
370 PRINT "   < 1 >  Metric"
380 PRINT "   < 2 >  U.S.A./Imperial"
390 Z$=INKEY$
400 IF Z$="1"THEN U$=" m.":GOTO 430
410 IF Z$="2"THEN U$=" ft.":GOTO 430
420 GOTO 390
430 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
440 PRINT " Press number in < > to select type of antenna supporting structure:"
450 PRINT UL$;
460 PRINT "   < 3 >  Tower designed for Amateur Radio antennas."
470 PRINT "   < 4 >  Standard TV antenna tower."
480 PRINT "   < 5 >  Thinwall pipe or tubing mast."
490 PRINT "   < 6 >  Other...."
500 Z$=INKEY$
510 IF Z$="3"THEN J=35:J$=" Amateur Radio type tower....":GOTO 560
520 IF Z$="4"THEN J=20:J$=" TV antenna type tower.......":GOTO 560
530 IF Z$="5"THEN J=12:J$=" thinwall pipe or tubing mast":GOTO 560
540 IF Z$="6"THEN J$=     " supporting structure........":GOTO 560
550 GOTO 500
560 CLS:GOTO 610
570 :REM'
580 LOCATE CSRLIN-1:PRINT "       ";:LOCATE CSRLIN,63:PRINT USING U1$;X;
590 RETURN
600 :REM'
610 :REM'.....input data
620 IF Z$<>"6"THEN 680
630 PRINT " ENTER: Maximum vertical distance between guy wire sets (";U$;")";
640 INPUT J:IF U$=" m."THEN J=J/0.30480000376701355!
650 X=J:GOSUB 580:PRINT U$
660 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
670 :REM'
680 PRINT " ENTER: Height of";J$;"................(";U$;")";
690 INPUT H:X=H:GOSUB 580:PRINT U$;"     "
700 PRINT "        MINIMUM distance to anchor points.....................";
710 PRINT USING U1$;H/SQR(3);:PRINT U$
720 PRINT "        RECOMMENDED distance to anchor points............about";
730 PRINT USING U1$;H*0.800000011920929!;:PRINT U$
740 PRINT " ENTER: Your choice of distance to anchor points (";U$;").......";
750 INPUT R
760 LN=CSRLIN-3:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
770 MAX=J:IF U$=" m."THEN MAX=J*0.30480000376701355!    :REM'maximum segment
780 THETA=ATN(H/R)   :REM'angle of top set of guy wires
790 :REM'
800 :REM'.....find number of guy wire sets
810 N=0      :REM'reset counter
820 :REM'
830 N=N+1
840 IA=THETA/N      :REM'incremental angle
850 BOT=R*TAN(IA*(N-1))
860 TOP=H-BOT
870 IF TOP>MAX THEN 830
880 :REM'
890 PRINT "        Number of guy wire sets...............................";
900 PRINT USING U2$;N
910 PRINT "        Guy wire anchors - distance from tower/mast...........";
920 PRINT USING U1$;R;:PRINT U$
930 PRINT UL$;
940 COLOR 0,7:LOCATE ,3:PRINT " Set ";:COLOR 7,0
950 PRINT TAB(11);
960 PRINT "Height above   Guy Wire    Tower    Non-Resonant    Anchor"
970 COLOR 0,7:LOCATE ,3:PRINT " No. ";:COLOR 7,0
980 PRINT TAB(14);
990 PRINT "Ground       Length  =   End   +   Segments   +   End      Slope"
1000 PRINT UL$;
1010 :REM'
1020 LIN=0    :REM'line number
1030     FOR Z=N TO 1 STEP-1
1040 ANG=IA*Z                          :REM'angle
1050 EL=TAN(ANG)*R                     :REM'elevation of guy wire attachment
1060 L=SQR(R^2+EL^2)                   :REM'hypotenuse
1070 IF U$=" ft." THEN E=1:GW=L-2*E    :REM'length of centre section - feet
1080 IF U$=" m."  THEN E=0.30000001192092896!:GW=L-2*E   :REM'length of centre section - metres
1090 IF Z=N THEN 1110
1100 PRINT USING U4$;LAST-EL;:PRINT U$;" space"
1110 LAST=EL
1120 COLOR 0,7:LOCATE ,4
1130 PRINT USING U0$;Z;:PRINT " ";     :REM'set no.
1140 COLOR 7,0
1150 PRINT TAB(11);USING U1$;EL;       :REM'height above ground
1160 PRINT U$;TAB(24);USING U1$;L;     :REM'length of guy wire
1170 PRINT U$;TAB(37);USING U3$;E;     :REM'length of tower end
1180 PRINT U$;
1190 GOSUB 1310
1200 PRINT TAB(46);USING "##";C;:PRINT " @";USING U1$;GW/C;
1210 PRINT U$;TAB(63);USING U3$;E;     :REM'length of anchor end
1220 PRINT U$;TAB(72);USING U4$;ANG*180/PI;:PRINT "°±"
1230 LIN=LIN+1
1240 IF LIN=8 THEN GOSUB 2260:LIN=0:VIEW PRINT 8 TO 24:CLS:LOCATE 8
1250     NEXT Z
1260 PRINT UL$;
1270 PRINT TAB(6);"From each anchor, guy wires are equispaced vertically at";
1280 PRINT USING U5$;IA*180/PI;:PRINT "°± apart.";
1290 GOTO 1420
1300 :REM'
1310 :REM'.....check for resonance
1320 IF U$=" m."THEN K1=K1*0.30480000376701355!:K2=K2*0.30480000376701355!
1330 C=1      :REM'divisor
1340 Y=GW/C:IF U$=" m."THEN Y=Y/0.30480000376701355!
1350 A=CINT(0.949999988079071!*Y):B=CINT(1.0499999523162842!*Y)
1360 FOR X=A-1 TO B+1
1370 IF X/16<>INT(X/16) AND X/22<>INT(X/22)THEN 1390
1380 C=C+1:GOTO 1340
1390 NEXT X
1400 RETURN
1410 :REM'
1420 :REM'.....end
1430 GOSUB 2260
1440 GOTO 140
1450 END
1460 :REM'
1470 :REM'.....preface
1480 T=7
1490 PRINT TAB(T);
1500 PRINT "To support a typical Ham beam antenna this program calculates:"
1510 PRINT TAB(T);
1520 PRINT "- Number of guy wire sets required for any given tower/mast height."
1530 PRINT TAB(T);
1540 PRINT "- Height above ground for the attachment of each set of guy wires."
1550 PRINT TAB(T);
1560 PRINT "- Distance from the tower/mast to the guy wire anchors."
1570 PRINT TAB(T);
1580 PRINT "- Quantity and length of non-resonant segments in each guy wire."
1590 PRINT TAB(T);
1600 PRINT "- Total length of each guy wire."
1610 PRINT
1620 PRINT TAB(T);
1630 PRINT "The calculations assume three wires per set spaced 120° apart, with"
1640 PRINT TAB(T);
1650 PRINT "three anchor points - each anchoring one wire of each guy wire set."
1660 PRINT
1670 COLOR 0,7
1680 T=8
1690 LN=CSRLIN:VIEW PRINT LN TO LN+10:CLS:CLS:VIEW PRINT:LOCATE LN
1700 PRINT TAB(T);
1710 PRINT "                         TYPICAL GUY WIRE"
1720 PRINT TAB(T);
1730 PRINT "                    ( ■ = Attachment Fitting )"
1740 PRINT TAB(T);
1750 PRINT "                    ( ∞ = Egg Insulator      )"
1760 PRINT TAB(T);
1770 PRINT "        │«─────────────── Centre Section ───────────────»│"
1780 PRINT TAB(T);
1790 PRINT "        │ (may need to be cut into separate non-resonant │"
1800 PRINT TAB(T);
1810 PRINT "        │      segments connected by egg insulators)     │"
1820 PRINT "  Tower";
1830 PRINT " ■──────∞───────────────∞────────────────∞───────────────∞──────■ ";
1840 PRINT "Anchor"
1850 PRINT TAB(T);
1860 PRINT "»│30 cm.│«                slope down ──>                »│30 cm.│«"
1870 PRINT TAB(T);
1880 PRINT "»│12 in.│«                                              »│12 in.│«"
1890 PRINT TAB(T);
1900 PRINT " │«────────────────────────── Length ──────────────────────────»│ "
1910 PRINT
1920 RETURN
1930 :REM'
1940 :REM'.....notes
1950 T$=STRING$(7,32)
1960 PRINT T$;
1970 PRINT "  The required number of supporting guy wire sets for a tower or"
1980 PRINT T$;
1990 PRINT "mast depends on the height of the structure and the minimum spacing"
2000 PRINT T$;
2010 PRINT "between guy wire sets recommended for the type of structure and"
2020 PRINT T$;
2030 PRINT "local icing and wind conditions. Typical minimum spacings assumed"
2040 PRINT T$;
2050 PRINT "by the program are conservative and may be considered as applicable"
2060 PRINT T$;
2070 PRINT "for close to 'worst case' site conditions."
2080 PRINT T$;
2090 PRINT "  To avoid possible mechanical resonance in the structure that may"
2100 PRINT T$;
2110 PRINT "cause it to have a tendency to vibrate, the sets of guys should NOT"
2120 PRINT T$;
2130 PRINT "be spaced at equal vertical intervals on the structure."
2140 PRINT T$;
2150 PRINT "  The recommended distance of anchor points from the structure is"
2160 PRINT T$;
2170 PRINT "about 80% of the structure height. Anchor distances of less than"
2180 PRINT T$;
2190 PRINT "58% of the height should be considered as being unsafe."
2200 PRINT T$;
2210 PRINT "  This program performs all the calculations required to meet these"
2220 PRINT T$;
2230 PRINT "criteria."
2240 RETURN
2250 :REM'
2260 :REM'PRT
2350 KEY OFF:GOSUB 2420:LOCATE 25,5:COLOR 0,2
2360 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2370 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2380 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2380 :ELSE GOSUB 2420
2390 IF Z$="3"THEN RETURN
2400 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2410 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2350
2420 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
