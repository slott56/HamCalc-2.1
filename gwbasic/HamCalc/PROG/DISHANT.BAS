10 :REM'DISHANT - Parabolic Dish Reflector - 15 AUG 92 rev. 21 JAN 2002
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$
40 CLS:KEY OFF:SCREEN 0
50 COLOR 7,0,1
60 DIM X(16),Y(16)
70 PI=3.1415929794311523!
80 U$="#####.##"
90 U1$="#####.#"
100 UL$=STRING$(80,205)
110 T$=" PARABOLIC DISH REFLECTOR"
120 :REM'
130 :REM'.....start
140 CLS
150 A=0:D=0:F=0:G=0:H=0:L=0:N=0:X=0:Y=0:Z=0:WM=0:WF=0:BW=0
160 COLOR 15,2,1
170 PRINT T$;TAB(57);"by George Murphy VE3ERP ";
180 COLOR 1,0:PRINT STRING$(80,223);
190 COLOR 7,0
200 PRINT " ref. CQ VHF, Spring 2002, pp.41-44, ";CHR$(34);
210 PRINT " Understanding Parabolic Dish Reflectors.";CHR$(34);
220 PRINT UL$;
230 PRINT " Press number in < > to:"
240 PRINT UL$;
250 PRINT "  < 1 >  RUN Dish Reflector program"
260 PRINT "  < 2 >  RUN Circular Waveguide Dish Feeds program"
270 :REM'PRINT "  < 3 >  READ ME"
280 PRINT UL$;
290 PRINT "  < 0 >  EXIT"
300 Z$=INKEY$
310 IF Z$="1"THEN CLS:GOTO 370
320 IF Z$="2"THEN CLS:CHAIN"circfeed"
330 :REM'IF Z$="3"THEN CLS:GOTO 2330
340 IF Z$="0"THEN CLS:RUN EX$
350 GOTO 300
360 :REM'
370 GOSUB 1820    :REM'graphics page
380 GOSUB 2470    :REM'screen dump
390 CLS
400 COLOR 7,0,0
410 PRINT T$;TAB(57);"by George Murphy VE3ERP ";
420 PRINT STRING$(80,205);
430 PRINT " Press number in < > to choose standard units of measure:"
440 PRINT UL$;
450 PRINT "   < 1 >  Metric"
460 PRINT "   < 2 >  U.S.A./Imperial"
470 Z$=INKEY$
480 IF Z$="1"THEN UM=2.5399999618530273!:UM$=" cm.":GOTO 520
490 IF Z$="2"THEN UM=1:UM$=" in.":GOTO 520
500 GOTO 470
510 :REM'
520 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
530 PRINT " Press letter in ( ) to"
540 PRINT "   (a) Find all other dimensions from a few known dimensions"
550 PRINT "   (b) Find dimensions for a specific frequency and beamwidth"
560 Z$= INKEY$:IF Z$=""THEN 560
570 IF Z$="a"THEN 700
580 IF Z$="b"THEN 610
590 GOTO 560
600 :REM'
610 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
620 INPUT " ENTER: Frequency.(MHz).......";H
630 IF H=0 THEN 620
640 WM=299.74200439453125!/H
650 WF=WM/0.30480000376701355!
660 INPUT " ENTER: Beamwidth (degrees)...";BW
670 IF BW=0 THEN 660
680 D=70*WF/BW*12:Y=D/2
690 :REM'
700 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
710 :REM'.....inputs
720 IF G THEN 750
730 PRINT " (if undecided, enter 60):"
740 INPUT " ENTER: Acceptance angle (degrees)..AFB= ";G:GOSUB 950
750 IF H AND G=0 THEN 740
760 IF Y=0 THEN PRINT " ENTER: Radius of dish (";UM$;").........Y= ";
770 IF Y=0 THEN INPUT Y:Y=Y/UM:GOSUB 950
780 IF G<>0 THEN 830
790 IF X=0 THEN PRINT " ENTER: Depth of dish (";UM$;") if known:X= ";
800 IF X=0 THEN INPUT X:X=X/UM:GOSUB 950
810 IF F=0 THEN PRINT " ENTER: Focal Length (";UM$;")...........Z= ";
820 IF F=0 THEN INPUT F:F=F/UM:GOSUB 950
830 IF X OR F THEN 840
840 IF N=0 THEN INPUT " ENTER: Number of rings (12 maximum).....";N
850 IF N<=12 THEN 920
860 BEEP:PRINT
870 PRINT " There is only enough space on the screen ";
880 PRINT "to print data for 12 rings!"
890 PRINT:PRINT " Press any key to enter a number less than 13........."
900 IF INKEY$=""THEN 900
910 N=0:GOTO 840
920 GOSUB 950
930 GOTO 710
940 :REM'
950 :REM'.....calculate missing factors
960 IF G>90 THEN GG=1
970 IF A=0 AND G<>0 THEN A=G*PI/180
980 IF Y=0 AND D<>0 THEN Y=D/2
990 IF D=0 AND Y<>0 THEN D=2*Y
1000 IF Z=0 AND Y*A<>0 THEN Z=Y/TAN(A)
1010 IF Y=0 AND F*X<>0 THEN Y=SQR(4*F*X)
1020 IF X=0 AND Y*F<>0 THEN X=Y^2/4/F
1030 IF F=0 AND Y*X<>0 THEN F=Y^2/4/X
1040 IF Y*X*F*N<>0 THEN 1080
1050 IF N THEN GOSUB 1710
1060 RETURN
1070 :REM'
1080 :REM'.....display
1090 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1100 PRINT " RING #";
1110 PRINT TAB(22);"Diameter";
1120 PRINT TAB(33);"Radius(Y)";
1130 PRINT TAB(46);"Depth(X)";
1140 PRINT TAB(58);"Circumf.";
1150 PRINT TAB(68);"Capture Area"
1160 PRINT UL$;
1170 W=Y/N
1180 :REM'
1190 FOR Z=1 TO N
1200 Y(Z)=W*Z            :REM'Radius                 Y co-ordinate
1210 X(Z)=(W*Z)^2/4/F    :REM'Distance from apex     X co-ordinate
1220 L=22.5!*PI/180       :REM'Angle in radians
1230 PRINT USING "###";Z;
1240 PRINT TAB(19);USING U$;2*Y(Z)*UM;:PRINT UM$;
1250 PRINT TAB(31);USING U$;Y(Z)*UM;:PRINT UM$;
1260 PRINT TAB(43);USING U$;X(Z)*UM;:PRINT UM$;
1270 PRINT TAB(55);USING U$;PI*2*Y(Z)*UM;:PRINT UM$;
1280 IF Z<>N THEN PRINT ""
1290 NEXT Z
1300 IF UM=1 THEN A=PI*Y(Z-1)^2/144:M$=" ft²":GOTO 1320
1310 A=(Y(Z-1)*25.399999618530273!)^2*PI/10^6:M$=" m²"
1320 PRINT TAB(68);USING "#,###.##";A;:PRINT M$
1330 :REM'
1340 LOCATE CSRLIN-1,5:PRINT "( Outer Ring )"
1350 PRINT UL$;
1360 IF F=X THEN A=PI/2
1370 IF F>X THEN A=ATN (Y/(F-X))
1380 IF F<X THEN A=PI-(ATN (Y/(X-F)))
1390 PRINT " Focal Length(Z):";USING "##,###.##";F*UM;:PRINT UM$;
1400 PRINT TAB(36)"Acceptance angle L:";USING "####.##";A*180/PI;
1410 PRINT "°"
1420 PRINT UL$;:IF H THEN 1450
1430 INPUT " ENTER: Frequency.(MHz)...";H
1440 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
1450 PRINT "     Frequency....";USING U$;H;:PRINT " MHz"
1460 :REM'
1470 IF WM=0 THEN WM=299.7919921875!/H          :REM'wavelength in meters
1480 IF WF=0 THEN WF=WM/0.30480000376701355!           :REM'wavelength in feet
1490 PRINT "     Wavelength..."USING U$;WM*100;
1500 PRINT " cm. =";:PRINT USING " ###.## ft.";WF
1510 :REM'
1520 PRINT " Approximate:-"
1530 IF BW=0 THEN BW=70*WF/D*12        :REM'beamwidth
1540 PRINT "     Beamwidth....";USING U$;BW;:PRINT "° at 1/2 power points";
1550 PRINT " (3 dB down)"
1560 :REM'
1570 LF=0.4342944920063019!           :REM'LOG factor 1/log(10) to convert to base 10
1580 G=10*LOG(0.550000011920929!*(PI*D/12/WF)^2)*LF
1590 PRINT "     Gain........┌";USING U$;G;
1600 PRINT " dB over an isotropic antenna"
1610 :REM'
1620 PRINT "                 └";USING U$;G-2.1500000953674316!;
1630 PRINT " dB over a dipole"
1640 :REM'
1650 GOSUB 2470
1660 GOTO 110   :REM'start
1670 END
1680 :REM'
1690 :REM'.....calculate other factors from angle
1700 IF Z=0 THEN RETURN
1710 X=0
1720 T=1000
1730 IF T<=9.999999747378752e-05! THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 1790
1740 X=X+T
1750 IF GG THEN F=X-Z :ELSE F=X+Z
1760 Q=SQR(4*F*X)
1770 IF Q>=Y THEN X=X-T:T=T/10:GOTO 1730
1780 GOTO 1730
1790 IF GG THEN SWAP F,X
1800 RETURN
1810 :REM'
1820 :REM'.....graphics diagram
1830 CLS:COLOR 0,7
1840 PRINT "                          "
1850 PRINT "              B «───────┐ "
1860 PRINT "             █▌         │ "
1870 PRINT "            █▌|         │ "
1880 PRINT "           █▌ |         │ "
1890 PRINT "          █▌  |         │ "
1900 PRINT "         █▌   |         │ "
1910 PRINT "        █▌    |         │ "
1920 PRINT "       █▌     |         │ "
1930 PRINT "      ▐▌      |           "
1940 PRINT "      █       |         Y "
1950 PRINT "     ▐▌       |           "
1960 PRINT "     █        |         │ "
1970 PRINT "    ▐▌        |         │ "
1980 PRINT "    █         |         │ "
1990 PRINT "   ▐▌         |         │ "
2000 PRINT "   █          |         │ "
2010 PRINT "  ▐▌          |         │ "
2020 PRINT "  █           |         │ "
2030 PRINT "  A────<AXIS>─┼─────F «─┘ "
2040 PRINT "  │           |     │     "
2050 PRINT "  │«─── X ───»│     │     "
2060 PRINT "  │«────── Z ──────»│     "
2070 PRINT "                          ";
2080 COLOR 7,0
2090 D$=STRING$(53,205)
2100 C=28
2110 LOCATE  1,C:PRINT "PARABOLIC DISH  (One half of dish profile is shown)."
2120 LOCATE  2,C:PRINT D$
2130 LOCATE  3,C:PRINT "(Due to the graphics limitations of your screen when"
2140 LOCATE  4,C:PRINT "in the Text mode, as it now is, the parabolic curve"
2150 LOCATE  5,C:PRINT "shown here is represented by stepped blocks)."
2160 LOCATE  6,C:PRINT D$
2170 LOCATE  7,C:PRINT "A = Centre of back of dish."
2180 LOCATE  8,C:PRINT "B = Any point on circumference."
2190 LOCATE  9,C:PRINT "F = Focal point of parabola."
2200 LOCATE 10,C:PRINT "    (this is where you locate your antenna)"
2210 LOCATE 11,C:PRINT "L = Acceptance angle A to F to B."
2220 LOCATE 12,C:PRINT "X = Depth (distance from back of dish)"
2230 LOCATE 13,C:PRINT "Y = Radius of dish."
2240 LOCATE 14,C:PRINT "Z = Focal Length (distance of focal point from A)."
2250 LOCATE 15,C:PRINT D$
2260 LOCATE 16,C:PRINT "The program calculates Z and the X and Y co-ordinates"
2270 LOCATE 17,C:PRINT "(depth and radius) of several inner rings around the"
2280 LOCATE 18,C:PRINT "center line of the dish. These are also the X and Y"
2290 LOCATE 19,C:PRINT "co-ordinates of several points along curve AB."
2300 LOCATE 20,C:PRINT D$
2310 RETURN
2320 :REM'
2330 :REM'.....help
2340 LN=0
2350 OPEN"I",1,"\hamcalc\docfiles\dishant.txt"
2360 IF EOF(1)THEN 2430
2370 INPUT#1,Y$
2380 PRINT "  ";Y$;
2390 LN=LN+1
2400 IF LN<24 THEN PRINT ""
2410 IF LN=24 THEN GOSUB 2470:LN=0:CLS
2420 GOTO 2360
2430 CLOSE
2440 GOSUB 2470
2450 ERASE X,Y:GOTO 10
2460 :REM'
2470 :REM'PRT
2480 KEY OFF:GOSUB 2550:LOCATE 25,5:COLOR 0,2
2490 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2500 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2510 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2510 :ELSE GOSUB 2550
2520 IF Z$="3"THEN RETURN
2530 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2540 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2480
2550 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
