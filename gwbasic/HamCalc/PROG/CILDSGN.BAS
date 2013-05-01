10 :REM'COILDSGN - Coil Design - 22 NOV 94 rev. 09 DEC 2005
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$:PROG$="coildsgn"::ELSE GO$=PROG$
50 Y$=PROG$
60 COMMON EX$,PROG$,LD,LX,QQ,I,I$,F,FQ,UH,D,L,NN,W,DIA
70 COMMON A,A1,B1,B,XT,C1,L1,L2,FH,FL,AMAX,AWG,FLAG
80 H=I  :REM'metric multipler
90 IF UH THEN UH=INT(UH*10^3+0.5!)/10^3
100 COLOR 7,0,1
110 DIM GA(50)    :REM'AWG gauge
120 DIM G#(9,2)   :REM'shotgun gauges
130 DIM P$(11,2)  :REM'pipe sizes
140 UL$=STRING$(80,205)
150 U1$="####.###"
160 U2$="####.#"
170 PI=4*ATN(1)     :REM'3.141593
180 :REM'
190 :REM'.....AWG calculator
200 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
210 FOR Z=1 TO 50
220 N=Z+3
230 GA(Z)=0.46000000834465027!/K^N
240 NEXT Z
250 :REM'
260 :REM'.....start
270 IF PROG$="coilq"THEN COLOR 7,0,0:GOTO 310
280 COLOR 15,2
290 PRINT " COIL DESIGNER";TAB(57);"by George Murphy VE3ERP ";
300 COLOR 1,0:PRINT STRING$(80,223);
310 COLOR 7,0
320 IF PROG$="coildsgn"THEN COLOR 7,0,0:GOTO 350
330 IF PROG$="shortant"THEN 630
340 IF LD THEN LDIN=LD:GOTO 440  :REM'LDIN = originating L/d ratio
350 GOSUB 4050     :REM'preface - page 1
360 COLOR 0,7:LOCATE 25,24
370 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
380 IF GO$=PROG$ THEN GO$=EX$
390 IF Y$="es2b"THEN GO$=Y$
400 Z$=INKEY$:IF Z$=""THEN 400
410 IF Z$="0"THEN QQ=0:CLS:CHAIN GO$
420 IF Z$="1"THEN 630
430 GOTO 400
440 IF QQ=0 THEN 630
450 IF PROG$="coilq" THEN DIA=W:GOTO 1080
460 PRINT " You are seeking a";UH;"µH coil"
470 PRINT " with a True Q of";CINT(QQ);USING " @###.### MHz";FQ
480 PRINT " and a Length/diameter ratio of";USING "##.###:1";LD
490 PRINT
500 PRINT " In the following design steps you will have the options of selec";
510 PRINT "ting standard "
520 PRINT " conductor and coil form sizes nearest to the design values shown";
530 PRINT ", and to round"
540 PRINT " off the number of turns. Each of these changes may alter the L/d";
550 PRINT " ratio which  "
560 PRINT " will change the Q accordingly. If the deviations from the design";
570 PRINT " values are   "
580 PRINT " slight the change in Q will not be significant.                 "
590 PRINT
600 PRINT " Press any key to continue . . . . "
610 IF INKEY$=""THEN 610
620 :REM'
630 LN=3:GOSUB 1010 :REM'clear screen
640 IF I THEN 650 :ELSE 670
650 IF I$=" in."THEN UM=1:UM$=I$ :ELSE UM=25.399999618530273!:UM$=" mm"
660 GOTO 760
670 PRINT " Press number in < > to choose standard units of measure:"
680 PRINT UL$;
690 PRINT "  < 1 >  Metric"
700 PRINT "  < 2 >  U.S.A./Imperial"
710 Z$=INKEY$
720 IF Z$="1"THEN H=1:UM$=" mm":I$="cm":GOTO 760
730 IF Z$="2"THEN H=2.5399999618530273!:UM$=" in.":I$="in.":GOTO 760
740  GOTO 710
750 :REM'
760 COLOR 7,0,0:IF Y$="shortant"THEN CLS:LD=0.5!:GOTO 1050
770 CLS:GOSUB 4550:PRINT :GOSUB 4630        :REM'preface - page 2
780 PRINT
790 IF LD=0 AND Y$="es2b"THEN CLS:GOTO 950
800 IF FQ THEN 930
810 IF LD THEN 1050
820 PRINT " The frequency of operation does not affect the design of a coil, ";
830 PRINT "only its Q,"
840 PRINT " which varies with frequency. If you want to see a table of typica";
850 PRINT "l Q values,"
860 PRINT " then ";:COLOR 0,7:PRINT " enter a frequency:":COLOR 7,0
870 PRINT
880 PRINT " Otherwise ";:COLOR 0,7:PRINT " enter 0 to continue:"
890 PRINT
900 INPUT " ENTER: Frequency of operation in MHz. or 0 to continue";FQ:COLOR 7,0
910 IF FQ=0 THEN LOCATE CSRLIN-1:GOTO 950
920 IF LD=0 AND Y$="es2b"THEN CLS:GOTO 950
930 IF LD THEN 1050
940 CLS:GOSUB 4650:LN=4:GOSUB 1010:GOSUB 3770  :REM'L/D ratio chart
950 COLOR 0,7
960 INPUT " To compute coil diameter, ENTER: ANY desired L/d ratio....";LD
970 LDIN=LD  :REM'originating L/d ratio
980 COLOR 7,0:IF LD=0 THEN BEEP:LN=CSRLIN-1:GOSUB 1010:GOTO 780
990 GOTO 1050
1000 :REM'
1010 :REM'.....erase screen to bottom
1020 VIEW PRINT LN TO 23:CLS:VIEW PRINT:LOCATE LN
1030 RETURN
1040 :REM'
1050 :REM'.....start
1060 COLOR 7,0:CLS
1070 :REM'.....input inductance
1080 COLOR 0,7:PRINT " DESIGN SPECIFICATIONS for a";
1090 PRINT USING "##.###:1 length-to-diameter ratio coil:";LD
1100 COLOR 7,0
1110 IF PROG$="coilq"THEN 1760
1120 IF UH THEN COLOR 7,0:GOTO 1160
1130 COLOR 7,0:INPUT " ENTER: Inductance (µH)......................";UH
1140 LN=CSRLIN-1:GOSUB 1010
1150 IF UH=0 THEN BEEP:GOTO 1130
1160 PRINT " Inductance......................";USING U1$;UH;
1170 PRINT " µH"
1180 LN=CSRLIN
1190 IF WHIP=0 THEN 1260
1200 PRINT UL$;
1210 PRINT TAB(7);
1220 PRINT "FOR MOBILE WHIP LOADING COILS USE THE LARGEST PRACTICABLE DIAMETER"
1230 PRINT TAB(7);
1240 PRINT "WIRE OR TUBING CONDUCTOR."
1250 :REM'
1260 :REM'.....input conductor size
1270 IF PROG$="coilequa"THEN DIA=WW:GOTO 1760
1280 IF PROG$="es2b"THEN DIA=W:GOTO 1760
1290 IF PROG$="shortant"THEN 1760
1300 PRINT UL$;
1310 IF MIN*MAX=0 THEN 1590
1320 MN=MIN*H:MX=MAX*H
1330 PRINT TAB(9);"Desired True Q.......................";USING " ####";QQ
1340 PRINT " Coil will be designed with turn spacing equal to twice the ";
1350 PRINT "conductor diameter "
1360 PRINT " to facilitate using scrap lengths of the windings wire as winding";
1370 PRINT " spacers."
1380 PRINT " Conductor sizes ";
1390 PRINT USING "less than ##.### or more than ##.###";MN,MX;
1400 PRINT UM$;" will produce Q values";
1410 PRINT " and coil diameters beyond the range of your specifications."
1420 COLOR 0,7
1430 PRINT " Select a conductor diameter within the range of ";
1440 PRINT USING "##.### and ##.###";MN,MX;:PRINT UM$;" ":COLOR 7,0
1450 PRINT USING "  Conductors ##.###";MN;
1460 PRINT UM$;" dia. will produce a Q lower than the desired value."
1470 PRINT USING "  Conductors ##.###";(MN+MX)/2;
1480 PRINT UM$;" dia. will produce a Q near the desired value."
1490 PRINT USING "  Conductors ##.###";MX;
1500 PRINT UM$;" dia. will produce a Q higher than the desired value."
1510 PRINT
1520 COLOR 0,7
1530 PRINT " INSULATION MAY INTRODUCE DIELECTRIC LOSSES, AFFECTING COIL Q! "
1540 COLOR 7,0
1550 FOR Z=40 TO 1 STEP -1
1560 IF GA(Z)<MIN OR GA(Z)>MAX THEN 1590
1570 NEXT Z
1580 :REM'
1590 PRINT " Press letter in < > to enter your choice of coil conductor size:"
1600 PRINT "   < a >  Diameter in millimetres"
1610 PRINT "   < b >  Diameter in inches"
1620 PRINT "   < c >  AWG#"
1630 Z$=INKEY$
1640 IF Z$="a"OR Z$="A"THEN WS$="mm":GOTO 1680
1650 IF Z$="b"OR Z$="B"THEN WS$="inches":GOTO 1680
1660 IF Z$="c"OR Z$="C"THEN WS$="AWG#":GOTO 1680
1670 GOTO 1630
1680 PRINT " ENTER: Conductor diameter (";WS$;")";:INPUT Z
1690 IF WS$="mm"THEN DIA=Z/25.399999618530273!
1700 IF WS$="inches"THEN DIA=Z
1710 IF WS$="AWG#"THEN AWG=Z:DIA=GA(Z)
1720 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)
1730 AWG=LOG(0.46000000834465027!/DIA)/(LOG(K))-3
1740 GOSUB 1010
1750 :REM'
1760 PRINT USING" Conductor diameter.............. ###.### in.= ##.# mm.";DIA,DIA*25.399999618530273!
1770 LN=CSRLIN
1780 IF Y$="es2b"THEN 1800
1790 IF FQ THEN W$="1":GOTO 1910
1800 PRINT UL$;
1810 PRINT " Press number in <> to select conductor type:"
1820 PRINT UL$;
1830 COLOR 0,7
1840 PRINT " INSULATION MAY INTRODUCE DIELECTRIC LOSSES, AFFECTING COIL Q! "
1850 COLOR 7,0
1860 PRINT "  < 1 > Bare"
1870 PRINT "  < 2 > Enamelled"
1880 PRINT "  < 3 > Insulated "
1890 COLOR 7,0
1900 W$=INKEY$
1910 IF W$="1" THEN WIR$="bare":SP=2*DIA:GOTO 1960
1920 IF W$="2" THEN WIR$="enamelled":SP=DIA*1.350000023841858!:GOTO 1960
1930 IF W$="3" THEN WIR$="insulated":GOTO 1960
1940 GOTO 1900
1950 :REM'
1960 :REM'.....turns per inch
1970 LOCATE 3,57:PRINT WIR$;USING " ##.# AWG";AWG
1980 K#=(0.46000000834465027!/0.004999999888241291!)^(1/39)
1990 AWG=LOG(0.46000000834465027!/DIA)/(LOG(K#))-3
2000 PRINT USING " (AWG###.#)";AWG
2010 IF W$="1"OR W$="2"THEN 2130
2020 GOSUB 1010
2030 PRINT UL$;
2040 TB=9
2050 PRINT TAB(TB);
2060 PRINT "Wrap some of the #";AWG;WIR$;" wire around a ruler to determine"
2070 PRINT TAB(TB);
2080 PRINT "the maximum number of turns that can be wound in 25mm (1 inch)."
2090 IF H=1 THEN CF=CF/2.5399999618530273!
2100 PRINT UL$;
2110 INPUT " ENTER: How many turns can be wound in 25mm (1 inch)";TPI
2120 SP=1/TPI
2130 GOSUB 1010
2140 :REM'.....calculate coil length and form diameter by iteration
2150 CD=10:XD=10                  :REM'default coil diameter
2160 IF PROG$="coilq"THEN CD=D+W
2170 L=LD*CD                      :REM'length=L/D ratio x diameter
2180 N=(SQR(UH*(18*CD+40*L)))/CD  :REM'number of turns
2190 IF ABS(N*SP-L)<9.999999747378752e-05! THEN 2230
2200 IF SGN(N*SP-L)<>SGN(XD)THEN XD=-XD/10
2210 CD=CD+XD:GOTO 2170
2220 :REM'
2230 T=1/SP                       :REM'turns per inch
2240 IF W$="1" THEN X=DIA         :REM'X=O.D.of wire c/w insulation, if any
2250 IF W$="2"OR W$="3"THEN X=SP
2260 CF=CD-X                      :REM'coil form diameter
2270 :REM'
2280 GOSUB 1010 :REM'erase to bottom
2290 PRINT USING " Coil diameter................... ###.### in.= ####.## cm.";CF+X,(CF+X)*2.5399999618530273!
2300 IF QQ THEN R=(CF+X)/2:LN=CSRLIN-1:GOSUB 3630:LOCATE LN,1
2310 PRINT USING" O.D. of coil form.............D= ###.### in.= ####.## cm.";CF,CF*2.5399999618530273!
2320 COLOR 14:PRINT "***";:COLOR 7,0
2330 PRINT " Number of turns..............";USING U1$;N
2340 PRINT USING" Length of coil.................. ###.### in.= ####.# cm.";L,L*2.5399999618530273!
2350 PRINT " Number of turns per 25 mm (inch)";USING U2$;T
2360 PRINT " Length-to-Diameter ratio........";USING U1$;L/CD;
2370 PRINT ":1"
2380 COLOR 14:PRINT "***";
2390 COLOR 7
2400 PRINT " Coil form diameter can be any size near D";
2410 COLOR 14:PRINT "***";
2420 COLOR 7
2430 PRINT UL$;
2440 IF PROG$="coilq"THEN LIN=CSRLIN:GOTO 2490
2450 LOCATE CSRLIN-1,18
2460 PRINT " SOME SUGGESTED SOURCES OF COIL FORM MATERIAL "
2470 PRINT " PVC pipe outside diameters:";
2480 PRINT TAB(39)"Shotgun shell diameters:"
2490 LN=CSRLIN
2500 DATA 3/8,1/2,3/4," 1 "," 1¼"," 1½"," 2 "," 2½"," 3 "," 3½"," 4 "
2510 DATA .675, .84, 1.05, 1.315, 1.66, 1.9, 2.375, 2.875, 3.5, 4, 4.5
2520 FOR Y=1 TO 11:READ P$(Y,1):NEXT Y
2530 FOR Y=1 TO 11:READ P$(Y,2):NEXT Y
2540 FOR Y=1 TO 10
2550 PRINT "   nom. ";P$(Y,1);" =";USING "##.###";VAL(P$(Y,2));
2560 PRINT " in. (";USING "###.#";VAL(P$(Y,2))*25.399999618530273!;:PRINT " mm)";
2570 IF Y<10 THEN PRINT ""
2580 NEXT Y
2590 LOCATE LN
2600 :REM'
2610 DATA ".410  ", .41, 28-Ga., .55, 20-Ga., .615, 16-Ga., .662
2620 DATA 12-Ga., .729, 10-Ga., .775,"","","","","",""
2630 FOR Y=1 TO 6:READ G$(Y,1),G$(Y,2)
2640 LOCATE ,42:PRINT G$(Y,1);USING "#####.###";VAL(G$(Y,2));
2650 PRINT " in. (";USING "###.#";VAL(G$(Y,2))*25.399999618530273!;:PRINT " mm)"
2660 NEXT Y
2670 RESTORE
2680 LOCATE 20,39
2690 PRINT "KODAK 35mm film plastic canister:"
2700 LOCATE 21,52:PRINT "1.245 in. ( 31.6mm ) dia."
2710 LOCATE 22,52:PRINT "1.750 in. ( 44.5mm ) long"
2720 LOCATE 23,39
2730 COLOR 14:PRINT "***";
2740 COLOR 7
2750 IF PROG$="coilq"THEN CF=D:GOTO 2810
2760 IF H=1 THEN J$="cm.":ELSE J$="in."
2770 COLOR 0,7:PRINT " ENTER: Coil form dia.("+J$+")";
2780 COLOR 14,0:PRINT "***";:INPUT CF
2790 IF H=1 THEN CF=CF/2.5399999618530273!
2800 IF H=1 THEN CH=CF/2.5399999618530273!
2810 CF=CF/H
2820 COLOR 7,0
2830 LN=11
2840 GOSUB 1010
2850 IF PROG$="coilq"THEN VIEW PRINT LIN TO 24:CLS:VIEW PRINT:LOCATE LIN
2860 PRINT
2870 :REM'
2880 :REM'.....re-calculate
2890 CD=CF+X                         :REM'coil diameter
2900 R=CD/2                          :REM'coil radius
2910 Q=R^2*T^2/UH                    :REM'factor
2920 L=ABS(-10-SQR(100+36*R*Q))/2/Q  :REM'length of winding
2930 N=(SQR(UH*(18*CD+40*L)))/CD     :REM'number of turns
2940 T=N/L                           :REM'turns per inch
2950 COLOR 0,7
2960 PRINT " DESIGN for a";CF;"in. diameter coil form"
2970 COLOR 7,0
2980 GOSUB 3010
2990 GOTO 3210
3000 :REM'
3010 :REM'.....screen print
3020 PRINT USING" Inductance...................... ###.### uH";UH
3030 PRINT USING" Conductor diameter.............. ###.### in.= ##.# cm.";DIA,DIA*2.5399999618530273!;
3040 PRINT " ";WIR$;:PRINT USING" (AWG ##.#)";AWG
3050 PRINT USING" Coil diameter................... ###.### in.= ##.# cm.";CF+X,(CF+X)*2.5399999618530273!
3060 PRINT USING" O.D.of coil form................ ###.### in.= ##.# cm.";CF,CF*H*2.5399999618530273!
3070 PRINT USING" Number of turns................. ###.#";N
3080 PRINT USING" Length of coil.................. ###.### in.= ##.# cm.";L,L*2.5399999618530273!
3090 PRINT USING" Turns per 25 mm (inch).......... ###.#";T
3100 LD=L/CD
3110 PRINT USING" Length-to-Diameter ratio........ ###.###:1";LD
3120 LN=CSRLIN
3130 IF LD>=0.4000000059604645! THEN PRINT "":GOTO 3150
3140 BEEP:COLOR 30,4:PRINT "«─ TOO LOW! "
3150 LW=(CD*PI*N)      :REM'length in inches
3160 IF UM=25.399999618530273! THEN UU=0.02539999969303608!:UU$=" m.":ELSE UU=1:UU$=UM$
3170 COLOR 7,0:LOCATE LN
3180 PRINT USING " Length of conductor required.... ###.# in.= ###.# cm.";LW,LW*2.4000000953674316!
3190 COLOR 7,0:RETURN
3200 :REM'
3210 :REM'.....end table of results
3220 GOSUB 3630
3230 IF N=INT(N)THEN Z$="n":GOTO 3300
3240 LN=23:GOSUB 1010:LOCATE 23:COLOR 0,7
3250 IF PROG$="coilq"THEN 3710
3260 PRINT " Do you want to round-off the number of turns?  (y/n) ";
3270 T=CSRLIN-1
3280 COLOR 30,4:PRINT "«─";:COLOR 7,0
3290 Z$=INKEY$
3300 IF Z$="n"THEN LN=23:GOSUB 1010:GOTO 3420
3310 IF Z$="y"THEN 3340
3320 GOTO 3290
3330 :REM'
3340 :REM'.....recalculate length
3350 LN=23:GOSUB 1010
3360 COLOR 0,7
3370 N=CINT(N)
3380 COLOR 7,0
3390 L=((CD^2*N^2/UH)-(18*CD))/40
3400 SP=L/N
3410 T=N/L
3420 LN=12:GOSUB 1010:LOCATE 12
3430 COLOR 0,7
3440 PRINT " ALTERNATE DESIGN for";N;
3450 PRINT "Turns on a";STR$(CF*UM);UM$;" diameter Coil Form:"
3460 COLOR 7,0
3470 GOSUB 3010
3480 LOCATE 23:COLOR 0,7:PRINT " Do you want to try another coil of the same ";
3490 PRINT "inductance? (y/n) ";
3500 COLOR 30,4:PRINT "«─";:COLOR 7,0
3510 GOSUB 3630
3520 Z$=INKEY$: IF Z$=""THEN 3520
3530 :REM'IF Z$="n"AND PROG$="coilq"THEN RUN"coilq"
3535 IF FLAG=1 THEN FLAG=0:RUN"coiltrue"
3540 IF Z$="y"THEN CLS:LD=LDIN:GOTO 670
3550 IF Z$="n"AND F=0 THEN LN=CSRLIN:GOSUB 1010":GOTO 3690"
3560 IF Z$="n"AND FQ<>0 THEN 3590
3570 IF Z$="n"THEN LN=23:GOSUB 1010:GOTO 3710
3580 GOTO 3520
3590 IF Y$="es2b"THEN 3610
3600 F=FQ*10^6:UH=UH:D=CD:L=L:NN=N:W=DIA:PROG$=Y$:CHAIN "coiltrue"
3610 LN=23:GOSUB 1010:GOSUB 4790:W=DIA:CHAIN Y$
3620 :REM'
3630 :REM'.....calculate Q
3640 IF FQ=0 THEN 3690
3650 RR=R*2.5399999618530273!:LL=L*2.5399999618530273!   :REM'dia.& radius in cm
3660 Q1=SQR(FQ*10^6)/(6.900000095367432!/RR+5.400000095367432!/LL)
3670 COLOR 15,1:LOCATE 24,2
3680 PRINT " Approximate True Q =";CINT(Q1);"at";FQ;"MHz.";
3690 COLOR 7,0:RETURN
3700 :REM'
3710 :REM'.....end
3720 GOSUB 4790:RUN GO$
3730 UH=0:DIA=0:FQ=0:LD=0
3740 IF EX$<>GO$ THEN QQ=0:CHAIN GO$
3750 GOTO 260    :REM'start
3760 :REM'
3770 :REM'.....L/d ratio chart
3780 CLS:GOSUB 4630:LOCATE 5
3790 COLOR 0,7
3800 PRINT " Typical L/d Ratios for Various Coil Diameters and Q Values at";
3810 COLOR 14,4:PRINT FQ;"MHz "
3820 COLOR 7,0:PRINT "  Dia.";
3830 K=50/SQR(2):D=0.25!:Z$="##.##"+CHR$(34)
3840 FOR Y=1 TO 9:Q=K*SQR(2)^Y:PRINT USING "│ Q=### ";Q;:NEXT Y:PRINT ""
3850 FOR Z=1 TO 17:D=D+0.25!
3860 PRINT USING Z$;D;    :REM'diameter
3870 FOR X=1 TO 9
3880  Q=K*SQR(2)^X
3890  R=D/2*2.5399999618530273!                    :REM'radius in cm
3900  LC=5.400000095367432!/(SQR(FQ*10^6)/Q-6.900000095367432!/R) :REM'length in cm
3910  LD=LC/(2*R)                   :REM'L/d ratio
3920  IF LD<0.3499999940395355! THEN PRINT "│∙∙∙∙∙∙∙";:GOTO 3940
3930  PRINT USING "│###.## ";LD;
3940  NEXT X:PRINT ""
3950 NEXT Z
3960 Z=9:LOCATE 18
3970 LOCATE ,Z:PRINT " L/d values shown are approximate "
3980 LOCATE ,Z:PRINT " for a 10 uH coil wound with #14  "
3990 LOCATE ,Z:PRINT " AWG wire. Actual values will be  "
4000 LOCATE ,Z:PRINT " computed according to parameters "
4010 LOCATE ,Z:PRINT " you will be asked to enter.      "
4020 COLOR 7,0:LOCATE 24
4030 RETURN
4040 :REM'
4050 :REM'.....preface - page 1
4060 TB=8
4070 LOCATE ,TB
4080 PRINT "  This program designs single-layer air-core coils using equations"
4090 LOCATE ,TB
4100 PRINT "published in the 1997 ARRL HANDBOOK, page 6.22. These equations"
4110 LOCATE ,TB
4120 PRINT "provide close approximations of values for frequencies in the 1-30"
4130 LOCATE ,TB
4140 PRINT "MHz range that are sufficiently accurate for most Amateur Radio"
4150 LOCATE ,TB
4160 PRINT "purposes. The calculations are useful in the VHF and UHF range but"
4170 LOCATE ,TB
4180 PRINT "only as a basis for further calculation and experimentation. The"
4190 LOCATE ,TB
4200 PRINT "program designs coils with pitches (c.c. distance between turns)"
4210 LOCATE ,TB
4220 PRINT "as follows:"
4230 COLOR 0,7
4240 LOCATE ,TB
4250 PRINT " - BARE CONDUCTOR (wire or tubing) @ twice its diameter.     "
4260 LOCATE ,TB
4270 PRINT "     (use scraps of the same size conductor as turn spacers)."
4280 LOCATE ,TB
4290 PRINT " - ENAMELLED WIRE @ outside diameter of the enamel.          "
4300 LOCATE ,TB:
4310 PRINT " - INSULATED WIRE @ outside diameter of the insulation.      "
4320 LOCATE ,TB:COLOR 12,0
4330 PRINT "WIRE INSULATION MAY INTRODUCE DIELECTRIC LOSSES, AFFECTING COIL Q!"
4340 COLOR 7,0
4350 PRINT
4360 LOCATE ,TB
4370 PRINT "  The accuracy of equations used in this program may decrease if"
4380 LOCATE ,TB
4390 PRINT "the recommended turn spacing is greatly increased. In every case"
4400 LOCATE ,TB
4410 PRINT "spread the windings evenly over the winding length and secure in"
4420 LOCATE ,TB
4430 PRINT "place with shellac or other suitable coating."
4440 IF LD THEN 4530
4450 IF Y$="es2b"THEN 4530
4460 LOCATE ,TB
4470 PRINT "  If coil Q is critical to your application, exit this program now"
4480 LOCATE ,TB
4490 PRINT "and run the ";CHR$(34);"Coil Q Calculator";CHR$(34);" program. ";
4500 PRINT "Then run this program"
4510 LOCATE ,TB
4520 PRINT "again from the Coil Q Calculator program menu."
4530 RETURN
4540 :REM'
4550 :REM'preface - page 2
4560 PRINT " The Length-to-diameter (L/d) ratio of a coil can affect its Q. A ";
4570 PRINT "high Q       "
4580 PRINT " ensures improved circuit efficiency, a narrower bandwidth, and le";
4590 PRINT "ss bandwidth "
4600 PRINT " noise. Primary design considerations are:"
4610 RETURN
4620 :REM'
4630 PRINT " Q refers to True Q, as opposed to Apparent Q read by a Q meter."
4640 PRINT " - Q increases with coil diameter. Q increases with coil length."
4650 PRINT " - Max.Q occurs at about .35-.45 L/d ratio, decreasing rapidly be";
4660 PRINT "low this range.";
4670 PRINT " - 0.5 to 2.0 L/d ratios are commonly used in many Amateur radio ";
4680 PRINT "applications."
4690 PRINT " - The conductor diameter should be as large as practicable."
4700 PRINT " - The turn spacing should be about twice the conductor diameter."
4710 PRINT " - The coil form should have a low dielectric constant.";
4720 PRINT " Air is best."
4730 PRINT " - Coils with L/d ratios less than 0.4:1 may be designed using W";
4740 PRINT "heeler's"
4750 PRINT "    1982 equation in the COIL EQUATION CALCULATOR program."
4760 PRINT " - Q can be calculated using the COIL Q CALCULATOR program."
4770 RETURN
4780 :REM'
4790 :REM'PRT
4800 KEY OFF:GOSUB 4870:LOCATE 25,5:COLOR 0,2
4810 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
4820 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
4830 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 4830 :ELSE GOSUB 4870
4840 IF Z$="3"THEN RETURN
4850 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
4860 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 4800
4870 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
4880 D=L/CD
