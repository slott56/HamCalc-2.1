10 :REM'BRICK - Brick & block estimator - 02 MAR 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....start
70 CLS
80 COLOR 15,2,0
90 PRINT " MASONRY ESTIMATOR"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 7,0
120 GOTO 160
130 :REM'.....erase
140 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
150 RETURN
160 :REM'.....diagram
170 COLOR 0,7:T=30
180 LOCATE,T:PRINT "                    "
190 LOCATE,T:PRINT " │«──── A ────»│    "
200 LOCATE,T:PRINT " ┌─┬───┬───┬───┐«─┐ "
210 LOCATE,T:PRINT " ├─┴─┬─┴─┬─┴─┬─┤  │ "
220 LOCATE,T:PRINT " ├─┬─┴─┬─┴─┬─┴─┤  B "
230 LOCATE,T:PRINT " ├─┴─┬─┴─┬─┴─┬─┤  │ "
240 LOCATE,T:PRINT " └───┴───┴───┴─┘«─┘ "
250 LOCATE,T:PRINT "  Typical Panel     "
260 PRINT
270 LN=CSRLIN
280 BC=A/(L+J)
290 COLOR 7,0
300 Y=4:X=60
310 LOCATE Y+1,X:PRINT "│«L»│      "
320 LOCATE Y+2,X:PRINT "┌───┐«┐H   "
330 LOCATE Y+3,X:PRINT "└───┘«┘    "
340 LOCATE Y+4,X:PRINT "Brick/Block"
350 LOCATE Y+5,X:PRINT "Dimensions"
360 GOSUB 130
370 PRINT" This program estimates quantities and dimensions for brick/block";
380 PRINT " panels."
390 PRINT
400 PRINT TAB(24)"Press 1 for dimensions in centimetres"
410 PRINT TAB(24)"Press 2 for dimensions in inches"
420 PRINT TAB(24)"Press 0 to exit"
430 Z$=INKEY$:IF Z$=""THEN 430
440 GOSUB 140
450 IF Z$="0"THEN RUN EX$
460 IF Z$="1"THEN M$="cm":GOTO 490
470 IF Z$="2"THEN M$="in":GOTO 490
480 GOTO 210
490 :REM'.....data entry
500 PRINT " Enter all dimensions in the same units of measure (cm.,in. etc,)"
510 GOSUB 140
520 PRINT " ENTER: Panel length A (";M$".)...........";:INPUT A
530 PRINT " ENTER: Panel height B (";M$".)...........";:INPUT B
540 AREA=A*B
550 PRINT " ENTER: Brick/block length L (";M$".).....";:INPUT L
560 PRINT " ENTER: Brick/block height H (";M$".).....";:INPUT H
570 PRINT " ENTER: Width of mortar joints (";M$".)...";:INPUT J
580 UNIT=(L+J)*(H+J)
590 BC=CINT(A/(L+J))
600 N=INT(AREA/UNIT)
610 IF M$="cm"THEN AR=A/100*B/100:A$="sq.metres"
620 IF M$="in"THEN AR=A/12*B/12:A$="sq.feet"
630 GOSUB 140
640 :REM'.....display
650 Y$="(approximate)":P$="(depends on pattern)"
660 PRINT USING " Panel area................... #####.### ";AR;:PRINT A$
670 PRINT USING " Panel length...............A= #####.### ";A;:PRINT M$;"."
680 PRINT USING " Panel height...............B= #####.### ";B;:PRINT M$;"."
690 PRINT USING " Brick/block length.........L= #####.### ";L;:PRINT M$;"."
700 PRINT USING " Brick/block height.........H= #####.### ";H;:PRINT M$;"."
710 PRINT USING " Bricks/blocks per course..... ##### ";BC;:PRINT Y$;P$
720 PRINT USING " Width of mortar joints....... #####.### ";J;:PRINT M$;"."
730 PRINT USING " Number of bricks/blocks...... ##### ";N;:PRINT Y$
740 LN=CSRLIN
750 CO=INT(B/(H+J))
760 GOSUB 130
770 PRINT
780 PRINT " Height B contains";CO;"courses"
790 :REM'.....end
800 GOSUB 810:GOTO 60
810 :REM'.....PRT
820 KEY OFF:GOSUB 890:LOCATE 25,5:COLOR 0,2
830 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
840 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
850 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 850 :ELSE GOSUB 890
860 IF Z$="3"THEN RETURN
870 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
880 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 820
890 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
