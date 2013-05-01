10 :REM'CCDANTEN - CCD Antenna - 01 MAR 94 rev. 06 APR 2006
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,0
50 UL$=STRING$(80,205)
60 U1$="######.###"
70 Q$="'"
80 :REM'
90 DIAM(1)=0.03200000151991844!    :REM'wire diameters
100 DIAM(2)=0.040300000458955765!
110 DIAM(3)=0.05079999938607216!
120 DIAM(4)=0.0640999972820282!
130 DIAM(5)=0.08079999685287476!
140 :REM'
150 DIM C(73)      :REM'capacitor standard values
160 DATA 1,2,3,5,7,10,12,15,18,20,22,24,27,30,33,36,39,43,47,50,51,56,62,68
170 DATA 75,82,91,100,110,120,150,160,180,200,220,240,250,270,330,360,390
180 DATA 430,470,500,510,560,620,680,750,820,910,1000,1100,1200,1500,1600,1800
190 DATA 2000,2200,2400,2700,3000,3300,3900,4300,4700,5000,5100,5600,6200
200 DATA 6800,7500,8200
210 FOR Z=0 TO 72:READ C(Z):NEXT Z   :REM'load capacitor values
220 :REM'
230 :REM'.....start
240 CLS
250 COLOR 15,2
260 PRINT " CONTROLLED CURRENT DISTRIBUTION (CCD) ANTENNAS";
270 PRINT TAB(57);"by George Murphy VE3ERP ";
280 COLOR 1,0:PRINT STRING$(80,223);
290 COLOR 7,0
300 GOSUB 1940   :REM'text block
310 COLOR O,7:LOCATE 24,22
320 PRINT " Press 1 to continue or 0 to EXIT.....";
330 COLOR 7,0
340 Z$=INKEY$:IF Z$=""THEN 340
350 IF Z$="0"THEN CLS:RUN EX$
360 IF Z$="1"THEN 380
370 GOTO 340
380 LOCATE CSRLIN-1:PRINT STRING$(80,32);
390 GOSUB 2490   :REM'dump screen option
400 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
410 GOSUB 2400   :REM'disclaimer
420 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
430 :REM'
440 :REM'.....diagram
450 LOCATE 3
460 PRINT " Adapted from a program and article by Stanley Kaplan WB9RQR and ";
470 PRINT "E.Joseph Bauer"
480 PRINT " W9WQ in the ARRL Antenna Compendium, Volume 2, page 132. Refer to ";
490 PRINT "this article"
500 PRINT " for a complete description of this type of antenna."
510 PRINT UL$;
520 COLOR 0,7
530 PRINT"    w   w   w   w     w   w   w   w                  w   w   w   w   "
540 PRINT"  ∞───╫───╫───╫───┬∞┬───╫───╫───╫───∞    │      ──∞┬───╫───╫───╫───∞ "
550 PRINT"      c   c   c   ╪═╪   c   c   c        │w      ╪═╪   c   c   c     "
560 PRINT"                  ╪═╪                   ═╪═ c    ╪═╪                 "
570 PRINT"    Feedline:     ╪═╪         Feedline:  │w      ╪═╪ Feedline:       "
580 PRINT"    Open-wire or  ╪═╪         52Ω coax  ═╪═ c    ╪═╪ Open-wire with  "
590 PRINT"    52Ω coax with ╪═╪         or single  │w      ╪═╪ one wire not    "
600 PRINT"    balun         ╪═╪         wire ─┐   ═╪═ c    ╪═╪ terminated, or  "
610 PRINT"                 ┌┴─┴┐        ┌───┐ ¡    │w     ┌┴─┴┐single wire     "
620 PRINT"                 │ T │        │ T ╞═════╤╝      │ T │                "
630 PRINT"                 └───┘        └───┘     │       └───┘                "
640 PRINT"                DIPOLE       VERTICAL  ///grnd     LONG-WIRE/ZEPP    "
650 COLOR 7,0
660 PRINT UL$;
670 PRINT" w = Identical wire sections";
680 PRINT TAB(32);"NOTES:Use 5% dipped Silver-Mica capacitors."
690 PRINT" c = Identical capacitors";
700 PRINT TAB(38);"The more capacitors, the better !";
710 PRINT" T = Transmatch";
720 PRINT TAB(38);"Design antenna for the low end of the band.";
730 PRINT UL$;
740 GOSUB 2490
750 :REM'
760 :REM'.....start program
770 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
780 :REM'
790 :REM'.....data input
800 PRINT " Press number in < > to select type of antenna:"
810 PRINT UL$;
820 PRINT "  < 1 >  Dipole"
830 PRINT "  < 2 >  Vertical or Long Wire"
840 PRINT UL$;
850 Z$=INKEY$
860 IF Z$="1"THEN TYPE=1:T$="DIPOLE":GOTO 900
870 IF Z$="2"THEN TYPE=2:T$="VERTICAL or LONG WIRE":GOTO 900
880 GOTO 850
890 :REM'
900 PRINT " Press number in < > to choose how you want capacitor ";
910 PRINT "values displayed:"
920 PRINT UL$;
930 PRINT "  < 1 >  Exact calculated values"
940 PRINT "  < 2 >  Nearest standard values"
950 PRINT UL$;
960 Z$=INKEY$
970 IF Z$="1"THEN NEAR=0:PF$="EXACT CALCULATED":GOTO 1010
980 IF Z$="2"THEN NEAR=1:PF$="NEAREST STANDARD":GOTO 1010
990 GOTO 960
1000 :REM'
1010 INPUT " ENTER: Frequency, in MHz, of low end of band ";FREQ
1020 TOTLINCH=300/FREQ*39.369998931884766!
1030 FEETINCH=TOTLINCH:GOSUB 1690
1040 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1050 :REM'
1060 :REM'.....calculate capacitance for each wire size
1070 FOR I=1 TO 5
1080  INDUCT(I)=0.005080000031739473!*TOTLINCH*((LOG(4*TOTLINCH/DIAM(I))-0.75!))
1090  CTOT(I)=2*((1/(((6.283199787139893!*FREQ)^2)*INDUCT(I))*10^6))
1100 NEXT I
1110 :REM'
1120 :REM'.....calculate and display table
1130 PRINT " CCD ";T$;" ANTENNA for";FREQ;"MHz. (wavelength=";
1140 PRINT USING "###.#";300/FREQ;:PRINT " m.)"
1150 PRINT " Overall length =";DIMEN$;"  (";USING "####.##";TOTLINCH/12;
1160 PRINT " ft.)(";USING "#####.##";TOTLINCH;
1170 PRINT CHR$(34);")(";USING "###.###";TOTLINCH*25.399999618530273!/1000.0!;:PRINT " m.)"
1180 PRINT UL$;
1190 PRINT"        ┌── Wire Size/Capacitor value ──┐«─ ";PF$;
1200 PRINT" pF values shown."
1210 PRINT" No. No.│   #12   #14   #16   #18   #20 ╞══════════════════════════";
1220 PRINT "═════════════";
1230 PRINT" of  of │   AWG   AWG   AWG   AWG   AWG │   Centre-to-centre Distance"
1240 PRINT" SEC CAP│    pF    pF    pF    pF    pF │   Between Capacitors"
1250 PRINT UL$;
1260 LOCATE CSRLIN-1,9:PRINT "╪":LOCATE CSRLIN-1,41:PRINT "╪"
1270 LN=10
1280 S=-4
1290 FOR SECTION=50 TO 1 STEP S
1300  FOR I=1 TO 5
1310 IF TYPE=1 THEN NOCAP=SECTION-2
1320 IF TYPE=2 THEN NOCAP=SECTION-1
1330   IF TYPE=1 THEN CAP(I)=CTOT(I)*(SECTION-2)
1340   IF TYPE=2 THEN CAP(I)=CTOT(I)*(SECTION-1)
1350   C=CAP(I)
1360   IF NEAR THEN GOSUB 1610:CAP(I)=Y
1370  NEXT I
1380 N=TOTLINCH/SECTION
1390 PRINT USING "###";SECTION;
1400 PRINT USING "####";NOCAP;
1410 PRINT " │";
1420 FOR Z=5 TO 1 STEP -1
1430 IF CAP(Z)<10 AND NEAR=0 THEN X$="####.#":ELSE X$="######"
1440 IF NOCAP=0 THEN CAP(Z)=0
1450 PRINT USING X$;CAP(Z);
1460 NEXT Z
1470 PRINT " │";
1480 FEETINCH=N:GOSUB 1690
1490 X$=""
1500 IF FT<100 THEN X$=" "
1510 IF FT<10 THEN X$="  "
1520 PRINT X$;DIMEN$;TAB(59);"(";USING "####.##";N;
1530 PRINT CHR$(34);")(";USING"##.###";N*25.399999618530273!/1000.0!;:PRINT " m.)";
1540 LN=LN+1
1550 IF LN<24 THEN PRINT ""
1560 IF LN=24 THEN GOSUB 2490:CLS:LN=0
1570 NEXT SECTION
1580 GOSUB 2490
1590 GOTO 230
1600 :REM'
1610 :REM'.....nearest standard capacitor
1620 FOR Z=1 TO 73
1630 IF C(Z)>C THEN HI=C(Z):LO=C(Z-1):GOTO 1650
1640 NEXT Z
1650 IF (HI-C)<=(C-LO)THEN Y=HI
1660 IF (C-LO)<=(HI-C)THEN Y=LO
1670 RETURN
1680 :REM'
1690 :REM'.....convert to feet and inches
1700 FT=0                         :REM'set feet to zero
1710 IF FEETINCH>12 THEN FT=INT(FEETINCH/12):FEETINCH=FEETINCH-FT*12
1720 IN=INT(FEETINCH)                 :REM'whole inches
1730 FR=FEETINCH-IN                   :REM'decimal part of inch
1740 :REM'.....calculate fraction
1750 D=64                             :REM'denominator base
1760 E=FR*D                           :REM'enumerator
1770 IF E=0 THEN D=0:GOTO 1820
1780 E=CINT(E/2):D=D/2
1790 IF E=0 THEN D=0:GOTO 1820
1800 IF E/2=INT(E/2)THEN 1780
1810 :REM'
1820 IF E=1 AND D=1 THEN IN=IN+1:E=0:D=O
1830 IF IN=12 THEN FT=FT+1:IN=0
1840 IN$=STR$(IN)
1850 FT$=STR$(FT)
1860 E$=STR$(E)
1870 D$=STR$(D):D$=RIGHT$(D$,LEN(D$)-1)
1880 DIMEN$=FT$+"'-"+IN$
1890 IF E=0 THEN 1910
1900 DIMEN$=DIMEN$+E$+"/"+D$
1910 DIMEN$=DIMEN$+CHR$(34)
1920 RETURN
1930 :REM'
1940 :REM'.....text block
1950 TB=7      :REM'tab for text
1960 PRINT TAB(TB);
1970 PRINT "  The Controlled Current Distribution Antenna consists of identical"
1980 PRINT TAB(TB);
1990 PRINT "lengths of wire joined together by identical capacitors. It looks"
2000 PRINT TAB(TB);
2010 PRINT "not unlike a trap antenna except the 'traps' are capacitors and"
2020 PRINT TAB(TB);
2030 PRINT "there are liable to be a lot of them."
2040 PRINT TAB(TB);
2050 PRINT "  Resonance is achieved by the proper combination of the capacitors"
2060 PRINT TAB(TB);
2070 PRINT "and the inductance of the antenna wire itself."
2080 PRINT TAB(TB);
2090 PRINT "  There can be practically any number of capacitors inserted into"
2100 PRINT TAB(TB);
2110 PRINT "the antenna. (This program designs antennas with up to fifty"
2120 PRINT TAB(TB);
2130 PRINT "capacitors). As a general rule, the more capacitors the more"
2140 PRINT TAB(TB);
2150 PRINT "efficient the antenna."
2160 PRINT TAB(TB);
2170 PRINT "  The design procedure is simple. Run the program and select the"
2180 PRINT TAB(TB);
2190 PRINT "'Nearest Standard Value' menu option. Enter the frequency of the"
2200 PRINT TAB(TB);
2210 PRINT "band of operation and the program will display several optional"
2220 PRINT TAB(TB);
2230 PRINT "configurations for the antenna. Match up the value and quantity"
2240 PRINT TAB(TB);
2250 PRINT "of capacitors you have in your junk box (or can find at a flea"
2260 PRINT TAB(TB);
2270 PRINT "market) with one of the options and the design is finished !"
2280 PRINT TAB(TB);
2290 PRINT "  To fit the screen, options are shown in steps of 4 capacitors."
2300 PRINT TAB(TB);
2310 PRINT "For intermediate even numbered steps the capacitor values will be"
2320 PRINT TAB(TB);
2330 PRINT "halfway between the values for the adjacent steps."
2340 PRINT TAB(TB);
2350 PRINT "  The CCD antenna was designed by Harry Mills, W4FD, as described"
2360 PRINT TAB(TB);
2370 PRINT "in the ARRL Antenna Compendium, Vol. 2, pp 132-136."
2380 RETURN
2390 :REM'
2400 :REM'.....preface
2410 OPEN"I",1,"\hamcalc\docfiles\antenna.doc"
2420 IF EOF(1)THEN 2440
2430 INPUT#1,NOTE$:PRINT "   ";NOTE$:GOTO 2420
2440 PRINT :PRINT "   Press any key to continue....."
2450 IF INKEY$=""THEN 2450
2460 CLOSE
2470 RETURN
2480 :REM'
2490 :REM'PRT
2500 KEY OFF:GOSUB 2570:LOCATE 25,5:COLOR 0,2
2510 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2520 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2530 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2530 :ELSE GOSUB 2570
2540 IF Z$="3"THEN RETURN
2550 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2560 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2500
2570 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
