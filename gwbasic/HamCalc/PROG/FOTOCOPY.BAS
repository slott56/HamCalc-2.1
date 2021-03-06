10 :REM'FOTOCOPY - image size calculator - 29 JAN 95 rev. 12 MAR 2000
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 DIM F$(16)
50 COLOR 15,1,4
60 UL$=STRING$(80,205)
70 T$=" PHOTOCOPIER IMAGE CALCULATOR "
80 ON ERROR  GOTO 110
90 GOTO 190
100 :REM'
110 :REM'.....error trap
120 CLS
130 IF ERR=25 THEN 140 :ELSE PRINT " ERROR ! .....press F2 to start over..":END
140 BEEP:LOCATE 12,12:COLOR 14,4
150 PRINT " Your printer is not ready. Press any key when ready......"
160 IF INKEY$=""THEN 160
170 COLOR 15,1:ERASE F$:FLAG=1:RESUME 10
180 :REM'
190 COLOR 15,4:PRINT UL$;
200 LOCATE 1,(80-LEN(T$))/2:PRINT T$
210 COLOR 4,1:PRINT STRING$(80,223);
220 COLOR 15,1
230 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3  :REM'add background color
240 IF FLAG THEN FLAG=0:GOTO 500    :REM'FLAG = printer error flag
250 :REM'
260 LOCATE 5,25:PRINT " Press number in < > to:"
270 LOCATE 7,25:PRINT " <1>  RUN program"
280 LOCATE 8,25:PRINT " <2>  QUIT"
290 Z$=INKEY$
300 IF Z$="1"THEN 340
310 IF Z$="2"THEN COLOR 7,0,0:CLS:RUN "fotomenu"
320 GOTO 290
330 :REM'
340 LOCATE 11,25:PRINT " Press number in < > to choose:"
350 LOCATE 13,25:PRINT " <3>  Data entry in MILLIMETRES"
360 LOCATE 14,25:PRINT " <4>  Data entry in INCHES"
370 Z$=INKEY$
380 IF Z$="3"THEN D=1:D$=" mm ":GOTO 420
390 IF Z$="4"THEN D=2:D$=" in.":GOTO 420
400 GOTO 370
410 :REM'
420 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
430 T=6
440 PRINT TAB(T);
450 PRINT"If the data requested is unknown press <ENTER> to bypass the question."
460 PRINT TAB(T);
470 PRINT"If the data is essential, you will be asked for it again."
480 PRINT UL$;
490 :REM'
500 :REM'.....fractions
510 DATA 1/16,1/8,3/16,1/4,5/16,3/8,7/16,1/2
520 DATA 9/16,5/8,11/16,3/4,13/16,7/8,15/16,1
530 FOR F=1 TO 16:READ F$:F$=F$+CHR$(34)
540 IF LEN(F$)<6 THEN F$=F$+" ":GOTO 540
550 F$(F)=F$+"= "
560 NEXT F
570 RESTORE
580 :REM'
590 LOCATE 14,24:PRINT "╔";STRING$(32,"═");"╗"
600 LOCATE 15,24:PRINT "║";STRING$(32," ");"║"
610 COLOR 0,7:LOCATE 15,25:PRINT "    DECIMAL INCH EQUIVALENTS    ":COLOR 15,1
620 FOR Z=1 TO 8
630 LOCATE Z+15,24:PRINT "║ ";F$(Z);USING "#.##";Z*0.0625!
640 LOCATE Z+15,44:PRINT F$(Z+8);USING "#.##";(Z+8)*0.0625!;
650 PRINT " ║"
660 NEXT Z
670 LOCATE 24,24:PRINT "╚";STRING$(32,"═");"╝";
680 LOCATE 5
690 GOTO 750
700 :REM'
710 :REM'.....erase input line
720 VIEW PRINT 6 TO 13:CLS:VIEW PRINT:LOCATE 6
730 RETURN
740 :REM'
750 :REM'.....input data
760 IF SO THEN 800
770 PRINT " ENTER: Length of SHORT side of SUBJECT area....(";D$;")";:INPUT SO
780 GOSUB 720:GOSUB 1030
790 :REM'
800 IF LO THEN 820
810 PRINT " ENTER: Length of LONG side of SUBJECT area.....(";D$;")";:INPUT LO
820 IF LO>0 AND SO=0 THEN GOSUB 720:GOTO 770
830 IF SO>0 AND LO=0 THEN GOSUB 720:GOTO 810
840 GOSUB 720:GOSUB 1030
850 :REM'
860 IF M THEN 900
870 INPUT " ENTER: Magnification % (if known)....................";M:M=M/100
880 GOSUB 720:GOSUB 1030
890 :REM'
900 IF SP THEN 940
910 PRINT " ENTER: Length of SHORT side of copy PAPER......(";D$;")";:INPUT SP
920 GOSUB 720:GOSUB 1030
930 :REM'
940 IF LP THEN 960
950 PRINT " ENTER: Length of LONG side of copy PAPER.......(";D$;")";:INPUT LP
960 IF LP>0 AND SP=0 THEN GOSUB 720:GOTO 910
970 IF SP>0 AND LP=0 THEN GOSUB 720:GOTO 950
980 GOSUB 720:GOSUB 1030
990 :REM'
1000 :REM'GOSUB 620:GOSUB 1020
1010 GOTO 770
1020 :REM'
1030 :REM'.....calculate
1040 IF SO*LO*M>0 THEN SI=SO*M:LI=LO*M:GOTO 1150
1050 IF SI*LI*M>0 THEN SO=SI/M:LO=LI/M:GOTO 1150
1060 IF SO*LO*SP*LP>0 AND M=0 THEN 1090
1070 RETURN
1080 :REM'
1090 :REM'.....fit image on paper
1100 M1=SP/SO:M2=LP/LO
1110 IF M1<=M2 THEN M=M1 :ELSE M=M2
1120 SI=SO*M:LI=LO*M
1130 GOTO 1150
1140 :REM'
1150 :REM'.....print data
1160 VIEW PRINT 3 TO 13:CLS:VIEW PRINT:LOCATE 3
1170 C=44   :REM'tab
1180 IF D$=" mm "THEN A$="####":B$="###.##":E$=" in.":E=0.03937000036239624!
1190 IF D$=" in."THEN A$="###.##":B$="####":E$=" mm ":E=25.399999618530273!
1200 :REM'
1210 PRINT " Size of SUBJECT area..";USING A$;SO;:PRINT " x";USING A$;LO;
1220 PRINT D$;" =";TAB(C)USING B$;SO*E;:PRINT " x";USING B$;LO*E;
1230 PRINT E$:PRINT
1240 :REM'
1250 PRINT " Magnification.........";USING "#####";M*100;:PRINT " %"
1260 PRINT
1270 :REM'
1280 IF SP*LP=0 THEN 1330
1290 PRINT " Size of copy PAPER....";USING A$;SP;:PRINT " x";USING A$;LP;
1300 PRINT D$;" =";TAB(C)USING B$;SP*E;:PRINT " x";USING B$;LP*E;
1310 PRINT E$:PRINT
1320 :REM'
1330 PRINT " Size of copied IMAGE..";USING A$;SI;:PRINT " x";USING A$;LI;
1340 PRINT D$;" =";TAB(C)USING B$;SI*E;:PRINT " x";USING B$;LI*E;
1350 PRINT E$:PRINT UL$;
1360 :REM'
1370 IF SP*LP=0 THEN 1610
1380 :REM'
1390 :REM'.....border option
1400 IF B THEN PRINT UL$;:GOTO 1520
1410 LOCATE 11:COLOR 0,7
1420 PRINT " Do you want to leave a border around the image? ";
1430 COLOR 16,7:PRINT " (y/n) "
1440 COLOR 15,1
1450 Z$=INKEY$
1460 IF Z$="y"OR Z$="Y"THEN 1500
1470 IF Z$="n"OR Z$="N"THEN LOCATE CSRLIN-1:PRINT STRING$(80,32);:GOTO 1610
1480 GOTO 1450
1490 :REM'
1500 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
1510 PRINT " ENTER: Width of border (";D$;")";:INPUT B
1520 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
1530 SB=SI-2*B:LB=LI-2*B:MB=SB/SO
1540 PRINT " To include a";USING A$;B;:PRINT D$;" border all around, copy ";
1550 PRINT "@";USING "####";MB*100;:PRINT " %"
1560 PRINT " IMAGE area will be....";USING A$;SB;:PRINT " x";USING A$;LB;
1570 PRINT D$;" =";TAB(C);USING B$;SB*E;:PRINT " x";USING B$;LB*E;
1580 PRINT E$
1590 PRINT UL$;
1600 :REM'
1610 :REM'.....end
1620 PRINT
1630 VIEW PRINT
1640 GOSUB 1680
1650 ERASE F$:B=0:M=0:SO=0:LO=0:SP=0:LP=0:SI=0:LI=0
1660 GOTO 10
1670 :REM'
1680 :REM'PRT
1690 KEY OFF:GOSUB 1760:LOCATE 25,5:COLOR 0,2
1700 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1710 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1720 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1720 :ELSE GOSUB 1760
1730 IF Z$="3"THEN RETURN
1740 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1750 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1690
1760 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
