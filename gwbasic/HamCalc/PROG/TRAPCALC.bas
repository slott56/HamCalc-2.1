10 :REM'TRAPCALC - Trap Design Calculator - 24 JUL 2001 rev. 30 MAY 18
20 CLS:KEY OFF
30 COMMON EX$,PROG$,NN,UH,LL,DD,WW,FF,CC
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 IF EX$=""THEN EX$="EXIT"
60 PROG$="trapcalc"
70 COLOR 7,0,1
80 PI=4*ATN(1)  :REM'3.141593
90 UL$=STRING$(80,205)
100 :REM'
110 :REM'.....title page
120 CLS
130 COLOR 15,2
140 PRINT " Trap Design Calculator"TAB(57)"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 GOSUB 1950  :REM'preface
180 PRINT UL$;
190 PRINT " Press number in < > to:"
200 PRINT "   <1> Run this program"
210 PRINT "   <2> Run Telescoping Capacitor program";
220 :REM'IF C THEN PRINT USING " for a ###.## pF capacitor";C
230 PRINT
240 PRINT "   <0> EXIT";
250 IF CC THEN C=CC
260 Z$=INKEY$:IF Z$=""THEN 260
270 IF Z$="0"THEN CLS:RUN "\hamcalc\menu\hcal"
280 IF Z$="1"THEN 320
290 IF Z$="2"THEN CC=C:CHAIN"capytel"
300 GOTO 260
310 :REM'
320 :REM'.....start
330 COLOR 7,0,0:CLS
340 AWG=0:F=0:X=0:L=0:C=0:N=0:DW=0:SP=0:DC=0:DP=0:LG=0:LW=0:LD=0
350 GOSUB 880
360 COLOR 0,7:INPUT " ENTER: Blocking frequency (MHz)";F:GOSUB 880
370 IF F=0 THEN 360
380 PRINT " Typical reactance and bandwidth values at this frequency:"
390 PRINT " (assuming a dipole with a feedpoint impedance of 75 ohms)"
400 PRINT
410 GOSUB 2230
420 PRINT
430 PRINT " ( if unsure of reactance, enter 370 )"
440 COLOR 0,7:INPUT " ENTER: Desired approximate reactance (ohms)";X:GOSUB 880
450 IF X=0 THEN 440
460 PRINT " ( reactance increases with decrease of capacitance )"
470 COLOR 0,7:PRINT " ENTER: Value of capacitor you want to use, near";C;"pF";
480 C=0:X=0:INPUT C
490 L=X/(2*PI*F):GOSUB 880
500 PRINT " Wire Size:"
510 PRINT "  For diameter in inches: enter value in the range of 0 to .128"
520 PRINT "  For diameter in mm    : enter value in the range of .129 to 7.99"
530 PRINT "  For diameter in AWG   : enter value in the range of 8 to 40"
540 COLOR 0,7:INPUT " ENTER: Coil wire size value.......";W
550 IF W=0 THEN 540
560 DW=0.46000000834465027!/1.122931957244873!^(W+3):W$="AWG"
570 IF W<8 THEN DW=W/25.399999618530273!:W$="mm"
580 IF W<0.12800000607967377! THEN DW=W:W$="in."
590 SP=2*DW
600 GOSUB 880
610 :REM'
620 :REM'.....optimum coil form
630 CLS
640 JK=0:JKL=9.999999790214768e+33!
650 JK=JK+1:IF JK>JKL THEN 690
660 DPX=4*JK*DW
670 JKL=SQR(L*38*DPX)/DPX
680 GOTO 650
690 DX=4*(JK-2)*DW-DW
700 PRINT " PVC plastic pipe sizes (inches):"
710 PRINT "   Nom.Size     Actual O.D."
720 PRINT "       1/4        0.540"
730 PRINT "       1/2        0.840"
740 PRINT "       3/4        1.050"
750 PRINT "     1            1.315"
760 PRINT "     1-1/4        1.660"
770 PRINT "     1-1/2        1.900"
780 PRINT "     2            2.375"
790 PRINT "     2-1/2        2.875"
800 PRINT "     3            3.500"
810 PRINT "     4            4.500"
820 T$=" ENTER: ANY coil form diameter near #.### inches........."
830 COLOR 0,7:PRINT USING T$;DX;
840 INPUT DC:IF DC=0 THEN 820
850 COLOR 7,0:GOSUB 880
860 GOTO 1470
870 :REM'
880 :REM'.....calculate
890 COLOR 7,0
900 IF X =0 AND F*C  <>0 THEN X=10^6/(2*PI*F*C):GOTO 880    :REM'reactance
910 IF L =0 AND X*F  <>0 THEN L=X/(2*PI*F):GOTO 880         :REM'inductance
920 IF C =0 AND F*L  <>0 THEN C=25330.2890625!/F^2/L:GOTO 880     :REM'capacitance
930 IF N =0 AND L*DP <>0 THEN N=SQR(L*38*DP)/DP+1:GOTO 880  :REM'no. of turns
940 IF DP=0 AND DW*DC<>0 THEN DP=DW+DC:GOTO 880             :REM'pitch diameter
950 IF LG=0 AND DP*L <>0 THEN LG=((DP^2*N^2/L)-(18*DP))/40:GOTO 880 :REM'length
960 IF LD=0 AND LG*DP<>0 THEN LD=LG/DP:GOTO 880             :REM'L/D ratio
970 IF LG=0 AND SP*N THEN LG=N*SP                            LENGTH
980 IF SP=0 AND LG*N <>0 THEN SP=LG/N                       :REM'turn spacing
990 LW=N*PI*DP                                              :REM'amount of wire
1000 :REM'
1010 :REM'.....display
1020 CLS
1030 PRINT " L/C Antenna Trap"
1040 :REM'PRINT UL$;
1050 IF X=0 THEN 1080
1060 Q=75/X
1070 BW=F/Q
1080 IF F  THEN PRINT USING " Frequency....................ƒ= #####.### MHz";F
1090 IF X  THEN PRINT USING " Reactance....................X= #####.### Ω";X
1100 IF L  THEN PRINT USING " Inductance...................L= #####.### µH";L
1110 IF C  THEN PRINT USING " Capacitance..................C= #####.### pF";C
1120 IF BW THEN PRINT USING " Approximate bandwidth.......Bw= #####.### MHz";BW
1130 IF N  THEN PRINT USING " Number of turns............. N= #####.###";N
1140 IF DW THEN PRINT USING " Wire diameter...............Dw= #####.### in.";DW;
1150 IF DW THEN PRINT USING " = ###.# mm";DW*25.399999618530273!
1160 IF W$="AWG" THEN LOCATE CSRLIN-1,15:PRINT " ( AWG";W;")"
1170 BC=SP-DW
1180 IF SP THEN PRINT USING " Space between conductors....Sc= #####.### in.";BC;
1190 IF BC THEN PRINT USING " = ###.# mm";BC*25.399999618530273!
1200 IF SP THEN PRINT USING " Pitch (c.c. turn spacing)...Sp= #####.### in.";SP;
1210 IF SP THEN PRINT USING " = ###.# mm = ##.# turns per inch";SP*25.399999618530273!;1/SP
1220 IF DC THEN PRINT USING " Coil form diameter..........Dc= #####.### in.";DC;
1230 IF DC THEN PRINT USING " = ##.## cm";DC*2.5399999618530273!
1240 FLAG=CSRLIN
1250 IF SP THEN IF SP/DW>2.200000047683716! THEN SP$="FAR APART - DE":GOTO 1380
1260 IF SP THEN IF SP/DW<1.399999976158142! THEN SP$="CLOSE TOGETHER - IN":GOTO 1380
1270 IF DP THEN PRINT USING " Coil pitch diameter.........Dp= #####.### in.";DP;
1280 IF DP THEN PRINT USING " = ##.## cm";DP*2.5399999618530273!
1290 IF LG THEN LG=SP*N
1300 IF LG THEN PRINT USING " Length of Coil..............Lg= #####.### in.";LG;
1310 IF LG THEN PRINT USING " = ##.## cm";LG*2.5399999618530273!
1320 IF LW THEN PRINT USING " Amount of wire in coil......Lw= #####.### in.";LW;
1330 IF LW THEN PRINT USING " = ##.## m";LW*0.02539999969303608!
1340 IF LD THEN PRINT USING " Length/Diameter ratio......l/d= #####.###:1";LD
1350 PRINT UL$;
1360 RETURN
1370 :REM'
1380 P$=" TURNS TOO "+SP$+"CREASE COIL FORM DIAMETER! "
1390 LN=CSRLIN:COLOR 0,7:PRINT P$
1400 COLOR 7,0
1410 PRINT " Press any key . . . "
1420 Z$=INKEY$:IF Z$=""THEN 1420
1430 DC=0:N=0:DP=0:LG=0:LP=0:SP=0:LW=0:LD=0
1440 LOCATE FLAG:PRINT UL$;
1450 GOTO 700
1460 :REM'
1470 :REM'.....recalculate turns
1480 LN=CSRLIN:COLOR 0,7
1490 :REM'PRINT " Want to recalculate for an integral number of turns?  (y/n) "
1500 COLOR 7,0
1505 Z$="y":GOTO 1530
1510 Z$=INKEY$:IF Z$=""THEN 1510
1520 IF Z$="n"THEN 1570
1530 IF Z$="y"THEN N=INT(N):GOSUB 1550:LG=0:LD=0:GOSUB 880:GOTO 1570
1540 GOTO 1510
1550 IF NI=N THEN 1560 :ELSE NI=INT(N)+1
1560 N=NI:NI=0:RETURN
1570 :REM'.....re-do option
1580 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1590 PRINT " If the l/d ratio is within the range of 0.5 to 0.7 then you have";
1600 PRINT " designed a   "
1610 PRINT " high-Q trap."
1620 :REM'PRINT
1630 PRINT "    To reduce the l/d ratio, increase the form diameter."
1640 PRINT "    To increase the l/d ratio, reduce the form diameter."
1650 PRINT
1660 COLOR 0,7:PRINT " Want to try another form diameter?  (y/n) ":COLOR 7,0
1670 Z$=INKEY$:IF Z$=""THEN 1670
1680 IF Z$="y"THEN 1890
1690 IF Z$="n"THEN 1720
1700 GOTO 1670
1710 :REM'
1720 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1730 COLOR 0,7:PRINT " Want to try another wire size? (y/n) ":COLOR 7,0
1740 Z$=INKEY$:IF Z$=""THEN 1740
1750 IF Z$="y"THEN VIEW PRINT 7 TO 24:CLS:VIEW PRINT:LOCATE 7:GOTO 1780
1760 IF Z$="n"THEN 1800
1770 GOTO 1820
1780 N=0:DP=0:DW=0:LG=0:LD=0:SP=0:GOTO 500
1790 :REM'
1800 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1810 COLOR 0,7:PRINT " Want detailed coil specifications?  (y/n) ":COLOR 7,0
1820 Z$=INKEY$:IF Z$=""THEN 1820
1830 IF Z$="y"THEN 1860
1840 IF Z$="n"THEN 2520
1850 GOTO 1820
1860 NN=N:UH=L:LL=LG*2.5399999618530273!:DD=DP*2.5399999618530273!:WW=DW*2.5399999618530273!:FF=F:CC=C
1870 CHAIN"coiltrue"
1880 :REM'
1890 :REM'.....return to start
1900 DC=0:N=0:DP=0:LG=0:LP=0:SP=0:LW=0:LD=0
1910 VIEW PRINT FLAG TO 24:CLS:VIEW PRINT
1920 LOCATE FLAG:PRINT UL$;
1930 GOTO 700
1940 :REM'
1950 :REM'.....preface
1960 T=32:COLOR 0,7
1970 LOCATE ,T:PRINT "       L       "
1980 LOCATE ,T:PRINT "   ┌──∩∩∩──┐   "
1990 LOCATE ,T:PRINT " ──┤       ├── "
2000 LOCATE ,T:PRINT "   └───╫───┘   "
2010 LOCATE ,T:PRINT "       C       "
2020 COLOR 7,0
2030 PRINT
2040 PRINT "   A trap consists of a parallel combination of L and C that is r";
2050 PRINT "esonant at a  "
2060 PRINT " desired blocking frequency. Trap Q decreases and bandwidth incre";
2070 PRINT "ases with the "
2080 PRINT " the reactance of the trap. Most Amateur Radio antenna traps are ";
2090 PRINT "designed for a"
2100 PRINT " reactance within the range of 200-450 ohms.                     "
2110 PRINT "   For maximum Q the trap coil length-to-diameter ratio should be";
2120 PRINT " close to, but"
2130 PRINT " not less than, 0.5:1, with turns spaced within the range of 1.4 ";
2140 PRINT "- 2.2 times   "
2150 PRINT " the diameter of the conductor (Radiotron Designer's Handbook, ch";
2160 PRINT "apter 11.4,   "
2170 PRINT " Section 5, page 463).                                           "
2180 PRINT "   This program designs traps with single-layer coils wound on lo";
2190 PRINT "w loss forms, "
2200 PRINT " within these design parameters.                                 "
2210 RETURN
2220 :REM'
2230 :REM'.....reactance table
2240 R=75  :REM'impedance
2250 Y=150 :REM'seed reactance
2260 FOR Z=1 TO 6:Y=Y+50
2270 X(Z)=Y
2280 NEXT Z
2290 :REM'
2300 PRINT " Reactance (Ω)";
2310 LOCATE ,18
2320 FOR Z=1 TO 6
2330 PRINT USING "│####.   ";X(Z),
2340 NEXT Z
2350 PRINT ""
2360 :REM'
2370 PRINT " Loaded Q";
2380 LOCATE ,18
2390 FOR Z=1 TO 6
2400 PRINT USING "│####.###";R/X(Z),
2410 NEXT Z
2420 PRINT ""
2430 :REM'
2440 PRINT " Bandwidth (MHz)";
2450 LOCATE ,18
2460 FOR Z=1 TO 6
2470 PRINT USING "│####.###";F/(R/X(Z)),
2480 NEXT Z
2490 PRINT ""
2500 RETURN
2510 :REM'
2520 :REM'.....end
2530 VIEW PRINT LN TO 24:CLS:VIEW PRINT
2540 GOSUB 2560:COLOR ,,1:GOTO 110
2550 :REM'
2560 :REM'.....PRT
2570 KEY OFF:GOSUB 2640:LOCATE 25,5:COLOR 0,2
2580 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2590 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2600 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2600 :ELSE GOSUB 2640
2610 IF Z$="3"THEN RETURN
2620 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2630 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2570
2640 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
