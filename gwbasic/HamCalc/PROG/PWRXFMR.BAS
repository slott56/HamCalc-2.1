10 :REM'PWRXFMR -Power Transformer Windings Estimator- 23 JAN 2000 rev. 03 APR 2000
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="pwrxfmr"
60 COMMON EX$,PROG$
70 COLOR 7,0,1
80 DIM K(9,2)
90 DATA .4,.5,.6,.7,.8,.9,1,1.25,1.5,90,80,70,60,55,50,50,45,43
100 FOR Z=1 TO 9:READ K(Z,1):NEXT Z
110 FOR Z=1 TO 9:READ K(Z,2):NEXT Z
120 RESTORE
130 :REM'
140 :REM'.....title page
150 COLOR 15,2
160 PRINT " POWER TRANSFORMER WINDINGS ESTIMATOR";
170 PRINT TAB(57)"BY GEORGE MURPHY VE3ERP ";
180 COLOR 1,0:PRINT STRING$(80,223);
190 COLOR 7,0
200 GOSUB 880  :REM'preface
210 PRINT:COLOR 15
220 PRINT TAB(T)"Press (1) to enter dimensions in inches"
230 PRINT TAB(T)"      (2) to enter dimensions in centimetres"
240 PRINT TAB(T)"      (3) to run Copper Wire Data program"
250 PRINT TAB(T)"      (4) to run Power Transformer Design program"
260 PRINT TAB(T)"      (0) to EXIT":COLOR 7
270 Z$=INKEY$:IF Z$=""THEN 270
280 IF Z$="1"THEN M$="in.":M=1:GOTO 350
290 IF Z$="2"THEN M$="cm.":M=2.5399999618530273!:GOTO 350
300 IF Z$="3"THEN CHAIN "copwire"
310 IF Z$="4"THEN CHAIN "powrxfmr"
320 IF Z$="0"THEN CLS:CHAIN GO$
330 GOTO 270
340 :REM'
350 :REM'.....start
360 P=0:S=0:I=0:IP=0:MV=0:D=0:A=0:W=0:H=0:AR=0:VA=0:T=0:TP=0:TS=0:TV=0
370 GOSUB 650
380 INPUT " ENTER: Primary voltage.......................";P:GOSUB 650
390 INPUT " ENTER: Secondary voltage.....................";S:GOSUB 650
400 INPUT " ENTER: Secondary current (amps)..............";I
410 MV=S*I:IP=S/P*I:GOSUB 650
420 :REM'
430   FOR Z=1 TO 9
440 A=K(Z,1):B=K(Z,2)
450 IF A^2*B>MV THEN 490
460   NEXT Z
470 A=SQR(MV/B)
480 :REM'
490 INPUT " ENTER: Your desired VA rating................";D
500 A=SQR(D/B)
510 GOSUB 650
520 PRINT " ENTER: Your core cross-section width (";M$;")...";:INPUT Z:W=Z/M
530 PRINT " ENTER: Your core cross-section height (";M$;")..";:INPUT Z:H=Z/M
540 AR=W*H:TV=7/AR:VA=AR^2*B
550 TP=TV*P:TS=TV*S:GOSUB 650
560 COLOR 7,0:GOSUB 1210
570 COLOR 14,4
580 LOCATE 25,23:PRINT " Try (a)nother or (q)uit?   (a/q) ";:COLOR 7,0
590 Z$=INKEY$:IF Z$=""THEN 590
600 IF Z$="a"THEN 350
610 IF Z$="q"THEN CLS:GOTO 140
620 GOTO 590
630 END
640 :REM'
650 :REM'.....display
660 COLOR 7,0:VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
670 IF P  THEN PRINT USING " Primary winding............. ######.## volts";P
680 IF IP THEN PRINT USING " Primary current............. ######.## amps";IP
690 IF S  THEN PRINT USING " Secondary winding........... ######.## volts";S
700 IF I  THEN PRINT USING " Secondary current........... ######.## amps";I
710 IF MV THEN PRINT USING " Minimum VA rating........... ######.##";MV
720 IF D  THEN PRINT USING " Desired VA rating........... ######.##";D
730 IF A  THEN PRINT USING " Minimum core section area... ######.##";A;
740 IF A  THEN PRINT " sq.in.=";:PRINT USING "###.##";A*2.5399999618530273!^2;:PRINT " sq.cm."
750 IF A THEN PRINT
760 IF W  THEN PRINT USING " Your core section width..... ######.##";W;
770 IF W  THEN PRINT " in.   =";:PRINT USING "###.##";W*2.5399999618530273!;:PRINT " cm."
780 IF H  THEN PRINT USING " Your core section height.... ######.##";H;
790 IF H  THEN PRINT " in.   =";:PRINT USING "###.##";H*2.5399999618530273!;:PRINT " cm."
800 IF AR THEN PRINT USING " Your core section area...... ######.##";AR;
810 IF AR THEN PRINT " sq.in.=";:PRINT USING "###.##";AR*2.5399999618530273!^2;:PRINT " sq.cm."
820 IF VA THEN PRINT USING " Actual VA rating............ ######.##";VA
830 IF TV THEN PRINT USING " Turns per volt.............. ######.##";TV
840 IF TP THEN PRINT USING " Number of primary turns..... ######   ";TP
850 IF TS THEN PRINT USING " Number of secondary turns... ######   ";TS
860 COLOR 0,7:RETURN
870 :REM'
880 :REM'.....preface
890 T=7
900 PRINT TAB(T);
910 PRINT "This program is based on a unique method of estimating power"
920 PRINT TAB(T);
930 PRINT "transformer windings by Luther, ZS6E, originally published in"
940 PRINT TAB(T);
950 PRINT "Radio-ZS, Nov/Dec 1991 issue. Luther's article has been translated"
960 PRINT TAB(T);
970 PRINT "into English by Mark Venter, ZL3VML, and re-published in the"
980 PRINT TAB(T);
990 PRINT "Nov/Dec 1999 issue of Break-in, the official journal of the New"
1000 PRINT TAB(T);
1010 PRINT "Zealand Association of Radio Transmitters."
1020 PRINT
1030 PRINT TAB(T);
1040 PRINT "You may want to determine the wire sizes required for the currents"
1050 PRINT TAB(T);
1060 PRINT "involved. This information is available in ";
1070 PRINT "HAMCALC's ";CHR$(34);"Copper Wire Data";CHR$(34)
1080 PRINT TAB(T);
1090 PRINT "program."
1100 PRINT
1110 PRINT TAB(T);:COLOR 12
1120 PRINT "CAUTION! There is much more to transformer design than what you"
1130 PRINT TAB(T);
1140 PRINT "will find in this program, which is meant only to give a rough"
1150 PRINT TAB(T);
1160 PRINT "estimate of number of turns. Use the results of this program with"
1170 PRINT TAB(T);
1180 PRINT "care!"
1190 COLOR 7:RETURN
1200 :REM'
1210 :REM'PRT
1220 KEY OFF:GOSUB 1290:LOCATE 25,5:COLOR 0,2
1230 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1240 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1250 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1250 :ELSE GOSUB 1290
1260 IF Z$="3"THEN RETURN
1270 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1280 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1220
1290 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
