10 :REM'FILTUT - 19 FEB 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1) :TP=2*PI
70 :REM'.....title page
80 COLOR 15,2
90 PRINT " FILTER TUTOR"TAB(61)"by R.J.Dehoney IEEE ";
100 COLOR 7,0
110 :REM'.....start
120 REM  -----rjd----FILTER TUTOR---------""
130 PRINT
140 PRINT "This program will discuss ladder filters and will show you how to design"
150 PRINT "filters with low pass, high pass, band pass and band reject characteristics."
160 LOCATE 12,21:COLOR 0,7:PRINT " Press <1> to continue or <0) to EXIT ":COLOR 7,0
170 A$=INKEY$:IF A$="0"THEN CLS:RUN GO$
180 IF A$="1"THEN CLS:PRINT :GOTO 200
190 GOTO 170
200 PRINT "Today's engineer and experimenter is fortunate that talented mathematicians"
210 PRINT "have come up with simple ways to design very useful filters. Cook book style"
220 PRINT "formulas convert filter specifications like bandwidth and roll-off into"
230 PRINT "prototype values of the required L's and C's. These values are normalized for a"
240 PRINT "lowpass filter with a cutoff of 1 radian/sec and a source resistance of 1 ohm."
250 PRINT "Once the prototype values have been obtained, other simple formulas convert"
260 PRINT "the prototype values into the L's and C's of the final filter." :PRINT
270 PRINT "Many different filters can be designed this way, each with a different"
280 PRINT "characteristic. Among them are Butterworth, Bessel, Gaussian, Chebychev,"
290 PRINT "and Elliptic Function. In this program, we will limit ourselves to Butterworth"
300 PRINT "and Chebychev, since they are widely used. Butterworth filters provide a smooth"
310 PRINT "response to the -3dB point (F0), then a fairly steep roll-off. Chebychev"
320 PRINT "filters ripple in the pass band then roll-off faster than Butterworth."
330 GOSUB 2880:CLS:GOTO 340
340 PRINT "There are two equivalent low pass circuits:"
350 PRINT "  ┌─g(0)─┬─g(2)---─┬─────┐       ┌─g(0)─g(1)─┬─g(3)---g(n)─┐"
360 PRINT "  │      │         │     │       │           │             │"
370 PRINT " Vin   g(1)       g(n) g(n+1)   Vin         g(2)        g(n+1)"
380 PRINT "  │      │         │     │       │           │             │"
390 PRINT "  └──────┴────----─┴─────┘       └───────────┴─────----────┘"
400 PRINT "     Shunt C input                   Series L input"
410 PRINT "g(0) is the source RS, g(n+1) is the load RL. For these low pass filters, shunt"
420 PRINT "elements are capacitors and series elements are inductors. The g(n) values"
430 PRINT "depend on the filter type (Bessel, Butterworth, Chebychev, etc) but the"
440 PRINT "procedure to get circuit values is the same for all. For low pass filters,"
450 PRINT "       g(n)                  g(n)*RS"
460 PRINT " C(n)=----- farads, and L(n)=-------henries, where Wc is 2*pi*Fc and Fc is the"
470 PRINT "      Rs*Wc                     Wc,"
480 PRINT "frequency where the response is down 3dB for Bessel and Butterworth filters"
490 PRINT "and, for Chebychev and Elliptic flilters, it's the highest frequency where the"
500 PRINT "response equals the ripple. For bandpass filters, the bandwidth is equal to Fc"
510 PRINT "of the denormalized low pass. Each shunt C is resonated at the desired center"
520 PRINT "frequency, F0, with a shunt L and each series L is resonated at F0 with a"
530 PRINT "series C. F0=SQR(FH*FL), where FH-FL=FC is the bandwidth." :PRINT
540 :REM'PRINT "Press any key to continue."
550 GOSUB 2880:CLS
560 PRINT "For high pass filters, the series elements are capacitors and the shunt"
570 PRINT "                               1                  RS"
580 PRINT "elements are inductors. C(n)=---------, and L(n)=-------."
590 PRINT "                            g(n)*RS*Wc          g(n)*Wc    " :PRINT
600 PRINT "For band reject, the bandwidth equals the Fc of the denormalized high pass"
610 PRINT "filter with each of the C(n)'s resonated at F0 with a parallel L and each"
620 PRINT "shunt L resonated at F0 with a series C."
630 PRINT
640 PRINT "For Butterworth filters, the load resistor RL is always equal to RS. This is"
650 PRINT "also true for Chebychev filters of odd order, 1,3,5,7 etc. For even order, RL"
660 PRINT "depends on the ripple and the filter configuration--input shunt C or series L."
670 PRINT "The g(n) values which are later calculated give you the appropriate value." :PRINT
680 PRINT "Press `e' to see worked examples, or `c' to design your own filter." :GOTO 700
690 PRINT "Press `e' to see worked examples, `c' to design your own filter or `b` to       select filters."
700 A$=INKEY$:IF A$="" THEN 700 :ELSE IF A$="e" THEN 1400 :ELSE IF A$="b" THEN 850
710 GOSUB 2880:CLS
720 CLS :PRINT "To design a filter, we need to know the desired pass band, the start of the"
730 PRINT "reject band, the required loss at this reject frequency, and, for the Chebychev"
740 PRINT "filter, the allowable loss (ripple) in the pass band. We'll also need RS." :PRINT
750 PRINT "Assuming we're designing a low pass filter, we'll first find the g(n)'s for     both types of filter."
760 PRINT :INPUT "Enter highest pass band frequency FC, MHz ",FC :WC=TP*FC*1000000.0! :IF FC=0 THEN 760
770 PRINT :INPUT "Enter the frequency,FR, at which you have a required loss ",FR
780 PRINT :INPUT "Enter the required loss AL, dB ",ADB
790 PRINT :INPUT "Enter RS, ohms ",RS
800 GOSUB 1150 :REM'Butterworth N calculation
810 PRINT "Number of Butterworth sections="NB
820 PRINT :INPUT "Enter allowable passband ripple, dB ",RIP
830 GOSUB 1170 :REM'Cheby N calculation
840 PRINT :PRINT "Number of Chebychev sections="NC :GOTO 850
850 PRINT :INPUT "Select filter type, 1=Butterworth, 2=Chebychev ",J
860 CLS :PRINT "              Equivalent low pass filter circuits"
870 PRINT "  ┌─g(0)─┬─g(2)---─┬─────┐       ┌─g(0)─g(1)─┬─g(3)---g(n)─┐"
880 PRINT "  │      │         │     │       │           │             │"
890 PRINT " Vin   g(1)       g(n) g(n+1)   Vin         g(2)        g(n+1)"
900 PRINT "  │      │         │     │       │           │             │"
910 PRINT "  └──────┴────----─┴─────┘       └───────────┴─────----────┘"
920 PRINT "     Shunt C input                   Series L input" :PRINT
930 ONJ GOSUB 1200,1250
940 IF J=2 THEN GOTO 1040
950 LOCATE 9,18 :PRINT "Circuit values for your filter."
960 LOCATE 10,20 :PRINT "RS="RS"ohms" :Q=11
970 FOR K=1 TO NB STEP 2 :C(K)=GB(K)/RS/WC :NEXT K
980 FOR K=2 TO NB STEP 2 :L(K)=GB(K)*RS/WC :NEXT K
990 FOR K=1 TO NB STEP 2
1000 LOCATE Q,20 :PRINT USING "C#=##.####^^^^ farads";K;C(K) :Q=Q+1
1010 IF K<NB THEN LOCATE Q,20 :PRINT USING "L#=##.####^^^^ henries";K+1;L(K+1)
1020 Q=Q+1 :NEXT K :IF (-1)^NB<0 THEN Q=Q-1
1030 LOCATE Q,20 :PRINT "RL="RS"ohms" :PRINT :GOTO 690
1040 Q=9 :LOCATE Q,34 :PRINT "Values for a filter with shunt C input"
1050 FOR K=1 TO NC STEP 2 :C(K)=GC(K)/RS/WC :NEXT K
1060 FOR K=2 TO NC STEP 2 :L(K)=GC(K)*RS/WC :NEXT K
1070 Q=10 :FOR K=1 TO NC STEP 2
1080 LOCATE Q,36 :PRINT USING "C#=##.####^^^^ farads";K;C(K) :Q=Q+1
1090 IF K<NC THEN LOCATE Q,36 :PRINT USING "L#=##.####^^^^ henries";K+1;L(K+1)
1100 Q=Q+1 :NEXT K
1110 IF (-1)^NC<0 THEN LOCATE Q,36 :PRINT "RS and RL="RS"ohms." :GOTO 1140
1120 LOCATE Q,36 :PRINT "Source resistance RS="RS"ohms." :Q=Q+1
1130 LOCATE Q,36 :PRINT "Load resistance RL="RL*RS"ohms." :Q=Q+1
1140 PRINT :GOTO 690
1150 :REM'------------Butterworth N calc------------
1160 W=FR/FC :X1=10^(ADB/10)-1 :PB=LOG(X1)/2/LOG(W) :NB=INT(PB)+1 :RETURN
1170 :REM'------------Chebychev N calc------------
1180 E=10^(RIP/10)-1 :X1=SQR((10^(ADB/10)-1)/E)
1190 W=FR/FC :PC=LOG(X1+SQR(X1^2-1))/LOG(W+SQR(W^2-1)) :NC=INT(PC)+1 :RETURN
1200 :REM'-------------Calculation of Butterworth g values-------
1210 PRINT "g(0)  1.0"
1220 FOR K=1 TO NB :GB(K)=2*SIN((2*K-1)*PI/2/NB)
1230 PRINT USING "g(#)  #.####";K;GB(K) :NEXT K
1240 PRINT USING "g(#)  1.0";NB+1 :RETURN
1250 :REM'-------------Calculation of Chebychev g values-------
1260 X1=RIP/17.3700008392334! :X2=(EXP(X1)+EXP(-X1))/(EXP(X1)-EXP(-X1)) :BETA=LOG(X2)
1270 X3=BETA/2/NC :GAMMA=(EXP(X3)-EXP(-X3))/2
1280 FOR K=1 TO NC :A(K)=SIN((2*K-1)*PI/2/NC) :B(K)=GAMMA^2+(SIN(K*PI/NC))^2
1290 NEXT K :GC(1)=2*A(1)/GAMMA
1300 FOR K=2 TO NC :GC(K)=4*A(K-1)*A(K)/B(K-1)/GC(K-1) :NEXT K
1310 IF (-1)^NC>0 THEN X4=BETA/4 :X5=(EXP(X4)-EXP(-X4))/(EXP(X4)+EXP(-X4)) :ELSE      X5=1 :GOTO 1340
1320 X5A=(EXP(X4)+EXP(-X4))/(EXP(X4)-EXP(-X4))
1330 RL=X5^2 :RLA=X5A^2
1340 PRINT "g(0)   1.0"
1350 FOR K=1 TO NC :PRINT USING "g(#)   #.#######";K;GC(K) :NEXT K
1360 IF (-1)^NC<1 THEN PRINT USING "g(#)   1.0";NC+1 :GOTO 1390
1370 PRINT USING "For input shunt C, g(#)=#.#####";NC+1;RL
1380 PRINT USING "For input series L, g(#)=#.#####";NC+1;RLA
1390 RETURN
1400 CLS :PRINT "             ---------Example---------"
1410 TP=8*ATN(1):FC=1000000.0! :WC=TP*FC :R=50 :F0=10000000.0! :W0=TP*SQR(10.5!*9499999993856.0!)
1420 PRINT "Let Ripple=.5 dB, Fc=1 MHz, Fr=3 MHz, AL=30dB, R=RS=RL=50 ohm"
1430 PRINT "    N    Butterworth G(N) values    Chebychev G(N) values"
1440 PRINT "    1            0.7654                    1.596331"
1450 PRINT "    2            1.8478                    1.096681"
1460 PRINT "    3            1.8478                    1.596331"
1470 PRINT "    4            0.7654                    ------"
1480 PRINT "                    Using the input shunt C versions"
1490 PRINT "              ┌──┬─L2─┬──L4──┐  ───        ┌──┬─L2─┬───┐ ────"
1500 PRINT "             RS  │    │      │   │        RS  │    │   │   │"
1510 PRINT "              │  C1   C3     RL Vout       │  C1   C3  RL Vout"
1520 PRINT "             Vin │    │      │   │        Vin │    │   │   │"
1530 PRINT "              └──┴────┴──────┘  ───        └──┴────┴───┘ ────"
1540 PRINT "            Low Pass Butterworth         Low Pass Chebychev"
1550 PRINT ""
1560 PRINT "                  /---Circuit values-(farads & henries----\"
1570 PRINT "                      Butterworth"TAB(50)"Chebychev"
1580 PRINT " C1=G(1)/WC/R    C1="0.7653999924659729!/R/WC;TAB(45)"C1="1.596331000328064!/R/WC
1590 PRINT " L2=G(2)/WC*R    L2="1.8478000164031982!*R/WC;TAB(45)"L2="1.096680998802185!*R/WC
1600 PRINT " C3=G(3)/WC/R    C2="1.8478000164031982!/R/WC;TAB(45)"C3="1.596331000328064!/R/WC
1610 PRINT " L4=G(4)/WC*R    L4="0.7653999924659729!*R/WC;TAB(45)"---------------"
1620 GOSUB 2880:CLS
1630 PRINT :PRINT "Results are, for Butterworth, Vout=-3 dB at 1 MHz"
1640 PRINT "                              Vout=-38.17dB at 3 MHz" :PRINT
1650 PRINT "               for Chebychev, Vout=-.50005 dB at 0.5 MHz"
1660 PRINT "                              Vout=0 dB at 0.865 MHz"
1670 PRINT "                              Vout=-.5 dB at 1.0 MHz"
1680 PRINT "                              Vout=-30.708 dB at 3 MHz"
1690 PRINT "The rest of the examples will use the Chebychev G(n)'s." :PRINT
1700 PRINT "We will now convert our filter from low pass to bandpass. To keep things"
1710 PRINT "simple, we'll move our 1 MHz filter to a 10 MHz center frequency."
1720 PRINT "Here's the schematic:"
1730 PRINT ""
1740 PRINT "              ┌──┬──┬─L2─C2─┬──┬──┐  ───"
1750 PRINT "             Rin │  │       │  │  │   │"
1760 PRINT "              │  C1 L1      C3 L3 RL Vout"
1770 PRINT "             Vin │  │       │  │  │   │"
1780 PRINT "              └──┴──┴───────┴──┴──┘  ───"
1790 PRINT "                Band Pass Chebychev"
1800 PRINT ""
1810 GOSUB 2880:CLS
1820 PRINT "Since the bandwidth is 1 MHz, the values for C1, L2, and C3 stay the same. The  center frequency will be close to SQR(FL*FH). We want FL to be at (10-.5) MHz,"
1830 PRINT "and FH to be at (10+.5) MHz, so W0=2*pi*SQR(9.5*10.5)*10^6 radians/sec.":PRINT
1840 PRINT "Then, resonating C1, L2, and C3, we get" :PRINT
1850 PRINT "L1=1/W0^2/C1         L1="1/W0^2/(1.596331000328064!/R/WC)"henries"
1860 PRINT "C2=1/W0^2/L2         C2="1/W0^2/(1.096680998802185!*R/WC)"farads"
1870 PRINT "L3=1/W0^2/C3         L3="1/W0^2/(1.596331000328064!/R/WC)"henries"
1880 PRINT "Here are the results:"
1890 PRINT "       Frequency, MHz    Output, dB down"
1900 PRINT "            8.50            32.86"
1910 PRINT "            9.50            0.49999"
1920 PRINT "            10.0            0.0006"
1930 PRINT "            10.5            0.5001"
1940 PRINT "            11.5            29.1259"
1950 PRINT "So, the filter is very close to the design requirement."
1960 GOSUB 2880:CLS
1970 PRINT "Now, we'll use the same G values to construct a high pass filter."
1980 PRINT " Here's the schematic:"
1990 PRINT ""
2000 PRINT "              ┌──C1─┬─C3─┐  ───"
2010 PRINT "             Rin    │    │   │      Fc=1 MHz"
2020 PRINT "              │     L2   RL Vout    AL=-30 dB at 1/3 MHz"
2030 PRINT "             Vin    │    │   │      Ripple=1/2 dB"
2040 PRINT "              └─────┴────┘  ───"
2050 PRINT "          High Pass Chebychev"
2060 PRINT ""
2070 PRINT " C1=1/G(1)/WC/R    C1="1/1.596331000328064!/WC/R"farad"
2080 PRINT " L2=1/G(2)/WC*R    L2="1/1.096680998802185!/WC*R"henry"
2090 PRINT " C3=1/G(3)/WC/R    C3="1/1.596331000328064!/WC/R"farad"
2100 GOSUB 2880:CLS
2110 PRINT "Results:"
2120 PRINT "       Frequency, MHz   Output, dB down"
2130 PRINT "            1/3             30.78"
2140 PRINT "            1.0             0.50048"
2150 PRINT "            1.5             .0008"
2160 PRINT "            2.0             0.4999"
2170 PRINT "            20.0            0.0117"
2180 PRINT " which show the correct high pass performance."
2190 PRINT
2200 GOSUB 2880:CLS
2210 PRINT "Now comes the band reject filter, which has this schematic:"
2220 PRINT "              ┌──L1──┬──L3──┐"
2230 PRINT "              ├──C1──┼──C3──┤  ───"
2240 PRINT "             Rin     L2     │   │"
2250 PRINT "              │      │      RL Vout"
2260 PRINT "             Vin     C2     │   │"
2270 PRINT "              └──────┴──────┘  ───"
2280 PRINT "           Band Reject Chebychev"
2290 PRINT
2300 PRINT "L1=1/W0^2/C1         L1="1/W0^2/(1/1.596331000328064!/WC/R)"henry"
2310 PRINT "C2=1/W0^2/L2         C2="1/W0^2/(1/1.096680998802185!/WC*R)"farad"
2320 PRINT "L3=1/W0^2/C3         L3="1/W0^2/(1/1.596331000328064!/WC/R)"henry"
2330 PRINT "Here're the results:"
2340 PRINT "   Frequency, MHz    Output, dB down"
2350 PRINT "       9.50            0.4999       Note that the reject band starts"
2360 PRINT "       9.817           30.173       at the .5 dB points which are 1"
2370 PRINT "      10.00            95.0         MHz apart, not the 3 dB points"
2380 PRINT "      10.159           30.122       which are less than 400 kHz apart."
2390 PRINT "      10.5             0.500167"
2400 PRINT "Bandpass and band reject filters as designed above may not prove practical at"
2410 PRINT "RF. Narrow band filters are better designed with coupled resonators."
2420 :REM'PRINT "Press any key.
2430 GOSUB 2860:CLS
2440 PRINT "We'll finish by designing some low pass filters using the input L schematic."
2450 PRINT "First, we'll build a filter using the same specs we used for our first example."
2460 PRINT "         ┌──L1──┬──L3──┐  ───       Ripple=1/2 dB"
2470 PRINT "         RS     │      │   │        FC=1 MHz"
2480 PRINT "         │      C2     RL Vout      FR=3 MHz"
2490 PRINT "        Vin     │      │   │        LA=30 dB"
2500 PRINT "         └──────┴──────┘  ───       RL=RS=R=50"
2510 PRINT ""
2520 PRINT "L1=G(1)/WC*R      L1="1.596331000328064!/WC*50"henries"
2530 PRINT "C2=G(2)/WC/R      C2="1.096680998802185!/WC/50"farads"
2540 PRINT "L3=G(3)/WC*R      L3="1.596331000328064!/WC*50"henries"
2550 PRINT
2560 PRINT "Here are the results:"
2570 PRINT "    Frequency, MHz    Loss, dB"
2580 PRINT "            0             0"
2590 PRINT "            0.5           0.499"
2600 PRINT "            0.866         0"
2610 PRINT "            1.0           0.5002"
2620 PRINT "            3.0          30.779"
2630 PRINT "So, the results are the same as for the shunt C version."
2640 GOSUB 2880:CLS
2650 PRINT " Now, we'll try one with RL not equal to RS."
2660 PRINT "         ┌──L1──┬──L3──┬───┐  ───   Ripple=1/2 dB"
2670 PRINT "         RS     │      │   │   │    FC=1 MHz"
2680 PRINT "         │      C2     C3  RL Vout  FR=2 MHz"
2690 PRINT "        Vin     │      │   │   │    LA=30 dB"
2700 PRINT "         └──────┴──────┴───┘  ───   RS=50"
2710 PRINT "                 N=4"
2720 PRINT "  g(0)=1.0            RS=g(0)*50=50 ohms"
2730 PRINT "  g(1)=1.670357       L1=g(1)*RS/2/pi/FC=1.329228E-5 henries"
2740 PRINT "  g(2)=1.192550       C2=g(2)/RS/2/pi/FC=3.796004E-9 farads"
2750 PRINT "  g(3)=2.366170       L2=g(3)*RS/2/pi/FC=1.882938E-5 henries"
2760 PRINT "  g(4)=0.8418601      C3=g(4)/RS/2/pi/Fc=2.679724E-9 farads"
2770 PRINT "  g(5)=1.98413        RL=g(5)*RS=99.2065 ohms"
2780 PRINT
2790 PRINT "    Frequency, MHz    Loss, dB          Since N is even, RL does not"
2800 PRINT "            0             0.5000432     equal RS, but the response"
2810 PRINT "            0.3809        0             is quite good. Notice that"
2820 PRINT "            0.7068        0.5000452     the ripples are not at the"
2830 PRINT "            0.9223        0             same frequencies as with the"
2840 PRINT "            1.0           0.5001001     odd N case."
2850 PRINT "            2.0          30.60394"
2860 GOSUB 2880:CLS:GOTO 70
2870 :REM'
2880 :REM'.....PRT(next page)"
2890 KEY OFF:GOSUB 2960:LOCATE 25,5:COLOR 0,2
2900 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2910 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2920 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2920 :ELSE GOSUB 2960
2930 IF Z$="3"THEN RETURN
2940 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2950 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2890
2960 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
