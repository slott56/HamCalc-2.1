10 :REM'WARTEST - Wall Wart Properties - rev. 12 DEC 2005
20 CLS:KEY OFF
30 PROG$="wartest"
40 IF EX$=""THEN EX$="EXIT"
50 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
60 COMMON EX$,PROG$
70 UL$=STRING$(80,205)
80 :REM'.....title page
90 COLOR 15,2,1
100 PRINT " WallWart Properties"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 LN=CSRLIN
140 :REM'.....start
150 PRINT " Wall Warts are those ubiquitous little cubical low voltage DC pow";
160 PRINT "er supplies  "
170 PRINT " that plug into a wall socket to run many of the electronic gadget";
180 PRINT "s on the     "
190 PRINT " market today. Long after the gadget has been discarded or replace";
200 PRINT "d with the   "
210 PRINT " latest model of whatever it was, the Wall Wart that came with it ";
220 PRINT "remains,     "
230 PRINT " simply because it is ";
240 PRINT CHR$(34);"too good to throw away";CHR$(34);". This program suggests";
250 PRINT " some "
260 PRINT " things you can do with them."
270 PRINT
280 PRINT " Usual precautions apply if the device draws current much in exces";
290 PRINT "s of the     "
300 PRINT " current rating marked on the Wall Wart. (e.g., proper cooling, in";
310 PRINT "termittent   "
320 PRINT " light duty only, etc.)."
330 PRINT
340 PRINT " Ref.`Reusing the WallWart',Phil Karras K3FL, QRP Quarterly, July 2";
350 PRINT "000, p.54 "
360 PRINT UL$;
370 PRINT " To test the properties of a substitute WallWart..........Press 1"
380 PRINT " To change the output voltage of a WallWart.............. Press 2"
390 PRINT " To run Wall Wart Ratings program........................ Press 3"
400 PRINT " To Exit................................................. Press 0"
410 Z$=INKEY$:IF Z$=""THEN 410
420 IF Z$="0" THEN RUN EX$
430 IF Z$="1"THEN 460
440 IF Z$="2"THEN 920
450 IF Z$="3"THEN CHAIN "walwart"
460 :REM'.....test
470 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
480 PRINT " To test a substitute WallWart:"
490 PRINT UL$;
500 PRINT " Example: If you need a 9V/300 mA wallwart but only have a 12V/100";
510 PRINT " mH on hand  "
520 PRINT " you can test it by finding a resistor that will provide a 9V/300 ";
530 PRINT "mA output   "
540 PRINT " when connected across the 12V WW's output. If the voltage drops t";
550 PRINT "o within 5% "
560 PRINT " of the desired voltage the substitute will probably be OK."
570 PRINT UL$;
580 LN=CSRLIN
590 INPUT " ENTER: Voltage of on-hand wallwart...";W
600 INPUT " ENTER: Desired output voltage........";E
610 IF E<W THEN 670
620 PRINT
630 BEEP:PRINT " Output voltage must be less than the input voltage!.....Pres";
640 PRINT "s any key....."
650 Z$=INKEY$:IF Z$=""THEN 650
660 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 590
670 INPUT " ENTER: Desired output current (mA)...";I
680 R=E/(I/1000)
690 R=0:N=0
700 M=1  :REM'increment
710 R=R+M:N=N+1
720 V=R*I/1000   :REM'voltage
730 IF V>E THEN 750
740 GOTO 710
750 P=(V/R)^2*R
760 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
770 PRINT USING " Wallwart output voltage. #,###.# volts";W
780 PRINT USING " Desired output voltage.. #,###.# volts";E
790 PRINT USING " Actual output voltage... #,###.# volts";V
800 PRINT USING " Ouput current........... #,###.# mA.";I
810 COLOR 0,7
820 PRINT USING " Dropping resistor....... #,###.# ohms, ###.# watts ";R,P
830 COLOR 7,0
840 PRINT
850 IF V>(0.8500000238418579!*E)AND V<(1.0499999523162842!*E) THEN V$= " will probably ":ELSE V$=" may not "
860 PRINT " This substitution";V$;"work."
870 PRINT UL$;
880 LN=CSRLIN:PRINT " (";N;" iterations )..... Press any key ....."
890 Z$=INKEY$:IF Z$=""THEN 890
900 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
910 GOSUB 1260:CLS:GOTO 80
920 :REM'.....change output voltage
930 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
940 PRINT " To change output voltage by adding a dropping resistor across the";:
950 PRINT " output:"
960 PRINT UL$;
970 LN=CSRLIN
980 INPUT " ENTER: No-Load voltage...............";V
990 INPUT " ENTER: Desired output voltage........";E
1000 IF E<V THEN 1050
1010 BEEP: PRINT " Output voltage must be less than the no-load voltage!"
1020 PRINT " .....press any key....."
1030 Z$=INKEY$:IF Z$=""THEN 1030
1040 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 980
1050 INPUT " ENTER: Desired output current (mA)...";I
1060 R=E/I*1000
1070 J=0:N=0
1080 M=1 :REM'increment
1090 J=J+M:N=N+1
1100 IF (V/J*1000)<=R THEN 1120    :REM'load resistance
1110 GOTO 1090
1120 LR=V/J*1000   :REM'load resistor
1130 P=(V/R)^2*LR  :REM'watts
1140 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1150 PRINT USING " No-Load voltage......... #,###.# volts";V
1160 PRINT USING " Actual output voltage... #,###.# volts";E
1170 PRINT USING " Output current.......... #,###.# mA.";I
1180 COLOR 0,7
1190 PRINT USING " Dropping resistor....... #,###.# ohms, ###.# watts ";LR,P
1200 COLOR 7,0
1210 PRINT STRING$(80,205);
1220 LN=CSRLIN:PRINT " (";N;" iterations )..... Press any key ....."
1230 Z$=INKEY$:IF Z$=""THEN 1230
1240 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1250 GOSUB 1260:CLS:GOTO 80
1260 :REM'.....PRT
1270 KEY OFF:GOSUB 1340:LOCATE 25,5:COLOR 0,2
1280 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1290 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1300 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1300 :ELSE GOSUB 1340
1310 IF Z$="3"THEN RETURN
1320 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1330 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1270
1340 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
