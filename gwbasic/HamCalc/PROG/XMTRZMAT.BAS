10 :REM'XMTRZMAT - Transmitter Transistor Stage Coupling - 30 APR 96 rev.13 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 UL$=STRING$(80,205)
80 X$=STRING$(80,32)
90 C$="##,###"
100 U$="##,###.###"
110 E$="##,###.######"
120 T$=" TRANSMITTER TRANSISTOR STAGE COUPLING "
130 PI=3.1415929794311523!
140 :REM'
150 :REM'.....start
160 CLS
170 COLOR 15,2
180 PRINT T$;TAB(57);"by George Murphy VE3ERP ";
190 COLOR 1,0:PRINT STRING$(80,223);
200 COLOR 7,0
210 GOTO 600
220 :REM'
230 :REM'.....diagrams
240 COLOR 0,7
250 LOCATE ,CO:PRINT " Vcc        L1          C2      "
260 LOCATE ,CO:PRINT " + ──┬─────∩∩∩∩────┬─────╫───── "
270 LOCATE ,CO:PRINT "  Q1 |             │            "
280 LOCATE ,CO:PRINT " Cout╪ Lo-Z     C1═╪═      Hi-Z "
290 LOCATE ,CO:PRINT "     | «─          │         ─» "
300 LOCATE ,CO:PRINT " - ──┴─────────────┴─────────── "
310 COLOR 15,2
320 LOCATE ,CO+10:PRINT " NETWORK #1 "
330 COLOR 7,0
340 RETURN
350 :REM'
360 COLOR 0,7
370 LOCATE ,CO:PRINT " Vcc       C1    L1             "
380 LOCATE ,CO:PRINT " + ──┬─────╫────∩∩∩∩───┬─────── "
390 LOCATE ,CO:PRINT "  Q1 |                 │        "
400 LOCATE ,CO:PRINT " Cout╪ Lo-Z         C2═╪═  Hi-Z "
410 LOCATE ,CO:PRINT "     | «─              │     ─» "
420 LOCATE ,CO:PRINT " - ──┴─────────────────┴─────── "
430 COLOR 15,2
440 LOCATE ,CO+10:PRINT " NETWORK #2 "
450 COLOR 7,0
460 RETURN
470 :REM'
480 COLOR 0,7
490 LOCATE ,CO:PRINT " Vcc        L1         L2       "
500 LOCATE ,CO:PRINT " + ──┬─────∩∩∩∩───┬───∩∩∩∩───── "
510 LOCATE ,CO:PRINT "  Q1 |            │             "
520 LOCATE ,CO:PRINT " Cout╪ Lo-Z    C1═╪═       Hi-Z "
530 LOCATE ,CO:PRINT "     | «─         │          ─» "
540 LOCATE ,CO:PRINT " - ──┴────────────┴──────────── "
550 COLOR 15,2
560 LOCATE ,CO+10:PRINT " NETWORK #3 "
570 COLOR 7,0
580 RETURN
590 :REM'
600 :REM'.....input menu
610 RO=2:CO=0
620 LOCATE 3:CO=7:GOSUB 240
630 LOCATE 3:CO=43:GOSUB 360
640 LOCATE 11:CO=25:GOSUB 480
650 PRINT UL$;
660 GOSUB 2070
670 COLOR 0,7:LOCATE 25,22
680 PRINT " Press 1 to continue or 0 to EXIT.....";
690 COLOR 7,0
700 Z$=INKEY$:IF Z$=""THEN 700
710 IF Z$="0"THEN CLS:CHAIN GO$
720 IF Z$="1"THEN 750
730 GOTO 700
740 :REM'
750 LOCATE 25,10
760 COLOR 15,6
770 PRINT " Press one of the three network numbers to start program......";
780 COLOR 7,0
790 N$=INKEY$:IF N$=""THEN 790
800 IF VAL(N$)<1 OR VAL(N$)>3 THEN 790
810  CLS:LOCATE 1,19:COLOR 15,2
820 PRINT "  TRANSMITTER  TRANSISTOR  STAGE  COUPLING  "
830 COLOR 7,0:LOCATE 8:PRINT UL$;
840 LOCATE 2:CO=25
850 IF N$="1" THEN GOSUB 240:GOTO 950
860 IF N$="2" THEN GOSUB 360:GOTO 950
870 IF N$="3" THEN GOSUB 480:GOTO 950
880 GOTO 790
890 :REM'
900 :REM'.....format input line
910 LOCATE CSRLIN-1:PRINT SPC(7);
920 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;ZZ;
930 RETURN
940 :REM'
950 :REM'.....input data
960 XS=0:XP=0:RS=0:RP=O:XCS=0
970 INPUT " ENTER: Frequency...............................(MHz)";F
980 ZZ=F:GOSUB 900:PRINT " Mhz"
990 INPUT " ENTER: Selected Q (typically 1 to 5)................";Z
1000 QI=INT((Z*10+5)/10)
1010 LOCATE CSRLIN-1
1020 PRINT "        Selected Q...................................";USING C$;QI
1030 PRINT " Do you know the internal capacitance Cout of transistor Q1?  (y/n)"
1040 Z$=INKEY$:IF Z$=""THEN 1040
1050 IF Z$="y"THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 1090
1060 IF Z$="n"THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1
1070 PRINT "        Q1 Cout parallel capacitance.................     ignored"
1080 COUT=0:GOTO 1120
1090 INPUT " ENTER: Q1 Cout parallel capacitance.............(pF)";COUT
1100 ZZ=COUT:GOSUB 900:PRINT " pF"
1110 :REM'
1120 INPUT " ENTER: Voltage Vcc...........................(volts)";VCC
1130 ZZ=VCC:GOSUB 900:PRINT " volts"
1140 INPUT " ENTER: Lo-Z stage output power...............(watts)";PO
1150 ZZ=PO:GOSUB 900:PRINT " watts"
1160 RP=VCC^2/(2*PO)
1170 PRINT "                   approximate impedance..........Rp≈";USING U$;RP;
1180 PRINT " ohms"
1190 IF COUT=0 THEN XP=0:GOTO 1210
1200 XP=1/(2*PI*F*10^6*COUT*10^-12)
1210 PRINT "                   parallel reactance.............Xp=";USING U$;XP;
1220 PRINT " ohms"
1230 IF COUT=0 THEN RS=RP:GOTO 1250
1240 RS=RP*XP^2/(RP^2+XP^2)
1250 PRINT "                   equivalent series resistance...Rs=";USING U$;RS;
1260 PRINT " ohms"
1270 IF COUT=0 THEN XS=0:GOTO 1290
1280 XS=RP^2*XP/(RP^2+XP^2)
1290 PRINT "                   equivalent series reactance....Xs=";USING U$;XS;
1300 PRINT " ohms"
1310 IF COUT=0 THEN XCS=0:GOTO 1330
1320 XCS=RS*RP/XP
1330 RV=RS*(1+QI^2)
1340 PRINT "                   virtual resistance of network..Rv=";USING U$;RV;
1350 PRINT " ohms"
1360 INPUT " ENTER: Hi-Z stage input impedance (typically 50 Ω)..";RL
1370 LOCATE CSRLIN-1
1380 PRINT "        Hi-Z stage input impedance...................";USING U$;RL;
1390 PRINT " ohms"
1400 IF RL>RS THEN 1470
1410 BEEP:COLOR 14,4
1420 LOCATE ,15:PRINT "      INSUFFICIENT POWER OUTPUT FROM Lo-Z STAGE      "
1430 LOCATE ,15:PRINT " Press any key to try again with increased power.... "
1440 IF INKEY$=""THEN 1440
1450 COLOR 7,0:VIEW PRINT 9 TO 24:CLS:VIEW PRINT:LOCATE 9:GOTO 950
1460 :REM'
1470 IF RV/RL-1>0 THEN 1560
1480 BEEP:COLOR 14,4
1490 LOCATE ,8:PRINT " The maximum possible Hi-Z match is";USING "###.##";RV;
1500 PRINT " ohms.";STRING$(22,32)
1510 LOCATE ,8:PRINT " Press any key to try again with a higher Q and/or ";
1520 PRINT "increased power..."
1530 IF INKEY$=""THEN 1530
1540 COLOR 7,0:VIEW PRINT 9 TO 24:CLS:VIEW PRINT:LOCATE 9:GOTO 950
1550 :REM'
1560 QL=SQR(RV/RL-1)
1570 PRINT "        Load Q.......................................";USING U$;QL
1580 TQ=QI+QL
1590 PRINT "        Total Q (selected Q + Load Q)................";USING U$;TQ
1600 IF N$="1"THEN GOSUB 1810
1610 IF N$="2"THEN GOSUB 1880
1620 IF N$="3"THEN GOSUB 1950
1630 :REM'
1640 :REM'.....print component values
1650 L1=XL1/(2*PI*F)
1660 PRINT "        L1...........................................";USING U$;L1;
1670 PRINT " µH"
1680 IF XL2=0 THEN 1720
1690 L2=XL2/(2*PI*F)
1700 PRINT "        L2...........................................";USING U$;L2;
1710 PRINT " µH"
1720 C1=10^6/(2*PI*F*XC1)
1730 PRINT "        C1...........................................";USING C$;C1;
1740 PRINT " pF";
1750 IF XC2=0 THEN 1790
1760 C2=10^6/(2*PI*F*XC2)
1770 PRINT "        C2...........................................";USING C$;C2;
1780 PRINT " pF";
1790 GOTO 2020
1800 :REM'
1810 :REM'.....network #1
1820 XL1=QI*RS+XCS
1830 XL2=0
1840 XC1=RV/(QI-QL)
1850 XC2=QL*RL
1860 RETURN
1870 :REM'
1880 :REM'.....network #2
1890 XC1=QI*RS:C1=10^6/(2*PI*F*XC1)
1900 XC2=RL*SQR(RS/(RL-RS))
1910 XL1=XC1+(RS*RL/XC2)+XCS
1920 XL2=0
1930 RETURN
1940 :REM'
1950 :REM'.....network #3
1960 XL1=RS*QI+XCS
1970 XL2=RL*QL
1980 XC1=RV/(QI+QL)
1990 XC2=0
2000 RETURN
2010 :REM'
2020 :REM'.....end
2030 GOSUB 2230
2040 GOTO 150   :REM'start
2050 END
2060 :REM'
2070 :REM'.....text
2080 T=7
2090 PRINT TAB(T);
2100 PRINT "The value of Cout is taken from the manufacturer's data sheet for"
2110 PRINT TAB(T);
2120 PRINT "transistor Q1. If unavailable it can be ignored at the expense of"
2130 PRINT TAB(T);
2140 PRINT "a slight methematical error in the network determination. By making"
2150 PRINT TAB(T);
2160 PRINT "C1 variable the network can be made to approximate the correct"
2170 PRINT TAB(T);
2180 PRINT "transformation ratio."
2190 PRINT TAB(T);
2200 PRINT "(see the 1996 ARRL HANDBOOK for RADIO AMATEURS, pp. 17.55 - 17.56)";
2210 RETURN
2220 :REM'
2230 :REM'....PRT
2240 KEY OFF:GOSUB 2310:LOCATE 25,5:COLOR 0,2
2250 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2260 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2270 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2270 :ELSE GOSUB 2310
2280 IF Z$="3"THEN RETURN
2290 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2300 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2240
2310 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
