10 :REM'SNGLWIRE - 26 MAY 95 rev. 20 AUG 2007
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 U$="#,###.#"
70 PI=3.1415929794311523!
80 DIM AWG(40)   :REM'AWG sizes
90 DIM CF(11,2)  :REM'centre frequency of each band
100 :REM'
110 DATA 1.8,1.897,3.742,7.148,10.125,14.174,18.118,21.224,24.94,28.837,29.7
120 FOR Z=1 TO 11:READ CF(Z,1):NEXT Z
130 :REM'
140 :REM'.....load AWG sizes
150 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
160 FOR Z=1 TO 40
170 N=Z+3
180 AWG(Z)=0.46000000834465027!/K^N
190 NEXT Z
200 :REM'
210 :REM'.....start
220 CLS:Y=0
230 COLOR 15,2
240 PRINT " SINGLE WIRE ANTENNA SYSTEM";TAB(57);"by George Murphy VE3ERP ";
250 COLOR 1,0:PRINT STRING$(80,223);
260 COLOR 7,0
270 :REM'
280 :REM'.....preface
290 :REM'OPEN"I",1,"\hamcalc\docfiles\antenna.doc"
300 :REM'IF EOF(1)THEN 320
310 :REM'INPUT#1,NOTE$:PRINT "   ";NOTE$:GOTO 300
320 :REM'CLOSE
330 :REM'PRINT UL$;
340 GOSUB 3070  :REM'further notes
350 COLOR 15,1
360 LOCATE 25,22:PRINT " Press 1 to continue or 0 to EXIT.....";
370 COLOR 7,0
380 Z$=INKEY$:IF Z$=""THEN 380
390 IF Z$="0"THEN CLS:RUN EX$
400 IF Z$="1"THEN 420
410 GOTO 380
420 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
430 GOTO 500
440 :REM'
450 :REM'.....format input line
460 USIN$="####.###":LOCATE CSRLIN-1:PRINT SPC(7);
470 LOCATE CSRLIN,47:PRINT SPC(7);USING USIN$;Z;
480 RETURN
490 :REM'
500 :REM'.....initial inputs
510 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
520 INPUT " ENTER: LOWEST  operating frequency.............(MHz)";LF
530 Z=LF:GOSUB 450:PRINT " MHz (";
540 PRINT CINT(300/LF*10)/10;"m.)"
550 INPUT " ENTER: HIGHEST operating frequency.............(MHz)";HF
560 Z=HF:GOSUB 450:PRINT " MHz (";
570 PRINT CINT(300/HF*10)/10;"m.)"
580 PRINT UL$;
590 :REM'
600 T=18
610 PRINT TAB(T);"Z  -     50 Ω coaxial transmission line from rig"
620 PRINT TAB(T);"C1, C2 - Transmatch variable tuning capacitors"
630 PRINT TAB(T);"L1 -     Transmatch variable inductor or tapped coil"
640 PRINT TAB(T);"A1 -     Single wire feedline to antenna"
650 PRINT TAB(T);"A2 -     End-fed single wire horizontal antenna"
660 PRINT UL$;
670 LN=CSRLIN-1
680 GOSUB 2630           :REM'print diagrams
690 :REM'
700 F=HF:N=1:GOSUB 2400  :REM'calculate values at highest frequency
710 F=LF:N=2:GOSUB 2400  :REM'calculate values at lowest frequency
720 GOSUB 2520           :REM'print component values
730 GOSUB 3430           :REM'screen dump option
740 :REM'
750 :REM'.....page 2
760 CLS
770 PRINT
780 PRINT TAB(20);"TYPICAL SETTINGS FOR ALL AMATEUR HF BANDS"
790 PRINT TAB(19);STRING$(43,205)
800 PRINT TAB(14);"│    FIG.1";TAB(34);"│    FIG.2";TAB(54);"│    FIG.3"
810 PRINT TAB(14);"│    C1 pF";TAB(26);"L1 µH";TAB(34);"│";
820 PRINT TAB(39);"C1 pF";TAB(46);"L1 µH";TAB(54);"│";
830 PRINT TAB(59);"C1 pF";TAB(66);"C2 pF";TAB(73);"L1 µH"
840 PRINT TAB(14);"│    ─────  ─────";TAB(34);"│";
850 PRINT TAB(39);"─────  ─────";TAB(54);"│";
860 PRINT TAB(59);"─────  ─────  ─────"
870 :REM'
880 :REM'.....calculate component values for each band
890 N=3
900 FOR Y=1 TO 11
910 F=CF(Y,1)
920 GOSUB 2400    :REM'calculate component values
930 GOSUB 2280    :REM'print component values
940 NEXT Y
950 GOSUB 3430
960 :REM'
970 :REM'.....page 3
980 CLS:PRINT
990 MG=7:PRINT TAB(MG);
1000 PRINT"The computer can help you design a multi-band tapped coil for Fig.3."
1010 PRINT TAB(MG);
1020 PRINT "Being a computer, it may locate two or more taps somewhere on the"
1030 PRINT TAB(MG);
1040 PRINT "same turn of the coil. A computer is very accurate, but it can also"
1050 PRINT TAB(MG);
1060 PRINT "be pretty impractical. Wherever it locates taps less than a turn"
1070 PRINT TAB(MG);
1080 PRINT "or two apart, just make a single tap somewhere between them. The"
1090 PRINT TAB(MG);
1100 PRINT "variable capacitors will hardly notice the difference!"
1110 COLOR 15,1:LOCATE 12,8
1120 PRINT " Do you want to design a multi-band tapped coil for Fig.3?  (y/n) "
1130 COLOR 7,0
1140 Z$=INKEY$:IF Z$=""THEN 1140
1150 IF Z$="N"OR Z$="n"THEN 3400
1160 IF Z$="Y"OR Z$="y"THEN 1190
1170 GOTO 1140
1180 :REM'
1190 :REM'.....design coil
1200 CLS
1210 PRINT " Press number in < > to choose standard units of measure:"
1220 PRINT UL$;
1230 PRINT "   < 1 >  Metric"
1240 PRINT "   < 2 >  U.S.A./Imperial"
1250 Z$=INKEY$
1260 IF Z$="1"THEN UM=25.399999618530273!:UM$="mm.":GOTO 1290
1270 IF Z$="2"THEN UM=1:UM$="in.":GOTO 1290
1280 GOTO 1250
1290 PRINT UL$;
1300 :REM'.....input wire size
1310 PRINT " ENTER: Coil Wire Size -";
1320 PRINT " either AWG# (10 to 40) or diameter (";UM$;") ";
1330 INPUT WS
1340 IF WS<10 THEN W=WS/UM :ELSE W=AWG(WS):W$="("+STR$(WS)+" AWG )"
1350 :REM'.....compute coil diameter
1360 CLS
1370 D=0.10000000149011612!                    :REM'initial diameter
1380 L=0.4000000059604645!*D                  :REM'minimum length/diameter ratio
1390 U=CF(1,1)               :REM'minimum inductance
1400 N=SQR(U*(18*D+40*L))/D  :REM'number of turns @ minimum L/D ratio
1410 IF (N*2*W)>L THEN D=D+0.009999999776482582!:GOTO 1380  :REM'where w=wire diameter
1420 OD=(D-W)*UM
1430 PRINT
1440 COLOR 0,7
1450 PRINT " COIL FORM O.D. SHOULD BE AS CLOSE TO";OD;UM$;" AS POSSIBLE."
1460 COLOR 7,0
1470 PRINT
1480 PRINT " Diameters much larger or smaller than this may produce";
1490 PRINT " unpredictable results,"
1500 PRINT " especially at the high and low ends of the HF frequency spectrum."
1510 PRINT
1520 PRINT " ENTER: Coil Form Diameter.........(";UM$;")";:INPUT Z
1530 FD=Z/UM      :REM'diameter of coil form
1540 CLS
1550 PRINT TAB(26);"ALL-BAND TAPPED COIL FOR FIG.3"
1560 PRINT UL$;
1570 U$="#####.###"
1580 PRINT " Coil FORM diameter..................";USING U$;FD*UM;:PRINT " ";UM$
1590 PRINT " Coil WIRE diameter..................";USING U$;W*UM;:PRINT " ";UM$;
1600 PRINT W$
1610 D=FD+W
1620 PRINT " COIL diameter.......................";USING U$;D*UM;:PRINT " ";UM$
1630 LOCATE 11
1640 PRINT UL$;
1650 PRINT "   BAND";TAB(14);"FREQ.";TAB(27);"µH";TAB(33);"TURNS &";
1660 PRINT TAB(41);"DISTANCE FROM INPUT END FOR EACH TAP"
1670 PRINT UL$;
1680 COLOR 0,7
1690 LOCATE CSRLIN-1,21:PRINT " ( L/D = Tap Length-to-Diameter ratio ) "
1700 COLOR 7,0
1710 :REM'
1720 J=12        :REM'set counter
1730 N=0         :REM'set number of turns to 0
1740 FLAG=0      :REM'set FLAG
1750 GOSUB 2130:PRINT "» BAND EDGE » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1760 IF LG/D<0.4000000059604645! THEN FLAG=1
1770 GOSUB 2130:PRINT "─┐  »   »   » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1780 GOSUB 2130:PRINT " ┤  »   »   » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1790 GOSUB 2130:PRINT " ┤  »   »   » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1800 GOSUB 2130:PRINT " ┤  »   »   » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1810 GOSUB 2130:PRINT " TAPS   »   » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1820 GOSUB 2130:PRINT " ┤  »   »   » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1830 GOSUB 2130:PRINT " ┤  »   »   » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1840 GOSUB 2130:PRINT " ┤  »   »   » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1850 GOSUB 2130:PRINT "─┘  »   »   » (L/D =";USING"##.##";LG/D;:PRINT ":1)"
1860 GOSUB 2130:PRINT "» BAND EDGE » (L/D =";USING"##.##";LG/D;:PRINT ":1)";
1870 J=0
1880 NN=INT(N)+1          :REM'number of turns
1890 LG=NN*2*W*UM         :REM'length of coil
1900 AMT=INT(PI*D*NN)+1   :REM'amount of wire
1910 TU=D^2*NN^2/(18*D+40*LG)*UM
1920 LOCATE 5
1930 PRINT " Number of turns.....................";USING "#####";NN
1940 PRINT " Turn spacing........................";USING "#####.###";2*W*UM;
1950 PRINT " ";UM$;" c.c. (2 x wire diameter)"
1960 PRINT " Coil length.........................";USING "#####.##";LG;
1970 PRINT " ";UM$
1980 PRINT " Inductance of entire coil...........";USING "#####.##";TU;
1990 PRINT " µH"
2000 PRINT " Amount of wire required.............";USING "#####";AMT*UM;
2010 PRINT " ";UM$;" plus end leads (if any)"
2020 COLOR 15,4
2030 IF FLAG<>1 THEN 2080
2040 LOCATE 16,52:PRINT " Length/Diameter ratio (L/D) "
2050 LOCATE 17,52:PRINT " must not be less than 0.4:1 "
2060 LOCATE 21,52:PRINT " Run program again and select"
2070 LOCATE 22,52:PRINT " a smaller coil form diameter"
2080 COLOR 7,0:GOTO 3380    :REM'end
2090 END
2100 :REM'
2110 PRINT :REM'************ sub-routines ************
2120 :REM'
2130 :REM'.....calculate coil taps
2140 J=J-1
2150 U=CF(J,2)        :REM'required inductance at tap
2160 IF N=0 THEN N=1  :REM'initial number of turns
2170 L=N*2*W
2180 UH=(D^2*N^2)/(18*D+40*L)
2190 IF UH<U THEN N=N+0.10000000149011612!:GOTO 2170
2200 PRINT USING "####.#";300/CF(J,1);:PRINT " m.";
2210 PRINT USING "####.###";CF(J,1);:PRINT " MHz.";
2220 PRINT USING "####.#";U;:PRINT " µH";
2230 PRINT USING "####.#";N;
2240 LG=N*W*2
2250 PRINT USING "#####.##";LG*UM;:PRINT " ";UM$;
2260 RETURN
2270 :REM'
2280 :REM'.....print component values for each band
2290 PRINT USING "###.###";F;:PRINT " MHz  │  ";
2300 PRINT USING "#######";C1A(N);
2310 PRINT USING "#####.#";L1A(N);
2320 PRINT TAB(31);"   │";
2330 PRINT TAB(37);USING "#######";C1B(N);
2340 PRINT USING "#####.#";L1B(N);
2350 PRINT TAB(54);"│";
2360 PRINT TAB(57);USING "#######";C1C(N);C2C(N);
2370 PRINT USING "#####.#";L1C(N)
2380 RETURN
2390 :REM'
2400 :REM'.....calculate
2410 C1A=1/(2*PI*F*225)*10^6: C1A(N)=INT(C1A)
2420 L1A=480/(2*PI*F):        L1A(N)=INT(L1A*10)/10
2430 :REM'
2440 C1B=1/(2*PI*F*480)*10^6: C1B(N)=INT(C1B)
2450 L1B=480/(2*PI*F):        L1B(N)=INT(L1B*10)/10
2460 :REM'
2470 C1C=1/(2*PI*F*225)*10^6: C1C(N)=INT(C1C)
2480 C2C=1/(2*PI*F*300)*10^6: C2C(N)=INT(C2C)
2490 L1C=400/(2*PI*F):        L1C(N)=INT(L1C*10)/10:CF(Y,2)=L1C
2500 RETURN
2510 :REM'
2520 :REM'.....print component values
2530 B=27:C=54
2540 PRINT        " C1 =";C1A(1);"-";C1A(2);"pF";
2550 PRINT TAB(B);"│  C1 =";C1B(1);"-";C1B(2);"pF";
2560 PRINT TAB(C);"│  C1 =";C1C(1);"-";C1C(2);"pF"
2570 PRINT TAB(B);"│";TAB(C);"│  C2 =";C2C(1);"-";C2C(2);"pF"
2580 PRINT        " L1 =";L1A(1);"-";L1A(2);"µH";
2590 PRINT TAB(B);"│  L1 =";L1B(1);"-";L1B(2);"µH";
2600 PRINT TAB(C);"│  L1 =";L1C(1);"-";L1C(2);"µH";
2610 RETURN
2620 :REM'
2630 :REM'.....diagrams
2640 LOCATE LN,27:PRINT "╤":LOCATE LN,54:PRINT "╤"
2650 CO=1
2660 LOCATE LN+ 1,CO:PRINT " A1+A2= ¼ wavelength or "
2670 LOCATE LN+ 2,CO:PRINT "        odd multiple    "
2680 COLOR 0,7
2690 LOCATE LN+ 3,CO:PRINT " FIG.1                    "
2700 LOCATE LN+ 4,CO:PRINT "            ∞┬───A2────∞  "
2710 LOCATE LN+ 5,CO:PRINT "        L1   A1           "
2720 LOCATE LN+ 6,CO:PRINT " Z┌─┬──┬∩∩∩──┘«- Low-Z    "
2730 LOCATE LN+ 7,CO:PRINT "═╤╝ │  └─┘                "
2740 LOCATE LN+ 8,CO:PRINT " │ ═╪═ C1                 "
2750 LOCATE LN+ 9,CO:PRINT " └──┴\\earth ground       "
2760 COLOR 7,0
2770 :REM'
2780 CO=27
2790 LOCATE LN+ 1,CO:PRINT "│ A1+A2= ½ wavelength or  "
2800 LOCATE LN+ 2,CO:PRINT "│        multiple         "
2810 COLOR 0,7
2820 LOCATE LN+ 3,CO:PRINT "│ FIG.2                    "
2830 LOCATE LN+ 4,CO:PRINT "│             ∞┬───A2────∞ "
2840 LOCATE LN+ 5,CO:PRINT "│       L1     A1          "
2850 LOCATE LN+ 6,CO:PRINT "│ Z┌───┬∩∩∩────┤«─ Hi-Z    "
2860 LOCATE LN+ 7,CO:PRINT "│═╤╝   └─┘     │           "
2870 LOCATE LN+ 8,CO:PRINT "│ │           ═╪═ C1       "
2880 LOCATE LN+ 9,CO:PRINT "│ └───\\earth\\┴\\ground   "
2890 COLOR 7,0
2900 LOCATE LN+10,CO:PRINT "│                          "
2910 :REM'
2920 CO=54
2930 LOCATE LN+ 1,CO:PRINT "│ A1+A2= any random length"
2940 LOCATE LN+ 2,CO:PRINT "│                         "
2950 COLOR 0,7
2960 LOCATE LN+ 3,CO:PRINT "│ FIG.3                    ";
2970 LOCATE LN+ 4,CO:PRINT "│             ∞┬───A2────∞ ";
2980 LOCATE LN+ 5,CO:PRINT "│    C1    C2  A1          ";
2990 LOCATE LN+ 6,CO:PRINT "│ Z┌──╫──┬──╫──┘«- Z       ";
3000 LOCATE LN+ 7,CO:PRINT "│═╤╝ ┌∩∩∩┘      unknown    ";
3010 LOCATE LN+ 8,CO:PRINT "│ │  ├─┘L1                 ";
3020 LOCATE LN+ 9,CO:PRINT "│ └\\┴\\earth ground       ";
3030 COLOR 7,0
3040 LOCATE LN+10,CO:PRINT "│                         "
3050 RETURN
3060 :REM'
3070 :REM'.....foreword
3080 T=8
3090 PRINT TAB(T);
3100 PRINT "The program designs a complete system including a Transmatch and"
3110 PRINT TAB(T);
3120 PRINT "calculates component values for three configurations:"
3130 PRINT
3140 PRINT TAB(T);
3150 PRINT "FIG.1 and FIG.2 are best for monoband antennas, requiring only one"
3160 PRINT TAB(T);
3170 PRINT "inductor (which may not need to be variable or tapped for the"
3180 PRINT TAB(T);
3190 PRINT "higher frequency bands) and one variable tuning capacitor. FIG.3 is"
3200 PRINT TAB(T);
3210 PRINT "a random-wire multi-band antenna which requires one variable or"
3220 PRINT TAB(T);
3230 PRINT "tapped inductor and two variable tuning capacitors."
3240 PRINT
3250 PRINT TAB(T);
3260 PRINT "The wire can be any length within the parameters shown from a short"
3270 PRINT TAB(T);
3280 PRINT "whip to a true long wire, however, due to the variable conditions"
3290 PRINT TAB(T);
3300 PRINT "noted above, the Transmatch control settings calculated by this"
3310 PRINT TAB(T);
3320 PRINT "program should be considered as approximate only."
3330 PRINT
3340 PRINT TAB(T);
3350 PRINT "(Ref. ARRL Electronics Data Book, 2nd Edition, page 7-2)";
3360 RETURN
3370 :REM'
3380 :REM'.....end
3390 GOSUB 3430
3400 GOTO 210   :REM'start
3410 END
3420 :REM'
3430 :REM'PRT
3440 KEY OFF:GOSUB 3510:LOCATE 25,5:COLOR 0,2
3450 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3460 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3470 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3470 :ELSE GOSUB 3510
3480 IF Z$="3"THEN RETURN
3490 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3500 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3440
3510 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
