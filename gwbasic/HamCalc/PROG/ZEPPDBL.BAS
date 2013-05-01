10 :REM'ZEPPDBL - Extended Double Zepp Antenna - 18 APR 96 rev. 23 FEB 2000
20 REM - 1994 ARRL HANDBOOK, pages 33-11 to 33-13
30 IF EX$=""THEN EX$="EXIT"
40 CLS:KEY OFF
50 COLOR 7,0,0
60 UL$=STRING$(80,205)
70 U$="####.###"
80 PI=3.1415929794311523!
90 :REM'
100 :REM'.....start
110 CLS
120 COLOR 15,2
130 PRINT " ZEPP EDZ (Extended Double Zepp) ANTENNA";
140 PRINT TAB(57);"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 LOCATE 3:GOSUB 1680   :REM'diagram
180 PRINT UL$;
190 :REM'
200 COLOR 0,7:LOCATE 25,24:PRINT " Press 1 to continue or 0 to EXIT ";
210 COLOR 7,0
220 Z$=INKEY$:IF Z$="" THEN 220
230 IF Z$="0"THEN CLS:RUN EX$
240 IF Z$="1"THEN 270
250 GOTO 220
260 :REM'
270 :REM'.....data input
280 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
290 GOSUB 1860  :REM'text
300 COLOR 0,7:LOCATE 24,11
310 PRINT " Press one of the letters in < > to select a design method ";
320 COLOR 7,0
330 Z$=INKEY$:IF Z$<"a"OR Z$>"b"THEN 330
340 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOSUB 1680:PRINT UL$;
350 IF Z$="a"OR Z$="b"THEN 370 :ELSE 330
360 GOTO 330
370 PRINT " Wire antennas require a length correction factor to allow for end ";
380 PRINT "effect and"
390 PRINT " velocity factor of the wire. A factor of .95 will suffice for most";
400 PRINT " HF antennas.";
410 PRINT
420 PRINT " A factor of 1 will ignore end effects and velocity factors in all ";
430 PRINT "calculations.";
440 PRINT
450 INPUT " ENTER: Length correction factor.....................";K
460 IF K=0 THEN K=1
470 COLOR 0,7
480 LOCATE 10,I+1:PRINT "with Length Correction"
490 LOCATE 11,I+1:PRINT "factor of";USING"##.##";K
500 COLOR 7,0
510 VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE 17
520 IF Z$="a"THEN 530 :ELSE 550
530 INPUT " ENTER: Design frequency of operation...........(MHz)";F:GOTO 650
540 :REM'
550 PRINT " Do you want to enter length in metres or feet?   (m/f)"
560 Z$=INKEY$:IF Z$=""THEN 560
570 IF Z$="m"THEN M=1:M$="metres":GOTO 600
580 IF Z$="f"THEN M=0.30480000376701355!:M$="feet..":GOTO 600
590 GOTO 560
600 LIN=CSRLIN-1:VIEW PRINT LIN TO 24:CLS:VIEW PRINT:LOCATE LIN
610 PRINT " ENTER: Length of each leg in ";M$;".....A=";:INPUT A
620 A=A/K*M     :REM'K=length correction factor
630 F=299.7919921875!*0.6399999856948853!/A:GOTO 650
640 :REM'
650 VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE 17
660 PRINT " Press number in < > to choose type of matching section:"
670 PRINT UL$;
680 PRINT "  < 1 > 450-Ω 1.6 mm (#14 AWG) ";
690 COLOR 15:PRINT "open-wire";:COLOR 7:PRINT " matching section:"
700 PRINT "          B = 34.85 mm (1-3/8";CHR$(34);"), velocity factor = 0.97"
710 PRINT
720 PRINT "  < 2 > 450-Ω U.S.A. 1-in. ";
730 COLOR 15:PRINT "TV-type window line";:COLOR 7:PRINT " matching section:"
740 PRINT "          B = 25.4 mm (1";CHR$(34);"), velocity factor = 0.95"
750 Z$=INKEY$:IF Z$=""THEN 750
760 IF Z$="1"THEN COLOR 0,7:LOCATE 12,45:PRINT "1.6mm (#14 AWG) wire":COLOR 7,0
770 IF Z$="2"THEN COLOR 0,7:LOCATE 12,45:PRINT "TV window-line      ":COLOR 7,0
780 IF Z$="1"THEN V=0.9700000286102295!:B=0.0347524993121624!:V$="#14 open-wire":GOTO 820
790 IF Z$="2"THEN V=0.949999988079071!:B=0.02539999969303608!:   V$="TV window-line":GOTO 820
800 GOTO 750
810 :REM'
820 VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE 17
830 PRINT "        Design frequency of operation............. ƒ=";USING U$;F;
840 PRINT " Mhz (";USING "###";299.7919921875!/F;:PRINT "m.)"
850 :REM'
860 PRINT "        Velocity factor of matching section....... V=";USING U$;V;
870 PRINT " (";V$;")"
880 :REM'
890 A1=299.7919921875!/F*0.6399999856948853!    :REM'leg length in metres = .64 wavelength in free space
900 A=A1*K              :REM'length including velocity factor
910 L=2*A+B             :REM'overall length
920 MAX=468*0.30480000376701355!/(2*A) :REM'approx. freq. of dipole
930 LN=CSRLIN
940 LOCATE 3,3:PRINT " ( A dipole 2 x A long with no matching section ";
950 PRINT "is resonant at";USING "###.##≈ MHz )";MAX
960 LOCATE LN
970 :REM'
980 PRINT "        Over-all length of flat-top................L=";
990 PRINT USING U$;L;:PRINT " m.=";USING U$;L/0.30480000376701355!;:PRINT " ft."
1000 :REM'
1010 PRINT "        Length of each leg.........................A=";
1020 PRINT USING U$;A;:PRINT " m.=";USING U$;A/0.30480000376701355!;:PRINT " ft."
1030 :REM'
1040 Y=B*10^3
1050 PRINT "        Open-Wire conductor spacing................B=";
1060 PRINT USING "####.#";Y;:PRINT " mm. =";:PRINT USING U$;Y/25.399999618530273!;:PRINT " in."
1070 C=299.7919921875!*V*52/(F*360*0.30480000376701355!)   :REM'52=length of matching section in degrees
1080 C=C*0.30480000376701355!   :REM'C in metres
1090 PRINT "        Length of 450 Ω matching section...........C=";
1100 PRINT USING U$;C;:PRINT " m.=";USING U$;C/0.30480000376701355!;:PRINT " ft."
1110 :REM'
1120 COLOR 0,7:LOCATE CSRLIN,18
1130 PRINT " To prune trim C - DO NOT CHANGE DIMENSION A! "
1140 COLOR 15,1:LOCATE ,10
1150 PRINT " Do you want to convert this to a multi-band antenna?  (y/n) ";
1160 COLOR 7,0
1170 Z$=INKEY$:IF Z$=""THEN 1170
1180 IF Z$="n"THEN LOCATE ,1:PRINT STRING$(80,32);:GOTO 1660
1190 IF Z$="y"THEN 1220
1200 GOTO 1170
1210 :REM'
1220 COLOR 7,0:LOCATE 3,1:PRINT STRING$(80,32);:LOCATE 3,12:COLOR 15,4
1230 Y=(299.7919921875!*52)/(360*0.30480000376701355!)
1240 NLF=Y/(2*A/K)     :REM'new low frequency
1250 PRINT " Low Edge frequency should be less than about";
1260 PRINT USING "###.### MHz ";NLF
1270 COLOR 7,0
1280 VIEW PRINT 23 TO 24:CLS:VIEW PRINT:LOCATE 23
1290 INPUT " ENTER: Low edge of lowest band of operation (MHz)";LO:LF=LO-0.10000000149011612!
1300 :REM'
1310 X=Y/LF*K                :REM'Lgth. of flat-top in metres @LF MHz
1320 C2=(X-2*A)*V            :REM'new length of matching section
1330 IF SGN(C2)=-1 THEN FLAG=1
1340 :REM'
1350 LOCATE 1,34:COLOR 15,2:PRINT "MULTIBAND ANTENNA":COLOR 7,0
1360 LOCATE 17
1370 PRINT "        Lowest usable frequency (approximate)..... ƒ=";USING U$;LF;
1380 PRINT " Mhz (";USING "###";300/LO;:PRINT "m.)"
1390 LOCATE 22
1400 PRINT "        Length of 450 Ω matching section...........C=";
1410 IF C2<0 THEN COLOR 0,7 :ELSE COLOR 7,0
1420 PRINT USING U$;C2;:PRINT " m.=";USING U$;C2/0.30480000376701355!;:PRINT " ft."
1430 COLOR 7,0:PRINT STRING$(80,32);
1440 IF FLAG=0 THEN 1580 :ELSE BEEP:FLAG=0:COLOR 0,7:LOCATE CSRLIN-1,9
1450 PRINT " THE LOWEST FREQUENCY YOU CHOSE IS TOO HIGH";
1460 PRINT " FOR THIS ANTENNA LENGTH! "
1470 LOCATE 25,9:PRINT USING " should be less than ###.## MHz.....";LO;
1480 COLOR 15,1
1490 PRINT " Do you want to try another? ";:COLOR 31,1:PRINT " (y/n) ";
1500 COLOR 7,0
1510 Z$=INKEY$:IF Z$=""THEN 1510
1520 IF Z$="n"THEN 2260
1530 IF Z$="y"THEN 1550
1540 GOTO 1510
1550 LOCATE 1,34:COLOR 15,2:PRINT "ANTENNA          "
1560 LOCATE 17:COLOR 7,0:GOTO 820
1570 :REM'
1580 LOCATE 23:COLOR 0,7
1590 PRINT " Do you want to try another low band edge frequency?  (y/n) "
1600 COLOR 7,0
1610 Z$=INKEY$:IF Z$=""THEN 1610
1620 IF Z$="n"THEN COLOR 7,0:LOCATE 3:PRINT STRING$(80,32);
1630 IF Z$="n"THEN VIEW PRINT 23 TO 24:CLS:VIEW PRINT:GOTO 2240
1640 IF Z$="y"THEN 1280
1650 GOTO 1610
1660 COLOR 7,0:GOTO 2240
1670 :REM'
1680 :REM'.....diagram 1
1690 COLOR 0,7:I=12
1700 LOCATE ,I:PRINT "                                                         "
1710 LOCATE ,I:PRINT "         E X T E N D E D   D O U B L E   Z E P P         "
1720 LOCATE ,I:PRINT "     │«──────────────────── L ────────────────────»│     "
1730 LOCATE ,I:PRINT "     │«──────── A ────────»│ │«──────── A ────────»│     "
1740 LOCATE ,I:PRINT "     │                   ─»│ │«─ B                 │     "
1750 LOCATE ,I:PRINT " - - ∞─────────────────────┬∞┬─────────────────────∞ - - "
1760 LOCATE ,I:PRINT " 1.6mm (#14 AWG) wire legs ├∞┤                           "
1770 LOCATE ,I:PRINT "                           ├∞┤<─ 450 Ω open-wire         "
1780 LOCATE ,I:PRINT "                          ┌┴─┴┐  matching section        "
1790 LOCATE ,I:PRINT "                   Balun─»│1:1│  52° long=               "
1800 LOCATE ,I:PRINT "                          └─▄─┘  'C' long                "
1810 LOCATE ,I:PRINT "    50 Ω coax, any length ─>█                            "
1820 LOCATE ,I:PRINT "                      To Transmatch                      "
1830 COLOR 7,0
1840 RETURN
1850 :REM'
1860 :REM'.....design note
1870 TB=7
1880 PRINT TAB(TB);
1890 PRINT "There are two methods for designing an Extended Double Zepp:"
1900 PRINT
1910 PRINT " <a>";TAB(TB)"Design a monoband EDZ for a specific frequency."
1920 PRINT " <b>";TAB(TB)"Design a monoband EDZ to fit a specific space."
1930 PRINT
1940 PRINT TAB(TB);
1950 PRINT "Method <b> may result in a design frequency of little interest."
1960 PRINT TAB(TB);
1970 PRINT "However, by converting this design to a multiband antenna, it may"
1980 PRINT TAB(TB);
1990 PRINT "produce a useful antenna for bands that are of interest."
2000 PRINT
2010 PRINT TAB(TB);
2020 PRINT "Both methods provide an option to convert a monoband EDZ into a"
2030 PRINT TAB(TB);
2040 PRINT "multiband antenna by altering the length of the open-wire matching"
2050 PRINT TAB(TB);
2060 PRINT "section. When asked for the lowest frequency of operation for a"
2070 PRINT TAB(TB);
2080 PRINT "multiband EDZ, enter the frequency of the low edge of the band of"
2090 PRINT TAB(TB);
2100 PRINT "interest. To ensure adequate coverage, program calculation starts"
2110 PRINT TAB(TB);
2120 PRINT "at 100 kHz below that frequncy."
2130 PRINT
2140 PRINT TAB(TB);
2150 PRINT "For example, use <b> to design an EDZ with 0.95 length-correction"
2160 PRINT TAB(TB);
2170 PRINT "factor legs 51 feet long, with open-wire matching section. Convert"
2180 PRINT TAB(TB);
2190 PRINT "this into a multiband antenna with a low edge frequency of 3.331"
2200 PRINT TAB(TB);
2210 PRINT "MHz. The result should look familiar - it is the world-famous G5RV!"
2220 RETURN
2230 :REM'
2240 :REM'.....end
2250 GOSUB 2290
2260 LF=0:GOTO 100
2270 END
2280 :REM'
2290 :REM'.....PRT
2300 KEY OFF:GOSUB 2370:LOCATE 25,5:COLOR 0,2
2310 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2320 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2330 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2330 :ELSE GOSUB 2370
2340 IF Z$="3"THEN RETURN
2350 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2360 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2300
2370 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
