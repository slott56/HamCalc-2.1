10 :REM'YAGTAPER - Yagi Tapered Elements - 24 OCT 96 rev. 28 NOV 97
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$
40 CLS:KEY OFF
50 COLOR 15,2,0
60 PRINT " YAGI TAPERED ELEMENTS";TAB(57)"by George Murphy VE3ERP ";
70 COLOR 1,0:PRINT STRING$(80,223);
80 COLOR 7,0
90 :REM'
100 :REM'...Reserve arrays
110 MAXPARTS=9
120 DIM PARTD(MAXPARTS), PARTL(MAXPARTS), LP(MAXPARTS), F(MAXPARTS)
130 DIM M(MAXPARTS), THETA(MAXPARTS+1)
140 :REM'
150 :REM'...Define functions for differential reactance, DELTAX, and
160 :REM'   total reactance, X.  Coefficients are changed to use natural
170 :REM'   logarithm instead of base-10 logarithm.  CAPK (CAPital K) is
180 :REM'   the ratio of wavelength to radius.
190 DEF FNDELTAX (CAPK)=-18.700000762939453!*LOG(CAPK)+33.900001525878906!
200 DEF FNX (CAPK)=33.25!+1.3849999904632568!*LOG(CAPK)-0.06599999964237213!*LOG(CAPK)^2
210 :REM'
220 :REM'...Constants
230 C=11802.849609375!          :REM'Speed of light in inches/microsecond
240 X$=STRING$(80,32)   :REM'blank line
250 PIO2=2*ATN(1)       :REM'π/2
260 U$="####.###"
270 U1$="###.## "
280 U2$="##.### "
290 U3$="####.##"
300 :REM'
310 :REM'...start
320 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
330 ROW=3:COL=2:NUM=7:GOSUB 2170   :REM'print diagram
340 PRINT STRING$(80,205);
350 GOSUB 2460  :REM'preface
360 PRINT STRING$(80,205);
370 PRINT " Press number in < > to:"
380 PRINT STRING$(80,205);
390 PRINT "   < 1 > Run program"
400 PRINT "   < 2 > Run Telescoping Aluminum Tube program"
410 PRINT "   < 0 > EXIT";
420 Z$=INKEY$:IF Z$=""THEN 420
430 IF Z$="0"THEN CLS:RUN EX$
440 IF Z$="1"THEN VIEW PRINT 9 TO 24:CLS:VIEW PRINT:LOCATE 9:GOTO 480
450 IF Z$="2"THEN CLS:CHAIN"teletube"
460 GOTO 420
470 :REM'
480 :REM'...Get design data and element tubing dimensions
490 INPUT " ENTER: Frequency in MHz (7-54 Mhz)........."; FREQ
500 IF FREQ<7 OR FREQ>54 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 490
510 LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1
520 COLOR 15,1
530 PRINT " Frequency =";USING U$;FREQ;:PRINT " MHz. (";USING "###.#";300/FREQ;
540 PRINT "m. )....";TAB(41);
550 PRINT "1/2 wavelength in free space =";USING U$;3597.509033203125!/0.30480000376701355!/FREQ/2;
560 PRINT CHR$(34);" ";
570 COLOR 7,0
580 LN=CSRLIN
590 PRINT " Do you want (l)ight, (m)edium, or (h)eavy duty construction?";
600 PRINT "   (l/m/h) "
610 Z$=INKEY$:IF Z$=""THEN 610
620 IF Z$="l"THEN DIAZ=0.375!:C$="Light ":GOTO 660
630 IF Z$="m"THEN DIAZ=0.625!:C$="Medium ":GOTO 660
640 IF Z$="h"THEN DIAZ=0.875!:C$="Heavy ":GOTO 660
650 GOTO 610
660 LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1,2
670 PRINT C$;"duty construction selected. Smallest section is";
680 PRINT USING "##.###";DIAZ+0.125!;:PRINT CHR$(34);" in diameter."
690 INPUT " ENTER: Diameter (inches) of one-piece element to be tapered";IDOL
700 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
710 PRINT SPC(5);
720 PRINT "║   LG   ║   A   ║  A/2  │   B   │   C   │   D   │   E   │   F   │";
730 PRINT "   G   │"
740 :REM'
750 SKIP=1        :REM'skip diameter display after first element
760 GOSUB 2110    :REM'input length
770 DOL=0.30480000376701355!*FREQ/3597.509033203125!*IDOL    :REM'diameter in wavelengths
780 :REM'
790 :REM'...compute section lengths and diameters
800 L=INCH/2   :REM'halflength
810 N=INT(L/66)-1
820 R=(L-N*66)
830 IF R<72 THEN CNTR=R/2:TIP=CNTR:GOTO 860
840 IF R>102 THEN N=N+1:GOTO 820
850 CNTR=36     :REM'1/2 centre section
860 TIP=R-CNTR  :REM'end section
870 :REM'...section length
880 FOR I=1 TO N+2
890  IF I=1 THEN PARTL(I)=CNTR:GOTO 920
900  IF I=N+2 THEN PARTL(I)=0:GOTO 920
910  PARTL(I)=66
920 NEXT I
930 :REM'...section diameter
940 Z=DIAZ         :REM'diameter data base
950 FOR I=N+2 TO 1 STEP-1
960  Z=Z+0.125!
970  PARTD(I)=Z
980 NEXT I
990 NPARTS=N+2
1000 LN2=CSRLIN
1010  FOR Z=NPARTS*8+27 TO 79  :REM'ERASE UNUSED COLUMNS
1020  LOCATE LN,Z:PRINT " ";
1030  NEXT Z
1040 VIEW PRINT 3 TO 8:CLS:VIEW PRINT
1050 ROW=3:COL=2:NUM=NPARTS
1060 GOSUB 2170   :REM'print diagrams
1070 COLOR 0,7:LOCATE 4,2:PRINT NUM*2-1;"piece"
1080 LOCATE ,3:PRINT C$
1090 LOCATE ,3:PRINT "Duty"
1100 LOCATE ,3:PRINT "Element":COLOR 7,0
1110 LOCATE LN2
1120 LAMBDA=C/FREQ
1130 :REM'
1140 :REM'...Alter halflength to scale from design diameter to the
1150 :REM'   geometric average of the root and end piece diameters
1160 AVGDIA=SQR(PARTD(1)*PARTD(NPARTS))
1170 ADOL=AVGDIA/LAMBDA
1180 CAPK=2/DOL
1190 ACAPK=2/ADOL
1200 SML=2*HOL
1210 ASML=(FNX(ACAPK)-FNX(CAPK)-20*FNDELTAX(CAPK)*(0.5!-SML))/(20*FNDELTAX(ACAPK))
1220 ASML=0.5!+ASML
1230 HAOL=ASML/2
1240 HA=HAOL*LAMBDA
1250 :REM'
1260 :REM'...Set up Lawson's M functions for each piece
1270 FOR I=1 TO NPARTS
1280     PDIA=PARTD(I)/LAMBDA
1290     CAPI=2/PDIA
1300     M(I)=FNDELTAX(CAPI)/FNDELTAX(ACAPK)
1310     NEXT I
1320 :REM'
1330 :REM'...Set up initial guess for the length of the end part
1340 PARTL(NPARTS)=HA
1350 FOR I=1 TO NPARTS-1
1360     PARTL(NPARTS)=PARTL(NPARTS)-PARTL(I)
1370     NEXT I
1380 THETA(NPARTS+1)=PIO2
1390 :REM'
1400 :REM'...Compute the cylindrical element which is equivalent to the
1410 :REM'   assumed tapered element, adjust the end piece length proportionally
1420 :REM'   to the error between the computed cylinder length and target length
1430 :REM'   (HA), iterate until the error is small
1440 DELTA=1
1450 WHILE+ ABS(DELTA)>9.999999747378752e-06!*HA
1460   :REM'Find the total half-length of the tapered element.
1470  S=0
1480  FOR I=1 TO NPARTS
1490   S=S+PARTL(I)
1500   THETA(I)=0
1510  NEXT I
1520  SRAD=S/PIO2
1530   :REM'Compute the positions of the joints in radians
1540  FOR I=2 TO NPARTS
1550   THETA(I)=THETA(I-1)+PARTL(I-1)/SRAD
1560  NEXT I
1570   :REM'Evaluate Lawson's F function and determine the
1580   :REM'equivalent length of each piece
1590  FOR I=1 TO NPARTS
1600   F(I)=(SIN(2*THETA(I+1))-SIN(2*THETA(I)))/(2*(THETA(I+1)-THETA(I)))
1610   LP(I)=PARTL(I)*(M(I)+1/M(I)+(M(I)-1/M(I))*F(I))/2
1620  NEXT I
1630   :REM'Find the error between the sum of the equivalent
1640   :REM'piece lengths and the target length
1650  DELTA=HA
1660  FOR I=1 TO NPARTS
1670   DELTA=DELTA-LP(I)
1680  NEXT I
1690   :REM'Add the error to the end piece and loop back
1700  PARTL(NPARTS)=PARTL(NPARTS)+M(NPARTS)*DELTA
1710 WEND
1720 :REM'
1730 :REM'...Show the results, then go back to do another case with the same
1740 :REM'   design parameters except halflength, and the same tubing schedule
1750 :REM'
1760 IF SKIP=1 THEN GOSUB 1950:SKIP=0   :REM'print diameters
1770 GOSUB 2030  :REM'print reference element
1780 PRINT " Lgth=";USING"####.## ║";S;:PRINT USING U1$;PARTL(1)*2;:PRINT "║";
1790 FOR I=1 TO NPARTS
1800 IF I=NPARTS THEN COLOR 15,1
1810 PRINT USING U1$;PARTL(I);:COLOR 7,0:PRINT "│";
1820 COLOR 7,0
1830 NEXT I:PRINT ""
1840 SKIP=0
1850 :REM'
1860 PRINT " Convert another element ?  (y/n)"
1870 Z$=INKEY$:IF Z$=""THEN 1870
1880 IF Z$="n"OR Z$="y"THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1
1890 IF Z$="n"THEN 1920
1900 IF Z$="y"THEN GOSUB 2120:GOTO 1130
1910 GOTO 1870
1920 GOSUB 2680:GOTO 310
1930 END
1940 :REM'
1950 :REM'...print diameters
1960 PRINT " Dia.= varies ║";USING U2$;PARTD(1);:PRINT "║";
1970 FOR I=1 TO NPARTS
1980 PRINT USING U2$;PARTD(I);:PRINT "│";
1990 NEXT I:PRINT ""
2000 SKIP=0
2010 RETURN
2020 :REM'
2030 :REM'...print ref. element specs.
2040 COLOR 0,7:LOCATE CSRLIN,2
2050 PRINT USING"##.###";IDOL;:PRINT CHR$(34);" diameter one-piece element";
2060 PRINT USING U3$;INCH;:PRINT CHR$(34);" long (halflength";USING U3$;INCH/2;
2070 PRINT CHR$(34);") becomes: "
2080 COLOR 7,0
2090 RETURN
2100 :REM'
2110 :REM'...input length
2120 INPUT " ENTER: End-to-end full length of one-piece element (inches) ";INCH
2130 LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1
2140 HOL=0.30480000376701355!*FREQ/3597.509033203125!*INCH/2   :REM'halflength in wavelengths
2150 RETURN
2160 :REM'
2170 :REM'...diagrams
2180 LOCATE ROW
2190 COLOR 15,7
2200 LOCATE ,COL:PRINT "      ALL DIMENSIONS IN INCHES        "
2210 COLOR 0,7
2220 LOCATE ,COL:PRINT "                     │«──────── LG ─»│"
2230 LOCATE ,COL:PRINT "             │«───── A ─────»│       │"
2240 LOCATE ,COL:PRINT "          ≈──┬───────┼───────┬───────┐"
2250 LOCATE ,COL:PRINT "          ≈──┴───────┬───────┴───────┘"
2260 LOCATE ,COL:PRINT "     element centre──┘«─A/2─»│«─ B ─»│"
2270 COLOR 7,0
2280 COL=COL+28
2290 FOR Z=3 TO NUM:COL=COL+8
2300 A$=" "+CHR$(Z+64)+" "
2310 GOSUB 2350
2320 NEXT Z
2330 RETURN
2340 :REM'
2350 COLOR 0,7
2360 LOCATE ROW
2370 LOCATE ,COL:PRINT "          "
2380 LOCATE ,COL:PRINT "────────»│"
2390 LOCATE ,COL:PRINT "         │"
2400 LOCATE ,COL:PRINT "─┬───────┐"
2410 LOCATE ,COL:PRINT "─┴───────┘"
2420 LOCATE ,COL:PRINT "»│«─";A$;"─»│"
2430 COLOR 7,0
2440 RETURN
2450 :REM'
2460 :REM'...preface
2470 TB=8
2480 PRINT TAB(TB);
2490 PRINT "This program converts cylindrical elements to equivalent tapered"
2500 PRINT TAB(TB);
2510 PRINT "elements by computing the length of the end pieces using Lawson's"
2520 PRINT TAB(TB);
2530 PRINT "method (Yagi Antenna Design). The program is based on TAPER.BAS by"
2540 PRINT TAB(TB);
2550 PRINT "Bill Myers, K1GQ, as published in The ARRL ANTENNA BOOK, 17th"
2560 PRINT TAB(TB);
2570 PRINT "edition, pp. 2-29 to 2-31. The diagram above shows one-half of a"
2580 PRINT TAB(TB);
2590 PRINT "typical element."
2600 PRINT
2610 PRINT TAB(TB);
2620 PRINT "Calculations are for .058";CHR$(34);" wall aluminum tube sections";
2630 PRINT " with a "
2640 PRINT TAB(TB);
2650 PRINT "maximum length of 72 inches (one-half standard 12 foot length)."
2660 RETURN
2670 :REM'
2680 :REM'.....PRT
2690 KEY OFF:GOSUB 2760:LOCATE 25,5:COLOR 0,2
2700 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2710 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2720 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2720 :ELSE GOSUB 2760
2730 IF Z$="3"THEN RETURN
2740 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2750 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2690
2760 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
