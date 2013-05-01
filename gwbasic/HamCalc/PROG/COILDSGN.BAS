10 :REM'COILDSGN - Coil Design - 22 NOV 94 rev. 13 FEB 2008
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$:PROG$="coildsgn"::ELSE GO$=PROG$
50 Y$=PROG$
60 COMMON EX$,PROG$,LD,LX,QQ,I,I$,F,FQ,UH,D,L,NN,W,WW,DIA,N,DD,FD
70 COMMON A,A1,B1,B,XT,C1,L1,L2,FH,FL,AMAX,FLAG,TPI
80 IF UH THEN UH=INT(UH*10^3+0.5!)/10^3
90 COLOR 7,0,0
100 DIM GA(50)    :REM'AWG gauge
110 DIM G#(9,2)   :REM'shotgun gauges
120 DIM P$(11,2)  :REM'pipe sizes
130 UL$=STRING$(80,205)
140 U1$="####.###"
150 U2$="####.#"
160 PI=4*ATN(1)     :REM'3.141593
170 :REM'
180 :REM'.....AWG calculator
190 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
200 FOR Z=1 TO 50
210 N=Z+3
220 GA(Z)=0.46000000834465027!/K^N
230 NEXT Z
240 :REM'
250 :REM'.....start
260 CLS
270 COLOR 15,2
280 PRINT " COIL DESIGNER";TAB(57);"by George Murphy VE3ERP ";
290 COLOR 1,0:PRINT STRING$(80,223);
300 COLOR 7,0
310 IF FLAG THEN 440
320 IF PROG$="shortant"THEN 700
330 IF LD THEN LDIN=LD:GOTO 430  :REM'LDIN = originating L/d ratio
340 GOSUB 4230     :REM'preface - page 1
350 COLOR 0,7:LOCATE 25,24
360 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
370 IF GO$=PROG$ THEN GO$=EX$
380 IF Y$="es2b"THEN GO$=Y$
390 Z$=INKEY$:IF Z$=""THEN 390
400 IF Z$="0"THEN QQ=0:CLS:CHAIN GO$
410 IF Z$="1"THEN 700
420 GOTO 390
430 IF QQ=0 THEN 700
440 PRINT " You are seeking a";UH;"µH coil"
450 Z=D-W
460 PRINT USING " wound on a form ##.### in.( ##.# cm.) diameter";Z,Z*2.5399999618530273!
470 :REM'IF FLAG THEN D=D+W
480 PRINT USING " with a Length/diameter ratio of ##.###:1";LD;
490 PRINT USING " using #.#### in. diameter wire";W
500 PRINT USING " operating at ###.### MHz";FQ
510 PRINT
520 IF FLAG THEN 640
530 :REM'
540 PRINT " In the following design steps you will have the options of selec";
550 PRINT "ting standard "
560 PRINT " conductor and coil form sizes nearest to the design values shown";
570 PRINT ", and to round"
580 PRINT " off the number of turns. Each of these changes may alter the L/d";
590 PRINT " ratio which  "
600 PRINT " will change the Q accordingly. If the deviations from the design";
610 PRINT " values are   "
620 PRINT " slight the change in Q will not be significant.                 "
630 PRINT
640 PRINT " . . . . Press 1 to continue . . . . "
650 Z$=INKEY$:IF Z$=""THEN 650
660 IF Z$="1"THEN 680
670 GOTO 650
680 IF FLAG THEN 710
690 :REM'
700 LN=3:GOSUB 1090 :REM'clear screen
710 IF I THEN 730 :ELSE 750
720 GOTO 650
730 IF I$=" in."THEN UM=1:UM$=I$ :ELSE UM=25.399999618530273!:UM$=" mm"
740 GOTO 840
750 PRINT " Press number in < > to choose standard units of measure:"
760 PRINT UL$;
770 PRINT "  < 1 >  Metric"
780 PRINT "  < 2 >  U.S.A./Imperial"
790 Z$=INKEY$
800 IF Z$="1"THEN UM=25.399999618530273!:UM$=" mm":GOTO 840
810 IF Z$="2"THEN UM=1:UM$=" in.":GOTO 840
820 GOTO 790
830 :REM'
840 IF FLAG THEN CLS:GOTO 1130
850 CLS:GOSUB 4730:PRINT :GOSUB 4810        :REM'preface - page 2
860 PRINT
870 IF LD=0 AND Y$="es2b"THEN CLS:GOTO 1030
880 IF FQ THEN 1010
890 IF LD THEN 1130
900 PRINT " The frequency of operation does not affect the design of a coil, ";
910 PRINT "only its Q,"
920 PRINT " which varies with frequency. If you want to see a table of typica";
930 PRINT "l Q values,"
940 PRINT " then ";:COLOR 0,7:PRINT " enter a frequency:":COLOR 7,0
950 PRINT
960 PRINT " Otherwise ";:COLOR 0,7:PRINT " enter 0 to continue:"
970 PRINT
980 INPUT " ENTER: Frequency of operation in MHz. or 0 to continue";FQ:COLOR 7,0
990  IF FQ=0 THEN LOCATE CSRLIN-1:GOTO 1030
1000 IF LD=0 AND Y$="es2b"THEN CLS:GOTO 1030
1010 IF LD THEN 1130
1020 CLS:GOSUB 4830:LN=4:GOSUB 1090:GOSUB 3960  :REM'L/D ratio chart
1030 COLOR 0,7
1040 INPUT " To compute coil diameter, ENTER: ANY desired L/d ratio....";LD
1050 LDIN=LD  :REM'originating L/d ratio
1060 COLOR 7,0:IF LD=0 THEN BEEP:LN=CSRLIN-1:GOSUB 1090:GOTO 860
1070 GOTO 1130
1080 :REM'
1090 :REM'.....erase screen to bottom
1100 VIEW PRINT LN TO 23:CLS:VIEW PRINT:LOCATE LN
1110 RETURN
1120 :REM'
1130 :REM'.....start
1140 COLOR 7,0:CLS
1150 IF FLAG THEN 1250
1160 :REM'
1170 :REM'.....input inductance
1180 COLOR 0,7:PRINT " DESIGN SPECIFICATIONS for a";
1190 PRINT USING "##.###:1 length-to-diameter ratio coil:";LD
1200 COLOR 7,0
1210 IF UH THEN COLOR 7,0:GOTO 1250
1220 COLOR 7,0:INPUT " ENTER: Inductance (µH)......................";UH
1230 LN=CSRLIN-1:GOSUB 1090
1240 IF UH=0 THEN BEEP:GOTO 1220
1250 PRINT "        Inductance...........................";USING U1$;UH;
1260 PRINT " µH"
1270 LN=CSRLIN
1280 IF FLAG THEN DIA=W:GOTO 1830
1290 IF WHIP=0 THEN 1360
1300 PRINT UL$;
1310 PRINT TAB(7);
1320 PRINT "FOR MOBILE WHIP LOADING COILS USE THE LARGEST PRACTICABLE DIAMETER"
1330 PRINT TAB(7);
1340 PRINT "WIRE OR TUBING CONDUCTOR."
1350 :REM'
1360 :REM'.....input conductor size
1370 IF PROG$="coilequa"THEN DIA=WW:GOTO 1830
1380 IF PROG$="es2b"THEN DIA=W:GOTO 1830
1390 IF PROG$="shortant"THEN 1830
1400 PRINT UL$;
1410 IF MIN*MAX=0 THEN 1670
1420 MN=MIN*UM:MX=MAX*UM
1430 PRINT " Coil will be designed with turn spacing equal to twice the ";
1440 PRINT "conductor diameter "
1450 PRINT " to facilitate using scrap lengths of the windings wire as winding";
1460 PRINT " spacers."
1470 LOCATE CSRLIN,9
1480 PRINT USING "less than ##.### or more than ##.###";MN,MX;
1490 PRINT UM$;" will produce Q values";
1500 PRINT " and coil diameters beyond the range of your specifications."
1510 COLOR 0,7
1520 PRINT " Select a conductor diameter within the range of ";
1530 PRINT USING "##.### and ##.###";MN,MX;:PRINT UM$;" ":COLOR 7,0
1540 PRINT USING "  Conductors ##.###";MN;
1550 PRINT UM$;" dia. will produce a Q lower than the desired value."
1560 PRINT USING "  Conductors ##.###";(MN+MX)/2;
1570 PRINT UM$;" dia. will produce a Q near the desired value."
1580 PRINT USING "  Conductors ##.###";MX;
1590 PRINT UM$;" dia. will produce a Q higher than the desired value."
1600 PRINT
1610 :REM'
1620 FOR Z=40 TO 1 STEP -1
1630 IF GA(Z)<MIN OR GA(Z)>MAX THEN 1650
1640 PRINT USING "  AWG ## = #.### in. (##.## mm) diameter";Z,GA(Z),GA(Z)*25.399999618530273!
1650 NEXT Z
1660 COLOR 0,7
1670 PRINT " Press letter in < > to enter your choice of coil conductor size:"
1680 COLOR 7,0
1690 PRINT "   < a >  Diameter in millimetres"
1700 PRINT "   < b >  Diameter in inches"
1710 PRINT "   < c >  AWG#"
1720 Z$=INKEY$
1730 IF Z$="a"OR Z$="A"THEN WS$="mm":GOTO 1770
1740 IF Z$="b"OR Z$="B"THEN WS$="inches":GOTO 1770
1750 IF Z$="c"OR Z$="C"THEN WS$="AWG#":GOTO 1770
1760 GOTO 1720
1770 PRINT " ENTER: Conductor diameter (";WS$;")";:INPUT Z
1780 IF WS$="mm"THEN DIA=Z/25.399999618530273!
1790 IF WS$="inches"THEN DIA=Z
1800 IF WS$="AWG#"THEN AWG=Z:DIA=GA(Z)
1810 GOSUB 1090
1820 :REM'
1830 PRINT "        Conductor diameter...................";USING U1$;DIA*UM;
1840 PRINT UM$
1850 LN=CSRLIN
1860 IF FLAG THEN DIA=W:W$="1":WIR$="bare":GOTO 2030
1870 IF Y$="es2b"THEN 1890
1880 IF FQ THEN W$="1":GOTO 1980
1890 PRINT UL$;
1900 PRINT " Press number in <> to select conductor type:"
1910 PRINT UL$;
1920 PRINT "  < 1 > Bare"
1930 PRINT "  < 2 > Enamelled"
1940 PRINT "  < 3 > Insulated ":COLOR 12,0:LOCATE ,9
1950 PRINT "INSULATION MAY INTRODUCE DIELECTRIC LOSSES, AFFECTING COIL Q!"
1960 COLOR 7,0
1970 W$=INKEY$
1980 IF W$="1" THEN WIR$="bare":SP=2*DIA:GOTO 2030
1990 IF W$="2" THEN WIR$="enamelled":SP=DIA*1.350000023841858!:GOTO 2030
2000 IF W$="3" THEN WIR$="insulated":GOTO 2030
2010 GOTO 1970
2020 :REM'
2030 :REM'.....turns per inch
2040 LOCATE 3,60:PRINT WIR$;
2050 K#=(0.46000000834465027!/0.004999999888241291!)^(1/39)
2060 AWG=LOG(0.46000000834465027!/DIA)/(LOG(K#))-3
2070 PRINT USING " (AWG###.#)";AWG
2080 IF FLAG THEN 2190
2090 IF W$="1"OR W$="2"THEN 2200
2100 GOSUB 1090
2110 PRINT UL$;
2120 TB=9
2130 PRINT TAB(TB);
2140 PRINT "Wrap some of the #";AWG;WIR$;" wire around a ruler to determine"
2150 PRINT TAB(TB);
2160 PRINT "the maximum number of turns that can be wound in 25mm (1 inch)."
2170 PRINT UL$;
2180 INPUT " ENTER: How many turns can be wound in 25mm (1 inch)";TPI
2190 SP=1/TPI
2200 GOSUB 1090
2210 :REM'
2220 :REM'.....calculate coil length and form diameter by iteration
2230 CD=10:XD=10                  :REM'default coil diameter
2240 L=LD*CD                      :REM'length=L/D ratio x diameter
2250 N=(SQR(UH*(18*CD+40*L)))/CD  :REM'number of turns
2260 IF ABS(N*SP-L)<9.999999747378752e-05! THEN 2290
2270 IF SGN(N*SP-L)<>SGN(XD)THEN XD=-XD/10
2280 CD=CD+XD:GOTO 2240
2290 T=1/SP                       :REM'turns per inch
2300 IF W$="1" THEN X=DIA         :REM'X=O.D.of wire c/w insulation, if any
2310 IF W$="2"OR W$="3"THEN X=SP
2320 CF=CD-X                      :REM'coil form diameter
2330 :REM'
2340 LN=CSRLIN-1:GOSUB 1090
2350 PRINT "        Coil diameter........................";USING U1$;(CF+X)*UM;
2360 PRINT UM$
2370 IF QQ THEN R=(CF+X)/2:LN=CSRLIN-1:GOSUB 3810:LOCATE LN
2380 PRINT "        Outside diameter of coil form.....";
2390 COLOR 14,4:PRINT " D=";:COLOR 7,0:PRINT USING U1$;CF*UM;
2400 PRINT UM$
2410 COLOR 14,4:LOCATE CSRLIN-1,58:PRINT " * ";:COLOR 7,0
2420 PRINT "        Number of turns......................";USING U1$;N;
2430 PRINT "        Length of coil.......................";USING U1$;L*UM;
2440 PRINT UM$
2450 PRINT "        Number of turns per 25 mm (inch).....";USING U1$;T
2460 PRINT "        Length-to-Diameter ratio.............";USING U1$;L/CD;
2470 PRINT ":1"
2480 :REM'
2490 IF FLAG THEN 3430
2500 LOCATE CSRLIN,9
2510 COLOR 14,4:PRINT " * ";
2520 COLOR 0,7
2530 PRINT " Coil form diameter can be any size near";
2540 COLOR 14,4:PRINT " D ";
2550 COLOR 0,7:PRINT " ":COLOR 7,0
2560 PRINT UL$;
2570 LOCATE CSRLIN-1,18
2580 PRINT " SOME SUGGESTED SOURCES OF COIL FORM MATERIAL "
2590 PRINT " PVC pipe outside diameters:";
2600 PRINT TAB(39)"Shotgun shell diameters:"
2610 LN=CSRLIN
2620 DATA 3/8,1/2,3/4," 1 "," 1¼"," 1½"," 2 "," 2½"," 3 "," 3½"," 4 "
2630 DATA .675, .84, 1.05, 1.315, 1.66, 1.9, 2.375, 2.875, 3.5, 4, 4.5
2640 FOR Y=1 TO 11:READ P$(Y,1):NEXT Y
2650 FOR Y=1 TO 11:READ P$(Y,2):NEXT Y
2660 FOR Y=1 TO 10
2670 PRINT "   nom. ";P$(Y,1);" =";USING "##.###";VAL(P$(Y,2));
2680 PRINT " in. (";USING "###.#";VAL(P$(Y,2))*25.399999618530273!;:PRINT " mm)";
2690 IF Y<10 THEN PRINT ""
2700 NEXT Y
2710 LOCATE LN
2720 :REM'
2730 DATA ".410  ", .41, 28-Ga., .55, 20-Ga., .615, 16-Ga., .662
2740 DATA 12-Ga., .729, 10-Ga., .775,"","","","","",""
2750 FOR Y=1 TO 6:READ G$(Y,1),G$(Y,2)
2760 LOCATE ,42:PRINT G$(Y,1);USING "#####.###";VAL(G$(Y,2));
2770 PRINT " in. (";USING "###.#";VAL(G$(Y,2))*25.399999618530273!;:PRINT " mm)"
2780 NEXT Y
2790 RESTORE
2800 :REM'
2810 LOCATE 20,39
2820 PRINT "KODAK 35mm film plastic canister:"
2830 LOCATE 21,52:PRINT "1.245 in. ( 31.6mm ) dia."
2840 LOCATE 22,52:PRINT "1.750 in. ( 44.5mm ) long"
2850 LOCATE 23,39
2860 COLOR 14,4:PRINT " * ";
2870 COLOR 0,7:PRINT " ENTER: Coil form dia.(";UM$;")";
2880 COLOR 30,4:PRINT " ";:INPUT CF
2890 CF=CF/UM
2900 COLOR 7,0
2910 LOCATE 6,43:PRINT "..."     :REM'delete D=
2920 LOCATE 6,58:PRINT "   "     :REM'delete asterisk
2930 LN=11
2940 GOSUB 1090
2950 PRINT
2960 :REM'
2970 :REM'.....re-calculate
2980 CD=CF+X                         :REM'coil diameter
2990 R=CD/2                          :REM'coil radius
3000 Q=R^2*T^2/UH                    :REM'factor
3010 L=ABS(-10-SQR(100+36*R*Q))/2/Q  :REM'length of winding
3020 N=(SQR(UH*(18*CD+40*L)))/CD     :REM'number of turns
3030 IF FLAG THEN CLS:GOTO 3100
3040 COLOR 0,7
3050 PRINT " DESIGN for a";STR$(CF*UM);UM$;" diameter Coil Form:"
3060 COLOR 7,0
3070 GOSUB 3100
3080 GOTO 3390
3090 :REM'
3100 :REM'.....screen print
3110 PRINT "        Inductance...........................";USING U1$;UH;
3120 PRINT " µH"
3130 PRINT "        Conductor diameter...................";USING U1$;DIA*UM;
3140 PRINT UM$;", ";WIR$;
3150 IF AWG THEN PRINT " (AWG";USING "###.#";AWG;:PRINT ")" :ELSE PRINT ""
3160 PRINT "        Approximate spacing of coil turns....";USING U1$;SP*UM;
3170 PRINT UM$
3180 PRINT "        Coil diameter........................";USING U1$;(CF+X)*UM;
3190 PRINT UM$
3200 PRINT "        Outside diameter of coil form........";USING U1$;CF*UM;
3210 PRINT UM$
3220 PRINT "        Number of turns......................";USING U1$;N;
3230 PRINT "        Length of coil.......................";USING U1$;L*UM;
3240 PRINT UM$
3250 PRINT "        Number of turns per 25 mm (inch).....";USING U1$;T
3260 LD=L/CD
3270 PRINT USING "        Length-to-Diameter ratio............. ###.##:1";LD
3280 :REM'
3290 IF FLAG THEN GOSUB 4970:CHAIN"coiltrue"
3300 IF LD>=0.4000000059604645! THEN PRINT "":GOTO 3320
3310 BEEP:COLOR 30,4:PRINT "«─ TOO LOW! "
3320 LW=(CD*PI*N)      :REM'length in inches
3330 IF UM=25.399999618530273! THEN UU=0.02539999969303608!:UU$=" m.":ELSE UU=1:UU$=UM$
3340 COLOR 7,0
3350 PRINT "        Approx.length of conductor required..";USING U1$;LW*UU;
3360 PRINT UU$
3370 COLOR 7,0:RETURN
3380 :REM'
3390 :REM'.....end table of results
3400 GOSUB 3810
3410 IF N=INT(N)THEN Z$="n":GOTO 3470
3420 :REM'
3430 LN=23:GOSUB 1090:LOCATE 23:COLOR 0,7
3440 PRINT " Do you want to round-off the number of turns?  (y/n) ";
3450 COLOR 30,4:PRINT "«─";:COLOR 7,0
3460 Z$=INKEY$
3470 IF Z$="n"THEN LN=23:GOSUB 1090:GOTO 3610
3480 IF Z$="y"THEN 3510
3490 GOTO 3460
3500 :REM'
3510 :REM'.....recalculate length
3520 LN=23:GOSUB 1090
3530 COLOR 0,7
3540 :REM'
3550 N=CINT(N):NN=N
3560 COLOR 7,0
3570 L=((CD^2*N^2/UH)-(18*CD))/40:LL=L
3580 SP=L/N
3590 T=N/L
3600 IF FLAG THEN COLOR 7,0,0:CLS:GOTO 3660
3610 LN=12:GOSUB 1090:LOCATE 12
3620 COLOR 0,7
3630 PRINT " DESIGN for";N;
3640 PRINT "Turns on a";STR$(CF*UM);UM$;" diameter Coil Form:"
3650 COLOR 7,0
3660 GOSUB 3100
3670 LOCATE 23:COLOR 0,7:PRINT " Do you want to try another coil of the same ";
3680 PRINT "inductance? (y/n) ";
3690 COLOR 30,4:PRINT "«─";:COLOR 7,0
3700 GOSUB 3810
3710 Z$=INKEY$: IF Z$=""THEN 3710
3720 IF Z$="y"THEN CLS:LD=LDIN:GOTO 750
3730 IF Z$="n" AND PROG$="mowhip" THEN GOSUB 4970:CHAIN"mobilmat"
3740 IF Z$="n"AND FQ<>0 THEN 3770
3750 IF Z$="n"THEN LN=23:GOSUB 1090:GOTO 3900
3760 GOTO 3710
3770 IF Y$="es2b"THEN 3790
3780 F=FQ*10^6:UH=UH:D=CD:LL=L:NN=N:W=DIA:PROG$=Y$:CHAIN "coiltrue"
3790 LN=23:GOSUB 1090:GOSUB 4970:W=DIA:CHAIN Y$
3800 :REM'
3810 :REM'.....calculate Q
3820 IF FQ=0 THEN 3880
3830 RR=R*2.5399999618530273!:LL=L*2.5399999618530273!   :REM'dia.& radius in cm
3840 Q1=SQR(FQ*10^6)/(6.900000095367432!/RR+5.400000095367432!/LL)
3850 COLOR 15,1:LOCATE 24,8
3860 PRINT " Approximate True Q =";CINT(Q1);"at";FQ;"MHz.";
3870 IF QQ THEN PRINT " (sought Q =";CINT(QQ);")";
3880 COLOR 7,0:RETURN
3890 :REM'
3900 :REM'.....end
3910 GOSUB 4970  :REM'printout
3920 UH=0:DIA=0:FQ=0:LD=0
3930 IF EX$<>GO$ THEN QQ=0:CHAIN GO$
3940 GOTO 250    :REM'start
3950 :REM'
3960 :REM'.....L/d ratio chart
3970 CLS:GOSUB 4810:LOCATE 5
3980 COLOR 0,7
3990 PRINT " Typical L/d Ratios for Various Coil Diameters and Q Values at";
4000 COLOR 14,4:PRINT FQ;"MHz "
4010 K=50/SQR(2):D=0.25!:Z$="##.##"+CHR$(34)
4020 FOR Y=1 TO 9:Q=K*SQR(2)^Y:PRINT USING "│ Q=### ";Q;:NEXT Y:PRINT ""
4030 FOR Z=1 TO 17:D=D+0.25!
4040 PRINT USING Z$;D;    :REM'diameter
4050 FOR X=1 TO 9
4060  Q=K*SQR(2)^X
4070  R=D/2*2.5399999618530273!                    :REM'radius in cm
4080  LC=5.400000095367432!/(SQR(FQ*10^6)/Q-6.900000095367432!/R) :REM'length in cm
4090  LD=LC/(2*R)                   :REM'L/d ratio
4100  IF LD<0.3499999940395355! THEN PRINT "│∙∙∙∙∙∙∙";:GOTO 4120
4110  PRINT USING "│###.## ";LD;
4120  NEXT X:PRINT ""
4130 NEXT Z
4140 Z=9:COLOR 14,4:LOCATE 18
4150 LOCATE ,Z:PRINT " L/d values shown are approximate "
4160 LOCATE ,Z:PRINT " for a 10 uH coil wound with #14  "
4170 LOCATE ,Z:PRINT " AWG wire. Actual values will be  "
4180 LOCATE ,Z:PRINT " computed according to parameters "
4190 LOCATE ,Z:PRINT " you will be asked to enter.      "
4200 COLOR 7,0:LOCATE 24
4210 RETURN
4220 :REM'
4230 :REM'.....preface - page 1
4240 TB=8
4250 LOCATE ,TB
4260 PRINT "  This program designs single-layer air-core coils using equations"
4270 LOCATE ,TB
4280 PRINT "published in the 1997 ARRL HANDBOOK, page 6.22. These equations"
4290 LOCATE ,TB
4300 PRINT "provide close approximations of values for frequencies in the 1-30"
4310 LOCATE ,TB
4320 PRINT "MHz range that are sufficiently accurate for most Amateur Radio"
4330 LOCATE ,TB
4340 PRINT "purposes. The calculations are useful in the VHF and UHF range but"
4350 LOCATE ,TB
4360 PRINT "only as a basis for further calculation and experimentation. The"
4370 LOCATE ,TB
4380 PRINT "program designs coils with pitches (c.c. distance between turns)"
4390 LOCATE ,TB
4400 PRINT "as follows:"
4410 COLOR 0,7
4420 LOCATE ,TB
4430 PRINT " - BARE CONDUCTOR (wire or tubing) @ twice its diameter.     "
4440 LOCATE ,TB
4450 PRINT "     (use scraps of the same size conductor as turn spacers)."
4460 LOCATE ,TB
4470 PRINT " - ENAMELLED WIRE @ outside diameter of the enamel.          "
4480 LOCATE ,TB:
4490 PRINT " - INSULATED WIRE @ outside diameter of the insulation.      "
4500 LOCATE ,TB:COLOR 12,0
4510 PRINT "WIRE INSULATION MAY INTRODUCE DIELECTRIC LOSSES, AFFECTING COIL Q!"
4520 COLOR 7,0
4530 PRINT
4540 LOCATE ,TB
4550 PRINT "  The accuracy of equations used in this program may decrease if"
4560 LOCATE ,TB
4570 PRINT "the recommended turn spacing is greatly increased. In every case"
4580 LOCATE ,TB
4590 PRINT "spread the windings evenly over the winding length and secure in"
4600 LOCATE ,TB
4610 PRINT "place with shellac or other suitable coating."
4620 IF LD THEN 4710
4630 IF Y$="es2b"THEN 4710
4640 LOCATE ,TB
4650 PRINT "  If coil Q is critical to your application, exit this program now"
4660 LOCATE ,TB
4670 PRINT "and run the ";CHR$(34);"Coil Q Calculator";CHR$(34);" program. ";
4680 PRINT "Then run this program"
4690 LOCATE ,TB
4700 PRINT "again from the Coil Q Calculator program menu."
4710 RETURN
4720 :REM'
4730 :REM'preface - page 2
4740 PRINT " The Length-to-diameter (L/d) ratio of a coil can affect its Q. A ";
4750 PRINT "high Q       "
4760 PRINT " ensures improved circuit efficiency, a narrower bandwidth, and le";
4770 PRINT "ss bandwidth "
4780 PRINT " noise. Primary design considerations are:"
4790 RETURN
4800 :REM'
4810 PRINT " Q refers to True Q, as opposed to Apparent Q read by a Q meter."
4820 PRINT " - Q increases with coil diameter. Q increases with coil length."
4830 PRINT " - Max.Q occurs at about .35-.45 L/d ratio, decreasing rapidly be";
4840 PRINT "low this range.";
4850 PRINT " - 0.5 to 2.0 L/d ratios are commonly used in many Amateur radio ";
4860 PRINT "applications."
4870 PRINT " - The conductor diameter should be as large as practicable."
4880 PRINT " - The turn spacing should be about twice the conductor diameter."
4890 PRINT " - The coil form should have a low dielectric constant.";
4900 PRINT " Air is best."
4910 PRINT " - Coils with L/d ratios less than 0.4:1 may be designed using W";
4920 PRINT "heeler's"
4930 PRINT "    1982 equation in the COIL EQUATION CALCULATOR program."
4940 PRINT " - Q can be calculated using the COIL Q CALCULATOR program."
4950 RETURN
4960 :REM'
4970 :REM'PRT
4980 KEY OFF:GOSUB 5050:LOCATE 25,5:COLOR 0,2
4990 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
5000 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
5010 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 5010 :ELSE GOSUB 5050
5020 IF Z$="3"THEN RETURN
5030 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
5040 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 4980
5050 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
