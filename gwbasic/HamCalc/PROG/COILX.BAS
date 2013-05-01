10 :REM'COILX    Coil Equations - 05 MAY 2006
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
120 COLOR 15,2,1
130 PRINT " Coil Calculator (Dehoney Equations)";
140 PRINT TAB(57)"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 15,2,1:LOCATE CSRLIN-1,24:PRINT " Algorithm by R.J.Dehoney IEEE "
170 COLOR 7,0
180 :REM'
190 :REM'.....start menu
200 PRINT
210 PRINT" This program finds the properties of single layer coils. For tapped";
220 PRINT" coils the "
230 PRINT" properties of the entire coil are found first, then the tap propert";
240 PRINT"ies. For   "
250 PRINT" coupled coils wound on the same form the coils are calculated indiv";
260 PRINT"idually,   "
270 PRINT" then their coupled properties are found."
280 PRINT UL$;
290 :REM'
300 PRINT "To run program .....press <1>"
310 PRINT "To read prologue....press <2>"
320 PRINT "To list variables...press <3>"
330 PRINT "To EXIT............ press <0>"
340 Z$=INKEY$:IF Z$=""THEN 340
350 COLOR 7,0,0
360 IF Z$="0"THEN CLS:RUN EX$
370 IF Z$="1"THEN CLS:GOTO 730
380 IF Z$="2"THEN CLS:LIST 420-610
390 IF Z$="3"THEN CLS:LIST 620-710
400 GOTO 340
410 :REM'
420 :REM'This program calculates the properties of single layer solenoid coils.
430 :REM'3 options are provided - single coil, tapped coil, or two spaced coils.
440 :REM'Inductance is calculated using the Bureau of Standards method as presented
450 :REM'in the Radiotron Handbook, 4th Edition. It uses the current sheet formula
460 :REM'corrected with Nagaoka's K factor with further corrections for round wire
470 :REM'and finite number of turns. The program finds the K factor using an exact
480 :REM'formula from Miller, Feb '87 IEEE, rather than the various approximations
490 :REM'developed by Wheeler and numerous others. The coupling coefficient of a
500 :REM'tapped coil is figured by calculating the inductancw of the entire coil
510 :REM'and the inductance of each section. Then M=(L-La-Lb)/2. For spaced coils
520 :REM'the calculation assumes a single coil tapped in two places, the space being
530 :REM'the turns between the two taps. Then Mac=(L-La-Lb-Lc-2*Mab-2*Mbc)/2. The
540 :REM'formula for inductance is L=D*N^2*[2.54*π^2*K*D/S-5.1*π*(A+B)/N] nH.
550 :REM'<A> is a function of the ratio of wire diameter to pitch, A=Ln(1.745*WD/P).
560 :REM'<B> is found using 3 formulas to approximate the curve in the Radiotron
570 :REM'Handbook. If the inductance and other parameters are known, the number of
580 :REM'turns can be calculated or a coil with highest Q can be found. Conditions
590 :REM'for highest Q are taken to be when the wire diameter equals= .7 times pitch
600 :REM'and the length equals .4 times diameter.
610 :REM'PRESS <F2> TO CONTINUE......
620 :REM'                     Definitions
630 :REM'               L = inductance in nH
640 :REM'               N = number of turns
650 :REM'               P = pitch, the distance between wire centers, inches
660 :REM'              PF = pitch factor, the ratio of wire diameter to pitch
670 :REM'               S = coil length to the outside of the end wires, inches
680 :REM'              DF = form diameter, inches
690 :REM'              WD = wire diameter, inches
700 :REM'               K = Nagaoka's correction factor
710 :REM'PRESS <F2> TO CONTINUE......
720 :REM'
730 :REM'.....set variables
740 FLAG=0 :K1=0.32485830783843994! :K2=1.1229317# :REM'AWG to wire diameter
750 L=0:N=0:P=0:PF=0:S=0:DF=0:WD=0:K=0
760 :REM'
770 :REM'.....start
780 PRINT "Select a program from the following menu:"
790 PRINT UL$;
800 PRINT "For Single coil.........................press <1>"
810 PRINT "For Tapped coil.........................press <2>"
820 PRINT "For Spaced coils on a single form.......press <3>"
830 PRINT UL$;
840 A$=INKEY$:IF A$=""THEN 840
850 IF A$="1"THEN 900
860 FLAG=1 :IF A$="2" THEN FLAG=2 :ELSE IF A$="3" THEN FLAG=4
870 PRINT
880 IF A$="3" THEN PRINT "First calculate one of the coils."
890 PRINT
900 PRINT "Do you know the coil inductance? <y/n>"
910 Z$=INKEY$:IF Z$=""THEN 910
920 LOCATE CSRLIN-1:PRINT X$
930 IF Z$="y"THEN 1320
940 IF Z$="n"THEN 980
950 GOTO 910
960 :REM'
970 :REM'.....other data inputs
980 INPUT "ENTER: Number of turns N";N
990 IF N=0 THEN 980
1000 IF WDX THEN 1050
1010 INPUT "ENTER: Wire diameter, inches or AWG # ";WDX
1020 IF WDX=0 THEN 1010  :REM'(required when changing no. of turns)
1030 IF WDX>1 THEN WD=0.32485830783843994!/1.1229317#^WDX :AWG=WDX
1040 IF WDX<=1 THEN AWG=INT(LOG(0.32485830783843994!/WDX)/LOG(1.1229317#)) :WD=WDX
1050 PRINT "       Wire diameter ="; :PRINT USING ".#### ";WD; :PRINT "inches ";
1060 PRINT "(AWG";AWG;")"
1070 IF DF THEN 1110 :ELSE INPUT "ENTER: Coil form diameter ";DF :D=WD+DF
1080 IF DF=0 THEN 1070
1090 :REM'
1100 :REM'.....pitch
1110 PRINT "To enter pitch ratio (=<1) of wire diameter to pitch....press <a>"
1120 PRINT "To choose pitch ........................................press <b>"
1130 PRINT "To choose coil length...................................press <c>"
1140 A$=INKEY$:IF A$=""THEN 1140
1150 IF A$="a"THEN 1200
1160 IF A$="b"THEN 1230
1170 IF A$="c"THEN 1260
1180 GOTO 1140
1190 LOCATE CSRLIN-1:PRINT X$
1200 INPUT "ENTER: Pitch ratio";PR
1210 IF PR=0 THEN 1200
1220 P=1/PR:S=P*N+(2*W):GOTO 1290
1230 INPUT "ENTER: Pitch (in.)";P
1240 IF P=0 THEN 1230
1250 PR=1/P:S=P*N+(2*W):GOTO 1290
1260 INPUT "ENTER: Coil length (in.)";S
1270 IF S=0 THEN 1260
1280 P=(S-(2*W))/N:PR=1/P:GOTO 1290
1290 GOSUB 2470 :LCALC=LX
1300 GOSUB 2280:GOTO 3350  :REM'....end
1310 :REM'
1320 :REM'.....subroutine for known inductance
1330 INPUT "ENTER: Desired inductance in µH ";L :L=L*1000
1340 IF L=0 THEN 1330
1350 LOCATE CSRLIN-1:PRINT X$
1360 INPUT "ENTER: Form diameter (inches)";DF
1370 LOCATE CSRLIN-1:PRINT X$
1380 PRINT "To choose Best Q...........................press <a>"
1390 PRINT "To choose Wire size........................press <b)"
1400 PRINT "To choose pitch............................press <c>"
1410 PRINT "To choose Pitch factor (wire dia./pitch)...press <d>"
1420 A$=INKEY$:IF A$=""THEN 1420
1430 IF A$="a" THEN GOTO 2200
1440 IF A$="b" THEN GOTO 1500
1450 IF A$="c" THEN GOTO 1680
1460 IF A$="d" THEN GOTO 1850
1470 GOTO 1420
1480 :REM'
1490 :REM'.....routine when wire size is known
1500 INPUT "Enter the wire diameter, inches, or AWG # ";WDX
1510 IF WDX=0 THEN 1500
1520 IF WDX>1 THEN WD=K1/K2^WDX :AWG=WDX
1530 IF WDX<=1 THEN AWG=INT(LOG(K1/WDX)/LOG(K2)) :WD=WDX
1540 CLS :PRINT "Number of turns   Overall coil length, in.     Pitch Factor"
1550 D=WD+DF :FOR PF=1 TO 0.05000000074505806! STEP -0.05000000074505806! :DN=16 :KN=2 :N=0
1560 N=N+DN :S=WD*(1+N/PF) :IF S/D>200 THEN 1600 :ELSE GOSUB 2470
1570 IF ABS(LX-L)/L=<0.0010000000474974513! THEN 1590
1580 IF L>LX THEN 1560 :ELSE IF L<LX THEN N=N-DN :DN=DN/KN :GOTO 1560
1590 PRINT USING "    ####.##            ####.###                  ##.##";N;S;PF
1600 NEXT PF
1610 INPUT "ENTER: Coil length (inches)";S :N=0 :DN=10
1620 IF S=0 THEN 1610
1630 N=N+DN :GOSUB 2470
1640 IF ABS(LX-L)/L=<0.0010000000474974513! THEN LCALC=LX :GOSUB 2280:GOTO 3350 :REM'...end
1650 IF LX<L THEN 1630 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 1630
1660 :REM'
1670 :REM'.....routine when pitch is known
1680 INPUT "ENTER: Pitch (inches)";P
1690 IF P=0 THEN 1680
1700 CLS :PRINT "AWG number    Number of turns    Overall coil length, inches"
1710 FOR AWG=2 TO 40 STEP 2 :WD=K1/K2^AWG:REM':IF WD>P THEN 1690
1720 D=DF+WD :N=0 :DN=10 :KN=2
1730 N=N+DN :S=WD+N*P :IF S/D>200 THEN 1770 :ELSE GOSUB 2470
1740 IF ABS(LX-L)/L<=0.0010000000474974513! THEN 1760
1750 IF LX<L THEN 1730 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 1730
1760 PRINT "  ";AWG;TAB(18);USING " ###.###              ";N;S
1770 NEXT AWG
1780 INPUT "ENTER an AWG #";AWG
1790 IF AWG=0 THEN 1780
1800 WD=K1/K2^AWG:D=DF+WD:N=0:DN=10
1810 N=N+DN :S=WD+N*P :GOSUB 2470
1820 IF ABS(LX-L)/L<=0.0010000000474974513! THEN GOSUB 2280:GOTO 3350 :REM'...end
1830 IF LX<L THEN 1810 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 1810
1840 :REM'
1850 :REM'.....routine when pitch factor is known
1860 INPUT "ENTER: Pitch factor ";PF
1870 IF PF=0 THEN 1860
1880 CLS :PRINT "AWG number    Number of turns    Overall coil length, inches"
1890 FOR AWG=1 TO 41 STEP 2 :WD=K1/K2^AWG
1900 D=DF+WD :N=0 :DN=10 :KN=2
1910 N=N+DN :S=WD*(1+N/PF) :IF S/D>200 THEN 1960 :ELSE GOSUB 2470
1920 IF ABS(LX-L)/L<=0.0010000000474974513! THEN 1940
1930 IF LX<L THEN 1910 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 1910
1940 PRINT "  ";AWG;TAB(18);USING "###.###              ";N;S
1950 NEXT AWG
1960 INPUT "ENTER an AWG #";AWG
1970 IF AWG=0 THEN 1960
1980 WD=K1/K2^AWG:D=DF+WD:P=WD/PF:N=0:DN=10
1990 N=N+DN :S=WD+N*P :GOSUB 2470
2000 IF ABS(LX-L)/L<=0.0010000000474974513! THEN LCALC=LX :GOSUB 2280:GOTO 3350 :REM'...end
2010 IF LX<L THEN 1990 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 1990
2020 :REM'
2030 :REM'.....routine when coil length is known
2040 IF S THEN  2060 :ELSE INPUT "ENTER: Overall coil length (inches)";S
2050 IF S=0 THEN 2040
2060 CLS :PRINT "AWG number    Number of turns    Pitch    Pitch factor"
2070 FOR PF=1 TO 0.03999999910593033! STEP -0.05000000074505806! :N=0 :DN=10 :KN=2
2080 N=N+DN :WD=S/(1+N/PF) :AWG=CINT(LOG(K1/WD)/LOG(K2)) :D=DF+WD
2090 IF S/DF>200 THEN CLS :PRINT "       Decrease coil length" :PRINT :GOTO 2040
2100 GOSUB 2470 :IF ABS(L-LX)/L=<0.0010000000474974513! THEN 2120
2110 IF LX<L THEN 2080 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 2080
2120 IF AWG=>0 THEN PRINT "  ";AWG;TAB(18);USING "###.###      ";N;P;PF
2130 NEXT PF
2140 INPUT "ENTER a wire gauge ";AWG
2150 IF AWG=0 THEN 2140
2160 WD=K1/K2^AWG :D=WD+DF :N=0 :DN=10
2170 N=N+DN:GOSUB 2470:IF ABS(LX-L)/L<=0.0010000000474974513! THEN LCALC=LX :GOSUB 2280:GOTO 3350
2180 IF LX<L THEN 2170 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 2170
2190 :REM'
2200 :REM'.....routine for best Q
2210 SA=0.4000000059604645!*DF :NA=SQR(34*L/1000/DF) :WD=0.6000000238418579!*SA/NA :D=DF+WD :S=0.4000000059604645!*D :N=0 :DN=10
2220 KN=2 :N=N+DN :GOSUB 2470 :IF ABS(L-LX)/L<=0.0010000000474974513! THEN 2240
2230 IF LX<L THEN 2220 :ELSE IF LX>L THEN N=N-DN :DN=DN/KN :GOTO 2220
2240 AWG=CINT(LOG(K1/WD)/LOG(K2))
2250 IF AWG>1 THEN WDX=AWG :ELSE WDX=WD
2260 GOSUB 2280:GOTO 3350
2270 :REM'
2280 :REM'.....subroutine to print values
2290 CLS:Z$=" nH":Z=LCALC:IF L THEN Z=L
2300 IF Z>=1000 THEN Z=Z/1000
2310 PRINT USING "Inductance............... ###.###";Z;:PRINT Z$
2320 PRINT USING "Wire diameter............ ###.### in. AWG ##";WD;AWG
2330 PRINT USING "Coil form diameter....... ###.### in.";DF
2340 PRINT USING "Number of turns.......... ###.###";N
2350 PRINT USING "Pitch.................... ###.### in.";P
2360 PRINT USING "Overall coil length...... ###.### in.";S
2370 IF P>=WD THEN 2400
2380 PRINT :COLOR 0,7:PRINT " TURNS OVERLAP! ";
2390 PRINT "INCREASE PITCH OR REDUCE WIRE DIAMETER! ":COLOR 7,0:GOTO 3350
2400 ONFLAG GOTO 2410,2430,2440,2450
2410 RETURN
2420 :REM'
2430 PRINT :INPUT "To show tap information press <ENTER> ",A$ :RETURN 2650
2440 PRINT USING "Tap at ##.## turns, L1=###.### µH, L2=###.### µH, K=.###, Mutual L=###.### µH";N1;L1;L2;C;M
2450 RETURN 2820
2460 :REM'
2470 :REM'.....subroutine to find K, then LX
2480 X=S/D :IF S>200 THEN RETURN
2490 X1=SQR(1+X^2) :U=1/X1 :A1=4*X*X1 :B1=4*X1/X
2500 A(0)=1 :B(0)=SQR(1-U^2) :C(0)=U :T1=2^0*C(0)^2 :FOR M=1 TO 9
2510 A(M)=1/2*(A(M-1)+B(M-1)) :B(M)=SQR(A(M-1)*B(M-1))
2520 C(M)=1/2*(A(M-1)-B(M-1)) :T1=T1+2^M*C(M)^2 :NEXT M
2530 F(U)=PI/2/A(M-1) :E(U)=F(U)*(1-1/2*T1)
2540 K=1/3/PI*(A1*F(U)-A1*E(U)+B1*E(U)-4/X)
2550 :REM'
2560 :REM'.....L=D*N^2*[2.54*pi^2*K/X-5.1*PI/N*(A+B)]
2570 P=(S-WD)/N :A=0.5569000244140625!+LOG(WD/P) :REM'from MEYER's article
2580 Z=LOG(N)/LOG(10) :REM'lines 000 & 000 are by CFIT, 390 is from Meyer's article.
2590 IF N<3.5999999046325684! THEN B=0.39703414#*Z+0.0010772900423035026!*Z^2-0.21069809794425964!*Z^3+0.0003699999942909926! :GOTO 2620
2600 IF N<10 THEN B=0.335999995470047!*(1-2.5!/N+3.799999952316284!/N^2-2.5!/N^3-0.8299999833106995!/N^4)+0.004000000189989805! :GOTO 2620
2610 Z=LOG(N-5)/LOG(10) :B=0.21360699832439423!+0.08856669813394547!*Z-0.0156870000064373!*Z^2
2620 LA=2.5399999618530273!*PI^2*D*N^2*K/X :LB=-5.099999904632568!*PI*N*D*(A+B) :LX=LA+LB  :REM'LX is in nH
2630 LX=LX+5.079999923706055!*S*(LOG(4*S/D)-0.75!) :RETURN :REM'inductance of straight wire, S" long
2640 :REM'
2650 :REM'.....subroutine to calculate tap parameters
2660 CLS :PRINT " Tapped turn    L1 uH         L2 uH           K       Mutual uH"
2670 NT=N :ST=S :FOR J=1 TO 18 :N1=NT/2*J/18 :S1=N1*P+WD :N2=NT-N1 :S2=N2*P+WD
2680 S=S1 :N=N1 :GOSUB 2470 :L1=LX/1000
2690 S=S2 :N=N2 :GOSUB 2470 :L2=LX/1000
2700 M=(LCALC/1000-L1-L2)/2 :C=M/SQR(L1*L2)
2710 PRINT USING " ###.##       ";N1,L1,L2,C,M
2720 NEXT J  :N=NT :S=ST
2730 :REM'.....select tap
2740 :REM'
2750 INPUT "Select tap @ turn #";N1
2760 S1=N1*P+WD :N2=NT-N1 :S2=N2*P+WD
2770 S=S1 :N=N1 :GOSUB 2470 :L1=LX/1000
2780 S=S2 :N=N2 :GOSUB 2470 :L2=LX/1000
2790 M=(LCALC/1000-L1-L2)/2 :C=M/SQR(L1*L2)
2800 FLAG=3 : N=NT :S=ST
2810 :REM'
2820 :REM'.....subroutine to get coupled coil info
2830 L1=LX :N1=N :S1=N*P+WD
2840 INPUT "Do you know the inductance of the second coil? <y/n> ",A$
2850 IF A$="y" THEN 2930
2860 INPUT "ENTER: Number of turns";N
2870 IF N=0 THEN 2860
2880 S=WD+N*P :GOSUB 2470 :L2=LX :S2=S :N2=N :GOTO 3060 :REM' to print
2890 IF S THEN 2910 :ELSE INPUT "ENTER: The overall coil length (inches)";S
2900 IF S=0 THEN 2890
2910 N=(S-WD)/P :IF N<1 THEN PRINT "N<1" :GOTO 2890
2920 GOSUB 2470 :L2=LX :N1=N :FLAG=1 :GOSUB 3060 :GOTO 3030
2930 :REM'.....routine when inductance is known
2940 :REM'
2950 INPUT "ENTER: Desired inductance of second coil in µH";L :L=L*1000
2960 IF L=0 THEN 2950
2970 DN=16 :KN=2 :N=0
2980 N=N+DN :S=WD+N*P :GOSUB 2470
2990 IF ABS(LX-L)/L=<0.0010000000474974513! THEN L2=LX :N2=N :S2=S :GOTO 3060
3000 IF L>LX THEN 2980 :ELSE IF L<LX THEN N=N-DN :DN=DN/KN :GOTO 2980
3010 :REM'
3020 :REM'.....space between coils
3030 INPUT "ENTER: Space between coils (inches)";SP
3040 IF SP=0 THEN GOSUB 3170 :ELSE NS=(SP+WD)/P :N=NS :S=N*P+WD :GOSUB 2470
3050 LS=LX :GOSUB 3280 :FLAG=5 :CLS
3060 PRINT "                   L1             L2"
3070 PRINT "Inductance     ";USING " ###.### µH   ";L1/1000;L2/1000
3080 PRINT "AWG number     ";USING " ###.         ";AWG;AWG
3090 PRINT "Coil form Dia  ";USING " ###.###      ";DF;DF
3100 PRINT "Number of turns";USING " ###.###      ";N1;N2
3110 PRINT "Pitch          ";USING " ###.###      ";P;P
3120 PRINT "Coil length    ";USING " ###.###      ";S1;S2
3130 P$="Mutual Inductance= ##.### µH  k=.####  Space beteen coils= ##.### in."
3140 IF FLAG=5 THEN PRINT USING P$;M12;K12;SP :GOTO 3350 :REM'...end
3150 GOTO 3030
3160 :REM'
3170 :REM'.....subroutine to show couplings
3180 CLS :PRINT "Spacing     Mutual uH    Coupling coeff"
3190 FOR J=1 TO 15 :SP=(S1+S2)/2*J/15 :NS=(SP+WD)/P :N=NS :S=N*P+WD
3200 GOSUB 2470 :LS=LX :GOSUB 3280
3210 PRINT USING " ##.###       ##.####        .###";SP,M12,K12
3220 NEXT J
3230 INPUT "ENTER: Spacing between coils (inches)";SP
3240 IF SP=0 THEN 3230
3250 RETURN 3040
3260 IF S=0 THEN 2040
3270 :REM'
3280 :REM'.....subroutine to find coupling
3290 N=N1+NS+N2 :S=WD+N*P :GOSUB 2470 :LT=LX
3300 N=N1+NS :S=WD+N*P :GOSUB 2470 :L112=LX
3310 N=NS+N2 :S=WD+N*P :GOSUB 2470 :L122=LX
3320 M12=(LT-L112-L122+LS)/2 :IF M12<0 THEN M12=0 :ELSE K12=M12/SQR(L1*L2)
3330 M12=M12/1000:RETURN
3340 :REM'
3350 :REM'.....end
3360 GOSUB 3440
3370 LOCATE 12
3380 PRINT TAB(18)"To return to menu..................press <0>"
3390 Z$=INKEY$:IF Z$=""THEN 3390
3400 IF Z$="0"THEN  100
3410 GOTO 3390
3420 END
3430 :REM'
3440 :REM'.....PRT
3450 KEY OFF:GOSUB 3520:LOCATE 25,5:COLOR 0,2
3460 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3470 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3480 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3480 :ELSE GOSUB 3520
3490 IF Z$="3"THEN RETURN
3500 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3510 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3450
3520 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
