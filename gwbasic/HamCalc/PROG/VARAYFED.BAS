10 :REM'VARAYFED - Vertical Antenna Array Feed - 27 JUN 1998
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 PI=4*ATN(1)  :REM'3.141593
60 UL$=STRING$(80,205)
70 :REM'
80 :REM'.....title page
90 CLS
100 COLOR 15,2
110 PRINT " VERTICAL ANTENNA ARRAY FEED METHOD";
120 PRINT TAB(57);"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 :REM'
160 :REM'.....diagram"
170 COLOR 0,7:T=25
180 LOCATE 3
190 LOCATE ,T:PRINT "           PLAN VIEW           "
200 LOCATE ,T:PRINT "  │«────────── A ──────────»│  "
210 LOCATE ,T:PRINT "  │«───────── 90° ─────────»│  "
220 LOCATE ,T:PRINT "  │«───── ¼ wavelength ────»│  "
230 LOCATE ,T:PRINT "                               "
240 LOCATE ,T:PRINT " [+]«─ Vertical Antennas ─»[+] ───> maximum radiation >"
250 LOCATE ,T:PRINT "  ║«┐                     ┌»║  "
260 LOCATE ,T:PRINT "  ║ │ 84°          161°   │ ║  "
270 LOCATE ,T:PRINT "  ║ └─ B ──»│«───── C ────┘ ║  "
280 LOCATE ,T:PRINT "  ╚═════════╦═══════════════╝  "
290 LOCATE ,T:PRINT "            ║«─ to Transmitter "
300 LOCATE ,T:PRINT "    Transmatch not required    "
310 LOCATE ,T:PRINT "        (══ = 52Ω coax)        "
320 COLOR 7,0
330 PRINT UL$;
340 PRINT TAB(16)"(Ref. ARRL ANTENNA BOOK, 17th Edition, page 4-12)"
350 PRINT TAB(7);
360 PRINT "(Ref. Al Christman KB8I,`Feeding Phased Arrays: An Alternate Method'"
370 PRINT TAB(22);
380 PRINT "HAM RADIO, May 1985, pp 58-59, 61-64)"
390 PRINT
400 COLOR 0,7:LOCATE ,24:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
410 Z$=INKEY$:IF Z$=""THEN 410
420 IF Z$="0"THEN RUN EX$
430 IF Z$="1"THEN 460
440 GOTO 410
450 :REM'
460 VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE 17
470 INPUT " ENTER: Frequency in MHz ..............................";F
480 INPUT " ENTER: Velocity Factor of your 52Ω coax (decimal).....";VF
490 A=300/F/4
500 B=984*VF*84/(F*360)*0.30480000376701355!
510 C=984*VF*161/(F*360)*0.30480000376701355!
520 VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE 17
530 T=21
540 PRINT TAB(T)USING "Frequency       ƒ=###.### MHz";F
550 PRINT TAB(T)USING "Antenna Spacing A=###.## m.=####.## ft.=";A,A/0.30480000376701355!;
560 PRINT " 90°= ¼ wavelength"
570 PRINT TAB(T)USING "Length of coax  B=###.## m.=####.## ft.";B,B/0.30480000376701355!
580 PRINT TAB(T)USING "Length of coax  C=###.## m.=####.## ft.";C,C/0.30480000376701355!
590 :REM'
600 :REM'.....end
610 GOSUB 630:GOTO 80
620 :REM'
630 :REM'.....PRT
640 KEY OFF:GOSUB 710:LOCATE 25,5:COLOR 0,2
650 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
660 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
670 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 670 :ELSE GOSUB 710
680 IF Z$="3"THEN RETURN
690 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
700 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 640
710 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
