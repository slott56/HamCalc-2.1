10 :REM'ZENER - Zener Diode Voltage Regulator - 23 MAR 2003
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$
40 CLS:KEY OFF
50 COLOR 7,0,0
60 :REM'
70 :REM'.....start
80 CLS
90 COLOR 15,2
100 PRINT " ZENER DIODE VOLTAGE REGULATOR";
110 PRINT TAB(57);"by George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 7,0
140 GOSUB 560 :REM'diagram
150 LN=CSRLIN
160 PRINT " Press 1 to continue or 0 to EXIT....."
170 Z$=INKEY$:IF Z$=""THEN 170
180 IF Z$="0"THEN CLS:CHAIN EX$
190 IF Z$="1" THEN 210
200 GOTO 170
210 COLOR ,,0:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
220 INPUT " ENTER: Input Supply Voltage.........Vi =";VI
230 IF VI=0 THEN 220
240 INPUT " ENTER: Regulated Voltage............Vo =";VO
250 IF VO=0 THEN  240
260 INPUT " ENTER: Current drawn by load (amps)...I=";I
270 IF I=0 THEN 260
280 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
290 PRINT USING " Vi = ###.## volts";VI
300 PRINT USING " Vo = ###.## volts";VO
310 LN=CSRLIN
320 COLOR 0,7:LOCATE 5,33:PRINT USING "@ #### ma.";I*1000
330 LOCATE 7,17:PRINT USING "###.# volts";VO
340 COLOR 7,0:LOCATE LN
350 PRINT " Without the zener in the circuit R would be";
360 PRINT USING " ###.# ohms";(VI-VO)/I
370 LOCATE 23,33
380 COLOR 15,2:PRINT " Press any key "
390 Z$=INKEY$:IF Z$=""THEN 390
400 COLOR 7,0:VIEW PRINT LN TO 24:CLS:VIEW PRINT:
410 :REM'
420 LOCATE LN
430 PRINT "┌─────── DIODE ───────┐ ┌────── RESISTOR ──────┐"
440 J=I/10
450 FOR Q=1 TO 10
460 K=J*Q
470 R1=(VI-VO)/(I+K)
480 WD=VO*K+VO*I
490 WR=VO*K+R1*I^2
500 WR=(K+I)^2*R1
510 Y$="( #### ma. ###.# watt )│( ###.# ohms ###.# watt)"
520 PRINT USING Y$;K*1000,WD,R1,WR
530 NEXT Q
540 GOTO 690
550 CLS:END
560 :REM'.....diagram
570 COLOR 0,7
580 PRINT "     resistor                               "
590 PRINT "       ┌─┐                                  "
600 PRINT "  Vi───┤R├────┬───────────── Vo             "
610 PRINT "       └─┘   ┌┴┐-                           "
620 PRINT " zener diode │D│                            "
630 PRINT "             └┬┘+                           "
640 PRINT "            /////                           "
650 PRINT "  ref. ARRL 2000 Handbook. p.8-18, Fig.8.29 "
660 COLOR 7,0
670 RETURN
680 :REM'
690 :REM'.....end
700 GOSUB 720:GOTO 10
710 :REM'
720 :REM'.....PRT
730 KEY OFF:GOSUB 800:LOCATE 25,5:COLOR 0,2
740 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
750 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
760 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 760 :ELSE GOSUB 800
770 IF Z$="3"THEN RETURN
780 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
790 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 730
800 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
