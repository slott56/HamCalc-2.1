10 :REM'OCTAGON - Octagonal Loop Framework - 30 NOV 2002
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$,P
40 PI=4*ATN(1)
50 UL$=STRING$(80,205)
60 :REM'
70 :REM'.....title page
80 CLS:KEY OFF
90 COLOR 15,2,1
100 PRINT " Octagonal Loop Framework"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 GOSUB 680
140 PRINT UL$;
150 IF P THEN LN=CSRLIN:GOTO 330
160 LN=CSRLIN
170 GOSUB 560  :REM'preface
180 LOCATE ,7:COLOR 0,7:PRINT " Press number in ( ) to:":COLOR 7,0
190 PRINT "  (1) Enter perimeter of loop"
200 PRINT "  (2) Enter dimension A"
210 PRINT "  (3) Enter dimension B"
220 PRINT "  (4) Enter distance between opposite corners of octagon"
230 PRINT "  (0) EXIT"
240 Z$=INKEY$:IF Z$=""THEN 240
250 IF Z$="0"THEN RUN EX$
260 IF Z$="1"THEN 310
270 IF Z$="2"THEN 340
280 IF Z$="3"THEN 370
290 IF Z$="4"THEN 400
300 GOTO 240
310 :REM'.....perimeter
320 GOSUB 840:INPUT " ENTER: Perimeter of loop";P
330 B=P/8:A=B/(TAN(22.5!*PI/180)):D=SQR(A^2+B^2):GOTO 440
340 :REM'.....dim. A
350 GOSUB 840:INPUT " ENTER: Dimension A";A
360 B=A*TAN(22.5!*PI/180):P=8*B:D=SQR(A^2+B^2):GOTO 440
370 :REM'.....dimension B
380 GOSUB 840:INPUT " ENTER: Dimension B";B
390 P=B*8:A=B/TAN(22.5!*PI/180):D=SQR(A^2+B^2):GOTO 440
400 :REM'.....Diagonal D
410 GOSUB 840:INPUT " ENTER: Distance between opposite corners of octagon";D
420 B=D*SIN(22.5!*PI/180):P=8*B:A=SQR(D^2-B^2):GOTO 440
430 :REM'
440 :REM'.....display
450 C=(A-B)/2
460 GOSUB 840:
470 PRINT USING " P =####.### (perimeter of loop)         ";P
480 PRINT USING " A =####.###";A
490 PRINT USING " B =####.###";B
500 PRINT USING " C =####.###";C
510 PRINT USING " D =####.###";D;:PRINT " (distance between opposite corners)"
520 PRINT
530 PRINT " Dimensions are between points of conductor attachment."
540 GOTO 870
550 :REM'
560 :REM'.....preface
570 T=7
580 PRINT TAB(T);
590 PRINT "This programs designs a lattice framework for mounting an octagonal"
600 PRINT TAB(T);
610 PRINT "wire antenna. Lattice may be constructed of wood, bamboo, aluminum"
620 PRINT TAB(T);
630 PRINT "tubing, plastic pipe, etc. Dimensions may be entered in any unit of"
640 PRINT TAB(T);
650 PRINT "measure. All calculated dimensions will be in the same units."
660 RETURN
670 :REM'
680 :REM'.....diagram
690 COLOR 0,7
700 T=27
710 LOCATE ,T:PRINT "        ┌── B ──┐        "
720 LOCATE ,T:PRINT "  ┌──── ╥       ╥ ────┐  "
730 LOCATE ,T:PRINT "  │     ║       ║     C  "
740 LOCATE ,T:PRINT "  │ ════╬═══╤═══╬════ ┤  "
750 LOCATE ,T:PRINT "  A     ║   │   ║     B  "
760 LOCATE ,T:PRINT "  │ ════╬═══╪═══╬════ ┤  "
770 LOCATE ,T:PRINT "  │ │   ║   │   ║   │ C  "
780 LOCATE ,T:PRINT "  └─┼── ╨   │   ╨ ──┼─┘  "
790 LOCATE ,T:PRINT "    │       │«-mast │    "
800 LOCATE ,T:PRINT "    └────── A ──────┘    "
810 COLOR 7,0
820 RETURN
830 :REM'
840 :REM'.....erase bottom of screen
850 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
860 RETURN
870 :REM'.....end
880 GOSUB 900:P=0:GOTO 70
890 :REM'
900 :REM'.....PRT
910 KEY OFF:GOSUB 980:LOCATE 25,5:COLOR 0,2
920 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
930 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
940 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 940 :ELSE GOSUB 980
950 IF Z$="3"THEN RETURN
960 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
970 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 910
980 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
