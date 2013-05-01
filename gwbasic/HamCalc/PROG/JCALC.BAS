10 :REM'JCALC - "J-Calculator" - 24 MAR 97 rev. 28 JUL 1998
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 U$="######.#"
60 UL$=STRING$(80,205)
70 GOTO 140
80 :REM'
90 :REM'.....format
100 LOCATE CSRLIN-1:PRINT SPC(7);
110 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;ZZ;
120 RETURN
130 :REM'
140 :REM'.....start
150 CLS:COLOR 15,2
160 PRINT " J-CALCULATOR  (Complex Impedances)";
170 PRINT TAB(57)"by N. Sutherland ZL2APG ";
180 PRINT STRING$(80,32);
190 LOCATE CSRLIN-1,12
200 PRINT " edited and enhanced for HAMCALC by George Murphy VE3ERP"
210 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
220 GOSUB 950    :REM'preface
230 COLOR 0,7:LOCATE 25,24
240 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
250 Z$=INKEY$:IF Z$=""THEN 250
260 IF Z$="0"THEN CLS:RUN EX$
270 IF Z$="1"THEN 300
280 GOTO 250
290 :REM'
300 :REM'.....inputs
310 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 5
320 PRINT " 1st IMPEDANCE (Z1)"
330 INPUT " ENTER: Resistive Component....................(ohms)";A
340 ZZ=A:GOSUB 90:PRINT " Ω"
350 INPUT " ENTER: Reactive  Component....................(ohms)";B
360 ZZ=B:GOSUB 90:PRINT " Ω"
370 IF B<0 THEN J$="-j":ELSE J$="+j"
380 B$=STR$(B):B$=RIGHT$(B$,LEN(B$)-1)
390 COLOR 15:PRINT "         Z1 Complex Impedance =";A;J$;B$;" Ω"
400 COLOR 7:PRINT
410 PRINT " 2nd IMPEDANCE (Z2)"
420 INPUT " ENTER: Resistive Component....................(ohms)";C
430 ZZ=C:GOSUB 90:PRINT " Ω"
440 INPUT " ENTER: Reactive  Component....................(ohms)";D
450 ZZ=D:GOSUB 90:PRINT " Ω"
460 IF D<0 THEN J$="-j":ELSE J$="+j"
470 D$=STR$(D):D$=RIGHT$(D$,LEN(D$)-1)
480 COLOR 15:PRINT "         Z2 Complex Impedance =";C;J$;D$;" Ω"
490 COLOR 7:PRINT :PRINT UL$;
500 LN=CSRLIN
510 FOR I=1 TO 4:ONI GOSUB 670,730,790,850:NEXT I:GOTO 910
520 VIEW PRINT LN TO 24:VIEW PRINT:LOCATE LN+1
530 IF X<0 THEN J$=" -j":ELSE J$=" +j"
540 Z=INT(Z*10^3+0.5!)/10^3
550 Z$=RIGHT$(STR$(Z),LEN(STR$(Z))-1)
560 IF ABS(Z)>0 AND ABS(Z)<1 THEN Z$="0"+Z$
570 IF Z<0 THEN Z$="-"+Z$ :ELSE Z$=" "+Z$
580 X=INT(X*10^3+0.5!)/10^3
590 X$=RIGHT$(STR$(X),LEN(STR$(X))-1)+" Ω "
600 IF ABS(X)>0 AND ABS(X)<1 THEN X$="0"+X$
610 PRINT TAB(9)"RESULT:";
620 PRINT " Z1 "R$" Z2";STRING$(30,".");
630 COLOR 0,7:PRINT " "Z$;J$;X$:LN=CSRLIN
640 COLOR 7,0
650 RETURN
660 :REM'
670 :REM'.....add
680 Z=A+C
690 X=B+D
700 R$="+"
710 GOTO 520
720 :REM'
730 :REM'.....subtract
740 Z=A-C
750 X=B-D
760 R$="-"
770 GOTO 520
780 :REM'
790 :REM'.....multiply
800 Z=(A*C)-(B*D)
810 X=(A*D)+(B*C)
820 R$="x"
830 GOTO 520
840 :REM'
850 :REM'.....divide
860 Z=((A*C)+(B*D))/(C^2+D^2)
870 X=((B*C)-(A*D))/(C^2+D^2)
880 R$="÷"
890 GOTO 520
900 :REM'
910 :REM'.....end
920 GOSUB 1390:GOTO 140
930 PRINT :COLOR 0,7
940 :REM'
950 :REM'.....preface
960 T=7
970 PRINT TAB(T);
980 PRINT "  This program is intended as a j calculator for the addition,"
990 PRINT TAB(T);
1000 PRINT "subtraction, multiplication and division of impedances in"
1010 PRINT TAB(T);
1020 PRINT "rectangular form (happily, without switching back and forth from"
1030 PRINT TAB(T);
1040 PRINT "rectangular to polar form). There is never any doubt which quadrant"
1050 PRINT TAB(T);
1060 PRINT "you are in."
1070 PRINT TAB(T);
1080 PRINT "  For those of you who have not used operator j lately, +j rotates"
1090 PRINT TAB(T);
1100 PRINT "the impedance vector from the 3 o'clock initial position anti-"
1110 PRINT TAB(T);
1120 PRINT "clockwise 90° to the 12 o'clock position, and -j rotates from the"
1130 PRINT TAB(T);
1140 PRINT "3 o'clock initial position to 6 o'clock. As anyone can plainly see,"
1150 PRINT TAB(T);
1160 PRINT "+j is inductive and -j is capacitive. If this you cannot plainly"
1170 PRINT TAB(T);
1180 PRINT "see, don't bother about it; j has been used for 200 years without"
1190 PRINT TAB(T);
1200 PRINT "anyone knowing how it works."
1210 PRINT TAB(T);
1220 PRINT "  It is no longer necessary to grapple with the Complex Algebra"
1230 PRINT TAB(T);
1240 PRINT "section of the 1997 ARRL HANDBOOK for RADIO AMATEURS (p.4.15), or"
1250 PRINT TAB(T);
1260 PRINT "other reference works of similar ilk. Use this program instead, to"
1270 PRINT TAB(T);
1280 PRINT "avoid boggling your mind."
1290 PRINT TAB(T);
1300 PRINT
1310 PRINT TAB(T);
1320 PRINT "  The original version of this program was published in Vol. 70, #1"
1330 PRINT TAB(T);
1340 PRINT "of BREAK-IN, the official journal of the New Zealand Association"
1350 PRINT TAB(T);
1360 PRINT "of Radio Transmitters Inc.";
1370 RETURN
1380 :REM'
1390 :REM'.....PRT
1400 KEY OFF:GOSUB 1470:LOCATE 25,5:COLOR 0,2
1410 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1420 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1430 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1430 :ELSE GOSUB 1470
1440 IF Z$="3"THEN RETURN
1450 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1460 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1400
1470 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
