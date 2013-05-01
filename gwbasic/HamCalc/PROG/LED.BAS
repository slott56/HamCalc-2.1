10 :REM'LED - Light Emitting Diodes - 13 JAN 91 rev.11 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 U$="##,###.##"
60 U1$="##,###"
70 U2$="###.#"
80 UL$=STRING$(80,205)
90 X$=STRING$(7,32)
100 DIM R(12)
110 DATA 10,12,15,18,22,27,33,39,47,56,68,82
120 FOR Z=1 TO 12:READ R(Z):NEXT Z
130 :REM'
140 :REM'.....start
150 CLS
160 COLOR 15,2
170 PRINT " LED SERIES RESISTOR";TAB(57);"by George Murphy VE3ERP ";
180 COLOR 7,0
190 COLOR 1,0:PRINT STRING$(80,223);
200 COLOR 7,0
210 TB=7         :REM'tab for text
220 GOSUB 1160   :REM'text block
230 PRINT
240 COLOR 0,7
250 LOCATE CSRLIN,22:PRINT " Press 1 to continue or 0 to EXIT....."
260 COLOR 7,0
270 Z$=INKEY$:IF Z$=""THEN 270
280 IF Z$="0"THEN CLS:RUN EX$
290 IF Z$="1"THEN 310
300 GOTO 280
310 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
320 :REM'
330 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
340 :REM'
350 :REM'.....draw diagram
360 CO=24
370 COLOR 0,7
380 LOCATE CSRLIN,CO:PRINT "                                 "
390 LOCATE CSRLIN,CO:PRINT "  │«───── voltage drop V ────»│  "
400 LOCATE CSRLIN,CO:PRINT "  │                           │  "
410 LOCATE CSRLIN,CO:PRINT "         R1       ┌─────┐        "
420 LOCATE CSRLIN,CO:PRINT " + ─────\/\/\─────┤ LED ├───── - "
430 LOCATE CSRLIN,CO:PRINT "                  └─────┘        "
440 COLOR 7,0
450 PRINT UL$;
460 :REM'
470 :REM'.....inputs
480 COLOR 0,7:PRINT " ENTER:";
490 COLOR 7,0:INPUT " Voltage Drop V..............................";V
500 LOCATE CSRLIN-1:PRINT X$
510 LOCATE CSRLIN-1,51:PRINT USING U$;V;:PRINT" volts"
520 :REM'
530 :REM'COLOR 0,7:PRINT " ENTER:";
540 :REM'COLOR 7,0:INPUT " Voltage V- .................................";VO
550 :REM'LOCATE CSRLIN-1:PRINT X$
560 :REM'LOCATE CSRLIN-1,51:PRINT USING U$;VO;:PRINT" volts"
570 :REM'
580 COLOR 0,7:PRINT " ENTER:";
590 COLOR 7,0:INPUT " Forward voltage rating of LED...............";VF
600 IF VF=0 THEN VF=2:VF$=" (typical)":ELSE VF$=""
610 LOCATE CSRLIN-1:PRINT X$
620 LOCATE CSRLIN-1,51:PRINT USING U$;VF;:PRINT" volts";VF$
630 :REM'
640 COLOR 0,7:PRINT " ENTER:";
650 COLOR 7,0:INPUT " Max.current rating of LED in mA. ...........";I
660 IF I=0 THEN I=20:I$="   (typical)":ELSE I$=""
670 LOCATE CSRLIN-1:PRINT X$
680 LOCATE CSRLIN-1,51:PRINT USING U$;I;:PRINT" ma.";I$
690 :REM'
700 VD=V-VF
710 PRINT SPC(7);" Voltage drop across resistor R1 ..........";USING U$;VD;
720 PRINT" volts"
730 :REM'
740 R1=VD/I*1000         :REM'resistance at max.current
750 R2=VD/I*2*1000       :REM'resistance at 1/2 max. current
760 :REM'
770 :REM'.....recommended resistors
780 N=0:X=1
790 FOR Z=1 TO 12
800 IF R(Z)*X>=R1 AND R(Z)*X<=R2 THEN N=N+1:RES(N)=R(Z)*X
810 IF R(Z)*X>R2 THEN 850
820 NEXT Z
830 X=X*10:GOTO 790
840 :REM'
850 PRINT SPC(7);" Recommended series resistor  R1 ..........";USING U1$;RES(N);
860 PRINT"    ohms"
870 PRINT UL$;
880 :REM'
890 FOR Z=N TO 1 STEP-1
900 OP=OP+1
910 COLOR 7,0
920 IF Z=N THEN COLOR 15,3 :ELSE COLOR 7,0
930 PRINT " Option";OP;
940 MA=VD/RES(Z)*1000
950 P=MA*VD/1000
960 P$="1/4 watt"
970 IF P>0.125! THEN P$="1/2 watt"
980 IF P>0.25! THEN P$="1.0 watt"
990 IF P>1.25! THEN P$="5.0 watt"
1000 PRINT " R1 =";USING U1$;RES(Z);
1010 PRINT " ohms ";P$;", LED current=";
1020 LOCATE CSRLIN,50:PRINT USING U2$;MA;:PRINT " ma.@";
1030 PRINT USING "###.##";VD*MA/1000;:PRINT "w. dissipation ";
1040 NEXT Z
1050 PRINT UL$;
1060 COLOR 15,3
1070 PRINT " Option 1 provides LONGEST LED LIFE."
1080 COLOR 7,0
1090 PRINT " Option";OP;"provides BRIGHTEST LIGHT."
1100 OP=0
1110 PRINT UL$;
1120 GOSUB 1360
1130 GOTO 140   :REM'start
1140 END
1150 :REM'
1160 :REM'.....text page
1170 PRINT TAB(TB);
1180 PRINT "You will be asked to enter the following ratings of the LED:"
1190 PRINT
1200 PRINT TAB(TB+3);"Forward voltage rating"
1210 PRINT TAB(TB+3);"Maximum current rating"
1220 PRINT
1230 PRINT TAB(TB);
1240 PRINT "If you do not know either or both of these ratings then just press"
1250 PRINT TAB(TB);
1260 PRINT "<ENTER> when asked to enter the rating, and the computer will enter"
1270 PRINT TAB(TB);
1280 PRINT "typical ratings for you."
1290 PRINT
1300 PRINT TAB(TB);
1310 PRINT "These typical ratings will provide you with a starting point for"
1320 PRINT TAB(TB);
1330 PRINT "further experimentation."
1340 RETURN
1350 :REM'
1360 :REM'PRT
1370 KEY OFF:GOSUB 1440:LOCATE 25,5:COLOR 0,2
1380 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1390 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1400 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1400 :ELSE GOSUB 1440
1410 IF Z$="3"THEN RETURN
1420 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1430 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1370
1440 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
