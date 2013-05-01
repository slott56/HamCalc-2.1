10 :REM'PSYCHROM - Thermodynamics - 22 APR 2004
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 UL$=STRING$(80,205)
80 U1$="#####.###"
90 T$="THERMODYNAMICS"
100 :REM'
110 COLOR 15,2,1
120 PRINT " ";T$;TAB(55);"by H.K.McMillan and J.Kim ";
130 COLOR 1,0:PRINT STRING$(80,223);""
140 COLOR 15,2:LOCATE 2,27:PRINT " algorithm by R.J.Dehoney "
150 :REM'
160 COLOR 7,0
170 PRINT
180 PRINT "This program determines the thermodynamics of moist air in the"
190 PRINT "temperature range 0-50° C (32-122°  F). The program has 8 outputs:"
200 PRINT "      Barometric Pressure,   Dry Bulb Temperature,"
210 PRINT "      Wet Bulb Temperature,  Dew Point Temperature,"
220 PRINT "      Relative Humidity,     Humidity Ratio,"
230 PRINT "      Specific Enthalpy of the moist air, and"
240 PRINT "      Specific Volume of the moist air."
250 PRINT "User can specify outputs and inputs in either English/USA or SI (";
260 PRINT "metric) units."
270 PRINT "      Three inputs are required"
280 PRINT "      1. Barometric Pressure"
290 PRINT "      2. Dry Bulb Temperature"
300 PRINT "      3. User preference of either:"
310 PRINT "             a) Wet Bulb Temperature"
320 PRINT "             b) Dew Point Temperature"
330 PRINT "             c) Relative Humidity"
340 PRINT "The program assumes that dry air and water vapor behave as perfect";
350 PRINT " gases."
360 PRINT
370 PRINT "To continue.........press 1"
380 PRINT "To EXIT.............press 0"
390 Z$=INKEY$:IF Z$=""THEN 390
400 IF Z$="1" THEN 430
410 IF Z$="0" THEN CLS:CHAIN GO$
420 GOTO 390
430 CLS:COLOR 7,0,0
440 PRINT "Specify the barometric pressure units by entering the number."
450 PRINT "         1) U.S. Standard Atmosphere (14.696 PSI)"
460 PRINT "         2) Pounds per square inch (PSI)"
470 PRINT "         3) Kilopascals (KPA)"
480 PRINT "         4) Inches of mercury"
490 INPUT "Enter <1 to 4> ";UNIP :PRINT
500 ONUNIP GOTO 510,520,540,560
510 PT=14.696000099182129! :GOTO 590
520 PRINT "Enter: pressure in pounds per square inch (PSI)";
530 INPUT " ";PT :GOTO 590
540 PRINT "Enter: pressure in kilopascals (KPA) ";
550 INPUT " ";PT :PT=0.14504000544548035!*PT :GOTO 590
560 PRINT "Enter: pressure in decinal inches of mercury";
570 INPUT " ";PT :PT=0.4909999966621399!*PT
580 PRINT
590 CLS: PRINT "Input temperatures in (f)ahrenheit or (c)elsius   (f/c)?"
600 A$=INKEY$:IF A$=""THEN 600
610 IF A$="f"OR A$="F"THEN UNI=1:GOTO 640
620 IF A$="c"OR A$="C"THEN UNI=2:GOTO 640
630 GOTO 600
640 CLS
650 PRINT "For program ouputs in English/USA units.............press 1"
660 PRINT "For program ouputs in SI (metric) units.............press 2"
670 Z$=INKEY$:IF Z$=""THEN 670
680 IF Z$="1"THEN UNO=1:GOTO 710
690 IF Z$="2"THEN UNO=2:GOTO 710
700 GOTO 670
710 CLS
720 PRINT "Choose which of the following three optional inputs you want to use:"
730 PRINT "          1) Wet Bulb Temperature"
740 PRINT "          2) Dew Point Temperature"
750 PRINT "          3) Relative Humidity"
760 PRINT
770 INPUT "Enter number (1,2,3) ";VAR3
780 ONVAR3 GOSUB 970, 1310, 1560
790 GOSUB 2210
800 PRINT STRING$(80,205);
810 COLOR 0,7
820 PRINT "(See also the HAMCALC ";CHR$(34);"Barometer Reading Equivalents";
830 PRINT CHR$(34);" program)":COLOR 7,0
840 PRINT
850 GOSUB 2880
860 CLS
870 PRINT "To re-run program............press 1"
880 PRINT "To QUIT......................press 0"
890 Z$=INKEY$:IF Z$=""THEN 890
900 IF Z$="0"THEN 110
910 IF Z$="1"THEN 930
920 CLS:INPUT "To re-run the program, enter <1> else <CR> ",RA
930 CLS
940 INPUT "New pressure? <y/n) ",A$
950 IF A$="y" THEN 430 :ELSE 590
960 :REM'
970 :REM'Subroutine to calc moist air properties using pressure and wet/dry temp.
980 CLS : ONUNI GOTO 1070,990
990 PRINT "Mandatory input:"
1000 INPUT "Enter: dry bulb temperature between 0 and 50 degrees C ";TDB
1010 PRINT
1020 PRINT "Optional input:"
1030 INPUT "Enter: wet bulb temperature in degrees C ";TWB
1040 TDB=1.7999999523162842!*TDB+32
1050 TWB=1.7999999523162842!*TWB+32
1060 GOTO 1110
1070 PRINT "Mandatory input:"
1080 INPUT "Enter: dry bulb temp between 32 and 122 degrees F ";TDB
1090 INPUT "Enter: wet bulb temp in degrees F";TWB
1100 PRINT
1110 T=TWB
1120 GOSUB 1800
1130 PSTWB=P
1140 HVTDB=1061.800048828125!+0.4399999976158142!*TDB
1150 HVTWB=1061.800048828125!+0.4399999976158142!*TWB
1160 HFTWB=TWB-32
1170 WTWB=(0.6219800114631653!*PSTWB)/(PT-PSTWB)
1180 W=(0.23999999463558197!*(TWB-TDB)+WTWB*(HVTWB-HFTWB))/(HVTDB-HFTWB)
1190 PV=(W*PT)/(0.6219800114631653!+W)
1200 T=TDB
1210 GOSUB 1800
1220 PS=P
1230 RH=PV/PS
1240 H=0.23999999463558197!*TDB+W*HVTDB
1250 V=(53.35200119018555!*(TDB+460))/((PT-PV)*144.0!)
1260 P=PV
1270 GOSUB 1840
1280 TDP=T
1290 RETURN
1300 :REM'
1310 :REM'Subroutine to calculate moist air properties given pressure, dry bulb temp
1320 :REM'and dew point temperature
1330 CLS : ONUNI GOTO 1400,1340
1340 PRINT "Mandatory input:"
1350 INPUT "Enter: dry bulb temp between 0.0 and 49.0 degrees C ";TDB
1360 INPUT "Enter: dew point temp between 0.0 and 49.0 degrees C ";TDP
1370 TDB=32.0!+1.7999999523162842!*TDB
1380 TDP=32.0!+1.7999999523162842!*TDP
1390 GOTO 1430
1400 PRINT "Mandatory input:"
1410 INPUT "Enter: dry bulb temp between 32.0 and 120.0 degrees F ";TDB
1420 INPUT "Enter: dew point temp between 32.0 and 120.0 degrees F ";TDP
1430 T=TDP
1440 GOSUB 1800
1450 PV=P
1460 W=0.6219800114631653!*PV/(PT-PV)
1470 H=0.23999999463558197!*TDB+W*(0.4399999976158142!*TDB+1061.800048828125!)
1480 V=53.35200119018555!*(TDB+460)/((PT-PV)*144.0!)
1490 T=TDB
1500 GOSUB 1800
1510 PS=P
1520 RH=PV/PS
1530 GOSUB 1880
1540 RETURN
1550 :REM'
1560 :REM'Subroutine to calculate moist air properties given pressure, dry bulb temp
1570 :REM'and relative humidity.
1580 CLS : ONUNI GOTO 1630,1590
1590 PRINT "Optional input:"
1600 INPUT "Enter: dry bulb temp between 0 and 50 degrees C ";TDB
1610 TDB=32.0!+1.7999999523162842!*TDB
1620 GOTO 1650
1630 PRINT "Mandatory input:"
1640 INPUT "Enter: dry bulb temp between 32.0 and 122.0 degrees F ";TDB
1650 INPUT "Enter: relative humidity as <xx.x> percent ";RH
1660 RH=RH/100
1670 T=TDB
1680 GOSUB 1800
1690 PS=P
1700 PV=RH*PS
1710 W=0.6219800114631653!*PV/(PT-PV)
1720 H=0.23999999463558197!*TDB+W*(0.4399999976158142!*TDB+1061.800048828125!)
1730 V=53.35200119018555!*(TDB+460)/((PT-PV)*144.0!)
1740 P=PV
1750 GOSUB 1840
1760 TDP=T
1770 GOSUB 1880
1780 RETURN
1790 :REM'
1800 :REM'Subroutine to calculate saturation pressure
1810 P=0.020663000643253326!+0.0011739999754354358!*T+1.570899985381402e-05!*T^2+3.9964999132280354e-07!*T^3+4.5258999326058813e-10!*T^4                     +2.0915999834891785e-11!*T^5
1820 RETURN
1830 :REM'
1840 :REM'Subroutine to calculate Saturation Temperature
1850 T=0.19336000084877014!+484.8900146484375!*P-1744.5999755859375!*P^2+4378*P^3-6961.5!*P^4+6884.60009765625!*P^5                       -4088.39990234375!*P^6+1330.5!*P^7-181.9499969482422!*P^8
1860 RETURN
1870 :REM'
1880 :REM'Subroutine to calculate wet bulb temp
1890 WTDP=W
1900 FTDP=(TDP-TDB)*(0.23999999463558197!+0.4399999976158142!*WTDP)
1910 WTDB=0.6219800114631653!*PS/(PT-PS)
1920 FTDB=(WTDB-WTDP)*(1093.800048828125!-TDB*0.5600000023841858!)
1930 TWBLI=TDP-(TDB-TDP)*(FTDP/(FTDB-FTDP))
1940 WBT=TWBLI
1950 GOSUB 2120
1960 IF FWBT>0 THEN 1970 :ELSE 2030
1970 WBT=WBT-1
1980 GOSUB 2120
1990 IF FWBT>0 THEN 1970 :ELSE 2000
2000 WBT=WBT+0.10000000149011612!
2010 GOSUB 2120
2020 IF FWBT>0 THEN 2090 :ELSE 2000
2030 WBT=WBT+1
2040 GOSUB 2120
2050 IF FWBT>0 THEN 2060 :ELSE 2030
2060 WBT=WBT-0.10000000149011612!
2070 GOSUB 2120
2080 IF FWBT>0 THEN 2060 :ELSE 2090
2090 TWB=WBT
2100 RETURN
2110 :REM'
2120 :REM'Subroutine to "Temp Function" used in finding the wet bulb temp
2130 T=WBT
2140 GOSUB 1800
2150 PSWBT=P
2160 WWBT=0.6219800114631653!*PSWBT/(PT-PSWBT)
2170 WTDP=W
2180 FWBT=0.23999999463558197!*(WBT-TDB)+0.4399999976158142!*(WWBT*WBT-WTDP*TDB)+(WWBT-WTDP)*(1093.800048828125!-WBT)
2190 RETURN
2200 :REM'
2210 :REM'Subroutine to convert outputs and print
2220 CLS
2230 RH=100*RH
2240 ONUNO GOTO 2590, 2250
2250 PT=6.894599914550781!*PT
2260 TDB=0.5555499792098999!*(TDB-32)
2270 TWB=0.5555499792098999!*(TWB-32)
2280 TDP=0.5555499792098999!*(TDP-32)
2290 H=2.3259999752044678!*H
2300 V=0.06242800131440163!*V
2310 PRINT T$
2320 PRINT STRING$(80,205);
2330 PRINT "Barometric Pressure      ";
2340 PRINT USING "####.##"; PT;
2350 PRINT " KPA"
2360 PRINT "Dry Bulb Temperature      ";
2370 PRINT USING "####.#"; TDB;
2380 PRINT "°C"
2390 PRINT "Wet Bulb Temperature      ";
2400 PRINT USING "####.#"; TWB;
2410 PRINT "°C"
2420 PRINT "Dew Point Temperature     ";
2430 PRINT USING "####.#"; TDP;
2440 PRINT "°C"
2450 PRINT "Relative Humidity         ";
2460 PRINT USING "####.#"; RH;
2470 PRINT " %"
2480 PRINT "Humidity Ratio            ";
2490 PRINT USING "##.###"; W;
2500 PRINT " Kg/Kg Dry Air"
2510 PRINT "Specific Enthalpy         ";
2520 PRINT USING "####.#"; H;
2530 PRINT " Kg/Kg Dry Air"
2540 PRINT "Specific Volume           ";
2550 PRINT USING "#.####"; V;
2560 PRINT " Cu.M/Kg Dry Air"
2570 PT=PT/6.394599914550781!
2580 GOTO 2850
2590 PRINT T$
2600 PRINT STRING$(80,205);
2610 PRINT "Barometric Pressure       ";
2620 PRINT USING "###.###"; PT;
2630 PRINT " PSI"
2640 PRINT "Dry Bulb Temperature      ";
2650 PRINT USING "###.#"; TDB;
2660 PRINT "°F"
2670 PRINT "Wet Bulb Temperature      ";
2680 PRINT USING "###.#"; TWB;
2690 PRINT "°F"
2700 PRINT "Dew Point Temperature     ";
2710 PRINT USING "###.#"; TDP;
2720 PRINT "°F"
2730 PRINT "Relative Humidity         ";
2740 PRINT USING "###.#"; RH;
2750 PRINT " %"
2760 PRINT "Humidity Ratio            ";
2770 PRINT USING "#.###"; W;
2780 PRINT " Lb/Lb Dry Air"
2790 PRINT "Specific Enthalpy         ";
2800 PRINT USING "###.#"; H;
2810 PRINT " BTU/Lb Dry Air"
2820 PRINT "Specific Volume           ";
2830 PRINT USING "##.##"; V;
2840 PRINT " Cu.Ft/Lb Dry Air"
2850 RETURN
2860 END
2870 :REM'
2880 :REM'.....PRT
2890 KEY OFF:GOSUB 2960:LOCATE 25,5:COLOR 0,2
2900 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2910 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2920 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2920 :ELSE GOSUB 2960
2930 IF Z$="3"THEN RETURN
2940 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2950 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2890
2960 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
2970 :REM'PRINT "Optional input:"
2980 PRINT "Optional input:"
