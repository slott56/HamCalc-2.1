10 :REM'CUSTCAP - 09 sep 92 rev. 10 NOV 97
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,0
70 UL$=STRING$(80,205)
80 U$="####,###"
90 U1$="##"
100 U2$="###,###.##"
110 U3$="#####.#"
120 U4$="####.#"
130 DIM Q(20,3)      :REM'quantity,value,net capacitance
140 DIM R(24)        :REM'24 combinations
150 :REM'.....standard capacitor values
160 DATA 1,1.1,1.2,1.3,1.5,1.6,1.8,2.0,2.2,2.4,2.7,3
170 DATA 3.3,3.6,3.9,4.3,4.7,5.1,5.6,6.2,6.8,7.5,8.2,9.1
180 :REM'.....load data arrays
190 FOR Z=1 TO 24
200 READ R(Z)
210 NEXT Z
220 :REM'
230 :REM'.....start
240 CLS
250 COLOR 15,2
260 PRINT " CAPACITORS in PARALLEL";TAB(57);"by George Murphy VE3ERP ";
270 COLOR 1,0:PRINT STRING$(80,223);
280 COLOR 7,0
290 IF RC<>0 AND PROG$="3mbridge"THEN O$="pf":GOTO 570
300 T=(8)     :REM'tab for text
310 GOSUB 1310  :REM'text
320 PRINT
330 COLOR 0,7:LOCATE CSRLIN,22
340 PRINT " Press 1 to continue or 0 to EXIT....."
350 COLOR 7,0
360 Z$=INKEY$:IF Z$=""THEN 360
370 IF Z$="0"THEN CLS:CHAIN GO$
380 IF Z$="1"THEN 420
390 GOTO 360
400 :REM'
410 :REM'.....start
420 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
430 PRINT " Press number in < > to select capacitance unit:"
440 PRINT UL$;
450 PRINT "   <1> pF"
460 PRINT "   <2) µF"
470 PRINT UL$;
480 Z$=INKEY$:IF Z$=""THEN 480
490 IF Z$="1"THEN O$="pF":GOTO 530
500 IF Z$="2"THEN O$="µF":GOTO 530
510 GOTO 480
520 IF RC<>0 THEN 570
530 PRINT " ENTER: Value of custom capacitor (";O$;")";:INPUT RC
540 IF RC<1 AND O$="µF"THEN RC=RC*10^6:O$="pF"
550 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
560 :REM'
570 :REM'.....calculate capacitor banks
580 N=0
590 FOR Y=1 TO 10            :REM'no. of capacitors loop
600  RX=RC/Y                 :REM'value of capacitor
610  M=1                     :REM'multiplier
620   FOR Z=1 TO 24
630    IF R(Z)*M>RX THEN 680
640   NEXT Z
650  M=M*10
660  GOTO 620
670 :REM'
680  R1=R(Z-1)*M                      :REM'next lower capacitor
690  IF Z=1 THEN R1=R(12)*M/10
700  N=N+1                            :REM'counter
710  Q(N,1)=Y                         :REM'quantity of capacitors in bank
720  Q(N,2)=R1                        :REM'value of each capacitor
730  Q(N,3)=R1*Y                      :REM'net capacitance of capacitor bank
740 :REM'
750  R2=R(Z)*M                        :REM'next higher capacitor
760  N=N+1                            :REM'counter
770  Q(N,1)=Y                         :REM'quantity of capacitors in bank
780  Q(N,2)=R2                        :REM'value of each capacitor
790  Q(N,3)=R2*Y                      :REM'net capacitance of capacitor bank
800 NEXT Y
810 :REM'
820 :REM'******START SORT******
830 SN=N
840 SM=SN
850 SM=INT(SM/2):IF SM=0 THEN 940
860 SK=SN-SM:SJ=1
870 SI=SJ
880 SL=SI+SM
890 IF Q(SI,3)<=Q(SL,3)THEN 920
900 FOR A=1 TO 3:SWAP Q(SI,A),Q(SL,A):NEXT A
910 SI=SI-SM:IF SI>0 THEN 880
920 SJ=SJ+1:IF SJ>SK THEN 850
930 GOTO 870
940 :REM'******SORT COMPLETED******
950 :REM'
960 :REM'....display data
970 FOR Z=1 TO N
980  PC=ABS(Q(Z,3)-RC)/RC*100                   :REM'% off target
990  IF Q(Z,1)=1 THEN P$=STRING$(13,32)+"="::ELSE P$=" in parallel ="
1000  IF Q(Z-1,3)<=RC AND Q(Z,3)>RC THEN GOSUB 1230
1010  IF PC<=5 THEN COLOR 15,2 :ELSE COLOR 7,0
1020 PRINT TAB(3);
1030  PRINT USING U1$;Q(Z,1);                    :REM'print quantity
1040  R=Q(Z,2):V$=O$                             :REM'value
1050   R$=STR$(R)
1060   L$=STR$(LEN(R$)-3)
1070   Q$=LEFT$(R$,2)
1080   Q$=MID$(R$,3,1)
1090   Q$=LEFT$(L$,2)
1100  IF R<10 THEN X$=U4$ :ELSE X$=U$
1110 IF RC<100 THEN U$="######.#"
1120  PRINT"  @";USING U$;R;                     :REM'print value
1130  PRINT " ";V$;P$;
1140  PRINT USING U2$;Q(Z,3);:PRINT " ";O$;      :REM'print net capacitance of bank
1150  IF Q(Z,3)=RC THEN PRINT "      ON TARGET !   ":GOTO 1170
1160  PRINT USING U3$;PC;:PRINT " % off target"  :REM'discrepancy
1170 NEXT Z
1180 COLOR 7,0
1190 PRINT UL$;
1200 GOSUB 1580             :REM'screen dump
1210 IF PROG$=""THEN RC=0:GOTO 230 :ELSE CLS:CHAIN PROG$
1220 :REM'
1230 :REM'.....hi-lite sought resistance
1240 COLOR 14,4
1250 PRINT " TARGET CAPACITANCE";
1260 PRINT STRING$(13,".");USING U2$;RC;
1270 PRINT " ";O$;STRING$(20,32)
1280 COLOR 7,0
1290 RETURN
1300 :REM'
1310 :REM'.....text page
1320 PRINT TAB(T);
1330 PRINT "This program designs custom capacitors that will be very close to"
1340 PRINT TAB(T);
1350 PRINT "almost any reasonable value, using standard common capacitors"
1360 PRINT TAB(T);
1370 PRINT "connected in parallel."
1380 PRINT
1390 PRINT TAB(T);
1400 PRINT "The program calculates several combinations of capacitors, any of"
1410 PRINT TAB(T);
1420 PRINT "which will provide a net capacitance close to your target value."
1430 PRINT
1440 PRINT TAB(T);
1450 PRINT "Each combination displayed shows what percentage it is off the"
1460 PRINT TAB(T);
1470 PRINT "target capacitance. Combinations within 5% of the target value"
1480 PRINT TAB(T);
1490 PRINT "are high-lighted."
1500 IF RC<>0 THEN 1560
1510 PRINT
1520 PRINT TAB(T);
1530 PRINT "Just enter the value of the custom capacitor you want and the"
1540 PRINT TAB(T);
1550 PRINT "computer will do the rest !"
1560 RETURN
1570 :REM'
1580 :REM'PRT
1590 KEY OFF:GOSUB 1660:LOCATE 25,5:COLOR 0,2
1600 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1610 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1620 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1620 :ELSE GOSUB 1660
1630 IF Z$="3"THEN RETURN
1640 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1650 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1590
1660 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
