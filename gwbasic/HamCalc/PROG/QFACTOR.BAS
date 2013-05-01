10 :REM'QFACTOR - Q Factor of Components - 01 JAN 2002 rev.01 MAR 2001
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 UL$=STRING$(80,205)
50 :REM'
60 :REM'.....title page
70 X=0:XC=0:XL=0:R=0:Q=0
80 CLS
90 COLOR 15,2,1
100 PRINT " Q FACTOR of L/C COMPONENTS"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 GOSUB 520 :REM'preamble
140 PRINT UL$;
150 COLOR 0,7:LOCATE ,23:PRINT " Press 1 to continue or 0 to EXIT ":
160 COLOR 7,0
170 Z$=INKEY$:IF Z$=""THEN 170
180 IF Z$="0"THEN CLS:CHAIN EX$
190 IF Z$="1"THEN COLOR 7,0,0:CLS:GOSUB 390:GOTO 220
200 GOTO 170
210 :REM'
220 :REM'.....data entry
230 IF X OR XC THEN 250
240 INPUT " ENTER: Capacitive reactance (ohms) or 0 if unknown";XC:GOSUB 330
250 IF X OR XL THEN 270
260 INPUT " ENTER: Inductive reactance (ohms) or 0 if unknown";XL:GOSUB 330
270 IF Q THEN 290
280 INPUT " ENTER: Q of component";Q:GOSUB 330
290 IF R THEN 310
300 INPUT " ENTER: Sum of all resistances (ohms)";R:GOSUB 330
310 GOTO 230
320 :REM'
330 :REM'.....calculate
340 IF X=0 AND XC<>0 THEN X=XC
350 IF X=0 AND XL<>0 THEN X=XL
360 IF X=0 AND Q*R<>0 THEN X=Q*R:GOTO 340
370 IF R=0 AND Q*X<>0 THEN R=X/Q:GOTO 340
380 IF Q=0 AND R*X<>0 THEN Q=X/R:GOTO 340
390 :REM'.....display
400 CLS:PRINT " Q FACTOR of L/C COMPONENTS"TAB(57)"by George Murphy VE3ERP ";
410 PRINT UL$;
420 IF XC THEN PRINT USING " Capacitive reactance......Xc= #####.### ohms";XC
430 IF XL THEN PRINT USING " Inductive reactance.......Xl= #####.### ohms";XL
440 IF XC OR XL THEN 460
450 IF X  THEN PRINT USING " Reactance..................X= #####.### ohms";X
460 IF R  THEN PRINT USING " Sum of all resistances.....R= #####.### ohms";R
470 IF Q  THEN PRINT USING " Q of component.............Q= #####.### ";Q
480 IF Q*X*R THEN PRINT UL$;:GOTO 820
490 RETURN
500 END
510 :REM'
520 :REM'.....preamble
530 T=8
540 PRINT TAB(T);
550 PRINT "Good quality ceramic capacitors and mica capacitors may have Q"
560 PRINT TAB(T);
570 PRINT "values of 1200 or more. Small ceramic trimmer capacitors may have Q"
580 PRINT TAB(T);
590 PRINT "values too small to ignore in some applications. At microwave"
600 PRINT TAB(T);
610 PRINT "frequencies capacitors can have poor Q values; 10 or less at 10 GHz"
620 PRINT TAB(T);
630 PRINT "and higher."
640 PRINT
650 PRINT TAB(T);
660 PRINT "Inductors are subject to many types of energy losses such as wire"
670 PRINT TAB(T);
680 PRINT "resistance, core losses, and skin effect. As a result, inductor Q"
690 PRINT TAB(T);
700 PRINT "rarely, if ever, approaches capacitor Q in a circuit where both"
710 PRINT TAB(T);
720 PRINT "components work together. Although many circuits call for the"
730 PRINT TAB(T);
740 PRINT "highest Q inductor obtainable, other circuits may call for a"
750 PRINT TAB(T);
760 PRINT "specific Q, or even a very low one."
770 PRINT
780 PRINT TAB(T);
790 PRINT "(ref. The 2000 ARRL Handbook for Radio Amateurs, page 6.21)"
800 RETURN
810 :REM'
820 :REM'.....end
830 GOSUB 850:GOTO 60
840 :REM'
850 :REM'.....PRT
860 KEY OFF:GOSUB 930:LOCATE 25,5:COLOR 0,2
870 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
880 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
890 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 890 :ELSE GOSUB 930
900 IF Z$="3"THEN RETURN
910 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
920 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 860
930 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
