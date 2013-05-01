10 :REM'COILDSGN - Coil Design - 22 NOV 94 rev. 15 DEC 2005
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$:PROG$="coildsgn"::ELSE GO$=PROG$
50 Y$=PROG$
60 COMMON EX$,PROG$,LD,LX,QQ,I,I$,F,FQ,UH,D,L,NN,W,DIA
70 COMMON A,A1,B1,B,XT,C1,L1,L2,FH,FL,AMAX,FLAG,TPI
80 IF UH THEN UH=INT(UH*10^3+0.5!)/10^3
90 COLOR 7,0,1
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
310 IF PROG$="coildsgn"THEN 340
320 IF PROG$="shortant"THEN 620
330 IF LD THEN LDIN=LD:GOTO 430  :REM'LDIN = originating L/d ratio
340 GOSUB 4040     :REM'preface - page 1
350 COLOR 0,7:LOCATE 25,24
360 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
370 IF GO$=PROG$ THEN GO$=EX$
380 IF Y$="es2b"THEN GO$=Y$
390 Z$=INKEY$:IF Z$=""THEN 390
400 IF Z$="0"THEN QQ=0:CLS:CHAIN GO$
410 IF Z$="1"THEN 620
420 GOTO 390
430 IF QQ=0 THEN 620
440 PRINT " You are seeking a";UH;"µH coil"
450 PRINT USING " with a Length/diameter ratio of ##.###:1";LD
460 PRINT USING " operating at ###.### MHz";FQ
470 PRINT
480 IF FLAG THEN 590
490 PRINT " In the following design steps you will have the options of selec";
500 PRINT "ting standard "
510 PRINT " conductor and coil form sizes nearest to the design values shown";
520 PRINT ", and to round"
530 PRINT " off the number of turns. Each of these changes may alter the L/d";
540 PRINT " ratio which  "
550 PRINT " will change the Q accordingly. If the deviations from the design";
560 PRINT " values are   "
570 PRINT " slight the change in Q will not be significant.                 "
580 PRINT
590 PRINT " Press any key to continue . . . . "
600 IF INKEY$=""THEN 600
610 :REM'
620 LN=3:GOSUB 1000 :REM'clear screen
630 IF I THEN 640 :ELSE 660
640 IF I$=" in."THEN UM=1:UM$=I$ :ELSE UM=25.399999618530273!:UM$=" mm"
650 GOTO 750
660 PRINT " Press number in < > to choose standard units of measure:"
670 PRINT UL$;
680 PRINT "  < 1 >  Metric"
690 PRINT "  < 2 >  U.S.A./Imperial"
700 Z$=INKEY$
710 IF Z$="1"THEN UM=25.399999618530273!:UM$=" mm":GOTO 750
720 IF Z$="2"THEN UM=1:UM$=" in.":GOTO 750
730 GOTO 700
740 :REM'
750 IF FLAG THEN CLS:GOTO 1040
760 CLS:GOSUB 4540:PRINT :GOSUB 4620        :REM'preface - page 2
770 PRINT
780 IF LD=0 AND Y$="es2b"THEN CLS:GOTO 940
790 IF FQ THEN 920
800 IF LD THEN 1040
810 PRINT " The frequency of operation does not affect the design of a coil, ";
820 PRINT "only its Q,"
830 PRINT " which varies with frequency. If you want to see a table of typica";
840 PRINT "l Q values,"
850 PRINT " then ";:COLOR 0,7:PRINT " enter a frequency:":COLOR 7,0
860 PRINT
870 PRINT " Otherwise ";:COLOR 0,7:PRINT " enter 0 to continue:"
880 PRINT
890 INPUT " ENTER: Frequency of operation in MHz. or 0 to continue";FQ:COLOR 7,0
900  IF FQ=0 THEN LOCATE CSRLIN-1:GOTO 940
910 IF LD=0 AND Y$="es2b"THEN CLS:GOTO 940
920 IF LD THEN 1040
930 CLS:GOSUB 4640:LN=4:GOSUB 1000:GOSUB 3760  :REM'L/D ratio chart
940 COLOR 0,7
950 INPUT " To compute coil diameter, ENTER: ANY desired L/d ratio....";LD
960 LDIN=LD  :REM'originating L/d ratio
970 COLOR 7,0:IF LD=0 THEN BEEP:LN=CSRLIN-1:GOSUB 1000:GOTO 770
980 GOTO 1040
990 :REM'
1000 :REM'.....erase screen to bottom
1010 VIEW PRINT LN TO 23:CLS:VIEW PRINT:LOCATE LN
1020 RETURN
1030 :REM'
1040 :REM'.....start
1050 COLOR 7,0:CLS
1060 IF FLAG THEN 1150
1070 :REM'.....input inductance
1080 COLOR 0,7:PRINT " DESIGN SPECIFICATIONS for a";
1090 PRINT USING "##.###:1 length-to-diameter ratio coil:";LD
1100 COLOR 7,0
1110 IF UH THEN COLOR 7,0:GOTO 1150
1120 COLOR 7,0:INPUT " ENTER: Inductance (µH)......................";UH
1130 LN=CSRLIN-1:GOSUB 1000
1140 IF UH=0 THEN BEEP:GOTO 1120
1150 PRINT "        Inductance...........................";USING U1$;UH;
1160 PRINT " µH"
1170 LN=CSRLIN
1180 IF FLAG THEN DIA=W:GOTO 1710
1190 IF WHIP=0 THEN 1250
1200 PRINT UL$;
1210 PRINT TAB(7);
1220 PRINT "FOR MOBILE WHIP LOADING COILS USE THE LARGEST PRACTICABLE DIAMETER"
1230 PRINT TAB(7);
1240 PRINT "WIRE OR TUBING CONDUCTOR."
1250 :REM'.....input conductor size
1260 IF PROG$="coilequa"THEN DIA=WW:GOTO 1710
1270 IF PROG$="es2b"THEN DIA=W:GOTO 1710
1280 IF PROG$="shortant"THEN 1710
1290 PRINT UL$;
1300 IF MIN*MAX=0 THEN 1550
1310 MN=MIN*UM:MX=MAX*UM
1320 PRINT " Coil will be designed with turn spacing equal to twice the ";
1330 PRINT "conductor diameter "
1340 PRINT " to facilitate using scrap lengths of the windings wire as winding";
1350 PRINT " spacers."
1360 PRINT " Conductor sizes ";
1370 PRINT USING "less than ##.### or more than ##.###";MN,MX;
1380 PRINT UM$;" will produce Q values";
1390 PRINT " and coil diameters beyond the range of your specifications."
1400 COLOR 0,7
1410 PRINT " Select a conductor diameter within the range of ";
1420 PRINT USING "##.### and ##.###";MN,MX;:PRINT UM$;" ":COLOR 7,0
1430 PRINT USING "  Conductors ##.###";MN;
1440 PRINT UM$;" dia. will produce a Q lower than the desired value."
1450 PRINT USING "  Conductors ##.###";(MN+MX)/2;
1460 PRINT UM$;" dia. will produce a Q near the desired value."
1470 PRINT USING "  Conductors ##.###";MX;
1480 PRINT UM$;" dia. will produce a Q higher than the desired value."
1490 PRINT
1500 FOR Z=40 TO 1 STEP -1
1510 IF GA(Z)<MIN OR GA(Z)>MAX THEN 1530
1520 PRINT USING "  AWG ## = #.### in. (##.## mm) diameter";Z,GA(Z),GA(Z)*25.399999618530273!
1530 NEXT Z
1540 COLOR 0,7
1550 PRINT " Press letter in < > to enter your choice of coil conductor size:"
1560 COLOR 7,0
1570 PRINT "   < a >  Diameter in millimetres"
1580 PRINT "   < b >  Diameter in inches"
1590 PRINT "   < c >  AWG#"
1600 Z$=INKEY$
1610 IF Z$="a"OR Z$="A"THEN WS$="mm":GOTO 1650
1620 IF Z$="b"OR Z$="B"THEN WS$="inches":GOTO 1650
1630 IF Z$="c"OR Z$="C"THEN WS$="AWG#":GOTO 1650
1640 GOTO 1600
1650 PRINT " ENTER: Conductor diameter (";WS$;")";:INPUT Z
1660 IF WS$="mm"THEN DIA=Z/25.399999618530273!
1670 IF WS$="inches"THEN DIA=Z
1680 IF WS$="AWG#"THEN AWG=Z:DIA=GA(Z)
1690 GOSUB 1000
1700 :REM'
1710 PRINT "        Conductor diameter...................";USING U1$;DIA*UM;
1720 PRINT UM$;", "
1730 LN=CSRLIN
1740 IF FLAG THEN DIA=W:W$="1":WIR$="bare":GOTO 1900
1750 IF Y$="es2b"THEN 1770
1760 IF FQ THEN W$="1":GOTO 1860
1770 PRINT UL$;
1780 PRINT " Press number in <> to select conductor type:"
1790 PRINT UL$;
1800 PRINT "  < 1 > Bare"
1810 PRINT "  < 2 > Enamelled"
1820 PRINT "  < 3 > Insulated ":COLOR 12,0:LOCATE ,9
1830 PRINT "INSULATION MAY INTRODUCE DIELECTRIC LOSSES, AFFECTING COIL Q!"
1840 COLOR 7,0
1850 W$=INKEY$
1860 IF W$="1" THEN WIR$="bare":SP=2*DIA:GOTO 1900
1870 IF W$="2" THEN WIR$="enamelled":SP=DIA*1.350000023841858!:GOTO 1900
1880 IF W$="3" THEN WIR$="insulated":GOTO 1900
1890 GOTO 1850
1900 :REM'.....turns per inch
1910 LOCATE 3,60:PRINT WIR$;
1920 K#=(0.46000000834465027!/0.004999999888241291!)^(1/39)
1930 AWG=LOG(0.46000000834465027!/DIA)/(LOG(K#))-3
1940 PRINT USING " (AWG###.#)";AWG
1950 IF FLAG THEN 2060
1960 IF W$="1"OR W$="2"THEN 2070
1970 GOSUB 1000
1980 PRINT UL$;
1990 TB=9
2000 PRINT TAB(TB);
2010 PRINT "Wrap some of the #";AWG;WIR$;" wire around a ruler to determine"
2020 PRINT TAB(TB);
2030 PRINT "the maximum number of turns that can be wound in 25mm (1 inch)."
2040 PRINT UL$;
2050 INPUT " ENTER: How many turns can be wound in 25mm (1 inch)";TPI
2060 SP=1/TPI
2070 GOSUB 1000
2100 :REM'.....calculate coil length and form diameter by iteration
2110 CD=10:XD=10                  :REM'default coil diameter
2120 L=LD*CD                      :REM'length=L/D ratio x diameter
2130 N=(SQR(UH*(18*CD+40*L)))/CD  :REM'number of turns
2140 IF ABS(N*SP-L)<9.999999747378752e-05! THEN 2170
2150 IF SGN(N*SP-L)<>SGN(XD)THEN XD=-XD/10
2160 CD=CD+XD:GOTO 2120
2170 T=1/SP                       :REM'turns per inch
2180 IF W$="1" THEN X=DIA         :REM'X=O.D.of wire c/w insulation, if any
2190 IF W$="2"OR W$="3"THEN X=SP
2200 CF=CD-X                      :REM'coil form diameter
2210 :REM'
2220 LN=CSRLIN-1:GOSUB 1000
2230 PRINT "        Coil diameter........................";USING U1$;(CF+X)*UM;
2240 PRINT UM$
2250 IF QQ THEN R=(CF+X)/2:LN=CSRLIN-1:GOSUB 3610:LOCATE LN
2260 PRINT "        Outside diameter of coil form.....";
2270 COLOR 14,4:PRINT " D=";:COLOR 7,0:PRINT USING U1$;CF*UM;
2280 PRINT UM$
2290 COLOR 14,4:LOCATE CSRLIN-1,58:PRINT " * ";:COLOR 7,0
2300 PRINT "        Number of turns......................";USING U1$;N;
2310 PRINT "        Length of coil.......................";USING U1$;L*UM;
2320 PRINT UM$
2330 PRINT "        Number of turns per 25 mm (inch).....";USING U2$;T
2340 PRINT "        Length-to-Diameter ratio.............";USING U1$;L/CD;
2350 PRINT ":1"
2360 LOCATE CSRLIN,9
2370 COLOR 14,4:PRINT " * ";
2380 COLOR 0,7
2390 PRINT " Coil form diameter can be any size near";
2400 COLOR 14,4:PRINT " D ";
2410 COLOR 0,7:PRINT " ":COLOR 7,0
2420 PRINT UL$;
2430 LOCATE CSRLIN-1,18
2440 PRINT " SOME SUGGESTED SOURCES OF COIL FORM MATERIAL "
2450 PRINT " PVC pipe outside diameters:";
2460 PRINT TAB(39)"Shotgun shell diameters:"
2470 LN=CSRLIN
2480 DATA 3/8,1/2,3/4," 1 "," 1¼"," 1½"," 2 "," 2½"," 3 "," 3½"," 4 "
2490 DATA .675, .84, 1.05, 1.315, 1.66, 1.9, 2.375, 2.875, 3.5, 4, 4.5
2500 FOR Y=1 TO 11:READ P$(Y,1):NEXT Y
2510 FOR Y=1 TO 11:READ P$(Y,2):NEXT Y
2520 FOR Y=1 TO 10
2530 PRINT "   nom. ";P$(Y,1);" =";USING "##.###";VAL(P$(Y,2));
2540 PRINT " in. (";USING "###.#";VAL(P$(Y,2))*25.399999618530273!;:PRINT " mm)";
2550 IF Y<10 THEN PRINT ""
2560 NEXT Y
2570 LOCATE LN
2580 :REM'
2590 DATA ".410  ", .41, 28-Ga., .55, 20-Ga., .615, 16-Ga., .662
2600 DATA 12-Ga., .729, 10-Ga., .775,"","","","","",""
2610 FOR Y=1 TO 6:READ G$(Y,1),G$(Y,2)
2620 LOCATE ,42:PRINT G$(Y,1);USING "#####.###";VAL(G$(Y,2));
2630 PRINT " in. (";USING "###.#";VAL(G$(Y,2))*25.399999618530273!;:PRINT " mm)"
2640 NEXT Y
2650 RESTORE
2660 LOCATE 20,39
2670 PRINT "KODAK 35mm film plastic canister:"
2680 LOCATE 21,52:PRINT "1.245 in. ( 31.6mm ) dia."
2690 LOCATE 22,52:PRINT "1.750 in. ( 44.5mm ) long"
2700 LOCATE 23,39
2710 COLOR 14,4:PRINT " * ";
2720 COLOR 0,7:PRINT " ENTER: Coil form dia.(";UM$;")";
2730 COLOR 30,4:PRINT " ";:INPUT CF
2740 CF=CF/UM
2750 COLOR 7,0
2760 LOCATE 6,43:PRINT "..."     :REM'delete D=
2770 LOCATE 6,58:PRINT "   "     :REM'delete asterisk
2780 LN=11
2790 GOSUB 1000
2800 PRINT
2810 :REM'
2820 :REM'.....re-calculate
2830 CD=CF+X                         :REM'coil diameter
2840 R=CD/2                          :REM'coil radius
2850 Q=R^2*T^2/UH                    :REM'factor
2860 L=ABS(-10-SQR(100+36*R*Q))/2/Q  :REM'length of winding
2870 N=(SQR(UH*(18*CD+40*L)))/CD     :REM'number of turns
2880 T=N/L                           :REM'turns per inch
2890 COLOR 0,7
2900 PRINT " ALTERNATE DESIGN for a";STR$(CF*UM);UM$;" diameter Coil Form:"
2910 COLOR 7,0
2920 GOSUB 2950
2930 GOTO 3230
2940 :REM'
2950 :REM'.....screen print
2960 PRINT "        Inductance...........................";USING U1$;UH;
2970 PRINT " µH"
2980 PRINT "        Conductor diameter...................";USING U1$;DIA*UM;
2990 PRINT UM$;", ";WIR$;
3000 IF AWG THEN PRINT " (AWG";USING "###.#";AWG;:PRINT ")" :ELSE PRINT ""
3010 PRINT "        Approximate spacing of coil turns....";USING U1$;SP*UM;
3020 PRINT UM$
3030 PRINT "        Coil diameter........................";USING U1$;(CF+X)*UM;
3040 PRINT UM$
3050 PRINT "        Outside diameter of coil form........";USING U1$;CF*UM;
3060 PRINT UM$
3070 PRINT "        Number of turns......................";USING U1$;N;
3080 PRINT "        Length of coil.......................";USING U1$;L*UM;
3090 PRINT UM$
3100 PRINT "        Number of turns per 25 mm (inch).....";USING U2$;T
3110 LD=L/CD
3120 PRINT "        Length-to-Diameter ratio.............";
3130 COLOR 14,4:PRINT USING U1$;LD;:PRINT ":1 ";
3140 IF LD>=0.4000000059604645! THEN PRINT "":GOTO 3160
3150 BEEP:COLOR 30,4:PRINT "«─ TOO LOW! "
3160 LW=(CD*PI*N)      :REM'length in inches
3170 IF UM=25.399999618530273! THEN UU=0.02539999969303608!:UU$=" m.":ELSE UU=1:UU$=UM$
3180 COLOR 7,0
3190 PRINT "        Approx.length of conductor required..";USING U1$;LW*UU;
3200 PRINT UU$
3210 COLOR 7,0:RETURN
3220 :REM'
3230 :REM'.....end table of results
3240 GOSUB 3610
3250 IF N=INT(N)THEN Z$="n":GOTO 3300
3260 LN=23:GOSUB 1000:LOCATE 23:COLOR 0,7
3270 PRINT " Do you want to round-off the number of turns?  (y/n) ";
3280 COLOR 30,4:PRINT "«─";:COLOR 7,0
3290 Z$=INKEY$
3300 IF Z$="n"THEN LN=23:GOSUB 1000:GOTO 3420
3310 IF Z$="y"THEN 3340
3320 GOTO 3290
3330 :REM'
3340 :REM'.....recalculate length
3350 LN=23:GOSUB 1000
3360 COLOR 0,7
3370 N=CINT(N)
3380 COLOR 7,0
3390 L=((CD^2*N^2/UH)-(18*CD))/40
3400 SP=L/N
3410 T=N/L
3420 LN=12:GOSUB 1000:LOCATE 12
3430 COLOR 0,7
3440 PRINT " ALTERNATE DESIGN for";N;
3450 PRINT "Turns on a";STR$(CF*UM);UM$;" diameter Coil Form:"
3460 COLOR 7,0
3470 GOSUB 2950
3480 LOCATE 23:COLOR 0,7:PRINT " Do you want to try another coil of the same ";
3490 PRINT "inductance? (y/n) ";
3500 COLOR 30,4:PRINT "«─";:COLOR 7,0
3510 GOSUB 3610
3520 Z$=INKEY$: IF Z$=""THEN 3520
3530 IF Z$="y"THEN CLS:LD=LDIN:GOTO 660
3540 IF Z$="n"AND FQ<>0 THEN 3570
3550 IF Z$="n"THEN LN=23:GOSUB 1000:GOTO 3700
3560 GOTO 3520
3570 IF Y$="es2b"THEN 3590
3580 F=FQ*10^6:UH=UH:D=CD:L=L:NN=N:W=DIA:PROG$=Y$:CHAIN "coiltrue"
3590 LN=23:GOSUB 1000:GOSUB 4780:W=DIA:CHAIN Y$
3600 :REM'
3610 :REM'.....calculate Q
3620 IF FQ=0 THEN 3680
3630 RR=R*2.5399999618530273!:LL=L*2.5399999618530273!   :REM'dia.& radius in cm
3640 Q1=SQR(FQ*10^6)/(6.900000095367432!/RR+5.400000095367432!/LL)
3650 COLOR 15,1:LOCATE 24,8
3660 PRINT " Approximate True Q =";CINT(Q1);"at";FQ;"MHz.";
3670 IF QQ THEN PRINT " (sought Q =";CINT(QQ);")";
3680 COLOR 7,0:RETURN
3690 :REM'
3700 :REM'.....end
3710 GOSUB 4780  :REM'printout
3720 UH=0:DIA=0:FQ=0:LD=0
3730 IF EX$<>GO$ THEN QQ=0:CHAIN GO$
3740 GOTO 250    :REM'start
3750 :REM'
3760 :REM'.....L/d ratio chart
3770 CLS:GOSUB 4620:LOCATE 5
3780 COLOR 0,7
3790 PRINT " Typical L/d Ratios for Various Coil Diameters and Q Values at";
3800 COLOR 14,4:PRINT FQ;"MHz "
3810 COLOR 7,0:PRINT "  Dia.";
3820 K=50/SQR(2):D=0.25!:Z$="##.##"+CHR$(34)
3830 FOR Y=1 TO 9:Q=K*SQR(2)^Y:PRINT USING "│ Q=### ";Q;:NEXT Y:PRINT ""
3840 FOR Z=1 TO 17:D=D+0.25!
3850 PRINT USING Z$;D;    :REM'diameter
3860 FOR X=1 TO 9
3870  Q=K*SQR(2)^X
3880  R=D/2*2.5399999618530273!                    :REM'radius in cm
3890  LC=5.400000095367432!/(SQR(FQ*10^6)/Q-6.900000095367432!/R) :REM'length in cm
3900  LD=LC/(2*R)                   :REM'L/d ratio
3910  IF LD<0.3499999940395355! THEN PRINT "│∙∙∙∙∙∙∙";:GOTO 3930
3920  PRINT USING "│###.## ";LD;
3930  NEXT X:PRINT ""
3940 NEXT Z
3950 Z=9:COLOR 14,4:LOCATE 18
3960 LOCATE ,Z:PRINT " L/d values shown are approximate "
3970 LOCATE ,Z:PRINT " for a 10 uH coil wound with #14  "
3980 LOCATE ,Z:PRINT " AWG wire. Actual values will be  "
3990 LOCATE ,Z:PRINT " computed according to parameters "
4000 LOCATE ,Z:PRINT " you will be asked to enter.      "
4010 COLOR 7,0:LOCATE 24
4020 RETURN
4030 :REM'
4040 :REM'.....preface - page 1
4050 TB=8
4060 LOCATE ,TB
4070 PRINT "  This program designs single-layer air-core coils using equations"
4080 LOCATE ,TB
4090 PRINT "published in the 1997 ARRL HANDBOOK, page 6.22. These equations"
4100 LOCATE ,TB
4110 PRINT "provide close approximations of values for frequencies in the 1-30"
4120 LOCATE ,TB
4130 PRINT "MHz range that are sufficiently accurate for most Amateur Radio"
4140 LOCATE ,TB
4150 PRINT "purposes. The calculations are useful in the VHF and UHF range but"
4160 LOCATE ,TB
4170 PRINT "only as a basis for further calculation and experimentation. The"
4180 LOCATE ,TB
4190 PRINT "program designs coils with pitches (c.c. distance between turns)"
4200 LOCATE ,TB
4210 PRINT "as follows:"
4220 COLOR 0,7
4230 LOCATE ,TB
4240 PRINT " - BARE CONDUCTOR (wire or tubing) @ twice its diameter.     "
4250 LOCATE ,TB
4260 PRINT "     (use scraps of the same size conductor as turn spacers)."
4270 LOCATE ,TB
4280 PRINT " - ENAMELLED WIRE @ outside diameter of the enamel.          "
4290 LOCATE ,TB:
4300 PRINT " - INSULATED WIRE @ outside diameter of the insulation.      "
4310 LOCATE ,TB:COLOR 12,0
4320 PRINT "WIRE INSULATION MAY INTRODUCE DIELECTRIC LOSSES, AFFECTING COIL Q!"
4330 COLOR 7,0
4340 PRINT
4350 LOCATE ,TB
4360 PRINT "  The accuracy of equations used in this program may decrease if"
4370 LOCATE ,TB
4380 PRINT "the recommended turn spacing is greatly increased. In every case"
4390 LOCATE ,TB
4400 PRINT "spread the windings evenly over the winding length and secure in"
4410 LOCATE ,TB
4420 PRINT "place with shellac or other suitable coating."
4430 IF LD THEN 4520
4440 IF Y$="es2b"THEN 4520
4450 LOCATE ,TB
4460 PRINT "  If coil Q is critical to your application, exit this program now"
4470 LOCATE ,TB
4480 PRINT "and run the ";CHR$(34);"Coil Q Calculator";CHR$(34);" program. ";
4490 PRINT "Then run this program"
4500 LOCATE ,TB
4510 PRINT "again from the Coil Q Calculator program menu."
4520 RETURN
4530 :REM'
4540 :REM'preface - page 2
4550 PRINT " The Length-to-diameter (L/d) ratio of a coil can affect its Q. A ";
4560 PRINT "high Q       "
4570 PRINT " ensures improved circuit efficiency, a narrower bandwidth, and le";
4580 PRINT "ss bandwidth "
4590 PRINT " noise. Primary design considerations are:"
4600 RETURN
4610 :REM'
4620 PRINT " Q refers to True Q, as opposed to Apparent Q read by a Q meter."
4630 PRINT " - Q increases with coil diameter. Q increases with coil length."
4640 PRINT " - Max.Q occurs at about .35-.45 L/d ratio, decreasing rapidly be";
4650 PRINT "low this range.";
4660 PRINT " - 0.5 to 2.0 L/d ratios are commonly used in many Amateur radio ";
4670 PRINT "applications."
4680 PRINT " - The conductor diameter should be as large as practicable."
4690 PRINT " - The turn spacing should be about twice the conductor diameter."
4700 PRINT " - The coil form should have a low dielectric constant.";
4710 PRINT " Air is best."
4720 PRINT " - Coils with L/d ratios less than 0.4:1 may be designed using W";
4730 PRINT "heeler's"
4740 PRINT "    1982 equation in the COIL EQUATION CALCULATOR program."
4750 PRINT " - Q can be calculated using the COIL Q CALCULATOR program."
4760 RETURN
4770 :REM'
4780 :REM'PRT
4790 KEY OFF:GOSUB 4860:LOCATE 25,5:COLOR 0,2
4800 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
4810 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
4820 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 4820 :ELSE GOSUB 4860
4830 IF Z$="3"THEN RETURN
4840 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
4850 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 4790
4860 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
