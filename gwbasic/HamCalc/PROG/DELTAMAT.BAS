10 :REM'DELTAMAT -Delta MAtch - 22 MAY 1999
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 COLOR 7,0,0
70 :REM'
80 :REM'.....title page
90 CLS
100 COLOR 15,2
110 PRINT " DELTA MATCH"TAB(57)"by George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 0,7
140 T=16
150 LOCATE ,T:PRINT "                                                 "
160 LOCATE ,T:PRINT "                  │«--- A ---»│                  "
170 LOCATE ,T:PRINT "   _ _ _ _ _ _ _ _│_ _ _│_ _ _│_ _ _ _ _ _ _ _   "
180 LOCATE ,T:PRINT "        centre ────\──-»│    /  |  └─ antenna    "
190 LOCATE ,T:PRINT "    Delta section ──»\  │  /    B                "
200 LOCATE ,T:PRINT "                       \ /______|                "
210 LOCATE ,T:PRINT "                       |_|                       "
220 LOCATE ,T:PRINT "                       |_|«─ 600 ohm line        "
230 LOCATE ,T:PRINT "                       | |                       "
240 LOCATE ,T:PRINT "                                                 "
250 COLOR 7,0
260 :REM'
270 LN=CSRLIN
280 PRINT
290 PRINT " The centre impedance of a centre-fed antenna may be too low to be";
300 PRINT " matched     "
310 PRINT " directly by any practicable type of air-insulated parallel-conduc";
320 PRINT "tor line.    "
330 PRINT " However, it is possible to find, between two points, a value of i";
340 PRINT "mpedance that"
350 PRINT " can be matched to such a line when a fanned delta section is used";
360 PRINT " to couple   "
370 PRINT " the line to the antenna (ARRL ANTENNA BOOK, 17th edition pp. 26-1";
380 PRINT "7 and 26-18)."
390 PRINT
400 COLOR 0,7:LOCATE ,22:PRINT " Press 1 to continue or 0 to EXIT....":COLOR 7,0
410 Z$=INKEY$:IF Z$=""THEN 410
420 IF Z$="0"THEN CLS:RUN GO$
430 IF Z$="1"THEN 450
440 GOTO 410
450 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN+1
460 PRINT TAB(9)"ENTER: Frequency of Operation (MHz)......";:INPUT F
470 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN+1
480 WL=300/F
490 IF F>30 THEN KA=0.11500000208616257! :ELSE KA=0.11999999731779099!
500 KB=0.15000000596046448!
510 PRINT TAB(16)USING "Frequency of Operation............. #####.### MHz";F
520 PRINT TAB(16)USING "Wavelength in free space........... #####.### m.";WL
530 A=KA*WL
540 B=KB*WL
550 A$="A=###.### m. (###.### feet)"
560 B$="B=###.### m. (###.### feet)"
570 PRINT TAB(16)USING A$;A,A/0.30480000376701355!
580 PRINT TAB(16)USING B$;B,B/0.30480000376701355!
590 PRINT
600 PRINT " These values are based on the assumption that the centre impedanc";
610 PRINT "e of the     "
620 PRINT " antenna is approximately 70 Ω. The dimensions will require modifi";
630 PRINT "cation if the"
640 PRINT " actual impedance is very much different. Adjustment when proper d";
650 PRINT "imensions are"
660 PRINT " unknown is somewhat awkward, because both A and B must be varied."
670 GOSUB 690:GOTO 80
680 :REM'
690 :REM'PRT
700 KEY OFF:GOSUB 770:LOCATE 25,5:COLOR 0,2
710 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
720 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
730 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 730 :ELSE GOSUB 770
740 IF Z$="3"THEN RETURN
750 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
760 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 700
770 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
