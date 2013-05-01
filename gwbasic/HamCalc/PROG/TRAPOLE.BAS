10 :REM'TRAPOLE - Trap Antenna Design - 22 JUN 1998 rev. 06 FEB 2004
20 IF EX$=""THEN EX$="EXIT"
22 PROG$="trapole"
25 COMMON EX$,PROG$
30 CLS:KEY OFF
40 COLOR 7,0,1
50 PI=3.1415929794311523!
60 UL$=STRING$(80,205)
70 DIM GA(40)
80 :REM'
90 :REM'.....AWG calculator
100 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
110 FOR Z=1 TO 40
120 N=Z+3
130 GA(Z)=0.46000000834465027!/K^N
140 NEXT Z
150 :REM'
160 :REM'.....title page
170 CLS
180 COLOR 15,2
190 PRINT " TRAP ANTENNA DESIGN";TAB(57);"by George Murphy VE3ERP ";
200 COLOR 1,0:PRINT STRING$(80,223);
210 COLOR 7,0
220 LN=CSRLIN:GOSUB 1650:GOSUB 1760   :REM'diagram
230 PRINT :LN=CSRLIN
240 GOSUB 1880  :REM'disclaimer
250 LOCATE ,9
260 PRINT " (Ref. ARRL ANTENNA BOOK, 17th Edition, pp. 6-6, 7-8 and 7-10)";
270 PRINT " NOTE: If the antenna is designed for 3.75 & 7.2 MHz it will also";
280 PRINT " perform"
290 PRINT "       efficiently in the 20, 15 and 10 metre bands."
300 PRINT :PRINT :PRINT
310 PRINT " Press (1) to run program, (2) to design traps or (0) to EXIT"
320 COLOR 7,0
330 Z$=INKEY$:IF Z$=""THEN 330
340 IF Z$="0"THEN CLS:CHAIN EX$
350 IF Z$="1" THEN 400
360 IF Z$="2"THEN CLS:CHAIN"trapcalc"
370 GOTO 330
380 GOTO 330
390 :REM'
400 :REM'.....data input
410 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
420 FH=O:FL=0:D=0:XL=0:XT=0:L=0:C=0
430 COLOR 0,7
440 PRINT " Press letter in ( ) to select closest description ";
450 PRINT "of conductor to be used:"
460 COLOR 7,0
470 PRINT " (You may press intermediate letters for intermediate sizes)"
480 PRINT
490 FOR Z=8 TO 24 STEP 2
500 PRINT "   (";CHR$(89+Z);") ";USING "AWG ##";Z;
510 PRINT USING " =  #.### in. (##.## mm.) dia.";GA(Z),GA(Z)*25.399999618530273!
520 NEXT Z
530 PRINT "   (r) Aluminum tubing"
540 Z$=INKEY$:IF Z$=""THEN 540
550 IF Z$="r"THEN 600
560 IF Z$<"a"OR Z$>"q"THEN 590 :ELSE 590
570 IF Z$="r"THEN 600
580 GOTO 540
590 Z=ASC(Z$)-89:D=GA(Z):GOTO 610
600 INPUT " ENTER: tubing diameter in inches";D
610 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
620 COLOR 0,7:PRINT " Select any two centre frequencies of operation:":COLOR 7,0
630 INPUT " ENTER: One of the two centre frequencies (MHz)...";FH
640 INPUT " ENTER: Other centre frequency (MHz)..............";FL
650 IF FL>FH THEN SWAP FL,FH
660 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN-1
670 PRINT "        HIGHER centre frequency of interest....ƒH=";
680 PRINT USING "#####.### MHz";FH;:PRINT SPC(15)
690 PRINT "        LOWER centre frequency of interest.....ƒL=";
700 PRINT USING "#####.### MHz";FL
710 PRINT "        Diameter of conducting elements.........D=";
720 PRINT USING "#####.### in.";D;:PRINT USING " (###.## mm.)";D*25.399999618530273!
730 B=468/FH/2:WI=B:COLOR 7,0:LOCATE ,8
740 PRINT " Length of inner dipole................. B=";
750 PRINT USING "#####.##  ft.";2*WI;:PRINT USING " (###.## m. )";2*WI*0.30480000376701355!
760 LN=CSRLIN:COLOR 7,0
770 PRINT:LOCATE ,4:COLOR 0,2
780 PRINT " Recommended reactance of an antenna trap is in the range of 300-";
790 PRINT "450 ohms "
800 LOCATE ,13:COLOR 7,0
810 PRINT "(The ARRL ELECTRONICS DATA BOOK, 2nd Edition, page 7-12)"
820 LOCATE ,14:COLOR 0,2
830 PRINT " Trap Q decreases, bandwidth increases with reactance "
840 LOCATE ,13:COLOR 7,0
850 PRINT "(The ARRL ELECTRONICS DATA BOOK, 2nd Edition, page 5-12)"
860 LOCATE ,14
870 PRINT "(The 1997 ARRL HANDBOOK for RADIO AMATEURS, page 20.7)"
880 LOCATE ,27:COLOR 0,2:PRINT " If in doubt, enter 375 ohms "
890 COLOR 15,4:PRINT
900 INPUT " ENTER: Desired approximate reactance of trap, in ohms, @ ƒH MHz";XT
910 C=10^6/(2*PI*FH*XT)
920 COLOR 7,0:LOCATE CSRLIN-1:PRINT STRING$(80,32);:COLOR 0,7:LOCATE CSRLIN-1
930 PRINT" ENTER: Value of a standard capacitor C, close to";
940 PRINT USING "###.# pF ";C;
950 INPUT C
960 XT=10^6/(2*PI*FH*C)
970 L=XT/2/PI/FH  :REM'inductance
980 COLOR 7,0
990 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1000 :REM'
1010 :REM'.....compute values
1020 A=468/FL   :REM'initial overall length
1030 E1=10^6/(34*PI*FL)
1040 INC=1     :REM'initial increment
1050 E2=LOG(24*(234/FL-B)/D)-1
1060 E3=(1-FL*B/234)^2-1
1070 E4=234/FL-B
1080 XCZ=1/(2*PI*FL*C)*10^6
1090 XLZ=2*PI*FL*L
1100 XZ=-XLZ*XCZ/(XLZ-XCZ)  :REM'effective combined reactance
1110 :REM'
1120 A=A-INC
1130 E5=LOG(24*(A/2-B)/D)-1
1140 E6=((FL*A/2-FL*B)/234)^2-1
1150 E7=A/2-B
1160 XL=E1*(E2*E3/E4-E5*E6/E7)
1170 IF ABS(XL-XZ)<0.0010000000474974513! THEN LOCATE LN:GOTO 1280
1180 IF XL<XZ THEN 1120
1190 A=A+INC:INC=INC*0.10000000149011612!:IF INC=0 THEN 1210 :ELSE 1120
1200 :REM'
1210 BEEP:COLOR 0,7:LOCATE ,8
1220 PRINT " THE PARAMETERS YOU HAVE SPECIFIED REQUIRE A MINIMUM REACTANCE OF";
1230 PRINT INT(XL+1);"Ω "
1240 COLOR 7,0
1250 PRINT "  . . . Press any key to start over . . ."
1260 IF INKEY$=""THEN 1260 :ELSE 80
1270 :REM'
1280 LOCATE LN:COLOR 7,0
1290 PRINT "        Length of inner element................Wi=";
1300 PRINT USING "#####.##  ft.";WI;:PRINT USING " (###.## m. )";WI*0.30480000376701355!
1310 WO=A/2-B
1320 LOCATE ,8:COLOR 0,7
1330 PRINT "        Inductance of each coil.................L=";
1340 PRINT USING "#####.## µH";L
1350 LOCATE ,8
1360 PRINT "        Value of each capacitor.................C=";
1370 PRINT USING "#####.## pF";C
1380 LOCATE ,8
1390 COLOR 7,0
1400 PRINT " Reactance of L and C @ ƒH MHz. ........Xt=";
1410 PRINT USING "#####.## Ω each";XT
1420 LOCATE ,8
1430 I=0:L$=" (Q AND PASSBAND WIDTH ARE WITHIN RECOMMENDED LIMITS) "
1440 IF XT>450 THEN I=4:L$= " (Q IS TOO LOW AND PASSBAND IS TOO BROAD) "
1450 IF XT<300 THEN I=0:L$= " (Q IS QUITE HIGH AND PASSBAND IS QUITE NARROW) "
1460 COLOR 15,I:PRINT L$:COLOR 7,0
1470 PRINT "        Reactance of coil L @ ƒL MHz. ........XLz=";
1480 PRINT USING "#####.## Ω inductive";XLZ
1490 PRINT "        Reactance of capacitor C @ ƒL MHz. ...XCz=";
1500 PRINT USING "#####.## Ω capacitive";ABS(XCZ)
1510 PRINT "        Reactance of paralleled L,C @ ƒL MHz...Xz=";
1520 PRINT USING "#####.## Ω inductive";XZ
1530 PRINT "        Length of outer element + trap.........Wo=";
1540 PRINT USING "#####.##  ft.";WO;:PRINT USING " (###.## m. )";WO*0.30480000376701355!
1550 COLOR 0,7:LOCATE ,8
1560 PRINT " Overall length of dipole............... A=";
1570 PRINT USING "#####.##  ft.";A;:PRINT USING " (###.## m. )";A*0.30480000376701355!
1580 COLOR 0,7:LOCATE ,8
1590 MO=WI+WO
1600 PRINT " Overall length of monopole............. H=";
1610 PRINT USING "#####.##  ft.";MO;:PRINT USING " (###.## m. )";MO*0.30480000376701355!;
1620 COLOR 7,0
1630 GOTO 2020
1640 :REM'
1650 :REM'.....diagram
1660 COLOR 0,7:T=2
1670 LOCATE ,T:PRINT "             DUAL BAND TRAP DIPOLE             "
1680 LOCATE ,T:PRINT "     │«─────────────── A ───────────────»│     "
1690 LOCATE ,T:PRINT "     │«─ Wo ─»│«────── B ──────»│«─ Wo ─»│     "
1700 LOCATE ,T:PRINT "     │      L │«─ Wi ─»│«─ Wi ─»│ L      │     "
1710 LOCATE ,T:PRINT " - - ∞────┬∩∩∩┬────────┐┌───────┬∩∩∩┬────∞ - - "
1720 LOCATE ,T:PRINT "          └─╫─┘        ╟┘       └─╫─┘          "
1730 LOCATE ,T:PRINT "            C      52 Ω║COAX      C            "
1740 COLOR 7,0
1750 RETURN
1760 :REM'.....monopole
1770 COLOR 0,7:LOCATE LN
1780 LOCATE ,50:PRINT " ┌ DUAL BAND TRAP VERTICAL    "
1790 LOCATE ,50:PRINT " │ Wo─»│                      "
1800 LOCATE ,50:PRINT " H     █«─ trap               "
1810 LOCATE ,50:PRINT " │ Wi─»│«─ monopole           "
1820 LOCATE ,50:PRINT " └     └─ «┐ 50 Ω coax        "
1830 LOCATE ,50:PRINT "       ┌─ «┘ to transceiver   "
1840 LOCATE ,50:PRINT "     ground                   "
1850 COLOR 7,0
1860 RETURN
1870 :REM'
1880 :REM'.....preface
1890 GOTO 1940
1900 OPEN"I",1,"\hamcalc\docfiles\antenna.doc"
1910 IF EOF(1)THEN 1930
1920 INPUT#1,NOTE$:PRINT "   ";NOTE$:GOTO 1910
1930 CLOSE:PRINT UL$;
1940 PRINT " This Dual-Band Trap Antenna program"
1950 PRINT "   a> Computes B & Wi for operation as a ½-wave dipole at the";
1960 PRINT " higher frequency."
1970 PRINT "   b> Computes L & C to resonate traps at the higher frequency."
1980 PRINT "   c> Computes A & Wo for an off-centre loaded dipole at the lower";
1990 PRINT " frequency."
2000 RETURN
2010 :REM'
2020 :REM'.....end
2030 GOSUB 2050:GOTO 160
2040 :REM'
2050 :REM'PRT
2060 KEY OFF:GOSUB 2130:LOCATE 25,5:COLOR 0,2
2070 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2080 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2090 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2090 :ELSE GOSUB 2130
2100 IF Z$="3"THEN RETURN
2110 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2120 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2060
2130 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
