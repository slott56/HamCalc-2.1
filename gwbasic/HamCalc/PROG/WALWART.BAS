10 :REM'WALWART - Wall Wart Ratings - 27 NOV 2000
20 CLS:KEY OFF
30 PROG$="walwart"
40 COMMON EX$,PROG$
50 IF EX$=""THEN EX$="EXIT"
60 COLOR 7,0,1
70 UL$=STRING$(80,205)
80 :REM'
90 :REM'.....title page
100 RT=0
110 CLS
120 COLOR 15,2
130 PRINT " WALL WART RATINGS"TAB(57)"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 7,0
160 GOSUB 2300 :REM'page 1 text
170 :REM'
180 PRINT
190 LOCATE ,23:COLOR 0,7
200 PRINT " Press 1 to Continue or 0 to EXIT ":COLOR 7,0
210 Z$=INKEY$
220 IF Z$="0"THEN RUN EX$
230 IF Z$="1"THEN 260
240 GOTO 210
250 :REM'
260 :REM'.....page 2
270 CLS:COLOR 7,0,0:GOSUB 2640   :REM'page 2 text
280 PRINT UL$;
290 PRINT " Press number in ( ) to:"
300 PRINT UL$;
310 PRINT "   (1) Run Wall Wart program."
320 PRINT
330 PRINT "        Design and assemble a custom value resistor using either:"
340 PRINT "   (2) Multiple resistors of same standard value in parallel."
350 PRINT "        or"
360 PRINT "   (3) Two resistors of different standard values in parallel."
370 PRINT
380 PRINT "   (4) Design a Wall Wart voltage regulator."
390 PRINT
400 PRINT "   (0) EXIT";
410 Z$=INKEY$
420 IF Z$="0"THEN 90
430 IF Z$="1"THEN CLS:GOTO 490
440 IF Z$="2"THEN WART=RT:CHAIN "custohm"
450 IF Z$="3"THEN WART=RT:CHAIN "precires"
460 IF Z$="4"THEN CHAIN "LM317"
470 GOTO 410
480 :REM'
490 :REM'.....start
500 LOCATE ,31:COLOR 0,7:PRINT " WALL WART RATING ":COLOR 7,0
510 PRINT UL$;
520 LN=CSRLIN
530 PRINT
540 COLOR 0,7:INPUT " ENTER: Current rating on Wall Wart label (mA)";C1
550 COLOR 7,0:GOSUB 2870
560 PRINT USING " Manufacturer's current rating......... ####.# mA";C1
570 LN=CSRLIN
580 PRINT
590 COLOR 0,7:PRINT "  Measure output voltage with no load connected "
600 COLOR 7,0
610 PRINT
620 COLOR 0,7:INPUT " ENTER: Measured No-load voltage";V1
630 COLOR 7,0:GOSUB 2870
640 PRINT USING " Measured No-Load voltage.............. ####.## volts";V1
650 LN=CSRLIN
660 PRINT
670 RT=CINT(V1/SQR(2)/C1*1000)
680 PRINT " You will need to find or make two calibration power resistors: "
690 PRINT:COLOR 0,7
700 PRINT " #1 as close as possible to";RT;"ohms,  "
710 PRINT " #2 as close as possible to";RT/2;"ohms."
720 COLOR 7,0:PRINT
730 PRINT " Press 1 to continue or 2 to go find some resistors "
740 Z$=INKEY$:IF Z$=""THEN 740
750 IF Z$="1"THEN 790
760 IF Z$="2"THEN 260
770 GOTO 740
780 :REM'
790 COLOR 7,0
800 :REM'.....1st calibration resistor
810 C2=C1/1000
820 PRINT
830 COLOR 7,0
840 GOSUB 2870
850 PRINT
860 COLOR 0,7:PRINT " Measure the actual resistance of load resistor #1 ";
870 PRINT "(nominal";RT;"ohms)":COLOR 7,0
880 PRINT
890 COLOR 0,7:INPUT " ENTER: Actual resistance of load resistor #1 (ohms) ";R2
900 IF R2>=RT*0.949999988079071! AND R2<=RT*1.0499999523162842! THEN 1000
910 :REM'
920 PRINT
930 Z=LN:LN=CSRLIN:COLOR 7,0
940 GOSUB 2870:COLOR 0,3:LOCATE LN-1
950 PRINT " OK, but results would be more accurate if resistance were in the ";
960 PRINT "range of "
970 PRINT USING " ##.# - ##.#  ohms.";RT*0.949999988079071!,RT*1.0499999523162842!
980 LN=Z:COLOR 7,0
990 :REM'
1000 PRINT
1010 PT=V1^2/R2
1020 COLOR 15,1
1030 PRINT " Power dissipation will peak at about";
1040 COLOR 14,4:PRINT USING " ##.# watts ";PT;:COLOR 15,1
1050 PRINT "during the next measurement."
1060 PRINT " KEEP THE DURATION OF THE MEASUREMENT SHORT! "
1070 PRINT
1080 COLOR 0,7
1090 PRINT " Connect the";R2;"ohm resistor to the wall wart. Measure ";
1100 PRINT "voltage across it."
1110 PRINT
1120 COLOR 0,7:PRINT " ENTER: Voltage across the"R2;"ohm resistor ";:INPUT V2
1130 IF V2<V1 THEN 1160
1140 COLOR 7,0:GOSUB 2870:GOSUB 2030
1150 LOCATE LN+1:PRINT " Try another!";:GOTO 1120
1160 C3=V2/R2
1170 COLOR 7,0:GOSUB 2870
1180 PRINT " Calibration #1.............";
1190 T$=" ###.## v. @####.# mA, ##.# watts @ ##.# Ω load"
1200 PRINT USING T$;V2,C3*1000,V2*C3,V2/C3
1210 LN=CSRLIN
1220 :REM'
1230 :REM'.....2nd calibration resistor
1240 LN=CSRLIN
1250 PRINT:COLOR 0,7
1260 PRINT " Measure the actual resistance of load resistor #2 ";
1270 PRINT "(nominal";RT/2;"ohms)":COLOR 7,0
1280 PRINT
1290 COLOR 15,0:PRINT " KEEP THE DURATION OF THE MEASUREMENT SHORT! "
1300 PRINT
1310 COLOR 0,7:INPUT " ENTER: Actual resistance of load resistor #2 (ohms)";R3
1320 COLOR 7,0
1330 PRINT
1340 COLOR 7,0:GOSUB 2870
1350 PRINT
1360 COLOR 0,7
1370 PRINT " Connect the";R3;"ohm resistor to the wall wart. Measure ";
1380 PRINT "voltage across it.":COLOR 7,0
1390 PRINT
1400 COLOR 0,7:PRINT " ENTER: Voltage across the"R3;"ohm resistor ";:INPUT V3
1410 COLOR 7,0
1420 IF V3<V2 THEN 1450
1430 COLOR 7,0:GOSUB 2870:GOSUB 2030
1440 LOCATE LN+1:PRINT " Try another!";:GOTO 1400
1450 C4=V3/R3
1460 :REM'
1470 COLOR 7,0:GOSUB 2870
1480 PRINT " Calibration #2.............";
1490 T$=" ###.## v. @####.# mA, ##.# watts @ ##.# Ω load"
1500 PRINT USING T$;V3,C4*1000,V3*C4,V3/C4
1510 LN=CSRLIN
1520 GOSUB 2870
1530 PRINT UL$;
1540 LOCATE CSRLIN-1,24
1550 COLOR 0,7:PRINT " ESTIMATED RATINGS of WALL WART ":COLOR 7,0
1560   FOR Z=1 TO 12
1570 A=Z*C4/12
1580 :REM'
1590 IF A>=C3 THEN E=(V2-V3)/(C4-C3)*(A-C3):V4=V2-E
1600 IF A<C3 THEN E=(V1-V2)/C3*A:V4=V1-E
1610 IF FLAG=1 THEN COLOR 0,7 :ELSE COLOR 7,0
1620 T$="###.## volts @####.# mA. = ###.# watts, ####.# ohm load "
1630 LOCATE ,12:PRINT USING T$;V4,A*1000,V4*A,V4/A
1640 COLOR 7,0
1650 IF FLAG THEN 1700
1660   NEXT Z
1670 PRINT UL$;
1680 GOTO 1750
1690 :REM'
1700 IF A<=C1/1000.0! THEN 1750
1710 LOCATE 23
1720 LOCATE ,12:COLOR 0,7:PRINT " CAUTION!";
1730 PRINT USING " #####.# mA EXCEEDS MANUFACTURER's RATING ";A*1000
1740 :REM'
1750 LN=21:FLAG=0:COLOR 7,0
1760 GOSUB 2910
1770 GOSUB 2870
1780 PRINT " Want a specific load in ";
1790 PRINT "(v)olts,(m)illiamps,(o)hms, or just (q)uit?  (v/m/o/q)"
1800 Z$=INKEY$
1810 IF Z$="v"OR Z$="V"THEN 1980
1820 IF Z$="m"OR Z$="M"THEN 1870
1830 IF Z$="o"OR Z$="O"THEN 1930
1840 IF Z$="q"OR Z$="Q"THEN 260
1850 GOTO 1800
1860 :REM'
1870 GOSUB 2870:INPUT " ENTER: Load in mA.";Z:A=Z/1000
1880 GOSUB 2870
1890 IF A<0.0010000000474974513! OR A>(4*C2)THEN GOSUB 2030:GOTO 1700
1900 IF A>C2 THEN FLAG=1:GOTO 1590
1910 FLAG=1:GOTO 1590
1920 :REM'
1930 GOSUB 2870:INPUT " ENTER: Load in ohms";R2
1940 GOSUB 2870
1950 IF R2>=1 AND R2<10000.0! THEN 2070
1960 GOSUB 2030:GOTO 1750
1970 :REM'
1980 GOSUB 2870:INPUT " ENTER: Voltage";V
1990 GOSUB 2870
2000 IF V>=1 AND V<=V1 THEN 2180
2010 GOSUB 2030:GOTO 1750
2020 :REM'
2030 COLOR 7,0:GOSUB 2870:LOCATE 23,25:COLOR 0,7
2040 PRINT " Value entered is unreasonable ! ":COLOR 7,0
2050 RETURN
2060 :REM'
2070 :REM'.....specific ohms
2080 A=0:N=0.10000000149011612!
2090 A=A+N
2100 IF A>C3*11 THEN BEEP:GOSUB 2030:GOTO 1750
2110 IF A>=C3 THEN E=(V2-V3)/(C4-C3)*(A-C3):V4=V2-E
2120 IF A<C3 THEN E=(V1-V2)/C3*A:V4=V1-E
2130 R3=V4/A
2140 IF ABS(R2-R3)<0.0010000000474974513! THEN FLAG=1:GOTO 1590
2150 IF R3<R2 THEN A=A-N:N=N/10
2160 GOTO 2090
2170 :REM'
2180 :REM'.....specific volts
2190 A=0:N=0.10000000149011612!
2200 A=A+N
2210 IF A>C3*11 THEN BEEP:GOSUB 2030:GOTO 1750
2220 IF A>=C3 THEN E=(V2-V3)/(C4-C3)*(A-C3):V4=V2-E
2230 IF A<C3 THEN E=(V1-V2)/C3*A:V4=V1-E
2240 R3=V4/A:R4=V/A
2250 IF ABS(R3-R4)<0.0010000000474974513! THEN FLAG=1:GOTO 1590
2260 IF R4>R3 THEN A=A-N:N=N/10
2270 GOTO 2200
2280 END
2290 :REM'
2300 :REM'.....page 1 text
2310 PRINT " Wall Warts are those ubiquitous little cubical low voltage DC pow";
2320 PRINT "er supplies  "
2330 PRINT " that plug into a wall socket to run almost every electronic gadge";
2340 PRINT "t on the     "
2350 PRINT " market today. Long after the gadget has been discarded or replace";
2360 PRINT "d with the   "
2370 PRINT " latest model of whatever it was, the Wall Wart that came with it ";
2380 PRINT "remains,     "
2390 PRINT " simply because it is ";
2400 PRINT CHR$(34);"too good to throw away";CHR$(34);"."
2410 PRINT
2420 PRINT " Wall Warts are unregulated power supplies whose output voltage va";
2430 PRINT "ries with the"
2440 PRINT " current drawn from them. They can be re-rated for use with other ";
2450 PRINT "devices as   "
2460 PRINT " long as you are not too fussy about the exact output voltage at t";
2470 PRINT "he current   "
2480 PRINT " drawn by the device, or you can use a Wall Wart that provides a h";
2490 PRINT "igher voltage"
2500 PRINT " than required and add a voltage regulator to achieve an exact vol";
2510 PRINT "tage.        "
2520 PRINT
2530 PRINT " Usual precautions apply if the device draws current much in exces";
2540 PRINT "s of the     "
2550 PRINT " current rating marked on the Wall Wart. (e.g., proper cooling, in";
2560 PRINT "termittent   "
2570 PRINT " light duty only, etc.)."
2580 PRINT UL$;
2590 PRINT " Reference:"
2600 PRINT " ";CHR$(34)"Reusing the Wall Wart";CHR$(34);" by Phil Karras, ";
2610 PRINT "KE3FL, QRP Quarterly, July 2000, p.54."
2620 RETURN
2630 :REM'
2640 :REM'.....page 2 text
2650 PRINT " This programs calculates Wall Wart RATINGS only. Actual outputs o";
2660 PRINT "f individual "
2670 PRINT " units from various manufacturers may differ somewhat from the gen";
2680 PRINT "eric ratings."
2690 PRINT
2700 PRINT " When using a Wall Wart with a device other than that with which i";
2710 PRINT "t came,      "
2720 PRINT " replace the connector on the end of the Wall Wart output cable wi";
2730 PRINT "th one to    "
2740 PRINT " suit the DC input socket or terminals of the device.             "
2750 PRINT
2760 PRINT " Calibration requires resistors that may be of non-standard values";
2770 PRINT ". if there is"
2780 PRINT " nothing on hand that is close you can make them using options (2)";
2790 PRINT " and/or (3)  "
2800 PRINT " in the menu below. This menu reappears at the conclusion of each ";
2810 PRINT "program run. "
2820 PRINT " Or try them now. ";
2830 IF RT=0 THEN PRINT "":GOTO 2890
2840 COLOR 0,7:PRINT " You are looking for";RT;"and";RT/2;"ohms. ":COLOR 7,0
2850 RETURN
2860 :REM'
2870 :REM'.....erase to bottom of screen
2880 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
2890 RETURN
2900 :REM'
2910 :REM'.....PRT
2920 KEY OFF:GOSUB 2990:LOCATE 25,5:COLOR 0,2
2930 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2940 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2950 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2950 :ELSE GOSUB 2990
2960 IF Z$="3"THEN RETURN
2970 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2980 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2920
2990 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
