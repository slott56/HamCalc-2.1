10 :REM'OPENWIRE - Open Wire Feeders - 28 JAN 94 rev. 06 JAN 2004
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)
70 COLOR 7,0,1
80 LF=1/LOG(10)           :REM'log factor to convert to log base 10
90 E$=STRING$(79,32)      :REM'line blanker
100 UL$=STRING$(80,205)
110 :REM'
120 :REM'.....AWG calculator
130 DIM GA(40)             :REM'AWG sizes
140 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
150 FOR Z=1 TO 40
160 N=Z+3
170 GA(Z)=0.46000000834465027!/K^N
180 NEXT Z
190 DIM T(8,6)
200 :REM'
210 :REM'.....start
220 CLS
230 COLOR 15,2
240 PRINT " TRANSMISSION LINES - OPEN WIRE";
250 PRINT TAB(57);"by George Murphy VE3ERP ";
260 COLOR 1,0:PRINT STRING$(80,223);
270 COLOR 7,0
280 GOSUB 4160
290 PRINT UL$;
300 PRINT " Press number in < > to choose standard units of measure:"
310 PRINT "   < 1 >  Metric"
320 PRINT "   < 2 >  U.S.A./Imperial"
330 PRINT UL$;
340 PRINT "     or Press < 0 > to EXIT....."
350 Z$=INKEY$
360 IF Z$="0"THEN CLS:CHAIN GO$
370 IF Z$="1"THEN UM=25.399999618530273!:UM$="mm":GOTO 400
380 IF Z$="2"THEN UM=1:UM$="in.":GOTO 400
390 GOTO 350
400 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
410 COLOR 0,7:PRINT " Press number in < > to:":COLOR 7,0
420 PRINT UL$;
430 PRINT "  < 1 >  Find IMPEDANCE of single horizontal wire line"
440 PRINT "  < 2 >  Find IMPEDANCE and LOSS of 2-wire line"
450 PRINT "  < 3 >  Find SPACING and LOSS of 2-wire line"
460 PRINT "  < 4 >  Find IMPEDANCE of 4-wire line"
470 PRINT "  < 5 >  Design Parallel Transmission Line with Square Conductors"
480 PRINT "          (Algorithm by Steve Stearns, K6OIK)"
490 PRINT "  < 6 >  List characteristics of U.S.A. standard open-wire ";
500 PRINT "transmission lines"
510 REM CQ, July 2001, pp.34-35
520 PRINT "  < 7 >  List dimensions of typical open-wire lines "
530 PRINT UL$;
540 PRINT " NOTE:"
550 PRINT " Spacing in this program refers to centre-to-centre distance ";
560 PRINT "between conductors."
570 Z$=INKEY$
580 IF Z$="1"THEN 860
590 IF Z$="2"THEN 1050
600 IF Z$="3"THEN 1270
610 IF Z$="4"THEN 1610
620 IF Z$="5"THEN 1990
630 IF Z$="6"THEN 3020
640 IF Z$="7"THEN 3430
650 GOTO 570
660 :REM'
670 :REM'.....input wire size
680 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
690 PRINT " Press number in < > to indicate how you wish to enter conductor ";
700 PRINT "size:"
710 PRINT UL$;
720 PRINT "   < 1 >  by diameter in millimetres"
730 PRINT "   < 2 >  by diameter in decimal inches"
740 PRINT "   < 3 >  by AWG #"
750 Z$=INKEY$:IF Z$=""THEN 750
760 IF Z$="1"THEN DIA=25.399999618530273!:D$="( mm )..":GOTO 800
770 IF Z$="2"THEN DIA=1:D$="( in.)..":GOTO 800
780 IF Z$="3"THEN DIA=0:D$="( AWG #)":GOTO 800
790 GOTO 750
800 PRINT UL$;
810 PRINT " ENTER: Conductor size ";D$;".....";:INPUT D
820 IF Z$="3"THEN AWG=D :ELSE AWG=0
830 IF DIA THEN D=D/DIA :ELSE D=GA(D)
840 RETURN
850 :REM'
860 :REM'.....single wire impedance calculation
870 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
880 GOSUB 660
890 PRINT " ENTER: Height of wire above ground plane (";UM$;")";
900 INPUT H:H=H/UM
910 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
920 PRINT " Impedance of a Single Wire transmission line"
930 PRINT UL$;
940 Z=LF*138*LOG(4*H/D)
950 PRINT " Wire diameter.....................";USING "#####.###";D*UM;
960 PRINT " ";UM$;:IF AWG THEN PRINT " ( AWG# ";USING "##";AWG;:PRINT " )";
970 PRINT ""
980 PRINT " Distance away from ground plane...";USING "#####.#";H*UM;
990 PRINT " ";UM$
1000 PRINT " Impedance.........................";USING "#####.#";Z;:PRINT" Ω"
1010 COLOR 7,0
1020 PRINT UL$;
1030 GOTO 4220
1040 :REM'
1050 :REM'.....2-wire impedance calculation
1060 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1070 GOSUB 670
1080 PRINT " ENTER: c.c. spacing of wires (";UM$;") ";
1090 INPUT S:S=S/UM
1100 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1110 PRINT " Impedance of a 2-Wire Open-Wire transmission line:"
1120 PRINT UL$;
1130 IF S<D THEN 1550    :REM'spacing less than diameter
1140 X=S/D:Z=119.91699981689453!*LOG(X+SQR(X^2-1)):X=0
1150 REM 'Z=LF*276*LOG(2*S/D) - approximate - not valid a very close spacing
1160 PRINT " Wire spacing (c.c)................";USING "###.###";S*UM;
1170 PRINT " ";UM$
1180 PRINT " Wire diameter.....................";USING "###.###";D*UM;
1190 PRINT " ";UM$;
1200 IF AWG THEN PRINT " ( AWG# ";USING "##";AWG;:PRINT " )":ELSE PRINT ""
1210 PRINT " Gap between wires.................";USING "###.###";UM*(S-D);
1220 PRINT " ";UM$
1230 PRINT " Spacing/diameter ratio............";USING "###.###:1";S/D
1240 PRINT " Impedance.........................";USING "###.###";Z;:PRINT" Ω"
1250 GOTO 3180
1260 :REM'
1270 :REM'.....2-wire spacing calculation
1280 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1290 GOSUB 670
1300 INPUT " ENTER: Desired impedance of line in ohms.........";Z
1310 LOCATE 3:VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1320 :REM'
1330 PRINT " Spacing of a 2-wire open transmission line:"
1340 PRINT UL$;
1350 :REM'
1360 X=0:K=100
1370 X=X+K
1380 Y=119.91699981689453!*LOG(X+SQR(X^2-1))
1390 IF ABS(Y-Z)<9.999999747378752e-05! THEN 1420
1400 IF Y>Z THEN X=X-K:K=K/10
1410 GOTO 1370
1420 S=X*D
1430 :REM'
1440 IF S<D THEN 1550       :REM'spacing less than diameter
1450 PRINT " Impedance.........................";USING "###.###";Z;:PRINT" Ω"
1460 PRINT " Wire spacing (c.c.)...............";USING "###.###";S*UM;
1470 PRINT " ";UM$
1480 PRINT " Wire diameter.....................";USING "###.###";D*UM;
1490 PRINT " ";UM$;
1500 IF AWG THEN PRINT " ( AWG# ";USING "##";AWG;:PRINT " )":ELSE PRINT ""
1510 PRINT " Gap between wires.................";USING "###.###";UM*(S-D);
1520 PRINT " ";UM$
1530 PRINT " Spacing/diameter ratio............";USING "###.###:1";S/D
1540 IF S>D THEN 1590
1550 BEEP:PRINT " NOT POSSIBLE! Wire diameter exceeds spacing!"
1560 PRINT " Press any key.................."
1570 IF INKEY$=""THEN 1570
1580 CLS:GOTO 210
1590 GOTO 3180
1600 :REM'
1610 :REM'.....4-wire calculation
1620 GOSUB 660
1630 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1640 R=0    :REM'row
1650 C=34   :REM'column
1660 LOCATE R+3,C:PRINT "      A"
1670 LOCATE R+4,C:PRINT "      ■"
1680 LOCATE R+5,C:PRINT "      |"
1690 LOCATE R+6,C:PRINT "C ■-- + --■ D"
1700 LOCATE R+7,C:PRINT "      |"
1710 LOCATE R+8,C:PRINT "      ■"
1720 LOCATE R+9,C:PRINT "      B"
1730 PRINT UL$;
1740 T$=" IMPEDANCE OF 4-wire OPEN-WIRE TRANSMISSION LINE "
1750 LOCATE CSRLIN,16:COLOR 15,2:PRINT T$:COLOR 7,0
1760 PRINT UL$;
1770 PRINT " ENTER: Dimension AC or BD (";UM$;") ";
1780 INPUT S1:S1=S1/UM
1790 PRINT " ENTER: Dimension AD or BC (";UM$;") ";
1800 INPUT S2:S2=S2/UM
1810 S3=SQR(S1^2+S2^2)
1820 VIEW PRINT 13 TO 24:CLS:VIEW PRINT:LOCATE 13
1830 Z=LF*138*LOG(2*S2/(D*SQR(1+(S2/S1)^2)))
1840 PRINT " Wire diameter.............................";USING "####.###";D*UM;
1850 PRINT " ";UM$;:IF AWG THEN PRINT " ( AWG# ";USING "##";AWG;:PRINT " )";
1860 PRINT ""
1870 PRINT " Distance from wires A to C and B to D.....";USING "####.###";S1*UM;
1880 PRINT " ";UM$
1890 PRINT " Distance from wires A to D and B to C.....";USING "####.###";S2*UM;
1900 PRINT " ";UM$
1910 PRINT " Distance from wires A to B and C to D.....";USING "####.###";S3*UM;
1920 PRINT " ";UM$
1930 PRINT " Impedance.................................";USING "####.###";Z;
1940 PRINT " Ω"
1950 PRINT UL$;
1960 COLOR 7,0
1970 GOTO 4220
1980 :REM'
1990 :REM'.....square conductor line
2000 CLS:KEY OFF:COLOR 7,0 :PI=4*ATN(1)
2010 UL$=STRING$(80,205)
2020 T$=" IMPEDANCE and SPACING of PARALLEL TRANSMISSION LINE with SQUARE "
2030 T$=T$+"CONDUCTORS"
2040 LOCATE ,(80-LEN(T$))/2:PRINT T$
2050 PRINT UL$;
2060 LN=CSRLIN
2070 PRINT " Characteristic impedances of any value are possible in open-wire ";
2080 PRINT "line that is "
2090 PRINT " constructed using conductors of any shape, round and square being";
2100 PRINT " the most    "
2110 PRINT " common. Open-wire transmission lines made of square conductors sh";
2120 PRINT "ow up, for   "
2130 PRINT " example, when square tubing is used for gamma matches or log-peri";
2140 PRINT "odic antenna "
2150 PRINT " booms."
2160 PRINT
2170 PRINT " This program calulates Zo for a given gap width or the gap for a";
2180 PRINT " given Zo in square transmission lines with flat sides facing."
2190 PRINT UL$;
2200 LN=CSRLIN
2210 PRINT
2220 IF UM THEN 2300
2230 VIEW PRINT LN TO 24:VIEW PRINT:LOCATE LN+1
2240 PRINT " Want dimensions in (m)illimetres or (i)nches?     (m/i)   "
2250 Z$=INKEY$:IF Z$=""THEN 2250
2260 IF Z$="m"THEN UM=25.399999618530273!:UM$="mm.":GOTO 2300
2270 IF Z$="i"THEN UM=1   :UM$="in.":GOTO 2300
2280 GOTO 2250
2290 :REM'
2300 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
2310 :REM'
2320 :REM'.....start
2330 PRINT " ENTER: Width of one side of square conductor (";UM$;").......";
2340 INPUT W:W=W/UM
2350 D=1.180340051651001!*W
2360 PRINT
2370 PRINT " Do you want to find conductor (s)pacing or line (i)mpedance?  (s/i)"
2380 Z$=INKEY$:IF Z$=""THEN 2380
2390 IF Z$="s"THEN 2550
2400 IF Z$="i"THEN 2420
2410 :REM'
2420 :REM'.....find Zo
2430 PRINT
2440 PRINT " ENTER: Gap between conductors (";UM$;")";:INPUT G:G=G/UM
2450 IF G<GAP THEN BEEP:GOTO 2440
2460 S=(W+G)  :REM'c.c. spacing
2470 SW=S/W :IF SW>2.63355792# THEN 2520  :REM'S/W ratio
2480 EQ1=1/(SW-1)
2490 EQ2=2/PI*(LOG(SW/(SW-1)))
2500 EQ3=1/(SW^0.33333298563957214!-0.10000000149011612!)
2510 ZO=376.73028564453125!/(EQ1+0.4830000102519989!+EQ2+EQ3):GOTO 2720
2520 X=SW/1.180340599#:ZO=119.9169832#*LOG(X+SQR(X^2-1))
2530 GOTO 2720
2540 :REM'
2550 :REM'.....find S by iteration
2560 PRINT
2570 INPUT " ENTER: Impedance of line (ohms)";ZO
2580 IF ZO<0 THEN BEEP:GOTO 2560
2590 G=0:K=1
2600 G=G+K
2610 S=W+G     :REM'spacing
2620 SW=S/W :IF ZO>172.82310999999999# THEN 2670
2630 EQ1=1/(SW-1)
2640 EQ2=2/PI*(LOG(SW/(SW-1)))
2650 EQ3=1/(SW^0.33333298563957214!-0.10000000149011612!)
2660 ZX=376.73028564453125!/(EQ1+0.4830000102519989!+EQ2+EQ3) :GOTO 2680
2670 X=SW/1.180340599#:ZX=119.9169832#*LOG(X+SQR(X^2-1))
2680 IF ABS(ZX-ZO)<9.999999747378752e-05! THEN 2720
2690 IF ZX>ZO THEN G=G-K:K=K/10
2700 GOTO 2600
2710 :REM'
2720 :REM'.....display results
2730 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
2740 PRINT " Width of one side of square conductor ....W=";
2750 PRINT USING " ###.### in. = ####.# mm";W,W*25.399999618530273!
2760 PRINT " Gap between conductors ...................G=";
2770 PRINT USING " ###.### in. = ####.# mm";S-W,(S-W)*25.399999618530273!
2780 PRINT " Conductor c.c. spacing....................S=";
2790 PRINT USING " ###.### in. = ####.# mm";S,S*25.399999618530273!
2800 PRINT " Spacing/Width ratio.....................S/W=";
2810 PRINT USING " ###.###:1";SW
2820 PRINT " Characteristic impedance of line.........Zo=";
2830 PRINT USING " ###.### ohms";ZO
2840 PRINT
2850 IF SW<3 THEN 2870
2860 :REM'
2870 COLOR 0,7:LOCATE ,23:PRINT " (r)un program?  (q)uit?    (r/q) ":COLOR 7,0
2880 Z$=INKEY$:IF Z$=""THEN 2880
2890 IF Z$="r"THEN 2220
2900 IF Z$="q"THEN 210
2910 GOTO 2880
2920 END
2930 LOCATE ,14:PRINT " may be unreliable and should be empirically tested. "
2940 COLOR 7,0:PRINT
2950 :REM'
2960 COLOR 0,7:LOCATE ,23:PRINT " (r)un program?  (q)uit?    (r/q) ":COLOR 7,0
2970 Z$=INKEY$:IF Z$=""THEN 2970
2980 IF Z$="r"THEN 2300
2990 IF Z$="q"THEN 210
3000 GOTO 2970
3010 :REM'
3020 :REM'.....open wire characteristics
3030 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
3040 PRINT "                                       Velocity"
3050 PRINT " Type                       Impedance   Factor  pF/ft."
3060 PRINT UL$;
3070 PRINT " Open Wire, #12 AWG             600 Ω    0.92    1.1"
3080 PRINT " 75 Ω  transmitting twin lead    75 Ω    0.67   19.0"
3090 PRINT " 300 Ω twin lead                300 Ω    0.80    5.8"
3100 PRINT " 300 Ω tubular                  300 Ω    0.80    5.8"
3110 PRINT
3120 PRINT " TV ";CHR$(34);"Window";CHR$(34);" type (#18 conductors):"
3130 PRINT " 1/2 in.(12.7mm) spacing        300 Ω    0.95     -"
3140 PRINT " 1.0 in.(25.4mm) spacing        450 Ω    0.91    4.0"
3150 PRINT UL$;
3160 GOTO 4220
3170 :REM'
3180 :REM'.....loss calculations according to Wes Stewart, N7WS
3190 IF UM=1 THEN M$="feet":ELSE M$="metres"
3200 PRINT " ENTER: Line Length ( ";M$;" )....";:INPUT LG
3210 IF UM=2 THEN LG=LG*0.30480000376701355!
3220 INPUT " ENTER: Frequency (MHz).........";F
3230 LOCATE CSRLIN-2:PRINT E$:PRINT E$:LOCATE CSRLIN-2
3240 PRINT " Frequency.........................";USING "###.###";F;:PRINT " MHz"
3250 X=(S/D)
3260 E=14400*(LOG(X+SQR(X*X-1))^2)/Z^2   :REM'log(x+√(x*x-1)) = acosh(x)
3270 U$="###.###"
3280 PRINT " Effective Dielectric Constant.....";USING U$;E
3290 PRINT " Power Factor......................";USING U$;0;:PRINT " (assumed)"
3300 RT=(0.20000000298023224!/D)*F^0.5!
3310 A=4.340000152587891!*RT/(Z+(2.7799999713897705!*((F*E)^0.5!)*F*P))
3320 PRINT " Unit Loss.........................";USING U$;A;
3330 PRINT " dB/100 feet"
3340 PRINT "                                  =";USING U$;A/0.30480000376701355!;
3350 PRINT " dB/100 metres"
3360 IF UM=1 THEN M=1 :ELSE M=0.30480000376701355!
3370 PRINT " Line Length.......................";USING U$;LG;:PRINT " ";M$
3380 PRINT " Line Loss.........................";USING U$;LG/100*A/M;
3390 PRINT " dB"
3400 PRINT UL$;
3410 GOTO 4220
3420 :REM'
3430 :REM'.....table of dimensions
3440 CLS
3450 PRINT " The spacings shown are the approximate dimensions produced by th";
3460 PRINT "e equation    "
3470 PRINT " Zo=276 log(2s/d). For more exact spacing, run menu item <3> in t";
3480 PRINT "his program.  "
3490 PRINT UL$;
3500 PRINT " Press letter in < > to select range of impedances, or 0 to retur";
3510 PRINT "n to the menu."
3520 PRINT UL$;
3530 PRINT "   <a>  100-200-300-400 ohms"
3540 PRINT "   <b>  150-300-450-600 ohms"
3550 Z$=INKEY$:IF Z$=""THEN 3550
3560 IF Z$="a"THEN SEED=100:GOTO 3600
3570 IF Z$="b"THEN SEED=150:GOTO 3600
3580 IF Z$="0"THEN CLS:GOTO 410
3590 GOTO 3550
3600 FOR J=1 TO 4:Z(J)=SEED*J:NEXT J
3610 CLS
3620 IF UM=25.399999618530273! THEN UM$="MILLIMETRES":ELSE UM$="INCHES"
3630 WW=1.125!
3640 FOR J=1 TO 7:WW=WW-0.125!:W(J,1)=WW:NEXT J
3650 FOR J=0 TO 7
3660  T(J,1)=J*2+4       :REM'AWG no.
3670  T(J,2)=GA(T(J,1))  :REM'wire dia.
3680 NEXT J
3690 FOR I=1 TO 4
3700  N=I*SEED/276:Q=10^N
3710 FOR J=0 TO 7
3720  T(J,I+2)=Q/2*T(J,2)
3730 NEXT J:NEXT I
3740 :REM'
3750 IF UM=25.399999618530273! THEN V$="#####.#    ":ELSE V$="###.##     "
3760 PRINT " Typical Open-Wire Transmission Lines (all dimensions in ";UM$;"):"
3770 PRINT UL$;
3780 PRINT "  AWG     Conductor   ⌐ Conductor spacing (centre-to-centre) ¬"
3790 PRINT "  Size       Dia.";
3800 FOR J=1 TO 4:PRINT USING "######### Ω";Z(J);:NEXT J
3810 PRINT "  «─── Impedance"
3820 PRINT UL$;
3830 FOR I=1 TO 7:PRINT TAB(11)USING V$;W(I,1)*UM;
3840  FOR J=1 TO 4
3850  N=J*SEED/276:Q=10^N:S=Q/2*W(I,1)*UM:PRINT USING V$;S;
3860 NEXT J:PRINT "":NEXT I
3870 FOR I=0 TO 7
3880 PRINT " AWG# ";USING "##  ";T(I,1);
3890 FOR J=2 TO 6
3900 PRINT USING V$;T(I,J)*UM;
3910 NEXT J:PRINT "":NEXT I
3920 PRINT UL$;
3930 :REM'
3940 LN=CSRLIN:COLOR 15,1
3950 LOCATE LN:PRINT " Do you want some other conductor diameter?  (y/n) "
3960 COLOR 7,0
3970 Z$=INKEY$:IF Z$=""THEN 3970
3980 IF Z$="n"THEN GOSUB 4120:GOTO 4220
3990 IF Z$="y"THEN 4010
4000 GOTO 3970
4010 GOSUB 4120
4020 COLOR 0,7:PRINT " ENTER: Wire diameter in "+UM$+" ";:INPUT D
4030 COLOR 7,0:GOSUB 4120
4040 PRINT TAB(11);USING V$;D;
4050 FOR I=1 TO 4
4060 N=I*SEED/276:Q=10^N:S=Q/2*D
4070 PRINT USING V$;S;
4080 NEXT I:REM':PRINT ""
4090 GOTO 3940
4100 END
4110 :REM'
4120 :REM'.....clear to bottom
4130 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
4140 RETURN
4150 :REM'
4160 :REM'.....prologue
4170 PRINT " This program calculates impedance, dimensions, and other proper";
4180 PRINT "ties of round "
4190 PRINT " and square conductor open-wire transmission lines.             "
4200 RETURN
4210 :REM'
4220 :REM'.....end
4230 GOSUB 4270
4240 GOTO 210   :REM'start
4250 END
4260 :REM'
4270 :REM'.....PRT
4280 KEY OFF:GOSUB 4350:LOCATE 25,5:COLOR 0,2
4290 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
4300 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
4310 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 4310 :ELSE GOSUB 4350
4320 IF Z$="3"THEN RETURN
4330 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
4340 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 4280
4350 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
