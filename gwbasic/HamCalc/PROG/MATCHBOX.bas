10 :REM'MATCHBOX - Matchbox Transformer - 09 DEC 01, rev. 14 DEC 2001
20 :REM'adapted from MATCH1.BAS by RJD, rev 0, Nov 10,2001
30 KEY OFF
40 IF EX$=""THEN EX$="EXIT"
50 PI=4*ATN(1)  :REM'3.141593
60 DEF FNX(Z)=CINT(Z*1000)/1000 :KE=1000000.0!
70 DIM F(30),R(30),X(30)
80 :REM'
90 :REM'.....title page
100 CLS
110 COLOR 15,2,1
120 PRINT " MATCHBOX IMPEDANCE TRANSFORMER"TAB(60)"by Robert J. Dehoney ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 15,2
150 LOCATE CSRLIN-1,18:PRINT " Edited for HAMCALC by George Murphy VE3ERP "
160 COLOR 7,0
170 :REM'
180 TP=2*PI:K1=1:K2=1:K3=1:K4=1
190 PRINT
200 TB=7
210 PRINT TAB(TB);
220 PRINT "For a single-band antenna, you can match across an entire band with"
230 PRINT TAB(TB);
240 PRINT "a few components and eliminate a bulky and expensive variable range"
250 PRINT TAB(TB);
260 PRINT "matchbox."
270 PRINT
280 PRINT TAB(TB);
290 PRINT "This program automates the impedance matching procedure described  "
300 PRINT TAB(TB);
310 PRINT "by Grant Bingeman, KM5KG, in the September/October 2001 issue of   "
320 PRINT TAB(TB);
330 PRINT "QEX magazine, and Sect. 43-7, Jasic `Antenna Engineering Handbook'."
340 PRINT :COLOR 0,7:LOCATE 24,23
350 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
360 Z$=INKEY$:IF Z$="0"THEN COLOR ,,0:CLS:CHAIN EX$
370 IF Z$="1"THEN 390
380 GOTO 360
390 CLS:COLOR 7,0,0
400 PRINT TAB(TB);
410 PRINT "This device is especially useful for simple antennas such as       "
420 PRINT TAB(TB);
430 PRINT "dipoles and monopoles. The circuit consists of a resonating        "
440 PRINT TAB(TB);
450 PRINT "reactance to cancel the load reactance at band center, followed by "
460 PRINT TAB(TB);
470 PRINT "LC tanks and a Tee or Pi matching network. 12 different            "
480 PRINT TAB(TB);
490 PRINT "configurations are possible consisting of 4 different Tee or Pi    "
500 PRINT TAB(TB);
510 PRINT "transformers placed at 3 different locations. After computing the  "
520 PRINT TAB(TB);
530 PRINT "data for any configuration, values for any other configuration can "
540 PRINT TAB(TB);
550 PRINT "be computed instantly by single menu-driven keystrokes."
560 PRINT
570 PRINT TAB(TB);
580 PRINT "The program finds Rin, Xin, and SWR at the frequencies specified,  "
590 PRINT TAB(TB);
600 PRINT "and gives the values of the matching circuits in uH and pF."
610 PRINT
620 COLOR 0,7:PRINT " Press number in ( ) to locate transformers ":COLOR 7,0
630 PRINT
640 PRINT "  (1) after the LC tanks"
650 PRINT "  (2) between the LC tanks"
660 PRINT "  (3) before the LC tanks"
670 Z$=INKEY$:IF Z$=""THEN 670
680 IF Z$<"1"OR Z$>"3"THEN 670
690 J=VAL(Z$):LOCA=J:GOSUB 2160:GOTO 710     :REM'loca=memorize location
700 PRINT
710 COLOR 0,7:PRINT " Press number in ( ) for transformer type:":COLOR 7,0
720 PRINT
730 PRINT "  (1) LCL Tee"
740 PRINT "  (2) CLC Tee"
750 PRINT "  (3) LCL Pi"
760 PRINT "  (4) CLC Pi"
770 Z$=INKEY$:IF Z$=""OR Z$<"1"OR Z$>"4"THEN 770
780 T=VAL(Z$):GOSUB 2210
790 CLS:ONT GOSUB 4260,4570,5110,4840
800 PRINT :LN=CSRLIN
810 INPUT "ENTER: System impedance Zo in ohms";Z0
820 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
830 PRINT " System impedance is";Z0;"ohms"+STRING$(40,32)
840 PRINT:COLOR 0,7:LN=CSRLIN
850 PRINT " Press letter in ( ) to select option for loading the data:"
860 COLOR 7,0:PRINT
870 PRINT "  (a) For monopoles, use length and diameter"
880 PRINT
890 PRINT "  (b) Use measured data exclusively"
900 PRINT
910 PRINT "  (c) Enter data for low, mid and high frequencies"
920 PRINT "      and let program calculate values in between."
930 A$=INKEY$:IF A$=""OR A$<"a"OR A$>"c"THEN 930
940 IF A$="a"THEN GOSUB 2420:GOTO 980
950 IF A$="b"THEN GOSUB 2750:GOTO 980
960 IF A$="c"THEN GOSUB 3020:GOTO 980
970 :REM'
980 :REM'.....calculate network R,X, & SWR
990 CLS
1000 PRINT "  Freq     Rin/Zo     Xin/Zo     SWR"
1010 FOR N=1 TO M0
1020 IF N=1 OR N=6 OR N=11 THEN COLOR 15 :ELSE COLOR 7
1030 F=F(N) :W=F*TP :R=R(N) :X=X(N)
1040 :REM'.....add Lres or Cres
1050 IF FLAG=1 THEN X=X+W*LRES*K4 :ELSE IF FLAG=2 THEN X=X-1/W/CRES/K4
1060 :REM'.....calculate final SWR
1070 IF J=1 THEN KX=K2:GOSUB 1110 :GOSUB 1140 :GOSUB 1170 :GOTO 1180
1080 IF J=2 THEN KX=K2:LP=L1 :CP=C1 :GOSUB 1110 :GOSUB 1160 :LP=L2 :CP=C2 :KX=K3
1090 IF J=2 THEN GOSUB 1110 :GOTO 1180
1100 IF J=3 THEN KX=K2:GOSUB 1160 :GOSUB 1140 :GOSUB 1110 :GOTO 1180
1110 :REM'.....add Lp, Cp
1120 G=R/(R^2+X^2) :B=-X/(R^2+X^2)
1130 B=B+W*CP/KX-1/W/LP/KX :R=G/(G^2+B^2) :X=-B/(G^2+B^2) :RETURN
1140 :REM'.....add LS, Cs
1150 X=X+W*LS*K3-1/W/CS/K3 :RETURN
1160 :REM'.....add 1/4 wave transforming section
1170 LT=K1*LT0 :CT=CT0/K1 :ONT GOSUB 2270,2310,2340,2380 :RETURN
1180 :REM'.....calculate SWR and print
1190 RHOF=SQR((R-Z0)^2+X^2)/SQR((R+Z0)^2+X^2) :SWR=(1+RHOF)/(1-RHOF)
1200 PRINT USING "###.###   ";F;R/Z0;X/Z0;SWR
1210 NEXT N
1220 PRINT :ONT GOSUB 4250,4560,5100,4830
1230 IF FLAG=1 THEN B$="Lr" :RES=LRES*K4 :X$=B$:W$=" uH"
1240 IF FLAG=2 THEN B$="Cr" :RES=CRES*KE*K4 :X$=B$:W$=" pF"
1250 IF FLAG=3 THEN X$="────"
1260 KA=FNX(K1) :KB=FNX(K2) :KC=FNX(K3) :KD=FNX(K4)
1270 IF J=1 OR J=3 THEN 1290 :ELSE 1400
1280 :REM'
1290 COLOR 0,7:LOCATE 13,34:PRINT X$:LOCATE 18,1
1300 PRINT " LP=";:Y=LP*K2:GOSUB 2070:PRINT USING Y$;Y;:PRINT " uH│";
1310 PRINT "LS=";:Y=LS*K3:GOSUB 2070:PRINT USING Y$;Y;:PRINT " uH│";
1320 PRINT "LT=";:Y=K1*LT:GOSUB 2070:PRINT USING Y$;Y;:PRINT " uH "
1330 PRINT " CP=";:Y=CP*KE/K2:GOSUB 2070:PRINT USING Y$;Y;:PRINT " pF│";
1340 PRINT "CS=";:Y=CS*KE/K3:GOSUB 2070:PRINT USING Y$;Y;:PRINT " pF│";
1350 PRINT "CT=";:Y=CT*KE/K1:GOSUB 2070:PRINT USING Y$;Y;:PRINT " pF "
1360 PRINT " ";B$;"=";:Y=RES:GOSUB 2070:PRINT USING Y$;Y;:PRINT W$;
1370 PRINT USING "│Zo=###.# ohms│              ";Z0
1380 GOTO 1500
1390 :REM'
1400 COLOR 0,7:LOCATE 13,34:PRINT X$:LOCATE 18,1
1410 PRINT " L1=";:Y=L1*K2:GOSUB 2070:PRINT USING Y$;Y;:PRINT " uH│";
1420 PRINT "L2=";:Y=L2*K3:GOSUB 2070:PRINT USING Y$;Y;:PRINT " uH│";
1430 PRINT "LT=";:Y=K1*LT:GOSUB 2070:PRINT USING Y$;Y;:PRINT " uH "
1440 PRINT " C1=";:Y=C1*KE/K2:GOSUB 2070:PRINT USING Y$;Y;:PRINT " pF│";
1450 PRINT "C2=";:Y=C2*KE/K3:GOSUB 2070:PRINT USING Y$;Y;:PRINT " pF│";
1460 PRINT "CT=";:Y=CT*KE/K1:GOSUB 2070:PRINT USING Y$;Y;:PRINT " pF "
1470 PRINT " ";B$;"=";:Y=RES:GOSUB 2070:PRINT USING Y$;Y;:PRINT W$;
1480 PRINT USING "│Zo=###.# ohms│              ";Z0
1490 :REM'
1500 COLOR 7,0
1510 PRINT USING " K1= #.## │ K2= #.## │ K3= #.## │ K4= #.##";KA,KB,KC,KD;
1520 IF LL*DD THEN 1530 :ELSE 1550
1530 PRINT
1540 PRINT USING "##.## cm. diameter monopole ##.## m. long";DD,LL
1550 LOCATE 1,42 :PRINT "K1 adjusts the matching xformer Z"
1560 LOCATE 2,42 :PRINT "K2 adjusts the first LC tank"
1570 LOCATE 3,42 :PRINT "K3 adjusts the second LC tank"
1580 LOCATE 4,42 :PRINT "K4 adjusts Lr or Cr"
1590 LOCATE 6,42 :PRINT "To: change K1 by 1%, press <+/->"
1600 LOCATE 7,46 :PRINT "change K2 by 1%, press <u/d>"
1610 LOCATE 8,46 :PRINT "change K3 by 1%, press <m/l>"
1620 LOCATE 9,46 :PRINT "change K4 by 1%, press <b/s>"
1630 LOCATE 10,46 :PRINT "change Zo, press <z>"
1640 LOCATE 11,46 :PRINT "change Tee/Pi sections, press <t>"
1650 LOCATE 12,46 :PRINT "change configuration, press <c>"
1660 COLOR 15,0:LOCATE 13,46 :PRINT "end program, press <q>"
1670 COLOR 7,0:LOCATE 16,44:PRINT "«";:COLOR 0,7
1680 PRINT " ";TYPE$;", Configuration";LOCA""
1690 COLOR 7,0
1700 LOCATE 17,45 :PRINT " (Xfmr. located ";J$;" LC tanks)"
1710 A$=INKEY$
1720 IF A$="+" THEN K1=K1*1.0099999904632568! :CLS :GOTO 980
1730 IF A$="-" THEN K1=K1/1.0099999904632568! :CLS :GOTO 980
1740 IF A$="u" THEN K2=K2*1.0099999904632568! :CLS :GOTO 980
1750 IF A$="d" THEN K2=K2/1.0099999904632568! :CLS :GOTO 980
1760 IF A$="m" THEN K3=K3*1.0099999904632568! :CLS :GOTO 980
1770 IF A$="l" THEN K3=K3/1.0099999904632568! :CLS :GOTO 980
1780 IF A$="b" THEN K4=K4*1.0099999904632568! :CLS :GOTO 980
1790 IF A$="s" THEN K4=K4/1.0099999904632568! :CLS :GOTO 3310
1800 IF A$="z" THEN GOSUB 1970:GOTO 3310
1810 IF A$="t" THEN LOCATE 25,1:GOTO 1830
1820 IF A$<>"t"THEN 1860
1830 PRINT "PRESS: 1 for LCL Tee, 2 for CLC Tee, 3 for LCL Pi, 4 for CLC Pi ";
1840 T$=INKEY$
1850 IF T$=""OR T$<"1"OR T$>"4"THEN 1840 :ELSE T=VAL(T$):GOSUB 2210:GOTO 3310
1860 IF A$="c"THEN 1870 :ELSE 2020
1870 LOCATE 22,1
1880 PRINT "Press number in ( ) to relocate transformer section to:"
1890 PRINT " (1) after LC tanks │(2) between LC tanks │(3) before LC tanks";
1900 PRINT " │(0) Start Over"
1910 :REM'Q2$=Q2$+"ENTER 3 "
1920 Q$=INKEY$:IF Q$=""OR Q$<"0" OR Q$>"3" THEN 1920
1930 IF Q$="0"THEN 90
1940 J=VAL(Q$):LOCA=J:GOSUB 2160:GOTO 3310
1950 GOTO 1920
1960 :REM'
1970 :REM'.....new Z0
1980 LOCATE 25,1:INPUT "ENTER: New Zo";Z0
1990 IF Z0<=0 THEN BEEP:GOTO 1980
2000 RETURN
2010 :REM'
2020 IF A$="q"THEN 2030 :ELSE 2050
2030 Q$=" MATCHBOX IMPEDANCE TRANSFORMER "
2040 COLOR 0,7:LOCATE 23,25:PRINT Q$:COLOR 7,0:GOSUB 5580:GOTO 90
2050 GOTO 1710
2060 :REM'
2070 :REM'.....subroutine to format display values
2080 Y$="#######"
2090 IF Y<10^5 THEN Y$="#####.#"
2100 IF Y<10^4 THEN Y$="####.##"
2110 IF Y<10^3 THEN Y$="###.###"
2120 IF Y<10^2 THEN Y$="##.####"
2130 IF Y<10 THEN Y$="#.#####"
2140 IF Y<1 THEN Y$="0.#####"
2150 RETURN
2160 :REM'.....subroutine for transformer location
2170 IF J=1 THEN J$="after"
2180 IF J=2 THEN J$="between"
2190 IF J=3 THEN J$="before"
2200 RETURN
2210 :REM'.....subroutine for type$
2220 IF T=1 THEN TYPE$="LCL TEE"
2230 IF T=2 THEN TYPE$="CLC TEE"
2240 IF T=3 THEN TYPE$="LCL Pi"
2250 IF T=4 THEN TYPE$="CLC Pi"
2260 RETURN
2270 :REM'.....subroutine to calculate Tee or Pi transformations
2280 :REM'.....for Ls/Cp/Ls Tee transformer
2290 X=X+W*LT :G=R/(R^2+X^2) :B=-X/(R^2+X^2) :B=B+W*CT :R=G/(G^2+B^2)
2300 X=-B/(G^2+B^2) :X=X+W*LT :RETURN
2310 :REM'.....for Cs/Lp/Cs Tee transformer
2320 X=X-1/W/CT :G=R/(R^2+X^2) :B=-X/(R^2+X^2)-1/W/LT :R=G/(G^2+B^2)
2330 X=-B/(G^2+B^2)-1/W/CT :RETURN
2340 :REM'.....for Lp/Cs/Lp Pi transformer
2350 G=R/(R^2+X^2) :B=-X/(R^2+X^2)-1/W/LT
2360 R=G/(G^2+B^2) :X=-B/(G^2+B^2)-1/W/CT :G=R/(R^2+X^2)
2370 B=-X/(R^2+X^2)-1/W/LT :R=G/(G^2+B^2) :X=-B/(G^2+B^2) :RETURN
2380 :REM'.....for Cp/Ls/Cp Pi transformer
2390 G=R/(R^2+X^2) :B=-X/(R^2+X^2)+W*CT
2400 R=G/(G^2+B^2) :X=-B/(G^2+B^2)+W*LT :G=R/(R^2+X^2)
2410 B=-X/(R^2+X^2)+W*CT :R=G/(G^2+B^2) :X=-B/(G^2+B^2) :RETURN
2420 :REM'.....subroutine to get antenna impedance values from dimensions
2430 PRINT
2440 INPUT "ENTER: Freq.(MHz) of low end of band................";FL
2450 INPUT "ENTER: Freq.(MHz) of high end of band...............";FH
2460 FC=SQR(FL*FH):WL=75/FC
2470 F$=" [Note: 1/4 wavelength at geometric mid-band (##.### MHz)"
2480 F$=F$+" is ##.### m.] "
2490 COLOR 0,7:PRINT USING F$;FC,WL:COLOR 7,0
2500 LN=CSRLIN
2510 MAX=0.30000001192092896!*300/FH   :REM'maximum length
2520 PRINT USING "ENTER: Monopole length in metres (max. ###.## m.)...";MAX;
2530 INPUT L
2540 H=10    :REM'number of steps
2550 IF L<=0.30000001192092896!*300/FH THEN 2630
2560 :REM'
2570 LOCATE ,22:COLOR 15,4
2580 PRINT USING " Length cannot exceed ##.### metres ";MAX
2590 COLOR 0,7:LOCATE 24,26:PRINT " Press any key to continue ";:COLOR 7,0
2600 IF INKEY$=""THEN 2600
2610 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 2520
2620 :REM'
2630 PRINT USING "ENTER: Monopole diameter in cm.(max. ##).....";4*L;:INPUT D
2640 IF D>(4*L)THEN 2630
2650 LL=L :DD=D     :REM'for final display description of monopole
2660 L=2*L :D=D/100 :STP=(FH-FL)/H
2670 LX=LOG(2*L/D)/LOG(10)
2680 CB=2*12.067399978637695!*L/2/(LX-0.7245000004768372!)*9.999999974752427e-07!
2690 CA=2*L*(0.890749990940094!/(LX^0.800599992275238!-0.8610000014305115!)-0.0254100002348423!)*9.999999974752427e-07!
2700 LA=0.05000000074505806!*L*(1.4812999963760376!*LX^1.0119999647140503!-0.6187999844551086!)
2710 RA=0.5!*(0.412880003452301!*LX^2+7.4075398445129395!*(2*L/D)^-0.023889999836683273!-7.2740797996521!)*1000
2720 M0=1+H :FOR N=1 TO M0 :F(N)=FL+STP*(N-1) :F=F(N) :W=TP*F
2730 GA=1/RA : B=W*CA-1/W/LA :R(N)=GA/(GA^2+B^2) :X(N)=-B/(GA^2+B^2)-1/W/CB
2740 NEXT N :GOTO 3320
2750 :REM'.....subroutine to load impedance data
2760 PRINT "Associate each data entry (freq, R, and X) with consecutive ";
2770 PRINT "numbers from 1 to";
2780 PRINT "10 maximum. Enter the data by first entering the data point ";
2790 PRINT "number. Then enter";
2800 PRINT "the F, R and X values. Data will be automatically ordered by ";
2810 PRINT "frequency. so data";
2820 PRINT "can be inserted. Change data by entering the data number then ";
2830 PRINT "entering the ";
2840 PRINT "correct data. When all the data is correct, press <ENTER>"
2850 PRINT
2860 IF N THEN 2880
2870 INPUT "ENTER: data number";A$:CLS:GOTO 2890
2880 INPUT "ENTER: data number or press <ENTER> if all data is correct";A$
2890 IF A$="" GOTO 3320 :ELSE N=VAL(A$)
2900 IF N>10 THEN PRINT "Too many data points. 10 maximum " :GOTO 2880
2910 IF N>M0 THEN M0=N
2920 INPUT "ENTER: Frequency (MHz)...";F(N)
2930 INPUT "ENTER: R (ohms)..........";R(N)
2940 INPUT "ENTER: X (ohms)..........";X(N)
2950 GOSUB 2960 :GOTO 2880
2960 :REM'.....Subroutine to sort frequency data
2970 FOR N=1 TO M0-1
2980 FOR M=1 TO M0-1
2990 IF F(M)>F(M+1) THEN SWAP F(M),F(M+1) :SWAP R(M),R(M+1) :SWAP X(M),X(M+1)
3000 NEXT M :NEXT N
3010 FOR N=1 TO M0 :PRINT N USING "#####.###  ";F(N);R(N);X(N) :NEXT N :RETURN
3020 :REM'.....subroutine to interpolate between values
3030 INPUT "ENTER: F(low)......MHz";FL
3040 INPUT "ENTER: R(low).....ohms";RL
3050 INPUT "ENTER: X(low).....ohms";XL
3060 PRINT
3070 INPUT "ENTER: F(mid)......MHz";FM
3080 INPUT "ENTER: R(mid).....ohms";RM
3090 INPUT "ENTER: X(mid).....ohms";XM
3100 IF FM<FL THEN 3160
3110 PRINT
3120 INPUT "ENTER: F(high).....MHz";FH
3130 INPUT "ENTER: R(high)....ohms";RH
3140 INPUT "ENTER: X(high)....ohms";XH
3150 IF FH<FM THEN 3160 :ELSE GOTO 3170
3160 PRINT:PRINT "Make sure that FL<FM<FH. Re-enter data." :PRINT :GOTO 3030
3170 :REM'PRINT :INPUT "ENTER: number of steps (max 10)";H :IF H>10 GOTO 2930
3180 H=10   :REM'number of steps
3190 STP=(FH-FL)/H :PL=RL :PM=RM :PH=RH :GOSUB 3260
3200 CR2=(AA-CC)/(DIFF) :CR1=AA+BB*CR2 :CR0=PM+CR2*FM*PM-CR1*FM
3210 PL=XL :PM=XM :PH=XH :GOSUB 3260
3220 CX2=(AA-CC)/(DIFF) :CX1=AA+BB*CX2 :CX0=PM+CX2*FM*PM-CX1*FM
3230 M0=1+(FH-FL)/STP :FOR N=1 TO M0 :F(N)=FL+STP*(N-1) :F=F(N)
3240 R(N)=(CR0+CR1*F)/(1+CR2*F)
3250 X(N)=(CX0+CX1*F)/(1+CX2*F) :NEXT N :GOTO 3310
3260 :REM'.....subroutine to get equation constants
3270 AA=(PL-PM)/(FL-FM) :BB=(PL*FL-PM*FM)/(FL-FM)
3280 CC=(PL-PH)/(FL-FH) :DD=(PL*FL-PH*FH)/(FL-FH) :DIFF=DD-BB
3290 IF DIFF=0 THEN DIFF=9.99999993922529e-09!
3300 RETURN
3310 :REM'.....find Lres or Cres
3320 FL=F(1) :RL=R(1) :XL=X(1) :FH=F(M0) :RH=R(M0) :XH=X(M0)
3330 WL=TP*FL :WH=TP*FH  :ZA=SQR(RL*RH)
3340 IF XL+XH<0 THEN FLAG=1 :GOSUB 3370 :REM'calculate inductive resonator
3350 IF XL+XH>0 THEN FLAG=2 :GOSUB 3400 :REM'calculate capacitive resonator
3360 IF XL+XH=0 THEN FLAG=3 :GOSUB 3430 :REM'no resonator required
3370 :REM'.....Subroutine to find Lres
3380 LRES=-(XL+XH)/(WL+WH)
3390 XL=XL+WL*LRES :XH=XH+WH*LRES :RETURN 3430
3400 :REM'.....Subroutine to find Cres
3410 CRES=(1/WL+1/WH)/(XL+XH)
3420 XL=XL-1/WL/CRES :XH=XH-1/WH/CRES :RETURN 3430
3430 :REM'.....find Lt and Ct
3440 WM=SQR(WL*WH) :ZT=SQR(ZA*Z0) :LT0=ZT/WM :CT0=LT0/ZT^2 :K=WH/WL
3450 :REM'.....find element values
3460 IF J=1 THEN GOSUB 3490 :GOTO 980
3470 IF J=2 THEN GOSUB 3760 :GOTO 980
3480 IF J=3 THEN GOSUB 4070 :GOTO 980
3490 :REM'.....transform section after LC tanks
3500 :REM'.....find Lp & Cp
3510 IF T=1 OR T=4 THEN COSL=1-WL^2*LT0*CT0 :KL=SQR(1-COSL^2)/COSL :W=WL
3520 IF T=2 OR T=3 THEN COSL=1-1/WL^2/LT0/CT0 :KL=-SQR(1-COSL^2)/COSL :W=WL
3530 ONT GOSUB 3720,3730,3740,3750 :ZTL=Z
3540 IF T=1 OR T=4 THEN COSH=1-WH^2*LT0*CT0 :KH=SQR(1-COSH^2)/COSH :W=WH
3550 IF T=2 OR T=3 THEN COSH=1-1/WH^2/LT0/CT0 :KH=-SQR(1-COSH^2)/COSH :W=WH
3560 ONT GOSUB 3720,3730,3740,3750 :ZTH=Z
3570 DENOM=ZTL^2+Z0^2*KL^2 :R2L=Z0*ZTL^2*(1+KL^2)/DENOM
3580 X2L=ZTL*KL*(Z0^2-ZTL^2)/DENOM
3590 DENOM=ZTH^2+Z0^2*KH^2 :R2H=Z0*ZTH^2*(1+KH^2)/DENOM
3600 X2H=ZTH*KH*(Z0^2-ZTH^2)/DENOM
3610 GL=RL/(RL^2+XL^2):BL=-XL/(RL^2+XL^2) :GH=RH/(RH^2+XH^2) :BH=-XH/(RH^2+XH^2)
3620 IF GL>1/R2L OR GH>1/R2H THEN 4280
3630 B1L=-SQR((GL-GL^2*R2L)/R2L) :B1H=SQR((GH-GH^2*R2H)/R2H)
3640 BPL=B1L-BL :BPH=B1H-BH
3650 LP=(K/WL-1/WH)/(BPH-K*BPL)
3660 CP=(BPH+1/WH/LP)/WH
3670 :REM'.....find Ls & Cs
3680 XL=-B1L/(GL^2+B1L^2)
3690 XH=-B1H/(GH^2+B1H^2)
3700 CS=(K/WL-1/WH)/(X2H-XH-K*(X2L-XL)) :LS=(X2H-XH+1/WH/CS)/WH
3710 RETURN
3720 Z=SQR(2*LT0/CT0*(1-W^2*LT0*CT0/2)) :RETURN
3730 Z=SQR(2*LT0/CT0*(1-1/2/W^2/LT0/CT0)) :RETURN
3740 Z=SQR(LT0/CT0/2/(1-1/2/W^2/LT0/CT0)) :RETURN
3750 Z=SQR(LT0/CT0/2/(1-W^2*LT0*CT0/2)) :RETURN
3760 :REM'.....transformer section between LC tanks
3770 :REM'.....find L1 & C1
3780 GL=RL/(RL^2+XL^2):BL=-XL/(RL^2+XL^2) :GH=RH/(RH^2+XH^2) :BH=-XH/(RH^2+XH^2)
3790 IF GL>1/ZA OR GH>1/ZA THEN 4280
3800 BXL=-BL-SQR((GL-ZA*GL^2)/ZA) :BXH=-BH+SQR((GH-ZA*GH^2)/ZA)
3810 IF T=1 OR T=4 THEN COSL=1-WL^2*LT0*CT0 :KL=SQR(1-COSL^2)/COSL :W=WL
3820 IF T=2 OR T=3 THEN COSL=1-1/WL^2/LT0/CT0 :KL=-SQR(1-COSL^2)/COSL :W=WL
3830 ONT GOSUB 3720,3730,3740,3750 :ZTL=Z
3840 IF T=1 OR T=4 THEN COSH=1-WH^2*LT0*CT0 :KH=SQR(1-COSH^2)/COSH :W=WH
3850 IF T=2 OR T=3 THEN COSH=1-1/WH^2/LT0/CT0 :KH=-SQR(1-COSH^2)/COSH :W=WH
3860 ONT GOSUB 3720,3730,3740,3750 :ZTH=Z
3870 YTL=1/ZTL :YTH=1/ZTH :UL=-2*YTL/KL :UH=-2*YTH/KH
3880 VL=YTL^2*((1-GL*Z0)/KL^2-GL*Z0)+GL^2
3890 IF UL^2<4*VL THEN 4280
3900 VH=YTH^2*((1-GH*Z0)/KH^2-GH*Z0)+GH^2
3910 IF UH^2<4*VH THEN 4280
3920 BSL=(-UL-SQR(UL^2-4*VL))/2 :BSH=(-UH+SQR(UH^2-4*VH))/2
3930 BXL=BSL-BL :BXH=BSH-BH
3940 L1=(K/WL-1/WH)/(BXH-K*BXL)
3950 C1=(BXH+1/WH/L1)/WH
3960 RL=GL/(GL^2+BSL^2) :XL=-BSL/(GL^2+BSL^2)
3970 RH=GH/(GH^2+BSH^2) :XH=-BSH/(GH^2+BSH^2)
3980 :REM'
3990 :REM'.....go through transform section
4000 LT=LT0 :CT=CT0 :GOSUB 4210
4010 :REM'.....find L2 and C2
4020 GL=RL/(RL^2+XL^2) :BL=-XL/(RL^2+XL^2)
4030 GH=RH/(RH^2+XH^2) :BH=-XH/(RH^2+XH^2)
4040 C2=(WL*BL-WH*BH)/(WH^2-WL^2)
4050 L2=1/(WL^2*C2+WL*BL)
4060 RETURN
4070 :REM'.....transform section before LC tanks
4080 :REM'.....go through transform section
4090 LT=LT0 :CT=CT0 :GOSUB 4210
4100 :REM'.....find Ls,Cs
4110 IF RL>Z0 OR RH>Z0 THEN 4280
4120 Y0=1/Z0 :XXL=-XL-SQR((RL-Y0*RL^2)/Y0) :XXH=-XH+SQR((RH-Y0*RH^2)/Y0)
4130 CS=(K/WL-1/WH)/(XXH-K*XXL)
4140 LS=(XXH+1/WH/CS)/WH :XL=XL+XXL :XH=XH+XXH
4150 :REM'.....find Lp, Cp
4160 BL=-XL/(RL^2+XL^2)
4170 BH=-XH/(RH^2+XH^2)
4180 CP=(WL*BL-WH*BH)/(WH^2-WL^2)
4190 LP=1/(WL^2*CP+WL*BL)
4200 RETURN
4210 :REM'.....run R and X thru xformer.
4220 W=WL :R=RL :X=XL :ONT GOSUB 2280,2310,2340,2380 :RL=R :XL=X
4230 W=WH :R=RH :X=XH :ONT GOSUB 2280,2310,2340,2380 :RH=R :XH=X :RETURN
4240 :REM'.....subroutines to print schematic
4250 LOCATE 13,1
4260 ONJ GOSUB 4320,4400,4480 :RETURN
4270 :REM'
4280 COLOR 15,0:PRINT " Try a location other than #";LOCA
4290 COLOR 7,0:GOTO 1880
4300 :REM'
4310 :REM'
4320 COLOR 0,7
4330 PRINT "  ───Lt──┬──Lt───Cs───Ls──┬──┬────────┐    "
4340 PRINT "         │                │  │        │    "
4350 PRINT " Zin     Ct               Lp Cp     Zload  "
4360 PRINT "         │                │  │        │    "
4370 PRINT "  ───────┴────────────────┴──┴────────┘    "
4380 COLOR 7,0:RETURN
4390 :REM'
4400 COLOR 0,7
4410 PRINT "  ────┬──┬───Lt──┬───Lt───┬──┬────────┐    "
4420 PRINT "      │  │       │        │  │        │    "
4430 PRINT " Zin  L2 C2      Ct       L1 C1     Zload  "
4440 PRINT "      │  │       │        │  │        │    "
4450 PRINT "  ────┴──┴───────┴────────┴──┴────────┘    "
4460 COLOR 7,0:RETURN
4470 :REM'
4480 COLOR 0,7
4490 PRINT "  ────┬──┬───Cs──Ls──Lt──┬──Lt────────┐    "
4500 PRINT "      │  │               │            │    "
4510 PRINT " Zin  Lp Cp              Ct         Zload  "
4520 PRINT "      │  │               │            │    "
4530 PRINT "  ────┴──┴───────────────┴────────────┘    "
4540 COLOR 7,0:RETURN
4550 :REM'
4560 LOCATE 13,1
4570 ONJ GOSUB 4590,4670,4750 :RETURN
4580 :REM'
4590 COLOR 0,7
4600 PRINT "  ───Ct──┬──Ct───Cs───Ls──┬──┬────────┐    "
4610 PRINT "         │                │  │        │    "
4620 PRINT " Zin     Lt               Lp Cp     Zload  "
4630 PRINT "         │                │  │        │    "
4640 PRINT "  ───────┴────────────────┴──┴────────┘    "
4650 COLOR 7,0:RETURN
4660 :REM'
4670 COLOR 0,7
4680 PRINT "  ────┬──┬───Ct──┬───Ct───┬──┬────────┐    "
4690 PRINT "      │  │       │        │  │        │    "
4700 PRINT " Zin  L2 C2      Lt       L1 C1     Zload  "
4710 PRINT "      │  │       │        │  │        │    "
4720 PRINT "  ────┴──┴───────┴────────┴──┴────────┘    "
4730 COLOR 7,0:RETURN
4740 :REM'
4750 COLOR 0,7
4760 PRINT "  ────┬──┬───Ls──Cs──Ct──┬──Ct────────┐    "
4770 PRINT "      │  │               │            │    "
4780 PRINT " Zin  Lp Cp              Lt         Zload  "
4790 PRINT "      │  │               │            │    "
4800 PRINT "  ────┴──┴───────────────┴────────────┘    "
4810 COLOR 7,0:RETURN
4820 :REM'
4830 LOCATE 13,1
4840 ONJ GOSUB 4860,4940,5020 :RETURN
4850 :REM'
4860 COLOR 0,7
4870 PRINT "  ────┬──Lt──┬───Cs──-Ls──┬──┬────────┐    "
4880 PRINT "      │      │            │  │        │    "
4890 PRINT " Zin  Ct     Ct           Lp Cp     Zload  "
4900 PRINT "      │      │            │  │        │    "
4910 PRINT "  ────┴──────┴────────────┴──┴────────┘    "
4920 COLOR 7,0:RETURN
4930 :REM'
4940 COLOR 0,7
4950 PRINT "  ────┬──┬────┬──Lt──┬────┬──┬────────┐    "
4960 PRINT "      │  │    │      │    │  │        │    "
4970 PRINT " Zin  L2 C2   Ct     Ct   L1 C1     Zload  "
4980 PRINT "      │  │    │      │    │  │        │    "
4990 PRINT "  ────┴──┴────┴──────┴────┴──┴────────┘    "
5000 COLOR 7,0:RETURN
5010 :REM'
5020 COLOR 0,7
5030 PRINT "  ────┬──┬───Cs──Ls───┬──Lt──┬────────┐    "
5040 PRINT "      │  │            │      │        │    "
5050 PRINT " Zin  Lp Cp           Ct     Ct     Zload  "
5060 PRINT "      │  │            │      │        │    "
5070 PRINT "  ────┴──┴────────────┴──────┴────────┘    "
5080 COLOR 7,0:RETURN
5090 :REM'
5100 LOCATE 13,1
5110 ONJ GOSUB 5130,5210,5290 :RETURN
5120 :REM'
5130 COLOR 0,7
5140 PRINT "  ────┬──Ct──┬───Cs───Ls──┬──┬────────┐    "
5150 PRINT "      │      │            │  │        │    "
5160 PRINT " Zin  Lt     Lt           Lp Cp     Zload  "
5170 PRINT "      │      │            │  │        │    "
5180 PRINT "  ────┴──────┴────────────┴──┴────────┘    "
5190 COLOR 7,0:RETURN
5200 :REM'
5210 COLOR 0,7
5220 PRINT "  ────┬──┬────┬──Ct──┬────┬──┬────────┐    "
5230 PRINT "      │  │    │      │    │  │        │    "
5240 PRINT " Zin  L2 C2   Lt     Lt   L1 C1     Zload  "
5250 PRINT "      │  │    │      │    │  │        │    "
5260 PRINT "  ────┴──┴────┴──────┴────┴──┴────────┘    "
5270 COLOR 7,0:RETURN
5280 :REM'
5290 COLOR 0,7
5300 PRINT "  ────┬──┬───Cs──Ls───┬──Ct──┬────────┐    "
5310 PRINT "      │  │            │      │        │    "
5320 PRINT " Zin  Lp Cp           Lt     Lt     Zload  "
5330 PRINT "      │  │            │      │        │    "
5340 PRINT "  ────┴──┴────────────┴──────┴────────┘    "
5350 COLOR 7,0:RETURN
5360 :REM'--------------program notes---------------
5370 :REM'The program is based on the matching technique suggested by KM5KG in the
5380 :REM'Sept/Oct QEX p12. Also section 43-7, Jasic "Antenna Engineering Handbook"
5390 :REM'To keep the program as simple as possible, coil Q was not considered.
5400 :REM'To determine actual performance, use the values in a network analysis
5410 :REM'program with realistic Q values to get final SWR and insertion loss,
5420 :REM'For dipoles, if you want to use antenna dimensions rather than actual
5430 :REM'impedance values, run the program for one half of the dipole, then
5440 :REM'combine the matching circuit with its mirror image. Thus,if the dipole is
5450 :REM'2 meters long, enter 1 meter and get 1/2 the final matching circuit.
5460 :REM'Tweaking is provided to improve the overall SWR. (+/-) changes the values
5470 :REM'of the Tee or Pi transformer so that the SWR spread can be centered about
5480 :REM'Z0. (u/d) changes the LC values of the first tank, (m/l) changes the LC
5490 :REM'values of the second tank and b/s changes the resonating reactor.
5500 :REM'Four different transformer configurations are provided. Single section
5510 :REM'transformers are only accurate at band center; away from Fo, the error
5520 :REM'depends on the configuration. Depending on the load, one configuration
5530 :REM'may be somewhat better than another.
5540 :REM'There is no such thing as a universal matching scheme. Each load has its
5550 :REM'own unique characteristic. This scheme seems OK for simple antennas and
5560 :REM'RL and RC circuits, but other more complex loads may cause hang-ups.
5570 :REM'
5580 :REM'.....PRT
5590 KEY OFF:GOSUB 5660:LOCATE 25,5:COLOR 0,2
5600 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
5610 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
5620 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 5620 :ELSE GOSUB 5660
5630 IF Z$="3"THEN RETURN
5640 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
5650 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 5590
5660 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
