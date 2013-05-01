10 :REM'HARTOSC3 - Hartly FET oscillator - 07 MAR 08, rev 9/17/10
15 :REM'rev 9/22/10. This corrects an inconsistancy in entering C1 and C2 values.
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....start
70 CLS
80 COLOR 15,2
90 PRINT " HARTLY FET OSCILLATOR";TAB(61);"by R.J.Dehoney,IEEE ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 7,0
120 GOSUB 230  :REM'print diaream
130 LN=CSRLIN
140 PRINT
150 PRINT " Press <1> to run program"
160 PRINT " Press <2> for theory"
170 PRINT " Press <0> to EXIT"
180 Z$=INKEY$:IF Z$=""THEN 180
190 IF Z$="1"THEN LN=3:GOSUB 1110:GOSUB 260:GOTO 400
200 IF Z$="2"THEN CLS:GOSUB 880:GOSUB 1130:GOTO 60
210 IF Z$="0"THEN RUN EX$
220 GOTO 190
230 TP=8*ATN(1):PRINT TAB(27);"HARTLEY OSCILLATOR " :PRINT
240 PRINT "This program finds the minimum required gm and inductance values for the"
250 PRINT "circuits shown, given RL, Fosc, C, coil Q and ratio, and the FET capacitances."
260 PRINT "                 d"
270 PRINT "            g ├──┐"
280 PRINT "    ┌───┬──┬──┤  ╧         ┌──C───┬──┬──┬──┐   These circuits are equivalent."
290 PRINT "    │  L2 Cgs ├─┐s         │   g ├┘d │  │  │   Only the ground location has"
300 PRINT "    │   │  │    │    or    ├──┬──┤  Cds L1 RL  been changed."
310 PRINT "    C   ├──┼────┤         L2 Cgs ├┐s │  │  │"
320 PRINT"    │  L1 Cds   RL         │  │   │  │  │  │"
330 PRINT"    │   │  │    │          ╧  ╧   ╧  ╧  ╧  ╧"
340 PRINT"    ╧   ╧  ╧    ╧"
350 PRINT "                   Cgd is included in C." :RETURN
360 PRINT :PRINT "To run program, press `r'. For program theory, press `t. To end, press `e'."
370 A$=INKEY$ :IF A$=""THEN 370
380 IF A$="t" THEN 880
390 IF A$="e" THEN END
400 PRINT :INPUT "Enter RL, ohms (20 to 2000) ",RL
410 INPUT "Enter M, the ratio of L2/L1 (between .1 and 10) ",M
420 INPUT "Enter desired frequency, MHz ",F0 :W0=F0*TP*1000000.0!
430 INPUT "Enter impedance level of Xc, ohms (30 to 800) ",XC :C=1/W0/XC
440 PRINT "Enter value of C near"INT(C*999999995904.0!)"pF "; :INPUT CX :C=CX/999999995904.0! :XC=1/W0/C
450 INPUT "Enter coil Q value, greater than 1 ",Q :IF Q=<1 THEN 450
460 INPUT "Enter a value for Cgs, pF ",C2X :C2=C2X/999999995904.0!
470 INPUT "Enter a value for Cds, pF ",C1X :C1=C1X/999999995904.0!
480 CC=C*C2+C*C1+C2*C1 :CEQ=C1+M*C2+C*(M+1) :AZ=RL*Q^2*M*W0^4*CC
490 BZ=RL*Q^2*W0^2*CEQ+W0*Q :CZ=RL*(Q^2-1)
500 IF BZ^2<4*AZ*CZ THEN PRINT "Increase Q or decrease C" :GOTO 430
510 L1=(BZ-SQR(BZ^2-4*AZ*CZ))/2/AZ :L2=M*L1
520 R1=Q*W0*L1 :R2=Q*W0*L2
530 :REM'----------------element formulas-----------------
540 CC=C2*C1+C*C2+C*C1 :AX=RL*R1*R2*L1*L2*CC
550 A1=L1*L2*(RL*C1*R1+RL*C2*R2+C2*R1*R2+RL*R1*C+RL*R2*C) :A2=L1*L2*R1*R2*C
560 CX=L1*L2*(RL+R1)+RL*R1*R2*(C1*L1+C2*L2+C*(L1+L2))
570 DX=RL*R1*L2+RL*L1*R2+L1*R1*R2 :EX=RL*R1*R2
580 WSQ=(CX-SQR(CX^2-4*AX*EX))/2/AX :W=SQR(WSQ) :FOSC=W/TP/1000000.0!
590 K=(DX-WSQ*A1)/A2/WSQ :PRINT "K="K :GM=(K-1)/RL
600 CLS :GOSUB 740
610 PRINT "To change a value, enter its part name, or to continue, enter `e'."
620 INPUT "Enter part name, rl,m,f0,xc,c,q,cds,cgs,l1,or l2 ",P$
630 IF P$="rl" THEN PRINT "Enter new value for "P$; :INPUT RL :GOTO 540
640 IF P$="m" THEN PRINT "Enter new value for "P$; :INPUT M :GOTO 480
650 IF P$="f0" THEN PRINT "Enter new value for "P$; :INPUT F0 :W0=F0*TP*1000000.0!    :C=1/XC/W0 :GOTO 480
660 IF P$="xc" THEN PRINT "Enter new value for "P$; :INPUT XC :C=1/W0/XC           :GOTO 480
670 IF P$="c" THEN PRINT "Enter new value for "P$; :INPUT C :C=C/999999995904.0!             :XC=1/W0/C :GOTO 540
680 IF P$="q" THEN PRINT "Enter new value for "P$; :INPUT Q :GOTO 480
690 IF P$="cds" THEN PRINT "Enter new value for "P$; :INPUT C1 :C1=C1/999999995904.0!          :GOTO 540
700 IF P$="cgs" THEN PRINT "Enter new value for "P$; :INPUT C2 :C2=C2/999999995904.0!          :GOTO 540
710 IF P$="l1" THEN PRINT "Enter new value for "P$; :INPUT L1 :L1=L1/1000000.0!           :M=L2/L1 :GOTO 520
720 IF P$="l2" THEN PRINT "Enter new value for "P$; :INPUT L2 :L2=L2/1000000.0!            :M=L2/L1 :GOTO 520
730 IF P$="" THEN 10 :ELSE IF ASC(P$)>64 AND ASC(P$)< 91 THEN 610 :ELSE 10
740 :REM'---------------------subroutine to print values---------------------
750 PRINT USING "RL---------------###.## ohms";RL
760 PRINT USING "M----------------------##.##";M
770 PRINT USING "F0---------------###.### MHz";F0
780 PRINT USING "Xc--------------####.## ohms";XC
790 PRINT USING "C----------------####.### pF";C*999999995904.0!
800 PRINT USING "Q-----------------------####";Q
810 PRINT USING "Cds-----------------##.## pF";C1*999999995904.0!
820 PRINT USING "Cgs-----------------##.## pF";C2*999999995904.0!
830 PRINT USING "L1-----------------##.### uH";L1*1000000.0!
840 PRINT USING "L2-----------------##.### uH";L2*1000000.0!
850 LOCATE 6,35 :PRINT USING "Fosc-----------###.##### MHz";FOSC
860 LOCATE 7,35 :PRINT USING "gm-----------------.#### mho";GM
870 LOCATE 18,1 :RETURN
880 CLS:PRINT "----------------------------Theory--------------------------"
890 PRINT "We assume we can break the circuit just before the input to the FET gm and can"
900 PRINT "apply a voltage. Oscillation will occur when the gap voltage goes to zero. We"
910 PRINT "use a symbolic circuit analysis program to find the expression for the gap"
920 PRINT "voltage, and find that the numerator is of the form:"
930 PRINT
940 PRINT "         W^4*Ax-jW^3*Bx-W^2*Cx+jW*Dx+Ex."
950 PRINT
960 PRINT "At W0, both real and imaginary parts must equal zero, which gives us two"
970 PRINT "equations for W0. Luckily, one of them does not include gm, so if we can enter"
980 PRINT "values for W0, C, Cds, Cgs, Q, RL and the ratio of L2 to L2, we can find L1,"
990 PRINT "then L2 and the loss resistances. Knowing these values, we can use the other"
1000 PRINT "expression to find gm. When we change a value, we can use the formula that"
1010 PRINT "doesn't include gm to find W, then use the other to find gm as before."
1020 PRINT
1030 PRINT "The `Change Values' section deserves a little explaination. We assume that"
1040 PRINT "a request to change F0, M, XC, or Q means recalculation of the L's and R's."
1050 PRINT "However, a request to change RL, C, Cds, Cgs, L1, or L2 just means another"
1060 PRINT "calculation of Fosc and gm, using the same values for the other elements."
1070 PRINT "This allows us to see how the frequency and required gm are affected by"
1080 PRINT "small changes in those elements."
1090 PRINT :PRINT "Press any key."
1100 A$=INKEY$ :IF A$="" THEN 1100 :ELSE 230
1110 :REM'.....clear ro bottom
1120 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
1130 :REM'.....PRT
1140 KEY OFF:GOSUB 1210:LOCATE 25,5:COLOR 0,2
1150 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1160 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1170 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1170 :ELSE GOSUB 1210
1180 IF Z$="3"THEN RETURN
1190 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1200 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1140
1210 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
