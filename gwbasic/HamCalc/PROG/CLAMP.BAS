10 :REM'CLAMP - Clamping voltage - 02 FEB 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 UL$=STRING$(79,205)
70 :REM'
80 :REM'.....title page
90 CLS
100 COLOR 15,2,0
110 PRINT " CLAMPING VOLTAGE CALCULATOR"TAB(57)"BY George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 7,0
140 :REM'.....start
150 PRINT " The RF power to a transmission line develops a corresponding vol";
160 PRINT "tage that     "
170 PRINT " becomes important when a voltage surge arrester is in the line. ";
180 PRINT " This program "
190 PRINT " calculates the maximum voltage developed for a given power input."
200 PRINT
210 PRINT "  (ref. ARRL Antenna Book, 18th edition, pp.1-14, 1-15)"
220 PRINT UL$
230 LN=CSRLIN:COLOR 0,7
240 PRINT " .....Press 1 to continue or 0 to exit..... ":COLOR 7,0
250 Z$=INKEY$:IF Z$=""THEN 250
260 IF Z$="0"THEN CLS:RUN EX$
270 IF Z$="1"THEN 290
280 GOTO 240
290 VIEW PRINT LN TO 24 :CLS:VIEW PRINT:LOCATE LN
300 INPUT " ENTER: Impedance of coaxial cable transmission line (ohms)...";Z
310 INPUT " ENTER: Peak power (watts)....................................";P
320 INPUT " ENTER: SWR...................................................";S
330 VIEW PRINT LN TO 24 :CLS:VIEW PRINT:LOCATE LN
340 V=SQR(2*P*Z*S)
350 C=3*V
360 PRINT V
370 VIEW PRINT LN TO 24 :CLS:VIEW PRINT:LOCATE LN
380 PRINT USING " Impedance of coaxial line..... ####.# ohms";Z
390 PRINT USING " Peak power.................... ####.# watts";P
400 PRINT USING " SWR........................... ####.#";S;:PRINT ":1"
410 PRINT USING " Maximum developed voltage..... ####.# volts";V
420 PRINT USING " Clamping voltage.............. ####.# volts";C;
430 PRINT " (minimum rating of surge arrester)"
440 PRINT UL$
450 PRINT  " Want to change SWR?   (y/n)"
460 Z$=INKEY$:IF Z$=""THEN 460
470 IF Z$="n"THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):GOTO 500
480 IF Z$="y"THEN 320
490 GOTO 460
500 :REM'....end
510 GOSUB 520:GOTO 80
520 :REM'.....PRT
530 KEY OFF:GOSUB 600:LOCATE 25,5:COLOR 0,2
540 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
550 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
560 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 560 :ELSE GOSUB 600
570 IF Z$="3"THEN RETURN
580 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
590 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 530
600 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
