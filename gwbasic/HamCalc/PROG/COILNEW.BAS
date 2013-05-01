10 :REM'COILNEW - Coil calculator - 04 JUN 06
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 X$=STRING$(79,32)
70 UL$=STRING$(80,205)
80 PI=4*ATN(1)
90 :REM'
100 :REM'.....title page
110 CLS
120 PRINT " Coil Calculator (Dehoney Equations)";
130 PRINT TAB(57)"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 15,2,0:LOCATE CSRLIN-1,24:PRINT " Algorithm by R.J.Dehoney IEEE "
160 COLOR 7,0
170 :REM'
180 :REM'.....start menu
190 PRINT
200 PRINT" This program finds the properties of single layer coils. For tapped";
210 PRINT" coils the "
220 PRINT" properties of the entire coil are found first, then the tap propert";
230 PRINT"ies. For   "
240 PRINT" coupled coils wound on the same form the coils are calculated indiv";
250 PRINT"idually,   "
260 PRINT" then their coupled properties are found."
270 PRINT UL$;
280 PRINT "To run program .....press <1>"
290 PRINT "To read prologue....press <2>"
300 PRINT "To list variables...press <3>"
310 PRINT "To EXIT............ press <0>"
320 Z$=INKEY$:IF Z$=""THEN 320
330 COLOR 7,0,0
340 IF Z$="0"THEN CLS:RUN GO$
350 IF Z$="1"THEN CLS:GOTO 720
360 IF Z$="2"THEN CLS:LIST 400-590
370 IF Z$="3"THEN CLS:LIST 610-700
380 GOTO 320
390 :REM'
400 :REM'This program calculates the properties of single layer solenoid coils.
410 :REM'3 options are provided - single coil, tapped coil, or two spaced coils.
420 :REM'Inductance is calculated using the Bureau of Standards method as presented
430 :REM'in the Radiotron Handbook, 4th Edition. It uses the current sheet formula
440 :REM'corrected with Nagaoka's K factor with further corrections for round wire
450 :REM'and finite number of turns. The program finds the K factor using an exact
460 :REM'formula from Miller, Feb '87 IEEE, rather than the various approximations
470 :REM'developed by Wheeler and numerous others. The coupling coefficient of a
480 :REM'tapped coil is figured by calculating the inductance of the entire coil
490 :REM'and the inductance of each section. Then M=(L-La-Lb)/2. For spaced coils
500 :REM'the calculation assumes a single coil tapped in two places, the space being
510 :REM'the turns between the two taps. Then Mac=(L-La-Lb-Lc-2*Mab-2*Mbc)/2. The
520 :REM'formula for inductance is L=D*N^2*[2.54*π^2*K*D/S-5.1*π*(A+B)/N] nH.
530 :REM'<A> is a function of the ratio of wire diameter to pitch, A=Ln(1.745*WD/P).
540 :REM'<B> is found using 3 formulas to approximate the curve in the Radiotron
550 :REM'Handbook. If the inductance and other parameters are known, the number of
560 :REM'turns can be calculated or a coil with highest Q can be found. Conditions
570 :REM'for highest Q are taken to be when the wire diameter equals= .7 times pitch
580 :REM'and the length equals .4 times diameter.
590 :REM'PRESS <F2> TO CONTINUE......
600 :REM'
610 :REM'                     Definitions
620 :REM'               L = inductance in nH
630 :REM'               N = number of turns
640 :REM'               P = pitch, the distance between wire centers, inches
650 :REM'              PF = pitch factor, the ratio of wire diameter to pitch
660 :REM'               S = coil length to the outside of the end wires, inches
670 :REM'              DF = form diameter, inches
680 :REM'              WD = wire diameter, inches
690 :REM'               K = Nagaoka's correction factor
700 :REM'PRESS <F2> TO CONTINUE......
710 :REM'
720 :REM'.....set variables
730 FLAG=0 :K1=0.32485830783843994! :K2=1.1229317# :REM'AWG to wire diameter
740 L=0:N=0:P=0:PF=0:S=0:DF=0:WD=0:K=0
750 :REM'
760 :REM'.....start
770 PRINT "Select a program from the following menu:"
780 PRINT UL$;
790 PRINT "For Single coil.........................press <1>"
800 PRINT "For Tapped coil.........................press <2>"
810 PRINT "For Spaced coils on a single form.......press <3>"
820 PRINT UL$;
830 A$=INKEY$:IF A$=""THEN 830
840 IF A$="1"THEN 890
850 FLAG=1 :IF A$="2" THEN FLAG=2 :GOTO 870 :ELSE IF A$="3" THEN FLAG=4 :GOTO 870
860 GOTO 830
870 PRINT :IF A$="3" THEN PRINT "First calculate one of the coils."
880 PRINT
890 PRINT "Do you know the coil inductance? <y/n>"
900 Z$=INKEY$:IF Z$=""THEN 900
910 LOCATE CSRLIN-1:PRINT X$
920 IF Z$="y"THEN 1400
930 IF Z$="n"THEN 980
940 GOTO 890
950 :REM'
960 :REM'.....other data inputs
970 IF N THEN 1000
980 INPUT "ENTER: Number of turns N";N
990 IF N=0 THEN 980
1000 IF WD THEN 1060
1010 IF WDX THEN 1060
1020 INPUT "ENTER: Wire diameter, inches or AWG # ";WDX
1030 IF WDX=0 THEN 1020  :REM'(required when changing no. of turns)
1040 IF WDX>1 THEN WD=0.32485830783843994!/1.1229317#^WDX :AWG=WDX
1050 IF WDX<=1 THEN AWG=INT(LOG(0.32485830783843994!/WDX)/LOG(1.1229317#)) :WD=WDX
1060 PRINT "       Wire diameter ="; :PRINT USING ".#### ";WD; :PRINT "inches ";
1070 PRINT "(AWG";AWG;")"
1080 :REM'
1090 :REM'.....coil form
1100 IF DF THEN 1140 
1110 INPUT "ENTER: Coil form diameter ";DF :D=WD+DF
1120 IF DF=0 THEN 1110
1130 :REM'
1140 IF P THEN 1380
1150 PRINT "To enter pitch factor (=<1) of wire diameter to pitch....press <a>"
1160 PRINT "To choose pitch ........................................press <b>"
1170 PRINT "To choose coil length...................................press <c>"
1180 A$=INKEY$:IF A$=""THEN 1180
1190 IF A$="a"THEN 1260
1200 IF A$="b"THEN 1290
1210 IF A$="c"THEN 1340
1220 GOTO 1180
1230 LOCATE CSRLIN-1:PRINT X$
1240 :REM'
1250 :REM'.....pitch factor
1260 INPUT "ENTER: Pitch factor";PF :IF PF=1 THEN PF=0.9990000128746033!
1270 IF PF=0 OR PF>1 THEN 1260
1280 P=WD/PF :S=P*N+WD :GOTO 1370
1290 INPUT "ENTER: Pitch (in.)";P
1300 IF P=0 THEN 1290
1310 PF=WD/P :S=P*N+WD :GOTO 1370
1320 :REM'
1330 :REM'.....coil length
1340 INPUT "ENTER: Coil length (in.)";S
1350 IF S=0 THEN 1340
1360 P=(S-(2*W))/N :PF=WD/P:GOTO 1370
1370 GOSUB 2620 :LCALC=LX
1380 GOSUB 2400 :GOTO 3610  :REM'....end
1390 :REM'
1400 :REM'.....subroutine for known inductance
1410 IF L THEN 1440
1420 INPUT "ENTER: Desired inductance in µH ";L :L=L*1000
1430 IF L=0 THEN 1420
1440 LOCATE CSRLIN-1:PRINT X$
1450 IF DF THEN 1470
1460 INPUT "ENTER: Form diameter (inches)";DF
1470 LOCATE CSRLIN-1:PRINT X$
1480 PRINT "To choose Best Q...........................press <a>"
1490 PRINT "To choose Wire size........................press <b)"
1500 PRINT "To choose pitch............................press <c>"
1510 PRINT "To choose Pitch factor (wire dia./pitch)...press <d>"
1520 PRINT "To choose Overall coil length..............press <e>"
1530 A$=INKEY$:IF A$=""THEN 1530
1540 IF A$="a" THEN GOTO 2320
1550 IF A$="b" THEN GOTO 1620
1560 IF A$="c" THEN GOTO 1810
1570 IF A$="d" THEN GOTO 1980
1580 IF A$="e" THEN GOTO 2160
1590 GOTO 1530
1600 :REM'
1610 :REM'.....routine when wire size is known
1620 INPUT "Enter the wire diameter, inches, or AWG # ";WDX
1630 IF WDX=0 THEN 1620
1640 IF WDX>1 THEN WD=K1/K2^WDX :AWG=WDX
1650 IF WDX<=1 THEN AWG=INT(LOG(K1/WDX)/LOG(K2)) :WD=WDX
1660 CLS :PRINT "Number of turns   Overall coil length, in.     Pitch Factor"
1670 D=WD+DF :FOR PF=1 TO 0.05000000074505806! STEP -0.05000000074505806! :DN=16 :KN=2 :N=0
1680 N=N+DN :S=WD*(1+N/PF) :IF S/D>200 THEN 1720 :ELSE GOSUB 2620
1690 IF ABS(LX-L)/L=<0.0010000000474974513! THEN 1710
1700 IF L>LX THEN 1680 :ELSE IF L<LX THEN N=N-DN :DN=DN/KN :GOTO 1680
1710 PRINT USING "    ####.##            ####.###                  ##.##";N;S;PF
1720 NEXT PF
1730 INPUT "ENTER: Coil length (inches)";S :N=0 :DN=10
1740 IF S=0 THEN 1730
1750 N=N+DN :GOSUB 2620
1760 IF ABS(LX-L)/L=<0.0010000000474974513! THEN LCALC=LX :GOSUB 2400 :GOTO 3610 :REM'...end
1770 IF LX<L THEN 1750 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 1750
1780 :REM'
1790 :REM'.....routine when pitch is known
1800 IF P THEN 1830
1810 INPUT "ENTER: Pitch (inches)";P
1820 IF P=0 THEN 1810
1830 CLS :PRINT "AWG number    Wire diameter    Number of turns    Overall coil length, inches"
1840 FOR AWG=2 TO 40 STEP 2 :WD=K1/K2^AWG :IF WD>P THEN 1900
1850 D=DF+WD :N=0 :DN=10 :KN=2
1860 N=N+DN :S=WD+N*P :IF S/D>200 THEN 1900 :ELSE GOSUB 2620
1870 IF ABS(LX-L)/L<=0.0010000000474974513! THEN 1890
1880 IF LX<L THEN 1860 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 1860
1890 PRINT "  ";AWG;TAB(18);USING " ###.###          ";WD;N;S
1900 NEXT AWG
1910 INPUT "ENTER an AWG #";AWG
1920 IF AWG=0 THEN 1910
1930 WD=K1/K2^AWG:D=DF+WD:N=0:DN=10
1940 N=N+DN :S=WD+N*P :GOSUB 2620
1950 IF ABS(LX-L)/L<=0.0010000000474974513! THEN LCALC=L :GOSUB 2400 :GOTO 3610 :REM'...end
1960 IF LX<L THEN 1940 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 1940
1970 :REM'
1980 :REM'.....routine when pitch factor is known
1990 INPUT "ENTER: Pitch factor ";PF :IF PF=1 THEN PF=0.9990000128746033!
2000 IF PF=<0 OR PF>1 THEN 1990
2010 CLS :PRINT "AWG number    Wire diameter    Number of turns    Overall coil length, inches"
2020 FOR AWG=1 TO 41 STEP 2 :WD=K1/K2^AWG
2030 D=DF+WD :N=0 :DN=10 :KN=2
2040 N=N+DN :S=WD*(1+N/PF) :IF S/D>200 THEN 2080 :ELSE GOSUB 2620
2050 IF ABS(LX-L)/L<=0.0010000000474974513! THEN 2070
2060 IF LX<L THEN 2040 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 2040
2070 PRINT "  ";AWG;TAB(18);USING "###.###         ";WD;N;S
2080 NEXT AWG
2090 :REM'
2100 INPUT "ENTER an AWG #";AWG
2110 WD=K1/K2^AWG:D=DF+WD:P=WD/PF:N=0:DN=10
2120 N=N+DN :S=WD+N*P :GOSUB 2620
2130 IF ABS(LX-L)/L<=0.0010000000474974513! THEN LCALC=LX :GOSUB 2400 :GOTO 3610 :REM'...end
2140 IF LX<L THEN 2120 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 2120
2150 :REM'
2160 :REM'.....routine when coil length is known
2170 IF S THEN 2190 :ELSE INPUT "ENTER: Overall coil length (inches)";S
2180 IF S=0 THEN 2170
2190 CLS :PRINT "AWG number    Number of turns    Pitch    Pitch factor"
2200 FOR PF=1 TO 0.03999999910593033! STEP -0.05000000074505806! :N=0 :DN=10 :KN=2
2210 N=N+DN :WD=S/(1+N/PF) :AWG=CINT(LOG(K1/WD)/LOG(K2)) :D=DF+WD
2220 IF S/DF>200 THEN CLS :PRINT "       Decrease coil length" :PRINT :GOTO 2170
2230 GOSUB 2620 :IF ABS(L-LX)/L=<0.0010000000474974513! THEN 2250
2240 IF LX<L THEN 2210 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 2210
2250 IF AWG=>0 THEN PRINT "  ";AWG;TAB(18);USING "###.###      ";N;P;PF
2260 NEXT PF
2270 INPUT "Enter a pitch factor ",PF :IF PF=0 OR PF>1 THEN 2270
2280 N=N+DN :WD=S/(1+N/PF) :AWG=CINT(LOG(K1/WD)/LOG(K2)) :D=DF+WD
2290 GOSUB 2620 :IF ABS(LX-L)/L<=0.0010000000474974513! THEN LCALC=LX :GOSUB 2400:GOTO 3610
2300 IF LX<L THEN 2280 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 2280
2310 :REM'
2320 :REM'.....routine for best Q
2330 SA=0.4000000059604645!*DF :NA=SQR(34*L/1000/DF) :WD=0.6000000238418579!*SA/NA :D=DF+WD :S=0.4000000059604645!*D :N=0 :DN=10
2340 KN=2 :N=N+DN :GOSUB 2620 :IF ABS(L-LX)/L<=0.0010000000474974513! THEN 2360
2350 IF LX<L THEN 2340 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 2340
2360 AWG=CINT(LOG(K1/WD)/LOG(K2))
2370 IF AWG>1 THEN WDX=AWG :ELSE WDX=WD
2380 LCALC=LX :GOSUB 2400 :GOTO 3610 :REM'...end
2390 :REM'
2400 :REM'.....subroutine to print values
2410 CLS:Z=LCALC:Z$=" nH"
2420 IF Z>=1000 THEN Z=Z/1000:Z$=" µH"
2430 PRINT USING "Inductance............... ###.###";Z;:PRINT Z$
2440 KK=(0.46000000834465027!/0.004999999888241291!)^(1/39)
2450 AWG=LOG(0.46000000834465027!/WD)/(LOG(KK))-3
2460 PRINT USING "Wire diameter............ ###.### in. ( AWG ##.# )";WD,AWG
2470 :REM'PRINT "( AWG";AWG;")"
2480 PRINT USING "Coil form diameter....... ###.### in.";DF
2490 PRINT USING "Number of turns.......... ###.###";N
2500 PRINT USING "Pitch.................... ###.### in.";P
2510 PRINT USING "Overall coil length...... ###.### in.";S
2520 IF P>=WD THEN 2550
2530 COLOR 0,7:PRINT " TURNS OVERLAP! ";
2540 PRINT "INCREASE PITCH OR REDUCE WIRE DIAMETER! ":COLOR 7,0
2550 ONFLAG GOTO 2560,2570,2580,2600
2560 RETURN
2570 PRINT :INPUT "To show tap information press <ENTER> ",A$ :RETURN 2800
2580 PRINT USING "Tap at ##.## turns, L1=###.### µH, L2=###.### µH, K=.###, Mutual L=###.### µH";N1;L1;L2;C;M
2590 GOTO 3610 :REM'....end
2600 RETURN 2980
2610 :REM'
2620 :REM'.....subroutine to find K, then LX
2630 X=S/D :IF S>200 THEN RETURN
2640 X1=SQR(1+X^2) :U=1/X1 :A1=4*X*X1 :B1=4*X1/X
2650 A(0)=1 :B(0)=SQR(1-U^2) :C(0)=U :T1=2^0*C(0)^2 :FOR M=1 TO 9
2660 A(M)=1/2*(A(M-1)+B(M-1)) :B(M)=SQR(A(M-1)*B(M-1))
2670 C(M)=1/2*(A(M-1)-B(M-1)) :T1=T1+2^M*C(M)^2 :NEXT M
2680 F(U)=PI/2/A(M-1) :E(U)=F(U)*(1-1/2*T1)
2690 K=1/3/PI*(A1*F(U)-A1*E(U)+B1*E(U)-4/X)
2700 :REM'
2710 :REM'.....L=D*N^2*[2.54*pi^2*K/X-5.1*PI/N*(A+B)]
2720 P=(S-WD)/N :A=0.5569000244140625!+LOG(WD/P) :REM'from MEYER's article
2730 Z=LOG(N)/LOG(10)  :REM'the N<10 line is from Meyer, the other two from CFIT.
2740 IF N<3.5999999046325684! THEN B=0.39703414#*Z+0.0010772900423035026!*Z^2-0.21069809794425964!*Z^3+0.0003699999942909926! :GOTO 2770
2750 IF N<10 THEN B=0.335999995470047!*(1-2.5!/N+3.799999952316284!/N^2-2.5!/N^3-0.8299999833106995!/N^4)+0.004000000189989805! :GOTO 2770
2760 Z=LOG(N-5)/LOG(10) :B=0.21360699832439423!+0.08856669813394547!*Z-0.0156870000064373!*Z^2
2770 LA=2.5399999618530273!*PI^2*D*N^2*K/X :LB=-5.099999904632568!*PI*N*D*(A+B) :LX=LA+LB  :REM'LX is in nH
2780 LX=LX+5.079999923706055!*S*(LOG(4*S/D)-0.75!) :RETURN :REM'inductance of straight wire, S" long
2790 :REM'
2800 :REM'.....subroutine to calculate tap parameters
2810 CLS :PRINT " Tapped turn    L1 uH         L2 uH           K       Mutual uH"
2820 NT=N :ST=S :FOR J=1 TO 18 :N1=NT/2*J/18 :S1=N1*P+WD :N2=NT-N1 :S2=N2*P+WD
2830 S=S1 :N=N1 :GOSUB 2620 :L1=LX/1000
2840 S=S2 :N=N2 :GOSUB 2620 :L2=LX/1000
2850 M=(LCALC/1000-L1-L2)/2 :C=M/SQR(L1*L2)
2860 PRINT USING " ###.##       ";N1,L1,L2,C,M
2870 NEXT J  :N=NT :S=ST
2880 :REM'
2890 :REM'.....select tap
2900 :REM'IF N1 THEN 2610
2910 INPUT "Select tap @ turn #";N1
2920 S1=N1*P+WD :N2=NT-N1 :S2=N2*P+WD
2930 S=S1 :N=N1 :GOSUB 2620 :L1=LX/1000
2940 S=S2 :N=N2 :GOSUB 2620 :L2=LX/1000
2950 M=(LCALC/1000-L1-L2)/2 :C=M/SQR(L1*L2)
2960 FLAG=3 : N=NT :S=ST:GOSUB 2400
2970 :REM'
2980 :REM'.....routine to get coupled coil info
2990 L1=LX :N1=N :S1=N*P+WD
3000 PRINT "Do you know the inductance of the second coil? <y/n> "
3010 A$=INKEY$:IF A$=""THEN 3010
3020 IF A$="n"THEN LOCATE CSRLIN-1:PRINT X$:GOTO 3050
3030 IF A$="y"THEN LOCATE CSRLIN-1:PRINT X$:GOTO 3130
3040 GOTO 3010
3050 IF N2 THEN 3070 :ELSE INPUT "ENTER: Number of turns";N
3060 IF N=0 THEN 3050
3070 S=WD+N*P :GOSUB 2620 :L2=LX :S2=S :N2=N :GOTO 3280 :REM' to print
3080 IF S THEN 3100 :ELSE INPUT "ENTER: The overall coil length (inches)";S
3090 IF S=0 THEN 3080
3100 N=(S-WD)/P :IF N<1 THEN PRINT "N<1" :GOTO 3080
3110 GOSUB 2620 :L2=LX :N2=N :FLAG=1 :GOSUB 3280 :GOTO 3230
3120 :REM'
3130 :REM'.....routine when inductance is known
3140 PRINT :INPUT "ENTER: Desired inductance of second coil in µH";L :L=L*1000
3150 IF L=0 THEN 3140
3160 DN=16 :KN=2 :N=0
3170 N=N+DN :S=WD+N*P :GOSUB 2620
3180 IF ABS(LX-L)/L=<0.0010000000474974513! THEN L2=LX :N2=N :S2=S :GOTO 3280
3190 IF L>LX THEN 3170 :ELSE IF L<LX THEN N=N-DN :DN=DN/KN :GOTO 3170
3200 :REM'.....space between coils
3210 :REM'
3220 IF SP THEN 3270
3230 PRINT :INPUT "ENTER: Space between coils (inches)";SP
3240 LOCATE CSRLIN-1:PRINT X$
3250 IF SP=0 THEN 3230
3260 IF SP=0 THEN GOSUB 3440 :ELSE NS=(SP+WD)/P :N=NS :S=N*P+WD :GOSUB 2620
3270 LS=LX :GOSUB 3540 :FLAG=5 :IF A$="y"THEN LOCATE LN:GOTO 3360
3280 CLS:PRINT "                   L1             L2"
3290 PRINT "Inductance     ";USING " ###.### µH   ";L1/1000;L2/1000
3300 PRINT "AWG number     ";USING " ###.         ";AWG;AWG
3310 PRINT "Coil form Dia  ";USING " ###.###      ";DF;DF
3320 PRINT "Number of turns";USING " ###.###      ";N1;N2
3330 PRINT "Pitch          ";USING " ###.###      ";P;P
3340 PRINT "Coil length    ";USING " ###.###      ";S1;S2
3350 LN=CSRLIN
3360 P$="Mutual Inductance= ##.### µH  k=.####  Space between coils= ##.### in."
3370 IF FLAG=5 THEN PRINT USING P$;M12;K12;SP :ELSE 3230
3380 PRINT "Another spacing (y/n)?"
3390 A$=INKEY$:IF A$=""THEN 3390
3400 IF A$="n"THEN LOCATE CSRLIN-1:PRINT X$:GOTO 3610
3410 IF A$="y"THEN 3230
3420 GOTO 3390
3430 :REM'
3440 :REM'.....subroutine to show couplings
3450 CLS :PRINT "Spacing     Mutual uH    Coupling coeff"
3460 FOR J=1 TO 15 :SP=(S1+S2)/2*J/15 :NS=(SP+WD)/P :N=NS :S=N*P+WD
3470 GOSUB 2620 :LS=LX :GOSUB 3540
3480 PRINT USING " ##.###       ##.####        .###";SP,M12,K12
3490 NEXT J
3500 IF SP THEN 3520 :ELSE INPUT "ENTER: Spacing between coils (inches)";SP
3510 IF SP=0 THEN 3500
3520 RETURN 3260
3530 :REM'
3540 :REM'.....subroutine to find coupling
3550 N=N1+NS+N2 :S=WD+N*P :GOSUB 2620 :LT=LX
3560 N=N1+NS :S=WD+N*P :GOSUB 2620 :L112=LX
3570 N=NS+N2 :S=WD+N*P :GOSUB 2620 :L122=LX
3580 M12=(LT-L112-L122+LS)/2 :IF M12<0 THEN M12=0 :ELSE K12=M12/SQR(L1*L2)
3590 M12=M12/1000:RETURN
3600 :REM'
3610 :REM'.....end
3620 GOSUB 3640:GOTO 100
3630 :REM'
3640 :REM'.....PRT
3650 KEY OFF:GOSUB 3720:LOCATE 25,5:COLOR 0,2
3660 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3670 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3680 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3680 :ELSE GOSUB 3720
3690 IF Z$="3"THEN RETURN
3700 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3710 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3650
3720 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
