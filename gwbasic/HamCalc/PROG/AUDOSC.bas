10 :REM'AUDOSC - Audio Oscillator - 06 JUN 2007
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'
70 :REM'.....title page
80 CLS
90 COLOR 15,2,0
100 PRINT " LM324 AUDIO OSCILLATOR"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 15,2:LOCATE CSRLIN-1,25:PRINT " Algorithm by R.J.Dehoney IEEE "
130 COLOR 7,0
140 GOSUB 610:LN=CSRLIN+1
150 PRINT
160 PRINT " This program analyzes an oscillator that uses a grounded resistor"
170 PRINT " to control its frequency. The frequency is independent of the"
180 PRINT " +/- DC supplies and inversely proportional to Rx. The period is"
190 PRINT " directly proportional to Rx. The period T=1/F=4*Rx*C1*R1/R2."
200 PRINT
210 PRINT " For a tone at a given frequency look for an Rx at that frequency,"
220 PRINT " then find the frequency with an Rx of the nearest standard value."
230 PRINT: COLOR 0,7
240 LOCATE ,20:PRINT " .....Press 1 to continue or 0 to exit..... ":COLOR 7,0
250 Z$=INKEY$:IF Z$=""THEN 250
260 IF Z$="1"THEN 290
270 IF Z$="0"THEN LOAD GO$,R
280 GOTO 250
290 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
300 :REM'.....start
310 COLOR 7,0,0
320 R1=100000.0! :R2=100000.0! : C1=1.0000000116860974e-07!     :REM' (C1 in farads)
330 PRINT  " Want to find (f)requency or R(x)?  (f/x)"
340 Z$=INKEY$
350 IF Z$="f"THEN 380
360 IF Z$="x"THEN 410
370 GOTO 340
380 :REM'.....find frequency
390 INPUT " ENTER: Rx in kΩ";Z:RX=Z*1000
400 F=R2/4/C1/RX/R1:GOTO 440
410 :REM'.....find Rx
420 INPUT " ENTER: Frequency in Hz";F
430 RX=R2/(4*C1*F*R1):GOTO 440
440 :REM'....DISPLAY
450 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
460 DT=0.5!/F:DTM=2*DT*1000
470 PRINT USING " Frequency....... ###,###.# Hz";F
480 PRINT USING " Period.......... ###,###.# msec";DTM
490 PRINT USING " Rx.............. ###,###.# kΩ";RX/1000
500 PRINT " Would you like to hear a";CINT(F);"Hz tone?   (y/n) ":COLOR 7,0
510 Z$=INKEY$:IF Z$=""THEN 510
520 IF Z$="n"THEN 600
530 IF Z$="y"AND F<37 THEN PRINT:GOTO 560
540 IF Z$="y"THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):SOUND F,40:GOTO 600
550 GOTO 510
560 PRINT TAB(10)"Sorry - GWBASIC cannot generate tones lower than 3 Hz!"
570 PRINT TAB(29)".....press any key....."
580 Z$=INKEY$:IF Z$=""THEN 580
590 LOCATE CSRLIN-1:PRINT STRING$(79,32)
600 GOTO 770
610 :REM'.....diagram
620 COLOR 0,7:T=14
630 LOCATE ,T:PRINT "                                                     "
640 LOCATE ,T:PRINT " ┌──────────────────────────────┐  U1--LM 324        "
650 LOCATE ,T:PRINT " │      ┌────C1────┐     V+     │  R1--100K ohm      "
660 LOCATE ,T:PRINT " │      │ ┌─────┐  │      │     │  R2--100K ohm      "
670 LOCATE ,T:PRINT " │ ┌─R1─┴─┤-    │  │   ┌──┴──┐  │  C1--0.1 µF        "
680 LOCATE ,T:PRINT " └─┤      │ U1a ├──┴───┤+    │  │                    "
690 LOCATE ,T:PRINT "   └─R2─┬─┤+    │      │ U1b ├──┴──> Square Wave out "
700 LOCATE ,T:PRINT "        │ └─────┘    ┌─┤-    │                       "
710 LOCATE ,T:PRINT "        Rx           │ └──┬──┘                       "
720 LOCATE ,T:PRINT "        │            │    │                          "
730 LOCATE ,T:PRINT "        ╧            ╧   V-                          "
740 COLOR 7,0
750 RETURN
760 :REM'.....end
770 GOSUB 780:GOTO 70
780 :REM'.....PRT
790 KEY OFF:GOSUB 860:LOCATE 25,5:COLOR 0,2
800 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
810 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
820 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 820 :ELSE GOSUB 860
830 IF Z$="3"THEN RETURN
840 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
850 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 790
860 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
