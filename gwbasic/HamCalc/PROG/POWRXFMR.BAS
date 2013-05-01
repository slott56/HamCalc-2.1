10 :REM'POWRXFMR - Power Transformer Design - 20 MAR 2000 rev. 22 APR 2004
20 IF EX$=""THEN EX$="EXIT"
30 COLOR 7,0,1
40 PI=4*ATN(1)  :REM'3.141593
50 DIM GA(40,7)
60 LN$=STRING$(60,32)
70 GOSUB 2660  :REM'AWG calculator
80 GOTO 190
90 :REM'
100 :REM'.....erase
110 COLOR 7,0:FOR Z=LN TO LN+8:LOCATE Z:PRINT LN$:NEXT Z:
120 RETURN
130 :REM'
140 :REM'.....print Wa product
150 LOCATE 12,61
160 COLOR 0,7:PRINT USING " Wa=AxBxCxD= ##.###";WA:COLOR 7,0
170 RETURN
180 :REM'
190 :REM'.....start
200 CLS:KEY OFF
210 COLOR 15,2
220 PRINT " POWER TRANSFORMER DESIGN";TAB(57)"by George Murphy VE3ERP ";
230 COLOR 1,0:PRINT STRING$(80,223);
240 COLOR 7,0
250 PRINT TAB(5)"References:"
260 PRINT TAB(5)"1. Practical Transformer Design Handbook, Erik Lowdon, ";
270 PRINT "pp 37-40."
280 PRINT TAB(13)"(Howard W. Sams & Co. Inc.)"
290 PRINT TAB(5);
300 PRINT "2. Reference Data for Radio Engineers, 2nd edition, 1946, pp ";
310 PRINT "124-126."
320 PRINT TAB(13)"(Federal Telephone & Radio Corp./I.T.& T. Corp.)"
330 PRINT TAB(5);
340 PRINT "3. CQ VHF, Summer, 2003, pp  24-28."
350 PRINT
360 LN=CSRLIN:T=31:GOSUB 2500 :REM'print diagram
370 PRINT " The table of round enameled copper wire data used for the equatio";
380 PRINT "ns in this   "
390 PRINT " program may be found in HAMCALC's ";CHR$(34);"Copper Wire Data";
400 PRINT CHR$(34)" program."
410 PRINT
420 LN=CSRLIN:COLOR 0,7:LOCATE LN,23
430 PRINT " Press 1 to continue or <0> to EXIT ";:COLOR 7,0
440 Z$=INKEY$:IF Z$=""THEN 440
450 IF Z$="0"THEN CLS:RUN EX$
460 IF Z$="1"THEN 480
470 GOTO 440
480 CLS:LN=1:T=61:GOSUB 2500 :REM'print diagram
490 LOCATE 1:COLOR 7,0
500 INPUT " ENTER: Mains frequency in Hz.....................";F
510 INPUT " ENTER: Input voltage.............................";V1
520 INPUT " ENTER: Output voltage............................";V2
530 INPUT " ENTER: Maximum output current (amps).............";I2
540 VA=V2*I2
550 LN=1:GOSUB 100
560 LOCATE 1:COLOR 15
570 PRINT USING " DESIGN FOR A ## Hz #### VA  POWER TRANSFORMER";F,VA
580 PRINT :COLOR 10
590 PRINT " Current densities for small transformers are usually in   "
600 PRINT " the range of 500 to 1200 circular mils per ampere. Typical"
610 PRINT " ratings are: Intermittent Duty..(75°C rise):   500 CM/amp "
620 PRINT "              Commercial Duty....(50°C rise):   700 CM/amp "
630 PRINT "              Heavy Duty.........(25°C rise):  1000 CM/amp "
640 PRINT :COLOR 0,7:INPUT " ENTER: Current density in CM/amp";S
650 LN=2:GOSUB 100
660 LOCATE 2
670 PRINT USING " Current density........................ #####.# CM/amp";S
680 PRINT :COLOR 14
690 PRINT " Flux densities may range from less than 10,000 to more    "
700 PRINT " than 16,000 gauss. The type of iron core most commonly    "
710 PRINT " used in small power transformers is silicon iron, which   "
720 PRINT " may be used at flux densities of 12000 - 14000 gauss.   "
730 PRINT :COLOR 0,7:INPUT " ENTER: Core flux density in gauss";G:KG=G*10^-3
740 LN=3:GOSUB 100
750 LOCATE 3
760 PRINT USING " Core flux density (silicon core)....... #####.# kilogauss";KG
770 LN=CSRLIN
780 WA=17.260000228881836!*S*VA/(F*G)  :REM'Wa product a*b*c*d
790 ABCD=WA              :REM'initial wa
800 GOSUB 140
810 AOPT=(WA/0.75!)^(1/4)  :REM'value of A when B = A (square core)
820 :REM'
830 COLOR 10:LOCATE 5
840 PRINT " From manufacturer's data sheets, select a lamination with"
850 PRINT USING " a core dimension A near #.### in.";AOPT
860 PRINT:COLOR 0,7
870 INPUT " ENTER: Dim. A of selected lamination";A
880 INPUT " ENTER: Dim. C of selected lamination";C
890 INPUT " ENTER: Dim. D of selected lamination";D
900 LN=5:GOSUB 100
910 LOCATE 4
920 PRINT USING "  Selected lamination dimension A....... #####.### in.";A
930 PRINT USING "  Selected lamination dimension C....... #####.### in.";C
940 PRINT USING "  Selected lamination dimension D....... #####.### in.";D
950 BOPT=WA/(A*C*D)
960 :REM'
970 LOCATE 8
980 PRINT USING "  Optimum dimension B................... #####.### in.";BOPT
990 WA=ABCD:GOSUB 140
1000 LOCATE 10:COLOR 0,7:INPUT " ENTER: Your choice of dimension B";B
1010 WA=A*B*C*D:GOSUB 140
1020 LN=7:GOSUB 100
1030 LOCATE 7
1040 PRINT USING "  Selected lamination dimension B....... #####.### in.";B
1050 LOCATE 9:COLOR 10
1060 PRINT " For most applications, estimate efficiency at 90%"       ""
1070 PRINT
1080 COLOR 0,7:INPUT " ENTER: Estimated efficiency (%)";EFF:EF=EFF/100
1090 COLOR 7,0:FOR Z=8 TO 10:LOCATE Z:PRINT LN$:NEXT Z
1100 LOCATE 8
1110 PRINT USING " Estimated efficiency................... #####.#%";EF
1120 P=VA/EF
1130 COLOR 7,0:FOR Z=8 TO 10:LOCATE Z:PRINT LN$:NEXT Z
1140 LOCATE 8
1150 PRINT USING " Input power @ ##% estimated efficiency: #####.# watts";EFF,P
1160 :REM'
1170 PRINT TAB(31)"PRIMARY";TAB(42)"SECONDARY"
1180 PRINT USING " Voltage................... #####.### v. #####.### v.";V1,V2
1190 I1=P/V1
1200 I2=VA/V2
1210 T1=V1*10^8/(28.639999389648438!*F*A*B*G)
1220 T2=V2/V1*T1:T2X=CINT(T2)
1230 T1=CINT(T1):T2=CINT(T2)
1240 PRINT USING " Number of turns........... #####         ####    ";T1,T2
1250 PRINT USING " Current................... #####.### amp ####.### amp";I1,I2
1260 :REM'
1270 A1=S*I1           :REM'primary wire area in circular mils
1280 W1=SQR(A1)/10^3   :REM'primary wire diameter
1290 FOR Z=40 TO 10 STEP -1
1300 IF W1<GA(Z,1)THEN 1320 :ELSE 1310
1310 NEXT Z
1320 G1=Z              :REM'AWG #
1330 WP=GA(Z,1)        :REM'bare wire dia.
1340 DP=GA(Z,2)        :REM'O.D. over enamel
1350 TPIP=GA(Z,3)      :REM'turns per inch
1360 RMP=GA(Z,5)*1.1200000047683716!  :REM'ohms/M ft. @ 50°C
1370 CMP=GA(Z,6)       :REM'coil margin
1380 LIP=GA(Z,7)       :REM'insulation layer
1390 :REM'
1400 A2=S*I2           :REM'secondary wire area in circular mils
1410 W2=SQR(A2)/10^3   :REM'secondary wire diameter
1420 PRINT USING " Minimum wire diameter..... #####.### in. ####.### in.";W1,W2
1430 FOR Z=40 TO 10 STEP -1
1440 IF W2<GA(Z,1)THEN 1460 :ELSE 1450
1450 NEXT Z
1460 G2=Z              :REM'AWG #
1470 WS=GA(Z,1)        :REM'bare wire dia.
1480 DS=GA(Z,2)        :REM'O.D. over enamel
1490 TPIS=GA(Z,3)      :REM'turns per inch
1500 RMS=GA(Z,5)*1.1200000047683716!  :REM'ohms/M ft. @ 50°C.
1510 CMS=GA(Z,6)       :REM'coil margin
1520 LIS=GA(Z,7)       :REM'insulation layer
1530 PRINT USING " Selected wire diameter.... #####.### in. ####.### in.";WP,WS
1540 PRINT USING " Selected wire gauge number ##### AWG     #### AWG";G1,G2
1550 LN=CSRLIN:COLOR 10
1560 PRINT " Press number in <1> for:"
1570 PRINT "  <1) Industrial winding, with bobbin, paper interleaving and cover"
1580 PRINT "  <2> Economy winding, wire only, with minimum clearances"
1590 Z$=INKEY$:IF Z$=""THEN 1590
1600 IF Z$="1"THEN COLOR 7:GOSUB 1630:GOTO 1660
1610 IF Z$="2"THEN COLOR 7:GOSUB 1630:GOTO 1830
1620 GOTO 1590
1630 COLOR 7,0:FOR Z=LN TO LN+3:LOCATE Z:PRINT STRING$(79,32):NEXT Z:LOCATE LN
1640 RETURN
1650 :REM'
1660 :REM'.....layers (industrial)
1670 BT=0.09200000017881393!   :REM'bobbin thickness
1680 CT=0.019999999552965164!    :REM'cover thickness
1690 TL1=INT((D-GA(G1,6)*2)*GA(G1,3)) :REM'pri.turns per layer
1700 TL2=INT((D-GA(G2,6)*2)*GA(G2,3)) :REM'sec.turns per layer
1710 NL1=INT(T1/TL1)+1        :REM'pri.no.of layers
1720 NL2=INT(T2/TL2)+1        :REM'sec.no.of layers
1730 L1=GA(G1,2)+GA(G1,7)     :REM'pri. wire + layer insulation
1740 L2=GA(G2,2)+GA(G2,7)     :REM'sec. wire + layer insulation
1750 HT=BT+(NL1*L1+NL2*L2)+CT :REM'thickness of bundle
1760 W1=L1*NL1:W2=L2*NL2      :REM'thickness of pri.& sec.bundles
1770 M1=T1*(2*(A+B+4*BT)+2*PI*W1/2)/12      :REM'length of pri.wire in ft.
1780 M2=T2*(2*(A+B+4*BT)+2*PI*(W1+W2)/2)/12 :REM'length sec.of wire in ft.
1790 R1=GA(G1,5)*1.1200000047683716!*M1/10^3 :REM'pri.resistance
1800 R2=GA(G2,5)*1.1200000047683716!*M2/10^3 :REM'sec.resistance
1810 GOTO 1980
1820 :REM'
1830 :REM'.....layers (economy)
1840 TL1=INT((D-GA(G1,2)*4)*GA(G1,3))
1850 TL2=INT((D-GA(G1,2)*4)*GA(G2,3))
1860 NL1=INT(T1/TL1)+1
1870 NL2=INT(T2/TL2)+1
1880 L1=GA(G1,2)  :REM'pri. wire only
1890 L2=GA(G2,2)  :REM'sec. wire only
1900 HT=NL1*L1+NL2*L2
1910 W1=L1*NL1:W2=L2*NL2
1920 M1=T1*(2*(A+B)+2*PI*W1/2)/12      :REM'length of pri.wire in ft.
1930 M2=T2*(2*(A+B)+2*PI*(W1+W2)/2)/12 :REM'length of sec.wire in ft.
1940 R1=GA(G1,5)*1.1200000047683716!*M1/10^3  :REM'pri.resistance
1950 R2=GA(G2,5)*1.1200000047683716!*M2/10^3  :REM'sec.resistance
1960 GOTO 1980
1970 :REM'
1980 PRINT USING " Turns per layer........... #####         ####    ";TL1,TL2
1990 PRINT USING " Number of layers.......... #####         ####    ";NL1,NL2
2000 PRINT USING " Length of wire............ #####.## ft.  ####.## ft.";M1,M2
2010 PRINT USING " Resistance of wire @ 50°C. #####.## Ω    ####.## Ω";R1,R2
2020 C1=R1*I1^2:C2=R2*I2^2
2030 PRINT USING " Copper loss @ 50°C. ...... #####.## w.   ####.## w.";C1,C2;
2040 PRINT USING " (total loss = ###.## w.)";C1+C2
2050 PRINT USING " Total layer thickness............. ###.### in.";HT;
2060 PRINT USING "(to fit #.### window dim. C)";C
2070 IF HT<=C THEN 2090
2080 BEEP:COLOR 14:PRINT " LAYER THICKNESS EXCEEDS WINDOW OPENING! "
2090 COLOR 0,7:PRINT " Want to try a different dimension B or class of ";
2100 PRINT "winding?   (y/n) "
2110 Z$=INKEY$:IF Z$=""THEN 2110
2120 IF Z$="n"AND HT>C THEN 2200
2130 IF Z$="n"THEN 2380
2140 IF Z$="y"THEN 2160
2150 GOTO 2110
2160 COLOR 7,0:VIEW PRINT 7 TO 24:CLS:VIEW PRINT
2170 LN=1:T=61:GOSUB 2500 :REM'print diagram
2180 GOTO 970
2190 :REM'
2200 :REM'.....notes
2210 CLS:COLOR 0,7:PRINT
2220 PRINT " To reduce total layer thickness to fit the window, you can reduc";
2230 PRINT "e the wire"
2240 PRINT " size and/or number of turns by any, or a combination of any, of ";
2250 PRINT "the following"
2260 PRINT " options:"
2270 PRINT
2280 PRINT "  1. Increase core lamination dimension B (reduces turns, increas";
2290 PRINT "es weight)"
2300 PRINT "  2. Increase current density (reduces wire sizes, increases temp";
2310 PRINT "erature rise)"
2320 PRINT "  3. Reduce output current (reduces wire sizes, lowers VA rating)"
2330 PRINT
2340 COLOR 7,0:LOCATE ,23:PRINT " Press any key to continue . . . "
2350 IF INKEY$=""THEN 2350
2360 CLS:GOTO 190
2370 :REM'
2380 :REM'.....efficiency
2390 COLOR 7,0
2400 IF HT>C THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):LOCATE CSRLIN-1
2410 LOCATE CSRLIN-1:PRINT STRING$(79,32):LOCATE CSRLIN-1
2420 WT=6*B*A^2*0.27000001072883606!
2430 C=(C1+C2)*1.100000023841858! :REM'estimated core loss assumed 110% of copper loss
2440 PRINT USING " Approximate weight of core........ ###.# lb.";WT;
2450 PRINT USING " (estimated core loss ##.## Ω";C;:PRINT ")"
2460 EST=VA*100/(VA+C1+C2+C)
2470 PRINT USING " Approximate actual efficiency..... ###.#%";EST;
2480 GOTO 2940  :REM'end
2490 :REM'
2500 :REM'.....diagram
2510 COLOR 0,7:LOCATE LN
2520 LOCATE ,T:PRINT "  Core Dimensions  "
2530 LOCATE ,T:PRINT "   ┌───────────┐   "
2540 LOCATE ,T:PRINT " ┌─┼»┌─┐   ┌─┐«┼─┐ "
2550 LOCATE ,T:PRINT " │ │ │ │   │ │ │ │ "
2560 LOCATE ,T:PRINT " D │ │ │   │ │ │ D "
2570 LOCATE ,T:PRINT " └»├─┴─┴───┴─┴─┤«┘ "
2580 LOCATE ,T:PRINT "   └───────────┘   "
2590 LOCATE ,T:PRINT "    »│C│«A»│C│«    "
2600 LOCATE ,T:PRINT " ┌»┌─┬─┬───┬─┬─┐   "
2610 LOCATE ,T:PRINT " B │ │ │   │ │ │   "
2620 LOCATE ,T:PRINT " └»└─┴─┴───┴─┴─┘   "
2630 COLOR 7,0
2640 RETURN
2650 :REM'
2660 :REM'.....AWG calculator
2670 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
2680 J=1.0063860416412354!:Q=SQR(J)
2690 FOR Z=1 TO 40
2700 N=Z+3
2710 Q=Q*J
2720 GA(Z,1)=0.46000000834465027!/K^N
2730 GA(Z,2)=GA(Z,1)*Q
2740 RAD=GA(Z,1)/2 :REM'wire radius
2750 AREA= PI*RAD^2
2760 GA(Z,3)=1/(GA(Z,1)*1.100000023841858!)
2770 GA(Z,4)=AREA*10^3  :REM'current capacity in amps @ 1000 amps/sq.in.
2780 GA(Z,5)=(304.79998779296875!/(58*PI*(RAD*25.399999618530273!)^2))   :REM'ohms/M feet @ 20°C
2790 GA(Z,6)=0.25!  :REM'coil margin
2800 IF Z>14 THEN GA(Z,6)=0.1875!
2810 IF Z>17 THEN GA(Z,6)=0.125!
2820 IF Z>31 THEN GA(Z,6)=0.09375!
2830 IF Z>37 THEN GA(Z,6)=0.0625!
2840 GA(Z,7)=0.009999999776482582!  :REM'interlayer insulation
2850 IF Z>17 THEN GA(Z,7)=0.004999999888241291!
2860 IF Z>21 THEN GA(Z,7)=0.003000000026077032!
2870 IF Z>24 THEN GA(Z,7)=0.0020000000949949026!
2880 IF Z>29 THEN GA(Z,7)=0.001500000013038516!
2890 IF Z>33 THEN GA(Z,7)=0.0010000000474974513!
2900 IF Z>38 THEN GA(Z,7)=0.000750000006519258!
2910 NEXT Z
2920 RETURN
2930 :REM'
2940 :REM'.....end
2950 GOSUB 2970:GOTO 190
2960 :REM'
2970 :REM'PRT
2980 KEY OFF:GOSUB 3050:LOCATE 25,5:COLOR 0,2
2990 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3000 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3010 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3010 :ELSE GOSUB 3050
3020 IF Z$="3"THEN RETURN
3030 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3040 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2980
3050 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
