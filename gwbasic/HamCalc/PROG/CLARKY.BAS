10 :REM'CLARKY - 06 FEB 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=ATN(1)*4
70 :REM'.....title page
80 COLOR 15,2
90 PRINT " CLARK Y AIRFOIL"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 7,0
110 :REM'.....start
120 :REM'.....diagram
130 COLOR 0,7
140 PRINT "                                                   "
150 PRINT "   A────────────────────────────────┐B             "
160 PRINT "                                    │              "
170 PRINT "                                   E├───────────F   F=leading edge  "
180 PRINT "   C────────────────────────────────┤D          │   C=trailing edge "
190 PRINT "    │                               │           │  "
200 PRINT "    │                               ┼G          │  "
210 PRINT "    │«─────────────chord───────────────────────»│  "
220 PRINT "                                                   "
230 PRINT "    Radius R=GB=GC                                 "
240 PRINT "    Curve CB is an arc with radius R and centre G  "
250 PRINT "    Curve BF is a ¼ elipse with axes BE and EF     "
260 PRINT "    Curve DF is a ¼ elipse with axes DE and EF     "
270 COLOR 7,0
280 PRINT :LN=CSRLIN
290 PRINT " This program designs templates for Clark Y Airfoils."
300 PRINT
310 PRINT " Press <1> to RUN or <0> to EXIT"
320 Z$=INKEY$:IF Z$=""THEN 320
330 IF Z$="0"THEN RUN GO$
340 IF Z$="1"THEN 360
350 GOTO 320
360 VIEW PRINT LN TO 24:CLS:VIEW PRINT
370 :REM'......data input
380 LOCATE LN:INPUT " ENTER length of chord         ";L
390 LOCATE 9,19:PRINT " CHORD = ";L
400 CD=L*0.699999988079071!:EF=L*0.30000001192092896!:BD=L*0.11699999868869781!:DE=BD/3:BE=BD-DE
410 BC=SQR(CD^2+BD^2):BH=BC/2
420 LD=9.488900184631348! :REM'angle-decimal
430 LR=LD*PI/180:REM'angle-radians
440 J=SIN(LR)
450 GB=BH/J
460 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
470 PRINT USING " Flat bottom CD......... ####.###";CD
480 PRINT USING " Thickness BD........... ####.###";BD
490 PRINT USING " Axis EF................ ####.###";EF
500 PRINT USING " Axis BE................ ####.###";BE
510 PRINT USING " Axis DE................ ####.###";DE
520 PRINT USING " R,GB,GC................ ####.###";GB
530 PRINT USING " Angle BGC.............. ####.###°";LD*2
540 PRINT "  For a detail drawing e-mail ve3erp@rac.ca and ask for CLARKY.jpg"
550 GOSUB 560:CLS:GOTO 70
560 :REM'.....end
570 KEY OFF:GOSUB 640:LOCATE 25,5:COLOR 0,2
580 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
590 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
600 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 600 :ELSE GOSUB 640
610 IF Z$="3"THEN RETURN
620 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
630 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 570
640 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
