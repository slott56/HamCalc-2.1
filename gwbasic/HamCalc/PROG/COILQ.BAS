10 :REM'COILQ  - Coil Q Calculator - 25 NOV 1998 rev. 29 MAY 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="coilq"
60 COMMON EX$,PROG$,D,L,Q,F,FQ,UH,LD,MIN,MAX,NN,I,I$,W
70 COLOR 7,0,0
80 UL$=STRING$(80,205)
90 DIM LD(10,6)  :REM'overview table
100 DIM Y(10)    :REM'tapped coil
110 DIM GA(40)
120 PI=4*ATN(1)  :REM'(3.141593)
130 :REM'.....AWG calculator
140 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
150 FOR Z=1 TO 40
160 N=Z+3
170 GA(Z)=0.46000000834465027!/K^N
180 NEXT Z:K=0:N=0
190 GOSUB 250:GOTO 330
200 :REM'
210 :REM'.....clear screen
220 VIEW PRINT LN TO 24:CLS:VIEW PRINT
230 RETURN
240 :REM'
250 :REM'.....title page
260 CLS
270 COLOR 15,2
280 PRINT " Coil Q Calculator"TAB(57)"by George Murphy VE3ERP ";
290 COLOR 1,0:PRINT STRING$(80,223);
300 COLOR 7,0
310 RETURN
320 :REM'
330 IF W THEN 420
340 GOSUB 2440   :REM'preface
350 COLOR 0,7:LOCATE ,24
360 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
370 Z$=INKEY$:IF Z$=""THEN 370
380 IF Z$="0"THEN CLS:RUN"\HAMCALC\MENU\HCAL-B"
390 IF Z$="1"THEN 420
400 GOTO 370
410 :REM'
420 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
430 IF GO$="miniquad"THEN CLS:LOCATE 1:GOTO 500
440 PRINT " Ref: G.Murphy VE3ERP, ";CHR$(34);"The Q of Single-Layer Air-Core";
450 PRINT " Coils: A Mathematical";
460 PRINT " Analysis";CHR$(34);", QEX/Communications Quarterly, Sept/Oct 2001";
470 PRINT " pp. 33-37."
480 PRINT UL$;
490 LOCATE 16:GOSUB 6260:COLOR 0,7:LOCATE 12,12
500 PRINT " Do you want dimensions in (m)etric or (i)inches?   (m/i) "
510 Z$=INKEY$:IF Z$=""THEN 510
520 IF Z$="m"THEN I=2.5399999618530273!:I$=" cm.":GOTO 560
530 IF Z$="i"THEN I=1   :I$=" in.":GOTO 560
540 GOTO 510
550 :REM'
560 COLOR 7,0:VIEW PRINT 3 TO 12:CLS:VIEW PRINT:LOCATE 3
570 IF GO$="miniquad"THEN CLS:LOCATE 1:GOTO 1350
580 PRINT " Press number in < > for:"
590 PRINT UL$;
600 COLOR 0,7
610 PRINT "  < 1 > Coil specifications for a specific frequency   "
620 COLOR 7,0
630 PRINT "  < 2 > Coil Designer program (to design a practical coil) "
640 PRINT "  < 3 > Chart of typical coil Q values at various L/d ratios and ";
650 PRINT "frequencies"
660 PRINT "  < 4 > Q & L/d ratios of coils with specified parameters"
670 PRINT "  < 5 > Length vs. Frequency with constant Q (e.g., a tapped coil)"
680 PRINT "  < 6 > Algorithms for True Q, L/d ratios, Self-Capacitance"
690 PRINT "  < 7 > High-Q commercial stock coils"
700 PRINT "  < 0 > EXIT";
710 Z$=INKEY$:IF Z$=""THEN 710
720 IF Z$="1"THEN 820
730 IF Z$="2"THEN CLS:CHAIN"coildsgn":ELSE QQ=0
740 IF Z$="3"THEN 2890
750 IF Z$="4"THEN 3360
760 IF Z$="5"THEN 5220
770 IF Z$="6"THEN CLS:GOTO 4050
780 IF Z$="7"THEN CLS:GOTO 5940
790 IF Z$="0"THEN CLS:RUN EX$
800 GOTO 710
810 :REM'
820 :REM'.....data input
830 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
840 PRINT "   A high-Q coil is recommended for applications requiring high ef";
850 PRINT "ficiency,    "
860 PRINT " narrow bandwidth, and minimum wide-band noise.                   "
870 PRINT "   Maximum Q occurs at a coil Length/diameter ratio of between (de";
880 PRINT "pending on   "
890 PRINT " other coil design parameters) .35 and .45, decreasing rapidly bel";
900 PRINT "ow that ratio"
910 PRINT " and more slowly above. To allow margin for error in designing a p";
920 PRINT "ractical coil"
930 PRINT " an initial L/d ratio of not less than .50 is recommended.        "
940 PRINT "   Optimum Q occurs when the self-resonant frequency of the coil d";
950 PRINT "ue to self-  "
960 PRINT " capacitance is about twice the operating frquency."
970 PRINT "   While an L/d ratio of .50 will result in near maximum Q, such a";
980 PRINT " high Q may  "
990 PRINT " not be desirable. Some circuits require maximum Q, some require a";
1000 PRINT " specific Q, "
1010 PRINT " and others require a relatively low Q. Q values with L/d ratios i";
1020 PRINT "n the range  "
1030 PRINT " 0.5 to 2.0 are commonly used in many practical applications."
1040 PRINT "   For high Q the optimum wire diameter is between .45 and .70 ti";
1050 PRINT "mes the c.c."
1060 PRINT " distance between turns (not all commercial stock coils meet this ";
1070 PRINT "condition). "
1080 PRINT " The nearest standard size conductor within these limits may be us";
1090 PRINT "ed, since   "
1100 PRINT " any error will be very small."
1110 PRINT
1120 PRINT "   Select a wire size large enough to carry the currents involved:"
1130 GOTO 1350
1140 :REM'
1150 :REM'.....find diameter
1160 D=10:X=1
1170 Y=SQR(U*(18*D+40*L))/D
1180 IF ABS(Y-N)<9.999999747378752e-05! THEN 1210
1190 IF SGN(Y-N)<>SGN(X)THEN X=-X/10
1200 D=D+X:GOTO 1170
1210 RETURN
1220 :REM'
1230 :REM'.....find diameter
1240 D=10:X=1
1250 L=LD*D
1260 EQ1=SQR(F)/Q
1270 EQ2=6.900000095367432!/(2.5399999618530273!*D/2)
1280 LU=0.3937000036239624!*5.400000095367432!/(EQ1-EQ2)
1290 IF ABS(LU-L)<0.0005000000237487257! THEN 1320
1300 IF SGN(LU-L)<>SGN(X)THEN X=-X/10
1310 D=D+X:IF D<=0 THEN 1330 :ELSE 1250
1320 N=SQR(U*(18*D+40*L))/D  :REM'no. of turns
1330 RETURN
1340 :REM'
1350 :REM'.....input data
1360 COLOR 7,0
1370 IF XIT=0 THEN 1440
1380  XIT=0:COLOR 15,7:LOCATE 6
1390  PRINT " Do you want to (c)hange Q or (r)eturn to menu?  (c/r)":COLOR 7,0
1400  Z$=INKEY$:IF Z$=""THEN 1400
1410 IF Z$="r"THEN GOSUB 250:GOTO 330
1420 IF Z$="c"THEN LOCATE CSRLIN-1:GOTO 1610
1430  GOTO 1400
1440 COLOR 0,7
1450 IF W THEN 1500
1460 PRINT " ENTER: Wire diameter (";I$;") or AWG size...";:INPUT W
1470 IF W=0 THEN LOCATE CSRLIN-1:GOTO 1460
1480 IF W<1 THEN 1500
1490 W=GA(W)*I
1500 P=W/0.44999998807907104!:W=W/I
1510 IF UH THEN U=UH:GOTO 1530
1520 INPUT " ENTER: Inductance in µH.........";U
1530 IF U=0 THEN LOCATE CSRLIN-1:GOTO 1520
1540 IF FQ=0 THEN INPUT " ENTER: Frequency in MHz.........";FQ
1550 F=FQ*10^6
1560 IF F=0 THEN LOCATE CSRLIN-1:GOTO 1540
1570 F=FQ*10^6
1580 P=P/I
1590 T=1/(W*2):GOSUB 4800:COLOR 15,0
1600 Q=QHI:GOTO 1650
1610 LOCATE 6:PRINT STRING$(80,32);:LOCATE 6
1620 PRINT USING " Median True Q is about #### ";QHI
1630 COLOR 7,0:INPUT " ENTER: Desired True Q of coil...";Q
1640 IF Q=0 THEN LOCATE CSRLIN-1:GOTO 1630
1650 COLOR 7,0
1660 CLS
1670 PRINT " Conductor diameter... ";USING "####.###";W*I;:PRINT I$
1680 PRINT " Inductance........... ";USING "####.### µH";U
1690 PRINT " Frequency............ ";USING "####.### MHz";FQ
1700 PRINT " Suggested True Q..... ";USING "####.### ";Q;
1710 COLOR 14,0:PRINT " (Max.Q occurs when L/d ratio is about 0.5:1) ":COLOR 7,0
1720 PRINT UL$;
1730 PRINT " L = length of coil,  d = outside diameter of coil form"
1740 T1$="│ Lgth.(    )│ dia. (    )│           │      Wire diameter range"
1750 T2$=" Typical coils with these specifications "
1760 PRINT UL$;
1770 LOCATE CSRLIN-1,(80-LEN(T2$))/2:PRINT T2$
1780 LOCATE ,12:PRINT T1$;:LOCATE ,1:PRINT " L/d ratio";
1790 LOCATE ,20:PRINT I$;:LOCATE ,33:PRINT I$
1800 :REM'.....compute dimensions
1810 J=0.5!/0.4000000059604645!:LD=0.4000000059604645!/J
1820 FLAG=0:DMAX=0:DMIN=0
1830  FOR Z=1 TO 11
1840 LD=LD*J
1850 GOSUB 1230
1860 :REM'
1870 SP=L/N  :REM'pitch
1880 IF D<=0 THEN 2010
1890 IF LD>2 THEN 2010
1900 FLAG=FLAG+1
1910 IF LD>0.49000000953674316! AND LD<0.5! THEN COLOR 14
1920 PRINT USING " L/d=##.## │";LD;
1930 PRINT USING " L=####.##  │";L*I;
1940 PRINT USING " d=####.##  │";D*I-W;
1950 IF DMAX=0 THEN DMAX=D
1960 DMIN=D
1970 PRINT USING "###.# turns│";N;
1980  Z$="##.##/ #.## cm = .###/.### in."
1990 PRINT USING Z$;SP*0.44999998807907104!*2.5399999618530273!,SP*0.699999988079071!*2.5399999618530273!,SP*0.44999998807907104!,SP*0.699999988079071!
2000 COLOR 7
2010   NEXT Z
2020 IF FLAG THEN 2170
2030 IF SP*0.44999998807907104!>W THEN Q$="lower"
2040 IF SP*0.699999988079071!<W THEN Q$="higher"
2050 BEEP:COLOR 12
2060 PRINT USING " This requires ###.# turns spaced #.###";N,SP*I;
2070 PRINT I$;" apart."
2080 PRINT USING " A #.###";W*I;
2090 PRINT I$;" diameter conductor requires a spacing between";
2100 PRINT USING " #.### and #.###";SP*0.44999998807907104!*I,SP*0.699999988079071!;:PRINT I$
2110 PRINT " Try again with a ";Q$;" Q!"
2120 PRINT:COLOR 0,7:PRINT " Press any key . . . ."
2130 IF INKEY$=""THEN 2130
2140 COLOR 7,0:VIEW PRINT 5 TO 24:CLS:VIEW PRINT
2150 LN=13:GOSUB 210:XIT=1:GOTO 1380
2160 :REM'
2170 PRINT UL$;:LOCATE 20
2180 COLOR 0,7:PRINT " Enter a coil form diameter (d) within the above range or"
2190 COLOR 7,0
2200 PRINT "  Decrease Q for higher L/d ratios & smaller coil diameters."
2210 PRINT "  Increase Q for lower L/d ratios & larger coil diameters."
2220 COLOR 0,7
2230 PRINT " ENTER: 0 (zero) to change, or ENTER:";
2240 PRINT " Coil form diameter (";I$;")...";
2250 :REM'GOSUB 6260   'activate this line only for demo print for QEX article
2260 INPUT D:IF D=0 THEN 2300
2270 IF (D/I)>=DMIN-0.009999999776482582! AND (D/I)<=DMAX+0.009999999776482582! THEN 2290
2280 BEEP:COLOR 7,0:LN=CSRLIN-1:GOSUB 210:LOCATE LN:GOTO 2220
2290 D=D/I
2300 COLOR 7,0
2310 IF D THEN D=D+W:GOTO 2370
2320 LN=CSRLIN
2330 VIEW PRINT 5 TO LN-4:CLS:VIEW PRINT
2340 VIEW PRINT LN-1 TO 24:CLS:VIEW PRINT
2350 XIT=1:GOTO 1380
2360 :REM'
2370 LN=5:GOSUB 210:LOCATE LN
2380 EQ1=SQR(F)/Q:EQ2=6.900000095367432!/(2.5399999618530273!*D/2)
2390 L=0.3937000036239624!*5.400000095367432!/(EQ1-EQ2)
2400 N=SQR(U*(18*D+40*L))/D  :REM'no. of turns
2410 LD=L/D:P=L/N:TPI=1/P:MIN=0.44999998807907104!*P:MAX=0.699999988079071!*P
2420 UH=U:NN=N-2:QQ=1:CHAIN"coiltrue"
2430 :REM'
2440 :REM'.....preface
2450 PRINT TAB(8);
2460 PRINT "Ref: Radiotron Designer's Handbook, 4th edition 1953, chap. 11.5."
2470 PRINT TAB(8)"     Terman, Radio Engineers' Handbook (1943)"
2480 COLOR 0,7
2490 TB=9
2500 LOCATE ,TB
2510 PRINT " The equations do not hold for coils with length-to-diameter  "
2520 LOCATE ,TB
2530 PRINT " ratios less than 0.35, coils with less than about 4 turns or "
2540 LOCATE ,TB
2550 PRINT " coils with conductor diameter-to-turn-spacing ratios of less "
2560 LOCATE ,TB
2570 PRINT " than 0.45 or more than 0.70                                  "
2580 COLOR 7,0
2590 PRINT "   This program computes theoretical True Q values. Some of the hi";
2600 PRINT "gher values  "
2610 PRINT " may not be attainable in practice, due to factors other than phys";
2620 PRINT "ical         "
2630 PRINT " dimensions and frequency that affect coil Q."
2640 PRINT "   When a coil is inserted into the circuit of a Q meter, the mete";
2650 PRINT "r assumes    "
2660 PRINT " coil Q to be the same as the circuit Q, which is not always the c";
2670 PRINT "ase. Also the"
2680 PRINT " presence of distributed coil capacity causes the apparent Q measu";
2690 PRINT "red by the Q "
2700 PRINT " meter to be lower than the True Q (Terman, page 916). True Q valu";
2710 PRINT "es calculated"
2720 PRINT " by this program ARE NOT the same as the apparent Q read by a Q me";
2730 PRINT "ter, but may "
2740 PRINT " be converted using the ";CHR$(34);"Coil Q - True vs. Apparent";
2750 PRINT CHR$(34);
2760 PRINT " program."
2770 PRINT"   Attempts to design a coil with an Apparent Q over about 900 may";
2780 PRINT " result in   "
2790 PRINT " abnormal dimensions, wire size, and/or number of turns."
2800 PRINT "   The subject of coil Q is too complex for resolution by a simp";
2810 PRINT "le equation."
2820 PRINT " However, Callender's approximation of Medhurst's formula (see Re";
2830 PRINT "f.) used in  "
2840 PRINT " this program produces results adequate for most amateur radio ap";
2850 PRINT "plications,  "
2860 PRINT " and as a basis for further research and development."
2870 RETURN
2880 :REM'
2890 :REM'.....overview table
2900 CLS
2910 F(1)=1.7999999523162842!:F(2)=3.5!:F(3)=7:F(4)=14:F(5)=21:F(6)=28
2920 LOCATE ,22:PRINT " (";I$;")";
2930 LOCATE ,38:INPUT Z:D=Z/I
2940 CLS
2950 PRINT " Theoretical Range of True Q for coils with diameter of";D*I;I$
2960 PRINT "╒"+STRING$(74,205)+"╕"
2970 FOR II=13 TO 67 STEP 9:LOCATE CSRLIN-1,II:PRINT "╤":NEXT II
2980 PRINT "│ L/d Ratio │ L ";I$;" │";
2990 FOR Y=1 TO 6:PRINT USING "##.# MHz";F(Y);:PRINT "│";:NEXT Y:PRINT " "
3000 PRINT "╞"+STRING$(74,205)+"╡"
3010 FOR II=13 TO 67 STEP 9:LOCATE CSRLIN-1,II:PRINT "╪":NEXT II
3020 FOR Z=1 TO 10
3030  FOR X=1 TO 6
3040   R=D/2*2.5399999618530273!  :REM'coil radius in cm.
3050   LG=Z/2*R*2  :REM'coil length in cm.
3060   Q=SQR(F(X)*10^6)/(6.900000095367432!/R+5.400000095367432!/LG)
3070   LD(Z,X)=Q
3080  NEXT X
3090 NEXT Z
3100 :REM'
3110 FOR Z=1 TO 10
3120 PRINT USING "│####.##:1";Z/2;
3130 Z$="  │###.##  │"
3140 PRINT USING Z$;Z/2*D*I;
3150 FOR X=1 TO 6
3160 IF LD(Z,X)<1500 THEN COLOR 7 :ELSE COLOR 12
3170 PRINT USING "######  ";LD(Z,X);:COLOR 7:PRINT "│";
3180 NEXT X
3190 COLOR 7
3200 PRINT ""
3210 NEXT Z
3220 PRINT "╘"+STRING$(74,205)+"╛";
3230 FOR II=13 TO 67 STEP 9:LOCATE CSRLIN,II:PRINT "╧";:NEXT II
3240 PRINT " This table indicates the relationship between diameter, length, f";
3250 PRINT "requency & Q."
3260 PRINT " True Q increases with diameter."
3270 PRINT " True Q increases with length."
3280 PRINT " True Q increases with frequency."
3290 COLOR 12
3300 PRINT " True Q in excess of 1500 is seldom required or attainable in act";
3310 PRINT "ual practice.":COLOR 7
3320 PRINT
3330 PRINT " The Apparent Q indicated by a Q meter is LESS than the True Q."
3340 GOTO 6380
3350 :REM'
3360 :REM'.....Q & L/d check
3370 CLS
3380 PRINT " SPECIFICATIONS:"
3390 PRINT UL$;
3400 INPUT " ENTER: Frequency (MHz).........";F
3410 IF F=0 THEN LOCATE CSRLIN-1:GOTO 3400
3420 INPUT " ENTER: Inductance (µH).........";U
3430 IF U=0 THEN LOCATE CSRLIN-1:GOTO 3420
3440 PRINT " ENTER: Pitch (";I$;")............";:INPUT P
3450 T=1/P*I   :REM'turns per inch
3460 CLS
3470 IF Z$="0"THEN 550
3480 LOCATE 1,18:PRINT USING " Frequency.... ####.### Mhz";F
3490 LOCATE 2,18:PRINT USING " Inductance... ####.## µH";U
3500 Z$=" Pitch........ ####.###"+I$
3510 LOCATE 3,18:PRINT USING Z$;P
3520 Z$="Conductor....    #.## to #.##"+I$+" diameter"
3530 LOCATE 4,19:PRINT USING Z$;0.44999998807907104!*P,0.699999988079071!*P
3540 PRINT UL$;
3550 N=4/SQR(2)
3560   FOR J=1 TO 16
3570 N=N*SQR(2)
3580 L=N/T
3590 GOSUB 1150 :REM'find diameter
3600 LD=L/D
3610 R=D/2*2.5399999618530273!    :REM'coil radius in cm.
3620 LG=L*2.5399999618530273!     :REM'coil length in cm.
3630 Q1=SQR(F*10^6)/(6.900000095367432!/R+5.400000095367432!/LG)
3640 QQ2=QQ1:QQ1=Q1
3650 IF QQ1<QQ2 THEN 3680
3660   NEXT J
3670 END
3680 :REM'.....screen display
3690 PRINT " Want to display (l)ow, (m)id or (h)igh range of coil turns?";
3700 PRINT "  (l/m/h) "
3710 Z$=INKEY$:IF Z$=""THEN 3710
3720 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
3730 IF Z$="l"THEN 3770
3740 IF Z$="m"THEN 3780
3750 IF Z$="h"THEN 3790
3760 :REM'
3770  B=INT(N/2)/2:C=CINT(N):E=(C-B)/16:GOTO 3800
3780  B=INT(N/2):C=CINT(N):E=(C-B)/16:GOTO 3800
3790  B=INT(N/2)/2:C=CINT(N)*4:E=(C-B)/16:GOTO 3800
3800 PRINT " No.turns│ L (";I$;")│ d (";I$;")│   L/d   │  True Q │"
3810   FOR J=B TO C STEP E
3820 N=J:L=N/T:GOSUB 1150
3830 LD=L/D
3840 IF J=B THEN MIN=LD
3850 IF J=C THEN MAX=LD
3860 R=D/2*2.5399999618530273!:LG=L*2.5399999618530273!
3870 Q1=SQR(F*10^6)/(6.900000095367432!/R+5.400000095367432!/LG)
3880 PRINT USING "  ###.#  │";N;
3890 PRINT USING "  ##.##  │";L*I;
3900 PRINT USING "  ##.##  │";D*I;
3910 PRINT USING " ##.###  │";LD;
3920 IF LD<0.27000001072883606! THEN PRINT "    **   │L/d too low to compute Q";:GOTO 3940
3930 PRINT USING " ####.## │";Q1;
3940 PRINT ""
3950   NEXT J
3960 QQ1=0:QQ2=0
3970 F=F*10^6:GOSUB 4800   :REM'get max. Q
3980 LOCATE 23:COLOR 0,7
3990 PRINT " Value of Q peaks as L/d ratio approaches";USING " #.###";LD;
4000 PRINT " where Q=";USING "####.## ";QHI
4010 IF MIN<0.36000001430511475! AND MAX>0.36000001430511475! THEN 4030
4020 BEEP:PRINT " Try again with a different TPI ! ";
4030 COLOR 7,0:GOTO 6390
4040 :REM'
4050 :REM'.....basic algorithms
4060 CLS
4070 LOCATE 7:PRINT UL$;:LOCATE 13:PRINT UL$;:LOCATE 18:PRINT UL$;:LOCATE 1
4080 :REM'
4090 VIEW PRINT 1 TO 6:CLS:VIEW PRINT:LOCATE 1
4100 PRINT " Press number in < > for:"
4110 PRINT UL$;
4120 PRINT "   < 1 >  True Q calculations"
4130 PRINT "   < 2 >  Coil Length/diameter calculation"
4140 PRINT "   < 3 >  Coil self-capacitance"
4150 PRINT "   < 0 >  Return to menu"
4160 Z$=INKEY$:IF Z$=""THEN 4160
4170 IF Z$<"0"OR Z$>"3"THEN 4160
4180 IF Z$="0"THEN GOSUB 250:GOTO 560
4190 VIEW PRINT 1 TO 6:CLS:VIEW PRINT:LOCATE 6:PRINT " COIL DATA:"
4200 IF Z$="1"THEN 4250
4210 IF Z$="2"THEN 4620
4220 IF Z$="3"THEN 4950
4230 GOTO 4160
4240 :REM'
4250 :REM'.....Q
4260 R=0:L=0:FQ=0:F=0:Q=0
4270 VIEW PRINT 8 TO 12:CLS:VIEW PRINT:LOCATE 8
4280 IF R THEN 4310
4290 PRINT " ENTER: Pitch diameter of coil (";I$;")...(0 if unknown)";
4300 INPUT Z:R=Z/2/I:GOSUB 4430
4310 IF L THEN 4340
4320 PRINT " ENTER: Length of coil (";I$;").......... (0 if unknown)";
4330 INPUT Z:L=Z/I:GOSUB 4430
4340 IF F THEN 4370
4350 INPUT " ENTER: Frequency in (MHz)................(0 if unknown)";FQ
4360 F=FQ*10^6:GOSUB 4420
4370 IF Q THEN 4400
4380 INPUT " ENTER: True Q........................... (0 if unknown)";Q
4390 GOSUB 4430
4400 GOTO 4270
4410 :REM'
4420 X=6.900000095367432!/2.5399999618530273!:Y=5.400000095367432!/2.5399999618530273!  :REM'convert R & L to cm.
4430 IF Q=0 AND F*R*L<>0 THEN Q=SQR(F)/(X/R+Y/L)
4440 IF L=0 AND F*Q*R<>0 THEN L=Y/(SQR(F)/Q-X/R):GOTO 4430
4450 IF R=0 AND F*Q*L<>0 THEN R=X/(SQR(F)/Q-Y/L):GOTO 4430
4460 IF F=0 AND Q*R*L<>0 THEN F=(Q*(X/R+Y/L))^2:GOTO 4430
4470 IF Q*L*R*F THEN 4480 :ELSE RETURN
4480 VIEW PRINT 8 TO 12:CLS:VIEW PRINT:LOCATE 8
4490 Z=2.5399999618530273!
4500 PRINT USING " Frequency.................. ####.### MHz";F/10^6
4510 PRINT " Length..................... ";
4520 PRINT USING "####.### cm. ( ##.### in.)";L*Z,L
4530 PRINT " Pitch diameter............. ";
4540 PRINT USING "####.### cm. ( ##.### in.)";2*R*Z,2*R
4550 LD=L/(2*R)
4560 PRINT USING " L/d ratio..................  ###.###:1";LD
4570 IF LD>=0.3499999940395355! THEN 4590
4580 PRINT " Q cannot be calculated for L/d ratios less than .35":GOTO 4600
4590 PRINT USING " True Q .................... ####.###";Q
4600 GOSUB 6420:Q=0:L=0:R=0:F=0:GOTO 4090
4610 :REM'
4620 :REM'.....find L/d for maximum Q
4630 FQ=0:F=0:U=0:T=0
4640 VIEW PRINT 14 TO 17:CLS:VIEW PRINT:LOCATE 14
4650 INPUT " Frequency (MHz..............";FQ:F=FQ*10^6
4660 IF FQ=0 THEN BEEP:LOCATE CSRLIN-1:GOTO 4650
4670 INPUT " Inductance (µH).............";U
4680 IF U=0 THEN BEEP:LOCATE CSRLIN-1:GOTO 4670
4690 INPUT " Turns per inch (2.54 cm.)...";T
4700 IF T=0 THEN BEEP:LOCATE CSRLIN-1:GOTO 4690
4710 VIEW PRINT 14 TO 16:CLS:VIEW PRINT:LOCATE 14
4720 PRINT USING " Frequency.................. ####.### MHz";FQ
4730 PRINT USING " Inductance................. ####.### µH";U
4740 PRINT USING " Turns per inch (2.54 cm.).. ####.###";T
4750 GOSUB 4800
4760 PRINT USING " Maximum True Q............. ####.###";QHI;
4770 PRINT " @ L/d ratio of";LD;":1"
4780 GOSUB 6420:FQ=0:F=0:U=0:T=0:GOTO 4090
4790 :REM'
4800 :REM'.....start loop
4810 QHI=0:QLO=0
4820 N=1:J=1
4830 N=N+J:L=N/T
4840 GOSUB 1150 :REM'find D
4850 LD=L/D
4860 R=D/2*2.5399999618530273! :REM'radius in cm.
4870 LG=L*2.5399999618530273!  :REM'length in cm.
4880 QLO=QHI
4890 QHI=SQR(F)/(6.900000095367432!/R+5.400000095367432!/LG)
4900 IF QHI<QLO THEN QHI=QLO:N=N-J:J=J/10:GOTO 4830
4910 IF ABS(QHI-QLO)<9.999999747378752e-05! THEN 4930
4920 GOTO 4830
4930 RETURN
4940 :REM'
4950 :REM'.....self-capacitance
4960 D=0:S=0:W=0:CD=0
4970 VIEW PRINT 19 TO 23:CLS:VIEW PRINT:LOCATE 19
4980 PRINT " ENTER: Pitch Diameter of coil (";I$;")....";
4990 INPUT Z:D=Z/I
5000 IF Z=0 THEN BEEP:LOCATE CSRLIN-1:GOTO 4980
5010 PRINT " ENTER: Pitch (turn spacing) (";I$;")......";
5020 INPUT Z:S=Z/I
5030 IF Z=0 THEN BEEP:LOCATE CSRLIN-1:GOTO 5010
5040 PRINT " ENTER: Diameter of conductor (";I$;").....";
5050 INPUT Z:W=Z/I
5060 IF Z=0 THEN BEEP:LOCATE CSRLIN-1:GOTO 5040
5070 SW=S/W
5080 DC=D*2.5399999618530273!                  :REM'coil diameter in cm.
5090 IHC=LOG(SW+SQR(SW^2-1))    :REM'Inverse Hyperbolic Cosine
5100 CD=PI*DC/(3.5999999046325684!*IHC)         :REM'distributed capacitance
5110 VIEW PRINT 19 TO 23:CLS:VIEW PRINT:LOCATE 19
5120 PRINT " Pitch Diameter of coil.....  ";
5130 PRINT USING " ##.### cm. ( ##.### in.)";D*2.5399999618530273!,D
5140 PRINT " Pitch (turn spacing).......  ";
5150 PRINT USING " ##.### cm. ( ##.### in.)";S*2.5399999618530273!,S
5160 PRINT " Diameter of conductor......  ";
5170 PRINT USING " ##.### cm. ( ##.### in.)";W*2.5399999618530273!,W
5180 PRINT " Self-Capacitance .......... ";
5190 PRINT USING " ###.### pF.";CD
5200 GOSUB 6420:D=0:S=0:W=0:CD=0:GOTO 4090
5210 :REM'
5220 :REM'.....tapped coil
5230 CLS:RESTORE
5240 DATA 14,30,48
5250 DATA 8,20,33,50,63,72
5260 FOR Z=1 TO 9:READ Y(Z):NEXT Z
5270 RESTORE
5280 :REM'
5290 PRINT " TAPPED COIL"
5300 PRINT UL$;
5310 IF I$=" cm "THEN M$=" centimetres":ELSE M$=" inches....."
5320 INPUT " ENTER: Desired constant True Q.....................";Q
5330 PRINT " ENTER: Coil pitch circle diameter in";M$;"...";:INPUT Z
5340 D=Z/I:R=D/2*2.5399999618530273!   :REM'radius in cm.
5350 PRINT " ENTER: Pitch (turn spacing) in";M$;".........";:INPUT Z
5360 P=Z/I   :REM'P=pitch in inches
5370 INPUT " ENTER: Number of taps (maximum 18).................";TAP
5380 IF TAP=0 THEN TAP=18
5390 TAP=INT(TAP):IF TAP>18 OR TAP=0 THEN TAP=18
5400 INPUT " ENTER: Highest frequency (at first tap) in MHz.....";HF
5410 INPUT " ENTER: Lowest frequency (at last tap) in MHz.......";LF
5420 LOCATE 1,13:PRINT USING " - Range:###.### MHz to ###.### MHz ";HF,LF;
5430 PRINT "(** = L/d too low to compute Q)"
5440 L=5.400000095367432!/(SQR(HF*10^6)/Q-6.900000095367432!/R) :REM'first tap length in cm
5450 PRINT
5460 LG=L/2.5399999618530273!
5470 Q=SQR(HF*10^6)/(6.900000095367432!/R+5.400000095367432!/L)
5480 :REM'
5490 :REM'.....print specs
5500 LN=3:GOSUB 220:LOCATE LN
5510 FOR Z=1 TO 3:LOCATE CSRLIN-1,Y(Z):PRINT "╤":NEXT Z
5520 PRINT USING " True Q=#####│";Q;
5530 Z$=" Dia.=##.##"+I$+"│"
5540 PRINT USING Z$;D*I;
5550 Z$=" Pitch= #.###"+I$+"│"
5560 PRINT USING Z$;P*I;
5570 Z$=" Wire dia. #.## to #.##"+I$
5580 PRINT USING Z$;0.5!*P*I,0.699999988079071!*P*I;
5590 PRINT UL$;
5600 FOR Z=1 TO 3:LOCATE CSRLIN-1,Y(Z):PRINT "╧":NEXT Z
5610 FOR Z=4 TO 9:LOCATE CSRLIN-1,Y(Z):PRINT "╤":NEXT Z
5620 :REM'
5630 :REM'.....print table
5640 JJ=EXP(LOG(LF/HF)/(TAP-1))
5650 KK=HF*JJ^-1
5660 FOR Z=1 TO TAP
5670 PRINT " Tap";USING"###│";Z;
5680 F=KK*JJ^Z
5690 PRINT USING "###.### MHz│";F;
5700 L=5.400000095367432!/(SQR(F*10^6)/Q-6.900000095367432!/R):LG=L/2.5399999618530273!
5710 N=LG/P
5720 PRINT USING "###.# turns │";N;
5730 Z$=" Lgth=###.##"+I$+"│"
5740 PRINT USING Z$;LG*I;
5750 PRINT USING " L/d=###.## │";LG/D;
5760 QZ=SQR(F*10^6)/(6.900000095367432!/R+5.400000095367432!/L)
5770 IF LG/D<0.3449999988079071! THEN PRINT " Q= **  │";:GOTO 5790
5780 PRINT USING " Q=#### │";QZ;
5790 UH=(D^2*N^2)/(18*D+40*LG)
5800 IF UH<10 THEN U$="##.# µH":ELSE U$="#### µH"
5810 IF UH<0.10000000149011612! THEN PRINT " <.1 µH";:GOTO 5830
5820 PRINT USING U$;UH;
5830 PRINT ""
5840 NEXT Z
5850 IF LG>=0 THEN 5890
5860 COLOR 0,7:BEEP
5870 PRINT " If any values are negative then try again with reduced frequency ";
5880 PRINT "range.";:COLOR 7,0:GOTO 5920
5890 COLOR 0,7:LOCATE 23,4
5900 PRINT " This table also applies to a series of coils with the same Q, ";
5910 PRINT "dia. & TPI ";:COLOR 7,0
5920 R=0:L=0:F=0:Q=0:GOTO 6380
5930 :REM'
5940 :REM'.....stock coils
5950 CLS
5960 PRINT " COMMERCIAL STOCK COILS   ";
5970 PRINT "(n/a = Not Acceptable for maximum Q applications)"
5980 PRINT UL$;
5990 COLOR 15,14
6000 PRINT" Not all commercial stock coils are suitable for applications requi";
6010 PRINT"ring high Q."
6020 COLOR 7,0
6030 PRINT" For maximum Q the ratio of wire diameter to winding pitch (i.e., c";
6040 PRINT".c. spacing "
6050 PRINT" between turns) must not be less than 0.45 nor greater than 0.70. A";
6060 PRINT"cceptable   "
6070 PRINT" maximum-Q diameter/pitch ratios for most commercial stock coils ar";
6080 PRINT"e:          "
6090 PRINT "════════";:FOR Z=1 TO 8:PRINT "╤═══════";:NEXT Z:PRINT "╤═══════";
6100 PRINT " Wire ─»";
6110 LOCATE ,9:FOR Z=10 TO 24 STEP 2
6120 PRINT "│AWG#";:PRINT USING " ##";Z;:NEXT Z:PRINT "│"
6130 PRINT "════════";:FOR Z=1 TO 8:PRINT "╪═══════";:NEXT Z:PRINT "╡"
6140 W=34
6150 FOR X=6 TO W STEP 2
6160 PRINT USING " ## TPI ";X;
6170 FOR Y=10 TO 24 STEP 2
6180 DS=GA(Y)/(1/X)  :REM'dia./spacing ratio
6190 IF DS <0.44999998807907104! OR DS>=0.699999988079071! THEN PRINT "│  n/a  ";:GOTO 6210
6200 PRINT "│";:COLOR 0,7:PRINT USING " #.### ";GA(Y)/(1/X);:COLOR 7,0
6210 NEXT Y:PRINT "│";:IF X<W THEN PRINT ""
6220 NEXT X
6230 F=0:D=0:R=0:L=0:N=0:Q=0:LG=0:UH=0:LD=0:TPI=0:TAP=0:HF=0:LF=0
6240 GOSUB 6420:CHAIN"aircore"
6250 :REM'
6260 :REM'.....equation
6270 Z=19:COLOR 0,7
6280 LOCATE ,Z:PRINT "            EQUATION for TRUE Q            "
6290 LOCATE ,Z:PRINT "                                           "
6300 LOCATE ,Z:PRINT "        √ƒ          Q = True Q             "
6310 LOCATE ,Z:PRINT " Q= ─────────       ƒ = Frequency in Hz    "
6320 LOCATE ,Z:PRINT "    6.9   5.4       R = Coil radius in cm. "
6330 LOCATE ,Z:PRINT "    ─── + ───       L = Coil length in cm. "
6340 LOCATE ,Z:PRINT "     R     L                               "
6350 LOCATE ,Z:PRINT "                                           "
6360 COLOR 7,0:RETURN
6370 :REM'
6380 :REM'.....end
6390 GOSUB 6420:GOSUB 250
6400 GOTO 560
6410 :REM'
6420 :REM'PRT
6430 KEY OFF:GOSUB 6500:LOCATE 25,5:COLOR 0,2
6440 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
6450 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
6460 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 6460 :ELSE GOSUB 6500
6470 IF Z$="3"THEN RETURN
6480 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
6490 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 6430
6500 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
