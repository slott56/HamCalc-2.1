10 :REM'PRECICAP - Precision Capacitor - 12 AUG 95 rev. 07 NOV 97
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON PROG$,EX$
50 CLS:KEY OFF
60 COLOR 7,0,0
70 UL$=STRING$(80,205)  :REM'underline
80 ER$=STRING$(80,32)   :REM'erase
90 U1$="########,##.#"
100 U2$="#########.###"
110 O$=" pF"
120 :REM'
130 COLOR 15,2
140 PRINT " PRECISION CAPACITOR";TAB(57);"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,"▀");
160 COLOR 7,0
170 :REM'
180 :REM'.....start
190 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
200 :REM'.....diagram
210 COLOR 0,7
220 T=24       :REM'tab
230 LOCATE  3,T:PRINT "                                   "
240 LOCATE  4,T:PRINT "  │«──────────── C ────────────»│  "
250 LOCATE  5,T:PRINT "  │                             │  "
260 LOCATE  6,T:PRINT "  │                             │  "
270 LOCATE  7,T:PRINT "  │                             │  "
280 LOCATE  8,T:PRINT "        C1               C2        "
290 LOCATE  9,T:PRINT " X ═════╡╞═══════════════╡╞═════ Y "
300 LOCATE 10,T:PRINT "                                   "
310 COLOR 7,0
320 LOCATE 11:PRINT UL$;
330 IF C<>0 THEN 490
340 :REM'
350 COLOR 0,7:LOCATE CSRLIN,23
360 PRINT " Press 1 to continue or 0 to EXIT... "
370 COLOR 7,0
380 Z$=INKEY$:IF Z$=""THEN 380
390 IF Z$="0"THEN CLS:CHAIN GO$
400 IF Z$="1"THEN 420
410 GOTO 380
420 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
430 :REM'
440 :REM'.....inputs
450 PRINT " ENTER:";:COLOR 0,7
460 INPUT " Sought precise capacitance between X & Y........(pF)=";C
470 COLOR 7,0
480 LOCATE CSRLIN-1:PRINT "       ";
490 LOCATE CSRLIN,57:COLOR 0,7:PRINT "....C =";
500 LOCATE CSRLIN,64:PRINT USING U1$;C;:PRINT O$:COLOR 7,0
510 INPUT " ENTER: Value of next standard capacitor greater than C....C1 =";C1
520 LOCATE CSRLIN-1,1:PRINT "       ";
530 LOCATE CSRLIN,57:PRINT "...C1 =";
540 LOCATE CSRLIN,64:PRINT USING U1$;C1;:PRINT O$
550 :REM'
560 CX=C/(1-C/C1)          :REM'exact series capacitor
570 :REM'
580 PRINT "        Value of capacitor C2 to obtain C precisely.......... =";
590 PRINT USING U1$;CX;:PRINT O$
600 :REM'
610 INPUT " ENTER: Value of closest standard capacitor................C2 =";C2
620 LOCATE CSRLIN-1,1:PRINT "       ";
630 LOCATE CSRLIN,57:PRINT "...C2 =";
640 LOCATE CSRLIN,64:PRINT USING U1$;C2;:PRINT O$
650 CX=1/(1/C1+1/C2)
660 PRINT "       ";:COLOR 0,7
670 PRINT " Capacitance of C1 & C2 in series between X & Y.....Cx =";
680 COLOR 0,7:PRINT USING U1$;CX;:PRINT O$
690 :REM'
700 D=ABS(C-CX)/C*100
710 COLOR 15,0
720 PRINT "        DIVERGENCE of Cx from C.............................. =";
730 PRINT USING U2$;D;:PRINT " %"
740 COLOR 7,0
750 PRINT UL$;:GOSUB 780
760 C=0:GOTO 180    :REM'start
770 :REM'
780 :REM'.....add to diagram
790 N=1
800 IF 10^N<=CX THEN N=N+1:GOTO 800
810 UX$=STRING$(N,"#")+".#"
820 :REM'
830 COLOR 0,7
840 LOCATE 4,T+10:PRINT " Cx= ";USING UX$;CX;:PRINT " pF"
850 LOCATE 7,T+4:PRINT C1;"pF"
860 LOCATE 7,T+21:PRINT C2;"pF"
870 COLOR 7,0
880 :REM'
890 :REM'PRT
900 KEY OFF:GOSUB 970:LOCATE 25,5:COLOR 0,2
910 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
920 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
930 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 930 :ELSE GOSUB 970
940 IF Z$="3"THEN RETURN
950 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
960 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 900
970 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
