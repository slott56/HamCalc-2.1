10 :REM'CUSTOHM - 10 AUG 92 rev. 20 NOV 2008
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON PROG$,EX$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 UL$=STRING$(80,205)
80 U$="##,###"
90 U1$="##"
100 U2$="#####,###.##"
110 U3$="#####.#"
120 U4$="####.#"
130 O$=CHR$(234)     :REM'omega
140 DIM Q(20,3)      :REM'quantity,value,net resistance
150 DIM R(24)        :REM'24 combinations
160 DIM C$(10)       :REM'colour codes
170 :REM'.....standard 5% resistors
180 DATA 1,1.1,1.2,1.3,1.5,1.6,1.8,2.0,2.2,2.4,2.7,3
190 DATA 3.3,3.6,3.9,4.3,4.7,5.1,5.6,6.2,6.8,7.5,8.2,9.1
200 FOR Z=1 TO 24
210 READ R(Z)
220 NEXT Z
230 :REM'.....colour codes
240 DATA Blk,Brn,Red,Orn,Yel,Grn,Blu,Vio,Gry,Wht
250 FOR Z=O TO 9
260 READ C$(Z)
270 NEXT Z
280 :REM'
290 :REM'.....menu
300 CLS
310 COLOR 15,2
320 PRINT " RESISTORS in PARALLEL";TAB(57);"by George Murphy VE3ERP ";
330 COLOR 7,0:PRINT STRING$(80,205);
340 :REM'COLOR 7,0
350 IF RC<>0 THEN 500
360 T=8      :REM'tab for text
370 GOSUB 1250
380 COLOR 0,7:LOCATE CSRLIN+1,22
390 PRINT " Press 1 to continue or 0 to EXIT....."
400 COLOR 7,0
410 Z$=INKEY$:IF Z$=""THEN 410
420 IF Z$="0"THEN CLS:CHAIN GO$
430 IF Z$="1"THEN 450
440 GOTO 410
450 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
460 :REM'
470 INPUT " ENTER: Value of custom resistor (ohms).......";RC
480 LOCATE CSRLIN-1
490 :REM'
500 :REM'.....calculate resistor banks
510 N=0
520 FOR Y=1 TO 10            :REM'no. of resistors loop
530  RX=RC*Y                 :REM'value of resistor
540  M=1                     :REM'multiplier
550   FOR Z=1 TO 24
560    IF R(Z)*M>RX THEN 610
570   NEXT Z
580  M=M*10
590  GOTO 550
600 :REM'
610  R1=R(Z-1)*M                      :REM'next lower resistor
620  IF Z=1 THEN R1=R(12)*M/10
630  N=N+1                            :REM'counter
640  Q(N,1)=Y                         :REM'quantity of resistors in bank
650  Q(N,2)=R1                        :REM'value of each resistor
660  Q(N,3)=R1/Y                      :REM'net resistance of resistor bank
670 :REM'
680  R2=R(Z)*M                        :REM'next higher resistor
690  N=N+1                            :REM'counter
700  Q(N,1)=Y                         :REM'quantity of resistors in bank
710  Q(N,2)=R2                        :REM'value of each resistor
720  Q(N,3)=R2/Y                      :REM'net resistance of resistor bank
730 NEXT Y
740 :REM'
750 :REM'******START SORT******
760 SN=N
770 SM=SN
780 SM=INT(SM/2):IF SM=0 THEN 870
790 SK=SN-SM:SJ=1
800 SI=SJ
810 SL=SI+SM
820 IF Q(SI,3)<=Q(SL,3)THEN 850
830 FOR A=1 TO 3:SWAP Q(SI,A),Q(SL,A):NEXT A
840 SI=SI-SM:IF SI>0 THEN 810
850 SJ=SJ+1:IF SJ>SK THEN 780
860 GOTO 800
870 :REM'******SORT COMPLETED******
880 :REM'
890 :REM'....display data
900 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
910 FOR Z=1 TO N
920  PC=ABS(Q(Z,3)-RC)/RC*100                   :REM'% off target
930  IF Q(Z,1)=1 THEN P$=STRING$(13,32)+"=":ELSE P$=" in parallel ="
940  IF Q(Z-1,3)<=RC AND Q(Z,3)>RC THEN GOSUB 1520
950  IF PC<=5 THEN COLOR 15,2 :ELSE COLOR 7,0
960 PRINT TAB(3);
970  PRINT USING U1$;Q(Z,1);                    :REM'print quantity
980  R=Q(Z,2):V$=O$                             :REM'value
990   R$=STR$(R)
1000   L$=STR$(LEN(R$)-3)
1010   Q$=LEFT$(R$,2):GOSUB 1190:C1$=C$
1020   Q$=MID$(R$,3,1):GOSUB 1190:C2$=C$
1030   Q$=LEFT$(L$,2):GOSUB 1190:C3$=C$
1040   CC$=C1$+"/"+C2$+"/"+C3$
1050  IF R>=10000.0! THEN R=R/1000.0!:V$="K"
1060  IF R<10 THEN X$=U4$ :ELSE X$=U$
1070  PRINT"  @";USING X$;R;                     :REM'print value
1080  PRINT " ";V$;P$;
1090  PRINT USING U2$;Q(Z,3);:PRINT " ";O$;      :REM'print net resistance of bank
1100  IF Q(Z,3)=RC THEN PRINT "      ON TARGET !";:GOTO 1120
1110  PRINT USING U3$;PC;:PRINT " % off target"; :REM'discrepancy
1120 IF R<10 THEN CC$="     -     "
1130 PRINT TAB(68);CC$
1140 NEXT Z
1150 PRINT UL$;
1160 GOSUB 1650             :REM'screen dump
1170 IF PROG$="" THEN RC=0:GOTO 290 :ELSE CLS:CHAIN PROG$
1180 :REM'
1190 :REM'.....calculate colour code
1200 FOR CC=0 TO 9
1210 IF CC=VAL(Q$)THEN C$=C$(CC):GOTO 1230
1220 NEXT CC
1230 RETURN
1240 :REM'
1250 :REM'.....text page
1260 PRINT TAB(T);
1270 PRINT "This program designs custom resistors that will be very close to"
1280 PRINT TAB(T);
1290 PRINT "almost any reasonable value, using standard common resistors"
1300 PRINT TAB(T);
1310 PRINT "connected in parallel."
1320 PRINT
1330 PRINT TAB(T);
1340 PRINT "The program calculates several combinations of resistors, any of"
1350 PRINT TAB(T);
1360 PRINT "which will provide a net resistance close to your target value."
1370 PRINT
1380 PRINT TAB(T);
1390 PRINT "Each combination displayed shows what percentage it is off the"
1400 PRINT TAB(T);
1410 PRINT "target resistance. Combinations within 5% of the target value"
1420 PRINT TAB(T);
1430 PRINT "are high-lighted."
1440 IF RC<>0 THEN 1500
1450 PRINT
1460 PRINT TAB(T);
1470 PRINT "Just enter the value of the custom resistor you want and the"
1480 PRINT TAB(T);
1490 PRINT "computer will do the rest !"
1500 RETURN
1510 :REM'
1520 :REM'.....hi-lite sought resistance
1530 COLOR 14,4
1540 PRINT " TARGET RESISTANCE";
1550 PRINT STRING$(11,".");USING U2$;RC;
1560 PRINT " ";O$;
1570  FOR L=1 TO 80
1580  Y=SCREEN(CSRLIN,L)
1590  IF Y=234 THEN 1610
1600  NEXT L
1610  PRINT STRING$(78-L,32);
1620 COLOR 7,0
1630 RETURN
1640 :REM'
1650 :REM'PRT
1660 KEY OFF:GOSUB 1730:LOCATE 25,5:COLOR 0,2
1670 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1680 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1690 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1690 :ELSE GOSUB 1730
1700 IF Z$="3"THEN RETURN
1710 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1720 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1660
1730 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
