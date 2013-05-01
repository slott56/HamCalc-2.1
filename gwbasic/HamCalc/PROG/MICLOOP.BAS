10 :REM'MICLOOP - Micro Miniature Loop Antenna - 05 DEC 02
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 LF=1/LOG(10)  :REM'factor to convert natural log to base 10
80 UL$=STRING$(80,205)
90 DIM C$(34,9)
100 DIM J(34,3)
110 :REM'
120 :REM'.....title page
130 CLS
140 COLOR 15,2,1
150 PRINT " MICROLOOP Micro Miniature Loop Antenna";
160 PRINT TAB(57)"by George Murphy VE3ERP ";
170 COLOR 1,0:PRINT STRING$(80,223);
180 COLOR 7,0
190 GOSUB 1630  :REM'diagram
200 LN=CSRLIN
210 PRINT
220 GOSUB 1890  :REM'preamble
230 COLOR 0,3:LOCATE 25,23:PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
240 Z$=INKEY$:IF Z$=""THEN 240
250 IF Z$="0"THEN COLOR 7,0,0:CLS:CHAIN GO$
260 IF Z$="1"THEN 290
270 GOTO 240
280 :REM'
290 :REM'.....data input
300 COLOR 7,0,0:GOSUB 2750
310 PRINT:LN=CSRLIN
320 PRINT "The MICROLOOP design is similar to the popular W5QJR Hart loop. It ";
330 PRINT "is smaller  "
340 PRINT "and therefore less efficient, but performs well where space is rest";
350 PRINT "ricted. If  "
360 PRINT "you want the most efficient loop design, go for the W5QJR Hart loop";
370 PRINT ", but if you"
380 PRINT "don't have the space, try the W2AHW MICROLOOP!                     "
390 PRINT
400 PRINT "Because of the narrow bandwidth of a loop antenna, it should be des";
410 PRINT "igned for a "
420 PRINT "specific operating frequency of interest rather than a band edge.  "
430 PRINT
440 PRINT "If a capacitor is used at (3) to replace the stub, it should be a h";
450 PRINT "igh voltage "
460 PRINT "split stator type."
470 :REM'
480 PRINT :LN=CSRLIN-1
490 INPUT "ENTER: Frequency (MHz)";F
500 WL=300/F   :REM'wavelength in metres
510 LN=CSRLIN-1:GOSUB 2750
520 INPUT "ENTER: Transmitter output (watts)";PWR
530 GOSUB 2750   :REM'erase to bottom of screen
540 COLOR 0,7
550 LN=20:GOSUB 2750
560 PRINT "  Very high voltages appear at the apex gap (3) in the loop. This v";
570 PRINT "oltage is a "
580 PRINT " function of the RF field strength in volts per metre (ARRL Antenna";
590 PRINT " Book, 18th "
600 PRINT " edition, p.5-3). At the design stage this value is unknown so sele";
610 PRINT "ct a cable  "
620 PRINT " with a high voltage breakdown point as your initial choice.       "
630 COLOR 7,0
640 :REM'
650 COLOR 0,3:LOCATE 25,26:PRINT " Press any key to continue ";:COLOR 7,0
660 IF INKEY$=""THEN 660
670 GOSUB 2190
680 CLS:COLOR 0,3,0:LOCATE 1,22
690 PRINT USING " W2AHW MICROLOOP for ###.### metres ";WL:COLOR 7,0
700 PRINT UL$;
710 LOCATE 3:GOSUB 1630
720 COLOR 0,7
730 LOCATE 3,26:PRINT LOOP$
740 COLOR 7,0
750 :REM'
760 P=0:N=10              :REM'seed factors
770 :REM'.....iteration
780 P=P+N
790 SIDE=P/8              :REM'length of one side
800 A=SIDE/TAN(22.5!*PI/180)
810 :REM'
820 :REM'.....calculate loop size and capacitance
830 B=A*TAN(22.5!*PI/180)  :REM'length of one side in inches
840 P=8*B                 :REM'loop perimeter in inches
850 CLOOP=P/12*CFT        :REM'loop capacitance
860 BCM=B*2.5399999618530273!            :REM'side length in centimeters
870 DCM=D*2.5399999618530273!            :REM'conductor diameter in centimeters
880 :REM'
890 :REM'.....ARRL Antenna Book, 18th edition, page 5-4, Table 1
900 E1=0.01600000075995922!*BCM
910 E2=2.61299991607666!*BCM/2^DCM
920 E3=0.07152999937534332!*2^DCM/BCM
930 LUH=E1*(LOG(E2)+0.7514299750328064!+E3)  :REM'inductance of octagonal loop
940 :REM'
950 CRES=25330.2890625!/F^2/LUH :REM'capacitance to resonate
960 CABL=CRES/CFT*12      :REM'cable length in inches
970 STUB=SQR(B^2/2)       :REM'stub length in inches
980 REQD=P+STUB           :REM'required cable length
990 IF ABS(CABL-REQD)<0.0010000000474974513! THEN 1030
1000 IF CABL<REQD THEN P=P-N:N=N/10
1010 GOTO 780
1020 :REM'
1030 XL=10^6/(2*PI*F*CRES) :REM'reactance
1040 CSTUB=CRES-CLOOP
1050 STUB=CSTUB/CFT*12     :REM'stub length in inches
1060 :REM'
1070 :REM'.....display
1080 LN=11:GOSUB 2750
1090 PRINT STRING$(80,196);
1100 LOCATE CSRLIN-1,41:PRINT "┬"
1110 PRINT USING " Resonant Frequency........ ####.### MHz│";F;
1120 PRINT USING "Reactance at resonance.... ####.### Ω  ";XL
1130 PRINT USING " Length of each side.....B= ####.### in.│";B;
1140 PRINT USING "Perimeter of octagon...... ####.### in.";P
1150 PRINT USING " Distance between sides..A= ####.### in.│";A;
1160 PRINT USING "Inductance of loop........ ####.### µH.";LUH
1170 PRINT USING " O.D. of coax braid........ ####.### in.│";D;
1180 PRINT USING "Coax cap'y per foot....... ####.### pF.";CFT
1190 PRINT USING " Cap'y needed to resonate.. ####.### pF.│";CRES;
1200 PRINT USING "Cap'y of cable in loop.... ####.### pF.";CLOOP
1210 PRINT USING " Length of stub..........S= ####.### in.│";STUB;
1220 PRINT USING "Cap'y of cable in stub.... ####.### pF.";CSTUB
1230 :REM'
1240 :REM'.....calculate variables
1250 BM=B*0.02539999969303608!                     :REM'octagon side in metres
1260 LR=(0.9959999918937683!*10^-6*SQR(F*10^6))/D  :REM'loss resistance - ohms per foot
1270 RL=P/12*LR                     :REM'loop loss resistance
1280 AR=4.828000068664551!*BM^2                  :REM'octagon area in square metres
1290 RR=3.119999885559082!*10^4*(1*AR/WL^2)^2     :REM'radiation resistance
1300 Q=XL/(2*(RR+RL))               :REM'loop Q
1310 BAND=F/Q*10^3                  :REM'bandwidth, kHz
1320 VC=SQR(PWR*XL*Q)               :REM'voltage across capacitor
1330 EFF=RR/(RR+RL)*100             :REM'efficiency %
1340 IL=SQR(PWR*Q/XL)               :REM'loop current at resonance
1350 :REM'
1360 PRINT USING " Bandwidth................. ####.### kHz│";BAND;
1370 PRINT USING "Loop Q.................... ########    ";Q
1380 PRINT USING " Radiation resistance...... ###.#### Ω  │";RR;
1390 PRINT USING "Loss resistance........... ###.#### Ω  ";RL
1400 IF VC<STUBV THEN 1430
1410 COLOR 14,4
1420 LN=CSRLIN:LOCATE 3,26:PRINT LOOP$:LOCATE LN
1430 PRINT USING " Xmitter output (watts).... ####.### W. │";PWR;
1440 PRINT USING "Voltage across loop ends.. ######## v. ";VC
1450 COLOR 7,0
1460 PRINT STRING$(80,196);
1470 LOCATE CSRLIN-1,41:PRINT "┴"
1480 :REM'
1490 C=3*CSTUB
1500 CC=CLOOP+C:F1=SQR(25330.2890625!/CC/LUH)
1510 F2=SQR(25330.2890625!/CLOOP/LUH)
1520 Z$="  (A ### pF variable capacitor in place of stub will "
1530 C$=Z$+"tune ##.### to ##.### MHz) "
1540 PRINT USING C$;C,F1,F2;
1550 PRINT UL$;
1560 IF VC<STUBV THEN 1590
1570 COLOR 14,4
1580 LOCATE 21,14:PRINT " D A N G E R !  Voltage exceeds capacity of cable ! ";
1590 COLOR 7,0
1600 GOTO 2790
1610 END
1620 :REM'
1630 :REM'.....diagram
1640 T=5
1650 COLOR 0,7
1660 LOCATE ,T:PRINT "    ╔════(3)════╗                                  "
1670 LOCATE ,T:PRINT "    ║     ║     ║    1» Coaxial cable loop         "
1680 LOCATE ,T:PRINT "  1»║   2»║     ║    2» Coaxial cable tuning stub  "
1690 LOCATE ,T:PRINT "    ║           ║   (3) (see enlarged detail)      "
1700 LOCATE ,T:PRINT "    ║  │«-B-»│  ║    B = 1/8 of loop perimeter     "
1710 LOCATE ,T:PRINT "    ╚══╤═════╤══╝                                  "
1720 LOCATE ,T:PRINT "       └─┐ ┌─┘«─Delta match to 50 Ω coax feedline  "
1730 COLOR 0,3
1740 LOCATE ,T:PRINT "(4-sided loop shown, but octagonal loop preferred.)"
1750 COLOR 0,7
1760 LOCATE 3:T=58
1770 LOCATE ,T:PRINT "       1 in.       "
1780 LOCATE ,T:PRINT "══════╤ gap ╤══════"
1790 LOCATE ,T:PRINT "─────────┐   ──────"
1800 LOCATE ,T:PRINT "═«1»═╤╧  ├──╧══«1»═"
1810 LOCATE ,T:PRINT "     │   │1 in.gap "
1820 LOCATE ,T:PRINT "     └─╥ │ ╖       "
1830 LOCATE ,T:PRINT "       ║ │ ║«2     "
1840 COLOR 0,3
1850 LOCATE ,T:PRINT "    Detail  (3)    "
1860 COLOR 7,0
1870 RETURN
1880 :REM'
1890 :REM'.....preamble
1900 TB=7
1910 PRINT TAB(TB);
1920 PRINT " The MICROLOOP design was conceived by Harold Kane, W2AHW, based on"
1930 PRINT TAB(TB);
1940 PRINT "the W5QJR Hart loop (The ARRL Antenna Book, 18th edition, p. 5-11)."
1950 PRINT TAB(TB);
1960 PRINT "The MICROLOOP consists of coaxial cable formed into an octagon with"
1970 PRINT TAB(TB);
1980 PRINT "a one inch gap (3) at the apex."
1990 PRINT TAB(TB);
2000 PRINT " It uses the outer conductor (shield) of coaxial cable as its      "
2010 PRINT TAB(TB);
2020 PRINT "radiating element, and the distributed capacitance of the coaxial  "
2030 PRINT TAB(TB);
2040 PRINT "cable for most of the capacitance required for resonance (ref. The "
2050 PRINT TAB(TB);
2060 PRINT "W1FB Loop, The ARRL Antenna Book, 18th edition, p. 5-19).          "
2070 PRINT TAB(TB);
2080 PRINT " The balance of the required capacitance is provided by a coaxial  "
2090 PRINT TAB(TB);
2100 PRINT "tuning stub. To expand the inherent narrow bandwidth of a small    "
2110 PRINT TAB(TB);
2120 PRINT "loop the stub may be replaced by a high-voltage variable capacitor."
2130 PRINT TAB(TB);
2140 PRINT " The primary equation by F.W.Grover of the US National Bureau of   "
2150 PRINT TAB(TB);
2160 PRINT "Standards is in the ARRL Antenna Book, 18th ed., p. 5-4, Table 1. ";
2170 RETURN
2180 :REM'
2190 :REM'.....coax cable list
2200 REM ..read data
2210 OPEN"I",1,"\hamcalc\coaxfile\coaxial.fil"
2220 FOR Z=1 TO 34:FOR Y=1 TO 9
2230 INPUT#1,Z$:C$(Z,Y)=Z$
2240 NEXT Y:NEXT Z
2250 CLOSE
2260 :REM'.....physical dimensions
2270 CLS:COLOR 7,0,0
2280 T1$=" Max    Braid    pF "
2290 T2$="volts   OD(in.) /ft."
2300 PRINT "Item"TAB(18)T1$;TAB(39)"│Item"TAB(59)T1$
2310 PRINT " No.   Type"TAB(18)T2$;TAB(39)"│ No.   Type";TAB(59)T2$
2320 FOR Z=1 TO 17
2330 HV=VAL(C$(Z,6)):J(Z,3)=HV
2340 HV1=VAL(C$(Z+17,6)):J(Z+17,3)=HV1
2350 E=VAL(C$(Z,3))       :REM'dielectric constant
2360 E1=VAL(C$(Z+17,3))   :REM'dielectric constant
2370 A$=C$(Z,1)           :REM'type
2380 A1$=C$(Z+17,1)       :REM'type
2390 B=VAL(C$(Z,5))       :REM'impedance
2400 B1=VAL(C$(Z+17,5))   :REM'impedance
2410 DD=10^(B*SQR(E)/138)    :REM'D/d factor
2420 DD1=10^(B1*SQR(E1)/138) :REM'D/d factor
2430 ID=VAL(C$(Z,8))      :REM'inner conductor diameter
2440 ID1=VAL(C$(Z+17,8))  :REM'inner conductor diameter
2450 D=DD*ID*1.0499999523162842!         :REM'braid OD (approx)
2460 J(Z,1)=D
2470 D1=DD1*ID1*1.0499999523162842!      :REM'braid OD (approx)
2480 J(Z+17,1)=D1
2490 CX=(7.260000228881836!*E/(LOG(DD)*LF))
2500 J(Z,2)=CX
2510 CX1=(7.260000228881836!*E1/(LOG(DD1)*LF))
2520 J(Z+17,2)=CX1
2530 Q$="######    .##    ##.#"
2540 IF Z<10 THEN PRINT " "+STR$(Z)+" ";:GOTO 2560
2550 PRINT STR$(Z)+" ";
2560 PRINT A$;
2570 PRINT TAB(17)USING Q$;HV,D,CX;
2580 PRINT TAB(39);"│";
2590 PRINT STR$(Z+17)+" ";
2600 PRINT A1$;
2610 PRINT TAB(58)USING Q$;HV1,D1,CX1
2620 NEXT Z
2630 PRINT "* = foam dielectric."
2640 COLOR 0,7
2650 PRINT " Note: The greater the loop braid OD, the higher the efficiency. ";
2660 PRINT "Cables with   "
2670 PRINT " braid dia. less then .29 not recommended. For maximum efficiency";
2680 PRINT " use RG-218.  "
2690 COLOR 7,0
2700 INPUT "ENTER: Item number to select a cable";Z
2710 D=J(Z,1):CFT=J(Z,2):LOOP$=C$(Z,1)+" -"+STR$(J(Z,3))+" max.volts"
2720 STUBV=J(Z,3)
2730 RETURN
2740 :REM'
2750 :REM'.....erase bottom of screen
2760 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
2770 RETURN
2780 :REM'
2790 :REM'.....end
2800 GOSUB 2820:GOTO 120
2810 :REM'
2820 :REM'.....PRT
2830 KEY OFF:GOSUB 2900:LOCATE 25,5:COLOR 0,2
2840 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2850 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2860 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2860 :ELSE GOSUB 2900
2870 IF Z$="3"THEN RETURN
2880 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2890 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2830
2900 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
