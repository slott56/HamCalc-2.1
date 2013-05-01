10 :REM'PHAZDIFF - Constant Phase Difference Networks - 09 JUN 1998 rev. 30 JAN 2000
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="exit"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)
70 UL$=STRING$(80,205)
80 U$="####.###"
90 NA$=CHR$(34)+"a"+CHR$(34)
100 NB$=CHR$(34)+"b"+CHR$(34)
110 DIM P(20)
120 :REM'
130 :REM'.....start
140 CLS
150 COLOR 15,2,0
160 PRINT " CONSTANT PHASE DIFFERENCE NETWORKS"TAB(63)"by Robert DeHoney ";
170 PRINT TAB(19)"Edited for HAMCALC by George Murphy, VE3ERP";SPC(19);
180 COLOR 1,0:PRINT STRING$(80,223);
190 COLOR 7,0
200 GOSUB 6850 :REM'title page
210 PRINT:COLOR 0,7
220 LOCATE ,24:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN CLS:RUN GO$
250 IF Z$="1"THEN 270
260 GOTO 230
270 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
280 GOSUB 6230 :REM'preface
290 PRINT
300 :REM'
310 INPUT " ENTER: the lower frequency,  in kHz";FL:FL=FL*10^3
320 IF FL=0 THEN FL=9.999999747378752e-06!
330 INPUT " ENTER: the higher frequency, in kHz";FH:FH=FH*10^3
340 IF FH=0 THEN FH=9.999999747378752e-06!
350 IF FH=FL THEN 330
360 IF FH<FL THEN SWAP FH,FL
370 :REM'
380 :REM'.....next page
390 CLS:COLOR 7,0,0:PRINT " "
400 Z=FL:GOSUB 6520:LO=FL/ZX:LO$=Z$+" "
410 IF LEN(LO$)<5 THEN LO$=LO$+" ":GOTO 410
420 LOCATE 1,1:COLOR 0,7:PRINT " ƒ(lo)=";USING U$;LO;:PRINT LO$:COLOR 7,0
430 Z=FH:GOSUB 6520:HI=FH/ZX:HI$=Z$+" "
440 IF LEN(HI$)<5 THEN HI$=HI$+" ":GOTO 440
450 LOCATE 1,22:COLOR 0,7:PRINT " ƒ(hi)=";USING U$;HI;:PRINT HI$:COLOR 7,0
460 F0=SQR(FL*FH)
470 R=FL/FH
480 Y=0
490  FOR J=12 TO 1 STEP -1
500  Y=R^2*(J-5/4)*(1+Y)/J
510  NEXT J
520 H=-Y/(2*Y+4)
530 IF H>9.999999974752427e-07! THEN Q1=H+2*H^5+15*H^9+150*H^13
540 IF H<=9.999999974752427e-07! THEN Q1=H
550 Q=EXP(PI^2/LOG(Q1))
560 PRINT
570 :REM'
580 INPUT " ENTER: Desired phase difference (degrees) ";D1
590 D1=INT(ABS(D1)+0.5!):D=PI/180*D1
600 VIEW PRINT 2 TO 24:CLS:VIEW PRINT:LOCATE 1,43:COLOR 0,7
610 PRINT " Phase diff.=";USING "####°";D1:COLOR 7,0
620 PRINT " NO. POLES    PHASE ERROR";
630 IF D1=90 THEN PRINT "     SSB REJECTION" :ELSE PRINT""
640   FOR N=1 TO 20
650 E=4*Q^N*SIN(D)*180/PI
660 IF D1=90 THEN SSB=20*LOG(TAN(E*PI/180/2))/LOG(10)
670 PRINT SPC(3)USING "###";N;
680 PRINT SPC(10)USING "###.##°";E;
690 IF SSB THEN PRINT SPC(9)USING "###.## dB";SSB :ELSE PRINT ""
700 IF ABS(E)<0.10000000149011612! THEN 730
710   NEXT N
720 :REM'
730 LN=CSRLIN:INPUT " ENTER: Number of poles ";Z
740 IF Z>N THEN BEEP:GOSUB 5920:GOTO 730
750 CLS:N=Z
760  COLOR 0,7:LOCATE 13,25:PRINT " CALCULATING....please wait....":COLOR 7,0
770   FOR K=1 TO N
780 PC=0:PS=0
790 IF N MOD(2)>0 THEN X=((K-1)*PI-D/2)/N :ELSE X=((K-1)*PI-(PI-D)/2)/N
800  FOR M=1 TO 10
810  PC=PC+Q^(M^2-M)*COS((2*M-1)*X)
820  PS=PS+(-1)^M*Q^(M^2-M)*SIN((2*M-1)*X)
830  NEXT M
840 P(K)=PC/PS*F0
850   NEXT K
860 :REM'
870 :REM'.....next page
880 CLS
890 PRINT :PRINT "NORMALIZED"
900 PRINT "FREQUENCY    PHASE DIFF    ERROR"
910 FOR A=0 TO 10
920 F=FL/R^(A/10):DIF=0
930 FF=F/F0
940 FOR K=1 TO N
950 DIF=DIF-2*ATN(F/P(K))
960 NEXT K
970 PRINT USING "#####.##  ";FF;
980 PRINT USING "#######.##° ";DIF*180/PI;
990 PRINT USING "######.##° ";-(D1-ABS(DIF*180/PI))
1000 NEXT A
1010 GOSUB 5590  :REM'display list of A & B pole frequencies
1020 GOSUB 7110  :REM'printout option
1030 :REM'
1040 :REM'.....next page
1050 CLS:GOSUB 5590 :REM'list frequencies
1060 LOCATE 2
1070 PRINT " 1 - Single pole RC lattice"
1080 PRINT " 2 - Single pole LC lattice"
1090 PRINT " 3 - Single pole LC Tee"
1100 PRINT " 4 - Single pole Active RC"
1110 PRINT " 5 - Two pole Wien bridge, Type 1"
1120 PRINT " 6 - Two pole Wien bridge, Type 2"
1130 PRINT " 7 - Two pole Ponsonby active RC"
1140 PRINT " 8 - Two pole Steffan active RC"
1150 PRINT " 9 - Two pole LC lattice"
1160 PRINT "10 - Two Pole Bridged tee, Type 1"
1170 PRINT "11 - Two Pole Bridged tee, Type 2"
1180 PRINT
1190 :REM'
1200 INPUT " ENTER: One of the above numbers to select a circuit ";NN
1210 CLS:ONNN GOSUB 1240,1580,1880,2170,2430,2940,3450,3890,4300,4680,5050
1220 IF NN>11 OR NN<1 GOTO 1050
1230 :REM'
1240 GOSUB 5590 :LOCATE 1,1:COLOR 0,7
1250   PRINT "                                "
1260   PRINT "     SINGLE POLE RC LATTICE     "
1270   PRINT "                                "
1280   PRINT " ┌─────────────────┬───┬─ + «┐  "
1290   PRINT " │                 │   │     │  "
1300   PRINT " R                 C   │     │  "
1310   PRINT " │     +┌───┐-     │   │     │  "
1320   PRINT " ├─R1/2─┤Vin├─R1/2─┤   R2  Vout "
1330   PRINT " │      └───┘      │   │     │  "
1340   PRINT " C                 R   │     │  "
1350   PRINT " │                 │   │     │  "
1360   PRINT " └─────────────────┴───┴─ - «┘  ":COLOR 7,0
1370 GOSUB 5980:W0=2*PI*F
1380 Z=F:GOSUB 6520
1390 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqency....";USING U$;Z/ZX;
1400 PRINT Z$
1410 :REM'
1420 INPUT " ENTER: C in µF ";C:C=C*10^-6
1430 Z=C:GOSUB 6600
1440 PRINT "C =..........................";USING U$;Z*ZX;:PRINT Z$
1450 PRINT :R=1/W0/C:Z=R:GOSUB 6780
1460 PRINT "R =..........................";USING U$;Z/ZX;:PRINT Z$
1470 :REM'
1480 INPUT " ENTER: R1 in ohms ";R1
1490 Z=R1:GOSUB 6780
1500 PRINT "R1 =.........................";USING U$;Z/ZX;:PRINT Z$
1510 PRINT :R2=R^2/R1:Z=R2:GOSUB 6780
1520 PRINT "R2 =.........................";USING U$;Z/ZX;:PRINT Z$
1530 G=1/(R/R2+1)^2: LOSS=20*LOG(G)/LOG(10)
1540 PRINT "LOSS =.......................";USING U$;-LOSS;:PRINT " dB"
1550 GOSUB 5820:IF ZZ THEN 1420
1560 GOTO 5490
1570 :REM'
1580 GOSUB 5590 :LOCATE 1,1:COLOR 0,7
1590 PRINT "                              "
1600 PRINT "    SINGLE POLE LC LATTICE    "
1610 PRINT "                              "
1620 PRINT " ┌───────────────┬───┬─ + «┐  "
1630 PRINT " │               │   │     │  "
1640 PRINT " L               C   │     │  "
1650 PRINT " │    +┌───┐-    │   │     │  "
1660 PRINT " ├─R/2─┤Vin├─R/2─┤   R   Vout "
1670 PRINT " │     └───┘     │   │     │  "
1680 PRINT " C               L   │     │  "
1690 PRINT " │               │   │     │  "
1700 PRINT " └───────────────┴───┴─ - «┘  ":COLOR 7,0
1710 GOSUB 5980:W0=2*PI*F
1720 Z=F:GOSUB 6520
1730 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqency....";USING U$;Z/ZX;
1740 PRINT Z$
1750 :REM'
1760 INPUT " ENTER R in ohms ";R
1770 Z=R:GOSUB 6780
1780 PRINT "R =..........................";USING U$;Z/ZX;:PRINT Z$
1790 PRINT :C=1/R/W0
1800 Z=C:GOSUB 6600
1810 PRINT "C =..........................";USING U$;Z*ZX;:PRINT Z$
1820 PRINT :L=R/W0
1830 Z=L:GOSUB 6690
1840 PRINT "L =..........................";USING U$;Z*ZX;:PRINT Z$
1850 GOSUB 5820:IF ZZ THEN 1760
1860 GOTO 5490
1870 :REM'
1880 GOSUB 5590:LOCATE 1,1:COLOR 0,7
1890 PRINT "                                           "
1900 PRINT "            SINGLE POLE LC TEE             "
1910 PRINT "     Winding sense is shown by asterisks   "
1920 PRINT "                                           "
1930 PRINT "         ⌐ K ¬                             "
1940 PRINT "   ┌──R──L─┬─L─┬─ + «┐                     "
1950 PRINT " ┌─┴─┐  *  │*  │     │  For this circuit,  "
1960 PRINT " │Vin│     C   R  Vout  coupling K must be "
1970 PRINT " └─┬─┘     │   │     │  greater than .99   "
1980 PRINT "   └───────┴───┴─ - «┘                     "
1990 PRINT "                                           ":COLOR 7,0
2000 GOSUB 5980:W0=2*PI*F
2010 Z=F:GOSUB 6520
2020 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqency....";USING U$;Z/ZX;
2030 PRINT Z$
2040 :REM'
2050 INPUT " ENTER: R in ohms ";R
2060 Z=R:GOSUB 6780
2070 PRINT "R =..........................";USING U$;Z/ZX;:PRINT Z$
2080 PRINT :C=2/R/W0
2090 Z=C:GOSUB 6600
2100 PRINT "C =..........................";USING U$;Z*ZX;:PRINT Z$
2110 PRINT :L=R/2/W0
2120 Z=L:GOSUB 6690
2130 PRINT "L =..........................";USING U$;Z*ZX;:PRINT Z$
2140 GOSUB 5820:IF ZZ THEN 2050
2150 GOTO 5490
2160 :REM'
2170 GOSUB 5590:LOCATE 1,1:COLOR 0,7
2180 PRINT "                                          "
2190 PRINT "          SINGLE POLE ACTIVE RC           "
2200 PRINT "                                          "
2210 PRINT "   ┌───RA─┬──RA───┐    Use any convenient "
2220 PRINT "   │      │ ┌───┐ │    value for RA       "
2230 PRINT "   │      └─┤-  │ │                       "
2240 PRINT "   │        │   ├─┴─ + «┐  Op Amp assumed "
2250 PRINT "   ├──R──┬──┤+  │       │  to be ideal    "
2260 PRINT " ┌─┴─┐   │  └───┘       │                 "
2270 PRINT " │Vin│   C         Vout = │Vin│           "
2280 PRINT " └─┬─┘   │              │                 "
2290 PRINT "   └─────┴────────── - «┘                 ":COLOR 7,0
2300 GOSUB 5980:W0=2*PI*F
2310 Z=F:GOSUB 6520
2320 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqency....";USING U$;Z/ZX;
2330 PRINT Z$
2340 :REM'
2350 INPUT " ENTER: C in µF ";C:C=C*10^-6
2360 Z=C:GOSUB 6600
2370 PRINT "C =..........................";USING U$;Z*ZX;:PRINT Z$
2380 PRINT:R=1/W0/C:Z=R:GOSUB 6780
2390 PRINT "R =..........................";USING U$;Z/ZX;:PRINT Z$
2400 GOSUB 5820:IF ZZ THEN 2350
2410 GOTO 5490
2420 :REM'
2430 GOSUB 5590 :LOCATE 1,1:COLOR 0,7
2440 PRINT "        TWO POLE WIEN BRIDGE TYPE 1        "
2450 PRINT "                                           "
2460 PRINT "   ┌───RA─┬──RA*m──┐  Use any convenient   "
2470 PRINT "   │      │  ┌───┐ │     value for RA      "
2480 PRINT "   │      └──┤-  │ │                       "
2490 PRINT "   │  ┌R1┐   │   ├─┴─ + «┐ Op Amp assumed  "
2500 PRINT "   ├──┤  ├─┬─┤+  │       │ to be ideal     "
2510 PRINT "   │  └C1┘ │ └───┘       │                 "
2520 PRINT " ┌─┴─┐     R2       Vout = │Vin│           "
2530 PRINT " │Vin│     │             │                 "
2540 PRINT " └─┬─┘     C2            │                 "
2550 PRINT "   └───────┴───────── - «┘                 ":COLOR 7,0
2560 GOSUB 6080
2570 PRINT :Z=F1:GOSUB 6520:Q1=F1/ZX:F1$=Z$
2580        Z=F2:GOSUB 6520:Q2=F2/ZX:F2$=Z$
2590 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqencies..";USING U$;Q1;
2600 PRINT F1$;" &";USING U$;Q2;:PRINT F2$
2610 F0=SQR(F1*F2):S=(F1+F2)/F0:W0=2*PI*F0
2620 :REM'
2630 INPUT " ENTER: C1, in µF ";C1:C1=C1*10^-6
2640 Z=C1:GOSUB 6600
2650 PRINT "C1 =.........................";USING U$;Z*ZX;:PRINT Z$
2660 PRINT "C2 max=";USING U$;C1*(S^2-4)/4*10^6;:PRINT " µF"
2670 :REM'
2680 LN=CSRLIN:INPUT " ENTER C2, in µF ";C2:C2=C2*10^-6
2690 Y=S^2-4*(C1+C2)/C1
2700 IF Y>=0 THEN 2730
2710  BEEP:PRINT "C2 too large"
2720  LOCATE LN:PRINT STRING$(50,32):LOCATE LN:GOTO 2680
2730 Z=C2:GOSUB 6600:LOCATE LN-1
2740 PRINT "C2 =.........................";USING U$;Z*ZX;:PRINT Z$
2750 R1A=(S+SQR(Y))/2/W0/(C1+C2)
2760 R2A=1/W0^2/C1/C2/R1A
2770 MA=(2*S-W0*R1A*C2)/W0/R1A/C2
2780 R1B=(S-SQR(Y))/2/W0/(C1+C2)
2790 R2B=1/W0^2/C1/C2/R1B
2800 MB=(2*S-W0*R1B*C2)/W0/R1B/C2
2810 COLOR 0,7:PRINT " Use either of the following sets of values":COLOR 7,0
2820 PRINT :Z=R1A:GOSUB 6780:R1A=Z/ZX:R1A$=Z$
2830 PRINT :Z=R1B:GOSUB 6780:R1B=Z/ZX:R1B$=Z$
2840 PRINT "R1=";USING U$;R1A;:PRINT R1A$;TAB(23);
2850 PRINT "│ R1=";USING U$;R1B;:PRINT R1B$
2860 PRINT :Z=R2A:GOSUB 6780:R2A=Z/ZX:R2A$=Z$
2870 PRINT :Z=R2B:GOSUB 6780:R2B=Z/ZX:R2B$=Z$
2880 PRINT "R2=";USING U$;R2A;:PRINT R2A$;TAB(23);
2890 PRINT "│ R2=";USING U$;R2B;:PRINT R2B$
2900 PRINT "m= ";USING U$;MA;:PRINT TAB(23);"│ m= ";USING U$;MB
2910 GOSUB 5820:IF ZZ THEN 2630
2920 GOTO 5490
2930 :REM'
2940 GOSUB 5590 :LOCATE 1,1:COLOR 0,7
2950 PRINT "       TWO POLE WIEN BRIDGE TYPE 2       "
2960 PRINT "   ┌─────┬R1┬───────┬─ + «┐              "
2970 PRINT "   │     │  │       R2    │ Use any      "
2980 PRINT "   │     └C1┘       │     │ convenient   "
2990 PRINT "   │                C2    │ value for RA "
3000 PRINT "   ├───RA─┬───RA*m──┤     │              "
3010 PRINT "   │      │  ┌───┐  │  Vout = │Vin│      "
3020 PRINT " ┌─┴─┐    └──┤-  │  │     │              "
3030 PRINT " │Vin│       │   ├──┘     │ Op Amp       "
3040 PRINT " └─┬─┘    ┌──┤+  │        │ assumed      "
3050 PRINT "   │      │  └───┘        │ to be ideal  "
3060 PRINT "   └──────┴─────────── - «┘              ":COLOR 7,0
3070 GOSUB 6080
3080 PRINT :Z=F1:GOSUB 6520:Q1=F1/ZX:F1$=Z$
3090        Z=F2:GOSUB 6520:Q2=F2/ZX:F2$=Z$
3100 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqencies..";USING U$;Q1;
3110 PRINT F1$;" &";USING U$;Q2;:PRINT F2$
3120 F0=SQR(F1*F2):S=(F1+F2)/F0:W0=2*PI*F0
3130 :REM'
3140 INPUT " ENTER: C1, in µF ";C1:C1=C1*10^-6
3150 Z=C1:GOSUB 6600
3160 PRINT "C1 =.........................";USING U$;Z*ZX;:PRINT Z$
3170 PRINT "C2 max=";USING U$;C1*(S^2-4)/4*10^6;:PRINT " µF"
3180 :REM'
3190 LN=CSRLIN:INPUT " ENTER C2, in µF ";C2:C2=C2*10^-6
3200 Y=S^2-4*(C1+C2)/C1
3210 IF Y>=0 THEN 3240
3220  BEEP:PRINT "C2 too large"
3230  LOCATE LN:PRINT STRING$(50,32):LOCATE LN:GOTO 3190
3240 Z=C2:GOSUB 6600:LOCATE LN-1
3250 PRINT "C2 =.........................";USING U$;Z*ZX;:PRINT Z$
3260 R1A=(S+SQR(Y))/2/W0/(C1+C2)
3270 R2A=1/W0^2/C1/C2/R1A
3280 MA=(2*S-W0*R1A*C2)/W0/R1A/C2
3290 R1B=(S-SQR(Y))/2/W0/(C1+C2)
3300 R2B=1/W0^2/C1/C2/R1B
3310 MB=(2*S-W0*R1B*C2)/W0/R1B/C2
3320 COLOR 0,7:PRINT " Use either of the following sets of values":COLOR 7,0
3330 PRINT :Z=R1A:GOSUB 6780:R1A=Z/ZX:R1A$=Z$
3340 PRINT :Z=R1B:GOSUB 6780:R1B=Z/ZX:R1B$=Z$
3350 PRINT "R1=";USING U$;R1A;:PRINT R1A$;TAB(23);
3360 PRINT "│ R1=";USING U$;R1B;:PRINT R1B$
3370 PRINT :Z=R2A:GOSUB 6780:R2A=Z/ZX:R2A$=Z$
3380 PRINT :Z=R2B:GOSUB 6780:R2B=Z/ZX:R2B$=Z$
3390 PRINT "R2=";USING U$;R2A;:PRINT R2A$;TAB(23);
3400 PRINT "│ R2=";USING U$;R2B;:PRINT R2B$
3410 PRINT "m= ";USING U$;MA;:PRINT TAB(23);"│ m= ";USING U$;MB
3420 GOSUB 5820:IF ZZ THEN 3140
3430 GOTO 5490
3440 :REM'
3450 GOSUB 5590 :LOCATE 1,1:COLOR 0,7
3460 PRINT "           TWO POLE PONSONBY RC             "
3470 PRINT "       ┌──────C2──────┐   Choose convenient "
3480 PRINT " ┌─s/w─│──C1──┬──R2───┤   value for RA      "
3490 PRINT " │     │      │ ┌───┐ │                     "
3500 PRINT " │     R1     └─┤-  │ │      Op Amp assumed "
3510 PRINT " │     │        │   ├─┴─ + «┐   to be ideal "
3520 PRINT " RX    ├─RA*m─┬─┤+  │       │               "
3530 PRINT " │     │      │ └───┘       │   Closing     "
3540 PRINT " │   ┌─┴─┐    │           Vout  switch s/w  "
3550 PRINT " │   │Vin│    RA            │   removes     "
3560 PRINT " │   └─┬─┘    │             │   phase shift "
3570 PRINT " └─────┴──────┴───────── - «┘               ":COLOR 7,0
3580 GOSUB 6080
3590 PRINT :Z=F1:GOSUB 6520:Q1=F1/ZX:F1$=Z$
3600        Z=F2:GOSUB 6520:Q2=F2/ZX:F2$=Z$
3610 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqencies..";USING U$;Q1;
3620 PRINT F1$;" &";USING U$;Q2;:PRINT F2$
3630 F0=SQR(F1*F2):S=(F1+F2)/F0:W0=2*PI*F0
3640 :REM'
3650 INPUT " ENTER: C1, in µF ";C1:C1=C1*10^-6
3660 Z=C1:GOSUB 6600
3670 PRINT "C1 =.........................";USING U$;Z*ZX;:PRINT Z$
3680 :REM'
3690 INPUT " ENTER: C2, in µF ";C2:C2=C2*10^-6
3700 Z=C2:GOSUB 6600
3710 PRINT "C2 =.........................";USING U$;Z*ZX;:PRINT Z$
3720 K=(C1+C2)/C2/S
3730 R1=1/C2/W0/K
3740 PRINT :Z=R1:GOSUB 6780
3750 PRINT "R1 =.........................";USING U$;Z/ZX;:PRINT Z$
3760 R2=1/W0^2/C1/C2/R1
3770 PRINT :Z=R2:GOSUB 6780
3780 PRINT "R2 =.........................";USING U$;Z/ZX;:PRINT Z$
3790 M=2*S/K:RX=R1/M
3800 PRINT :Z=RX:GOSUB 6780
3810 PRINT "Rx =.........................";USING U$;Z/ZX;:PRINT Z$
3820 PRINT "m =..........................";USING U$;M
3830 G=1/(1+M)
3840 PRINT "Circuit gain.................";USING U$;G
3850 COLOR 0,2:PRINT "(To increase gain, increase ratio of C1/C2)":COLOR 7,0
3860 GOSUB 5820:IF ZZ THEN 3650
3870 GOTO 5490
3880 :REM'
3890 GOSUB 5590 :LOCATE 1,1:COLOR 0,7
3900 PRINT "             STEFFAN NETWORK              "
3910 PRINT "   ┌───RA───┬───RA───┐ Use any convenient "
3920 PRINT "   │        │  ┌───┐ │ value for RA       "
3930 PRINT "   │        └──┤-  │ │                    "
3940 PRINT "   │           │   ├─┴┬─ + «┐  Op Amp     "
3950 PRINT "   ├───┬──R1─┬─┤+  │  │     │  assumed to "
3960 PRINT "   │   │     │ └───┘  │     │  be ideal.  "
3970 PRINT " ┌─┴─┐ C1    C2       │     │             "
3980 PRINT " │Vin│ └──┬──┴───R3───┘  Vout = │Vin│     "
3990 PRINT " └─┬─┘    │                 │             "
4000 PRINT "   │      R2                │             "
4010 PRINT "   └──────┴───────────── + «┘             ":COLOR 7,0
4020 GOSUB 6080
4030 PRINT :Z=F1:GOSUB 6520:Q1=F1/ZX:F1$=Z$
4040        Z=F2:GOSUB 6520:Q2=F2/ZX:F2$=Z$
4050 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqencies..";USING U$;Q1;
4060 PRINT F1$;" &";USING U$;Q2;:PRINT F2$
4070 F0=SQR(F1*F2):S=(F1+F2)/F0:W0=2*PI*F0
4080 :REM'
4090 INPUT " ENTER: C1, in µF ";C1:C1=C1*10^-6
4100 Z=C1:GOSUB 6600
4110 PRINT "C1 =.........................";USING U$;Z*ZX;:PRINT Z$
4120 :REM'
4130 INPUT " ENTER: C2, in µF ";C2:C2=C2*10^-6
4140 Z=C2:GOSUB 6600
4150 PRINT "C2 =.........................";USING U$;Z*ZX;:PRINT Z$
4160 CP=C1*C2/(C1+C2)
4170 R1=(S+SQR(S^2+4*C2/CP))/2/C2/W0
4180 PRINT :Z=R1:GOSUB 6780
4190 PRINT "R1 =.........................";USING U$;Z/ZX;:PRINT Z$
4200 RP=1/W0/W0/R1/C1/C2 :K=RP*C1/R1/CP
4210 R2=1/S/W0/C1
4220 PRINT :Z=R2:GOSUB 6780
4230 PRINT "R2 =.........................";USING U$;Z/ZX;:PRINT Z$
4240 R3=RP/K
4250 PRINT :Z=R3:GOSUB 6780
4260 PRINT "R3 =.........................";USING U$;Z/ZX;:PRINT Z$
4270 GOSUB 5820:IF ZZ THEN 4090
4280 GOTO 5490
4290 :REM'
4300 GOSUB 5590 :LOCATE 1,1:COLOR 0,7
4310 PRINT "                                "
4320 PRINT "      TWO POLE LC LATTICE       "
4330 PRINT "   ┌───────────────┬────┬─ + «┐ "
4340 PRINT " ┌─┴─┐             L2   │     │ "
4350 PRINT " L1  C1            │    │     │ "
4360 PRINT " └─┬─┘  +┌───┐-    C2   │     │ "
4370 PRINT "   ├─R/2─┤Vin├─R/2─┤    R   Vout"
4380 PRINT "   L2    └───┘   ┌─┴─┐  │     │ "
4390 PRINT "   │             L1  C1 │     │ "
4400 PRINT "   C2            └─┬─┘  │     │ "
4410 PRINT "   └───────────────┴────┴─ - «┘ "
4420 PRINT "                                ":COLOR 7,0
4430 GOSUB 6080
4440 PRINT :Z=F1:GOSUB 6520:Q1=F1/ZX:F1$=Z$
4450        Z=F2:GOSUB 6520:Q2=F2/ZX:F2$=Z$
4460 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqencies..";USING U$;Q1;
4470 PRINT F1$;" &";USING U$;Q2;:PRINT F2$
4480 F0=SQR(F1*F2):S=(F1+F2)/F0:W0=2*PI*F0
4490 :REM'
4500 INPUT " ENTER: R in ohms ";R
4510 Z=R:GOSUB 6780
4520 PRINT "R =..........................";USING U$;Z/ZX;:PRINT Z$
4530 C1=1/R/W0/S
4540 PRINT :Z=C1:GOSUB 6600
4550 PRINT "C1 =.........................";USING U$;Z*ZX;:PRINT Z$
4560 L1=S*R/W0
4570 PRINT :Z=L1:GOSUB 6690
4580 PRINT "L1 =.........................";USING U$;Z*ZX;:PRINT Z$
4590 C2=S/W0/R
4600 PRINT :Z=C2:GOSUB 6600
4610 PRINT "C2 =.........................";USING U$;Z*ZX;:PRINT Z$
4620 L2=R/W0/S
4630 PRINT :Z=L2:GOSUB 6690
4640 PRINT "L2 =.........................";USING U$;Z*ZX;:PRINT Z$
4650 GOSUB 5820:IF ZZ THEN 4500
4660 GOTO 5490
4670 :REM'
4680 GOSUB 5590 :LOCATE 1,1:COLOR 0,7
4690 PRINT "             BRIDGED TEE, TYPE 1              "
4700 PRINT " This network requires a specific coefficient "
4710 PRINT " of coupling, K. The Type 2 Bridged Tee can   "
4720 PRINT " accomodate a range of coupling values.       "
4730 PRINT "                                              "
4740 PRINT "         ┌───C1──┐                            "
4750 PRINT "         │ ⌐ K ¬ │                            "
4760 PRINT "   ┌──R──┴─L─┬─L─┴──┬─ + «┐                   "
4770 PRINT " ┌─┴─┐    *  │*     │     │     Winding sense "
4780 PRINT " │Vin│       C2     R    Vout   is shown by   "
4790 PRINT " └─┬─┘       │      │     │     asterisks     "
4800 PRINT "   └─────────┴──────┴─ - «┘                   ":COLOR 7,0
4810 GOSUB 6080
4820 PRINT :Z=F1:GOSUB 6520:Q1=F1/ZX:F1$=Z$
4830        Z=F2:GOSUB 6520:Q2=F2/ZX:F2$=Z$
4840 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqencies..";USING U$;Q1;
4850 PRINT F1$;" &";USING U$;Q2;:PRINT F2$
4860 F0=SQR(F1*F2):S=(F1+F2)/F0:W0=2*PI*F0
4870 :REM'
4880 INPUT " ENTER: R in ohms ";R
4890 Z=R:GOSUB 6780
4900 PRINT "R =..........................";USING U$;Z/ZX;:PRINT Z$
4910 K=(S*S-1)/(S*S+1)
4920 PRINT "K =..........................";USING U$;K
4930 L1=S*R/W0/(1+K)
4940 PRINT :Z=L1:GOSUB 6690
4950 PRINT "L =..........................";USING U$;Z*ZX;:PRINT Z$
4960 C1=1/2/W0/R/S
4970 PRINT :Z=C1:GOSUB 6600
4980 PRINT "C1 =.........................";USING U$;Z*ZX;:PRINT Z$
4990 C2=2*S/W0/R
5000 PRINT :Z=C2:GOSUB 6600
5010 PRINT "C2 =.........................";USING U$;Z*ZX;:PRINT Z$
5020 GOSUB 5820:IF ZZ THEN 4880
5030 GOTO 5490
5040 :REM'
5050 GOSUB 5590 :LOCATE 1,1:COLOR 0,7
5060 PRINT "         BRIDGED TEE, TYPE 2         "
5070 PRINT " Winding sense is shown by asterisks "
5080 PRINT "            ┌───C1────┐              "
5090 PRINT "            │  ⌐ K ¬  │              "
5100 PRINT "     ┌───R──┴─L1─┬─L1─┴──┬─ + «┐     "
5110 PRINT "     │      *    │*      │     │     "
5120 PRINT "   ┌─┴─┐         L2      │     │     "
5130 PRINT "   │Vin│         │       R    Vout   "
5140 PRINT "   └─┬─┘         C2      │     │     "
5150 PRINT "     │           │       │     │     "
5160 PRINT "     └───────────┴───────┴─ - «┘     "
5170 PRINT "                                     ":COLOR 7,0
5180 GOSUB 6080
5190 PRINT :Z=F1:GOSUB 6520:Q1=F1/ZX:F1$=Z$
5200        Z=F2:GOSUB 6520:Q2=F2/ZX:F2$=Z$
5210 PRINT "Network ";CHR$(34);Q$;CHR$(34)" pole freqencies..";USING U$;Q1;
5220 PRINT F1$;" &";USING U$;Q2;:PRINT F2$
5230 F0=SQR(F1*F2):S=(F1+F2)/F0:W0=2*PI*F0
5240 :REM'
5250 INPUT " ENTER: R in ohms ";R
5260 Z=R:GOSUB 6780
5270 PRINT "R =..........................";USING U$;Z/ZX;:PRINT Z$
5280 KMIN=(S^2-1)/(S^2+1)
5290 :REM'
5300 CL=CSRLIN:PRINT " ENTER: Coefficient of coupling K (min="KMIN")";:INPUT K
5310 LOCATE CL:PRINT STRING$(55,32):LOCATE CL
5320 IF K<KMIN THEN BEEP:GOTO 5300
5330 PRINT "K (coefficient of coupling) =";USING U$;K
5340 L1=S*R/W0/(1+K)
5350 PRINT :Z=L1:GOSUB 6690
5360 PRINT "L1 =.........................";USING U$;Z*ZX;:PRINT Z$
5370 L2=R/2/W0/S-L1*(1-K)/2
5380 PRINT :Z=L2:GOSUB 6690
5390 PRINT "L2 =.........................";USING U$;Z*ZX;:PRINT Z$
5400 C1=1/2/R/W0/S
5410 PRINT :Z=C1:GOSUB 6600
5420 PRINT "C1 =.........................";USING U$;Z*ZX;:PRINT Z$
5430 C2=2*S/W0/R
5440 PRINT :Z=C2:GOSUB 6600
5450 PRINT "C2 =.........................";USING U$;Z*ZX;:PRINT Z$
5460 GOSUB 5820:IF ZZ THEN 5250
5470 GOTO 5490
5480 :REM'
5490 :REM'.....program completed
5500 LN=CSRLIN-1:LOCATE LN:PRINT SPC(30):GOSUB 7110:LOCATE LN:COLOR 0,7
5510 PRINT " Another (p)ole, another (c)ircuit, or (q)uit?  (p/c/q) "
5520 COLOR 7,0
5530 A$=INKEY$:IF A$=""THEN 5530
5540 IF A$="P" OR A$="p" THEN 1210
5550 IF A$="C" OR A$="c" THEN 1050
5560 IF A$="Q" OR A$="q" THEN 130
5570 GOTO 5530
5580 :REM'
5590 :REM'.....print list of A & B pole frequencies.
5600 LOCATE 1,55:PRINT "Nominal Phase Diff.=";D1;"°"
5610 NP$=CHR$(34)+"a"+CHR$(34)
5620 LOCATE 2,55:COLOR 0,7:PRINT " Network ";NP$" pole freq.":COLOR 7,0
5630 M=2:A=0
5640  FOR L=2 TO INT(N/2)+1
5650  M=M+1:IF L<11 THEN LL=61 :ELSE LL=60
5660  LOCATE M,LL:A=A+1:A(A)=-P(L)
5670  Z=-P(L):GOSUB 6520:LOCATE CSRLIN+1,LL:PRINT A" ";USING U$;Z/ZX;:PRINT Z$
5680  NEXT L
5690 M=M+1
5700 NP$=CHR$(34)+"b"+CHR$(34)
5710 LOCATE M,55:COLOR 0,7:PRINT " Network ";NP$" pole freq.":COLOR 7,0
5720 M=M+1:LL=61:B=1:B(1)=P(1)
5730 Z=P(1):GOSUB 6520:LOCATE CSRLIN+1,LL:PRINT B" ";USING U$;Z/ZX;:PRINT Z$;
5740 FOR L=N TO INT(N/2)+2 STEP -1
5750 M=M+1:B=B+1:B(B)=P(L):IF B<10 THEN LL=61 :ELSE LL=60
5760 LOCATE M,LL
5770 Z=P(L):GOSUB 6520:LOCATE CSRLIN+1,LL:PRINT B" ";USING U$;Z/ZX;:PRINT Z$;
5780 NEXT L
5790 LOCATE 7,1
5800 RETURN
5810 :REM'
5820 :REM'.....verify values
5830 ZZ=0
5840 COLOR 0,7:PRINT " Are values OK?   (y/n) ":COLOR 7,0
5850 Z$=INKEY$:IF Z$=""THEN 5850
5860 IF Z$="N"OR Z$="n"THEN 5890
5870 IF Z$="y"OR Z$="y"THEN 5900
5880 GOTO 5850
5890 ZZ=1:LN=15:GOSUB 5920
5900 RETURN
5910 :REM'
5920 :REM'.....clear text window
5930 FOR X=LN TO 24:LOCATE X:PRINT STRING$(54,32);
5940 IF X<24 THEN PRINT ""
5950 NEXT X:LOCATE LN,1
5960 RETURN
5970 :REM'
5980 :REM'.....get pole frequency for one pole networks.
5990 LOCATE 14,1 :INPUT " ENTER: Network & pole (e.g. b3) ";F$
6000 ZZ=1:FOR X=17 TO 24:LOCATE X:PRINT STRING$(54,32);
6010 IF X<24 THEN PRINT ""
6020 NEXT X:LOCATE 15,1
6030 V=VAL(RIGHT$(F$,LEN(F$)-1))
6040 Q$=LEFT$(F$,1):IF Q$="A"OR Q$="a" THEN F=A(V) :ELSE F=B(V)
6050 IF F=0 OR ASC(Q$)<58 THEN GOSUB 6190:GOTO 5990
6060 RETURN
6070 :REM'
6080 :REM'.....get pole frequencies for 2-pole networks.
6090 LOCATE 14,1 :INPUT " ENTER: Network & 2 poles (e.g. b3,4) ";F$,V2
6100 ZZ=1:FOR X=15 TO 24:LOCATE X:PRINT STRING$(54,32);
6110 IF X<24 THEN PRINT ""
6120 NEXT X:LOCATE 15,1
6130 V1=VAL(RIGHT$(F$,LEN(F$)-1))
6140 Q$=LEFT$(F$,1):IF Q$="A"OR Q$="a" THEN F1=A(V1) :ELSE F1=B(V1)
6150 IF Q$="A"OR Q$="a" THEN F2=A(V2) :ELSE F2=B(V2)
6160 IF F1=0 OR F2=0 OR ASC(Q$)<58 THEN GOSUB 6190:GOTO 6090
6170 RETURN
6180 :REM'
6190 LOCATE 17,1:COLOR 0,7:PRINT " Improper pole number. Select again."
6200 LOCATE 14,1:COLOR 7,0:PRINT STRING$(50,32):BEEP
6210 RETURN
6220 :REM'
6230 :REM'.....preface
6240 TB=7
6250 PRINT TAB(TB);
6260 PRINT "This program determines the element values for two networks (";NA$
6270 PRINT TAB(TB);
6280 PRINT "and ";NB$") which, when driven in parallel, will have a given phase"
6290 PRINT TAB(TB);
6300 PRINT "difference between their outputs from a lower frequency to a higher"
6310 PRINT TAB(TB);
6320 PRINT "frequency. The two networks may be chosen from among eleven active"
6330 PRINT TAB(TB);
6340 PRINT "and passive circuits covering the frequency range from audio"
6350 PRINT TAB(TB);
6360 PRINT "through UHF."
6370 PRINT
6380 PRINT TAB(TB);
6390 PRINT "Each network consists of as many circuits as required for the phase"
6400 PRINT TAB(TB);
6410 PRINT "accuracy needed. For example, to generate two signals with 90°"
6420 PRINT TAB(TB);
6430 PRINT "phase difference from 20 to 20,000 Hz, 11 poles will provide 0.33°"
6440 PRINT TAB(TB);
6450 PRINT "accuracy. This can be done with three 2-pole circuits in the ";NA$;
6460 PRINT TAB(TB);
6470 PRINT "network and two 2-pole circuits plus a single pole circuit in the ";
6480 PRINT TAB(TB);
6490 PRINT NB$;" network."
6500 RETURN
6510 :REM'
6520 :REM'.....frequency
6530 ZX=1:Z$=" Hz"
6540 IF Z>=10^3 THEN ZX=10^3:Z$=" kHz"
6550 IF Z>=10^6 THEN ZX=10^6:Z$=" MHz"
6560 IF Z>=10^9 THEN ZX=10^9:Z$=" GHz"
6570 LOCATE CSRLIN-1
6580 RETURN
6590 :REM'
6600 :REM'.....capacitance
6610 ZX=1:Z$=" Farads"
6620 IF Z<1     THEN ZX=10^3: Z$=" mF(milli F)"
6630 IF Z<10^-3 THEN ZX=10^6: Z$=" µF"
6640 IF Z<10^-6 THEN ZX=10^9: Z$=" nF"
6650 IF Z<10^-9 THEN ZX=10^12:Z$=" pF"
6660 LOCATE CSRLIN-1
6670 RETURN
6680 :REM'
6690 :REM'.....inductancee
6700 ZX=1:Z$=" Henries"
6710 IF Z<1     THEN ZX=10^3: Z$=" mH"
6720 IF Z<10^-3 THEN ZX=10^6: Z$=" µH"
6730 IF Z<10^-6 THEN ZX=10^9: Z$=" nH"
6740 IF Z<10^-9 THEN ZX=10^12:Z$=" pH"
6750 LOCATE CSRLIN-1
6760 RETURN
6770 :REM'
6780 :REM'.....resistance
6790 ZX=1:Z$=" ohms"
6800 IF Z>=10^3 THEN ZX=10^3:Z$=" kilohms"
6810 IF Z>=10^6 THEN ZX=10^6:Z$=" megohms"
6820 LOCATE CSRLIN-1
6830 RETURN
6840 :REM'
6850 :REM'.....title page
6860 TB=7
6870 PRINT TAB(TB);
6880 PRINT "Phase difference networks are linear circuits with one input and"
6890 PRINT TAB(TB);
6900 PRINT "two outputs. With a constant input amplitude, the two output"
6910 PRINT TAB(TB);
6920 PRINT "amplitudes are constant with frequency, but their phases shift in"
6930 PRINT TAB(TB);
6940 PRINT "such a way as to keep their phase difference constant over some"
6950 PRINT TAB(TB);
6960 PRINT "bandwidth. When the phase difference is 90° the circuits are useful"
6970 PRINT TAB(TB);
6980 PRINT "for SSB generation, antenna pattern and polarization control,"
6990 PRINT TAB(TB);
7000 PRINT "signal processing, FSK systems, CRT display generators, and solid"
7010 PRINT TAB(TB);
7020 PRINT "state power module combining. With 60° or 120° shift, three phase"
7030 PRINT TAB(TB);
7040 PRINT "power amplifier combining is possible."
7050 RETURN
7060 :REM'
7070 :REM'.....end
7080 GOSUB 7110:GOTO 130
7090 END
7100 :REM'
7110 :REM'.....PRT
7120 KEY OFF:GOSUB 7190:LOCATE 25,5:COLOR 0,2
7130 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
7140 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
7150 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 7150 :ELSE GOSUB 7190
7160 IF Z$="3"THEN RETURN
7170 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
7180 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 7120
7190 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
