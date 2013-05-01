10 :REM'PEDOM - Pedometer - 05 MAR 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " PEDOMETER"TAB(57)"by George Murphy VE3ERP ";
90 COLOR 1,0:PRINT STRING$(80,223);
100 COLOR 7,0
110 GOTO 150
120 :REM'.....erase line
130 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
140 RETURN
150 :REM'.....menu
160 LN=CSRLIN
170 PRINT TAB(13)"This program calculates walking speed, time and distance."
180 PRINT
190 PRINT TAB(19)" .....Press 1 to continue or 0 to Exit....."
200 Z$=INKEY$:IF Z$=""THEN 200
210 IF Z$="0"THEN RUN EX$
220 IF Z$="1"THEN 240
230 GOTO 200
240 :REM'.....start
250 W=0:S=0:T=0:D=0
260 GOSUB 120:LOCATE LN
270 PRINT " The stride length of an average adult is about 32 inches (80 cent";
280 PRINT "imetres)."
290 PRINT " Normal walking speed is about 3 miles (4.8 kilometres) per hour."
300 PRINT
310 PRINT " When entering data if you want to skip an entry press ENTER to go";
320 PRINT " on to the   "
330 PRINT " next entry. When the program has all it needs it will proceed."
340 PRINT STRING$(79,205)
350 W=0:S=0:T=0:D=0
360 :REM'.....data entry
370 LN=CSRLIN
380 GOSUB 120:IF W=0 THEN INPUT " ENTER: Your stride length (in.)";W
390 GOSUB 120:IF W=0 THEN INPUT " ENTER: Your stride length (cm.)";X:W=X/2.5399999618530273!
400 GOSUB 120:IF S=0 THEN INPUT " ENTER: Your speed (miles/hour)";S
410 GOSUB 120:IF S=0 THEN INPUT " ENTER: Your speed (km./hour)";X::S=X*0.6230999827384949!
420 GOSUB 120:IF T=0 THEN INPUT " ENTER: Time walked (hours)";T
430 GOSUB 120:IF T=0 THEN INPUT " ENTER: Time walked (minutes)";X:T=X/60
440 GOSUB 120:IF D=0 THEN INPUT " ENTER: Distance walked (miles)";D:
450 GOSUB 120:IF D=0 THEN INPUT " ENTER: Distance walked (km.)";X:D=X*0.6230999827384949!
460 :REM'.....summary
470 IF S*T THEN D=S*T
480 IF D*S THEN T=D/S
490 IF D*T THEN S=D/T
500 IF W*S*T*D THEN 520
510 GOTO 360
520 :REM'.....display
530 GOSUB 120:LOCATE 9
540 PRINT USING " Stride length...... ####.# in.    ####.# cm.";W,W*2.5399999618530273!
550 PRINT USING " Speed.............. ####.# mph    ####.# km/h";S,S/0.6230999827384949!
560 PRINT USING " Time walked........ ####.# hrs    ####.# min.";T,T*60
570 PRINT USING " Distance walked.... ####.# miles  ####.# km.";D,D/0.6230999827384949!
580 PRINT USING " No. of steps taken #####,###";D*5280*12/W
590 :REM'.....end
600 GOSUB 610:CLS:GOTO 60
610 :REM'.....PRT
620 KEY OFF:GOSUB 690:LOCATE 25,5:COLOR 0,2
630 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
640 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
650 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 650 :ELSE GOSUB 690
660 IF Z$="3"THEN RETURN
670 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
680 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 620
690 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
