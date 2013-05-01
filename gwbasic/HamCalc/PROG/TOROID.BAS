10 :REM'TOROID - 20 NOV 93 rev. 26 MAY 2007,  31 DEC 2008
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$,F$,T$,ZP,ZS,XS,LS,C1,X1,L,FRQ,MX,AL,CAT$,WIRD,NT,MAX,GA$
50 IF LS THEN L=LS   :REM'(LS chained from broadfer.bas)
60 CLS:KEY OFF
70 COLOR 7,0,1
80 PI=4*ATN(1)
90 DIM T$(10,4)         :REM'core material - powdered iron
100 DIM CT$(23,14)       :REM'core size - powdered iron
110 DIM F$(6,3)          :REM'core material -ferrite
120 DIM CF$(10,10)       :REM'core size - ferrite
130 DIM NT(23)           :REM'no. of turns
140 DIM MAX(23)          :REM'max.no.of turns
150 DIM GA(40)
160   K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'AWG increment multiplier
170   FOR Z=1 TO 40
180    N=Z+3
190    GA(Z)=0.46000000834465027!/K^N
200   NEXT Z
210 UL$=STRING$(80,205)
220 E$=STRING$(79,32)    :REM'blank line
230 GOSUB 4560       :REM'load data
240 :REM'
250 :REM'.....start
260 CLS
270 :REM'.....clear variables - except L, which may be chained from another program
280 B=0:C=0:F=0:M=0:N=0:R=0:IR=0:X=0:Y=0:XC=0:T=0:U=0
290 OD=0:ID=0:TH=0:WD=0:AF=0:AL=0:ER=0:NP=0:FQ=0
300 :REM'
310 COLOR 15,2
320 PRINT " TOROID INDUCTOR CALCULATOR";TAB(57);"by George Murphy VE3ERP ";
330 COLOR 1,0:PRINT STRING$(80,223);
340 COLOR 7,0
350 GOSUB 5430
360 PRINT
370 PRINT " Ref: ";
380 PRINT "PALOMAR ENGINEERS Spring 2007 catalog (WWW.palomar-engineers.com)"
390 PRINT UL$;
400 IF UM THEN 520
410 PRINT " Press number in < > to select:"
420 PRINT UL$;
430 PRINT "  < 1 >  Metric dimensions"
440 PRINT "  < 2 >  U.S.A./Imperial dimensions"
450 PRINT "  < 0 >  EXIT";
460 Z$=INKEY$
470 IF Z$="0"THEN CLS:CHAIN GO$
480 IF Z$="1"THEN UM=25.399999618530273!:UM$="mm.":DM$="millimetres":GOTO 570
490 IF Z$="2"THEN UM=1:UM$="in.":DM$="inches":GOTO 570
500 GOTO 460
510 PRINT UL$;
520 LOCATE ,23:COLOR 0,7:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
530 Z$=INKEY$:IF Z$=""THEN 530
540 IF Z$="0"THEN CLS:RUN EX$
550 IF Z$="1"THEN 570
560 GOTO 520
570 COLOR 7,0,0:CLS
580 IF L<>0 THEN Z$="4":GOTO 780         :REM'if L chained from another program
590 PRINT " Press number in < > to:"
600 PRINT UL$;
610 SEE=0
620 PRINT "  < 1 >  Quick Calculator"
630 PRINT "  < 2 >  Calculate winding parameters for maximum Q."
640 PRINT "  < 3 >  CALCULATE flux density"
650 PRINT "  < 4 >  DESIGN a toroidal inductor"
660 PRINT "  < 5 >  FIND properties of a toroidal inductor"
670 PRINT "  < 6 >  CHECK inductance of a toroidal device with a grid-dip meter"
680 PRINT "  < 7 >  SEE a table of Palomar core materials"
690 PRINT "  < 0 >  QUIT"
700 PRINT UL$;
710 PRINT TAB(3);"NOTE:";
720 PRINT TAB(10);
730 PRINT "All wire calculations are for enamelled solid copper wire."
740 Z$=INKEY$
750 IF Z$="1"THEN GOSUB 6330:CLS:GOTO 590
760 IF Z$="2"THEN GOSUB 5690:GOSUB 6240:CLS:GOTO 590
770 IF Z$="3"THEN GOSUB 1860:FLUX=1:GOTO 850
780 IF Z$="4"THEN GOSUB 1860:GOTO 2460
790 IF Z$="5"THEN GOSUB 1860:FLUX=0:GOTO 850
800 IF Z$="6"THEN 4010
810 IF Z$="7"THEN SEE=1:GOTO 1980
820 IF Z$="0"THEN 250
830 GOTO 740
840 :REM'
850 :REM'.....calculate flux density
860 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
870 COLOR 7,0:LOCATE 3
880 M=ASC(Z$)-96
890 PRINT " PALOMAR ";
900 IF M<=10 THEN C$="T":M$="mix #"+T$(M,1)+" POWDERED-IRON":D$=T$(M,4)
910 IF M>10 THEN C$="F":M=M-10:M$="mix #"+F$(M,1)+" Ferrite":D$=F$(M,3)
920 PRINT M$;" toroid cores for ";D$;" MHz"
930 PRINT UL$;
940 COLOR 0,7:PRINT " Press letter in < > to select core number";:COLOR 7,0
950 PRINT TAB(50);"(dimensions in ";UM$;")"
960 PRINT STRING$(42,205);TAB(49);"O.D.     I.D.     Thk."
970 IF C$="T"THEN 1000
980 IF C$="F"THEN 1100
990 :REM'
1000 FOR Z=1 TO 16   :REM'powdered iron
1010 PRINT " <";CHR$(Z+96);">  ";"T-";CT$(Z,1);
1020 IF VAL(CT$(Z,M+1))>0 THEN 1030 :ELSE PRINT TAB(26)"N/A":GOTO 1070
1030 PRINT TAB(23);USING "####.#";VAL(CT$(Z,M+1));:PRINT " Mfr. AL no. ";
1040 IF UM=1 THEN MM$="#####.###" :ELSE MM$="#######.#"
1050 PRINT TAB(44);USING MM$;VAL(CT$(Z,12))*UM;VAL(CT$(Z,13))*UM;
1060 PRINT USING MM$;VAL(CT$(Z,14))*UM
1070 NEXT Z
1080 GOTO 1180
1090 :REM'
1100 FOR Z=1 TO 10   :REM'ferrite
1110 PRINT "<";CHR$(Z+96);">  ";"F-";CF$(Z,1);
1120 IF VAL(CF$(Z,M+1))>0 THEN 1130 :ELSE PRINT TAB(26)"N/A":GOTO 1160
1130 PRINT TAB(23);USING "####.#";VAL(CF$(Z,M+1));:PRINT " Mfr. AL no.  ";
1140 PRINT TAB(44);USING "#####.###";VAL(CF$(Z,8))*UM;VAL(CF$(Z,9))*UM;
1150 PRINT USING "#####.###";VAL(CF$(Z,10))*UM
1160 NEXT Z
1170 :REM'
1180 IF C$="T"THEN C=112
1190 IF C$="F"THEN C=106
1200 Z$=INKEY$
1210 IF Z$=""THEN 1200
1220 IF ASC(Z$)<96 OR ASC(Z$)>C THEN 1200
1230 C=ASC(Z$)-96
1240 IF C$="T"THEN S$="T-"+CT$(C,1):AL=VAL(CT$(C,M+1)):MIX=VAL(T$(M,1))
1250 IF C$="T"THEN OD=VAL(CT$(C,12)):ID=VAL(CT$(C,13)):TH=VAL(CT$(C,14))
1260 IF C$="F"THEN S$="FT-"+CF$(C,1):AL=VAL(CF$(C,M+1)):MIX=VAL(F$(M,1))
1270 IF C$="F"THEN OD=VAL(CF$(C,8)):ID=VAL(CF$(C,9)):TH=VAL(CF$(C,10))
1280 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1290 AE=(OD*2.5399999618530273!-ID*2.5399999618530273!)/2*TH*2.5399999618530273!   :REM'section area in square cm.
1300 U$="####.##"
1310 PRINT TAB(9);"PALOMAR core number........... ";S$;" mix #";MIX
1320 PRINT TAB(9);"Outside diameter..........OD = ";USING U$;OD*UM;
1330 PRINT " ";UM$
1340 PRINT TAB(9);"Inside diameter...........ID = ";USING U$;ID*UM;
1350 PRINT " ";UM$
1360 PRINT TAB(9);"Thickness.................TH = ";USING U$;TH*UM;
1370 PRINT " ";UM$
1380 AE=(OD-ID)*UM*TH*UM
1390 PRINT TAB(9);"Section area..............AE = ";USING U$;AE;:PRINT" sq.";UM$
1400 LG=(OD+ID)/2*PI
1410 PRINT TAB(9);"Length of flux path.......LG = ";USING U$;LG;:PRINT" ";UM$
1420 PRINT TAB(9);"Mfr's Inductance Index....AL = ";USING U$;AL
1430 IF FLUX=0 THEN 1470
1440 INPUT " ENTER: Applied AC voltage.......ER = ";ER
1450 IF ER=0 THEN LOCATE CSRLIN-1:PRINT E$:LOCATE CSRLIN-1:GOTO 1440
1460 LOCATE CSRLIN-1:PRINT "       ";:LOCATE CSRLIN,42:PRINT USING U$;ER
1470 INPUT " ENTER: Number of wire turns......NP = ";NP
1480 IF NP=0 THEN LOCATE CSRLIN-1:PRINT E$:LOCATE CSRLIN-1:GOTO 1470
1490 LOCATE CSRLIN-1:PRINT "       ";:LOCATE CSRLIN,40:PRINT USING U$;NP
1500 L=(NP/100)^2*AL
1510 PRINT TAB(9);"Inductance.................L = ";USING U$;L;
1520 PRINT " µH (approx.)"
1530 AE=AE*2.5399999618530273!^2
1540 U=L/0.4000000059604645!*PI*NP^2*AE/LG*10^-2
1550 PRINT TAB(9);"Core permeability..........µ = ";INT(U);"(approx.)"
1560 PRINT
1570 PRINT TAB(9);"Want to see winding data for maximum Q?  (y/n)"
1580 Z$=INKEY$:IF Z$=""THEN 1580
1590 IF Z$="n"THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):GOTO 1630
1600 IF Z$="y"THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):GOTO 5970
1610 GOTO 1580
1620 :REM'
1630 IF FLUX=0 THEN 1740
1640 INPUT " ENTER: Operating Frequency (MHz)...FQ = ";FQ
1650 IF FQ=0 THEN LOCATE CSRLIN-1:PRINT E$:LOCATE CSRLIN-1:GOTO 1640
1660 LOCATE CSRLIN-1:PRINT "       ";:LOCATE CSRLIN,42:PRINT USING U$;FQ
1670 F=FQ*10^6   :REM'frequency in Hertz
1680 INPUT " ENTER: DC current in amps(if any)..DC = ";DC
1690 LOCATE CSRLIN-1:PRINT "       ";:LOCATE CSRLIN,42:PRINT USING U$;DC
1700 :REM'
1710 B=ER*10^8/(4.440000057220459!*F*NP*AE)
1720 IF DC THEN B=B+NP*DC*AL/(10*AE)
1730 PRINT TAB(9);"Flux density in Gauss .......B = ";USING U$;B
1740 PRINT UL$;
1750 GOSUB 6240  :REM'screendump
1760 LOCATE 25,1:PRINT STRING$(79,32);
1770 COLOR 14,6
1780 LOCATE 25,22:PRINT " Do you want to try another?  (y/n) ";
1790 COLOR 7,0
1800 Z$=INKEY$
1810 IF Z$="n"OR Z$="N"THEN 6220   :REM'end without screen dump
1820 IF Z$="y"OR Z$="Y"THEN GOSUB 1860:GOTO 850
1830 GOTO 1800
1840 GOTO 6190  :REM'end
1850 :REM'
1860 :REM'.....select a core
1870 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1880 PRINT " In the following tables select a core with number of turns somewh";
1890 PRINT "at less than"
1900 PRINT " the core's maximum turn capacity to allow for a gap between the f";
1910 PRINT "irst and    "
1920 PRINT " last turns. Make note of core dimensions, wire size and number of"
1930 PRINT " turns for use in calculating winding parameters."
1940 PRINT:COLOR 0,7
1950 LOCATE CSRLIN,28:PRINT " .....press any key..... "
1960 Z$=INKEY$:IF Z$=""THEN 1960
1970 COLOR 7,0,0
1980 :REM'.....display materials
1990 CLS:PRINT " PALOMAR Core Materials"
2000 PRINT UL$;
2010 IF SEE=1 THEN 2060
2020 COLOR 0,7
2030 PRINT " Press a letter in < > below to select a core material:"
2040 COLOR 7,0
2050 PRINT UL$;
2060 IF SEE=1 THEN 2080
2070 PRINT " CODE";
2080 PRINT TAB(8);"MIX #";TAB(16);"CORE MATERIAL";TAB(31);"COLOR";
2090 PRINT TAB(40);"PERMEABILITY";TAB(55);
2100 IF PROG$="broadfer"THEN PRINT "":GOTO 2130
2110 PRINT TAB(55);"FQCY.RANGE (MHz)"
2120 :REM'
2130 :REM'.....print table
2140 FOR Z=1 TO 16
2150   IF Z<=10 THEN 2170
2160   IF Z>10 THEN 2260
2170  IF SEE=1 THEN PRINT "        ";::ELSE PRINT " < ";CHR$(Z+96);" >  ";
2180 T$=T$(Z,1)
2190 IF LEN(T$)<2 THEN T$=" "+T$
2200  PRINT T$;TAB(16);"Powdered Iron";
2210  PRINT TAB(31);T$(Z,2);TAB(40);T$(Z,3);
2220 IF PROG$="broadfer"THEN 2240
2230  PRINT TAB(55)T$(Z,4);
2240 GOTO 2340
2250 :REM'
2260 IF PROG$="broadfer"AND Z=14 THEN COLOR 0,7
2270  IF SEE=1 THEN PRINT "        ";::ELSE PRINT " < ";CHR$(Z+96);" >  ";
2280 F$=F$(Z-10,1)
2290 IF LEN(F$)<2 THEN F$=" "+F$
2300  PRINT F$;TAB(16);"Ferrite";
2310  PRINT TAB(40);F$(Z-10,2);
2320 IF PROG$="broadfer"THEN 2240
2330  PRINT TAB(55)F$(Z-10,3);
2340  IF SEE=1 THEN PRINT TAB(72);"       ";:GOTO 2360
2350  PRINT TAB(72);"< ";CHR$(Z+96);" >  ";
2360 COLOR 7,0
2370 NEXT Z
2380 IF SEE=1 THEN 2440
2390 Z$=INKEY$:IF Z$=""THEN 2390
2400 IF ASC(Z$)<=78 AND ASC(Z$)>=65 THEN Z$=CHR$(ASC(Z$)+32)
2410 IF ASC(Z$)>=97 AND ASC(Z$)<=114 THEN 2430
2420 GOTO 2390
2430 RETURN
2440 GOTO 6190   :REM'end
2450 :REM'
2460 :REM'.....display selected item
2470 CLS:COLOR 7,0,0
2480 M=ASC(Z$)-96
2490 IF M<=10 THEN C$="T"
2500 IF M>10 THEN C$="F":M=M-10
2510 PRINT " CORE:";
2520 L$=" µH "
2530 IF C$="T"THEN 2550
2540 IF C$="F"THEN 2570
2550  PRINT TAB(8);T$(M,1);TAB(16);"Powdered Iron";TAB(31);T$(M,2);
2560  PRINT TAB(40);T$(M,3);TAB(55)T$(M,4);" MHz":DASH=VAL(T$(M,1)):GOTO 2590
2570  PRINT TAB(8);F$(M,1);TAB(16);"Ferrite";
2580  PRINT TAB(40);F$(M,2);TAB(55)F$(M,3);" Mhz":DASH=VAL(F$(M,1))
2590 PRINT UL$;
2600 :REM'
2610 :REM'.....input data
2620 IF L THEN 2640
2630 INPUT " ENTER: Desired inductance in µH";L
2640 L$=" #### "
2650 IF L<100 THEN L$=" ##.# "
2660 IF L<10  THEN L$=" #.## "
2670 IF L<1   THEN L$=" .### "
2680 :REM'
2690 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2700 IF UM=1 THEN 2730
2710 INPUT " ENTER: Wire diameter (mm) ";R
2720 R=R/25.399999618530273!/2:GOTO 2750
2730 INPUT " ENTER: Wire size (AWG#) ";GA$
2740 R=GA(VAL(GA$))/2
2750 CLS
2760 IF C$="T"THEN 2790
2770 IF C$="F"THEN 3200
2780 :REM'
2790 :REM'.....powdered iron core calculations
2800 IF UM=1 THEN D$=" inches ":ELSE D$="── mm.──"
2810 PRINT "  PALOMAR";TAB(14);"│┌──────";D$;"───────┐│";
2820 PRINT TAB(39);" Mfr. │";TAB(47);"No.of turns │";
2830 IF UM=1 THEN M$=CHR$(34)+" " :ELSE M$="mm"
2840 IF UM=1 THEN MM$="##.###":ELSE MM$="##.## "
2850 PRINT TAB(61);"Wireφ";USING "##.###";R*2*UM;:PRINT M$;
2860 IF GA$<>""THEN PRINT " AWG ";GA$;:GOTO 2880
2870 PRINT "       ";
2880 PRINT "Core # - mix │";TAB(17);"O.D.";TAB(25);"I.D.";TAB(32)"Thick │";
2890 PRINT TAB(40);"AL # │";TAB(47);"for";USING L$;L;:PRINT "µH";TAB(59);"│";
2900 PRINT " Maximum Turns       ";
2910 PRINT UL$;
2920 LOCATE CSRLIN-1,14:PRINT "╧"
2930 LOCATE CSRLIN-1,38:PRINT "╧"
2940 LOCATE CSRLIN-1,45:PRINT "╧"
2950 LOCATE CSRLIN-1,59:PRINT "╧"
2960 COLOR 7,0,0
2970 LN=4
2980 FOR Z=1 TO 23
2990 LN=LN+1:IF LN=24 THEN GOSUB 6240:VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
3000 PRINT " T-";CT$(Z,1);
3010 PRINT TAB(10)"#";RIGHT$(STR$(DASH),LEN(STR$(DASH))-1);
3020 V=VAL(CT$(Z,M+1))
3030 IF V=0 THEN PRINT TAB(16);"not available in this mix":GOTO 3170
3040 N=100*SQR(L/V)  :REM'number of turns
3050 NT(Z)=N
3060 IF UM=1 THEN M$="#####.##":ELSE M$="######.#"
3070 PRINT TAB(13);USING M$;VAL(CT$(Z,12))*UM;VAL(CT$(Z,13))*UM;
3080 PRINT USING M$;VAL(CT$(Z,14))*UM;
3090 PRINT USING "######.#";V;
3100 PRINT USING "######.##";N;
3110 IR=VAL(CT$(Z,13))/2:GOSUB 3940        :REM'IR = I.D./2
3120 MAX(Z)=MAX
3130 PRINT TAB(59);USING "####";MAX;
3140 IF N<MAX THEN PRINT " approx.  <";CHR$(Z+96);">";:GOTO 3160
3150 PRINT " -CORE TOO SMALL";:GOTO 3610
3160 IF LN<24 THEN PRINT ""
3170 NEXT Z
3180 GOTO 3610
3190 :REM'
3200 :REM'.....ferrite core calculations
3210 IF UM=1 THEN D$=" inches ":ELSE D$="── mm.──"
3220 PRINT "  PALOMAR";TAB(14);"│┌──────";D$;"───────┐│";
3230 PRINT TAB(39);" Mfr.  ";TAB(46);"│No.of turns│";
3240 IF UM=1 THEN M$=CHR$(34)+" " :ELSE M$="mm"
3250 IF UM=1 THEN MM$="##.###":ELSE MM$="##.## "
3260 PRINT TAB(60);"Wireφ";USING MM$;R*2*UM;:PRINT M$;
3270 IF GA$<>""THEN PRINT " AWG ";GA$;" ";:GOTO 3290
3280 PRINT "        ";
3290 PRINT "Core # - Mix │";TAB(17);"O.D.";TAB(25);"I.D.";TAB(32)"Thick │";
3300 PRINT TAB(40);"AL # ";TAB(46);"│for";USING L$;L;:PRINT "µH";TAB(58);"│";
3310 PRINT " Maximum Turns        ";
3320 IF PROG$="broadfer"THEN LOCATE 2,47:PRINT "  (hi-Z)   "
3330 PRINT UL$;
3340 LOCATE CSRLIN-1,14:PRINT "╧"
3350 LOCATE CSRLIN-1,38:PRINT "╧"
3360 LOCATE CSRLIN-1,46:PRINT "╧"
3370 LOCATE CSRLIN-1,58:PRINT "╧"
3380 COLOR 7,0,0
3390  FOR Z=1 TO 10:REM':IF VAL(CF$(Z,M+1))=0 THEN 3320
3400 V=VAL(CF$(Z,M+1)):AL=V
3410 PRINT" FT-"+CF$(Z,1);
3420 PRINT TAB(11)"#";RIGHT$(STR$(DASH),LEN(STR$(DASH))-1);
3430 IF V=0 THEN PRINT TAB(16);"not available in this mix":GOTO 3580
3440 N=100*SQR(L/V)  :REM'number of turns
3450 IR=VAL(CF$(Z,9))/2:GOSUB 3940        :REM'ir = I.D./2     find max. turns
3460 PRINT TAB(14);USING "###.###";VAL(CF$(Z,8))*UM;
3470 PRINT USING "####.###";VAL(CF$(Z,9))*UM;VAL(CF$(Z,10))*UM;
3480 IF PROG$="broadfer"THEN ZN=10^3*SQR(L/AL)*SQR(ZP/ZS):ELSE ZN=N
3490 PRINT USING "#######       ";V;
3500 IF PROG$<>"broadfer"THEN 3520
3510 IF ZN<MAX THEN COLOR 15,2 :ELSE COLOR 7,4
3520 PRINT USING " ###.##";ZN;
3530 PRINT TAB(59);USING "####";MAX;
3540 NT(Z)=MAX
3550 IF PROG$="torotrap"THEN NT(Z)=ZN:MAX(Z)=MAX
3560 IF N<MAX THEN PRINT " approx. <";CHR$(96+Z);">    ":GOTO 3580
3570 PRINT " -CORE TOO SMALL"
3580  COLOR 7,0:NEXT Z
3590 PRINT UL$;:COLOR 7,0,1
3600 :REM'
3610 IF PROG$="broadfer" THEN 3650
3620 IF PROG$="torotrap" THEN 3850
3630 GOTO 6190
3640 :REM'
3650 :REM'.....change wire size
3660 COLOR 0,7:LOCATE 24,18
3670 PRINT " Want to try another size of wire?   (y/n) ";:COLOR 7,0
3680 Z$=INKEY$:IF Z$=""THEN 3680
3690 IF Z$="y"THEN 2690
3700 IF Z$="n"THEN 3830
3710 GOTO 3680
3720 :REM'
3730 :REM'.....select a core
3740 VIEW PRINT 24 TO 24:CLS:VIEW PRINT
3750 PR=VAL(RIGHT$(F$(M,2),LEN(F$(M,2))-2)):MX=VAL(F$(M,1))
3760 GOSUB 6240
3770 COLOR 0,7:LOCATE 24,20
3780 PRINT " Press a letter in < > to select a core ......";:COLOR 7,0
3790 Z$=INKEY$:IF Z$<"a"OR Z$>"j"THEN 3790
3800 Z=ASC(Z$)-96
3810 F$=F$(M,2):AL=VAL(CF$(Z,5)):CAT$=CF$(Z,1):WIRD=2*R :REM'(wire dia.)
3820 NT=NT(Z):MAX=NT
3830 CLS:CHAIN PROG$
3840 :REM'
3850 MX=VAL(T$(M,1))
3860 COLOR 0,7:LOCATE 24,17
3870 PRINT " Press a letter in < > to select a core ......";:COLOR 7,0
3880 Z$=INKEY$:IF Z$<"a"OR Z$>"p"THEN 3880
3890 Z=ASC(Z$)-96
3900 T$=T$(M,2):AL=VAL(CT$(Z,5)):CAT$=CT$(Z,1):WIRD=2*R :REM'(wire dia.)
3910 NT=NT(Z):MAX=MAX(Z)
3920 CLS:CHAIN"torotrap"
3930 :REM'
3940 :REM'.....max. no.of turns
3950 ID=2*IR:WIRE=2*R
3960 CIRC=PI*(ID+R)
3970 DIV=INT(CIRC/WIRE)
3980 MAX=DIV*0.949999988079071!  :REM'.95 allows for close winding, enamel thickness, etc.
3990 RETURN
4000 :REM'
4010 :REM'.....check inductance
4020 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
4030 COLOR 15,2:LOCATE 1,18:PRINT "CHECK        "
4040 COLOR 7,0:LOCATE 3
4050 PRINT TAB(9);
4060 PRINT "Refer to the ARRL HANDBOOK FOR THE RADIO AMATEUR for method of";
4070 PRINT TAB(9);
4080 PRINT "checking the inductance of a toroidal device with a grid dip meter."
4090 PRINT
4100 PRINT TAB(9);
4110 PRINT "This program will perform all the necessary calculations:"
4120 PRINT UL$;
4130 INPUT " ENTER: Capacitance of known capacitor in pF .......";C
4140 IF C=0 THEN LOCATE CSRLIN-1:PRINT E$:LOCATE CSRLIN-1:GOTO 4130
4150 LOCATE CSRLIN-1:PRINT "       ";:LOCATE CSRLIN,53:PRINT USING "#####.###";C
4160 C=C/10^6    :REM'µF
4170 INPUT " ENTER: Measured frequency in MHz...................";F
4180 IF F=0 THEN LOCATE CSRLIN-1:PRINT E$:LOCATE CSRLIN-1:GOTO 4170
4190 LOCATE CSRLIN-1:PRINT "       ";:LOCATE CSRLIN,53:PRINT USING "#####.###";F
4200 XC=1/(2*PI*F*C):XL=XC
4210 L=XL/(2*PI*F)
4220 PRINT "        Reactance of known capacitor in ohms........";
4230 PRINT USING "#####.###";XC
4240 PRINT "        Inductance of toroidal device in µH.........";
4250 PRINT USING "#####.###";L
4260 PRINT UL$;
4270 GOTO 6190  :REM'end
4280 :REM'
4290 :REM'.....core size table
4300 CLS
4310 IF UM=1 THEN U$="########.##":ELSE U$="#########.#"
4320 PRINT " CORE SIZE     O.D.(";UM$;")  I.D.(";UM$;")  THK.(";UM$;")"
4330 FOR Z=1 TO 23:PRINT " T-"+CT$(Z,1);
4340 PRINT TAB(12);USING U$;VAL(CT$(Z,12))*UM,VAL(CT$(Z,13))*UM,
4350 PRINT USING U$;VAL(CT$(Z,14))*UM;
4360 IF Z<23 THEN PRINT ""
4370 NEXT Z
4380 LOCATE 3,50:PRINT "POWDERED IRON CORES"
4390 LOCATE 4,50:PRINT "═══════════════════"
4400 LOCATE 6,50:PRINT "Press 3 to see Ferrite cores"
4410 GOSUB 6240:CLS
4420 PRINT " FERRITE CORES"
4430 PRINT UL$;
4440 PRINT " CORE SIZE     O.D.(";UM$;")  I.D.(";UM$;")  THK.(";UM$;")"
4450 PRINT UL$;
4460 FOR Z=1 TO 10:PRINT " F-"+CF$(Z,1);
4470 PRINT TAB(12);USING U$;VAL(CF$(Z,8))*UM,VAL(CF$(Z,9))*UM,
4480 PRINT USING U$;VAL(CF$(Z,10))*UM;
4490 IF Z<10 THEN PRINT ""
4500 NEXT Z
4510 PRINT:PRINT
4520 PRINT " Press 3 to return to menu . . . ."
4530 GOTO 6190  :REM'end
4540 END
4550 :REM'
4560 :REM'LOAD DATA........
4570 :REM'
4580 :REM'.....core description - powdered iron
4590 DATA 26,Yel/Wh,>=75,0-1
4600 DATA 3,Grey,>=35,0.02-1
4610 DATA 15,Red/Wh,>=25,0.1-3
4620 DATA 1,Blue,>=20,0.15-2
4630 DATA 2,Red,>=10,0.25-10
4640 DATA 7,White,>=9,1-20
4650 DATA 6,Yellow,>=8.5,2-30
4660 DATA 10,Black,>=6,10-100
4670 DATA 12,Grn/Wh,>=4,20-200
4680 DATA 0,Tan,>=1,50-250
4690  FOR Z=1 TO 10:FOR Y=1 TO 4:READ T$(Z,Y):NEXT Y:NEXT Z
4700 :REM'
4710 :REM'.....inductance index & core dimensions - powdered iron
4720 DATA 400-A, 2600,    0,    0,    0,  360,    0,    0,    0,    0,    0
4730 DATA 4,2.25,1.3
4740 DATA 400  , 1320,    0,    0,    0,  185,    0,    0,    0,    0,    0
4750 DATA 4,2.25,.65
4760 DATA 300  ,  825,    0,    0,    0,  115,    0,    0,    0,    0,    0
4770 DATA 3.05,1.93,.5
4780 DATA 250  ,    0,    0,    0,    0,  310,    0,    0,    0,    0,    0
4790 DATA 2.5,1.25,1
4800 DATA 225-A,    0,    0,    0,    0,  215,    0,    0,    0,    0,    0
4810 DATA 2.25,1.25,1
4820 DATA 225  ,  950,  425,    0,    0,  120,    0,  100,    0,    0,    0
4830 DATA 2.25,1.4,.55
4840 DATA 200-A, 1550,    0,    0,    0,  218,    0,    0,    0,    0,    0
4850 DATA 2,1.25,1
4860 DATA 200  ,  895,  425,    0,  250,  120,    0,  100,    0,    0,    0
4870 DATA 2,1.25,.55
4880 DATA 184  , 1640,  720,    0,  500,  240,    0,  195,    0,    0,    0
4890 DATA 1.84,.95,.71
4900 DATA 157  ,  970,  420,  360,  320,  140,    0,  115,    0,    0,    0
4910 DATA 1.57,.95,.57
4920 DATA 130  ,  785,  350,  250,  200,  110,    0,   96,    0,    0,   15
4930 DATA 1.3,.78,.44
4940 DATA 106  ,  900,  450,  345,  325,  135,    0,  116,    0,    0,   19
4950 DATA 1.06,.57,.44
4960 DATA 94   ,  590,  248,  200,  160,   84,    0,   70,   58,   32, 10.6
4970 DATA .94,.56,.31
4980 DATA 80   ,  450,  180,  170,  115,   55,    0,   45,   32,   22,  8.5
4990 DATA .8,.5,.25
5000 DATA 68   ,  420,  195,  180,  115,   57,   52,   47,   32,   21,  7.5
5010 DATA .68,.37,.19
5020 DATA 50   ,  320,  175,  135,  100,   49,   43,   40,   31,   18,  6.4
5030 DATA .5,.30,.19
5040 DATA 44   ,  360,  180,  160,  105,   52,   46,   42,   33,   19,  6.5
5050 DATA .44,.23,.16
5060 DATA 37   ,  275,  120,   90,   85,   40,   32,   30,   25,   15,  4.9
5070 DATA .37,.20,.13
5080 DATA 30   ,  325,  140,   93,   85,   43,    0,   36,   25,   16,  6.0
5090 DATA .30,.15,.13
5100 DATA 25   ,    0,  100,   85,   70,   34,    0,   27,   19,   12,  4.5
5110 DATA .25,.12,.1
5120 DATA 20   ,    0,   90,   65,   52,   27,    0,   22,   16,   10,  3.5
5130 DATA .2,.09,.07
5140 DATA 16   ,    0,   61,   55,   44,   22,    0,   19,   13,    8,  3.0
5150 DATA .16,.08,.06
5160 DATA 12   ,    0,   60,   50,   48,   20,    0,   17,   12,    7,  3.0
5170 DATA .12,.06,.05
5180  FOR Z=1 TO 23:FOR Y=1 TO 14:READ CT$(Z,Y):NEXT Y:NEXT Z
5190 :REM'
5200 :REM'.....core description - ferrite
5210 DATA 68,>=20,80-180
5220 DATA 67,>=40,10-80
5230 DATA 61,>=125,0.2-10
5240 DATA 43,>=850,0.01-1
5250 DATA 77,>=1800,0.001-2
5260 DATA 75,>=5000,0.001-1
5270  FOR Z=1 TO 6:FOR Y=1 TO 3:READ F$(Z,Y):NEXT Y:NEXT Z
5280 :REM'
5290 :REM'.....inductance index & core dimensions - ferrite
5300 DATA 240  ,   0,   0, 173,1240,2740,   0,2.4 , 1.4, .5
5310 DATA 140  ,   0,   0, 140,1060,2250,   0,1.4 ,  .9, .5
5320 DATA 114-A,   0,   0, 146,   0,2340,   0,1.14, .75, .55
5330 DATA 114  ,   0,  25,  79, 603,1270,   0,1.14, .75, .3
5340 DATA  82  ,  12,  22,  73, 557,1170,   0, .82, .52, .25
5350 DATA  50-B,    ,  48, 150,1140,2400,   0, .5 , .31, .5
5360 DATA  50-A,    ,  24,  75, 570,1200,3000, .5 , .31, .25
5370 DATA  50  ,  11,  22,  68, 523,1100,2750, .5 , .28, .19
5380 DATA  37  ,   9,  18,  55, 420, 884,2210, .37, .19, .12
5390 DATA  23  ,   4,   8,  25, 188, 396,   0, .23, .12, .06
5400  FOR Z=1 TO 10:FOR Y=1 TO 10:READ CF$(Z,Y):NEXT Y:NEXT Z
5410 RETURN
5420 :REM'
5430 :REM'.....preface
5440 PRINT " FERRITE TOROID CORES are used for low power tuned circuits and e";
5450 PRINT "specially for "
5460 PRINT " wideband transformers and baluns for transistor coupling and ant";
5470 PRINT "enna matching."
5480 PRINT " Their high permeability provides high inductances with few turns";
5490 PRINT ". Low         "
5500 PRINT " frequency cores are used in switch-mode power supplies. Frequenc";
5510 PRINT "y ranges      "
5520 PRINT " listed in the tables are those recommended for tuned circuits. F";
5530 PRINT "or wideband   "
5540 PRINT " transformers the top frequency is ten times higher.             "
5550 PRINT
5560 PRINT " POWDERED IRON CORES are suitable for tuned tank circuits, filter";
5570 PRINT "s, pi network "
5580 PRINT " inductors, etc. They are more stable than ferrites and do not sa";
5590 PRINT "turate as     "
5600 PRINT " easily. They are available in a number of different mixes. For b";
5610 PRINT "est Q use the "
5620 PRINT " mix specified for your frequency. The cores are colour coded to ";
5630 PRINT "show the mix. "
5640 PRINT
5650 PRINT " NOTE:"
5660 PRINT " Mix 7 has the lowest temperature coefficient. Use for oscillator";
5670 PRINT "s, VFO's etc."
5680 RETURN
5690 :REM'.....winding
5700 CLS
5710 :REM'IF UM$="mm."THEN D$="millimetres."ELSE D$="inches."
5720 PRINT
5730 PRINT " Enter diameters in ";DM$
5740 PRINT
5750 IF OD THEN 5760 :ELSE INPUT " ENTER: Core outer diameter";OD:OD=OD/UM
5760 IF ID THEN 5770 :ELSE INPUT " ENTER: Core inner diameter";ID:ID=ID/UM
5770 IF TH THEN 5780 :ELSE INPUT " ENTER: Core thickness     ";TH:TH=TH/UM
5780 IF WD THEN 5790 :ELSE INPUT " ENTER: Wire diameter      ";WD:WD=WD/UM
5790 CIRC=2*((OD-ID)+TH)+(PI*WD)
5800 PD=ID-WD/2
5810 IF NP=0 THEN INPUT " ENTER: No. of turns       ";NP
5820 LG=PD*NP
5830 :REM'.....display
5840 CLS:PRINT " TOROID WINDING"
5850 PRINT
5860 PRINT " For maximum Q a toroid coil should have its windings spaced equ";
5870 PRINT "ally over "
5880 PRINT " 330° leaving a 30°gap between the first and last turns."
5890 PRINT " (ref. ARRL 2007 Handbook, page 8.23)"
5900 PRINT
5910 PRINT USING " Core outer diameer..... ###.###";OD*UM;:PRINT" "+UM$
5920 PRINT USING " Core inside diameter... ###.###";ID*UM;:PRINT" "+UM$
5930 PRINT USING " Core thickness......... ###.###";TH*UM;:PRINT" "+UM$
5940 PRINT USING " Wire diameter.......... ###.###";WD*UM;:PRINT" "+UM$
5950 PRINT USING " Number of turns........ ###.###";NP
5960 PRINT
5970 PRINT " Turn spacing for maximum Q:"
5980 IF WD=0 THEN 5730
5990 PRINT
6000 GAP=30
6010 SPC=330/(NP-1) :REM'degrees
6020 SEG=PI*PD/(NP-3) :REM'linear
6030 PRINT USING " Gap angle.............. ###.###°";GAP
6040 PRINT USING " Angular turn spacing... ###.###°";SPC
6050 PRINT USING " Linear turn spacing.... ###.###";SEG;:PRINT " "+UM$;" c.c."
6060 PRINT " Length of wire......... ";INT((LG*10+5)/10)*UM;:PRINT UM$+" plus leads."
6070 IF ABS(SEG-WD)<0.0010000000474974513! OR SEG>WD THEN 6180
6080 :REM'.....recalculate core
6090 XX=0
6100 XX=XX+0.0010000000474974513!      :REM'new radius
6110 MAXSEG=PI*2*XX/(NP-3) :REM'new seg
6120 IF ABS(MAXSEG-WD)<0.0010000000474974513! THEN 6140
6130 GOTO 6100
6140 Z=INT(2*XX*1000+5)/1000
6150 CLS:LOCATE 12,4:COLOR 0,7
6160 PRINT NP"turn coils of"WD"wire require cores with a minimum I.D.";
6170 PRINT " of"Z:COLOR 7,0
6180 GOSUB 6240:GOTO 250
6190 :REM'.....end
6200 GOSUB 6240
6210 IF EX$<>GO$ THEN CLS:CHAIN GO$
6220 L=0:GOTO 250
6230 END
6240 :REM'PRT
6250 KEY OFF:GOSUB 6320:LOCATE 25,5:COLOR 0,2
6260 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
6270 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
6280 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 6280 :ELSE GOSUB 6320
6290 IF Z$="3"THEN RETURN
6300 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
6310 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 6250
6320 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
6330 :REM'.....PALOMA
6340 CLS:KEY OFF
6350 IF AL=0 THEN INPUT " Enter AL# (0 if unknown)";AL
6360 IF L=0 THEN INPUT " Enter µH (0 if unknown)";L
6370 IF T=0 THEN INPUT " Enter No. of turns (0 if unknown)";T
6380 IF AL*L THEN T=100*SQR(L/AL):GOTO 6420
6390 IF T*AL THEN L=(T/100)^2*AL:GOTO 6420
6400 IF T*L THEN AL=L/(T/100)^2:GOTO 6420
6410 GOTO 6340
6420 CLS
6430 PRINT USING " Inductance........ ####.## µH";L
6440 PRINT USING " No. of turns...... ####.## ";T
6450 PRINT USING " AL number......... ####.## ";AL
6460 PRINT " .....press 1 to run again or 0 to quit....."
6470 Z$=INKEY$:IF Z$=""THEN 6470
6480 IF Z$="1"THEN L=0:T=0:AL=0:GOTO 6340
6490 IF Z$="0"THEN CLS:RETURN
6500 GOTO 6470
