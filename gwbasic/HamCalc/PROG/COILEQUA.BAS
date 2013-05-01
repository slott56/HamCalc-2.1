10 :REM'COILEQUA - Coil Equation Calculator - 30 NOV 95 rev. 05 JUN 2006
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="coilequa"
60 COMMON EX$,PROG$,L,D,F,FQ,UH,LD,MIN,MAX,QQ,T,NT,WW,W
70 COLOR 7,0,0
80 PI=4*ATN(1)     :REM'(3.141593)
90 DIM GA(40)
100 UL$=STRING$(80,205)
110 A$="#####.###"
120 B$="########.###"
130 C$="#####.### in.= ####.## cm"
140 :REM'
150 :REM'.....start
160 CLS
170 COLOR 15,2
180 PRINT " COIL EQUATION CALCULATOR";TAB(57);"by George Murphy VE3ERP ";
190 COLOR 1,0:PRINT STRING$(80,223);
200 COLOR 7,0
210 IF GO$="tunecct"OR GO$="resicop"OR GO$="trapcalc"THEN LN=3:GOTO 810
220 :REM'
230 PRINT " Press <1> for Wheeler equation program"
240 PRINT " Press <2> for Meyer/Miller/Nagaota/Dehoney equation program"
245 PRINT " Press <0> to EXIT"
250 Z$= INKEY$:IF Z$=""THEN 250
255 IF Z$="0"THEN CLS:RUN GO$
260 IF Z$="1"THEN LN=3:GOSUB 3030:LOCATE LN:GOTO 300
270 IF Z$="2"THEN CLS:CHAIN "coilnew"
280 GOTO 260
290 :REM'
300 :REM'.....start
310 TB=7
320 PRINT TAB(TB+2);
330 PRINT "This program solves the basic equation for close-wound single-"
340 PRINT TAB(TB);
350 PRINT "layer air-core coils as it appears in recent editions of the ARRL"
360 PRINT TAB(TB);
370 PRINT "HANDBOOK. This equation was formulated by Harold A. Wheeler in 1928."
380 PRINT TAB(TB);
390 PRINT "A more accurate equation presented by Mr. Wheeler circa 1982 is also"
400 PRINT TAB(TB);
410 PRINT "used in the program to show the difference between the two (most"
420 PRINT TAB(TB);
430 PRINT "apparent when coil length-to-diameter ratio is less than 0.4:1."
440 PRINT TAB(TB+2);
450 PRINT "In this program ";CHR$(34);"coil diameter";CHR$(34);
460 PRINT " is the diameter of the axis of the"
470 PRINT TAB(TB);
480 PRINT "conductor (i.e., the pitch circle diameter). This is equal to the"
490 PRINT TAB(TB);
500 PRINT "sum of the outside diameter of the coil form and the outside"
510 PRINT TAB(TB);
520 PRINT "diameter of the conductor, including its insulation."
530 PRINT TAB(TB+2);
540 PRINT "The length of the coil is the distance between centres of the wire"
550 PRINT TAB(TB);
560 PRINT "at each end of the coil for coils with an integral number of turns,"
570 PRINT TAB(TB);
580 PRINT "or the number of turns multiplied by the pitch (i.e., centre-to-"
590 PRINT TAB(TB);
600 PRINT "centre spacing between turns)."
610 PRINT TAB(TB+2);
620 PRINT "The program also computes coil self-capacitance and Q."
630 PRINT UL$;
640 PRINT " Press number in < > to:"
650 PRINT UL$;
660 PRINT "   < 1 > Analyze a single-layer air-core coil"
670 IF U THEN COLOR 0,7 :ELSE COLOR 7,0:GOTO 720
680 LOCATE ,3
690 PRINT " < 2 > Run Coil Designer program";
700 IF U THEN PRINT USING" for a ###.### µH, ##.###:1 L/d coil ";U,LD;
710 COLOR 7,0:PRINT ""
720 PRINT "   < 0 > EXIT";
730 IF GO$=PROG$ THEN GO$="\hamcalc\menu\hcal"
740 Z$=INKEY$
750 IF Z$="0"THEN CLS:CHAIN GO$
760 IF Z$="1"THEN X=0:LN=3:GOTO 810
770 IF U=0 THEN 790
780 IF Z$="2"THEN CLS:GOSUB 2520:FQ=F:UH=U:PROG$="coilequa":CHAIN "coildsgn"
790 GOTO 740
800 :REM'
810 :REM'.....start
820 COLOR 7,0
830 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:
840 IF GO$="trapcalc"THEN 950
850 PRINT " Press number in < > to choose standard units of measure:"
860 PRINT UL$;
870 PRINT "   < 3 >  Metric"
880 PRINT "   < 4 >  U.S.A./Imperial"
890 Z$=INKEY$
900 IF Z$="3"THEN UM=2.5399999618530273!:UM$=" cm ":GOTO 930
910 IF Z$="4"THEN UM=1:UM$=" in.":GOTO 930
920 GOTO 890
930 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
940 :REM'
950 :REM'.....data input
960 IF GO$="coilq"THEN GOSUB 1460:LOCATE 5:BEEP:GOTO 1020
970 IF GO$="resicop"THEN GOSUB 1460:LOCATE 5:BEEP:GOTO 1020
980 IF GO$="trapcalc"THEN GOSUB 1460:LOCATE 5:BEEP:GOTO 1020
990 IF GO$="tunecct"THEN GOSUB 1460
1000 :REM'
1010 U=0:R=0:D=0:L=0:N=0:T=0:S=0:F=0:W=0:WW=0
1020 PRINT " ENTER known factors ( if factor unknown, press <ENTER> )"
1030 PRINT UL$;
1040 IF U THEN 1060
1050 INPUT " ENTER: Inductance (µH).........................";U:GOSUB 1460
1060 IF D THEN 1090
1070 PRINT " ENTER: Coil Pitch Circle Diameter (";UM$;").......";
1080 INPUT D:D=D/UM:GOSUB 1460
1090 IF T THEN 1110
1100 INPUT " ENTER: Turns per inch (2.54 cm.)...............";T:GOSUB 1460
1110 IF N THEN 1130
1120 INPUT " ENTER: Number of turns.........................";N:GOSUB 1460
1130 IF L THEN 1160
1140 PRINT " ENTER: Coil length (";UM$;")......................";
1150 INPUT L:L=L/UM:GOSUB 1460
1160 IF R THEN 1180
1170 INPUT " ENTER: Length-to-diameter (L/d) ratio..........";R:GOSUB 1460
1180 GOSUB 1460
1190 VIEW PRINT 5 TO 24:CLS:VIEW PRINT:LOCATE 5:GOTO 1040
1200 :REM'
1210 :REM'.....find length
1220 L=10:X=1
1230 N=SQR(U*(18*D+40*L))/D
1240 IF ABS(T-N/L)<9.999999747378752e-06! THEN 1270
1250 IF SGN(N/L-T)<>SGN(X)THEN X=-X/10
1260 L=L+X:GOTO 1230
1270 RETURN
1280 :REM'
1290 :REM'.....find diameter
1300 D=10:X=1               :REM'initial coil diameter
1310 Y=SQR(U*(18*D+40*L))/D  :REM'number of turns
1320 IF ABS(Y-N)<9.999999747378752e-06! THEN 1350
1330 IF SGN(Y-N)<>SGN(X)THEN X=-X/10
1340 D=D+X:GOTO 1310
1350 RETURN
1360 :REM'
1370 :REM'.....find diameter
1380 D=10:X=1               :REM'initial coil diameter
1390 L=R*D:N=L*T
1400 Y=SQR(U*(18*D+40*L))/D  :REM'number of turns
1410 IF ABS(Y-N)<9.999999747378752e-05! THEN 1440
1420 IF SGN(Y-N)<>SGN(X)THEN X=-X/10
1430 D=D+X:GOTO 1390
1440 RETURN
1450 :REM'
1460 :REM'.....calculate
1470 IF NT THEN N=NT
1480 IF U=0 AND D*L*N>0 THEN U=(D^2*N^2)/(18*D+40*L)    :REM'Wheeler 1928 equation
1490 IF L=0 AND U*D*N>0 THEN L=((D^2*N^2/U)-18*D)/40:GOTO 1460
1500 IF L=0 AND U*D*T>0 THEN GOSUB 1210:GOTO 1460
1510 IF D=0 AND U*L*N>0 THEN GOSUB 1290:GOTO 1460
1520 IF D=0 AND R*U*T>0 THEN GOSUB 1370:GOTO 1460
1530 IF N=0 AND U*D*L>0 THEN N=SQR(U*(18*D+40*L))/D:GOTO 1460
1540 IF R=0 AND L*D>0   THEN R=L/D:GOTO 1460
1550 IF L=0 AND R*D>0   THEN L=R*D:GOTO 1460
1560 IF D=0 AND L*R>0   THEN D=L/R:GOTO 1460
1570 IF S=0 AND L*N>0   THEN S=L/N:GOTO 1460
1580 IF T=0 AND N*L>0   THEN T=N/L:GOTO 1460
1590 IF L=0 AND N*T>0   THEN L=N/T:GOTO 1460
1600 IF N=0 AND T*L>0   THEN N=T*L:GOTO 1460
1610 IF U*D*L*N*R*S*T>0 THEN 1680
1620 IF SGN(L)=-1 THEN 1640
1630 RETURN
1640 BEEP:COLOR 0,7:PRINT " NOT POSSIBLE! . . . press any key . . .":COLOR 7,0
1650 IF INKEY$=""THEN 1650
1660 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 950
1670 :REM'
1680 :REM'.....print
1690   A=D/2*2.5399999618530273!     :REM'radius in cm.
1700   B=L*2.5399999618530273!       :REM'length in cm.
1710   LD=R           :REM'Lgth.dia. ratio
1720   F1=4*PI*10^-3*N^2*A         :REM'┐
1730   F2=LOG(1+PI*A/B)            :REM'├ Wheeler 1982 equation by Gary Bold, ZL1AN
1740   F3=2.299999952316284!+1.600000023841858!*B/A+0.4399999976158142!*(B/A)^2  :REM'│
1750   I=F1*(F2+1/F3)              :REM'┘ inductance in µH
1760 :REM'
1770 CLS:COLOR 15,2:PRINT UL$;:LOCATE 1,27
1780 PRINT " COIL EQUATION CALCULATOR ":COLOR 7,0,0
1790 IF U<1 THEN U1=U*10^3:H$=" nH":ELSE U1=U:H$=" µH"
1800 PRINT " INDUCTANCE (Wheeler 1928 equation)...";USING A$;U1;:PRINT H$;
1810 PRINT "  ( most ARRL Handbooks )"
1820 IF I<1 THEN I1=I*10^3:H$=" nH":ELSE I1=I:H$=" µH"
1830 PRINT " INDUCTANCE (Wheeler 1982 equation)...";USING A$;I1;:PRINT H$
1840 ACC=100-(I1-U1)/I1*100
1850 PRINT " Accuracy of 1928 equation............";USING A$;ACC;:PRINT "%"
1860 PRINT " Pitch circle diameter................";USING C$;D,D*2.5399999618530273!
1870 PRINT " Length...............................";USING C$;L,L*2.5399999618530273!
1880 PRINT " Length-to-diameter ratio.............";USING A$;LD;:PRINT ":1"
1890 PRINT " Number of turns......................";USING A$;N
1900 PRINT " Pitch (i.e., turn spacing)...........";USING C$;S,S*2.5399999618530273!
1910 PRINT " Turns per inch/25.4mm................";USING A$;T
1920 WL=PI*D*N
1930 PRINT " Amount of wire in coil...............";USING C$;WL,WL*2.5399999618530273!
1940 LN=CSRLIN
1950 PRINT
1960 :REM'
1970 IF GO$="resicop"THEN LOCATE CSRLIN-1:GOTO 2240
1980 IF GO$="trapcalc"THEN LOCATE CSRLIN-1:GOTO 2500
1990 :REM'
2000 COLOR 0,7:PRINT " Want to change coil length & pitch?  (y/n) "
2010 COLOR 7,0
2020 Z$=INKEY$:IF Z$=""THEN 2020
2030 IF Z$="n"THEN LOCATE LN:PRINT STRING$(80,32);:GOTO 2150
2040 IF Z$="y"THEN 2070
2050 GOTO 2020
2060 :REM'
2070 :REM'.....change specs.
2080 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2090 U=0:L=0:R=0:S=0:T=0
2100 PRINT " ENTER: Coil length (";UM$;")......................";
2110 INPUT L:IF L=0 THEN 2080
2120 L=L/UM:GOSUB 1460
2130 END
2140 :REM'
2150 :REM'.....estimate Q
2160 LOCATE LN+1:COLOR 0,7
2170 PRINT " Want to compute Self-Capacitance and Q?  (y/n) "
2180 COLOR 7,0
2190 Z$=INKEY$:IF Z$=""THEN 2190
2200 IF Z$="y"THEN GOSUB 3020:LOCATE LN:GOTO 2240
2210 IF Z$="n"THEN GOSUB 3020:LOCATE LN:GOTO 3060
2220 GOTO 2190
2230 :REM'
2240 :REM'.....calculate Q
2250 MIN=S*0.44999998807907104!:MAX=S*0.699999988079071!:ZZ=CSRLIN
2260 Q=0:ZZ=CSRLIN
2270 IF F THEN 2310
2280 COLOR 0,7:INPUT " ENTER: Frequency in MHz....";F:COLOR 7,0
2290 IF WW THEN W=WW:GOTO 2570
2300 IF F=0 THEN BEEP:LOCATE ZZ:GOTO 2280
2310 PRINT USING " Min./Max. wire size: ##.#### / ##.####";MIN*UM,MAX*UM;
2320 PRINT UM$;" dia. "+STRING$(29,".")
2330 WWIN=CSRLIN:LN=WWIN
2340 :REM'
2350 :REM'.....AWG calculator
2360 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
2370 FOR WG=1 TO 40
2380 N=WG+3
2390 GA(WG)=0.46000000834465027!/K^N
2400 NEXT WG
2410 LN=12
2420    FOR WG=40 TO 8 STEP -1
2430 IF GA(WG)<MIN OR GA(WG)>MAX THEN 2470
2440 LN=LN+1
2450 LOCATE LN,60
2460 PRINT USING "AWG ## =##.#### "+UM$;WG,GA(WG)*UM
2470    NEXT WG
2480 LOCATE WWIN
2490 :REM'
2500 IF GO$="trapcalc" THEN W=WW:GOTO 2620
2510 :REM'
2520 COLOR 0,7:PRINT " ENTER: Wire dia.(";UM$;")............";:INPUT WW
2530 COLOR 7,0
2540 IF Z$="2"THEN W=WW:RETURN
2550 :REM'
2560 IF GO$="trapcalc"THEN W=WW :ELSE W=WW/UM
2570 IF W>=MIN AND W<=MAX THEN 2610
2580 BEEP:COLOR 12,0:PRINT "In order to calculate Q, wire size must be";
2590 PRINT "within the range of suggested sizes shown"
2600 GOTO 2520
2610 LN=ZZ:GOSUB 3020:LOCATE ZZ
2620 PRINT " Frequency............................";USING A$;F;:PRINT " MHz"
2630 PRINT " Wire diameter........................";USING C$;W,W*2.5399999618530273!;
2640 PRINT USING " = AWG ##.##";LOG(0.46000000834465027!/W)/(LOG(1.1229000091552734!))-3
2650 SW=S/WW*UM
2660 IHC=LOG(SW+SQR(SW^2-1))  :REM'inverse hyperbolic cosine
2670 CO=PI*D*2.5399999618530273!/(3.5999999046325684!*IHC)   :REM'distributed capacitance
2680 PRINT " Self-capacitance.....................";USING A$;CO;:PRINT " pF"
2690 JJ=1/(4*PI^2)*10^6    :REM'25330.29
2700 FS=SQR(JJ/CO/U)
2710 PRINT " Self-resonant frequency..............";USING A$;FS;:PRINT " MHz"
2720 CR=JJ/(F^2*U) :REM'capacitance required to resonate
2730 C=CR-CO
2740 PRINT " Added capacity required to resonate..";USING A$;C;:PRINT " pF"
2750 AU=U*(1+CO/C)
2760 PRINT "  Apparent inductance.................";USING A$;AU;:PRINT " µH"
2770 QT=SQR(F*10^6)/(6.900000095367432!/A+5.400000095367432!/B)    :REM'true Q
2780 RT=2*PI*F*U/QT   :REM'true resistance
2790 RA=RT*(1+CO/C)^2
2800 PRINT " True total resistance................";USING A$;RT;:PRINT " ohms"
2810 PRINT "  Apparent total resistance...........";USING A$;RA;:PRINT " ohms"
2820 XT=10^6/(2*PI*F*U)
2830 PRINT " True reactance at resonance..........";USING A$;XT;:PRINT " ohms"
2840 X=2*PI*F*AU
2850 PRINT "  Apparent reactance at resonance.....";USING A$;X;:PRINT " ohms"
2860 PRINT " True Q...............................";USING "#####";CINT(QT)
2870 AQ=QT/(1+CO/C)
2880 PRINT "  Apparent Q..........................";USING "#####";CINT(AQ)
2890 :REM'
2900 IF FS>F THEN 2980 :ELSE COLOR 12
2910 COLOR 12
2920 PRINT " WARNING: Q Calculations NOT VALID at frequencies above self-";
2930 PRINT "resonance !"
2940 W$="««««««!"
2950 LOCATE 14,53:PRINT W$
2960 LOCATE 17,53:PRINT W$
2970 COLOR 7,0
2980 LOCATE 24,10
2990 PRINT "Ref. RADIOTRON DESIGNERS' HANDBOOK, 4th edition, pp. 451-464";
3000 QQ=Q:Q=0:GOTO 3060
3010 :REM'
3020 :REM'.....clear screen
3030 VIEW PRINT LN TO 24:CLS:VIEW PRINT
3040 RETURN
3050 :REM'
3060 :REM'.....end
3070 GOSUB 3130
3080 IF GO$="tunecct"THEN CLS:GOTO 640
3090 IF GO$="resicop"THEN CLS:GOTO 640
3100 IF GO$="trapcalc"THEN CLS:GOTO 640
3110 COLOR 7,0,1:GOTO 150
3120 :REM'
3130 :REM'PRT
3140 KEY OFF:GOSUB 3210:LOCATE 25,5:COLOR 0,2
3150 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3160 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3170 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3170 :ELSE GOSUB 3210
3180 IF Z$="3"THEN RETURN
3190 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3200 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3140
3210 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
