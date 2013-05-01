10 :REM'RCLOAD2 - 27 JUL 2010
20 KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS:COLOR 15,2
80 PRINT " MATCHING into an R/C LOAD"TAB(61)"by R.J.Dehoney IEEE ";
90 COLOR 7,0
100 :REM'.....start
110 GOTO 130
120 GOSUB 11140:LOCATE 23:GOTO 260
130 LOCATE 3:GOTO 160
140 REM CLS'---------------LEVY3G.BAS,RJD,6/11/10-------------
150 REM PRINT "        --------------Matching into an R C Load------------------"
160 PRINT "This program automates the procedure given by Levy in `Explicit Formulas"
170 PRINT "For Chebyshev Impedance-Matching Networks...` in Proc IEE, June 1964. It"
180 PRINT "enables you to design networks to deliver constant power to a specified RC"
190 PRINT "load from various sources. You can select lowpass or bandpass configurations."
200 PRINT "Most of the lowpass circuits will require a transformer--bandpass circuits can"
210 PRINT "obtain the required transformation with tee or pi LC equivalents. Values are"
220 PRINT "given for all the possible circuits." :PRINT
230 PRINT "Vout/Vin will show a ripple across the pass band. Levy's procedure finds the"
240 PRINT "values giving the lowest VSWR for a given Wc*RL*C. Examples are provided."
250 PRINT
260 LOCATE 23:PRINT  ".....Press 1 to continue or 0 to exit......"
270 A$=INKEY$:IF A$=""THEN 270
280 IF A$="0"THEN CLS:RUN GO$
290 IF A$="1"THEN CLS:GOTO 310
300 GOTO 270
310 MHZ=1000000.0! :PI=4*ATN(1) :TP=2*PI :PF=9.999999960041972e-13!
320 DEF FNHS(X)=(EXP(X)-EXP(-X))/2 :DEF FNIHS(X)=LOG(X+SQR(X^2+1))
330 DEF FNHC(X)=(EXP(X)+EXP(-X))/2 :DEF FNIHC(X)=LOG(X+SQR(X^2-1))
340 DEF FNIHCT(X)=1/2*LOG((X+1)/(X-1))
350 PRINT
360 PRINT "Press `c` to match a resistive source into a given RC load."
370 PRINT "Press `h' to match from a high impedance source with a given shunt C into the          RC load."
380 PRINT "Press `d' to match a known RC source to the RC load."
390 PRINT "Press `e' for examples of program use."
400 A$=INKEY$ :IF A$="" THEN 400 :ELSE CLS
410 IF ASC(A$)<97 THEN 360
420 IF A$="h" THEN 2800
430 IF A$="d" THEN 3810
440 IF A$="e" THEN 1920
450 IF A$<>"c" THEN 360
460 DEF FNHC(X)=(EXP(X)+EXP(-X))/2 :DEF FNIHC(X)=LOG(X+SQR(X^2-1))
470 DEF FNIHCT(X)=1/2*LOG((X+1)/(X-1))
480 PRINT "This option requires you to enter the load shunt C and R, and the pass band"
490 PRINT "frequencies. It then prints out a list of number of poles N, VSWR and ripple."
500 PRINT "After you choose a desired N, it finds the required circuit values including"
510 PRINT "the input R. If you would rather specify a value for RS, use the `d' option."
520 PRINT :INPUT "Enter RL, ohms ",RL
530 INPUT "Enter CL, pF ",CL :CL=CL*PF
540 INPUT "Enter the highest pass band frequency, FH, MHz ",FH
550 INPUT "Enter the lowest pass band frequency, MHz ",FL :IF FL>FH THEN SWAP       FL,FH
560 FC=FH-FL :WC=TP*FC*MHZ :G(1)=RL*CL*WC
570 PRINT " N   SWR max   SWR min     SWR ave   Ripple dB"
580 FOR N=2 TO 7 :GOSUB 650
590 PRINT USING " #    #.###       #.###      #.###    ##.###";N;SWRMAX;SWRMIN;SWRAVE;RIP
600 NEXT N :PRINT :INPUT "Enter N or to change frequencies enter 0 ",N
610 IF N=0 THEN 540
620 CLS :PRINT "   ------------ Low Pass Circuit-------------"
630 ONN-1 GOSUB 1080,1220,1360,1500,1640,1780 :REM'get schematic
640 GOSUB 650 :GOTO 750
650 B=-0.0008999999845400453! :DB=0.0010000000474974513!
660 B=B+DB :Z=FNHS(B)+2/G(1)*SIN(PI/2/N) :A=FNIHS(Z)
670 X1=FNHS(A*N)/FNHC(A*N)/FNHC(A)
680 X2=FNHS(B*N)/FNHC(B*N)/FNHC(B)
690 ER=ABS(X1/X2-X2/X1) :IF ER<9.999999747378752e-05! THEN 710
700 IF X1>X2 THEN 660 :ELSE B=B-DB :DB=DB/2 :GOTO 660
710 RHOMAX=FNHC(N*B)/FNHC(N*A) :SWRMAX=(RHOMAX+1)/(1-RHOMAX)
720 RHOMIN=FNHS(N*B)/FNHS(N*A) :SWRMIN=(1+RHOMIN)/(1-RHOMIN)
730 SWRAVE=(2+RHOMAX+RHOMIN)/(2-RHOMAX-RHOMIN)
740 RIP=10*LOG((1-RHOMIN^2)/(1-RHOMAX^2))/LOG(10) :RETURN
750 PRINT USING "SWR max=#.###  SWR min=#.###    SWR ave=#.###  Ripple=##.#### dB";SWRMAX;SWRMIN;SWRAVE;RIP
760 X=FNHS(A) :Y=FNHS(B)
770 FOR R=1 TO N-1
780 NUM=4*SIN((2*R-1)/2/N*PI)*SIN((2*R+1)/2/N*PI)
790 DENOM=X^2+Y^2+SIN(R*PI/N)^2-2*X*Y*COS(R*PI/N)
800 G(R+1)=1/G(R)*NUM/DENOM
810 NEXT R
820 S=G(N)/G(1)*(X+Y)/(X-Y)
830 RS=S :IF (-1)^N<1 THEN RS=1/S
840 PRINT USING "RS=###.## ohms    RL=###.## ohms   FC=###.## MHz";RS*RL;RL;FC
850 PRINT :FOR P=1 TO N STEP 2 :C(P)=G(P)/RL/WC :NEXT P
860 FOR P=2 TO N STEP 2 :L(P)=G(P)*RL/WC :NEXT P
870 FOR P=1 TO N :IF (-1)^P<1 THEN 880 :ELSE 890
880 PRINT USING "C#=##.####^^^^ farads";P;C(P) :GOTO 900
890 PRINT USING "L#=##.####^^^^ henries";P;L(P) :GOTO 900
900 NEXT P
910 IF FL<>0 THEN CLS :GOTO 950
920 PRINT :PRINT :PRINT "Press any key to continue"
930 A$=INKEY$ :IF A$="" THEN 930 :ELSE CLS
940 IF FL=0 THEN 140
950 PRINT "         -------------Band Pass Network----------"
960 ONN-1 GOSUB 1150,1290,1430,1570,1710,1850 :REM'get bandpass schmatic
970 F0=SQR(FH*FL) :W0=TP*F0*MHZ
980 FOR P=1 TO N STEP 2 :L(P)=WC/G(P)*RL/W0^2 :NEXT P
990 FOR P=2 TO N STEP 2 :C(P)=WC/G(P)/RL/W0^2 :NEXT P
1000 FOR P=1 TO N :IF (-1)^P<1 THEN 1010 :ELSE 1020
1010 PRINT USING "C#=##.####^^^^ farads, L#=##.####^^^^ henries";P;C(P);P;       L(P) :GOTO 1030
1020 PRINT USING "L#=##.####^^^^ henries, C#=##.####^^^^ farads";P;L(P);P;       C(P) :GOTO 1030
1030 NEXT P :PRINT
1040 PRINT "RL="RL"  RS="RS*RL" FH="FH"MHz FL="FL"MHz" :PRINT
1050 PRINT "     VSWRmax="SWRMAX" VSWRmin="SWRMIN"  Ripple="RIP"dB"
1060 LOCATE 23:PRINT :PRINT :PRINT "Press any key"
1070 A$=INKEY$ :IF A$="" THEN 1070 :ELSE 120
1080 PRINT ""
1090 PRINT "           ┌──┬─L2──RS─┐"
1100 PRINT "           │  │        │"
1110 PRINT "          RL C1       Vin"
1120 PRINT "           │  │        │"
1130 PRINT "           └──┴────────┘"
1140 PRINT "                N=2 " :RETURN
1150 PRINT ""
1160 PRINT "           ┌──┬──┬─L2─C2─RS─┐"
1170 PRINT "           │  │  │          │"
1180 PRINT "          RL C1 L1         Vin"
1190 PRINT "           │  │  │          │"
1200 PRINT "           └──┴──┴──────────┘"
1210 PRINT "                N=2 " :RETURN
1220 PRINT ""
1230 PRINT "           ┌──┬─L2─┬-RS─┐"
1240 PRINT "           │  │    │    │"
1250 PRINT "          RL C1   C3   Vin"
1260 PRINT "           │  │    │    │"
1270 PRINT "           └──┴────┴────┘"
1280 PRINT "                N=3 " :RETURN
1290 PRINT ""
1300 PRINT "           ┌──┬──┬─L2─C2─┬──┬─RS─┐"
1310 PRINT "           │  │  │       │  │    │"
1320 PRINT "          RL C1 L1      C3 L3   Vin"
1330 PRINT "           │  │  │       │  │    │"
1340 PRINT "           └──┴──┴───────┴──┴────┘"
1350 PRINT "                N=3 " :RETURN
1360 PRINT ""
1370 PRINT "           ┌──┬─L2─┬-L4─RS─┐"
1380 PRINT "           │  │    │       │"
1390 PRINT "          RL C1   C3      Vin"
1400 PRINT "           │  │    │       │"
1410 PRINT "           └──┴────┴───────┘"
1420 PRINT "                N=4 " :RETURN
1430 PRINT ""
1440 PRINT "           ┌──┬──┬─L2─C2─┬──┬─L4─C4─RS─┐"
1450 PRINT "           │  │  │       │  │          │"
1460 PRINT "          RL C1 L1      C3 L3         Vin"
1470 PRINT "           │  │  │       │  │          │"
1480 PRINT "           └──┴──┴───────┴──┴──────────┘"
1490 PRINT "                N=4 " :RETURN
1500 PRINT ""
1510 PRINT "           ┌──┬─L2─┬-L4─┬─RS─┐"
1520 PRINT "           │  │    │    │    │"
1530 PRINT "          RL C1   C3   C5   Vin"
1540 PRINT "           │  │    │    │    │"
1550 PRINT "           └──┴────┴────┴────┘"
1560 PRINT "                   N=5 " :RETURN
1570 PRINT ""
1580 PRINT "           ┌──┬──┬─L2─C2─┬──┬-L4─C4─┬──┬─RS─┐"
1590 PRINT "           │  │  │       │  │       │  │    │"
1600 PRINT "          RL C1 L1      C3 L3      C5 L5   Vin"
1610 PRINT "           │  │  │       │  │       │  │    │"
1620 PRINT "           └──┴──┴───────┴──┴───────┴──┴────┘"
1630 PRINT "                         N=5 " :RETURN
1640 PRINT ""
1650 PRINT "           ┌──┬─L2─┬-L4─┬─L6─RS─┐"
1660 PRINT "           │  │    │    │       │"
1670 PRINT "          RL C1   C3   C5      Vin"
1680 PRINT "           │  │    │    │       │"
1690 PRINT "           └──┴────┴────┴───────┘"
1700 PRINT "                    N=6 " :RETURN
1710 PRINT ""
1720 PRINT "           ┌──┬──┬─L2─C2─┬──┬─L4─C4─┬──┬─L6─C6─RS─┐"
1730 PRINT "           │  │  │       │  │       │  │          │"
1740 PRINT "          RL C1 L1      C3 L3      C5 L5         Vin"
1750 PRINT "           │  │  │       │  │       │  │          │"
1760 PRINT "           └──┴──┴───────┴──┴───────┴──┴──────────┘"
1770 PRINT "                           N=6 " :RETURN
1780 PRINT ""
1790 PRINT "           ┌──┬─L2─┬-L4─┬─L6─┬─RS─┐"
1800 PRINT "           │  │    │    │    │    │"
1810 PRINT "          RL C1   C3   C5   C7   Vin"
1820 PRINT "           │  │    │    │    │    │"
1830 PRINT "           └──┴────┴────┴────┴────┘"
1840 PRINT "                    N=7 " :RETURN
1850 PRINT ""
1860 PRINT "      ┌──┬──┬─L2─C2─┬──┬─L4─C4─┬──┬─L6─C6─┬──┬─RS─┐"
1870 PRINT "      │  │  │       │  │       │  │       │  │    │"
1880 PRINT "     RL C1 L1      C3 L3      C5 L5      C7 L7   Vin"
1890 PRINT "      │  │  │       │  │       │  │       │  │    │"
1900 PRINT "      └──┴──┴───────┴──┴───────┴──┴───────┴──┴────┘"
1910 PRINT "                       N=7 " :RETURN
1920 PRINT "            -----------------Example---------------"
1930 PRINT "Let's assume we need to drive into a load consisting of a parallel RC with RL="
1940 PRINT "100 ohms and C1=100pf. We would like a flat gain from 20 to 50 MHz. Using the"
1950 PRINT "`c' option, we enter the RL, C1, FH, and FL values at the prompts then get a"
1960 PRINT "chart showing VSWR vs N. We select N=3 and then get this screen:"
1970 PRINT ""
1980 PRINT "     ───── ┌──┬──┬─L2─C2─┬──┬─RS─┐"
1990 PRINT "       │   │  │  │       │  │    │"
2000 PRINT "     Vout RL C1 L1      C3  L3  Vin"
2010 PRINT "       │   │  │  │       │  │    │"
2020 PRINT "     ───── └──┴──┴───────┴──┴────┘"
2030 PRINT ""
2040 PRINT "   C1=1.0000E-10 farafds  L1=2.533029E-7 henries"
2050 PRINT "   L2=4.1763E-7 henries  C2=6.065246E-11 farads"
2060 PRINT "   C3=6.8052E-11 farads  L3=3.722196E-7 henries"
2070 PRINT ""
2080 PRINT " RL=100  RS=62.67825  FH=50 MHz  FL=20 MHz"
2090  PRINT :PRINT " .....Press any key....."
2100 A$=INKEY$ :IF A$="" THEN 2100 :ELSE CLS
2110 PRINT "With Vin=2 volts, a circuit analysis program gives these values for Vout: " :PRINT
2120 PRINT "Frequency 20    21.2    25    31.6    40    47.14    50 MHz"
2130 PRINT "Output  1.209  1.2294  1.209 1.2294  1.209  1.2294  1.209 Volts"
2140 PRINT
2150 :REM'IF A$="b" THEN 895
2160 PRINT "So, in the pass band, the output ripples around 1.2192 volts. This corresponds"
2170 PRINT "to an output power of 14.86 mw. The matched power in is Vin^2/4/RS or 15.954 mw"
2180 PRINT "so the reflected power is 15.954-14.86 or 1.0895 mw or a reflection coefficient"
2190 PRINT "of SQR(1.0895/15.954)=.261325 or a VSWR of 1.707, which is what we expected." :PRINT
2200 PRINT :PRINT "Press `b' to see the previous screen or `c' to continue."
2210 A$=INKEY$ :IF A$="" THEN 2210 :ELSE CLS :IF A$="b" THEN 1920
2220 PRINT "If we are not happy with a 62.68 ohm source impedance and we'd rather see Rs="
2230 PRINT "50 ohms, we can modify our circuit to include a transformer. We need a turns"
2240 PRINT "ratio of sqr(50/63.38) or 0.893142. Since C1 is fixed, we have to use the L"
2250 PRINT "form of transformer. We choose the pi circuit, as shown below:"
2260 PRINT "                                     1:M"
2270 PRINT "   ┌──┬──┬─L2─C2─┬──┬─RS─┐     *─┬─L2─)(──*      *─┬─LB─┬─*"
2280 PRINT "   │  │  │       │  │    │       │    )(           │    │"
2290 PRINT "  RL C1 L1      C3 L3   Vin     L1    )(          LA   LC"
2300 PRINT "   │  │  │       │  │    │       │    )(           │    │"
2310 PRINT "   └──┴──┴───────┴──┴────┘     *─┴────)(──*      *─┴────┴──*"
2320 PRINT "      Original Circuit          Transformer  Transformer Equivalent"
2330 PRINT:PRINT "where LA=L1*L2*M/(L2*M-L1*(1-M)), LB=L2*M, and LC=L2*M^2/(1-M)"
2340 PRINT "Note that this equivalence depends on the values of L1, L2, and M. If L2 had"
2350 PRINT "been less than L1*(1-M)/M, LA would have been negative." :PRINT
2360 PRINT "Press `b' to see previous screen or `c' to continue."
2370 A$=INKEY$ :IF A$="" THEN 2370 :ELSE CLS :PRINT
2380 IF A$="b" THEN 2110
2390 PRINT "We add the transformer to the original circuit: "
2400 PRINT "                    1:0.893142"
2410 PRINT "        ┌──┬─*─┬──L2─)(──*──C2a─┬───┬─RSa─┐   C2a=C2/M^2=7.60339e-11"
2420 PRINT "        │  │   │     )(         │   │     │   C3a=C3/M^2=8.531e-11"
2430 PRINT "       RL C1  L1     )(        C3a L3a   Vin  L3a=L3*M^2=2.969206e-7"
2440 PRINT "        │  │   │     )(         │   │     │   RSa=RS*M^2=50"
2450 PRINT "        └──┴─*─┴─────)(──*──────┴───┴─────┘"
2460 PRINT "   Original Circuit with the transformer inserted."
2470 PRINT :PRINT
2480 PRINT "          ┌──┬───*─┬─LB─┬─*──C2a─┬───┬─RSa─┐"
2490 PRINT "          │  │     │    │        │   │     │   LA=2.731224E-7"
2500 PRINT "         RL C1    LA   LC       C3a L3a   Vin  LB=3.730029E-7"
2510 PRINT "          │  │     │    │        │   │     │   LC=3.117637E-7"
2520 PRINT "          └──┴───*─┴────┴─*──────┴───┴─────┘"
2530 PRINT "    Circuit with L1, L2, and transformer replaced by the pi network."
2540 PRINT ""
2550 PRINT ""
2560 PRINT ""
2570 PRINT ""
2580 PRINT "Press `b' to see previous screen or `c' to continue."
2590 A$=INKEY$ :IF A$="" THEN 2590 :ELSE CLS
2600 IF A$="b" THEN 2220
2610 PRINT ""
2620 PRINT "  ┌──┬──┬─LB─┬─C2a─┬───┬─RSa─┐      Final Circuit Values"
2630 PRINT "  │  │  │    │     │   │     │   LA=2.731224E-7  LB=3.730029E-7"
2640 PRINT " RL C1 LA   LC    C3a L3a   Vin  LC=3.117637E-7 C2a=7.60339E-11"
2650 PRINT "  │  │  │    │     │   │     │   L3a=2.969206E-7 C3a=8.531E-11"
2660 PRINT "  └──┴──┴────┴─────┴───┴─────┘   RSa=50  RL=100  C1=100E-12"
2670 PRINT "          Final Circuit"
2680 PRINT ""
2690 PRINT "With all the black magic circuit conversions, we need to reassure ourselves"
2700 PRINT "that we still have a circuit, so we use our circuit analysis program again"
2710 PRINT "and find that all is well! With 2 volts in, we get these voltages out:"
2720 PRINT "Freq, MHz 20    21.35    24.96   31.65   40.00     47.2   50.0"
2730 PRINT "Output 1.35393  1.3765  1.35393  1.3765  1.35393  1.3765 1.35393"
2740 PRINT ""
2750 PRINT "The average power out is 18.64 mw. The matched power in is 20 mw, so the"
2760 PRINT "reflection coefficient Rho=0.261 and the VSWR is 1.707, as it was before."
2770 PRINT
2780 LN=CSRLIN:PRINT "Press `b' to see previous screen or `c' to continue."
2790 A$=INKEY$ :IF A$="" THEN 2790 :ELSE IF A$="b" THEN 2390 :ELSE 120
2800 :REM'-----------------High impedance source-----------
2810 PRINT "A common problem is to match a current source with a shunt C, such as a FET,"
2820 PRINT "transistor, or vacuum tube, into an RC load. If we use odd order networks, we"
2830 PRINT "can absorb the source and load C's into the network over the band of interest."
2840 PRINT "The following section finds the necessary circuit values, given the source"
2850 PRINT "capacitance, CS, the load RL and CL and the allowable passband ripple. It is a"
2860 PRINT "characteristic of these circuits that their bandwidth increases as the ripple"
2870 PRINT "increases, but the allowable source capacitance decreases." :PRINT
2880 INPUT "Enter source capacitance, pF ",C1 :C1=C1*PF :IF C1=0 THEN 2880
2890 INPUT "Enter load capacitance, pF ",CL :CL=CL*PF :IF CL=0 THEN 2890
2900 INPUT "Enter load resistance, RL, ohms ",RL :IF RL=0 THEN 2900
2910 INPUT "Enter desired passband ripple, dB ",RIP :IF RIP=0 THEN 2910
2920 PRINT "   N     Bandwidth, MHz"
2930 FOR N=3 TO 9 STEP 2
2940 X1=SQR(10^(RIP/10)) :X2=FNIHCT(X1)/N :X=FNHS(X2) :REM'calculate X
2950 GG(N,N)=SIN(PI/2/N)/X :BW(N)=GG(N,N)/CL/TP/RL :REM'calculate BW
2960 G1=TP*BW(N)*RL*C1
2970 FOR R=N-1 TO 1 STEP -1                     :REM'-------------------
2980 NUM=4*SIN((2*R-1)/2/N*PI)*SIN((2*R+1)/2/N*PI)  :REM'Find G values
2990 DENOM=2*X^2*(1-COS(R*PI/N))+SIN(R*PI/N)^2
3000 GG(R,N)=1/GG(R+1,N)*NUM/DENOM
3010 NEXT R                                     :REM'---------------
3020 IF G1<GG(1,N) THEN PRINT USING "   #       ###.###";N;BW(N)/MHZ
3030 NEXT N :IF G1>GG(1,N-2) THEN PRINT "Requirements too severe. Decrease CS or increase CL" :GOTO 2880
3040 INPUT "Enter desired value of N or to change ripple, enter 0 ",N :IF N=0 THEN CLS :GOTO 2910 :ELSE IF N<3 OR N>9 THEN 3040
3050 INPUT "Do you want a low pass or band pass circuit? (l/b) ",A$
3060 IF A$="l" THEN CLS :PRINT :GOTO 3150
3070 INPUT "Enter desired center frequency, MHz ",F0 :CLS :PRINT
3080 PRINT USING "F0=###.## MHz  BW=###.## MHz   Ripple=#.### dB";F0;BW(N)/MHZ;RIP
3090 ON(N-1)/2 GOSUB 3300,3450,3590,3730
3100 FOR P=1 TO N :IF (-1)^P>0 THEN 3120
3110 PRINT USING "C#=##.####^^^^ farads     L#=##.####^^^^ henries";P;                   GG(P,N)/BW(N)/TP/RL;P;BW(N)*RL/GG(P,N)/F0^2/MHZ^2/TP :GOTO 3130
3120 PRINT USING "L#=##.####^^^^ henries    C#=##.####^^^^ farads";P;                   GG(P,N)*RL/BW(N)/TP;P;BW(N)/RL/GG(P,N)/F0^2/MHZ^2/TP
3130 NEXT P :GOTO 3210
3140 PRINT "RL="RL :GOTO 3210
3150 PRINT USING "BW=###.## MHz   Ripple=#.### dB";BW(N)/MHZ;RIP
3160 ON(N-1)/2 GOSUB 3230,3380,3520,3660
3170 FOR P=1 TO N :IF (-1)^P>0 THEN 3190
3180 PRINT USING "C#=##.####^^^^ farads";P;GG(P,N)/BW(N)/TP/RL :GOTO 3200
3190 PRINT USING "L#=##.####^^^^ henries";P;GG(P,N)*RL/BW(N)/TP
3200 NEXT P :PRINT "RL="RL
3210 PRINT :PRINT "Press any key"
3220 A$=INKEY$ :IF A$="" THEN 3220 :ELSE 120
3230 PRINT ""
3240 PRINT "         IS>──┬─L2─┬───┐"
3250 PRINT "              │    │   │"
3260 PRINT "              C1   C3  RL"
3270 PRINT "              │    │   │"
3280 PRINT "              └────┴───┘"
3290 PRINT "                N=3 " :RETURN
3300 PRINT ""
3310 PRINT "         IS>──┬──┬─L2─C2─┬──┬──┐"
3320 PRINT "              │  │       │  │  │"
3330 PRINT "              C1 L1      C3 L3 RL"
3340 PRINT "              │  │       │  │  │"
3350 PRINT "              └──┴───────┴──┴──┘"
3360 PRINT "                N=3 " :RETURN
3370 PRINT ""
3380 PRINT ""
3390 PRINT "          IS>───┬─L2─┬-L4─┬───┐"
3400 PRINT "                │    │    │   │"
3410 PRINT "                C1   C3   C5  RL"
3420 PRINT "                │    │    │   │"
3430 PRINT "                └────┴────┴───┘"
3440 PRINT "                   N=5 " :RETURN
3450 PRINT ""
3460 PRINT "          IS>──┬──┬─L2─C2─┬──┬-L4─C4─┬──┬───┐"
3470 PRINT "               │  │       │  │       │  │   │"
3480 PRINT "               C1 L1      C3 L3      C5 L5  RL"
3490 PRINT "               │  │       │  │       │  │   │"
3500 PRINT "               └──┴───────┴──┴───────┴──┴───┘"
3510 PRINT "                         N=5 " :RETURN
3520 PRINT ""
3530 PRINT "           IS>──┬─L2─┬-L4─┬─L6─┬───┐"
3540 PRINT "                │    │    │    │   │"
3550 PRINT "                C1   C3   C5   C7  RL"
3560 PRINT "                │    │    │    │   │"
3570 PRINT "                └────┴────┴────┴───┘"
3580 PRINT "                    N=7 " :RETURN
3590 PRINT ""
3600 PRINT "      IS>──┬──┬─L2─C2─┬──┬─L4─C4─┬──┬─L6─C6─┬──┬───┐"
3610 PRINT "           │  │       │  │       │  │       │  │   │"
3620 PRINT "           C1 L1      C3 L3      C5 L5      C7 L7  RL"
3630 PRINT "           │  │       │  │       │  │       │  │   │"
3640 PRINT "           └──┴───────┴──┴───────┴──┴───────┴──┴───┘"
3650 PRINT "                       N=7 " :RETURN
3660 PRINT ""
3670 PRINT "           IS>──┬─L2─┬-L4─┬─L6─┬─L8─┬───┐"
3680 PRINT "                │    │    │    │    │   │"
3690 PRINT "                C1   C3   C5   C7   C9  RL"
3700 PRINT "                │    │    │    │    │   │"
3710 PRINT "                └────┴────┴────┴────┴───┘"
3720 PRINT "                    N=9 " :RETURN
3730 PRINT ""
3740 PRINT "  IS>─┬──┬─L2─C2─┬──┬─L4─C4─┬──┬─L6─C6─┬──┬─L8─C8──┬──┬───┐"
3750 PRINT "      │  │       │  │       │  │       │  │        │  │   │"
3760 PRINT "     C1 L1      C3 L3      C5 L5      C7 L7       C9 L9  RL"
3770 PRINT "      │  │       │  │       │  │       │  │        │  │   │"
3780 PRINT "      └──┴───────┴──┴───────┴──┴───────┴──┴────────┴──┴───┘"
3790 PRINT "                       N=9 " :RETURN
3800 :REM'---------------------------RC source and load------------------------
3810 PRINT "This section finds the circuit values for a network matching an RC source to"
3820 PRINT "an RC load. The program first finds G(1) and G(N) as 2pi*BW*R*C using the"
3830 PRINT "appropriate R & C. It then asks you to select N, then finds the G values and"
3840 PRINT "the load resistance. It next denormalizes and prints out the values. To get"
3850 PRINT "the desired load R & C, you must use an appropriate transformer. If you have a"
3860 PRINT "low pass network, this must be an actual transformer; with a bandpass circuit,"
3870 PRINT "a Shea L or C tee or pi transformer is often possible. To see these circuits,"
3880 PRINT "press any key after the transformer version is shown. Tee equivalents have been"
3890 PRINT "calculated. To get the pi equivalents, you can use the well known tee to pi"
3900 PRINT "transformations."
3910 PRINT :FLAG=0
3920 INPUT "Enter RS, ohms ",RS :RS0=RS :RSI=RS :IF RS=0 THEN 3920
3930 INPUT "Enter CS, pF ",CS :CS=CS*PF :IF CS=0 THEN 3930
3940 INPUT "Enter RL, ohms ",RL :RL0=RL :RLI=RL :IF RL=O THEN 3940
3950 INPUT "Enter CL, pF ",CL :CL=CL*PF :IF CL=0 THEN 3950
3960 INPUT "Enter desired bandwidth, MHz ",BW :BWR=BW*MHZ*TP :IF BW=0 THEN 3960
3970 G1=RS*CS*BWR:GN=RL*CL*BWR :IF G1<GN THEN SWAP G1,GN :SWAP RS,RL :SWAP RS0,RL0 :SWAP CS,CL :FLAG=1
3980 PRINT " N  Ripple, dB   SWRmin"
3990 FOR N=3 TO 7 STEP 2
4000 X=(1/GN+1/G1)*SIN(PI/2/N) :A=FNIHS(X)
4010 Y=(1/GN-1/G1)*SIN(PI/2/N) :B=FNIHS(Y)
4020 RHOMAX=FNHC(N*B)/FNHC(N*A) :RHOMIN=FNHS(N*B)/FNHS(N*A)
4030 RIP=10*LOG((1-RHOMIN^2)/(1-RHOMAX^2))/LOG(10) :SWRMIN=(1+RHOMIN)/(1-RHOMIN)
4040 PRINT USING " #   ##.###      ##.## ";N;RIP;SWRMIN :NEXT N
4050 INPUT "Choose a value for N or enter 0 to change bandwidth ",N
4060 IF N=0 THEN 3960 :ELSE IF N/2=INT(N/2) OR N<3 OR N>7 THEN 4050
4070 G(1)=G1 :G(N)=GN
4080 X=(1/GN+1/G1)*SIN(PI/2/N) :A=FNIHS(X)
4090 Y=(1/GN-1/G1)*SIN(PI/2/N) :B=FNIHS(Y)
4100 RHOMAX=FNHC(N*B)/FNHC(N*A) :RHOMIN=FNHS(N*B)/FNHS(N*A)
4110 RIP=10*LOG((1-RHOMIN^2)/(1-RHOMAX^2))/LOG(10) :SWRMIN=(1+RHOMIN)/(1-RHOMIN)
4120 FOR R=1 TO N-2
4130 NUM=4*SIN((2*R-1)/2/N*PI)*SIN((2*R+1)/2/N*PI)
4140 DENOM=X^2+Y^2+SIN(R*PI/N)^2-2*X*Y*COS(R*PI/N)
4150 G(R+1)=1/G(R)*NUM/DENOM :NEXT R
4160 R=(1-RHOMIN)/(1+RHOMIN) :G(N)=G(N)/R :RL=R*RS
4170 PRINT "Low pass or Band pass? (l/b)."
4180 A$=INKEY$ :IF A$="" THEN 4180 :ELSE W0=1
4190 IF A$="b" THEN INPUT "Enter center frequency, F0, MHz ",F0 :W0=TP*F0*MHZ :      GOTO 4210
4200 IF A$<>"l" THEN 4170
4210 :REM'PRINT "RS="RSI"  RL="RLI
4220 FOR P=1 TO N STEP 2 :C(P)=G(P)/RS/BWR :L(P)=1/C(P)/W0^2 :NEXT P
4230 FOR P=2 TO N-1 STEP 2 :L(P)=G(P)*RS/BWR :C(P)=1/L(P)/W0^2 :NEXT P
4240 M=SQR(RL0/RL)
4250 C(N)=C(N)*RL/RL0
4260 IF A$="b" THEN 4340 :REM'print band pass values
4270 CLS :IF FLAG=0 THEN ON(N-1)/2 GOSUB 4470,4610,4750
4280 IF FLAG=1 THEN ON(N-1)/2 GOSUB 4890,5030,5170
4290 PRINT " RS="RSI"  RL="RLI"   Fc="BW"  SWRmin="SWRMIN"  Ripple="RIP
4300 FOR P=1 TO N
4310 IF (-1)^P<0 THEN PRINT USING "  C(#)=##.#####^^^^ ";P;C(P)
4320 IF (-1)^P>0 THEN PRINT USING "  L(#)=##.#####^^^^ ";P;L(P)
4330 NEXT P :GOTO 4450
4340 CLS :REM'----------------printout for bandpass circuit---------------
4350 IF FLAG=0 THEN ON(N-1)/2 GOSUB 4540,4680,4820
4360 IF FLAG=1 THEN ON(N-1)/2 GOSUB 4960,5100,5240
4370 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
4380 FOR P=1 TO N :IF FLAG=1 THEN Q=N+1-P :ELSE Q=P
4390 IF (-1)^P<0 THEN PRINT USING "  C#=##.#####^^^^   L#=##.####^^^^";P;C(Q);P;L(Q)
4400 IF (-1)^P>0 THEN PRINT USING "  L#=##.#####^^^^   C#=##.####^^^^";P;L(Q);P;C(Q)
4410 NEXT P :PRINT "Press any key to continue ",C$
4420 A$=INKEY$ :IF A$="" THEN 4420
4430 IF FLAG=0 THEN GOSUB 5310
4440 IF FLAG=1 THEN GOSUB 8220
4450 LOCATE 23:PRINT "Press any key"
4460 A$=INKEY$ :IF A$="" THEN 4460 :ELSE 120
4470 PRINT "                   1:M     M="M
4480 PRINT "       ┌──RS──┬─L2─)(──┬────┐"
4490 PRINT "       │      │    )(  │    │"
4500 PRINT "      VS     C1    )(  C3   RL"
4510 PRINT "       │      │    )(  │    │"
4520 PRINT "       └──────┴────)(──┴────┘"
4530 PRINT "                N=3 " :RETURN
4540 PRINT "                           1:M    M="M
4550 PRINT "       ┌──RS──┬──┬─L2─C2─┬─)(─┬────┐"
4560 PRINT "       │      │  │       │ )( │    │"
4570 PRINT "       VS    C1 L1      L3 )( C3   RL"
4580 PRINT "       │      │  │       │ )( │    │"
4590 PRINT "       └──────┴──┴───────┴─)(─┴────┘"
4600 PRINT "                N=3 " :RETURN
4610 PRINT "                        1:M    M="M
4620 PRINT "       ┌──RS──┬─L2─┬-L4─)(──┬────┐"
4630 PRINT "       │      │    │    )(  │    │"
4640 PRINT "       VS    C1   C3    )( C5   RL"
4650 PRINT "       │      │    │    )(  │    │"
4660 PRINT "       └──────┴────┴────)(──┴────┘"
4670 PRINT "                   N=5 " :RETURN
4680 PRINT "                                      1:M   M="M
4690 PRINT "        ┌──RS─┬──┬─L2─C2─┬──┬-L4─C4─┬──)(─┬────┐"
4700 PRINT "        │     │  │       │  │       │  )( │    │"
4710 PRINT "        VS   C1 L1      C3 L3      L5  )( C5   RL"
4720 PRINT "        │     │  │       │  │       │  )( │    │"
4730 PRINT "        └─────┴──┴───────┴──┴───────┴──)(─┴────┘"
4740 PRINT "                         N=5 " :RETURN
4750 PRINT "                             1:M    M="M
4760 PRINT "        ┌──RS─┬─L2─┬-L4─┬─L6─)(──┬───┐"
4770 PRINT "        │     │    │    │    )(  │   │"
4780 PRINT "        VS   C1   C3   C5    )(  C7  RL"
4790 PRINT "        │     │    │    │    )(  │   │"
4800 PRINT "        └─────┴────┴────┴────)(──┴───┘"
4810 PRINT "                    N=7 " :RETURN
4820 PRINT "                                             1:M    M="M
4830 PRINT "   ┌─RS──┬──┬─L2─C2─┬──┬─L4─C4─┬──┬─L6─C6─┬──)(─┬───┐"
4840 PRINT "   │     │  │       │  │       │  │       │  )( │   │"
4850 PRINT "   VS   C1 L1      C3 L3      C5 L5      L7  )( C7  RL"
4860 PRINT "   │     │  │       │  │       │  │       │  )( │   │"
4870 PRINT "   └─────┴──┴───────┴──┴───────┴──┴───────┴──))─┴───┘"
4880 PRINT "                       N=7 " :RETURN
4890 PRINT "                M:1     M="M
4900 PRINT "       ┌──RS──┬─)(─L2──┬────┐"
4910 PRINT "       │      │ )(     │    │"
4920 PRINT "      VS     C3 )(     C1   RL"
4930 PRINT "       │      │ )(     │    │"
4940 PRINT "       └──────┴─)(─────┴────┘"
4950 PRINT "                N=3 " :RETURN
4960 PRINT "                M:1    M="M
4970 PRINT "       ┌──RS──┬─)(─┬─L2─C2─┬──┬────┐"
4980 PRINT "       │      │ )( │       │  │    │"
4990 PRINT "       VS    C1 )( L1     L3  C3   RL"
5000 PRINT "       │      │ )( │       │  │    │"
5010 PRINT "       └──────┴─)(─┴───────┴──┴────┘"
5020 PRINT "                N=3 " :RETURN
5030 PRINT "                M:1   M="M
5040 PRINT "       ┌──RS──┬─)(─L2─┬-L4───┬────┐"
5050 PRINT "       │      │ )(    │      │    │"
5060 PRINT "       VS    C1 )(   C3     C5   RL"
5070 PRINT "       │      │ )(    │      │    │"
5080 PRINT "       └──────┴─)(────┴──────┴────┘"
5090 PRINT "                   N=5 " :RETURN
5100 PRINT "                M:1    M="M
5110 PRINT "        ┌──RS─┬─)(─┬─L2─C2─┬──┬-L4─C4─┬───┬────┐"
5120 PRINT "        │     │ )( │       │  │       │   │    │"
5130 PRINT "        VS   C1 )( L1     C3 L3      L5  C5   RL"
5140 PRINT "        │     │ )( │       │  │       │   │    │"
5150 PRINT "        └─────┴─)(─┴───────┴──┴───────┴───┴────┘"
5160 PRINT "                         N=5 " :RETURN
5170 PRINT "                M:1      M="M
5180 PRINT "        ┌──RS─┬─)(─L2─┬-L4─┬─L6─┬──┐"
5190 PRINT "        │     │ )(    │    │    │  │"
5200 PRINT "        VS   C1 )(   C3   C5   C7  RL"
5210 PRINT "        │     │ )(    │    │    │  │"
5220 PRINT "        └─────┴─)(────┴────┴────┴──┘"
5230 PRINT "                    N=7 " :RETURN
5240 PRINT "           M:1       M="M
5250 PRINT "   ┌─RS──┬─)(─┬─L2─C2─┬──┬─L4─C4─┬──┬─L6─C6─┬──┬───┐"
5260 PRINT "   │     │ )( │       │  │       │  │       │  │   │"
5270 PRINT "   VS   C1 )( L1     C3 L3      C5 L5      L7  C7  RL"
5280 PRINT "   │     │ )( │       │  │       │  │       │  │   │"
5290 PRINT "   └─────┴─)(─┴───────┴──┴───────┴──┴───────┴──┴───┘"
5300 PRINT "                       N=7 " :RETURN
5310 :REM'-----subroutine to check tee/pi transformer equivalent---FLAG=0
5320 IF M>1 THEN ON(N-1)/2 GOTO 5350,5490,5950
5330 IF M<1 THEN ON(N-1)/2 GOTO 6780,6930,7390
5340 :REM'-----------N=3--M>1--FLAG=0---------------
5350 LS=L(2) : LP=L(3) :LA=LS-LP*(M-1) :IF LA<0 THEN 6760 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
5360 PRINT :PRINT "    Transformer replaced with pi network"
5370 PRINT "       ┌──RS──┬──┬─C2──LA─┬─LC─┬────┐"
5380 PRINT "       │      │  │        │    │    │"
5390 PRINT "       VS    C1 L1       LB    C3   RL"
5400 PRINT "       │      │  │        │    │    │"
5410 PRINT "       └──────┴──┴────────┴────┴────┘"
5420 PRINT "                N=3"
5430 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
5440 PRINT "      C1="C(1)"   L1="L(1)
5450 PRINT "      C2="C(2)"   LA="LA"   LB="LB""
5460 PRINT "      LC="LC"   C3="C(3)
5470 PRINT:PRINT "Press (b) to see previous screen or any other key to restart."
5480 A$=INKEY$ :IF A$="" THEN 5480 :ELSE IF A$="b" GOTO 4340 :ELSE 140
5490 :REM'           --------N=5---M>1---FLAG=0------------
5500 LP=L(5) :LS=L(4) :LA=LS-LP*(M-1) :IF LA<0 THEN 5650 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
5510 PRINT :PRINT "    Transformer replaced with tee network, 1st circuit"
5520 PRINT "        ┌──RS─┬──┬─L2─C2─┬──┬-C4─LA─┬──LC─┬────┐"
5530 PRINT "        │     │  │       │  │       │     │    │"
5540 PRINT "        VS   C1 L1      C3 L3      LB     C5   RL"
5550 PRINT "        │     │  │       │  │       │     │    │"
5560 PRINT "        └─────┴──┴───────┴──┴───────┴─────┴────┘"
5570 PRINT "                      N=5"
5580 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
5590 PRINT "   C1="C(1)"   L1="L(1)" L2="L(2)
5600 PRINT "   C2="C(2)"   C3="C(3)"   L3="L(3)
5610 PRINT "   C4="C(4)"   LA="LA"   LB="LB
5620 PRINT "   LC="LC"    C5="C(5)
5630 PRINT:PRINT "Press (b) to see previous screen or any other key to continue"
5640 A$=INKEY$ :IF A$="" THEN 5640 :ELSE IF A$="b" GOTO 4340
5650 LP=L(3) :LS=L(2) :LA=LS-LP*(M-1) :IF LA<0 THEN 5800 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
5660 PRINT :PRINT "    Transformer replaced with tee network, 2nd circuit"
5670 PRINT "        ┌──RS─┬──┬─C2─LA─┬─LC─┬-L4a─C4a─┬───┬────┐"
5680 PRINT "        │     │  │       │    │         │   │    │"
5690 PRINT "        VS   C1 L1      LB   C3a       L5a C5   RL"
5700 PRINT "        │     │  │       │    │         │   │    │"
5710 PRINT "        └─────┴──┴───────┴────┴─────────┴───┴────┘"
5720 PRINT "                         N=5"
5730 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
5740 PRINT "   C1="C(1)"   L1="L(1)"  C2="C(2)
5750 PRINT "   LA="LA"   LB="LB"   LC="LC
5760 PRINT "   C3a"C(3)/M^2"   L4a="L(4)*M^2"   C4a="C(4)/M^2
5770 PRINT "   L5a="L(5)*M^2"    C5="C(5)
5780 PRINT :PRINT "Press (b) to see previous screen or any other key to continue"
5790 A$=INKEY$ :IF A$="" THEN 5790 :ELSE IF A$="b" GOTO 5500
5800 CS=C(2) :CP=C(3) :CA=CP*CS/(CP-CS*(M-1)) :IF CA<0 THEN 5960 :ELSE CB=CP/M :CC=CP/M/(M-1) :CLS
5810 PRINT :PRINT "    Transformer replaced with tee network , 3rd circuit"
5820 PRINT "        ┌──RS─┬──┬─L2─CA─┬─CC─┬-L4a─C4a─┬───┬───┐"
5830 PRINT "        │     │  │       │    │         │   │   │"
5840 PRINT "        VS   C1 L1      CB   L3a       L5a  C5  RL"
5850 PRINT "        │     │  │       │    │         │   │   │"
5860 PRINT "        └─────┴──┴───────┴────┴─────────┴───┴───┘"
5870 PRINT "                         N=5"
5880 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
5890 PRINT "   C1="C(1)"   L1="L(1)"  L2="L(2)
5900 PRINT "   CA="CA"   CB="CB"   CC="CC
5910 PRINT "   L3a="L(3)*M^2"   L4a="L(4)*M^2"   C4a="C(4)/M^2
5920 PRINT "   L5a="L(5)*M^2"    C5="C(5)
5930 PRINT:PRINT "Press (b) to see previous screen or any other key to restart."
5940 A$=INKEY$ :IF A$="" THEN 5940 :ELSE IF A$="b" GOTO 5650 :ELSE RETURN 140
5950 :REM'-------------- N=7 --M>1---FLAG=0--------------
5960 LP=L(7) :LS=L(6) :LA=LS-LP*(M-1) :IF LA<0 THEN 6120 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
5970 PRINT :PRINT "    Transformer replaced with tee network, 1st circuit"
5980 PRINT "        ┌──RS─┬──┬─L2─C2─┬──┬-C4─L4─┬──┬─C6─LA─┬─LC──┬──┐"
5990 PRINT "        │     │  │       │  │       │  │       │     │  │"
6000 PRINT "        VS   C1 L1      C3 L3      C5 L5      LB     C7 RL"
6010 PRINT "        │     │  │       │  │       │  │       │     │  │"
6020 PRINT "        └─────┴──┴───────┴──┴───────┴──┴───────┴─────┴──┘"
6030 PRINT "                      N=7"
6040 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
6050 PRINT "   C1="C(1)"   L1="L(1)"   C2="C(2)
6060 PRINT "   L2="L(2)"   C3="C(3)"   L3="L(3)
6070 PRINT "   C4="C(4)"   L4="L(4)"   C5="C(5)
6080 PRINT "   L5="L(5)"   C6="C(6)"   LA="LA
6090 PRINT "   LB="LB"    LC="LC"    C7="C(7)
6100 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
6110 A$=INKEY$ :IF A$="" THEN 6110 :ELSE IF A$="b" GOTO 4340
6120 LP=L(5) :LS=L(4) :LA=LS-LP*(M-1) :IF LA<0 THEN 6280 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
6130 PRINT :PRINT "    Transformer replaced with tee network, 2nd circuit"
6140 PRINT "        ┌──RS─┬──┬─C2─L2─┬──┬-C4─LA─┬─LC─┬─C6a─L6a─┬──┬───┐"
6150 PRINT "        │     │  │       │  │       │    │         │  │   │"
6160 PRINT "        VS   C1 L1      L3 C3      LB    C5a      L7a C7  RL"
6170 PRINT "        │     │  │       │  │       │    │         │  │   │"
6180 PRINT "        └─────┴──┴───────┴──┴───────┴────┴─────────┴──┴───┘"
6190 PRINT "                         N=7"
6200 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
6210 PRINT "   C1="C(1)"   L1="L(1)"   C2="C(2)
6220 PRINT "   L2="L(2)"   L3="L(3)"   C3="C(3)
6230 PRINT "   C4="C(4)"   LA="LA"   LB="LB""
6240 PRINT "   LC="LC"   C5a="C(5)/M^2"   C6a="C(6)/M^2
6250 PRINT "   L6a="L(6)*M^2"   L7a="L(7)*M^2"   C7="C(7)
6260 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
6270 A$=INKEY$ :IF A$="" THEN 6270 :ELSE IF A$="b" GOTO 5960
6280 LP=L(3) :LS=L(2) :LA=LS-LP*(M-1) :IF LA<0 THEN 6540 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
6290 PRINT :PRINT "    Transformer replaced with tee network , 3rd circuit"
6300 PRINT "        ┌──RS─┬──┬─C2─LA─┬─LC─┬-L4a─C4a─┬───┬──C6a─L6a─┬───┬──┐"
6310 PRINT "        │     │  │       │    │         │   │          │   │  │"
6320 PRINT "        VS   C1 L1      LB   C3a       L5a  C5a       L7a C7  RL"
6330 PRINT "        │     │  │       │    │         │   │          │   │  │"
6340 PRINT "        └─────┴──┴───────┴────┴─────────┴───┴──────────┴───┴──┘"
6350 PRINT "                         N=7"
6360 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
6370 PRINT "   C1="C(1)"   L1="L(1)"    C2="C(2)
6380 PRINT "   LA="LA"   LB="LB"   LC="LC""
6390 PRINT "   C3a="C(3)/M^2"   L4a="L(4)*M^2"   C4a="C(4)/M^2
6400 PRINT "   L5a="L(5)*M^2"     C5a="C(5)/M^2"   C6a="C(6)/M^2
6410 PRINT "   L6a="L(6)*M^2"   L7a="L(7)*M^2"    C7="C(7)
6420 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
6430 A$=INKEY$ :IF A$="" THEN 6430 :ELSE IF A$="b" GOTO 6120
6440 CS=C(4) :CP=C(5) :CA=CP*CS/(CP-CS*(M-1)) :IF CA<0 THEN 6600 :ELSE CB=CP/M :CC=CP/M/(M-1) :CLS
6450 PRINT :PRINT "    Transformer replaced with tee network , 4th circuit"
6460 PRINT "        ┌──RS─┬──┬─C2─L2─┬───┬-L4─CA─┬─CC──┬──C6a─L6a─┬───┬──┐"
6470 PRINT "        │     │  │       │   │       │     │          │   │  │"
6480 PRINT "        VS   C1 L1      L3  C3      CB    L5a        L7a C7  RL"
6490 PRINT "        │     │  │       │   │       │     │          │   │  │"
6500 PRINT "        └─────┴──┴───────┴───┴───────┴─────┴──────────┴───┴──┘"
6510 PRINT "                         N=7"
6520 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
6530 PRINT "   C1="C(1)"   L1="L(1)"    C2="C(2)
6540 PRINT "   L2="L(2)"   L3="L(3)"    C3="C(3)
6550 PRINT "   L4="L(4)"   CA="CA"   CB="CB""
6560 PRINT "   CC="CC"     L5a="L(5)*M^2"   C6a="C(6)/M^2
6570 PRINT "   L6a="L(6)*M^2"   L7a="L(7)*M^2"    C7="C(7)
6580 PRINT:PRINT "Press (b) to see previous screen or any other key to see next circuit."
6590 A$=INKEY$ :IF A$="" THEN 6590 :ELSE IF A$="b" GOTO 6280
6600 CS=C(2) :CP=C(3) :CA=CP*CS/(CP-CS*(M-1)) :IF CA<0 THEN 6760 :ELSE CB=CP/M :CC=CP/M/(M-1) :CLS
6610 PRINT :PRINT "    Transformer replaced with tee network , 5th circuit"
6620 PRINT "        ┌──RS─┬──┬─L2─CA─┬─CC─┬-L4a─C4a─┬───┬──C6a─L6a─┬───┬──┐"
6630 PRINT "        │     │  │       │    │         │   │          │   │  │"
6640 PRINT "        VS   C1 L1      CB   L3a       L5a  C5a       L7a C7  RL"
6650 PRINT "        │     │  │       │    │         │   │          │   │  │"
6660 PRINT "        └─────┴──┴───────┴────┴─────────┴───┴──────────┴───┴──┘"
6670 PRINT "                         N=7"
6680 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
6690 PRINT "   C1="C(1)"   L1="L(1)"    L2="L(2)
6700 PRINT "   CA="CA"   CB="CB"    CC="CC
6710 PRINT "   L3a="L(3)*M^2"   L4a="L(4)*M^2"   C4a="C(4)/M^2
6720 PRINT "   L5a="L(5)*M^2"   C5a="C(5)/M^2"   C6a="C(6)/M^2
6730 PRINT "   L6a="L(6)*M^2"   L7a="L(7)*M^2"    C7="C(7)
6740 PRINT :PRINT "Press (b) to see previous screen or any other key to restart."
6750 A$=INKEY$ :IF A$="" THEN 6750 :ELSE IF A$="b" GOTO 6440 :ELSE RETURN 140
6760 PRINT :PRINT "Cannot use tee or pi networks to replace transformer. Press any key. "
6770 WHILE+ INKEY$="":WEND :RETURN 140
6780 :REM'------------------N=3---M<1----FLAG=0-------------
6790 LS=L(2) : LP=L(1) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 8200 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
6800 PRINT :PRINT "    Transformer replaced with tee network"
6810 PRINT "       ┌──RS──┬─LA─┬─LC──C2a──┬───┬───┐"
6820 PRINT "       │      │    │          │   │   │"
6830 PRINT "      VS     C1   LB         L3a  C3  RL"
6840 PRINT "       │      │    │          │   │   │"
6850 PRINT "       └──────┴────┴──────────┴───┴───┘"
6860 PRINT "                      N=3"
6870 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
6880 PRINT "      C1="C(1)"    LA="LA"   LB="LB
6890 PRINT "      LC="LC"   C2a="C(2)/M^2""
6900 PRINT "      L3a="L(3)*M^2"   C3="C(3)
6910 PRINT:PRINT "Press (b) to see previous screen or any other key to restart."
6920 A$=INKEY$ :IF A$="" THEN 6920 :ELSE IF A$="b" GOTO 4340 :ELSE 140
6930 :REM'   ---------- N=5---M<1----FLAG=0--------------
6940 LS=L(4) : LP=L(3) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 8200 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
6950 PRINT :PRINT "    Transformer replaced with tee network, 1st circuit"
6960 PRINT "        ┌──RS─┬──┬─L2─C2─┬──LA─┬─LC──C4a─┬───┬───┐"
6970 PRINT "        │     │  │       │     │         │   │   │"
6980 PRINT "       VS    C1 L1      C3    LB        L5a  C5  RL"
6990 PRINT "        │     │  │       │     │         │   │   │"
7000 PRINT "        └─────┴──┴───────┴─────┴─────────┴───┴───┘"
7010 PRINT "                      N=5"
7020 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
7030 PRINT "   C1="C(1)"   L1="L(1)"    L2="L(2)
7040 PRINT "   C2="C(2)"   C3="C(3)"   LA="LA
7050 PRINT "   LB="LB"   LC="LC"   C4a="C(4)/M^2
7060 PRINT "   L5a="L(5)*M^2"    C5="C(5)
7070 PRINT:PRINT "Press (b) to see previous screen or any other key to continue"
7080 A$=INKEY$ :IF A$="" THEN 7080 :ELSE IF A$="b" GOTO 4340
7090 LS=L(2) : LP=L(1) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 8200 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
7100 PRINT :PRINT "    Transformer replaced with tee network, 2nd circuit"
7110 PRINT "        ┌──RS─┬─LA─┬─LC──C2a─┬───┬-L4a─C4a─┬───┬────┐"
7120 PRINT "        │     │    │         │   │         │   │    │"
7130 PRINT "       VS    C1   LB        L3a C3a       L5a C5   RL"
7140 PRINT "        │     │    │         │   │         │   │    │"
7150 PRINT "        └─────┴────┴─────────┴───┴─────────┴───┴────┘"
7160 PRINT "                         N=5"
7170 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
7180 PRINT "   C1="C(1)"   LA="LA"  LB="LB
7190 PRINT "   LC="LC"   C2a="C(2)/M^2"   L3a="L(3)*M^2
7200 PRINT "   C3a"C(3)/M^2"   L4a="L(4)*M^2"   C4a="C(4)/M^2
7210 PRINT "   L5a="L(5)*M^2"    C5="C(5)
7220 PRINT :PRINT "Press (b) to see previous screen or any other key to continue"
7230 A$=INKEY$ :IF A$="" THEN 7230 :ELSE IF A$="b" GOTO 6940
7240 CS=C(4) :CP=C(3) :CC=CP*CS/(CP*M^2-CS*M*(1-M)) :IF CC<0 THEN 8200 :ELSE          CB=CP/M :CA=CP/(1-M) :CLS
7250 PRINT :PRINT "    Transformer replaced with tee network , 3rd circuit"
7260 PRINT "        ┌──RS─┬──┬─L2─C2─┬─CA─┬-CC──L4a─┬───┬───┐"
7270 PRINT "        │     │  │       │    │         │   │   │"
7280 PRINT "        VS   C1 L1      L3   CB        L5a  C5  RL"
7290 PRINT "        │     │  │       │    │         │   │   │"
7300 PRINT "        └─────┴──┴───────┴────┴─────────┴───┴───┘"
7310 PRINT "                         N=5"
7320 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
7330 PRINT "   C1="C(1)"   L1="L(1)"  L2="L(2)
7340 PRINT "   C2="C(2)"   L3="L(3)"   CA="CA""
7350 PRINT "   CB="CB"   CC="CC"     L4a="L(4)*M^2""
7360 PRINT "   L5a="L(5)*M^2"    C5="C(5)
7370 PRINT:PRINT "Press (b) to see previous screen or any other key to restart"
7380 A$=INKEY$ :IF A$="" THEN 7380 :ELSE IF A$="b" GOTO 7090 :ELSE RETURN 140
7390 :REM'-------------- N=7 ------------------
7400 LS=L(6) : LP=L(5) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 8200 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
7410 PRINT :PRINT "    Transformer replaced with tee network, 1st circuit"
7420 PRINT "        ┌──RS─┬──┬─L2─C2─┬──┬-C4─L4─┬──LA─┬─LC──C6a─┬──┬──┐"
7430 PRINT "        │     │  │       │  │       │     │         │  │  │"
7440 PRINT "        VS   C1 L1      C3 L3      C5    LB        L7a C7 RL"
7450 PRINT "        │     │  │       │  │       │     │         │  │  │"
7460 PRINT "        └─────┴──┴───────┴──┴───────┴─────┴─────────┴──┴──┘"
7470 PRINT "                      N=7"
7480 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
7490 PRINT "   C1="C(1)"   L1="L(1)"   C2="C(2)
7500 PRINT "   L2="L(2)"   C3="C(3)"   L3="L(3)
7510 PRINT "   C4="C(4)"   L4="L(4)"   C5="C(5)
7520 PRINT "   LA="LA"   LB="LB"   LC="LC
7530 PRINT "   C6a="C(6)/M^2"   L7a="L(7)*M^2"    C7="C(7)
7540 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
7550 A$=INKEY$ :IF A$="" THEN 7550 :ELSE IF A$="b" GOTO 4340
7560 LS=L(4) : LP=L(3) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 8200 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
7570 PRINT :PRINT "    Transformer replaced with tee network, 2nd circuit"
7580 PRINT "        ┌──RS─┬──┬─C2─L2─┬─LA─┬─LC─-C4a──┬───┬─C6a─L6a─┬──┬───┐"
7590 PRINT "        │     │  │       │    │          │   │         │  │   │"
7600 PRINT "       VS    C1 L1      C3   LB         L5a C5a      L7a  C7  RL"
7610 PRINT "        │     │  │       │    │          │   │         │  │   │"
7620 PRINT "        └─────┴──┴───────┴────┴──────────┴───┴─────────┴──┴───┘"
7630 PRINT "                         N=7"
7640 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
7650 PRINT "   C1="C(1)"   L1="L(1)"   C2="C(2)
7660 PRINT "   L2="L(2)"   C3="C(3)"  LA="LA
7670 PRINT "   LB="LB"   LC="LC"   C4a="C(4)/M^2
7680 PRINT "   L5a="L(5)*M^2"   C5a="C(5)/M^2"   C6a="C(6)/M^2
7690 PRINT "   L6a="L(6)*M^2"   L7a="L(7)*M^2"   C7="C(7)
7700 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
7710 A$=INKEY$ :IF A$="" THEN 7710 :ELSE IF A$="b" GOTO 7400
7720 LS=L(2) : LP=L(1) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 8200 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
7730 PRINT :PRINT "    Transformer replaced with tee network , 3rd circuit"
7740 PRINT "        ┌──RS─┬─LA─┬─LC──C2a─┬───┬-C4a─L4a─┬───┬─C6a──L6a─┬───┬──┐"
7750 PRINT "        │     │    │         │   │         │   │          │   │  │"
7760 PRINT "       VS    C1   LB        C3a L3a       L5a C5a        L7a C7  RL"
7770 PRINT "        │     │    │         │   │         │   │          │   │  │"
7780 PRINT "        └─────┴────┴─────────┴───┴─────────┴───┴──────────┴───┴──┘"
7790 PRINT "                         N=7"
7800 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
7810 PRINT "   C1="C(1)"   LA="LA"   LB="LB
7820 PRINT "   LC="LC"   C2a="C(2)/M^2"   C3a="C(3)/M^2
7830 PRINT "   L3a="L(3)*M^2"   C4a="C(4)/M^2"   L4a="L(4)*M^2
7840 PRINT "   L5a="L(5)*M^2"   C5a="C(5)/M^2"   C6a="C(6)/M^2
7850 PRINT "   L6a="L(6)*M^2"   L7a="L(7)*M^2"    C7="C(7)
7860 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
7870 A$=INKEY$ :IF A$="" THEN 7870 :ELSE IF A$="b" GOTO 7560
7880 CS=C(6) :CP=C(5) :CC=CP*CS/(CP*M^2-CS*M*(1-M)) :IF CC<0 THEN 8200 :ELSE          CB=CP/M :CA=CP/(1-M) :CLS
7890 PRINT :PRINT "    Transformer replaced with tee network , 4th circuit"
7900 PRINT "        ┌──RS─┬──┬─C2─L2─┬───┬-L4─C4─┬──CA─┬─CC──L6a─┬───┬──┐"
7910 PRINT "        │     │  │       │   │       │     │         │   │  │"
7920 PRINT "        VS   C1 L1      L3  C3       L5   CB        L7a C7  RL"
7930 PRINT "        │     │  │       │   │       │     │         │   │  │"
7940 PRINT "        └─────┴──┴───────┴───┴───────┴─────┴─────────┴───┴──┘"
7950 PRINT "                         N=7"
7960 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
7970 PRINT "   C1="C(1)"   L1="L(1)"    C2="C(2)
7980 PRINT "   L2="L(2)"   L3="L(3)"    C3="C(3)
7990 PRINT "   L4="L(4)"   C4="C(4)"    L5="L(5)""
8000 PRINT "   CA="CA"   CB="CB"    CC="CC""
8010 PRINT "   L6a="L(6)*M^2"   L7a="L(7)*M^2"    C7="C(7)
8020 PRINT:PRINT "Press (b) to see previous screen or any other key to see next circuit."
8030 A$=INKEY$ :IF A$="" THEN 8030 :ELSE IF A$="b" GOTO 7720
8040 CS=C(4) :CP=C(3) :CC=CP*CS/(CP*M^2-CS*M*(1-M)) :IF CC<0 THEN 8200 :ELSE          CB=CP/M :CA=CP/(1-M) :CLS
8050 PRINT :PRINT "    Transformer replaced with tee network , 5th circuit"
8060 PRINT "        ┌──RS─┬──┬─C2─L2─┬─CA─┬-CC─L4a─┬───┬──C6a─L6a─┬───┬──┐"
8070 PRINT "        │     │  │       │    │        │   │          │   │  │"
8080 PRINT "        VS   C1 L1      L3   CB       L5a  C5a       L7a C7  RL"
8090 PRINT "        │     │  │       │    │        │   │          │   │  │"
8100 PRINT "        └─────┴──┴───────┴────┴────────┴───┴──────────┴───┴──┘"
8110 PRINT "                         N=7"
8120 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
8130 PRINT "   C1="C(1)"   L1="L(1)"    C2="C(2)
8140 PRINT "   L2="L(2)"   L3="L(3)"   CA="CA""
8150 PRINT "   CB="CB"   CC="CC"   L4a="L(4)*M^2""
8160 PRINT "   L5a="L(5)*M^2"   C5a="C(5)/M^2"   C6a="C(6)/M^2
8170 PRINT "   L6a="L(6)*M^2"   L7a="L(7)*M^2"    C7="C(7)
8180 PRINT :PRINT "Press (b) to see previous screen or any other key to restart."
8190 A$=INKEY$ :IF A$="" THEN 8190 :ELSE IF A$="b" GOTO 7880 :ELSE RETURN 140
8200 PRINT :PRINT "Cannot use tee or pi networks to replace transformer. Press any key. "
8210 WHILE+ INKEY$="":WEND :RETURN 140
8220 :REM'---subroutine to check tee/pi transformer equivalent- FLAG=1
8230 IF M>1 THEN ON(N-1)/2 GOTO 8260,8400,8860
8240 IF M<1 THEN ON(N-1)/2 GOTO 9690,9840,10300
8250 :REM'-----------N=3, M>1, FLAG=1---------------
8260 LS=L(2) : LP=L(3) :LA=LS-LP*(M-1) :IF LA<0 THEN 9670 :ELSE LB=LP*M :LC=LP*M*(M-1)  :CLS
8270 PRINT :PRINT "    Transformer replaced with tee network"
8280 PRINT "       ┌──RS──┬─LA─┬─LC─C2─┬──┬───┐"
8290 PRINT "       │      │    │       │  │   │"
8300 PRINT "       VS    C1   LB      L3 C3  RL"
8310 PRINT "       │      │    │       │  │   │"
8320 PRINT "       └──────┴────┴───────┴──┴───┘"
8330 PRINT "                N=3"
8340 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
8350 PRINT "      C1="C(3)"   LA="LC"    LB="LB
8360 PRINT "      LC="LA"   C2="C(2)
8370 PRINT "      L3="L(1)"   C3="C(1)
8380 PRINT:PRINT "Press (b) to see previous screen or any other key to restart."
8390 A$=INKEY$ :IF A$="" THEN 8390 :ELSE IF A$="b" GOTO 4340 :ELSE 140
8400 :REM'           --------N=5, M>, FLAG=1------------
8410 LP=L(5) :LS=L(4) :LA=LS-LP*(M-1) :IF LA<0 THEN 8560 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
8420 PRINT :PRINT "    Transformer replaced with tee network, 1st circuit"
8430 PRINT "        ┌──RS─┬─LA─┬─LC─C2─┬──┬-C4─L4─┬──┬──┐"
8440 PRINT "        │     │    │       │  │       │  │  │"
8450 PRINT "        VS   C1   LB      C3 L3      L5  C5 RL"
8460 PRINT "        │     │    │       │  │       │  │  │"
8470 PRINT "        └─────┴────┴───────┴──┴───────┴──┴──┘"
8480 PRINT "                      N=5"
8490 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
8500 PRINT "   C1="C(5)"   LA="LC"   LB="LB
8510 PRINT "   LC="LA"    C2="C(4)"   C3="C(3)""
8520 PRINT "   L3="L(3)"   C4="C(2)"   L4="L(2)""
8530 PRINT "   L5="L(1)"   C5="C(1)
8540 PRINT:PRINT "Press (b) to see previous screen or any other key to continue"
8550 A$=INKEY$ :IF A$="" THEN 8550 :ELSE IF A$="b" GOTO 4340
8560 LP=L(3) :LS=L(2) :LA=LS-LP*(M-1) :IF LA<0 THEN 8710 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
8570 PRINT :PRINT "    Transformer replaced with tee network, 2nd circuit"
8580 PRINT "        ┌──RS─┬──┬─L2a─C2a─┬─LA─┬-LC─C4─┬──┬───┐"
8590 PRINT "        │     │  │         │    │       │  │   │"
8600 PRINT "        VS   C1 L1a       C3a   LB      L5 C5  RL"
8610 PRINT "        │     │  │         │    │       │  │   │"
8620 PRINT "        └─────┴──┴─────────┴────┴───────┴──┴───┘"
8630 PRINT "                         N=5"
8640 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
8650 PRINT "   C1="C(5)"   L1a="L(5)*M^2"   L2a="L(4)*M^2
8660 PRINT "   C2a="C(4)/M^2"   C3a="C(3)/M^2"   LA="LC""
8670 PRINT "   LB="LB"   LC="LA"   C4="C(2)
8680 PRINT "   L5="L(1)"    C5="C(1)
8690 PRINT :PRINT "Press (b) to see previous screen or any other key to continue"
8700 A$=INKEY$ :IF A$="" THEN 8700 :ELSE IF A$="b" GOTO 8410
8710 CS=C(2) :CP=C(3) :CA=CP*CS/(CP-CS*(M-1)) :IF CA<0 THEN 8870 :ELSE CB=CP/M :CC=CP/M/(M-1) :CLS
8720 PRINT :PRINT "    Transformer replaced with tee network , 3rd circuit"
8730 PRINT "        ┌──RS─┬──┬─L2a─C2a─┬─CA─┬-CC─L4─┬───┬───┐"
8740 PRINT "        │     │  │         │    │       │   │   │"
8750 PRINT "        VS   C1 L1a       L3a  CB      L5a  C5  RL"
8760 PRINT "        │     │  │         │    │       │   │   │"
8770 PRINT "        └─────┴──┴─────────┴────┴───────┴───┴───┘"
8780 PRINT "                         N=5"
8790 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
8800 PRINT "   C1="C(5)"   L1a="L(5)*M^2"  L2a="L(4)*M^2
8810 PRINT "   C2a="C(4)/M^2"    L3a="L(3)*M^2"   CA="CC""
8820 PRINT "   CB="CB"   CC="CA"   L4="L(2)""
8830 PRINT "   L5="L(1)"    C5="C(1)
8840 PRINT:PRINT "Press (b) to see previous screen or any other key to restart."
8850 A$=INKEY$ :IF A$="" THEN 8850 :ELSE IF A$="b" GOTO 8560 :ELSE RETURN 140
8860 :REM'-------------- N=7, M>1, FLAG=1--------------
8870 LP=L(7) :LS=L(6) :LA=LS-LP*(M-1) :IF LA<0 THEN 9030 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
8880 PRINT :PRINT "    Transformer replaced with tee network, 1st circuit"
8890 PRINT "        ┌──RS─┬─LA─┬─LC─C2─┬──┬-C4─L4─┬──┬─C6─L6─┬─┬──┐"
8900 PRINT "        │     │    │       │  │       │  │       │ │  │"
8910 PRINT "        VS   C1   LB      C3 L3      C5 L5      L7 C7 RL"
8920 PRINT "        │     │    │       │  │       │  │       │ │  │"
8930 PRINT "        └─────┴────┴───────┴──┴───────┴──┴───────┴─┴──┘"
8940 PRINT "                      N=7"
8950 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
8960 PRINT "   C1="C(7)"   LA="LC"   LB="LB
8970 PRINT "   LC="LA"   C2="C(6)"   C3="C(5)""
8980 PRINT "   L3="L(5)"    C4="C(4)"   L4="L(4)""
8990 PRINT "   C5="C(3)"    L5="L(3)"   C6="C(2)""
9000 PRINT "   L6="L(2)"    L7="L(1)"    C7="C(1)
9010 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
9020 A$=INKEY$ :IF A$="" THEN 9020 :ELSE IF A$="b" GOTO 4340
9030 LP=L(5) :LS=L(4) :LA=LS-LP*(M-1) :IF LA<0 THEN 9190 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
9040 PRINT :PRINT "    Transformer replaced with tee network, 2nd circuit"
9050 PRINT "        ┌──RS─┬──┬─C2a─L2a─┬──LA─┬─LC─C4─┬──┬─C6─L6─┬──┬──┐"
9060 PRINT "        │     │  │         │     │       │  │       │  │  │"
9070 PRINT "        VS   C1 L1a       C3a   LB      C5 L5      L7 C7 RL"
9080 PRINT "        │     │  │         │     │       │  │       │  │  │"
9090 PRINT "        └─────┴──┴─────────┴─────┴───────┴──┴───────┴──┴──┘"
9100 PRINT "                         N=7"
9110 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
9120 PRINT "   C1="C(7)"   L1a="L(7)*M^2"   C2a="C(6)/M^2
9130 PRINT "   L2a="L(6)*M^2"   C3a="C(5)/M^2"   LA="LC
9140 PRINT "   LB="LB"   LC="LA"   C4="C(4)
9150 PRINT "   C5="C(3)"   L5="L(3)"   C6="C(2)
9160 PRINT "   L6="L(2)"   L7="L(1)"   C7="C(1)
9170 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
9180 A$=INKEY$ :IF A$="" THEN 9180 :ELSE IF A$="b" GOTO 8870
9190 LP=L(3) :LS=L(2) :LA=LS-LP*(M-1) :IF LA<0 THEN 9450 :ELSE LB=LP*M :LC=LP*M*(M-1) :CLS
9200 PRINT :PRINT "    Transformer replaced with tee network , 3rd circuit"
9210 PRINT "        ┌──RS─┬──┬─C2a─L2a─┬───┬-C4a─L4a─┬─LA─┬─LC─C6─┬───┬──┐"
9220 PRINT "        │     │  │         │   │         │    │       │   │  │"
9230 PRINT "        VS   C1 L1a       L3a C3a       C5a  LB      L7  C7  RL"
9240 PRINT "        │     │  │         │   │         │    │       │   │  │"
9250 PRINT "        └─────┴──┴─────────┴───┴─────────┴────┴───────┴───┴──┘"
9260 PRINT "                         N=7"
9270 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
9280 PRINT "   C1="C(7)"   L1a="L(7)*M^2"    C2a="C(6)/M^2
9290 PRINT "   L2a="L(6)*M^2"   L3a="L(5)*M^2"    C3a="C(5)/M^2
9300 PRINT "   C4a="C(4)/M^2"   L4a="L(4)*M^2"    C5a="C(3)/M^2
9310 PRINT "   LA="LC"     LB="LB"    LC="LA
9320 PRINT "   C6="C(2)"   L7="L(1)"    C7="C(1)
9330 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
9340 A$=INKEY$ :IF A$="" THEN 9340 :ELSE IF A$="b" GOTO 9030
9350 CS=C(4) :CP=C(5) :CA=CP*CS/(CP-CS*(M-1)) :IF CA<0 THEN 9510 :ELSE CB=CP/M :CC=CP/M/(M-1) :CLS
9360 PRINT :PRINT "    Transformer replaced with tee network, 4th circuit"
9370 PRINT "        ┌──RS─┬──┬─C2a─L2a─┬─CA─┬-CC──L4─┬──┬─L6──C6─┬───┬──┐"
9380 PRINT "        │     │  │         │    │        │  │        │   │  │"
9390 PRINT "        VS   C1 L1a       L3a  CB       L5  C5      L7  C7  RL"
9400 PRINT "        │     │  │         │    │        │  │        │   │  │"
9410 PRINT "        └─────┴──┴─────────┴────┴────────┴──┴────────┴───┴──┘"
9420 PRINT "                         N=7"
9430 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
9440 PRINT "   C1="C(7)"   L1a="L(7)*M^2"    C2a="C(6)/M^2
9450 PRINT "   L2a="L(6)*M^2"   L3a="L(5)*M^2"    CA="CC
9460 PRINT "   CB="CB"   CC="CA"   L4="L(4)
9470 PRINT "   C5="C(3)"   L5="L(3)"   C6="C(2)
9480 PRINT "   L6="L(2)"   L7="L(1)"    C7="C(1)
9490 PRINT:PRINT "Press (b) to see previous screen or any other key to see next circuit."
9500 A$=INKEY$ :IF A$="" THEN 9500 :ELSE IF A$="b" GOTO 9190
9510 CS=C(2) :CP=C(3) :CA=CP*CS/(CP-CS*(M-1)) :IF CA<0 THEN 9670 :ELSE CB=CP/M :CC=CP/M/(M-1) :CLS
9520 PRINT :PRINT "    Transformer replaced with tee network , 5th circuit"
9530 PRINT "        ┌──RS─┬──┬─L2─CA─┬─CC─┬-L4a─C4a─┬───┬──C6a─L6a─┬───┬──┐"
9540 PRINT "        │     │  │       │    │         │   │          │   │  │"
9550 PRINT "        VS   C1 L1      CB   L3a       L5a  C5a       L7a C7  RL"
9560 PRINT "        │     │  │       │    │         │   │          │   │  │"
9570 PRINT "        └─────┴──┴───────┴────┴─────────┴───┴──────────┴───┴──┘"
9580 PRINT "                         N=7"
9590 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
9600 PRINT "   C1="C(1)"   L1="L(1)"    L2="L(2)
9610 PRINT "   CA="CC"   CB="CB"    CC="CA
9620 PRINT "   L3a="L(3)*M^2"   L4a="L(4)*M^2"   C4a="C(4)/M^2
9630 PRINT "   L5a="L(5)*M^2"   C5a="C(5)/M^2"   C6a="C(6)/M^2
9640 PRINT "   L6a="L(6)*M^2"   L7a="L(7)*M^2"    C7="C(7)
9650 PRINT :PRINT "Press (b) to see previous screen or any other key to restart."
9660 A$=INKEY$ :IF A$="" THEN 9660 :ELSE IF A$="b" GOTO 9350 :ELSE RETURN 140
9670 PRINT :PRINT "Cannot use tee or pi networks to replace transformer. Press any key. "
9680 WHILE+ INKEY$="":WEND :CLS :RETURN 140
9690 :REM'------------------N=3---M<1----FLAG=1-------------
9700 LS=L(2) : LP=L(1) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 11110 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
9710 PRINT :PRINT "    Transformer replaced with tee network"
9720 PRINT "       ┌──RS──┬──┬─C2a─LA─┬─LC─┬───┐"
9730 PRINT "       │      │  │        │    │   │"
9740 PRINT "      VS     C1 L1a      LB   C3   RL"
9750 PRINT "       │      │  │        │    │   │"
9760 PRINT "       └──────┴──┴────────┴────┴───┘"
9770 PRINT "                      N=3"
9780 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
9790 PRINT "      C1="C(3)"    L1a="L(3)*M^2"   C2a="C(2)/M^2
9800 PRINT "      LA="LC"   LB="LB""
9810 PRINT "      LC="LA"   C3="C(1)
9820 PRINT:PRINT "Press (b) to see previous screen or any other key to restart."
9830 A$=INKEY$ :IF A$="" THEN 9830 :ELSE IF A$="b" GOTO 4340 :ELSE 140
9840 :REM'   -----------N=5, M<1, FLAG=1--------------
9850 LS=L(4) : LP=L(3) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 11110 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
9860 PRINT :PRINT "    Transformer replaced with tee network, 1st circuit"
9870 PRINT "        ┌──RS─┬──┬─C2a─LA─┬─LC─┬─L4─C4┬──┬──┐"
9880 PRINT "        │     │  │        │    │      │  │  │"
9890 PRINT "       VS    C1 L1a      LB   C3     L5  C5 RL"
9900 PRINT "        │     │  │        │    │      │  │  │"
9910 PRINT "        └─────┴──┴────────┴────┴──────┴──┴──┘"
9920 PRINT "                      N=5"
9930 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
9940 PRINT "   C1="C(5)"   L1a="L(5)*M^2"   C2a="C(4)/M^2
9950 PRINT "   LA="LC"    LB="LB"   LC="LA
9960 PRINT "   C3="C(3)"   L4="L(2)"   C4="C(2)
9970 PRINT "   L5="L(1)"   C5="C(1)
9980 PRINT:PRINT "Press (b) to see previous screen or any other key to continue"
9990 A$=INKEY$ :IF A$="" THEN 9990 :ELSE IF A$="b" GOTO 4340
10000 LS=L(2) : LP=L(1) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 11110 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
10010 PRINT :PRINT "    Transformer replaced with tee network, 2nd circuit"
10020 PRINT "        ┌──RS─┬──┬─C2a─L2a─┬──┬─C4a─LA─┬─LC─┬───┐"
10030 PRINT "        │     │  │         │  │        │    │   │"
10040 PRINT "       VS    C1 L1a       C3a L3a     LB   C5   RL"
10050 PRINT "        │     │  │         │  │        │    │   │"
10060 PRINT "        └─────┴──┴─────────┴──┴────────┴────┴───┘"
10070 PRINT "                         N=5"
10080 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
10090 PRINT "   C1="C(5)"   L1a="L(5)*M^2"  C2a="C(4)/M^2
10100 PRINT "   L2a="L(4)*M^2"   C3a="C(3)/M^2"   L3a="L(3)*M^2
10110 PRINT "   C4a="C(2)/M^2"   LA="LC"   LB="LB
10120 PRINT "   LC="LA"   C5="C(1)
10130 PRINT :PRINT "Press (b) to see previous screen or any other key to continue"
10140 A$=INKEY$ :IF A$="" THEN 10140 :ELSE IF A$="b" GOTO 9850
10150 CS=C(4) :CP=C(3) :CC=CP*CS/(CP*M^2-CS*M*(1-M)) :IF CC<0 THEN 11110 :ELSE          CB=CP/M :CA=CP/(1-M) :CLS
10160 PRINT :PRINT "    Transformer replaced with tee network , 3rd circuit"
10170 PRINT "        ┌─RS─┬──┬─L2a─CA─┬─CC─┬-L4─C4─┬──┬──┐"
10180 PRINT "        │    │  │        │    │       │  │  │"
10190 PRINT "        VS  C1 L1a      CB   L3      L5 C5 RL"
10200 PRINT "        │    │  │        │    │       │  │  │"
10210 PRINT "        └────┴──┴────────┴────┴───────┴──┴──┘"
10220 PRINT "                         N=5"
10230 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
10240 PRINT "   C1="C(5)"   L1a="L(5)*M^2"  L2a="L(4)*M^2
10250 PRINT "   CA="CC"   CB="CB"   CC="CA""
10260 PRINT "   L3="L(3)"   L4="L(2)"   C4="C(2)
10270 PRINT "   L5="L(1)"   C5="C(1)
10280 PRINT:PRINT "Press (b) to see previous screen or any other key to restart"
10290 A$=INKEY$ :IF A$="" THEN 10290 :ELSE IF A$="b" GOTO 10000 :ELSE RETURN 140
10300 :REM'---------------N=7, FLAG=1, M<1--------------------
10310 LS=L(6) : LP=L(5) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 11110 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
10320 PRINT :PRINT "    Transformer replaced with tee network, 1st circuit"
10330 PRINT "        ┌──RS─┬──┬─C2a──LA─┬─LC─┬-C4─L4─┬──┬─L6──C6─┬──┬──┐"
10340 PRINT "        │     │  │         │    │       │  │        │  │  │"
10350 PRINT "        VS   C1 L1a       LB   C3      C5 L5       L7 C7  RL"
10360 PRINT "        │     │  │         │    │       │  │        │  │  │"
10370 PRINT "        └─────┴──┴─────────┴────┴───────┴──┴────────┴──┴──┘"
10380 PRINT "                      N=7"
10390 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
10400 PRINT "   C1="C(7)"   L1a="L(7)*M^2"   C2a="C(6)/M^2
10410 PRINT "   LA="LC"   LB="LB"   LC="LA
10420 PRINT "   C3="C(5)"   C4="C(4)"   L4="L(4)""
10430 PRINT "   C5="C(3)"   L5="L(3)"   L6="L(2)""
10440 PRINT "   C6="C(2)"   L7="L(1)"   C7="C(1)""
10450 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
10460 A$=INKEY$ :IF A$="" THEN 10460 :ELSE IF A$="b" GOTO 4340
10470 LS=L(4) : LP=L(3) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 11110 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
10480 PRINT :PRINT "    Transformer replaced with tee network, 2nd circuit"
10490 PRINT "        ┌──RS─┬──┬─C2a─L2a─┬───┬─C4a─LA─┬─LC─┬─C6─L6──┬──┬───┐"
10500 PRINT "        │     │  │         │   │        │    │        │  │   │"
10510 PRINT "       VS    C1 L1a       C3a L3a      LB   C5       L7 C7  RL"
10520 PRINT "        │     │  │         │   │        │    │        │  │   │"
10530 PRINT "        └─────┴──┴─────────┴───┴────────┴────┴────────┴──┴───┘"
10540 PRINT "                         N=7"
10550 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
10560 PRINT "   C1="C(7)"   L1a="L(7)*M^2"   C2a="C(6)/M^2
10570 PRINT "   L2a="L(6)*M^2"   C3a="C(5)/M^2"   L3a="L(5)*M^2
10580 PRINT "   C4a="C(4)/M^2"   LA="LC"     LB="LB
10590 PRINT "   LC="LA"   C5="C(3)"   C6="C(2)
10600 PRINT "   L6="L(2)"   L7="L(1)"   C7="C(1)
10610 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
10620 A$=INKEY$ :IF A$="" THEN 10620 :ELSE IF A$="b" GOTO 10310
10630 LS=L(2) : LP=L(1) :LC=LS*M^2-LP*M*(1-M) :IF LC<0 THEN 11110 :ELSE LB=LP*M         :LA=LP*(1-M) :CLS
10640 PRINT :PRINT "    Transformer replaced with tee network , 3rd circuit"
10650 PRINT "      ┌─RS─┬──┬─C2a─L2a─┬───┬─C4a─L4a─┬───┬─C6a─LA─┬─LC──┬──┐"
10660 PRINT "      │    │  │         │   │         │   │        │     │  │"
10670 PRINT "     VS   C1 L1a       C3a L3a       L5a C5a      LB    C7  RL"
10680 PRINT "      │    │  │         │   │         │   │        │     │  │"
10690 PRINT "      └────┴──┴─────────┴───┴─────────┴───┴────────┴─────┴──┘"
10700 PRINT "                         N=7"
10710 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
10720 PRINT "   C1="C(7)"   L1a="L(7)*M^2"   C2a="C(6)/M^2
10730 PRINT "   L2a="L(6)*M^2"   C3a="C(5)/M^2"   L3a="L(5)*M^2""
10740 PRINT "   C4a="C(4)/M^2"   L4a="L(4)*M^2"   L5a="L(3)*M^2""
10750 PRINT "   C5a="C(3)/M^2"   C6a="C(2)/M^2"   LA="LC""
10760 PRINT "   LB="LB"   LC="LA"   C7="C(1)
10770 PRINT :PRINT "Press (b) to see previous screen or any other key to see next circuit."
10780 A$=INKEY$ :IF A$="" THEN 10780 :ELSE IF A$="b" GOTO 10470
10790 CS=C(6) :CP=C(5) :CC=CP*CS/(CP*M^2-CS*M*(1-M)) :IF CC<0 THEN 11110 :ELSE          CB=CP/M :CA=CP/(1-M) :CLS
10800 PRINT :PRINT "    Transformer replaced with tee network , 4th circuit"
10810 PRINT "        ┌──RS─┬──┬─L2a─CA─┬─CC─┬-L4─C4─┬──┬─L6─C6─┬───┬──┐"
10820 PRINT "        │     │  │        │    │       │  │       │   │  │"
10830 PRINT "        VS   C1 L1a      CB   L3      C5 L5      L7a C7  RL"
10840 PRINT "        │     │  │        │    │       │  │       │   │  │"
10850 PRINT "        └─────┴──┴────────┴────┴───────┴──┴───────┴───┴──┘"
10860 PRINT "                         N=7"
10870 PRINT " RS="RSI"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
10880 PRINT "   C1="C(7)"   L1a="L(7)*M^2"    L2a="L(6)*M^2
10890 PRINT "   CA="CC"   CB="CB"    CC="CA
10900 PRINT "   L3="L(5)"   C4="C(4)"    L4="L(4)""
10910 PRINT "   C5="C(3)"   L5="L(3)"    C6="C(2)
10920 PRINT "   L6="L(2)"   L7="L(1)"    C7="C(1)
10930 PRINT:PRINT "Press (b) to see previous screen or any other key to see next circuit."
10940 A$=INKEY$ :IF A$="" THEN 10940 :ELSE IF A$="b" GOTO 10630
10950 CS=C(4) :CP=C(3) :CC=CP*CS/(CP*M^2-CS*M*(1-M)) :IF CC<0 THEN 11110 :ELSE          CB=CP/M :CA=CP/(1-M) :CLS
10960 PRINT :PRINT "    Transformer replaced with tee network , 5th circuit"
10970 PRINT "        ┌──RS─┬──┬─C2a─L2a─┬───┬─L4a─CA─┬─CC─┬─C6─L6─┬───┬──┐"
10980 PRINT "        │     │  │         │   │        │    │       │   │  │"
10990 PRINT "        VS   C1 L1a       L3a C3a       CB   L5      L7  C7  RL"
11000 PRINT "        │     │  │         │   │        │    │       │   │  │"
11010 PRINT "        └─────┴──┴─────────┴───┴────────┴────┴───────┴───┴──┘"
11020 PRINT "                         N=7"
11030 PRINT " RS="RS"  RL="RLI"   BW="BW"   F0="F0" SWRmin="SWRMIN"  Ripple="RIP
11040 PRINT "   C1="C(7)"   L1a="L(7)*M^2"    C2a="C(6)/M^2
11050 PRINT "   L2a="L(6)*M^2"   L3a="L(5)*M^2"   C3a="C(5)/M^2
11060 PRINT "   L4a="L(4)*M^2"   CA="CC"   CB="CB
11070 PRINT "   CC="CA"   L5="L(3)"   C6="C(2)
11080 PRINT "   L6="L(2)"   L7="L(1)"    C7="C(1)
11090 PRINT :PRINT "Press (b) to see previous screen or any other key to restart."
11100 A$=INKEY$ :IF A$="" THEN 11100 :ELSE IF A$="b" GOTO 10790 :ELSE RETURN 140
11110 PRINT :PRINT "Cannot use tee or pi networks to replace transformer. Press any key. "
11120 WHILE+ INKEY$="":WEND :RETURN 140
11130 :REM'
11140 :REM'.....PRT
11150 KEY OFF:GOSUB 11220:LOCATE 25,5:COLOR 0,2
11160 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
11170 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
11180 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 11180 :ELSE GOSUB 11220
11190 IF Z$="3"THEN RETURN
11200 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
11210 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 11150
11220 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
