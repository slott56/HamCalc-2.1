10 :REM'NUMDERIV - 10 MAR 96 rev. 07 JUN 2002
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 UL$=STRING$(80,205)
70 COLOR 7,0,5
80 :REM'
90 :REM'.....start
100 CLS:A#=0
110 COLOR 15,1
120 PRINT " NUMBERS and FUNCTIONS";TAB(61);"by George C. Murphy ";
130 COLOR 5,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 :REM'
160 PRINT " Press number in < > to find:"
170 PRINT UL$;
180 PRINT "   < 1 >  Powers, roots, reciprocals & logarithms"
190 PRINT "   < 2 >  Antilogarithms"
200 PRINT "   < 3 >  Logarithms to any base"
210 PRINT
220 PRINT "   < 0 >  EXIT"
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN CLS:CHAIN GO$
250 IF Z$="1"THEN 300
260 IF Z$="2"THEN 530
270 IF Z$="3"THEN 650
280 GOTO 230
290 :REM'
300 :REM'.....derivatives
310 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
320 INPUT " ENTER: Number to be analyzed........";A
330 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
340 PRINT " Functions of";A
350 PRINT UL$;
360 PRINT " Number.................................";A
370 PRINT " Square.................................";A^2
380 PRINT " Cube...................................";A^3
390 B=A^(1/2)
400 PRINT " Square root............................";B
410 C=A^(1/3)
420 PRINT " Cube root..............................";C
430 D=1/A
440 PRINT " Reciprocal.............................";
450 PRINT USING "##.######";D
460 NL=LOG(A)
470 PRINT " Natural logarithm......................";NL
480 CL=LOG(A)/LOG(10)
490 PRINT " Common logarithm.......................";CL
500 GOTO 750
510 END
520 :REM'
530 :REM'.....antilogarithm
540 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
550 INPUT " ENTER: Value of logarithm.   ....";A
560 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
570 PRINT "        Value of logarithm...............";A
580 ANL=EXP(A)
590 PRINT "        Antilogarithm if natural log.....";ANL
600 ACL=10^A
610 PRINT "        Antilogarithm if common log......";ACL
620 GOTO 750
630 END
640 :REM'
650 :REM'.....log to any base
660 CLS
670 INPUT " ENTER: Value of Base";Y:GOSUB 720
680 INPUT " ENTER: Number (or 0 to quit)";X:GOSUB 720
690 IF X=0 THEN 730 :ELSE J=LOG(X)/LOG(Y)
700 PRINT "log";X;USING "(base###)=";Y;:PRINT J
710 GOTO 680
720 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:RETURN
730 GOTO 750
740 :REM'
750 :REM'.....end
760 GOSUB 800
770 GOTO 90
780 END
790 :REM'
800 :REM'PRT
810 KEY OFF:GOSUB 880:LOCATE 25,5:COLOR 0,2
820 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
830 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
840 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 840 :ELSE GOSUB 880
850 IF Z$="3"THEN RETURN
860 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
870 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 810
880 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
