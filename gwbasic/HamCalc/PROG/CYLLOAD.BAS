10 :REM'CYLLOAD - Cylinder-Loaded Dipole - 17 JAN 97 rev. 27 OCT 02
20 REM: ref. ARRL ANTENNA BOOK, 17th ed. page 2-40
30 IF EX$=""THEN EX$="EXIT"
40 PI=4*ATN(1)
50 UL$=STRING$(80,205)
60 :REM'
70 :REM'.....start
80 CLS:COLOR 15,2,1:D=0:C=0
90 PRINT " CYLOAD Short Cylinder-Loaded Dipole";
100 PRINT TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0,0
130 LOCATE 2:GOSUB 1760  :REM'diagram
140 COLOR 15,1:LOCATE ,21
150 PRINT " Antenna designed by Hal Wright, W9UYA ":COLOR 7,0
160 PRINT TAB(25)"Ref. QEX Sep/Oct 1998 pp.44-46"
170 PRINT
180 PRINT " The CYLOAD is a dipole with wire elements end-loaded by metal ";
190 PRINT "cylinders. The  "
200 PRINT " minimum length H is 265/MHz (57% of the length of an unloaded ";
210 PRINT "dipole 468/MHz  "
220 PRINT " long). However, as with all shortened antennas, the longer the";
230 PRINT " overall length,"
240 PRINT " the better the efficiency, so a CYLOAD should be longer than t";
250 PRINT "he minimum      "
260 PRINT " length wherever possible."
270 PRINT UL$;
280 PRINT " Press number in < > for:"
290 PRINT UL$;
300 PRINT "   < 1 >  CYLOAD antenna design"
310 PRINT "   < 0 >  EXIT";
320  Z$=INKEY$:IF Z$=""THEN 320
330  IF Z$="0"THEN CLS:RUN EX$
340  IF Z$="1"THEN 370
350 GOTO 320
360 :REM'
370 :REM'.....preface
380 LN=2:GOSUB 1720   :REM'clear screen
390 LOCATE 2:COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
400 GOSUB 1910  :REM'notes#1
410 GOSUB 2820
420 LN=3:GOSUB 1720
430 GOSUB 2400  :REM'notes#2
440 GOSUB 2820
450 LN=2:GOSUB 1720:LOCATE 2
460 GOSUB 1760    :REM'diagram
470 :REM'
480 :REM'.....frequency
490 PRINT:COLOR 7,0,0
500 INPUT " ENTER: Frequency of operation in MHz";F
510 LOCATE CSRLIN-1
520 IF F=0 THEN 500
530 U$=" Frequency and wavelength.... =#####.### MHz.=####.### metres"
540 PRINT USING U$;F,299.7925109863281!/F
550 :REM'
560 :REM'.....leg length
570 IPD=32.79999923706055!/F
580 LU=90*0.949999988079071!  :REM'90°less 5% for velocity factor, end effect, wire size etc.
590 U$=" Unloaded dipole length......H=#####.###°    =####.### ft.=####.### m"
600 PRINT USING U$;2*LU,2*LU*IPD/12,2*LU*IPD*0.02539999969303608!
610 LN=CSRLIN:
620 MAX=INT(LU):MIN=49:HI=65
630 M$=" Minimum length (approx).....L=#####°(###.# ft.)"
640 PRINT USING M$;MIN,MIN*IPD/12
650 PRINT
660 PRINT USING " Outside the range of ##°to ##° dimensions and ";MIN,HI;
670 PRINT "construction tolerances of the";
680 PRINT " cylinders tend to become unreasonably critical."
690 FLO=INT(MIN*32.79999923706055!/F/12*10)/10:FHI=INT(HI*32.79999923706055!/F/12*10)/10
700 COLOR 0,7
710 PRINT " Leg length between";FLO"ft. and";FHI"ft. recommended "
720 COLOR 7,0:PRINT
730 J=0:INPUT " ENTER: Desired leg length (ft.)... L=";Z:COLOR 7,0
740 IF Z>=FLO AND Z<=FHI THEN 780
750 J=1:COLOR 12:BEEP:PRINT Z"ft. is not recommended! "
760 COLOR 7,0:PRINT " .....press any key....."
770 Z$=INKEY$:IF Z$=""THEN 770 :ELSE 780
780 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
790 LD=Z*12/IPD
800 U$=" Length L .................. L=#####.###°    =####.### ft.=####.### m"
810 PRINT USING U$;LD,LD*IPD/12,LD*IPD*0.02539999969303608!:COLOR 7,0
820 :REM'
830 :REM'.....wire size
840 LN=CSRLIN
850 PRINT
860 PRINT " Do you want wire size in millimetres, inches, or AWG# ?   (m/i/a)"
870 Z$=INKEY$:IF Z$=""THEN 870
880 IF Z$="m"THEN M$="(mm.)":GOTO 930
890 IF Z$="i"THEN M$="(in.)":GOTO 930
900 IF Z$="a"THEN M$="(AWG)":GOTO 930
910 GOTO 870
920 :REM'
930 Z=0:PRINT:PRINT " ENTER: Wire size ";M$;:INPUT Z
940 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
950 IF Z$="m"THEN D=Z/25.399999618530273!:GOTO 990
960 IF Z$="i"THEN D=Z:GOTO 990
970 KK=(0.46000000834465027!/0.004999999888241291!)^(1/39)
980 D=0.46000000834465027!/KK^(Z+3):D=INT(D*1000)/1000
990 WD=D/IPD
1000 U$=" Wire diameter............. Wd=#####.###°    =####.### in.=####.## mm"
1010 PRINT USING U$;WD,WD*IPD,WD*IPD*25.399999618530273!
1020 :REM'
1030 LC=LD-45   :REM'cylinder length
1040 LW=LD-LC   :REM'wire length
1050 U$=" Wire length................ W=#####.###°    =####.### ft.=####.### m"
1060 PRINT USING U$;LW,LW*IPD/12,LW*IPD*0.02539999969303608!
1070 :REM'
1080 :REM'.....wire impedance
1090 ZW=60*(LOG(4*LW/WD)-1) :REM'Antenna Book, 17th edition, p.2-40, Eq 31
1100 XW=ZW/TAN(LW*PI/180)
1110 U$=" Impedance of wire section. Zw=#####.### Ω       Reactance=####.### Ω"
1120 PRINT USING U$;ZW,XW
1130 :REM'
1140 :REM'.....cylinder impedance
1150 REM:" Zc = Zw x tan Lw * tan Lc "  'equation by W9UYA
1160 ZC=ZW*TAN(LW*PI/180)*TAN(LC*PI/180)
1170 XC=ZC/TAN(LC*PI/180)
1180 U$=" Impedance of cylinder..... Zc=#####.### Ω       Reactance=####.### Ω"
1190 PRINT USING U$;ZC,XC
1200 :REM'
1210 :REM'.....wire length/diameter
1220 LDW=LW/WD
1230 U$=" Lgth/Dia.ratio of wire... LDw=#####.###:1"
1240 PRINT USING U$;LDW
1250 :REM'
1260 :REM'.....cylinder diameter
1270 LDC=(EXP((ZC/60)+1))/4
1280 U$=" Lgth/Dia.ratio of cyl.....LDc=#####.###:1"
1290 PRINT USING U$;LDC
1300 U$=" Cylinder length............ C=#####.###°    =####.### in. =####.## cm"
1310 PRINT USING U$;LC,LC*IPD,LC*IPD*2.5399999618530273!
1320 D=LC/LDC
1330 U$=" Cylinder diameter.......... D=#####.###°    =####.### in. =####.## cm"
1340 PRINT USING U$;D,D*IPD,D*IPD*2.5399999618530273!
1350 CC=D*PI   :REM'cylinder circumference
1360 U$=" Cylinder circumference..................... =####.### in. =####.## cm"
1370 PRINT USING U$;CC*IPD,CC*IPD*2.5399999618530273!
1380 COLOR 0,7:LOCATE 2,13:PRINT STRING$(55,32)
1390 COLOR 7,0:LOCATE 12:PRINT STRING$(79,32):LOCATE 12
1400 U$=" CYLOAD dipole length........H=#####.###°    =####.### ft.=####.### m"
1410 PRINT USING U$;2*LD,2*LD*IPD/12,2*IPD*0.02539999969303608!
1420 IF LDC<1 THEN 1480
1430 IF J=0 THEN 1460 :ELSE LOCATE 10
1440 COLOR 12:PRINT " Results may be inaccurate due to inadvisable selection";
1450 PRINT " of dimension L"
1460 GOTO 1590
1470 :REM'
1480 BEEP:COLOR 12,0:LOCATE 23
1490 PRINT " CYLINDER CALCULATIONS ARE INEFFECTUAL IF LDc LESS THAN 1:1";
1500 GOTO 1590
1510 :REM'
1520 :REM'.....title line
1530 COLOR 7,0,0:LOCATE 1:PRINT STRING$(80,32);
1540 T$="####.### MHz CYLOAD Short Cylinder-Loaded Dipole ###.## ft.(###.## m)"
1550 T$=T$+" Long"
1560 FT=2*LD/12*IPD
1570 LOCATE 1,2:PRINT USING T$;F,FT,FT*0.30480000376701355!
1580 COLOR 0,7:LOCATE 2,13:PRINT STRING$(55,32);
1590 COLOR 7,0,0:GOSUB 2820
1600 LOCATE 24,23:COLOR 0,7,0:PRINT " Try (a)nother or (q)uit?   (a/q) ";
1610 COLOR 7,0
1620 Z$=INKEY$:IF Z$=""THEN 1620
1630 IF Z$="q"THEN 70
1640 IF Z$="a"THEN 70
1650 GOTO 1620
1660 LOCATE 1,1:PRINT STRING$(80,32);
1670 :REM'
1680 VIEW PRINT 10 TO 24:CLS:VIEW PRINT:LOCATE 10
1690 GOTO 480
1700 END
1710 :REM'
1720 :REM'.....clear screen to bottom
1730 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1740 RETURN
1750 :REM'
1760 :REM'.....diagram
1770 T=13
1780 COLOR 1,7
1790 LOCATE ,T:PRINT STRING$(55,223)
1800 COLOR 0,7
1810 LOCATE ,T:PRINT "     │«─────────────────── H ───────────────────»│     "
1820 LOCATE ,T:PRINT "     │«──────── L ────────»│«──────── L ────────»│     "
1830 LOCATE ,T:PRINT " ---∞┬─────────┬───────────┐┌──────────┬─────────┬∞--- "
1840 LOCATE ,T:PRINT "     └───cyl───┘    wire   ╟┘  wire    └───cyl───┘     "
1850 LOCATE ,T:PRINT "     │«── C ──»│«─── W ───»║«─── W ───»│«── C ──»│     "
1860 LOCATE ,T:PRINT "      D diameter           ║            D diameter     "
1870 LOCATE ,T:PRINT "                50-75 Ω coaxial feedline               "
1880 COLOR 7,0
1890 RETURN
1900 :REM'
1910 :REM'.....notes #1
1920 M=7
1930 PRINT TAB(M);
1940 PRINT "  CYLOAD is an EXPERIMENTAL antenna designed by Hal Wright, W9UYA,"
1950 PRINT TAB(M);
1960 PRINT "who reports that it performs well. It does not claim any practical"
1970 PRINT TAB(M);
1980 PRINT "advantage over other short dipole types but it does re-open an area"
1990 PRINT TAB(M);
2000 PRINT "of antenna design not often mentioned in current amateur radio"
2010 PRINT TAB(M);
2020 PRINT "literature. The program provides calculations for those who might"
2030 PRINT TAB(M);
2040 PRINT "like to experiment further with this concept."
2050 PRINT TAB(M);
2060 PRINT "  Previous discussions of cylindrical loads in amateur radio"
2070 PRINT TAB(M);
2080 PRINT "literature have assumed the length and diameter of the loading"
2090 PRINT TAB(M);
2100 PRINT "cylinder to be equal. CYLOAD does not impose this limitation."
2110 PRINT TAB(M);
2120 PRINT "  Cylinders may be rolled from roofers' flashing sheets or metal"
2130 PRINT TAB(M);
2140 PRINT "screening, or cut from copper water pipe or aluminum tubing."
2150 PRINT TAB(M);
2160 PRINT "  Practical field tests by W9UYA indicate that antennas built to"
2170 PRINT TAB(M);
2180 PRINT "this design resonate at very close to the design frequency in the"
2190 PRINT TAB(M);
2200 PRINT "range of 7 MHz to 21.5 MHz. At 24.8 - 148 MHz it may be advisable"
2210 PRINT TAB(M);
2220 PRINT "to increase the design length of the inner wires by about 10% to"
2230 PRINT TAB(M);
2240 PRINT "allow for pruning to resonance at the design frequency."
2250 PRINT TAB(M);
2260 PRINT "  The fundamental equation for a CYLOAD antenna is:"
2270 PRINT TAB(M);
2280 PRINT "Zc = (Zw x tan Lw x tan Lc) where: Zc = impedance of cylinder (Ω)"
2290 PRINT TAB(M);
2300 PRINT "                                   Zw = impedance of wire (Ω)"
2310 PRINT TAB(M);
2320 PRINT "                                   Lw = length of wire (°)"
2330 PRINT TAB(M);
2340 PRINT "                                   Lc = length of cylinder (°)"
2350 COLOR 15,4:LOCATE,M
2360 PRINT "  A transmatch at the station end of the feedline is recommended.";
2370 COLOR 7,0
2380 RETURN
2390 :REM'
2400 :REM'.....notes#2
2410 PRINT TAB(M);
2420 PRINT "Other equations used are from the ARRL Antenna Book, 17th edition,"
2430 PRINT TAB(M);
2440 PRINT "chapter 2, page 2-40:"
2450 PRINT
2460 PRINT TAB(M);
2470 PRINT "  Zo = 60 [ LOGn ( 4h/d ) - 1 ]      (Eq 31)"
2480 PRINT TAB(M);
2490 PRINT "  X  = Zo / tan Φ                    (Eq 32)"
2500 PRINT
2510 PRINT TAB(M);
2520 PRINT "where Zo= impedance, h= length of radiator, d= diameter of radiator"
2530 PRINT TAB(M);
2540 PRINT "      X= reactance, Φ= amount of electrical loading in degrees"
2550 PRINT
2560 PRINT TAB(M);
2570 PRINT "  Special thanks go to L.B.Cebik, W4RNL, for his encouragement in"
2580 PRINT TAB(M);
2590 PRINT "the development of the CYLOAD antenna, and for the many computer"
2600 PRINT TAB(M);
2610 PRINT "models he has run to check out the viability and accuracy of the"
2620 PRINT TAB(M);
2630 PRINT "design. These models and the practical field tests by Hal Wright,"
2640 PRINT TAB(M);
2650 PRINT "W9UYA, indicate that good performance characteristics are possible"
2660 PRINT TAB(M);
2670 PRINT "in the 3.5 to 28 MHz range."
2680 PRINT TAB(M);
2690 PRINT "  The CYLOAD concept is based on equations usually applied to cases"
2700 PRINT TAB(M);
2710 PRINT "where the conductor diameter is an insignificant percentage of a"
2720 PRINT TAB(M);
2730 PRINT "wavelength (e.g., at LF and VLF frequencies). At HF and above the"
2740 PRINT TAB(M);
2750 PRINT "percentage becomes more significant and the equations become"
2760 PRINT TAB(M);
2770 PRINT "increasingly more inaccurate. Above 21 MHz allowance should be made"
2780 PRINT TAB(M);
2790 PRINT "for further experimentation and pruning."
2800 RETURN
2810 :REM'
2820 :REM'PRT
2830 KEY OFF:GOSUB 2900:LOCATE 25,5:COLOR 0,2
2840 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2850 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2860 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2860 :ELSE GOSUB 2900
2870 IF Z$="3"THEN RETURN
2880 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2890 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2830
2900 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
