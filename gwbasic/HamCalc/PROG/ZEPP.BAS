10 :REM'ZEPP - end fed multiband antenna - 02 FEB 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS
80 COLOR 15,2,0
90 PRINT " ZEPP END-FED MULTBAND ANTENNA"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 7,0
120 :REM'.....diagram
130 COLOR 0,7:T=23
140 LOCATE ,T:PRINT "                                  "
150 LOCATE ,T:PRINT "           │<────── A ──────>│    "
160 LOCATE ,T:PRINT " ─ ─ ∞──∞┬∞┬────────────────∞ ─ ─ "
170 LOCATE ,T:PRINT "         ├∞┤                      "
180 LOCATE ,T:PRINT "         ├∞┤<450 Ω or 600 Ω       "
190 LOCATE ,T:PRINT "         ├∞┤ open line B long     "
200 LOCATE ,T:PRINT "        ┌┴─┴┐                     "
210 LOCATE ,T:PRINT "        │1:1│<Balun               "
220 LOCATE ,T:PRINT "        └─▄─┘                     "
230 LOCATE ,T:PRINT "          █<50 Ω Coax, any length "
240 LOCATE ,T:PRINT "    To Transmatch                 "
250 COLOR 7,0
260 PRINT TAB(12)"(ref. ARRL Electromics Data Book, 2nd edition, fig. 7-4)"
270 PRINT
280 GOTO 310
290 :REM'.....erase line
300 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
310 :REM'.....start
320 LN=CSRLIN: PRINT TAB(19)".....Press 1 to continue or 0 to exit....."
330 Z$=INKEY$:IF Z$=""THEN 330
340 IF Z$="0"THEN RUN EX$
350 IF Z$="1"THEN 370
360 GOTO 330
370 :REM'.....start
380 GOSUB 290
390 INPUT " ENTER: Lowest operating frequency in MHz";F
400 GOSUB 290
410 PRINT USING " Lowest operating frequency..= ####.### MHz";F
420 A=468/F
430 PRINT USING " Antenna length.............A= ####.### m.";A*0.30480000376701355!;
440 PRINT USING " (####.## ft.)";A
450 W=299.792458#/F
460 PRINT USING " Wavelength..................= ####.### m. band";W
470 Q=W/2
480 PRINT USING " 1/2 wavelength..............= ####.### m.";Q;
490 PRINT USING " (####.## ft.)";Q/0.30480000376701355!
500 PRINT
510 PRINT USING " Feedline length B may be any multiple of ####.### m.";Q;
520 PRINT USING " (####.## ft.)";Q/0.30480000376701355!
530 LOCATE 3,60:PRINT "Some Dim. B options:"
540 FOR Z=1 TO 6
550 LOCATE (4+Z),62:PRINT USING " ###.## ft.";Z*Q/0.30480000376701355!
560 NEXT Z
570 :REM'.....end
580 GOSUB 590:GOTO 60
590 :REM'.....PRT
600 KEY OFF:GOSUB 670:LOCATE 25,5:COLOR 0,2
610 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
620 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
630 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 630 :ELSE GOSUB 670
640 IF Z$="3"THEN RETURN
650 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
660 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 600
670 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
