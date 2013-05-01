10 :REM'NICAD - 18 JUN 92 rev.12 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 U$="####,###.###"
70 U1$="####,###"
80 DIM R(22)         :REM'Radio Shack resistors
90 :REM'
100 :REM'.....start
110 CLS
120 COLOR 15,2
130 PRINT " NiCad BATTERY DISCHARGER";TAB(57);"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 7,0
160 PRINT UL$;
170 :REM'
180 GOSUB 1600         :REM'display page 1
190 LOCATE 25,24:COLOR 0,7
200 PRINT " Press 1 to CONTINUE or 0 to EXIT ";
210 COLOR 7,0
220 Z$=INKEY$:IF Z$=""THEN 220
230 IF Z$="0"THEN CLS:RUN EX$
240 IF Z$="1"THEN 260
250 GOTO 220
260 LOCATE 25,1:PRINT STRING$(80,32);
270 GOSUB 2200         :REM'screen dump
280 GOSUB 320          :REM'run calculator program
290 GOSUB 2200         :REM'screen dump
300 GOTO 100           :REM'start
310 :REM'
320 :REM'.....run
330 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
340 :REM'.....standard Radio Shack 1/2 watt 10% resistors
350 DATA 10,22,33,47,100,220,330,470,560,680,1000,1500,2200,4700,5600
360 DATA 10e3,15e3,22e3,47e3,1e5,1e6,2.2e5
370  FOR Z=1 TO 22
380   READ R(Z)
390  NEXT Z
400 :REM'
410 :REM'.....input data
420 PRINT " Press letter in < > to select a close description of your battery:"
430 PRINT UL$;
440 PRINT "  <a>  1.2 volts,  1 cell"
450 PRINT "  <b)  2.4 volts,  2 cells"
460 PRINT "  <c>  3.6 volts,  3 cells"
470 PRINT "  <d>  4.8 volts,  4 cells"
480 PRINT "  <e>  6.0 volts,  5 cells"
490 PRINT "  <f>  7.2 volts,  6 cells"
500 PRINT "  <g>  8.4 volts,  7 cells"
510 PRINT "  <h>  9.6 volts,  8 cells"
520 PRINT "  <i> 10.8 volts,  9 cells"
530 PRINT "  <j> 12.0 volts, 10 cells"
540 PRINT "  <k> more than 12 volts"
550 Z$=INKEY$
560 IF Z$="a"OR Z$="A"THEN E=1.2000000476837158!
570 IF Z$="b"OR Z$="B"THEN E=2.4000000953674316!
580 IF Z$="c"OR Z$="C"THEN E=3.5999999046325684!
590 IF Z$="d"OR Z$="D"THEN E=4.800000190734863!
600 IF Z$="e"OR Z$="E"THEN E=6
610 IF Z$="f"OR Z$="F"THEN E=7.199999809265137!
620 IF Z$="g"OR Z$="G"THEN E=8.399998664855957!
630 IF Z$="h"OR Z$="H"THEN E=9.600001335144043!
640 IF Z$="i"OR Z$="I"THEN E=10.800000190734863!
650 IF Z$="j"OR Z$="J"THEN E=12
660 IF Z$="k"OR Z$="K"THEN CLS:GOTO 680
670 IF E THEN 700 :ELSE 550
680 INPUT "ENTER: Voltage of your NiCad battery pack.........................";E
690 IF E=0 THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):LOCATE CSRLIN-1:GOTO 680
700 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
710 C=CINT(E/1.2000000476837158!)      :REM'number of cells
720 DV=C*1             :REM'minimum discharge voltage @ 1 volt per cell
730 PRINT " What is the power consumption of the device operated by this";
740 PRINT " battery pack"
750 PRINT " under normal full load operating conditions ? ........."
760 PRINT UL$;
770 PRINT " Press <1> to enter consumption in watts"
780 PRINT "  -or-"
790 PRINT " Press <2) to enter power consumption in amperes"
800 Z$=INKEY$
810 IF Z$="1"OR Z$="2"THEN 840
820 GOTO 800
830 :REM'
840 :REM'.....calculate resistance
850 IF Z$="1"THEN Z$="watts"
860 IF Z$="2"THEN Z$="amps."
870 PRINT UL$;
880 PRINT " ENTER: Full load power consumption of the device in ";Z$;
890 PRINT STRING$(9,46);
900 INPUT Z
910 IF Z=0 THEN 880
920 IF Z$="watts"THEN I=Z/E       :REM'current in amps if watts known
930 IF Z$="amps."THEN I=Z         :REM'current in amps
940 R=E/I                         :REM'load resistance of device
950 P=I*E                         :REM'power consumption of device in watts
960 CLS
970 PRINT " Your battery pack is accustomed to operating under the following ";
980 PRINT "conditions:"
990 PRINT UL$;
1000 PRINT " Voltage....................";USING U$;E;
1010 PRINT "   (";C;"cells @ 1.2 volts each )"
1020 PRINT " Full load current (amperes)";USING U$;I
1030 PRINT " Load resistance (ohms).....";USING U$;R
1040 PRINT " Power consumption (watts)..";USING U$;P
1050 PRINT UL$;
1060 PRINT " The battery pack can therefore be discharged safely through a ";
1070 PRINT "load of not less"
1080 PRINT " than";CINT(R);:PRINT "ohms with a minumum rating of";
1090 :REM'
1100 IF P<0.5! THEN P=0.5!:GOTO 1120         :REM'minimum rating 1/2 watt
1110 IF INT(P)<>P THEN P=INT(P)+1       :REM'round off to next higher integer
1120 PRINT CINT(P);"watt";
1130 IF CINT(P)>1 THEN PRINT "s";
1140 PRINT "."
1150 PRINT
1160 PRINT " A suitable load can be made from standard resistors as follows:"
1170 PRINT UL$;
1180 :REM'
1190 :REM'.....calculate quantity of resistors in parallel
1200 N=INT(P/0.5!)+1                      :REM'number of 1/2 watt resistors
1210 W=N*0.5!                             :REM'total wattage rating
1220 :REM'
1230 :REM'.....find nearest standard resistor
1240 X=N/(1/R)                          :REM'net resistance
1250  FOR Z=1 TO 22
1260   IF R(Z)>=X THEN 1360
1270  NEXT Z
1280 BEEP:CLS
1290 PRINT " The data you have entered requires a resistor of";X;"ohms."
1300 PRINT
1310 PRINT " This value is probably not easily available..........."
1320 PRINT
1330 PRINT " Press any key to start over..........."
1340 IF INKEY$=""THEN 1340 :ELSE ERASE R:RESTORE:GOTO 30
1350 :REM'
1360 :REM'.....display results
1370 T=1/(N/R(Z))                      :REM'net resistance
1380 PRINT " Quantity of resistors......";USING U1$;N;
1390 PRINT " connected in parallel"
1400 PRINT " Each resistor..............";USING U1$;R(Z);
1410 PRINT " ohms, 1/2 watt, 10% tolerance"
1420 PRINT " Net resistance.............";USING U$;T;:PRINT " ohms"
1430 PRINT " Power dissipation..........";USING U$;W;:PRINT " watts"
1440 PRINT
1450 PRINT " (NOTE: any 1/2 watt resistor from";CINT(X);"to";INT(R(Z));
1460 PRINT "ohms may be substituted)"
1470 PRINT UL$;
1480 PRINT " If your device uses more than one cell then discharge all cells ";
1490 PRINT "together as a"
1500 PRINT " battery pack unit rather than individually."
1510 PRINT
1520 LOCATE CSRLIN,5
1530 COLOR 15,1
1540 PRINT " DISCHARGE THE BATTERY PACK TO";DV;"VOLTS";
1550 PRINT ", BUT NOT LESS before recharging. "
1560 COLOR 7,0
1570 PRINT UL$;
1580 RETURN
1590 :REM'
1600 :REM'.....page 1
1610 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1620 :REM'.....text
1630 TB=(8)       :REM'tab for text
1640 GOSUB 1990   :REM'text block
1650 PRINT
1660 PRINT UL$;
1670 :REM'
1680 :REM'.....schematic
1690 R=15   :REM'row
1700 LOCATE R
1710 COLOR 0,7
1720 LOCATE CSRLIN,2:PRINT " + ┌───┬─┬─┬─┬─┬────┐   "
1730 LOCATE CSRLIN,2:PRINT " A ▀  ┌┴┐│┌┴┐│┌┴┐   │   "
1740 LOCATE CSRLIN,2:PRINT "      │R│││R│││R│   │ + "
1750 LOCATE CSRLIN,2:PRINT "      └┬┘│└┬┘│└┬┘   ▀ C "
1760 LOCATE CSRLIN,2:PRINT "       │ │ │ │ │  ╞═══╡ "
1770 LOCATE CSRLIN,2:PRINT "       │┌┴┐│┌┴┐│    ▄ D "
1780 LOCATE CSRLIN,2:PRINT "       ││R│││R││    │ - "
1790 LOCATE CSRLIN,2:PRINT " B ▄   │└┬┘│└┬┘│    │   "
1800 LOCATE CSRLIN,2:PRINT " - └───┴─┴─┴─┴─┴────┘   "
1810 COLOR 7,0
1820 :REM'
1830 :REM'.....legend
1840 X=28   :REM'column
1850 LOCATE R,X-1
1860 PRINT "LEGEND"
1870 LOCATE R+1,X-1
1880 PRINT "------"
1890 LOCATE R+2,X
1900 PRINT "A,B  Screw heads or pin jacks for voltmeter readings"
1910 LOCATE R+4,X
1920 PRINT "C,D  Screw heads spaced to match contacts on battery"
1930 LOCATE R+6,X-1
1940 PRINT "╞═══╡ Elastic band to press battery against C & D"
1950 LOCATE R+8,X
1960 PRINT " R   Resistors (program will show values & how many)"
1970 RETURN
1980 :REM'
1990 :REM'.....text block
2000 PRINT TAB(TB);
2010 PRINT "NiCad batteries SHOULD NOT be recharged at random. Before"
2020 PRINT TAB(TB);
2030 PRINT "recharging they SHOULD be discharged to a level of 1 volt per"
2040 PRINT TAB(TB);
2050 PRINT "cell. Battery packs consisting of 2 or more individual 1.2 volt"
2060 PRINT TAB(TB);
2070 PRINT "NiCad batteries should NOT be discharged singly, but as a unit."
2080 PRINT
2090 PRINT TAB(TB);
2100 PRINT "Discharging should be through a load that approximates the load"
2110 PRINT TAB(TB);
2120 PRINT "that the battery or battery pack is accustomed to operating."
2130 PRINT
2140 PRINT TAB(TB);
2150 PRINT "This program can help you design and build a simple NiCad battery"
2160 PRINT TAB(TB);
2170 PRINT "discharger as shown below:"
2180 RETURN
2190 :REM'
2200 :REM'PRT
2210 KEY OFF:GOSUB 2280:LOCATE 25,5:COLOR 0,2
2220 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2230 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2240 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2240 :ELSE GOSUB 2280
2250 IF Z$="3"THEN RETURN
2260 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2270 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2210
2280 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
