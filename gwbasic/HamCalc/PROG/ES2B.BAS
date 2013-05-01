10 :REM'ES2B - Electrically Shortened 2 Band Dipole - 09 JAN 2002
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 IF GO$="es2b"THEN GO$=EX$
50 PROG$="es2b"
60 COMMON EX$,PROG$,LD,UH,FQ,W
70 COMMON A,A1,B1,B,XT,C1,L1,L2,FH,FL,AMAX
80 CLS:KEY OFF
90 PI=3.1415929794311523!
100 UL$=STRING$(80,205)
110 DIM GA(40)
120 :REM'
130 :REM'.....AWG calculator
140 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
150 FOR Z=1 TO 40
160 N=Z+3
170 GA(Z)=0.46000000834465027!/K^N
180 NEXT Z
190 :REM'
200 IF A*A1*B1*B*XT*C1*FH*FL*W THEN D=W:COLOR 7,0,0:CLS:GOSUB 1970:GOTO 1540
210 :REM'.....title page
220 COLOR 7,0,1
230 CLS
240 FH=0:FL=0:D=0:XT=0:C1=0:L1=0:L2=0:L3=0:LD=0
250 A=0:A1=0:A2=0:B=0:B1=0:B2=0:B3=0:B4=0:BB=0:X=0
260 COLOR 15,2
270 PRINT " SHORT ES2B (Electrically Shortened 2-Band) DIPOLE";
280 PRINT TAB(57)"by George Murphy VE3ERP ";
290 COLOR 1,0:PRINT STRING$(80,223);
300 COLOR 15,1:LOCATE CSRLIN-1,20
310 PRINT " (primary equation by Jerry Hall, K1TD) "
320 COLOR 7,0
330 GOSUB 1970  :REM'diagram
340 PRINT
350 GOSUB 2110  :REM'preface
360 PRINT
370 PRINT "    Press: 1 to run program"
380 PRINT "           2 for explanatory diagram and notes"
390 PRINT "           0 to EXIT";
400 Z$=INKEY$:IF Z$=""THEN 400
410 IF Z$="0"THEN COLOR 7,0,0:CLS:CHAIN GO$
420 IF Z$="1" THEN 470
430 IF Z$="2" THEN CLS:GOSUB 2250
440 GOSUB 2590
450 GOTO 210
460 :REM'
470 :REM'.....data input
480 COLOR 7,0,0:COLOR 7,0,0:CLS:GOSUB 1970
490 FH=O:FL=0:D=0:XL=0:XT=0:L=0:C=0
500 PRINT:LN=CSRLIN:COLOR 0,7
510 PRINT " Press letter in ( ) to select your choice: ":COLOR 7,0
520 PRINT "    (a) wire size in AWG"
530 PRINT "    (b) wire size in millimetres"
540 PRINT "    (c) wire size in inches"
550 Z$=INKEY$:IF Z$=""THEN 550
560 IF Z$="a"THEN Y$="AWG.......":GOTO 600
570 IF Z$="b"THEN Y$="mm........":GOTO 600
580 IF Z$="c"THEN Y$="inches  ..":GOTO 600
590 GOTO 550
600 COLOR 0,7:PRINT " ENTER: Wire size in ";Y$;:COLOR 7,0:PRINT " ";:INPUT Y
610 IF Z$="a"THEN D=GA(Y)
620 IF Z$="b"THEN D=Y/25.399999618530273!
630 IF Z$="c"THEN D=Y
640 AWG=LOG(0.46000000834465027!/D)/(LOG(K))-3
650 PRINT USING " Wire size =####.# AWG";AWG
660 PRINT USING "           =###.## mm";D*25.399999618530273!
670 PRINT USING "           =##.### in.";D
680 COLOR 0,7:PRINT " Press any key to continue ":COLOR 7,0
690 Z$=INKEY$:IF Z$=""THEN 690
700 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
710 COLOR 0,7:PRINT " Enter frequencies of any two bands of operation:"
720 LN=CSRLIN:COLOR 7,0
730 INPUT " ENTER: Centre frequency (MHz) of one of the bands...........";FL
740 INPUT " ENTER: Centre frequency (MHz) of the other band.............";FH
750 IF FL>FH THEN SWAP FL,FH
760 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
770 PRINT USING " Lower frequency  = ###.### Mhz";FL
780 PRINT USING " Higher frequency = ###.### Mhz";FH
790 COLOR 0,7
800 PRINT " ENTER: Frequency (MHz) of bottom edge of the";FH;"MHz band..";
810 COLOR 7,0:INPUT FHB
820 LOCATE 2,41:PRINT USING "###.### MHz";FL
830 LOCATE 3,41:PRINT USING "###.### MHz";FH
840 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN-1
850 PRINT
860 PRINT:LOCATE ,4:COLOR 0,7
870 PRINT " Recommended reactance of an antenna trap is in the range of 300-";
880 PRINT "450 ohms "
890 LOCATE ,13:COLOR 7,0
900 PRINT "(The ARRL ELECTRONICS DATA BOOK, 2nd Edition, page 7-12)"
910 LOCATE ,14:COLOR 0,7
920 PRINT " Trap Q decreases, bandwidth increases with reactance "
930 LOCATE ,13:COLOR 7,0
940 PRINT "(The ARRL ELECTRONICS DATA BOOK, 2nd Edition, page 5-12)"
950 LOCATE ,14
960 PRINT "(The 1997 ARRL HANDBOOK for RADIO AMATEURS, page 20.7)"
970 LOCATE ,27:COLOR 0,7:PRINT " If in doubt, enter 375 ohms "
980 COLOR 0,7:PRINT
990 INPUT " ENTER: Desired approximate reactance of trap, in ohms....";XT
1000 C1=10^6/(2*PI*FH*XT)
1010 COLOR 7,0:LOCATE CSRLIN-1:PRINT STRING$(80,32);:COLOR 0,7
1020 PRINT" ENTER: Value of a standard capacitor C1, close to";
1030 PRINT USING "#### pF ";C1;
1040 COLOR 7,0
1050 INPUT C1
1060 XT=10^6/(2*PI*FH*C1)
1070 L1=XT/2/PI/FH :REM'trap coil inductance
1080 :REM'
1090 :REM'.....design trap antenna
1100 A=468/FL:B=468/FH/2
1110 E1=10^6/(34*PI*FL)
1120 INC=1     :REM'initial increment
1130 E2=LOG(24*(234/FL-B)/D)-1
1140 E3=(1-FL*B/234)^2-1
1150 E4=234/FL-B
1160 XCZ=1/(2*PI*FL*C1)*10^6
1170 XLZ=2*PI*FL*L1
1180 XZ=-XLZ*XCZ/(XLZ-XCZ)
1190 A=A-INC
1200 E5=LOG(24*(A/2-B)/D)-1
1210 E6=((FL*A/2-FL*B)/234)^2-1
1220 E7=A/2-B
1230 XL=E1*(E2*E3/E4-E5*E6/E7)
1240 IF ABS(XL-XZ)<0.0010999999940395355! THEN 1280
1250 IF XL<XZ THEN 1190
1260 A=A+INC:INC=INC/2:GOTO 1190
1270 :REM'
1280 VIEW PRINT 10 TO 24:CLS:VIEW PRINT:LOCATE 11
1290 B1=2*B
1300 AMIN=2*INT(B/0.8999999761581421!)+1
1310 AMAX=CINT(A)-1
1320 A$=" Length of a ##.### Mhz 1/2 wave dipole is ###.## feet"
1330 PRINT USING A$;FL,468/FL
1340 A$=" Length of a ##.### / ##.### MHz trap dipole is ###.## feet"
1350 PRINT USING A$;FL,FH,A
1360 PRINT
1370 PRINT " Select an ES2B length A beween";AMIN;"feet and";AMAX;"feet "
1380 PRINT
1390 COLOR 0,7:PRINT " ENTER: Your choice of length A ";:COLOR 7,0:INPUT AA
1400 IF AA<AMIN OR AA>AMAX THEN BEEP:GOTO 1390
1410 COLOR 7,0
1420 A=AA
1430 F=FL
1440   F1=10^6/(68*PI^2*F^2)
1450   F2=LOG(24*(234/F-B)/D)-1
1460   F3=(1-F*B/234)^2-1
1470   F4=234/F-B
1480   F5=LOG(24*(A/2-B)/D)-1
1490   F6=((F*A/2-F*B)/234)^2-1
1500   F7=A/2-B
1510 L3=F1*(F2*F3/F4-F5*F6/F7)
1520 L2=L3-L1
1530 :REM'
1540 :REM'.....final screen display
1550 VIEW PRINT 10 TO 24:CLS:VIEW PRINT:LOCATE 10
1560 M=0.30480000376701355!
1570 PRINT USING " ###.### MHz dipole....A = ####.## ft.(##.## m.)";FL,A,A*M;
1580 PRINT USING ":full size dipole is ###.## ft.";468/FL
1590 A1=A/2-B
1600 PRINT USING "                       A1= ####.## ft.(##.## m.)";A1,A1*M
1610 PRINT USING " ###.### MHz dipole....B1= ####.## ft.(##.## m.)";FH,B1,B1*M;
1620 PRINT USING ":full size dipole is ###.## ft.";468/FH
1630 PRINT USING "                       B = ####.## ft.(##.## m.)";B,B*M
1640 PRINT USING " Trap reactance........X = ####.### ohms";XT
1650 PRINT USING " Trap capacitor........C1= ####.### pF";C1
1660 PRINT USING " Trap inductor.........L1= ####.### µH";L1
1670 PRINT USING " Loading coil..........L2= ####.### µH";L2
1680 PRINT USING " Effective loading.....L3= ####.### µH";L1+L2
1690 A$=" (The length of a ##.### / ##.### MHz unshortened trap dipole is "
1700 A$=A$+"about ### ft.)"
1710 COLOR 0,7:PRINT USING A$;FL,FH,AMAX
1720 COLOR 7,0:PRINT UL$;
1730 COLOR 0,7
1740 LOCATE 5,69:PRINT " Wire dia. "
1750 LOCATE  ,69:PRINT USING "┌ ##.# AWG ";AWG
1760 LOCATE  ,68:PRINT USING "«┤ #.### in.";D
1770 LOCATE  ,69:PRINT USING "└ #.## mm. " ;D*25.399999618530273!
1780 LOCATE 14,47:PRINT " Depending on design parameters  "
1790 LOCATE   ,47:PRINT " chosen, feedpoint impedance may "
1800 LOCATE   ,47:PRINT " not be close to 50-75Ω so coax  "
1810 LOCATE   ,47:PRINT " feedline may not be advisable.  "
1820 COLOR 7,0
1830 GOSUB 2590
1840 :REM'
1850 LOCATE 21
1860 PRINT " Press: 1 to run Coil Designer program for L1"
1870 PRINT "        2 to run Coil Designer program for L2"
1880 PRINT "        3 to configure as an Inverted Vee"
1890 PRINT "        0 to Quit";
1900 Z$=INKEY$
1910 IF Z$="0"THEN 210
1920 IF Z$="1"THEN LD=0.5!:FQ=FHB:UH=L1:W=D:CHAIN"coildsgn"
1930 IF Z$="2"THEN LD=0:FQ=FL:UH=L2:W=D:CHAIN"coildsgn"
1940 IF Z$="3"THEN CHAIN"invee"
1950 GOTO 1900
1960 :REM'
1970 :REM'.....diagram
1980 COLOR 0,7:T=13
1990 LOCATE ,T:PRINT "         ELECTRICALLY SHORTENED 2 BAND DIPOLE          "
2000 LOCATE ,T:PRINT " │«───────────────────── A ─────────────────────────»│ "
2010 LOCATE ,T:PRINT " │«─── A1───»│«───────── B1─────────────»│«─── A1───»│ "
2020 LOCATE ,T:PRINT " │           │«──── B ────»│«──── B ────»│           │ "
2030 LOCATE ,T:PRINT " │     ⌐ L3  ¬             │             ⌐  L3 ¬     │ "
2040 LOCATE ,T:PRINT " │     L2  L1│             │             │L1  L2     │ "
2050 LOCATE ,T:PRINT " ∞─────∩∩∩┬∩∩∩┬───────────┐ ┌───────────┬∩∩∩┬∩∩∩─────∞ "
2060 LOCATE ,T:PRINT "          └─╫─┘   Open-wire feedline    └─╫─┘          "
2070 LOCATE ,T:PRINT "           C1     with antenna tuner      C1           "
2080 COLOR 7,0
2090 RETURN
2100 :REM'
2110 :REM'.....preface
2120 PRINT "    This program:"
2130 PRINT " a> Computes B1 for a 1/2 wave dipole at the higher frequency"
2140 PRINT " b> Computes L1 & C1 for traps resonant at the higher frequency"
2150 PRINT " c> Computes A,B,L2 & A1 for an off-centre loaded dipole at the";
2160 PRINT " lower frequency"
2170 PRINT
2180 PRINT " All electrically shortened dipoles are inherently less efficie";
2190 PRINT "nt and have less"
2200 PRINT " gain than 1/2 wave dipoles, but they do work, usually with muc";
2210 PRINT "h more gain and "
2220 PRINT " better efficiency than short loaded vertical antennas.  "
2230 RETURN
2240 :REM'
2250 :REM'.....explanatory diagram and notes
2260 COLOR 0,7,0:T=16
2270 LOCATE ,T:PRINT "                                                 "
2280 LOCATE ,T:PRINT " │«──────────────────── A ────────────────────»│ "
2290 LOCATE ,T:PRINT " │         L1 │«─────── B ───────»│ L1         │ "
2300 LOCATE ,T:PRINT " ∞────────┬∩∩∩┬────────┐ ┌────────┬∩∩∩┬────────∞ "
2310 LOCATE ,T:PRINT "          └─╫─┘    TRAP DIPOLE    └─╫─┘          "
2320 LOCATE ,T:PRINT "            C1        Fig.1a       C1            "
2330 LOCATE ,T:PRINT "       L2                               L2       "
2340 LOCATE ,T:PRINT " ∞─────∩∩∩─────────────┐ ┌─────────────∩∩∩─────∞ "
2350 LOCATE ,T:PRINT "          ELECTRICALLY SHORTENED DIPOLE          "
2360 LOCATE ,T:PRINT "                      Fig.1b                     "
2370 LOCATE ,T:PRINT "       L2   L1                     L1   L2       "
2380 LOCATE ,T:PRINT " ∞─────∩∩∩┬∩∩∩┬────────┐ ┌────────┬∩∩∩┬∩∩∩─────∞ "
2390 LOCATE ,T:PRINT "          └─╫─┘    ES2B DIPOLE    └─╫─┘          "
2400 LOCATE ,T:PRINT "            C1        Fig.1c       C2            "
2410 PRINT
2420 COLOR 7,0:LOCATE 16
2430 PRINT "A trap dipole (Fig.1a) consists of two dipoles A & B segregated";
2440 PRINT " by L1/C1 traps";
2450 PRINT "tuned to the higher frequency."
2460 PRINT
2470 PRINT "An electrically shortened dipole (Fig.1b) has loading coils L2 ";
2480 PRINT "inserted in each"
2490 PRINT "leg, which physically shortens the antenna."
2500 PRINT
2510 PRINT "The ES2B dipole (Fig.1c) is an electrically shortened trap dipole,";
2520 PRINT " where L1 and"
2530 PRINT "L2 together function as the loading coil."
2540 RETURN
2550 :REM'
2560 :REM'.....end
2570 GOSUB 2590:GOTO 210
2580 :REM'
2590 :REM'PRT
2600 KEY OFF:GOSUB 2670:LOCATE 25,5:COLOR 0,2
2610 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2620 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2630 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2630 :ELSE GOSUB 2670
2640 IF Z$="3"THEN RETURN
2650 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2660 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2600
2670 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
