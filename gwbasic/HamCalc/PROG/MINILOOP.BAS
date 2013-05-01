10 :REM'MINILOOP - Miniature Tuned Loop Antennas - 12 MAR 95 rev. 09 DEC 2002
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="miniloop"
40 COMMON EX$,PROG$,VC,CC
50 COLOR 7,0,1
60 PI=4*ATN(1)
70 U1$="##,###.###"
80 U2$="##,###.##"
90 U3$="##,#.#####"
100 U4$=" > ###.###"
110 UL$=STRING$(80,205)
120 :REM'
130 :REM'.....start
140 CLS
150 COLOR 15,2
160 PRINT " MINILOOP - Miniature Tuned Loop Antenna";
170 PRINT TAB(60);"by Harold Kane W2AHW ";
180 PRINT STRING$(80,32);
190 LOCATE CSRLIN-1,20:PRINT "Edited for HAMCALC by George Murphy VE3ERP"
200 COLOR 1,0:PRINT STRING$(80,223);
210 COLOR 7,0
220 GOTO 290
230 :REM'
240 :REM'.....print data line
250 LOCATE LN:PRINT "       ";:LOCATE CSRLIN,47:PRINT USING U1$;Z;
260 PRINT Y$
270 RETURN
280 :REM'
290 :REM'.....start
300 GOSUB 2070    :REM'diagram
310 PRINT UL$;
320 GOSUB 1920  :REM'credits
330 PRINT UL$;
340 PRINT " Press number in < > to choose standard units of measure:"
350 PRINT "   < 1 >  Metric"
360 PRINT "   < 2 >  U.S.A./Imperial"
370 PRINT "     or press < 0 > to EXIT.....";
380 M$=INKEY$:IF M$=""THEN 380
390 IF M$="0"THEN CLS:RUN EX$
400 IF M$="1"THEN MX=2.5399999618530273!:E$="cm.":GOTO 430
410 IF M$="2"THEN MX=1:E$="in.":GOTO 430
420 :REM'
430 COLOR 7,0,0:CLS
440 PRINT " W5QJR MINILOOP Octagonal Loop Antenna"
450 PRINT UL$;
460 :REM'
470 :REM'.....frequency
480 INPUT " ENTER: Operating frequency...................(MHz)";F
490 WV=300/F     :REM'wavelength in metres
500 Z=F:Y$=" MHz":LN=3:GOSUB 240
510 LOCATE CSRLIN-1,62:PRINT USING "( ##.### metres)";WV
520 :REM'
530 :REM'.....loop dimensions
540 PMAX=WV*0.25!*39.369998931884766!  :REM'maximum perimeter in inches
550 SMAX=INT(PMAX/8)
560 PMIN=WV*0.10000000149011612!*39.369998931884766!   :REM'minimum perimeter in inches
570 SMIN=PMIN/8
580 COLOR 0,7
590 PRINT " For optimum performance loop perimeter should be between 1/8 & 1/4";
600 PRINT " wavelength, ";
610 PRINT " therefore distance between opposite sides should be between";
620 LIMIT$=" ###.# and ###.# "+E$
630 PRINT USING LIMIT$;SMIN*MX,SMAX*MX;:COLOR 7,0
640 LN=CSRLIN
650 PRINT " ENTER: Distance between opposite sides.......(";E$;")";
660 INPUT Z:IF M$="1"THEN X=Z/30.479999542236328! :ELSE X=Z/12     :REM'X=distance in feet
670 Z=X*12:Y$=" in. =":GOSUB 240
680 LOCATE CSRLIN-1,65:PRINT USING U2$;X*30.479999542236328!;:PRINT " cm"
690 IF Z<=SMAX THEN 790
700 :REM'
710 :REM'.....self-resonance warning
720 PRINT :COLOR 12
730 PRINT " LOOP MAY BE SELF-RESONANT! TRY A SMALLER LOOP":COLOR 7
740 PRINT
750 PRINT " Press any key . . . . ."
760 IF INKEY$=""THEN 760
770 GOTO 130
780 :REM'
790 S1=X*12*TAN(22.5!*PI/180)  :REM'length of each side in inches
800 S=8*S1/12                 :REM'length of conductor in feet
810 DC=SQR((X*12)^2+S1^2)     :REM'distance between corners in inches
820 LG=S*0.30480000376701355!    :REM'length of conductor in metres
830 :REM'
840 :REM'.....distance between corners
850 IF S$="3"OR S$="5"THEN 890
860 PRINT "        Distance between opposite corners.....";USING U1$;DC;
870 PRINT " in. =";TAB(65);USING U2$;DC*2.5399999618530273!;:PRINT " cm"
880 :REM'
890 :REM'.....side of shape
900 IF S$="3"THEN 940
910 PRINT "        Length of each side of loop...........";USING U1$;S1;
920 PRINT " in. =";TAB(65);USING U2$;S1*2.5399999618530273!;:PRINT " cm"
930 :REM'
940 :REM'.....conductor length
950 PRINT "        Length of conductor...................";USING U1$;S;
960 PRINT " ft. =";TAB(65);USING U2$;S*30.479999542236328!;:PRINT " cm"
970 :REM'
980 :REM'.....area
990 A=S1/39.369998931884766!         :REM'length of side in metres
1000 AM=4.828000068664551!*A^2       :REM'area in m^2
1010 :REM'
1020 :REM'.....conductor diameter
1030 LN=CSRLIN
1040 PRINT " ENTER: Diameter of conductor.................(";E$;")";
1050 INPUT Z:IF M$="1"THEN D=Z/2.5399999618530273! :ELSE D=Z
1060 Z=D:Y$=" in. =":GOSUB 240
1070 LOCATE CSRLIN-1,65:PRINT USING U2$;D*2.5399999618530273!;:PRINT " cm"
1080 :REM'
1090 :REM'.....power
1100 INPUT " ENTER: Transmitter power output..............";P
1110 Z=P:Y$=" watts":LN=CSRLIN-1:GOSUB 240
1120 :REM'
1130 :REM'.....radiation resistance
1140 RR=3.119999885559082!*10^4*(AM/WV^2)^2
1150 PRINT "        Radiation Resistance..................";USING U3$;RR;
1160 PRINT " Ω"
1170 :REM'
1180 :REM'.....loss resistance
1190 LR=(0.9959999918937683!*10^-6*SQR(F*10^6))/D      :REM'ohms per foot
1200 RL=LR*S
1210 PRINT "        AC Loss Resistance....................";USING U3$;RL;
1220 PRINT " Ω"
1230 :REM'
1240 :REM'.....efficiency
1250 E=RR/(RR+RL):E1=E*100
1260 PRINT "        Efficiency............................";USING U1$;E1;
1270 PRINT " %"
1280 :REM'
1290 :REM'.....inductance
1300 S2=S1*2.5399999618530273!   :REM'length of side in cm.
1310 D1=D*2.5399999618530273!    :REM'conductor dia. in cm.
1320 J1=0.01600000075995922!*S2
1330 J2=LOG(2.61299991607666!*S2/2^D1)
1340 J3=0.07152999937534332!*2^D1/S2
1350 L=J1*(J2+0.7514299750328064!+J3)
1360 PRINT "        Inductance............................";USING U1$;L;
1370 PRINT " µH"
1380 :REM'
1390 :REM'.....reactance
1400 XL=2*PI*F*10^6*L/10^6
1410 PRINT "        Inductive reactance (ohms)............";USING U1$;XL;
1420 PRINT " Ω"
1430 :REM'
1440 :REM'.....Q
1450 Q=XL/(2*(RL+RR))
1460 PRINT "        Q of antenna..........................";USING U1$;Q
1470 :REM'
1480 :REM'.....bandwidth
1490 BW=F*10^3/Q
1500 PRINT "        Bandwidth.............................";USING U1$;BW;
1510 PRINT " kHz"
1520 :REM'
1530 :REM'.....peak voltage
1540 VC=SQR(P*XL*Q)*10^-3
1550 PRINT "        Peak voltage across tuning capacitor..";USING U1$;VC;
1560 PRINT " kV"
1570 :REM'
1580 GAP=VC/21:MPS=1.5!*GAP   :REM'MPS=minimum capacitor plate spacing
1590 PRINT "        Voltage breakdown spacing (approx.)...";USING U1$;GAP;
1600 PRINT " in."
1610 :REM'
1620 :REM'.....tuning capacitor
1630 C=(1/(2*3.141590118408203!*F*10^6*XL))*10^12
1640 PRINT "        Capacitance required to resonate......";USING U1$;C;
1650 PRINT " pF"
1660 :REM'
1670 :REM'.....distributed capacitance
1680 CD=0.8199999928474426!*S
1690 PRINT "        Distributed capacitance...............";USING U1$;CD;
1700 PRINT " pF"
1710 :REM'
1720 :REM'.....capacitor
1730 CV=C-CD
1740 PRINT "        Tuning Capacitor......................";USING U4$;CV;
1750 PRINT " pF"
1760 :REM'
1770 :REM'.....plate spacing
1780 PRINT "        Recommended minimum plate spacing.....";USING U1$;MPS;
1790 PRINT " in.";
1800 GOSUB 2210
1810 :REM'
1820 LOCATE 25,8:COLOR 15,4
1830 PRINT " Do you want to design a telescoping variable capacitor?    (y/n) ";
1840 COLOR 7,0
1850 Z$=INKEY$:IF Z$=""THEN 1840
1860 IF Z$="n"THEN 130
1870 IF Z$="y"THEN CLS:CC=C:CHAIN"capytel"
1880 GOTO 1850
1890 GOTO 130
1900 :REM'
1910 :REM'.....credits
1920 TB=8
1930 PRINT TAB(TB);
1940 PRINT "This program is based on the paper 'SMALL HIGH EFFICIENCY ANTENNA',"
1950 PRINT TAB(TB);
1960 PRINT "by Ted Hart, W5QJR, in the June 1986 issue of QST, and the ARRL";
1970 PRINT TAB(TB);
1980 PRINT "ANTENNA BOOK, 17th Edition, pp. 5-10 to 5-16."
1990 PRINT TAB(TB);
2000 PRINT "  The program performs all the design calculations pertaining to"
2010 PRINT TAB(TB);
2020 PRINT "the original article, which should be consulted for construction"
2030 PRINT TAB(TB);
2040 PRINT "details and theory of operation. All equations have been updated.";
2050 RETURN
2060 :REM'
2070 :REM'.....diagram
2080 T=17:COLOR 0,7
2090 LOCATE ,T:PRINT "               tuning capacitor               "
2100 LOCATE ,T:PRINT "               ╔══════╡╞══════╗               "
2110 LOCATE ,T:PRINT " copper pipe──»║              ║               "
2120 LOCATE ,T:PRINT "               ║delta or gamma║               "
2130 LOCATE ,T:PRINT "               ║   ⌐match ¬   ║               "
2140 LOCATE ,T:PRINT "               ╚═══╤══════╤═══╝               "
2150 LOCATE ,T:PRINT "                   «─┬────»                   "
2160 LOCATE ,T:PRINT "                     └1/8 of loop perimeter   "
2170 LOCATE ,T:PRINT " 4-side loop shown - octagonal loop preferred "
2180 COLOR 7,0
2190 RETURN
2200 :REM'
2210 :REM'PRT
2220 KEY OFF:GOSUB 2290:LOCATE 25,5:COLOR 0,2
2230 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2240 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2250 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2250 :ELSE GOSUB 2290
2260 IF Z$="3"THEN RETURN
2270 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2280 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2220
2290 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
