10 :REM'IMPEDMET Impedance Meter - 18 NOV 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 R=1/(7/(27000))  :REM'7x 27k resistors in parallel
60 UL$=STRING$(80,205)
70 R$="###,###.# ohms"
80 E$="###,###.# volts"
90 :REM'
100 :REM'.....start
110 CLS
120 COLOR 15,2
130 PRINT " IMPEDANCE METER";TAB(57);"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 7,0
160 :REM'
170 GOSUB 460  :REM'diagram
180 :REM'
190 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 15
200 GOSUB 620
210 PRINT :COLOR 0,7:LOCATE ,24
220 PRINT " Press 1 to continue or 0 to EXIT "
230 COLOR 7,0
240 Z$=INKEY$:IF Z$=""THEN 240
250 IF Z$="0"THEN CLS:RUN EX$
260 IF Z$="1"THEN 290
270 GOTO 240
280 :REM'
290 :REM'.....calculate
300 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 15
310 GOSUB 760
320 PRINT
330 INPUT " ENTER: Voltage across R (switch position A)....";ER
340 INPUT " ENTER: Voltage across Z (switch position B)....";EZ
350 VIEW PRINT 18 TO 24:CLS:VIEW PRINT:LOCATE 18
360 ZX=R*EZ/ER
370 PRINT "        Resistor R .............................";USING R$;R;
380 PRINT ", 3½ watts"
390 PRINT "        Voltage across R (switch position A)....";USING E$;ER
400 PRINT "        Voltage across Z (switch position B)....";USING E$;EZ
410 PRINT "        Approximate impedance of load Z ........";USING R$;ZX
420 GOSUB 900
430 GOTO 190
440 END
450 :REM'
460 :REM'.....diagram
470 COLOR 0,7:C=20
480 LOCATE ,C:PRINT "                                          "
490 LOCATE ,C:PRINT "             on-off sw.      R            "
500 LOCATE ,C:PRINT "             ┌───/ ────┬───/\/\/───┐      "
510 LOCATE ,C:PRINT "           │─┘         │A          │      "
520 LOCATE ,C:PRINT "    117vAC─┤ SPDT sw.> ────«─┤V├─»─┤      "
530 LOCATE ,C:PRINT "           │─┐         │B          │      "
540 LOCATE ,C:PRINT "             └─────────┴──── Z ────┘      "
550 LOCATE ,C:PRINT " ┤V├ - Voltmeter switched to read 150 vAC "
560 LOCATE ,C:PRINT "  R  - 7 parallel 27 kΩ ½W resistors.     "
570 LOCATE ,C:PRINT "  Z  - unknown impedance                  "
580 LOCATE ,C:PRINT "                                          "
590 COLOR 7,0
600 RETURN
610 :REM'
620 :REM'.....intro
630 T=7
640 PRINT TAB(T);
650 PRINT "The approximate impedance of a load Z can be found by comparing the"
660 PRINT TAB(T);
670 PRINT "voltage across it to the voltage across a known resistance R."
680 PRINT TAB(T);
690 PRINT
700 PRINT TAB(T);
710 PRINT "This concept is from the 1949 edition of the ARRL publication"
720 PRINT TAB(T);
730 PRINT "`Hints and Kinks for the Radio Amateur'."
740 RETURN
750 :REM'
760 :REM'.....data entry
770 PRINT TAB(T);
780 PRINT "The load Z must be isolated from ground, and must be able to carry"
790 PRINT TAB(T);
800 PRINT "a voltage of 117vAC, limited to about 30 mA by resistor R."
810 PRINT
820 PRINT TAB(T);
830 PRINT "When measuring transformers, each winding not under test must be"
840 PRINT TAB(T);
850 PRINT "loaded with a resistance equal to the value of the winding, e.g.,"
860 PRINT TAB(T);
870 PRINT "an 8 ohm voice coil winding must be loaded with an 8 ohm resistor."
880 RETURN
890 :REM'
900 :REM'PRT
910 KEY OFF:GOSUB 980:LOCATE 25,5:COLOR 0,2
920 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
930 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
940 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 940 :ELSE GOSUB 980
950 IF Z$="3"THEN RETURN
960 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
970 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 910
980 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
