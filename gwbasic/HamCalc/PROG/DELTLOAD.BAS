10 :REM'DELTLOAD - Load Resistance Calculator - 10 JUL 01
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 :REM'
70 :REM'.....title page
80 CLS
90 COLOR 15,2
100 PRINT " LOAD RESISTANCE CALCULATOR"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 15,2:LOCATE CSRLIN-1,19
130 PRINT " Algorithm and text by Ralph Dieter, K1RD "
140 COLOR 7,0:PRINT
150 :REM'
160 :REM'.....start
170 COLOR 0,7:T=24
180 LOCATE ,T:PRINT "  ┌───Ro───┬───>>───┬────────┐  "
190 LOCATE ,T:PRINT "  │        │     S1 \     S2 \  ";
200 COLOR 7,0:PRINT " «─ SPST switches or":COLOR 0,7
210 LOCATE ,T:PRINT "  E~   voltmeter    │        │  ";
220 COLOR 7,0:PRINT "    alligator clips":COLOR 0,7
230 LOCATE ,T:PRINT "  │        │       Rhi      Rlo "
240 LOCATE ,T:PRINT "  └────────┴───<<───┴────────┘  "
250 COLOR 7,0
260 PRINT UL$;
270 LN=CSRLIN
280 :REM'
290 :REM'.....text
300 PRINT " Most circuits can be modeled as a generator (E), output resistan";
310 PRINT "ce (Ro), and  "
320 PRINT " output terminals. This program calculates output resistance (Ro)";
330 PRINT " by measuring "
340 PRINT " the output voltage with 2 different load resistors (Rhi and Rlo)";
350 PRINT ", enabling the"
360 PRINT " plotting of changes (Delta) in the output.                      "
370 PRINT
380 PRINT " This method can be used on line drivers, AC or DC circuits, and ";
390 PRINT "one not       "
400 PRINT " usually thought of as a circuit - meter internal resistance. To ";
410 PRINT "protect a     "
420 PRINT " sensitive meter movement from possible damage you may want to ad";
430 PRINT "d a resistor  "
440 PRINT " in series with the meter and deduct its measured (not its colour";
450 PRINT " coded) value "
460 PRINT " from the calculated value of Ro.                                "
470 PRINT UL$
480 COLOR 0,7:LOCATE ,23:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
490 Z$=INKEY$:IF Z$=""THEN 490
500 IF Z$="0"THEN CLS:CHAIN EX$
510 IF Z$="1"THEN 540
520 GOTO 490
530 :REM'
540 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
550 PRINT " Select Rhi to give about 1/2 full scale reading on the voltmeter";
560 PRINT " and Rlo to   "
570 PRINT " read about full scale.                                          "
580 PRINT
590 INPUT " ENTER: Value of Rhi (ohms).................";RHI
600 INPUT " ENTER: Value of Rlo (ohms).................";RLO
610 PRINT
620 PRINT " Close S1 and open S2: Measure voltage across Rh1"
630 PRINT
640 INPUT " ENTER: Voltage Vhi across Rhi..............";VHI
650 PRINT
660 PRINT " Open S1 and close S2: Measure voltage across Rlo"
670 PRINT
680 INPUT " ENTER: Voltage Vlo across Rlo..............";VLO
690 RO=(RHI*RLO*(VHI-VLO))/(RHI*VLO-RLO*VHI)
700 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
710 :REM'
720 PRINT " As long as source voltage E does not change under load, then:"
730 PRINT
740 PRINT "IF"
750 PRINT USING " Value of Rhi...............= ####,###.### ohms";RHI
760 PRINT USING " Value of Rlo...............= ####,###.### ohms";RLO
770 PRINT USING " Voltage across Rhi only....= ####,###.### volts";VHI
780 PRINT USING " Voltage across Rlo only....= ####,###.### volts";VLO
790 PRINT "THEN"
800 PRINT USING " Output resistance Ro.......= ####,###.### ohms";RO
810 PRINT UL$;
820 :REM'
830 GOSUB 860
840 GOTO 70
850 :REM'
860 KEY OFF:GOSUB 930:LOCATE 25,5:COLOR 0,2
870 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
880 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
890 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 890 :ELSE GOSUB 930
900 IF Z$="3"THEN RETURN
910 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
920 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 860
930 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
