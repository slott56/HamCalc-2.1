10 :REM'INDUCALC - Inductance Calculator - 28 NOV 95 rev. 29 OCT 1999
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 RESTORE
50 COLOR 7,0,1
60 PI=3.1415929794311523!
70 UL$=STRING$(80,205)
80 U$="####.###"
90 V$="#####.##"
100 ON ERROR  GOTO 5880
110 :REM'
120 COLOR 15,2
130 PRINT " INDUCTANCE CALCULATOR";TAB(62);"by Bob Stein W6NBI ";
140 PRINT STRING$(80,32);
150 LOCATE CSRLIN-1,20:PRINT "edited for HAMCALC by George Murphy VE3ERP"
160 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
170 :REM'
180 PRINT " Press letter in < > to calculate:"
190 PRINT UL$;
200 PRINT "  <a> INDUCTANCE of a single-layer coil"
210 PRINT "  <b>   Turns in a single-layer coil for a specified inductance"
220 PRINT "  <c>   Turns from coil stock of known pitch (turns per inch or"
230 PRINT "        turns per cm.) for a specified inductance"
240 PRINT "  <d> INDUCTANCE of a straight copper strap"
250 PRINT "  <e>   Length of a straight copper strap for a specified inductance"
260 PRINT "  <f> INDUCTANCE of a transmission-line section"
270 PRINT "  <g>   Length of transmission line for a specified inductance"
280 PRINT "  <h> INDUCTANCE of a copper wire parallel to and grounded to a ";
290 PRINT "ground plane"
300 PRINT "  <i>   Length of a copper wire parallel to and above a ground ";
310 PRINT "plane for a"
320 PRINT "        specified inductance"
330 PRINT "  <j> INDUCTANCE of a straight copper wire in free space"
340 PRINT "  <k>   Length of a straight copper wire for a specified inductance"
350 PRINT "  <l> INDUCTANCE of a multi-layer rectangular coil"
360 PRINT "  <m> INDUCTANCE of a multi-layer circular coil"
370 PRINT "  <n>   Turns in a multi-layer bobbin-wound coil for a specified ";
380 PRINT "inductance"
390 PRINT "       - O R -"
400 PRINT "  <z> to EXIT"
410 :REM'
420 Z$=INKEY$:IF Z$=""THEN 420
430 IF Z$="a"OR Z$="A"THEN CLS:GOSUB 660:GOTO 590
440 IF Z$="b"OR Z$="B"THEN CLS:GOSUB 2860:GOTO 590
450 IF Z$="c"OR Z$="C"THEN CLS:GOSUB 900:GOTO 590
460 IF Z$="d"OR Z$="D"THEN CLS:GOSUB 1180:GOTO 590
470 IF Z$="e"OR Z$="E"THEN CLS:GOSUB 1350:GOTO 590
480 IF Z$="f"OR Z$="F"THEN CLS:GOSUB 3130:GOTO 590
490 IF Z$="g"OR Z$="G"THEN CLS:GOSUB 3760:GOTO 590
500 IF Z$="h"OR Z$="H"THEN CLS:GOSUB 2240:GOTO 590
510 IF Z$="i"OR Z$="I"THEN CLS:GOSUB 2550:GOTO 590
520 IF Z$="j"OR Z$="J"THEN CLS:GOSUB 4270:GOTO 590
530 IF Z$="k"OR Z$="K"THEN CLS:GOSUB 5710:GOTO 590
540 IF Z$="l"OR Z$="L"THEN CLS:GOSUB 1550:GOTO 590
550 IF Z$="m"OR Z$="M"THEN CLS:GOSUB 2050:GOTO 590
560 IF Z$="n"OR Z$="N"THEN CLS:GOSUB 4400:GOTO 590
570 IF Z$="z"OR Z$="Z"THEN CLS:RUN EX$
580 GOTO 420
590 GOSUB 6630:GOTO 30   :REM'screen dump
600 :REM'
610 :REM'.....format input line
620 LOCATE CSRLIN-1:PRINT "       ";
630 LOCATE CSRLIN,49:PRINT ".....";USING U$;Z;
640 RETURN
650 :REM'
660 :REM'.....single layer coil
670 REM  Equations from Hank Meyer, W6GGV, as published in "QST" Apr 1992, p76
680 PRINT " SINGLE-LAYER COIL INDUCTANCE"
690 PRINT UL$;
700 GOSUB 5970
710 INPUT " ENTER: Number of turns..............................";N
720 Z=N:GOSUB 610:PRINT ""
730 PRINT " ENTER: Coil Length.............................(";UM$;")";:INPUT B
740 Z=B:GOSUB 610:PRINT " ";UM$
750 PRINT " ENTER: Coil Inside Diameter....................(";UM$;")";:INPUT ID
760 Z=ID:GOSUB 610:PRINT " ";UM$
770 PRINT " ENTER: Total Lead Length.......................(";UM$;")";:INPUT LG
780 Z=LG:GOSUB 610:PRINT " ";UM$
790 GOSUB 6090
800 :REM'
810 DIA=ID+D
820 A=DIA/2
830 IF X%=2 THEN LG=LG/25.399999618530273! : A=A/25.399999618530273! : B=B/25.399999618530273! : D=D/25.399999618530273! : DIA=DIA/25.399999618530273!
840 GOSUB 6400
850 PRINT "        INDUCTANCE...................................";
860 IF L=>1 THEN PRINT USING U$;L;:PRINT " µH"
870 IF L<1 THEN PRINT USING U$;L*1000;:PRINT " nH"
880 RETURN
890 :REM'
900 :REM'.....coil turns using known winding pitch
910 PRINT " COIL TURNS REQUIRED USING KNOWN WINDING PITCH"
920 PRINT UL$;
930 GOSUB 5970
940 INPUT " ENTER: Inductance..............................(µH)";LR
950 Z=LR:GOSUB 610:PRINT " µH"
960 IF X%=2 THEN T$="centimetre":ELSE T$="inch......"
970 PRINT " ENTER: Turns-per-";T$;".........................";:INPUT T
980 Z=T:GOSUB 610
990 PRINT " ENTER: Coil Inside Diameter....................(";UM$;")";:INPUT ID
1000 Z=ID:GOSUB 610:PRINT " ";UM$
1010 PRINT " ENTER: Total Lead Length.......................(";UM$;")";:INPUT LG
1020 Z=LG:GOSUB 610:PRINT " ";UM$
1030 IF X%=2 THEN ID=ID/10:LG=LG/10   :REM'mm. to cm.
1040 GOSUB 6090
1050 IF X%=2 THEN D=D/10
1060 DIA=ID+D
1070 A=DIA/2
1080 IF X%=2 THEN T=T*2.5399999618530273! : A=A/2.5399999618530273! : LG=LG/2.5399999618530273! : D=D/2.5399999618530273! : DIA=DIA/25.399999618530273!
1090 IF LG>0 THEN GOSUB 6530
1100 LI=LR-LW/1000
1110 P=1/T
1120 N=(5*LI+SQR(25*LI*LI+9*LI*T*T*A^3))/(T*A*A)   :REM'Solve for initial value of N
1130 B=P*N : GOSUB 6430                            :REM'Check inductance for N turns
1140 IF L>1.0010000467300415!*LR OR L<0.9990000128746033!*LR THEN N=N*(LR/L) : GOTO 1130    :REM'Adjust N
1150 PRINT "        NUMBER OF TURNS..............................";USING U$;N
1160 RETURN
1170 :REM'
1180 :REM'.....straight strap inductance
1190 PRINT " STRAIGHT STRAP INDUCTANCE"
1200 PRINT UL$;
1210 GOSUB 5970
1220 PRINT " ENTER: Strap Length............................(";UM$;")";:INPUT LG
1230 Z=LG:GOSUB 610:PRINT " ";UM$
1240 PRINT " ENTER: Strap Width.............................(";UM$;")";:INPUT B
1250 Z=B:GOSUB 610:PRINT " ";UM$
1260 PRINT " ENTER: Strap Thickness.........................(";UM$;")";:INPUT C
1270 Z=C:GOSUB 610:PRINT " ";UM$
1280 IF X%=2 THEN LG=LG/25.399999618530273!  : B=B/25.399999618530273! : C=C/25.399999618530273!
1290 L=0.005100000184029341!*LG*(LOG(2*LG/(B+C))+(0.2240000069141388!*(B+C)/LG)+0.5!)*1000
1300 L1=L/10^3
1310 PRINT "        INDUCTANCE...................................";USING U$;L1;
1320 PRINT " µH"
1330 RETURN
1340 :REM'
1350 :REM'.....straight strap length
1360 PRINT " STRAIGHT STRAP LENGTH"
1370 PRINT UL$;
1380 GOSUB 5970
1390 INPUT " ENTER: Inductance..............................(µH)";L1:L=L1*10^3
1400 Z=L1:GOSUB 610:PRINT " µH"
1410 PRINT " ENTER: Strap Width.............................(";UM$;")";:INPUT B
1420 Z=B:GOSUB 610:PRINT " ";UM$
1430 PRINT " ENTER: Strap Thickness.........................(";UM$;")";:INPUT C
1440 Z=C:GOSUB 610:PRINT " ";UM$
1450 IF X%=2 THEN B=B/25.399999618530273! : C=C/25.399999618530273!
1460 X=1
1470 LG=(0.19599999487400055!*L)/(LOG((2*X)/(B+C))+(0.2240000069141388!*(B+C)/X)+0.5!)
1480 IF LG<0.9990000128746033!*X OR LG>1.0010000467300415!*X THEN X=LG :ELSE 1500
1490 GOTO 1470
1500 IF X%=2 THEN LG=LG*25.399999618530273!
1510 PRINT "        STRAP LENGTH.................................";USING U$;LG;
1520 PRINT " ";UM$
1530 RETURN
1540 :REM'
1550 :REM'.....multi-length rectangulare coil
1560 PRINT " MULTI-LAYER RECTANGULAR COIL INDUCTANCE"
1570 PRINT UL$;
1580 PRINT 
1590 J=16
1600 PRINT TAB(J);"    │«──────── LG ────────»│     ──»│  H  │«──"
1610 PRINT TAB(J);" ──»│   │«── T             │        │     │"
1620 PRINT TAB(J);"┌─» ╔═══╪══════════════════╗        ╔═════╗"
1630 PRINT TAB(J);"│   ║ ┌─┼──>         ────┐ ║        ║▓▓▓▓▓║"
1640 PRINT TAB(J);"│   ║ │ ╔══════════════╗ │ ║        ╠═════╣"
1650 PRINT TAB(J);"│   ║ │ ║              ║ │ ║        ║     ║"
1660 PRINT TAB(J);"W   ║ │ ║              ║ │ ║        ║     ║"
1670 PRINT TAB(J);"│   ║ │ ║              ║ │ ║        ║     ║"
1680 PRINT TAB(J);"│   ║ │ ╚══════════════╝ │ ║        ╠═════╣"
1690 PRINT TAB(J);"│   ║ └──── windings ────┘ ║        ║▓▓▓▓▓║"
1700 PRINT TAB(J);"└─» ╚══════════════════════╝        ╚═════╝"
1710 PRINT
1720 PRINT UL$;
1730 GOSUB 5970
1740 PRINT " ENTER: Overall Length (LG).....................(";UM$;")";:INPUT LG
1750 Z=LG:GOSUB 610:PRINT " ";UM$
1760 PRINT " ENTER: Overall Width (W).......................(";UM$;")";:INPUT W
1770 Z=W:GOSUB 610:PRINT " ";UM$
1780 PRINT " ENTER: Overall Height (H)......................(";UM$;")";:INPUT H
1790 Z=H:GOSUB 610:PRINT " ";UM$
1800 PRINT " ENTER: Coil Thickness (T)......................(";UM$;")";:INPUT T
1810 Z=T:GOSUB 610:PRINT " ";UM$
1820 PRINT " Press number in ( ) to ENTER:"
1830 PRINT " (1) Total number of turns, or";
1840 PRINT " (2) Number of turns per layer and no. of layers"
1850 Y$=INKEY$
1860 IF Y$="1"OR Y$="2"THEN Y%=VAL(Y$):ELSE 1850
1870 CSR=CSRLIN-2:VIEW PRINT CSR TO 24:CLS:VIEW PRINT:LOCATE CSR
1880 IF Y%=1 THEN 1950
1890 INPUT " ENTER: Number of turns per layer....................";N
1900 Z=N:GOSUB 610:PRINT ""
1910 INPUT " ENTER: Number of layers in coil.....................";M
1920 Z=M:GOSUB 610:PRINT ""
1930 N=N*M
1940 GOTO 1990
1950 INPUT " ENTER: Total number of turns........................";N
1960 Z=N:GOSUB 610:PRINT ""
1970 IF X%=2 THEN LG=LG/25.399999618530273! : W=W/25.399999618530273! : H=H/25.399999618530273! : T=T/25.399999618530273!
1980 REM  Formula from EDN; Aug 4, 1982; p164 (RSS Document #M905)
1990 C=LG+W-2*T
2000 L=0.07000000029802322!*C*C*N*N/(1.9079999923706055!*C+9*H+10*T)
2010 PRINT "        INDUCTANCE...................................";USING U$;L;
2020 PRINT " µH (±10%)"
2030 RETURN
2040 :REM'
2050 :REM'.....multi-layer circular coil
2060 PRINT " MULTI-LAYER CIRCULAR COIL INDUCTANCE"
2070 PRINT UL$;
2080 GOSUB 5970
2090 PRINT " ENTER: Inside Diameter of Coil.................(";UM$;")";:INPUT ID
2100 Z=ID:GOSUB 610:PRINT " ";UM$
2110 PRINT " ENTER: Outside Diameter of Coil................(";UM$;")";:INPUT OD
2120 Z=OD:GOSUB 610:PRINT " ";UM$
2130 PRINT " ENTER: Length of Coil..........................(";UM$;")";:INPUT W
2140 Z=W:GOSUB 610:PRINT " ";UM$
2150 PRINT " ENTER: Number of Turns..............................";:INPUT N
2160 Z=N:GOSUB 610:PRINT " ";UM$
2170 IF X%=2 THEN W=W/25.399999618530273! : ID=ID/25.399999618530273! : OD=OD/25.399999618530273!
2180 R=(OD+ID)/4
2190 L=0.800000011920929!*R*R*N*N/(6*R+9*W+5*(OD-ID))
2200 PRINT "        INDUCTANCE...................................";USING U$;L;
2210 PRINT " µH"
2220 RETURN
2230 :REM'
2240 :REM'.....wire parallel to & grounded to ground plane
2250 PRINT " WIRE PARALLEL TO and GROUNDED TO A GROUND PLANE"
2260 PRINT UL$;
2270 PRINT 
2280 T=22
2290 PRINT TAB(T);"     <───────── LG ─────────>"
2300 PRINT TAB(T);"wire ═══════════════════════╗ <──┐"
2310 PRINT TAB(T);"                            ║    │"
2320 PRINT TAB(T);"                            ║    H"
2330 PRINT TAB(T);"                            ║    │"
2340 PRINT TAB(T);"     ────- ground plane ────╨─ <─┘"
2350 PRINT TAB(T);"     \\\\\\\\\\\\\\\\\\\\\\\\\"
2360 PRINT UL$;
2370 GOSUB 5970 : GOSUB 6090
2380 PRINT " ENTER: Length (LG).............................(";UM$;")";:INPUT LG
2390 Z=LG:GOSUB 610:PRINT " ";UM$
2400 PRINT " ENTER: Height (H) above ground plane...........(";UM$;")";:INPUT W
2410 Z=W:GOSUB 610:PRINT " ";UM$
2420 TL=LG+W
2430 PRINT "        Total wire length (LG+H).....................";USING U$;TL;
2440 PRINT " ";UM$
2450 IF X%=2 THEN R=D/2 :ELSE LG=25.399999618530273!*LG : R=12.699999809265137!*D : W=25.399999618530273!*W
2460 REM Equation from 1986 ARRL Handbook
2470 K1=SQR(LG*LG+R*R)
2480 K2=SQR(LG*LG+4*W*W)
2490 L=0.20000000298023224!*LG*LOG((2*W/R)*((LG+K1)/(LG+K2)))+0.20000000298023224!*(K2-K1+(LG/4)-(2*W)+R)
2500 L1=L/10^3
2510 PRINT "        INDUCTANCE for Total Length (LG+H)...........";USING U$;L1;
2520 PRINT " µH"
2530 RETURN
2540 :REM'
2550 :REM'.....wire length parallel to and above ground plane
2560 PRINT " WIRE LENGTH PARALLEL TO AND ABOVE GROUND PLANE"
2570 PRINT UL$;
2580 PRINT 
2590 T=22
2600 PRINT TAB(T);"     <───────── LG ─────────>"
2610 PRINT TAB(T);"wire ════════════════════════ <──┐"
2620 PRINT TAB(T);"                                 │"
2630 PRINT TAB(T);"                                 H"
2640 PRINT TAB(T);"                                 │"
2650 PRINT TAB(T);"     ────- ground plane ───── <──┘"
2660 PRINT TAB(T);"     \\\\\\\\\\\\\\\\\\\\\\\\\"
2670 PRINT UL$;
2680 GOSUB 5970 : GOSUB 6090
2690 INPUT " ENTER: Inductance (µH)..............................";L:
2700 Z=L:GOSUB 610:PRINT " µH"
2710 L=L*10^3    :REM'inductance in nH
2720 PRINT " ENTER: Height (H) above ground plane...........(";UM$;")";:INPUT W
2730 Z=W:GOSUB 610:PRINT " ";UM$
2740 IF X%=2 THEN R=D/2 :ELSE R=12.699999809265137!*D : W=25.399999618530273!*W
2750 X=25
2760 K1=SQR(X*X+R*R)
2770 K2=SQR(X*X+4*W*W)
2780 LG=L/(0.20000000298023224!*LOG((2*W/R)*((X+K1)/(X+K2)))+(0.20000000298023224!*(K2-K1+(X/4)-(2*W)+R))/X)
2790 IF LG>0.9990000128746033!*X AND LG<1.0010000467300415!*X THEN 2810 :ELSE X=LG
2800 GOTO 2760
2810 IF X%=1 THEN LG=LG/25.399999618530273!
2820 PRINT "        WIRE LENGTH (LG).............................";USING U$;LG;
2830 PRINT " ";UM$
2840 GOTO 5900
2850 :REM'
2860 :REM'.....single-layer coil turns
2870 PRINT " SINGLE-LAYER COIL TURNS"
2880 PRINT UL$;
2890 GOSUB 5970
2900 INPUT " ENTER: Inductance..............................(µH)";LR
2910 Z=LR:GOSUB 610:PRINT " µH"
2920 PRINT " ENTER: Coil Length.............................(";UM$;")";:INPUT B
2930 Z=B:GOSUB 610:PRINT " ";UM$
2940 PRINT " ENTER: Coil Inside Diameter....................(";UM$;")";:INPUT ID
2950 Z=ID:GOSUB 610:PRINT " ";UM$
2960 PRINT " ENTER: Total Lead Length.......................(";UM$;")";:INPUT LG
2970 Z=LG:GOSUB 610:PRINT " ";UM$
2980 GOSUB 6090
2990 DIA=ID+D
3000 A=DIA/2
3010 IF X%=2 THEN LG=LG/25.399999618530273! : A=A/25.399999618530273! : B=B/25.399999618530273! : D=D/25.399999618530273! : DIA=DIA/25.399999618530273!
3020 IF LG>0 THEN GOSUB 6530
3030 LI=LR-LW/1000
3040 N=SQR(LI*(9*A+10*B)/(A*A))         :REM'Solve for initial value of N
3050 GOSUB 6400                         :REM'Check inductance for N turns
3060 IF L>1.0010000467300415!*LR OR L<0.9990000128746033!*LR THEN N=N*SQR(LR/L) : GOTO 3050    :REM'Adjust N
3070 IF B>=N*D THEN 3100
3080 PRINT " TOO MANY TURNS - REDUCE WIRE SIZE OR INCREASE COIL LENGTH"
3090 GOTO 3110
3100 PRINT "        NUMBER OF TURNS..............................";USING U$;N
3110 RETURN
3120 :REM'
3130 :REM'.....transmission line inductance
3140 PRINT " TRANSMISSION LINE INDUCTANCE"
3150 PRINT UL$;
3160 PRINT " Press number in < > to choose Line Length unit of measurement:"
3170 PRINT UL$;
3180 PRINT "   <1> Inches"
3190 PRINT "   <2> Centimetres"
3200 PRINT "   <3> Electrical Degrees"
3210 PRINT "   <4> Wavelengths"
3220 Z$=INKEY$:IF VAL(Z$)<1 OR VAL(Z$)>4 THEN 3220
3230 Y%=VAL(Z$)
3240 IF Y%=1 THEN L$="( inches )....."
3250 IF Y%=2 THEN L$="( centimetres )"
3260 IF Y%=3 THEN L$="( ° ).........."
3270 IF Y%=4 THEN L$="( wavelengths )"
3280 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
3290 PRINT " ENTER: Line Length ";L$;".............";:INPUT LG
3300 Z=LG:GOSUB 610:PRINT ""
3310 PRINT UL$;
3320 PRINT " Press number in < > to describe line:"
3330 PRINT UL$;
3340 PRINT "   <1> OPEN line"
3350 PRINT "   <2> SHORTED line"
3360 Z$=INKEY$
3370 IF Z$="1"THEN T$="O":LT$="OPEN":GOTO 3400
3380 IF Z$="2"THEN T$="S":LT$="SHORTED":GOTO 3400
3390 GOTO 3360
3400 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
3410 PRINT "        Line Type.................................... ";LT$
3420 INPUT " ENTER: Characteristic Impedance (ohms)..........";ZO
3430 Z=ZO:GOSUB 610:PRINT ""
3440 IF Y%>2 THEN 3470
3450 INPUT " ENTER: Velocity Factor (decimal)................";V
3460 Z=V:GOSUB 610:PRINT ""
3470 INPUT " ENTER: Frequency (MHz)..........................";F
3480 Z=F:GOSUB 610:PRINT ""
3490 IF Y%=1 THEN LG=LG*F/(11802.900390625!*V)
3500 IF Y%=2 THEN LG=LG*F/(29979.30078125!*V)
3510 IF Y%=3 THEN LG=LG/360
3520 WHILE+ LG>0.5!
3530   LG=LG-0.5!
3540 WEND
3550 PRINT 
3560 IF LG<=0.24899999797344208! OR LG>=0.25099998712539673! THEN 3580
3570 PRINT " LINE IS A QUARTER-WAVE OPEN OR SHORT CIRCUIT":RETURN
3580 IF LG>=0.4950000047683716! AND LG=<0.5! THEN PRINT " LINE IS A HALF-WAVE TRANSFORMER":RETURN
3590 LG=LG*2*PI
3600 IF T$="S" OR T$="s" THEN XL=ZO*TAN(LG) :ELSE XL=-ZO*TAN(LG)
3610 IF XL<0 THEN PRINT " LINE IS CAPACITIVE" :ELSE 3690
3620 C=ABS(1/(2*PI*F*XL))
3630 C1=C*10^6
3640 PRINT "        Capacitance..................................";USING U$;C1;
3650 PRINT " pF"
3660 PRINT "        Reactance....................................";USING U$;XL;
3670 PRINT " Ω"
3680 RETURN
3690 L=XL/(2*PI*F)
3700 PRINT "        Inductance...................................";USING U$;L;
3710 PRINT " µH"
3720 PRINT "        Reactance....................................";USING U$;XL;
3730 PRINT " Ω"
3740 RETURN
3750 :REM'
3760 :REM'.....transmission line length
3770 PRINT " TRANSMISSION LINE LENGTH"
3780 GOSUB 5970
3790 PRINT UL$;
3800 INPUT " ENTER: Inductance................................(µH)";L1:L=L1*10^3
3810 Z=L1:GOSUB 610:PRINT " µH"
3820 INPUT " ENTER: Characteristic Impedance................(ohms)";ZO
3830 Z=ZO:GOSUB 610:PRINT " Ω"
3840 INPUT " ENTER: Velocity Factor (decimal).....................";V
3850 Z=V:GOSUB 610:PRINT ""
3860 INPUT " ENTER: Frequency................................(MHz)";F
3870 Z=F:GOSUB 610:PRINT " MHz"
3880 PRINT UL$;
3890 PRINT " Press number in < > to describe line:"
3900 PRINT UL$;
3910 PRINT "   <1> OPEN line"
3920 PRINT "   <2> SHORTED line"
3930 Z$=INKEY$
3940 IF Z$="1"THEN T$="O":LT$="OPEN":GOTO 3970
3950 IF Z$="2"THEN T$="S":LT$="SHORTED":GOTO 3970
3960 GOTO 3930
3970 VIEW PRINT 7 TO 24:CLS:VIEW PRINT:LOCATE 7
3980 PRINT "        Line Type.................................... ";LT$
3990 XL=2*PI*F*L*0.0010000000474974513!
4000 LG=ATN(XL/ZO)
4010 IF T$="O" OR T$="o" THEN LG=PI-LG
4020 LG=LG/(2*PI)        :REM'wavelength
4030 LGD=LG*360          :REM'degrees
4040 LGI=LG*V*11802.900390625!/F  :REM'inches
4050 PRINT "  LENGTH TO FIRST POINT HAVING";USING U$;L1;:PRINT " µH INDUCTANCE:"
4060 PRINT "        Wavelengths..................................";USING U$;LG
4070 PRINT "        Electrical Degrees...........................";USING U$;LGD
4080 IF X%=2 THEN 4110
4090 PRINT "        Inches.......................................";USING U$;LGI
4100 GOTO 4120
4110 LGI=LGI*2.5399999618530273!
4120 IF X%=1 THEN 4140
4130 PRINT "        Centimetres..................................";USING U$;LGI
4140 WLFS=29979.30078125!/F       :REM'wavelength in free space in centimetres
4150 HWC=V*WLFS/2         :REM'½ wavelength in cable with velociy factor V
4160 IF X%=1 THEN K=2.5399999618530273!:K$="in.":ELSE K=1:K$="cm."
4170 PRINT "  LENGTHS TO OTHER POINTS ALSO HAVING";USING U$;L1;
4180 PRINT " µH INDUCTANCE:"
4190 PRINT "        (measurements from end of cable):"
4200 FOR Z=1 TO 9
4210 PRINT TAB(26);USING V$;LGI+Z*HWC/K;:PRINT " ";K$
4220 NEXT Z
4230 PRINT TAB(30);"continuing onward at";USING V$;HWC/K;
4240 PRINT " ";K$;" intervals.";
4250 RETURN
4260 :REM'
4270 :REM'.....straight wire inductance
4280 PRINT " STRAIGHT WIRE INDUCTANCE"
4290 PRINT UL$;
4300 GOSUB 5970 : GOSUB 6090
4310 PRINT " ENTER: Wire Length.............................(";UM$;")";:INPUT LG
4320 Z=LG:GOSUB 610:PRINT " ";UM$
4330 IF X%=2 THEN LG=LG/25.399999618530273! : D=D/25.399999618530273!
4340 GOSUB 6530
4350 L1=LW/10^3    :REM'inductance in µH
4360 PRINT "        INDUCTANCE...................................";USING U$;L1;
4370 PRINT " µH"
4380 RETURN
4390 :REM'
4400 :REM'.....multi-layer bobbin-wound coil
4410 REM  This routine adapted from program written by Thomas N. Lockyer and
4420 REM  published in March 17, 1983 issue of "EDN"
4430 PRINT " MULTI-LAYER BOBBIN-WOUND COIL DESIGN"
4440 PRINT UL$;
4450 PRINT " DIMENSIONS MUST BE ENTERED IN INCHES"
4460 PRINT UL$;
4470 PRINT " Press number in ( ) to indicate shape of bobbin:"
4480 PRINT UL$;
4490 PRINT "   (1) Round"
4500 PRINT "   (2) Rectangular"
4510 J$=INKEY$:IF J$="1"OR J$="2"THEN J%=VAL(J$):GOTO 4520 :ELSE 4510
4520 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
4530 :REM'
4540 :REM' .....diagram
4550 IF J%=1 THEN V$="Circular, D diameter":ELSE V$="Rectangular, W x H"
4560 T=16
4570 PRINT TAB(T);"      ──»│  LG  │«──"
4580 PRINT
4590 PRINT TAB(T);"          ▓▓▓▓▓▓"
4600 PRINT TAB(T);"         ╠══════╣"
4610 PRINT TAB(T);"Bobbin ──╫──»   ║<─- End View is ";V$
4620 PRINT TAB(T);"         ╠══════╣"
4630 PRINT TAB(T);"          ▓▓▓▓▓▓<─── windings build-up"
4640 PRINT
4650 PRINT UL$;
4660 :REM'
4670 INPUT " ENTER: Desired Inductance.......................(µH)";H1
4680 Z=H1:GOSUB 610:PRINT " µH"
4690 :REM'
4700 IF J%=2 THEN 4730
4710 INPUT " ENTER: Length (LG) of circular coil............(in.)";L
4720 GOTO 4740
4730 INPUT " ENTER: Length (LG) of Rectangular Coil.........(in.)";L
4740 Z=L:GOSUB 610:PRINT " in."
4750 :REM'
4760 COLOR 0,7
4770 PRINT " NOTE: The estimated thickness of coil build-up must not be less ";
4780 PRINT "than 0.003";CHR$(34);" "
4790 COLOR 7,0
4800 INPUT " ENTER: Estimated thickness of coil build-up....(in.)";B
4810 CSR=CSRLIN-2:VIEW PRINT CSR TO 24:CLS:VIEW PRINT:LOCATE CSR
4820 IF B<0.003000000026077032! THEN BEEP:GOTO 4760
4830 PRINT "        Estimated thickness of coil build-up.........";USING U$;B;
4840 PRINT " in."
4850 :REM'
4860 PRINT " MUST INDUCTOR CARRY A SPECIFIED CURRENT? (y/n) "
4870 Z$=INKEY$
4880 IF Z$="N" OR Z$="n" THEN GOSUB 4910:GOTO 5030
4890 IF Z$="Y" OR Z$="y" THEN GOSUB 4910:GOTO 4940
4900 GOTO 4870
4910 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
4920 RETURN
4930 :REM'
4940 COLOR 0,7
4950 PRINT " NOTE: Current must be between .019 A. and 21.0 A. "
4960 COLOR 7,0
4970 INPUT " ENTER: Required current.......................(amps)";A2
4980 CSR=CSRLIN-2:VIEW PRINT CSR TO 24:CLS:VIEW PRINT:LOCATE CSR
4990 IF A2<0.01899999938905239! OR A2>21 THEN BEEP:GOTO 4940
5000 PRINT "        Required current (amps)......................";USING U$;A2;
5010 PRINT " amps"
5020 :REM'
5030 IF J%=1 THEN 5120
5040 INPUT " ENTER: Width (W) of Rectangular Bobbin.........(in.)";Y
5050 Z=Y:GOSUB 610:PRINT " in."
5060 INPUT " ENTER: Height (H) of Rectangular Bobbin........(in.)";D
5070 Z=D:GOSUB 610:PRINT " in."
5080 C=D+Y+2*B
5090 Z=1.9079999923706055!*C
5100 GOTO 5150
5110 :REM'
5120 INPUT " ENTER: Diameter (D) of Circular Bobbin.........(in.)";D
5130 Z=D:GOSUB 610:PRINT " in."
5140 C=(D/2)+(B/2)
5150 K=9*L
5160 M=10*B
5170 IF J%=1 THEN 5220
5180 T=H1*(Z+K+M)
5190 P=T/0.07000000029802322!
5200 N=SQR(P)/C
5210 GOTO 5260
5220 V=6*C
5230 T=H1*(V+K+M)
5240 P=T/0.800000011920929!
5250 N=SQR(P)/C
5260 A=SQR((B*L)/N)*800
5270 C1=A*A
5280 A1=C1/500
5290 REM  Calc wire size (10 to 40 AWG) and circular mils
5300 E=10
5310 FOR E=10 TO 40
5320   D1=10380
5330   F=E-9
5340   FOR G=1 TO F
5350     D1=D1-0.2070000022649765!*D1
5360   NEXT G
5370   IF D1<C1 THEN 5390
5380 NEXT E
5390 IF Z$="N" OR Z$="n" THEN 5530 :ELSE PFLAG%=PFLAG%+1
5400 IF PFLAG%=1 THEN PRINT " .......calculating - please wait!......."
5410 REM  Determines wire size for specified current
5420 IF A1/A2<1.0099999904632568! THEN 5470
5430 IF A1>A2 THEN 5450
5440 GOTO 5470
5450 B=B-0.05000000074505806!*B
5460 IF J%=1 THEN 5140 :ELSE 5080
5470 IF A2/A1<1.0099999904632568! THEN 5530
5480 IF A1<A2 THEN 5500
5490 GOTO 5530
5500 B=B+0.05000000074505806!*B
5510 IF J%=1 THEN 5140 :ELSE 5080
5520 :REM'
5530 S=A*N/(L*800)
5540 IF A1>21 THEN PRINT "Estimated coil build-up is too large - redesign!" : RETURN
5550 IF A1<0.01899999938905239! THEN PRINT "Estimated coil build-up is too small - redesign!" : RETURN
5560 IF S<0.8999999761581421! THEN PRINT "Less than one coil layer - respecify coil length!" : RETURN
5570 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
5580 PRINT "        Number of Turns..............................";USING U$;N
5590 PRINT "        Required Coil Build-up.......................";USING U$;B;
5600 PRINT " in."
5610 PRINT "        Circular mils per turn available.............";USING U$;C1
5620 PRINT "        Max.Current @ 500 cm per amp.................";USING U$;A1;
5630 PRINT " amps"
5640 U$="####"
5650 PRINT "        Wire Size...................................#";USING U$;E;
5660 PRINT " AWG"
5670 IF S-FIX(S)>0 THEN S=FIX(S)+1
5680 PRINT "        Number of Layers.............................";USING U$;S;
5690 RETURN
5700 :REM'
5710 :REM'.....straight wire length
5720 PRINT " STRAIGHT WIRE LENGTH"
5730 PRINT UL$;
5740 GOSUB 5970 : GOSUB 6090
5750 INPUT " ENTER: Inductance (µH)..............................";L:
5760 Z=L:GOSUB 610:PRINT " µH"
5770 L=L*10^3   :REM'inductance in nH
5780 IF X%=2 THEN D=D/25.399999618530273!
5790 X=1
5800 LG=0.19599999487400055!*L/(LOG(4*X/D)-1)
5810 IF LG>0.9990000128746033!*X AND LG<1.0010000467300415!*X THEN 5830 :ELSE X=LG
5820 GOTO 5800
5830 IF X%=2 THEN LG=LG*25.399999618530273!
5840 PRINT "        WIRE LENGTH..................................";USING U$;LG;
5850 PRINT " ";UM$
5860 RETURN
5870 :REM'
5880 :REM'.....error message
5890 PRINT : PRINT " NO SOLUTION FOR THE DATA ENTERED"
5900 :REM'
5910 :REM'.....end
5920 GOSUB 6630:CLS:GOTO 30
5930 END
5940 :REM'
5950 :REM'************ sub routines ************
5960 :REM'
5970 :REM'.....metric/imperial
5980 PRINT " Press number in < > to choose standard system of measurement:"
5990 PRINT UL$;
6000 PRINT "   < 1 > Metric"
6010 PRINT "   < 2 > U.S.A./Imperial"
6020 X$=INKEY$
6030 IF X$="1"THEN X%=2:UM$="mm.":GOTO 6060
6040 IF X$="2"THEN X%=1:UM$="in.":GOTO 6060
6050 GOTO 6020
6060 CSR=CSRLIN-5:VIEW PRINT CSR TO 24:CLS:VIEW PRINT:LOCATE CSR
6070 RETURN
6080 :REM'
6090 :REM'.....wire size
6100 IF X%=2 THEN 6210
6110 PRINT " Do you want to enter wire diameter by its AWG size?   (y/n)"
6120 Z$=INKEY$
6130 IF Z$="y"OR Z$="Y" THEN 6160
6140 IF Z$="n"OR Z$="N"THEN 6200
6150 GOTO 6120
6160 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
6170 INPUT " ENTER: Wire Size (even no. from 10 to 40)...........";Z%
6180 GOTO 6250
6190 :REM'
6200 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
6210 PRINT " ENTER: Wire Diameter...........................(";UM$;")";:INPUT D
6220 Z=D:GOSUB 610:PRINT " ";UM$
6230 RETURN
6240 :REM'
6250 IF Z%>=10 AND Z%<=40 AND Z%/2=INT(Z%/2) THEN 6280
6260 BEEP:GOTO 6160
6270 :REM'
6280 FOR J=10 TO Z% STEP 2
6290   READ D
6300 NEXT J
6310 CSR=CSRLIN-1:VIEW PRINT CSR TO 24:CLS:VIEW PRINT:LOCATE CSR
6320 PRINT "        Wire Diameter................................";USING U$;D;
6330 PRINT " ";UM$;" (#";Z%;"AWG )"
6340 GOTO 6220
6350 :REM'
6360 REM **********************************************************************
6370 INPUT"DO YOU WANT TO ENTER DIMENSIONS IN (1) INCHES OR (2) CENTIMETERS ";X%
6380 IF X%<1 OR X%>2 THEN PRINT "Please enter 1 or 2" : GOTO 6370
6390 RETURN
6400 REM *********************************************************************
6410 REM  W6GGV's equations
6420 P=B/N                            :REM'NOTE ==> 1/pitch
6430 G=(5/4)-LOG(2*P/D)
6440 H=0.335999995470047!*(1-(2.5!/N)+(3.799999952316284!/N^2)-(2.5!/N^3)-(0.8299999833106995!/N^4))+0.004000000189989805!
6450 R=B/DIA : C=LOG(4/R)
6460 IF 2*A/B >= 1 THEN K=(2*R/PI)*((C-1/2)+((R^2)/8)*(C+1/8)-((R^4)/64)*(C-2/3)+((5*R^6)/1024)*(C-109/120))
6470 IF 2*A/B < 1 THEN K=1-(8*A)/(3*PI*B)+A^2/(2*B^2)-A^4/(4*B^4)+(5*A^6)/(16*B^6)-(35*A^8)/(64*B^8)+(147*A^10)/(128*B^10)
6480 L=(5.079999923706055!*PI^2*A*N^2*K)/(B/(2*A))-(10.199999809265137!*PI*N*(G+H)*A)
6490 IF LG>0 THEN GOSUB 6530
6500 L=(L+LW)/1000
6510 RETURN
6520 :REM'
6530 :REM'.....inductance of straight wire
6540 REM  Inductance of straight wire in nH
6550 LW=5.079999923706055!*LG*(LOG((4*LG)/D)-0.75!)
6560 RETURN
6570 :REM'
6580 :REM'.....data
6590 REM  Data are dia in inches of even-number wire sizes from #10 to #40 AWG
6600 DATA .1019,.08081,.06408,.05082,.0403,.03196,.02535,.0201,.01594,.01264
6610 DATA .01003,.00795,.006305,.005,.003965,.003145
6620 :REM'
6630 :REM'PRT
6640 KEY OFF:GOSUB 6710:LOCATE 25,5:COLOR 0,2
6650 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
6660 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
6670 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 6670 :ELSE GOSUB 6710
6680 IF Z$="3"THEN RETURN
6690 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
6700 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 6640
6710 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
