10 :REM'MATCHNET - Matching networks for Transistors - 02 JAN 95 rev.12 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 ON ERROR  GOTO 240
50 COLOR 7,0,1
60 UL$=STRING$(80,205)
70 U1$="##,###.###"
80 U2$="##,###"
90 U3$="####.#"
100 PI=3.1415929794311523!
110 :REM'
120 :REM'.....page 1
130 XC1=0:XC2=0:XL1=0:XL2=0
140 CLS
150 COLOR 15,2
160 PRINT " MATCHING NETWORKS for TRANSISTORS";
170 PRINT TAB(57);"by George Murphy VE3ERP ";
180 COLOR 1,0:PRINT STRING$(80,223);
190 LOCATE 24,1:PRINT STRING$(80,220);
200 COLOR 15,1:LOCATE 25,1:PRINT STRING$(80,32);:LOCATE 25,10
210 PRINT " Ref. ARRL ELECTRONICS DATA BOOK, 2nd Edition, pp. 5-3 to 5-8 ";
220 GOTO 1120
230 :REM'
240 :REM'.....error trap
250 CLS:BEEP
260 IF ERR=5 OR ERR=11 THEN 280
270 PRINT " Error";ERR;"in line";ERL:END
280 COLOR 15,1:LOCATE 12,13
290 PRINT " You may have entered a parameter that is not possible."
300 LOCATE 13,13
310 PRINT "              Press any key to start over.             "
320 IF INKEY$=""THEN 320
330 COLOR 7,0:CLS:RESUME 30
340 :REM'
350 :REM'.....diagrams
360 COLOR 0,7
370 LOCATE ,CO:PRINT " ⌐Transistor¬                      "
380 LOCATE ,CO:PRINT "  ┌─  ──  ─┐   L1         C2       "
390 LOCATE ,CO:PRINT "    ┌───╫─────∩∩∩∩───┬────╫────┐   "
400 LOCATE ,CO:PRINT "  │ │   Co │         │         │   "
410 LOCATE ,CO:PRINT "    R1            C1═╪═        RL  "
420 LOCATE ,CO:PRINT "  │ │      │         │         │   "
430 LOCATE ,CO:PRINT "    └────────────────┴─────────┘   "
440 LOCATE ,CO:PRINT "  └─  ──  ─┘                       "
450 COLOR 15,2
460 LOCATE ,CO:PRINT "     NETWORK #1, where R1 < RL     "
470 COLOR 7,0
480 RETURN
490 :REM'
500 COLOR 0,7
510 LOCATE ,CO:PRINT " ⌐Transistor¬                      "
520 LOCATE ,CO:PRINT "  ┌─  ──  ─┐         L1            "
530 LOCATE ,CO:PRINT "    ┌───┬────────┬──∩∩∩∩──┬────┐   "
540 LOCATE ,CO:PRINT "  │ │   │  │     │        │    │   "
550 LOCATE ,CO:PRINT "    R1 ═╪═Co  C1═╪═    C2═╪═   RL  "
560 LOCATE ,CO:PRINT "  │ │   │  │     │        │    │   "
570 LOCATE ,CO:PRINT "    └───┴────────┴────────┴────┘   "
580 LOCATE ,CO:PRINT "  └─  ──  ─┘                       "
590 COLOR 15,2
600 LOCATE ,CO:PRINT "     NETWORK #2, where R1 > RL     "
610 COLOR 7,0
620 RETURN
630 :REM'
640 COLOR 0,7
650 LOCATE ,CO:PRINT " ⌐Transistor¬                      "
660 LOCATE ,CO:PRINT "  ┌─  ──  ─┐    C1   L1            "
670 LOCATE ,CO:PRINT "    ┌───╫───────╫───∩∩∩∩──┬────┐   "
680 LOCATE ,CO:PRINT "  │ │   Co │              │    │   "
690 LOCATE ,CO:PRINT "    R1                 C2═╪═   RL  "
700 LOCATE ,CO:PRINT "  │ │      │              │    │   "
710 LOCATE ,CO:PRINT "    └─────────────────────┴────┘   "
720 LOCATE ,CO:PRINT "  └─  ──  ─┘ (Option 2 of 2)       "
730 COLOR 15,2
740 LOCATE ,CO:PRINT "    NETWORK #3, where R1 < 50 Ω    "
750 COLOR 7,0
760 RETURN
770 :REM'
780 COLOR 0,7
790 LOCATE ,CO:PRINT " ⌐Transistor¬                      "
800 LOCATE ,CO:PRINT "  ┌─  ──  ─┐    C1   L1            "
810 LOCATE ,CO:PRINT "    ┌───┬────┬──╫───∩∩∩∩──┬────┐   "
820 LOCATE ,CO:PRINT "  │ │   │  │ │            │    │   "
830 LOCATE ,CO:PRINT "    R1 ═╪═Co └─∩∩∩∩─┐  C2═╪═   RL  "
840 LOCATE ,CO:PRINT "  │ │   │  │    L2  │     │    │   "
850 LOCATE ,CO:PRINT "    └───┴───────────┴─────┴────┘   "
860 LOCATE ,CO:PRINT "  └─  ──  ─┘ (Option 1 of 2)       "
870 COLOR 15,2
880 LOCATE ,CO:PRINT "    NETWORK #3, where R1 < 50 Ω    "
890 COLOR 7,0
900 RETURN
910 :REM'
920 COLOR 0,7
930 LOCATE ,CO:PRINT " ⌐Transistor¬                      "
940 LOCATE ,CO:PRINT "  ┌─  ──  ─┐   L1         L2       "
950 LOCATE ,CO:PRINT "    ┌───╫─────∩∩∩∩───┬───∩∩∩∩──┐   "
960 LOCATE ,CO:PRINT "  │ │   Co │         │         │   "
970 LOCATE ,CO:PRINT "    R1            C1═╪═        RL  "
980 LOCATE ,CO:PRINT "  │ │      │         │         │   "
990 LOCATE ,CO:PRINT "    └────────────────┴─────────┘   "
1000 LOCATE ,CO:PRINT "  └─  ──  ─┘                       "
1010 COLOR 15,2
1020 LOCATE ,CO:PRINT "  NETWORK #4, Low-pass, T-Section  "
1030 COLOR 7,0
1040 RETURN
1050 :REM'
1060 :REM'.....display input
1070 LOCATE CSRLIN-1:PRINT "        ";:LOCATE CSRLIN,43
1080 IF Z=QL THEN PRINT USING U2$;Z:GOTO 1100
1090 PRINT USING U1$;Z
1100 RETURN
1110 :REM'
1120 :REM'.....start
1130 LOCATE  3:CO= 4:GOSUB 350
1140 LOCATE  3:CO=43:GOSUB 500
1150 LOCATE 13:CO= 4:GOSUB 780
1160 LOCATE 13:CO=43:GOSUB 920
1170 PRINT UL$;
1180 COLOR 15,2:LOCATE CSRLIN,3
1190 PRINT " Press one of the above network numbers to start program or";
1200 COLOR 15,4
1210 PRINT " Press 0 to EXIT."
1220 COLOR 7,0
1230 N$=INKEY$:IF N$=""THEN 1230
1240 IF N$="0" THEN CLS:RUN EX$
1250 IF N$="1" THEN CLS:LOCATE 2:CO=24:GOSUB 350:GOTO 1320
1260 IF N$="2" THEN CLS:LOCATE 2:CO=24:GOSUB 500:GOTO 1320
1270 IF N$="3" THEN CLS:LOCATE 2:CO= 4:GOSUB 780             :REM'#3, option 1
1280 IF N$="3" THEN LOCATE 2:CO= 43:GOSUB 640:GOTO 1320      :REM'#3, option 2
1290 IF N$="4" THEN CLS:LOCATE 2:CO=24:GOSUB 920:GOTO 1320
1300 GOTO 1230
1310 :REM'
1320 :REM'.....input & print
1330 PRINT UL$;
1340 IF N$<>"3"THEN 1420
1350 INPUT " ENTER: Desired option ( 1 or 2 )............";OPT
1360 IF OPT=1 OR OPT=2 THEN 1380
1370 BEEP:LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 1350
1380 CLS:LOCATE 2:CO=24
1390 IF OPT=1 THEN GOSUB 780
1400 IF OPT=2 THEN GOSUB 640
1410 PRINT UL$;
1420 INPUT " ENTER: Terminating impedance (ohms)...RL=   ";RL
1430 Z=RL:GOSUB 1060
1440 INPUT " ENTER: Frequency (MHz).................F=   ";F
1450 Z=F:GOSUB 1060
1460 INPUT " ENTER: Capacitive component (pF)......Co=   ";CO
1470 Z=CO:GOSUB 1060
1480 XCO=10^6/(2*PI*F*CO)    :REM'transistor reactance
1490 PRINT "        Reactance of Co (ohms)........XCo=";USING U1$;XCO
1500 INPUT " ENTER: Resistive component (ohms).....R1=   ";R1
1510 Z=R1:GOSUB 1060
1520 INPUT " ENTER: Desired Network Q (range 1-4)..QL=   ";QL
1530 Z=QL:GOSUB 1060
1540 GOSUB 1740    :REM'calculate
1550 :REM'
1560 :REM'.....screen print
1570 PRINT "        Reactance of L1 (ohms)........XL1=";USING U1$;XL1;
1580 L1=XL1/(2*PI*F):PRINT TAB(57)"L1=";USING U3$;L1;:PRINT " µH"
1590 IF XL2=0 THEN 1620
1600 PRINT "        Reactance of L2 (ohms)........XL2=";USING U1$;XL2;
1610 L2=XL2/(2*PI*F):PRINT TAB(57)"L2=";USING U3$;L2;:PRINT " µH"
1620 PRINT "        Reactance of C1 (ohms)........XC1=";USING U1$;XC1;
1630 C1=10^6/(2*PI*F*XC1):PRINT TAB(57)"C1=";USING U2$;C1;:PRINT " pF"
1640 IF XC2=0 THEN 1670
1650 PRINT "        Reactance of C2 (ohms)........XC2=";USING U1$;XC2;
1660 C2=10^6/(2*PI*F*XC2):PRINT TAB(57)"C2=";USING U2$;C2;:PRINT " pF";
1670 PRINT UL$;
1680 COLOR 0,7:LOCATE CSRLIN,13
1690 PRINT " Original Data Source: Motorola Application Note AN-267 "
1700 COLOR 7,0
1710 PRINT UL$;
1720 GOTO 2050
1730 :REM'
1740 :REM'.....calculate
1750 IF N$<>"1"THEN 1830
1760 XL1=QL*R1+XCO
1770 A=SQR((R1*(QL^2+1)/RL)-1)
1780 B=R1*(QL^2+1)
1790 XC1=B/(QL+A)
1800 XC2=A*RL
1810 RETURN
1820 :REM'
1830 IF N$<>"2"THEN 1890
1840 XC1=R1/QL
1850 XC2=RL*SQR(R1/RL/((QL^2+1)-(R1/RL)))
1860 XL1=(QL*R1+R1*RL/XC2)/(QL^2+1)
1870 RETURN
1880 :REM'
1890 IF N$<>"3"THEN 1980
1900 XC1=QL*R1
1910 XC2=RL*SQR(R1/(RL-R1))
1920 IF OPT=1 THEN XL2=XCO
1930 IF OPT=2 THEN XL2=0
1940 IF OPT=1 THEN XL1=XC1+(R1*RL/XC2)
1950 IF OPT=2 THEN XL1=XC1+(R1*RL/XC2)+XCO
1960 RETURN
1970 :REM'
1980 XL1=R1*QL+XCO
1990 A=R1*(QL^2+1)
2000 B=SQR(A/RL-1)
2010 XL2=RL*B
2020 XC1=A/(QL+B)
2030 RETURN
2040 :REM'
2050 :REM'.....end
2060 GOSUB 2100
2070 GOTO 120   :REM'start
2080 END
2090 :REM'
2100 :REM'PRT
2110 KEY OFF:GOSUB 2180:LOCATE 25,5:COLOR 0,2
2120 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2130 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2140 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2140 :ELSE GOSUB 2180
2150 IF Z$="3"THEN RETURN
2160 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2170 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2110
2180 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
