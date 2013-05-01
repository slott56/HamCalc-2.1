10 :REM'METERS - Meters (DC) - 15 DEC 85 rev. 05 OCT 2007
20 IF EX$=""THEN EX$="exit"
30 PROG$="meters"
40 COMMON EX$,PROG$,R,E  :REM'for chaining to PRECIRES
50 CLS:KEY OFF
60 COLOR 7,0,1
70 PI=3.1415929794311523!
80 UL$=STRING$(80,205)       :REM'underline
90 ER$=STRING$(80,32)        :REM'erase
100 U$="####,###.###"
110 DIM A(50)                 :REM'AWG sizes (American Wire Gauge)
120 :REM'
130 :REM'.....AWG wire sizes
140 K#= (0.46000000834465027!/0.004999999888241291!)^(1/39)        :REM'incremental multiplier
150 FOR Z=1 TO 50
160 N=Z+3
170 WIRE=0.46000000834465027!/K#^N         :REM'wire diameter in inches
180 A(Z)=WIRE             :REM'wire diameter in inches
190 NEXT Z
200 :REM'
210 :REM'.....start
220 COLOR 15,2
230 PRINT " METERS (Direct-Current)";TAB(57);"by George Murphy VE3ERP ";
240 COLOR 1,0:PRINT STRING$(80,223);
250 COLOR 7,0
260 T=7
270 PRINT TAB(T);
280 PRINT "This program calculates values of shunts and multipliers required"
290 PRINT TAB(T);
300 PRINT "to convert basic d'Arsonval meter movements into practical meters"
310 PRINT TAB(T);
320 PRINT "for measuring DC current or voltage. The program also calculates"
330 PRINT TAB(T);
340 PRINT "the internal resistance of a meter movement."
350 PRINT
360 PRINT TAB(T);
370 PRINT "WARNING! The internal resistance of a meter cannot be measured"
380 PRINT TAB(T);
390 PRINT "directly with an ohmmeter without risk of damage to the meter"
400 PRINT TAB(T);
410 PRINT "movement!"
420 PRINT UL$;
430 PRINT " Press number in < > to calculate:"
440 PRINT UL$;
450 PRINT "  < 1 >  Ammeter shunt"
460 PRINT "  < 2 >  Voltmeter multiplier"
470 PRINT "  < 3 >  Meter internal resistance"
480 PRINT UL$;
490 PRINT "    or press < 0 > to EXIT....."
500 Z$=INKEY$
510 IF Z$="0"THEN CLS:RUN EX$
520 IF Z$="1"THEN 570
530 IF Z$="2"THEN 1800
540 IF Z$="3"THEN 2690
550 GOTO 500
560 :REM'
570 :REM'.....ammeter
580 LOCATE CSRLIN-1
590 PRINT " Press number in < > to choose standard units of measure:"
600 PRINT UL$;
610 PRINT "  < 3 >  Metric"
620 PRINT "  < 4 >  U.S.A./Imperial"
630 PRINT UL$;
640 Z$=INKEY$
650 IF Z$="3"THEN UM=25.399999618530273!:UM$="mm.":GOTO 680
660 IF Z$="4"THEN UM=1:UM$="in.":GOTO 680
670 GOTO 640
680 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
690 GOSUB 2280     :REM'preface text
700 GOSUB 3520
710 GOTO 790
720 :REM'
730 :REM'.....display input
740 LOCATE CSRLIN-1:PRINT STRING$(7,32)
750 LOCATE CSRLIN-1,39:PRINT STRING$(40,32)
760 LOCATE CSRLIN-1,39:PRINT ".......";USING U$;Q;
770 RETURN
780 :REM'
790 :REM'.....ammeter
800 CLS
810 PRINT TAB(37);"AMMETER"
820 PRINT UL$;
830 PRINT
840 T=26:COLOR 0,7
850 LOCATE CSRLIN,T:PRINT "     shunt wire (coiled)      "
860 LOCATE CSRLIN,T:PRINT "         ┌──\/\/\──┐          "
870 LOCATE CSRLIN,T:PRINT "         │  ┌───┐  │          "
880 LOCATE CSRLIN,T:PRINT " I(in) ──┴──┤ \ ├──┴── I(out) "
890 LOCATE CSRLIN,T:PRINT "           +└───┘-            "
900 LOCATE CSRLIN,T:PRINT "            meter             "
910 COLOR 7,0
920 PRINT
930 INPUT " ENTER: Meter Movement (full scale).....(mA.)";Z:A=Z/1000
940 IF Z=0 THEN LOCATE CSRLIN-1:GOTO 930
950 Q=Z:GOSUB 730:PRINT " mA."
960 INPUT " ENTER: Internal Resistance............(ohms)";RM
970 IF RM=0 THEN LOCATE CSRLIN-1:GOTO 960
980 Q=RM:GOSUB 730:PRINT " ohms"
990 INPUT " ENTER: New Dial Full Scale............(amps)";B
1000 IF B=0 THEN LOCATE CSRLIN-1:GOTO 990
1010 Q=B:GOSUB 730:PRINT " amps"
1020 BA=B*10^3/-A   :REM'scale multiplication factor
1030 C=B*250
1040  FOR Z=40 TO 1 STEP -1
1050   CM=(A(Z)*10^3)^2                                   :REM'circular mils
1060   IF CM>C THEN W=Z:GOTO 1130
1070  NEXT Z
1080 IF W<10 THEN BEEP:COLOR 0,7:PRINT:PRINT " NOT PRACTICAL ! "  :REM'AWG<10
1090 PRINT:COLOR 0,7:PRINT " Press any key to start over ":COLOR 7,0
1100 Z$=INKEY$:IF Z$<>""THEN 800
1110 GOTO 1100
1120 :REM'
1130 PRINT TAB(9);"Shunt Wire minimum diameter..........";
1140 PRINT USING U$;A(Z)*UM;:PRINT " ";UM$;"  (#";W;"AWG)"
1150 LIN=CSRLIN
1160 PRINT UL$;
1170 PRINT " Press number in < > to choose how you want to select wire:"
1180 PRINT UL$;
1190 PRINT "   < 1 >  by Diameter"
1200 PRINT "   < 2 >  by AWG #"
1210 Z$=INKEY$
1220 IF Z$="1"THEN GOSUB 1260:GOTO 1290
1230 IF Z$="2"THEN GOSUB 1260:GOTO 1360
1240 GOTO 1210
1250 :REM'
1260 VIEW PRINT LIN TO 24:CLS:VIEW PRINT:LOCATE LIN
1270 RETURN
1280 :REM'
1290 :REM'.....size by diameter
1300 PRINT " ENTER: Shunt Wire diameter.............(";UM$;")";:INPUT Q
1310 GOSUB 730:PRINT " ";UM$
1320 LOCATE CSRLIN-1,4:PRINT "USE:"
1330 DIA=Q/UM     :REM'wire diameter in inches
1340 GOTO 1430
1350 :REM'
1360 :REM'.....size by AWG
1370 INPUT " ENTER: Selected Shunt Wire diameter.......(AWG#)";X
1380 Q=A(X)*UM:GOSUB 730:PRINT " ";UM$;"  (#";X;"AWG)"
1390 LOCATE CSRLIN-1,4:PRINT "USE:"
1400 DIA=A(X)     :REM'wire diameter in inches
1410 GOTO 1430
1420 :REM'
1430 IF DIA>=INT(A(Z)*10^3)/10^3 THEN 1480
1440 BEEP:COLOR 0,7
1450 PRINT:PRINT " CURRENT EXCEEDS WIRE CAPACITY !"
1460 COLOR 7,0:GOTO 1090
1470 :REM'
1480 IF UM=1 THEN M=UM:M$="in.":ELSE M=2.5399999618530273!:M$="cm."
1490 PRINT " ENTER: Shunt Wire Coil diameter........(";M$;")";:INPUT D
1500 IF D=0 THEN LOCATE CSRLIN-1:GOTO 1480
1510 D=D/M
1520 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1
1530 CM=(DIA*10^3)^2 :REM'circular mils
1540 OMFT=10371/CM   :REM'ohms per 1000 feet
1550 R=OMFT/12000    :REM'ohms per inch
1560 N=B/A           :REM'factor by which original meter scale is to be multiplied
1570 S=RM/(N-1)      :REM'shunt resistance
1580 L=S/R           :REM'shunt length
1590 PRINT TAB(9);"Shunt resistance.....................";USING U$;S;
1600 PRINT " ohms"
1610 PRINT TAB(9);"Shunt Wire capacity..................";USING U$;CM/250;
1620 PRINT " amps"
1630 IF UM=1 THEN M=UM:M$=UM$ :ELSE M=2.5399999618530273!:M$="cm."
1640 PRINT TAB(9);"Shunt Wire length....................";USING U$;L*M;
1650 PRINT " ";M$
1660 PRINT TAB(9);"Shunt Coil diameter..................";USING U$;D*M;
1670 PRINT " ";M$
1680 PRINT TAB(9);"Shunt Coil length....................";USING U$;L/D/PI;
1690 PRINT " turns"
1700 PRINT UL$;
1710 T=7
1720 PRINT TAB(T);
1730 PRINT " Resistance wire may be wound in a coil as suggested, or it may be"
1740 PRINT TAB(T);
1750 PRINT " wound in a loop around the inside walls of the chassis, or even"
1760 PRINT TAB(T);
1770 PRINT " bundled or bunched in any random fashion.";
1780 GOTO 3470      :REM'end
1790 :REM'
1800 :REM'....voltmeter
1810 CLS
1820 PRINT TAB(36);"VOLTMETER"
1830 PRINT UL$;
1840 PRINT
1850 T=27:COLOR 0,7
1860 LOCATE CSRLIN,T:PRINT " + ───┬───────────────── "
1870 LOCATE CSRLIN,T:PRINT "      │ multiplier       "
1880 LOCATE CSRLIN,T:PRINT "      └───\/\/\/──┐      "
1890 LOCATE CSRLIN,T:PRINT "                ┌─┴─┐+   "
1900 LOCATE CSRLIN,T:PRINT "           meter│ \ │    "
1910 LOCATE CSRLIN,T:PRINT "                └─┬─┘-   "
1920 LOCATE CSRLIN,T:PRINT " - ───────────────┴───── "
1930 COLOR 7,0
1940 PRINT
1950 INPUT " ENTER: Meter Movement - Full Scale.....(mA.)";Z:I=Z/1000
1960 Q=Z:GOSUB 730:PRINT " mA."
1970 RM=0        :REM'internal resistance
1980 PRINT " Is the internal resistance of the meter known?   (y/n)"
1990 Z$=INKEY$
2000 IF Z$="Y"OR Z$="y"THEN LOCATE CSRLIN-1:PRINT ER$:LOCATE CSRLIN-2:GOTO 2030
2010 IF Z$="N"OR Z$="n"THEN LOCATE CSRLIN-1:PRINT ER$:LOCATE CSRLIN-2:GOTO 2050
2020 GOTO 1990
2030 INPUT " ENTER: Internal Resistance............(ohms)";RM
2040 Q=RM:GOSUB 730:PRINT " ohms":GOTO 2090
2050 PRINT "        Internal Resistance.................."
2060 RM=100
2070 Q=RM:GOSUB 730:PRINT " ohms (assumed)"
2080 :REM'
2090 INPUT " ENTER: Desired Full Scale Reading....(volts)";E
2100 Q=E:GOSUB 730:PRINT " volts"
2110 :REM'
2120 R=E/I-RM
2130 PRINT "        Multiplier Resistor.................."
2140 Q=R:GOSUB 730:PRINT " ohms "
2150 :REM'
2160 VR=RM+R
2170 PRINT "        Total Voltmeter Resistance..........."
2180 Q=VR:GOSUB 730:PRINT " ohms"
2190 :REM'
2200 S=(R+RM)/E
2210 PRINT "        Voltmeter Sensitivity................"
2220 Q=S/10^3:GOSUB 730:PRINT " kΩ/v"
2230 :REM'
2240 GOSUB 3520     :REM'screen dump
2250 CLS:CHAIN"precires"
2260 END
2270 :REM'
2280 :REM'.....meter shunt preface
2290 TB=8     :REM'tab for text
2300 PRINT TAB(TB);
2310 PRINT "It is necessary to know the meter's internal resistance before"
2320 PRINT TAB(TB);
2330 PRINT "the required value for a shunt can be calculated. The internal"
2340 PRINT TAB(TB);
2350 PRINT "resistance may vary from a fraction of an ohm to a few thousand"
2360 PRINT TAB(TB);
2370 PRINT "ohms, with the higher resistance values associated with higher"
2380 PRINT TAB(TB);
2390 PRINT "sensitivity."
2400 PRINT
2410 PRINT TAB(TB);
2420 PRINT "Often the resistance of a particular meter will be unknown. This"
2430 PRINT TAB(TB);
2440 PRINT "is usually the case when a meter is purchased at a flea market or"
2450 PRINT TAB(TB);
2460 PRINT "is obtained from a commercial piece of equipment. Unfortunately"
2470 PRINT TAB(TB);
2480 PRINT "the internal resistance of a meter CANNOT be measured directly"
2490 PRINT TAB(TB);
2500 PRINT "with an ohmmeter without risk of damage to the meter movement."
2510 PRINT
2520 PRINT TAB(TB);
2530 PRINT "(ref. 2000 ARRL Handbook for Radio Amateurs, page 26.4)"
2540 PRINT
2550 PRINT TAB(TB);
2560 PRINT "To find the internal resistance of a meter, re-run this program"
2570 PRINT TAB(TB);
2580 PRINT "and select item < 3 > from the main menu."
2590 PRINT
2600 PRINT TAB(TB);
2610 PRINT "Do you wish to do this now?   (y/n)"
2620 Z$=INKEY$:IF Z$=""THEN 2620
2630 IF Z$="y"THEN CLS:GOTO 210
2640 IF Z$="n"THEN 2660
2650 GOTO 2620
2660 LOCATE CSRLIN-4:VIEW PRINT CSRLIN TO 24:CLS:VIEW PRINT:GOTO 2670
2670 RETURN
2680 :REM'
2690 :REM'.....internal resistance
2700 CLS:C=20:LOCATE 1:COLOR 0,7
2710 LOCATE ,C:PRINT "  METER INTERNAL RESISTANCE MEASUREMENT  "
2720 LOCATE ,C:PRINT "  │«─n/c              n/c  not connected "
2730 LOCATE ,C:PRINT "  R1«─┬───────────┐   R1 - potentiometer "
2740 LOCATE ,C:PRINT " +│   └─S1─┐     ┌┴─┐ R2 - potentiometer "
2750 LOCATE ,C:PRINT "  E1       R2«─┐ │R3│ R3 - unknown meter "
2760 LOCATE ,C:PRINT " -│   n/c─»│   │ └┬─┘ S1 - on/off switch "
2770 LOCATE ,C:PRINT "  └────────────┴──┘   E1 - 1.5v battery  "
2780 COLOR 7,0:
2790 PRINT
2800 PRINT " R1 and R2 can be 5k linear or audio taper. If they are audio tap";
2810 PRINT "er the + leads"
2820 PRINT " can be connected to either end to alter sensitivity of response ";
2830 PRINT "over any given"
2840 PRINT " range of adjustment."
2850 PRINT
2860 PRINT "  1. Disconnect E1."
2870 PRINT "  2. Set R1 and R2 to maximum resistance and open S1."
2880 PRINT "  3. Insert R3 and connect E1."
2890 PRINT "  4. Reduce R1 until R3 reads exactly full scale."
2900 PRINT "  5. Close S1 and reduce R2 until R3 reads exactly one-half scale."
2910 PRINT "  6. Measure voltage E1 (under load) with an accurate multimeter."
2920 PRINT "     (if voltage is appreciably less than rated voltage, replace ";
2930 PRINT "battery)"
2940 PRINT "  7. Disconnect E1 and remove R3."
2950 PRINT "  9. With the same multimeter measure resistances R1 and R2."
2960 PRINT " 10. Make a note of readings E1, R1, and R2."
2970 PRINT " 11. Press 3 to calculate meter internal resistance."
2980 GOSUB 3520
2990 VIEW PRINT 8 TO 24:CLS:VIEW PRINT:LOCATE 8
3000 PRINT " INPUT DATA:"
3010 INPUT " Meter full scale current (mA)...";S
3020 I3=S/10^3/2 :REM'meter current at half full-scale reading
3030 INPUT " Measured voltage E1.............";E1
3040 INPUT " Measured value of R1 (ohms).....";R1
3050 INPUT " Measured value of R2 (ohms).....";R2
3060 PRINT
3070 PRINT " COMPUTED DATA:"
3080 R3=0:N=10
3090 :REM'
3100 R3=R3+N
3110 RX=1/(1/R2+1/R3) :REM'net resistance of R2 and R3 in parallel
3120 RT=R1+RX :REM'total series resistance
3130 I1=E1/RT :REM'circuit current
3140 I2=I1-I3 :REM'current thru R2
3150 V1=R1*I1 :REM'voltage drop across R1
3160 V2=R2*I2 :REM'voltage drop across R2
3170 V3=R3*I3 :REM'voltage drop across R3
3180 DIF=ABS(V2-V3)
3190 IF DIF<9.999999747378752e-05! THEN 3240
3200 IF V2>V3 THEN 3100
3210 R3=R3-N:N=N/10
3220 GOTO 3100
3230 :REM'
3240 PRINT USING " Meter sensitivity = ##.# kΩ/volt";1/S
3250 COLOR 0,7
3260 PRINT USING " R3= ####.## ohms";R3;
3270 PRINT SPC(1)"(internal resistance of meter)"
3280 COLOR 7,0
3290 PRINT USING " Rn= ####.## ohms";RX;
3300 PRINT SPC(1)"(net resistance of R2 and R3 in parallel)"
3310 PRINT USING " Rt= ####.## ohms";RT;
3320 PRINT SPC(1)"(total series resistance = R1 + Rn)"
3330 PRINT USING " I1= ####.## mA";I1*10^3;
3340 PRINT SPC(3)"(current thru R1)"
3350 PRINT USING " I2= ####.## mA";I2*10^3;
3360 PRINT SPC(3)"(current thru R2)"
3370 PRINT USING " I3= ####.## mA";I3*10^3;
3380 PRINT SPC(3)"(current thru R3)"
3390 PRINT USING " V1= ####.## v.";V1;
3400 PRINT SPC(3)"(voltage drop across R1)"
3410 PRINT USING " V2= ####.## v.";V2;
3420 PRINT SPC(3)"(voltage drop across R2)"
3430 PRINT USING " V3= ####.## v.";V3;
3440 PRINT SPC(3)"(voltage drop across R3)";
3450 GOTO 3470
3460 :REM'
3470 :REM'.....end
3480 GOSUB 3520
3490 CLS:GOTO 220
3500 END
3510 :REM'
3520 :REM'PRT
3530 KEY OFF:GOSUB 3600:LOCATE 25,5:COLOR 0,2
3540 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3550 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3560 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3560 :ELSE GOSUB 3600
3570 IF Z$="3"THEN RETURN
3580 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3590 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3530
3600 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
