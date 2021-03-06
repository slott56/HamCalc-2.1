10 :REM'AUDPASS - Passive Audio Filters - 05 MAY 95  rev. 08 APR 97
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COLOR 7,0,0
50 DIM C(7)
60 DIM L(3)
70 PI=3.1415929794311523!
80 UL$=STRING$(80,205)
90 U1$="#####.#"
100 U2$="####.###"
110 :REM'
120 :REM'.....start
130 FOR Z=1 TO 7:C(Z)=0:NEXT Z
140 FOR Z=1 TO 3:L(Z)=0:NEXT Z
150 COLOR 15,2
160 PRINT " PASSIVE AUDIO FILTERS";TAB(57);"by George Murphy VE3ERP ";
170 COLOR 1,0:PRINT STRING$(80,223);
180 COLOR 7,0
190 :REM'
200 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
210 MENU=1
220 RO=2:CO=3:GOSUB 880
230 COLOR 15,0
240 LOCATE 9,4:PRINT "└─<1> ELLIPTIC - 1 dB/50 dB"
250 COLOR 7,0
260 RO=2:CO=38:GOSUB 1170
270 COLOR 15,0
280 LOCATE 9,41:PRINT "└─<2> ELLIPTIC - 0.18 dB/50.1 dB"
290 COLOR 7,0
300 RO=9:CO=38:GOSUB 1460
310 COLOR 15,0
320 LOCATE 16,42:PRINT "└─<3> ELLIPTIC - 0.18 dB/81 dB"
330 COLOR 7,0
340 MENU=0
350 RO=16:CO=3:GOSUB 1700
360 COLOR 15,0
370 LOCATE 23,4:PRINT "└─<4> BUTTERWORTH HIGH-PASS"
380 COLOR 7,0
390 RO=16:CO=38:GOSUB 1920
400 COLOR 15,0
410 LOCATE 23,40:PRINT "└─<5> BUTTERWORTH LOW-PASS";
420 COLOR 7,0
430 :REM'
440 :REM'.....credits
450 COLOR 15,2
460 LOCATE 11,4:PRINT " Program suggested by Roel   "
470 LOCATE 12,4:PRINT " Koekoek, PA0RBK, based on   "
480 LOCATE 13,4:PRINT " data developed by Willem    "
490 LOCATE 14,4:PRINT " Chaudron, PE1GCS            "
500 COLOR 7,0
510 LOCATE 25,12:COLOR 15,1
520 PRINT " Press number in < > to select filter, or press 0 to EXIT ";
530 COLOR 7,0
540 Z$=INKEY$:Z=VAL(Z$)
550 IF Z$="0"THEN CLS:RUN EX$
560 IF Z>=1 AND Z<=5 THEN 590
570 GOTO 540
580 :REM'
590 :REM'.....input parameters
600 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
610 GOSUB 2320    :REM'preface notes
620 PRINT UL$;
630 INPUT " ENTER: Load Resistance.......(ohms)";R
640 INPUT " ENTER: Cutoff Frequency........(Hz)";FC
650 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
660 KC=10^6/(2*PI*FC*R)        :REM'capacitance constant
670 KL=R*10^3/(2*PI*FC)        :REM'inductance constant
680 IF Z=1 THEN 740
690 IF Z=2 THEN 1000
700 IF Z=3 THEN 1290
710 IF Z=4 THEN 1580
720 IF Z=5 THEN 1800
730 :REM'
740 :REM'.....5-pole, 1 dB/50 dB
750 C(1)=1.9329999685287476!*KC
760 C(2)=0.22300000488758087!*KC
770 C(3)=2.3919999599456787!*KC
780 C(4)=0.6259999871253967!*KC
790 C(5)=1.6349999904632568!*KC
800 L(1)=0.9629999995231628!*KL
810 L(2)=0.75!*KL
820 PRINT " 5-POLE ELLIPTIC LOW-PASS FILTER (1 dB / 50 dB)"
830 PRINT UL$;
840 RO=4:CO=2:GOSUB 880
850 PRINT UL$;
860 GOTO 2020
870 :REM'
880 COLOR 0,7
890 LOCATE RO+1,CO:PRINT "          L1        L2         "
900 LOCATE RO+2,CO:PRINT "      ┌─∩∩∩∩∩─┐ ┌─∩∩∩∩∩─┐      "
910 LOCATE RO+3,CO:PRINT "  ───┬┤   C2  ├┬┤   C4  ├┬───  "
920 LOCATE RO+4,CO:PRINT "     │└───╫───┘│└───╫───┘│     "
930 LOCATE RO+5,CO:PRINT " «R ═╪═ C1    ═╪═ C3  C5═╪═ R» "
940 IF MENU=1 THEN RO=RO-1:GOTO 960
950 LOCATE RO+6,CO:PRINT "     │         │         │     "
960 LOCATE RO+7,CO:PRINT "  ───┴─────────┴─────────┴───  "
970 COLOR 7,0
980 RETURN
990 :REM'
1000 :REM'.....7-pole, 0.18 dB/50.1 dB
1010 C(1)=1.1829999685287476!*KC
1020 C(2)=0.18529999256134033!*KC
1030 C(3)=1.534999966621399!*KC
1040 C(4)=0.9575999975204468!*KC
1050 C(5)=1.3070000410079956!*KC
1060 C(6)=0.6754999756813049!*KC
1070 C(7)=0.8543000221252441!*KC
1080 L(1)=1.2029999494552612!*KL
1090 L(2)=0.748199999332428!*KL
1100 L(3)=0.8216999769210815!*KL
1110 PRINT " 7-POLE ELLIPTIC LOW-PASS FILTER (0.18 dB / 50.1 dB)"
1120 PRINT UL$;
1130 RO=4:CO=2:GOSUB 1170
1140 PRINT UL$;
1150 GOTO 2020
1160 :REM'
1170 COLOR 0,7
1180 LOCATE RO+1,CO:PRINT "          L1        L2        L3         "
1190 LOCATE RO+2,CO:PRINT "      ┌─∩∩∩∩∩─┐ ┌─∩∩∩∩∩─┐ ┌─∩∩∩∩∩─┐      "
1200 LOCATE RO+3,CO:PRINT "  ───┬┤   C2  ├┬┤   C4  ├┬┤   C6  ├┬───  "
1210 LOCATE RO+4,CO:PRINT "     │└───╫───┘│└───╫───┘│└───╫───┘│     "
1220 LOCATE RO+5,CO:PRINT " «R ═╪═ C1    ═╪═ C3    ═╪═ C5  C7═╪═ R» "
1230 IF MENU=1 THEN RO=RO-1:GOTO 1250
1240 LOCATE RO+6,CO:PRINT "     │         │         │         │     "
1250 LOCATE RO+7,CO:PRINT "  ───┴─────────┴─────────┴─────────┴───  "
1260 COLOR 7,0
1270 RETURN
1280 :REM'
1290 :REM'.....7-pole, 0.18 dB/81 dB
1300 C(1)=1.2799999713897705!*KC
1310 C(2)=0.06499999761581421!*KC
1320 C(3)=1.9429999589920044!*KC
1330 C(4)=0.30790001153945923!*KC
1340 C(5)=1.8370000123977661!*KC
1350 C(6)=0.218299999833107!*KC
1360 C(7)=1.1430000066757202!*KC
1370 L(1)=1.3209999799728394!*KL
1380 L(2)=1.1829999685287476!*KL
1390 L(3)=1.156999945640564!*KL
1400 PRINT " 7-POLE ELLIPTIC LOW-PASS FILTER (0.18 dB / 81 dB)"
1410 PRINT UL$;
1420 RO=4:CO=2:GOSUB 1460
1430 PRINT UL$;
1440 GOTO 2020
1450 :REM'
1460 COLOR 0,7
1470 LOCATE RO+1,CO:PRINT "          L1        L2        L3         "
1480 LOCATE RO+2,CO:PRINT "      ┌─∩∩∩∩∩─┐ ┌─∩∩∩∩∩─┐ ┌─∩∩∩∩∩─┐      "
1490 LOCATE RO+3,CO:PRINT "   ──┬┤   C2  ├┬┤   C4  ├┬┤   C6  ├┬───  "
1500 LOCATE RO+4,CO:PRINT "     │└───╫───┘│└───╫───┘│└───╫───┘│     "
1510 LOCATE RO+5,CO:PRINT " «R ═╪═ C1    ═╪═ C3    ═╪═ C5  C7═╪═ R» "
1520 IF MENU=1 THEN RO=RO-1:GOTO 1540
1530 LOCATE RO+6,CO:PRINT "     │         │         │         │     "
1540 LOCATE RO+7,CO:PRINT "   ──┴─────────┴─────────┴─────────┴───  "
1550 COLOR 7,0
1560 RETURN
1570 :REM'
1580 :REM'.....hi-pass Butterworth
1590 C(1)=1.6180000305175781!*KC
1600 C(2)=0.5!*KC
1610 C(3)=1.6180000305175781!*KC
1620 L(1)=0.6179999709129333!*KL
1630 L(2)=0.6179999709129333!*KL
1640 PRINT " BUTTERWORTH HIGH-PASS FILTER"
1650 PRINT UL$;
1660 RO=4:CO=2:GOSUB 1700
1670 PRINT UL$;
1680 GOTO 2020
1690 :REM'
1700 COLOR 0,7
1710 LOCATE RO+1,CO:PRINT "       C1      C2      C3      "
1720 LOCATE RO+2,CO:PRINT "  ─────╫───┬───╫───┬───╫─────  "
1730 LOCATE RO+3,CO:PRINT "           │       │           "
1740 LOCATE RO+4,CO:PRINT " «R       ∩∩∩     ∩∩∩       R» "
1750 LOCATE RO+5,CO:PRINT "           │L1     │L2         "
1760 LOCATE RO+6,CO:PRINT "  ─────────┴───────┴─────────  "
1770 COLOR 7,0
1780 RETURN
1790 :REM'
1800 :REM'.....lo-pass Butterworth
1810 C(1)=1.6180000305175781!*KC
1820 C(2)=1.6180000305175781!*KC
1830 L(1)=0.6179999709129333!*KL
1840 L(2)=2*KL
1850 L(3)=0.6179999709129333!*KL
1860 PRINT " BUTTERWORTH LOW-PASS FILTER"
1870 PRINT UL$;
1880 RO=4:CO=2:GOSUB 1920
1890 PRINT UL$;
1900 GOTO 2020
1910 :REM'
1920 COLOR 0,7
1930 LOCATE RO+1,CO:PRINT "       L1      L2      L3      "
1940 LOCATE RO+2,CO:PRINT "  ───∩∩∩∩∩─┬─∩∩∩∩∩─┬─∩∩∩∩∩∩──  "
1950 LOCATE RO+3,CO:PRINT "           │       │           "
1960 LOCATE RO+4,CO:PRINT " «R       ═╪═ C1  ═╪═ C2    R» "
1970 LOCATE RO+5,CO:PRINT "           │       │           "
1980 LOCATE RO+6,CO:PRINT "  ─────────┴───────┴─────────  "
1990 COLOR 7,0
2000 RETURN
2010 :REM'
2020 :REM'.....screen display
2030 LN=CSRLIN-1
2040 FOR Z=1 TO 3
2050 IF L(Z)=0 THEN 2080
2060 L$="L"+RIGHT$(STR$(Z),1)
2070 PRINT TAB(24);L$;" =";USING U2$;L(Z);:PRINT " mH"
2080 NEXT Z
2090 :REM'
2100 FOR Z=1 TO 7
2110 IF C(Z)=0 THEN 2150
2120 C$="C"+RIGHT$(STR$(Z),1)
2130 LN=LN+1:LOCATE LN
2140 PRINT " ";C$;" =";USING U2$;C(Z);:PRINT " µF"
2150 NEXT Z
2160 :REM'
2170 LOCATE RO+1,45:
2180 PRINT "1-ohm, 1 radian/second"
2190 LOCATE RO+3,45:
2200 PRINT "Cutoff Frequency:   ";USING U1$;FC;:PRINT " Hz."
2210 LOCATE RO+5,45
2220 PRINT "Load Resistance «R»:";USING U1$;R;:PRINT " Ω"
2230 LOCATE 20,2:PRINT "Use nearest standard 5% tolerance capacitors and ";
2240 PRINT "inductors."
2250 PRINT " Toroid inductors may be designed using HAMCALC's Toroid Inductor ";
2260 PRINT "Calculator."
2270 PRINT UL$;
2280 GOSUB 2480    :REM'screen dump
2290 CLS:GOTO 120  :REM'start
2300 END
2310 :REM'
2320 :REM'.....preface
2330 T=10
2340 PRINT TAB(T);
2350 PRINT "The formulae used in this program were developed by Willem"
2360 PRINT TAB(T);
2370 PRINT "Chaudron, PE1GCS, primarily for use as audio filters. Roel"
2380 PRINT TAB(T);
2390 PRINT "Koekoek, PA0RBK, advises that he has also used this program"
2400 PRINT TAB(T);
2410 PRINT "to design RF filters that are reasonably accurate up to about"
2420 PRINT TAB(T);
2430 PRINT "30 MHz by entering the frequency in KHz and reading the results"
2440 PRINT TAB(T);
2450 PRINT "as being in nF and µH."
2460 RETURN
2470 :REM'
2480 :REM'PRT
2570 KEY OFF:GOSUB 2640:LOCATE 25,5:COLOR 0,2
2580 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2590 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2600 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2600 :ELSE GOSUB 2640
2610 IF Z$="3"THEN RETURN
2620 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2630 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2570
2640 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
