10 :REM'CAPVAL - 27 APR 09
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " CAPACITOR MEASURER"TAB(61)"by R.J.Dehoney IEEE "
90 COLOR 7,0:GOSUB 180
100 :REM'-------------------CAPMEAS.BAS, RJD, 4/12/9--------------------
110 PRINT
120 PRINT "This is a simple electrolytic capacitor measuring circuit that can"
130 PRINT "can be built in a few hours."
140 PRINT :PRINT  " .....press 1 to continue or 0 to exit....."
150 Z$=INKEY$:IF Z$=""THEN 150
160 IF Z$="0"THEN RUN GO$
170 IF Z$="1"THEN CLS:PRINT::GOSUB 180:GOTO 310:GOTO 160
180 :REM'......diagram
190 PRINT "                                      ELECROLYTIC CAPCITOR MEASURER (Fig.1)          S1      T1   D1 R1 S2 R2     R3              C1"
200 PRINT "    ─\─────)║(───>├─────┬─────┬─10 kΩ─────────────┬──────┐"
210 PRINT "    on/off )║(        ┌─\─┐   └─────────»+        │      │"
220 PRINT "           )║(6.3v  50Ω  500Ω test leads Cx     100 µF   │"
230 PRINT "    120v   )║(        └┐ ┌┘   ┌─────────»-        │     -│ digital"
240 PRINT "    60 Hz  )║(─────────┴┬┴───┬┴─────────┬─────────┤     DC volt"
250 PRINT "           )║(          │    │          │         │     +│ meter"
260 PRINT "           )║(6.3v   500 Ω  10 µF     100 µF    56 kΩ    │"
270 PRINT "           )║(          │    │          │         │      │"
280 PRINT "    ───────)║(───>├─────┴────┴──10 kΩ───┴ 0-20 kΩ─┴──────┘"
290 PRINT "                 D2    R6   C2   R4    C3   R5   R7 (R5 is variable)"
300 RETURN
310 :REM' ......text
320 PRINT
330 PRINT "T1 is a 12.6 volt center tapped 1 amp transformer. Diodes D1 and D2 are"
340 PRINT "1N4002's. R1 & R2 are 50 & 500 ohms. Cx is the unknown capacitor. The theory"
350 PRINT "of operation takes advantage of the fact that in a half wave rectifier, the"
360 PRINT "average DC output is a fairly linear function of Cx over a 30:1 range of"
370 PRINT "values. At the low end, the output is simply the average of a half wave"
380 PRINT "rectified sine wave. At the high end, it nears the peak of the AC waveform."
390 PRINT "The circuitry associated with D2 and the 20k variable generate a DC voltage"
400 PRINT "a bit higher than a rectified half wave allowing R5 to zero the DVM at Cx=0."
410 GOSUB 680:CLS:GOTO 420
420 :REM'.....typical data
430 PRINT
440 PRINT  " ELECTROLYTIC CAPACITORS MEASURER (Fig.2)"
450 PRINT " Typical Data is shown below:"
460 PRINT
470 PRINT "           ┌ volt meter readings ┐"
480 PRINT "   C uF   R1(50 Ω)«─»R2(500 Ω)«──(switchable)"
490 PRINT " 2200      4.88-4.92     -----"
500 PRINT " 1000      4.59-4.63     -----"
510 PRINT "  470      3.86-4.11     -----"
520 PRINT "  330      3.28-3.69     -----"
530 PRINT "  220      2.67-2.84"
540 PRINT "  100      1.37-1.47    4.73-4.8    To find value of unknown capacitor Cx:"
550 PRINT "   47      .515-.557    3.81-3.98   1. With no Cx zero meter with R5"
560 PRINT "   33      .315-.437    2.95-4.05   2. Connect test leads to Cx"
570 PRINT "   22      .156-.165    2.70-2.84   3. Note meter reading with R1"
580 PRINT "   10        -----      1.31-1.35   4. Note meter reading with R2"
590 PRINT "    4.7      -----      .478-.571   5. Value of Cx is the one nearest"
600 PRINT "    3.3      -----      .275-.408      the reading(s) in the table─┐"
610 PRINT "    2.2      -----      .123-.148   «──────────────────────────────┘"
620 PRINT "    1.1      -----      .026-.028"
630 PRINT
640 PRINT " The range of values represents the max and min readings from about 10 samples"
650 PRINT " of each value."
660 :REM'.....END
670 GOSUB 680:GOTO 10
680 :REM'.....PRT
690 KEY OFF:GOSUB 760:LOCATE 25,5:COLOR 0,2
700 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
710 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
720 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 720 :ELSE GOSUB 760
730 IF Z$="3"THEN RETURN
740 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
750 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 690
760 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
