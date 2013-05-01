10 :REM'ANTSYN2 - Antenna Matching Networks - 4 MAY 2010, rev.5/5/10
20 :REM'Final version. Taken from ANTSYNZ1, corrected and renumbered.
30 CLS:KEY OFF
40 IF EX$=""THEN EX$="EXIT"
45 IF PROG$="" THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 DIM L(20),C(20),G(20)
70 DIM A(8,9), B(8,9), X(8), NPIVROW(8,2), NPIVCOL(8,2)
80 PI=4*ATN(1)  :REM'3.141593
90 UL$=STRING$(80,205)
100 :REM'
110 :REM'.....title page
120 CLS
130 COLOR 15,2,1
140 PRINT " ANTENNA MATCHING NETWORKS"TAB(66)"by R.J.Dehoney ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 :REM'
180 PRINT " This program solves for the element values of a matching network for dipole"
190 PRINT " or monopole type antennas. Using four sets of Rin and jXin data, it calculates"
200 PRINT " values for an equivalent circuit, then, given the highest passband frequency,"
210 PRINT " the maximum and minimum allowable passband VSWRs, and the filter order, N, it"
220 PRINT " calculates the required vlaues for the matching network. Not all antennas can"
230 PRINT " be matched with this program. Sometimes the data will not result in  real"
240 PRINT " values for the antenna circuit, or the matching network will require negative"
250 PRINT " or unreasonable values. In these cases, other programs, such as HAMCALC's"
260 PRINT " MATCHBOX IMPEDANCE TRANSFORMER may help." :PRINT
270 LOCATE ,32:COLOR 0,7:PRINT " Program Hints: ":COLOR 7,0 :PRINT
280 PRINT " The program assumes a maximum VSWR of 1.05:1, a minimum VSWR of 1.0:1, and a"
290 PRINT " filter order, N, of 3. These values can be `TUNED' with the resulting circuit"
300 PRINT " values and lower pasband frequency displayed. Sometimes you will hear a `beep'"
310 PRINT " as you try to change a value. This means you have reached one of the program"
320 PRINT " limits, for instance negative matching elements, or N less than 2, or minimum"
330 PRINT " VSWR greater than maximum VSWR."
340 PRINT:LOCATE ,23
350 COLOR 0,7:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
360 A$=INKEY$:IF A$=""THEN 360
370 IF A$="0"THEN CLS :CHAIN GO$
380 IF A$="1"THEN 400
390 GOTO 360
400 COLOR 7,0,0 :KA=2 :CLS
410 NA=3 :SWRMAX=1.0499999523162842! :SWRMIN=1
420 PRINT :GOSUB 1810 ::REM'Calculate G(n)'s
430 FLAG2=1 :GOSUB 2240 :REM'get data and calc Ra-Cb
440 IF FLAG4=1 THEN 470
450 INPUT "ENTER: highest operating frequency in MHz ";F0 :FH=F0*10^6
460 IF F0=0 THEN 460
470 FLAG4=0 :GOSUB 500 :IF FLAG=1 THEN GOSUB 3510
480 CLS :GOSUB 710 :GOTO 900
490 :REM'......subroutine to calc L's & C's
500 FL=FH/(G(1)*LA/RA*2*PI*FH+1)
510 BW=FH-FL :BWR=2*PI*BW :F0=SQR(FH*FL) :W0=2*PI*F0
520 CP=G(1)/BWR/RA
530 M=CB/(CA+CB-CP)
540 CC=CB*(M-1) :CS=CB/M
550 IF (-1)^NA<0 THEN Z0=RA/M/M/SWRMIN :ELSE Z0=RA/M/M/SWRMAX
560 L(2)=G(2)*RA/BWR :C2=1/W0/W0/L(2) :C(2)=CS*C2/(CS-C2)
570 FOR I=3 TO NA STEP 2
580 C(I)=G(I)/RA/BWR*M*M
590 L(I)=1/C(I)/W0/W0
600 NEXT I
610 FOR I=4 TO NA STEP 2
620 L(I)=G(I)*RA/BWR/M/M
630 C(I)=1/L(I)/W0/W0
640 NEXT I
650 L(2)=L(2)/M/M :C(2)=C(2)*M*M
660 FOR M=1 TO 10 :IF C(M)<0 OR CC<0 THEN FLAG3=1
670 NEXT M :IF FLAG3=1 THEN FLAG=1 :FLAG3=0 :ELSE FLAG=0 :RETURN
680 :REM'-------------------------------------------------------------
690 :REM'.....subroutine to print values
700 CLS
710 P$="FL=  ####.### MHz│FH=###.### MHz│BW=   #####.##%"
720 PRINT USING P$;FL/10^6,FH/10^6,BW/F0*100
730 P$="Zo= #####.### Ω  │SQRmax= ###.##│SWRmin= ###.##"
740 PRINT USING P$;Z0/KA,SWRMAX,SWRMIN
750 PRINT :GOSUB 1740
760 LOCATE 1,53 :PRINT "════ ANTENNA ELEMENTS ════"
770 LOCATE 2,53
780 LOCATE 3,60 :PRINT "RA=";USING "####.###";RA/KA;:PRINT " ohms"
790 LOCATE 4,60 :PRINT "LA=";USING "####.###";LA/KA*10^6;:PRINT " uH"
800 LOCATE 5,60 :PRINT "CA=";USING "####.###";CA*KA*999999995904.0!;:PRINT " pF"
810 LOCATE 6,60 :PRINT "CB=";USING "####.###";2*CB*999999995904.0!;:PRINT " pF"
820 LOCATE 7,53 :PRINT "════ NETWORK ELEMENTS ════"
830 LOCATE 8,60 :PRINT "CC="USING "####.###" ;CC*KA*999999995904.0!;:PRINT " pF"
840 FOR I=2 TO NA :N$=MID$(STR$(I),2) :IF I MOD(2)=0 THEN PA=2 :ELSE PA=KA
850 LOCATE 2*I+5,60:PRINT "C"N$"=";USING "####.###";C(I)*PA*999999995904.0!;:PRINT " pF"
860 LOCATE 2*I+6,60:PRINT"L"N$"=";USING"####.###";L(I)/PA*10^6;:PRINT " uH"
870 NEXT I
880 RETURN
890 :REM'----------------menu when using data--------------------------
900 LOCATE 15,7 :PRINT "To change values, press letter as shown below:"
910 PRINT "         SWRMAX        SWRMIN       # Poles"
920 C$="──────":PRINT TAB(10);C$;TAB(23);C$;TAB(38);C$
930 PRINT "Increase  <X>           <S>          <N>"
940 PRINT "Decrease  <x>           <s>          <n>"
950 PRINT "For Zin of the antenna without the matching, enter <a>"
960 PRINT "For Zin of the antenna with the matching network, enter <v>"
970 PRINT "To continue, enter <c>."
980 PRINT "Enter letter....";
990 A$=INKEY$ :IF A$="" THEN GOTO 990
1000 IF A$="X" THEN SWRMAX=SWRMAX+0.05000000074505806! :GOSUB 2040
1010 IF A$="x" THEN SWRMAX=SWRMAX-0.05000000074505806! :GOSUB 2060
1020 IF A$="S" THEN SWRMIN=SWRMIN+0.05000000074505806! :GOSUB 2090
1030 IF A$="s" THEN SWRMIN=SWRMIN-0.05000000074505806! :GOSUB 2120
1040 IF A$="N" THEN NA=NA+1 :GOSUB 2150
1050 IF A$="n" THEN NA=NA-1 :GOSUB 2180
1060 IF A$="v" THEN GOSUB 1110 :GOTO 480
1070 IF A$="a" THEN GOSUB 1450 :GOTO 480
1080 IF A$="c" GOTO 1730 :REM' program end routine
1090 GOTO 480 :REM'repeats screen for any other entry.
1100 :REM'--------------------------------------------------------------------
1110 :REM'.....subroutine to find Zin
1120 CLS :IF FLAG2=1 THEN GOSUB 710 :ELSE GOSUB 680
1130  PRINT "This segment will analyze the matched antenna system                                  from a lower to an upper frequency."
1140 IF FLAG1=1 THEN PRINT :INPUT"Use same frequencies <y/n>? ",A$:IF A$="y"         GOTO 1180
1150 PRINT :INPUT "Enter the lower frequency in MHz ",F1 :IF F1=0 GOTO 1150
1160 INPUT "Enter the upper frequency in MHz ",F2 :IF F2<F1 THEN BEEP :GOTO 1150
1170 FS=(F2-F1)/12  :FLAG1=1
1180 CLS :LOCATE 2,1
1190 PRINT "Xin and VSWR for matched antenna with Z0="INT(10*Z0/KA)/10"ohms"
1200 PRINT " Frequency        Rin           Xin           VSWR"
1210 FOR FM=F1 TO F2*1.0010000467300415! STEP FS
1220 F=FM*10^6:W=2*PI*F
1230 RP=RA :BP=W*CA-1/W/LA :XP=-1/BP
1240 DN=RP*RP+XP*XP :RS=RP*XP*XP/DN :XS=XP*RP*RP/DN-1/W/CB
1250 RP=RS+XS*XS/RS :BP=-XS/(XS*XS+RS*RS)+W*CC :XP=-1/BP
1260 FOR P=2 TO NA STEP 2
1270 DN=RP*RP+XP*XP :RS=RP*XP*XP/DN :XS=XP*RP*RP/DN-1/W/C(P)+W*L(P)
1280 IF P+1>NA THEN GOTO 1320
1290 RP=RS+XS*XS/RS :BP=-XS/(XS*XS+RS*RS)+W*C(P+1)-1/W/L(P+1) :XP=-1/BP
1300 NEXT P
1310 DN=RP*RP+XP*XP :RS=RP*XP*XP/DN :XS=XP*RP*RP/DN
1320 REFLCO=SQR(((RS-Z0)^2+XS^2)/((RS+Z0)^2+XS^2))
1330 SWR=(1+REFLCO)/(1-REFLCO)
1340 PRINT USING "#####.##      ";F/10^6;RS/KA;XS/KA;SWR
1350 NEXT FM :PRINT
1360 PRINT "To change frequencies, press <f>"
1370 PRINT "To review antenna/network values, press <a>"
1380 PRINT "To continue, press <c>."
1390 A$=INKEY$ :IF A$="" GOTO 1390
1400 IF A$="f" GOTO 1150
1410 IF A$="a" THEN RETURN
1420 IF A$="c" THEN RETURN 1730
1430 GOTO 1390
1440 :REM'------------subroutine to find ZA---------------------------
1450 CLS :IF FLAG2=1 THEN GOSUB 710 :ELSE GOSUB 680 :REM'print display
1460 PRINT "This segment will analyze the antenna equivalent                                circuit from a lower to an upper frequency."
1470 IF FLAG1=1 THEN PRINT :INPUT "Use same frequencies? <y/n) ",A$:IF A$="y"        GOTO 1510
1480 PRINT :INPUT "Enter the lower frequency in MHz ",F1 :IF F1=0 GOTO 1480
1490 INPUT "Enter the upper frequency in MHz ",F2 :IF F2<F1 THEN BEEP :GOTO 1480
1500 FS=(F2-F1)/12  :FLAG1=1
1510 IF ZA=0 THEN INPUT "Enter trial ZA ",ZA :ZO=ZA*KA
1520 CLS :PRINT :PRINT "Zin and VSWR for antenna equivalent circuit with ZA="        INT(10*ZO/KA)/10"ohms"
1530 PRINT "Frequency         Rin          Xin          VSWR "
1540 FOR FM=F1 TO F2*1.0010000467300415! STEP FS
1550 F=FM*10^6 :W=2*PI*F
1560 RP=RA :BP=W*CA-1/W/LA :XP=-1/BP
1570 DN=RP*RP+XP*XP :RS=RP*XP*XP/DN :XS=XP*RP*RP/DN-1/W/CB
1580 RP=RS+XS*XS/RS :XP=XS+RS*RS/XS
1590 REFLCO=SQR(((RS-ZO)^2+XS^2)/((RS+ZO)^2+XS^2))
1600 SWR=(1+REFLCO)/(1-REFLCO)
1610 PRINT USING "####.##       ";F/10^6;RS/KA;XS/KA;SWR
1620 NEXT FM
1630 PRINT "To change ZA, press <z>"
1640 PRINT "To change frequencies, press <f>"
1650 PRINT "To review antenna/network values, press <a>"
1660 PRINT "To continue, press <c>."
1670 A$=INKEY$ :IF A$="" GOTO 1670
1680 IF A$="f" GOTO 1480
1690 IF A$="a" THEN RETURN
1700 IF A$="z" THEN INPUT "Enter new ZA ",ZA :ZO=ZA*KA :GOTO 1520
1710 IF A$="c" THEN RETURN 1730
1720 GOTO 1670
1730 GOSUB 3640:GOTO 110
1740 :REM'------------subroutine to print antenna circuit--------------
1750 PRINT "  ┌──┬──┬──CB─*┬─C2──L2─* * * * C4 * L4 *"
1760 PRINT "  │  │  │      │        *   *"
1770 PRINT "  RA LA CA     CC       C3  L3        INPUT"
1780 PRINT "  │  │  │      │        *   *"
1790 PRINT "  └──┴──┴─────*┴────────* * * * * * * * *"
1800 PRINT "  │«─antenna-»│«───matching network────»┤" :RETURN
1810 :REM'---------subroutine to calculate G(n)'s----------------------
1820 SX=SWRMAX :SM=SWRMIN :IF SX=1 THEN SX=1.0010000467300415!
1830 IF (SX-SM)=0 THEN SX=SX*1.0010000467300415!
1840 PMAX=(SX-1)/(SX+1) :ILMAX=1-PMAX^2
1850 PMIN=(SM-1)/(SM+1) :ILMIN=1-PMIN^2
1860 E1=SQR(ILMIN-ILMAX)
1870 U1=SQR((1-PMAX*PMAX)/(PMAX*PMAX-PMIN*PMIN))
1880 U2=PMIN*U1
1890 NA1=LOG(U1+SQR(U1*U1+1))
1900 NB1=LOG(U2+SQR(U2*U2+1))
1910 A=NA1/NA
1920 B=NB1/NA
1930 HSA=0.5!*(EXP(A)-EXP(-A))
1940 HSB=0.5!*(EXP(B)-EXP(-B))
1950 G(1)=2*SIN(PI/2/NA)/(HSA-HSB)
1960 FOR I=1 TO NA-1
1970 U3=4*SIN((2*I-1)*PI/2/NA)*SIN((2*I+1)*PI/2/NA)
1980 U4=HSA*HSA+HSB*HSB+SIN(I*PI/NA)^2-2*HSA*HSB*COS(I*PI/NA)
1990 G(I+1)=U3/U4/G(I)
2000 NEXT I
2010 GIN=2*SIN(PI/2/NA)/(HSA+HSB)/G(NA)
2020 RETURN
2030 :REM'.....logic subroutines for data.......................
2040 :REM'.....subroutine to check X
2050 GOSUB 1810 :GOSUB 490:IF FLAG=1 THEN BEEP:SWRMAX=SWRMAX-0.05000000074505806! :GOTO 2210 :ELSE     GOTO 2220
2060 :REM'.....subroutine to check x
2070 IF SWRMAX< SWRMIN*0.9990000128746033! THEN BEEP :SWRMAX=SWRMAX+0.05000000074505806! :GOTO 2220
2080 GOSUB 1810 :GOSUB 490:IF FLAG=1 THEN BEEP:SWRMAX=SWRMAX+0.05000000074505806! :GOTO 2220 :ELSE     GOTO 2220
2090 :REM'.....subroutine to check S
2100 IF SWRMIN>SWRMAX*1.0010000467300415! THEN BEEP :SWRMIN=SWRMIN-0.05000000074505806! :GOTO 2220
2110 GOSUB 1810 :GOSUB 490:IF FLAG=1 THEN BEEP:SWRMIN=SWRMIN-0.05000000074505806! :GOTO 2210 :ELSE     GOTO 2220
2120 :REM'.....subroutine to check s
2130 IF SWRMIN<0.9990000128746033! THEN BEEP :SWRMIN=SWRMIN+0.05000000074505806! :GOTO 2220
2140 GOSUB 1810 :GOSUB 490:IF FLAG=1 THEN BEEP:SWRMIN=SWRMIN*1.0099999904632568!:GOTO 2210 :ELSE     GOTO 2220
2150 :REM'.....subroutine to check N
2160 IF NA>6 THEN BEEP :NA=NA-1 :GOTO 2220
2170 GOSUB 1810 :GOSUB 490:IF FLAG=1 THEN BEEP: NA=NA-1:GOTO 2210 :ELSE GOTO 2220
2180 :REM'.....subroutine to check n
2190 IF NA<2 THEN BEEP :NA=NA+1 :GOTO 2220
2200 GOSUB 1810:GOSUB 490:IF FLAG=1 THEN BEEP: NA=NA+1 :GOTO 2210 :ELSE GOTO 2220
2210 GOSUB 1810 :GOSUB 490
2220 CLS :GOSUB 710 :RETURN 890
2230 :REM'
2240 :REM'.....subroutine to get data and calculate RA,LA,CA,and CB
2250 PRINT "Do you want to enter data (press 1) or see an example (press 2)"
2260 A$=INKEY$ :IF A$="" THEN 2260
2270 CLS :KEY OFF :N=4 :TP=2*3.1415972#
2280 IF A$="2" THEN 3260
2290 CLS :PRINT
2300 PRINT "The program requires 4 sets of <Frequency, Rin, Xin> data. Associate"
2310 PRINT "each set of data with a number from 1 to 4. Enter the data by first"
2320 PRINT "entering the data point number, then entering the F, Rin, and Xin"
2330 PRINT "values. Data will automatically be ordered by frequency, so it can "
2340 PRINT "be corrected. Change data by entering the data number, then entering"
2350 PRINT "the correct data. When all the data is correct, press <CR>"
2360 PRINT
2370 FOR P=9 TO 17:LOCATE P,1:PRINT "                                   ":NEXT P
2380 LOCATE 9,1 :INPUT "Enter Data Number ";A$
2390 IF A$<"1" OR A$>"4" THEN BEEP :GOTO 2370 :ELSE N=VAL(A$)
2400 INPUT "Enter Frequency (MHz)...";F(N)
2410 INPUT "Enter R (ohms)..........";R(N)
2420 INPUT "Enter X (ohms)..........";X1(N) :PRINT
2430 LOCATE 18,1 :FOR N=1 TO 4 :PRINT N USING "#####.###  ";F(N);R(N);X1(N)          :NEXT N
2440 FOR N=1 TO 4 :IF F(N)=0 THEN GOTO 2370 :ELSE NEXT N
2450 :REM'--------------sort frequency data-----------------------
2460 FOR N=1 TO 3
2470 FOR M=1 TO 3
2480 IF F(M)>F(M+1) THEN SWAP F(M),F(M+1) :SWAP R(M),R(M+1) :SWAP X1(M),X1(M+1)
2490 NEXT M :NEXT N :LOCATE 13,1
2500 LOCATE 18,1
2510 LOCATE 18,1 :FOR N=1 TO 4 :PRINT N USING "#####.###  ";F(N);R(N);X1(N)          :NEXT N
2520 PRINT :INPUT "Is data is OK? <y/n>. ", A$
2530 LOCATE 23,1 :PRINT "                                     "
2540 IF A$<>"y" GOTO 2370
2550 :REM'-----------------load matrix values---------------------
2560 FOR N=1 TO 4
2570 W(N)=F(N)*TP :GA(N)=R(N)/(R(N)^2+X1(N)^2) :B1(N)=-X1(N)/(R(N)^2+X1(N)^2)
2580 B(N,1)=-W(N)^3 :B(N,2)=W(N) :B(N,3)=W(N)^2*B1(N) :B(N,4)=-W(N)*GA(N)             :B(N,5)=B1(N)
2590 NEXT N :N=4
2600 :REM'------------------solve matrix-----------------------
2610 NC=N+1 :EPS=9.999999960041972e-13! :DET=1
2620 FOR K = 1 TO N
2630 FOR J = 1 TO NC
2640 A(K,J)=B(K,J)
2650 NEXT J : NEXT K
2660 FOR K = 1 TO N
2670 :REM'----------Apply complete pivoting strategy--------------
2680 MAXPIVOT = ABS(A(K,K))
2690 NPIVROW(K,1)=K: NPIVROW(K,2)=K
2700 NPIVCOL(K,1)=K: NPIVCOL(K,2)=K
2710 FOR I = K TO N
2720 FOR J = K TO N
2730 IF MAXPIVOT > = ABS(A(I,J)) GOTO 2770
2740 MAXPIVOT=ABS(A(I,J))
2750 NPIVROW(K,1)=K: NPIVROW(K,2)=I
2760 NPIVCOL(K,1)=K: NPIVCOL(K,2)=J
2770 NEXT J:NEXT I
2780 IF MAXPIVOT > = EPS GOTO 2800
2790 GOTO 3160
2800 IF NPIVROW(K,2)=K GOTO 2850
2810 FOR J = K TO NC
2820 SWAP  A(NPIVROW(K,2),J),A(K,J)
2830 NEXT J
2840 DET=DET*(-1)
2850 IF NPIVCOL(K,2)=K GOTO 2900
2860 FOR I = 1 TO N
2870 SWAP  A(I,NPIVCOL(K,2)),A(I,K)
2880 NEXT I
2890 DET=DET*(-1)
2900 IF K=N THEN GOTO 2970
2910 FOR I = K+1 TO N
2920 MULT = - A(I,K)/A(K,K)
2930 FOR J = NC TO K STEP -1
2940 A(I,J)=A(I,J)+MULT*A(K,J)
2950 NEXT J
2960 NEXT I
2970 NEXT K
2980 :REM'----------Apply the back-substitution formulas-----------
2990 RANK=K-1 :NMR=N-RANK
3000 IF RANK=N THEN X(N) = A(N,N+1) / A(N,N) :NCOUNT=N-1: GOTO 3040
3010 IF ABS(A(N,N+1)) > EPS THEN GOTO 3160
3020 FOR JJ=1 TO NMR : X(N+1-JJ) = 1: NEXT JJ
3030 NCOUNT=RANK
3040 FOR I = NCOUNT TO 1 STEP -1
3050 SUM = 0
3060 FOR J = I+1 TO N
3070 SUM = SUM + A(I,J) * X(J)
3080 NEXT J
3090 X(I) = (A(I,N+1) - SUM) / A(I,I)
3100 NEXT I
3110 :REM'.....interchange order of unknowns to correct for column pivoting
3120 FOR K=N TO 1 STEP -1
3130 SWAP X(NPIVCOL(K,2)), X(NPIVCOL(K,1))
3140 NEXT K :GOSUB 3190 :RETURN :REM'  solve for RA,LA,CA,CB and return
3150 :REM'
3160 PRINT "Either there's an error in the data or this antenna cannot be "
3170 PRINT "analyzed by this program. " :END
3180 :REM'-------------------------------------------------------------------
3190 :REM'.....subroutine to get RA ,LA ,CA, and CB values
3200 AA=X(1) :CB=X(2) :DD=X(3): EE=X(4)
3210 :REM'AA=CA*LA*CB, DD=LA*(CA+CB), EE=LA*GA
3220 CA=AA/DD*CB/(CB-AA/DD) :LA=DD/(CA+CB) :GA=EE/LA :RA=KA/GA
3230 CA=CA*9.999999974752427e-07!/KA : LA=KA*LA*9.999999974752427e-07! :CB=CB*9.999999974752427e-07!/KA
3240 IF CA<0 OR CB<0 OR RA<0 OR LA<0 THEN GOTO 3160
3250 RETURN
3260 :REM'----------------------------------------------------------------------
3270 :REM'.....subroutine to load example data
3280 PRINT "This Zin data is for a 4 meter long, 1 cm diameter monopole over good ground." :PRINT
3290 PRINT "   Frequency     Rin        Xin"
3300 PRINT "     17 MHz     27 ohms    -33 ohms"
3310 PRINT "     18         32          -3"
3320 PRINT "     19         37          26"
3330 PRINT "     20         43          55" :PRINT
3340 PRINT "The initial screen will show performance with a 3 pole matching network and a"
3350 PRINT "maximum VSWR of 1.05:1. The bandwidth is 6.24% and Zin is 47.158 ohms. If you"
3360 PRINT "press `X', you'll see the maximum VSWR increase. In fact, at VSWR=1.45:1,"
3370 PRINT "you'll find the bandwidth has increased to 14% and Zin has dropped to 12.38"
3380 PRINT "ohms, suitable for a simple 1:2 ferrite transformer. You'll notice that some"
3390 PRINT "of the C values are large and some of the L values are small. Moving them"
3400 PRINT "across the 1:2 transformer will make the C vaules 4 times smaller and the L"
3410 PRINT "values 4 times larger."
3420 F(1)=17 :R(1)=27 :X1(1)=-33
3430 F(2)=18 :R(2)=32 :X1(2)=-3
3440 F(3)=19 :R(3)=37 :X1(3)=26
3450 F(4)=20 :R(4)=43 :X1(4)=55
3460 PRINT :PRINT "Press any key"
3470 A$=INKEY$ :IF A$="" THEN 3470
3480 FH=20000000.0! :FLAG4=1
3490 PRINT :GOTO 2550
3500 :REM'------------------------------------------------------------------
3510 IF FLAG=1 THEN CLS :BEEP :INPUT "Reqires negative elements. This program not useful for this antenna. Press <CR>.",A$ :CLS :END
3520 :REM'
3530 :REM'                         Program Notes
3540 :REM'After the intro, the program loads starting values of SWR & L, then calcs
3550 :REM'G(N)'s. It then collects four sets of Zin data, then calculates RA,LA,CA,
3560 :REM'and CB .It then calculates the matching circuit L's & C's. Next, it print
3570 :REM'the data and the parameter change, and analysis screen. Here, VSWR and N
3580 :REM'can be changed, and Zin can be calculated for the antenna alone or the
3590 :REM'antenna with the matching network.
3600 :REM'Because of all the subroutines, a CLEAR statement had to be used to
3610 :REM'increase stack space to avoid an "OUT OF MEMORY" error.
3620 :REM'Extensive "tuning" might still cause the error.
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
