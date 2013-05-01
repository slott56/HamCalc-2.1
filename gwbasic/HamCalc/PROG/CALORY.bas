10 :REM'CALORY - Calorie Calculator - 12 SEP 2002 - rev. 10 JUL 2009
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$
50 UL$=STRING$(80,205)
60 A1$="sedentary        ":A2$="normally active  ":A3$="quite active    "
70 A4$="very active      ":A5$="constantly active"
80 DIM DN$(365)
90 FOR Z=1 TO 365
100 IF Z>334 THEN DN$(Z)="Dec"+STR$(Z-334):GOTO 230
110 IF Z>304 THEN DN$(Z)="Nov"+STR$(Z-304):GOTO 230
120 IF Z>273 THEN DN$(Z)="Oct"+STR$(Z-273):GOTO 230
130 IF Z>243 THEN DN$(Z)="Sep"+STR$(Z-243):GOTO 230
140 IF Z>212 THEN DN$(Z)="Aug"+STR$(Z-212):GOTO 230
150 IF Z>181 THEN DN$(Z)="Jul"+STR$(Z-181):GOTO 230
160 IF Z>151 THEN DN$(Z)="Jun"+STR$(Z-151):GOTO 230
170 IF Z>120 THEN DN$(Z)="May"+STR$(Z-120):GOTO 230
180 IF Z> 90 THEN DN$(Z)="Apr"+STR$(Z-90):GOTO 230
190 IF Z> 59 THEN DN$(Z)="Mar"+STR$(Z-59):GOTO 230
200 IF Z> 31 THEN DN$(Z)="Feb"+STR$(Z-31):GOTO 230
210 IF Z>  1 THEN DN$(Z)="Jan"+STR$(Z):GOTO 230
220 IF Z=  1 THEN DN$(Z)="Jan 1"
230 NEXT Z
240 DATA Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec
250 DIM MO$(12)
260 FOR Z=1 TO 12:READ MO$(Z):NEXT Z
270 RESTORE
280 :REM'.....title page
290 COLOR 0,7
300 PRINT
310 PRINT " CALORIE COUNTER ";
320 COLOR 7,0:PRINT TAB(23)"Press 1 to continue or 0 to EXIT."
330 Z$=INKEY$
340 IF Z$="1"THEN CLS:GOTO 370
350 IF Z$="0"THEN CLS:RUN EX$
360 GOTO 330
370 :REM'.....start
380 COLOR 7,0,1
390 PRINT
400 LOCATE ,31:COLOR 0,7:PRINT " CALORIE COUNTER ":COLOR 7,0
410 PRINT
420 T=7
430 PRINT TAB(T);
440 PRINT "No attempt to control your weight should be undertaken without the"
450 PRINT TAB(T);
460 PRINT "the approval of your physician. However, many diet plans involve"
470 PRINT TAB(T);
480 PRINT "the tedious task of counting calories, which this program can help"
490 PRINT TAB(T);
500 PRINT "you do."
510 PRINT
520 PRINT TAB(T);
530 PRINT "Ref: The Joy of Cooking by Irma S. Rombauer and Marion Rombauer";
540 PRINT TAB(T);
550 PRINT "Becker, 31st printing, Nov.1983, Bobbs-Merrill Co.Inc., pp 1-14."
560 PRINT
570 PRINT UL$;
580 PRINT TAB(15)"  Press letter in ( ) to indicate your activity level:"
590 PRINT UL$;
600 PRINT TAB(10)"  (a)  ";A1$;TAB(38)"(e.g. invalid, bedridden)"
610 PRINT TAB(10)"  (b)  ";A2$;TAB(38)"(e.g. housewife, office worker)"
620 PRINT TAB(10)"  (c)  ";A3$;TAB(38)"(e.g. deliveryman, construction worker)"
630 PRINT TAB(10)"  (d)  ";A4$;TAB(38)"(e.g. daily exerciser, very athletic)"
640 PRINT TAB(10)"  (e)  ";A5$;TAB(38)"(e.g. professional athlete in training)"
650 PRINT TAB(10)"   or"
660 PRINT TAB(10)"  (x)  to EXIT program"
670 Z$=INKEY$
680 IF Z$="a"OR Z$="A"THEN X=1  :A$=A1$:GOTO 750
690 IF Z$="b"OR Z$="B"THEN X=1.2000000476837158!:A$=A2$:GOTO 750
700 IF Z$="c"OR Z$="C"THEN X=1.2999999523162842!:A$=A3$:GOTO 750
710 IF Z$="d"OR Z$="D"THEN X=1.399999976158142!:A$=A4$:GOTO 750
720 IF Z$="e"OR Z$="E"THEN X=1.5!:A$=A5$:GOTO 750
730 IF Z$="x"OR Z$="X"THEN CLS:CHAIN EX$
740 GOTO 670
750 :REM'.....inputs
760 CLS:COLOR 7,0,0
770 PRINT
780 PRINT " Want weight in (k)ilograms or (p)ounds?   (k/p)"
790 Z$=INKEY$:IF Z$=""THEN 790
800 IF Z$="k"THEN KP=2.2046000957489014!:KP$="kg.":GOTO 830
810 IF Z$="p"THEN KP=1:    KP$="lb." :GOTO 830
820 GOTO 790
830 CLS
840 PRINT
850 PRINT " When do you want to start the diet?"
860 PRINT
870 INPUT " ENTER: Start Month No. ........";S:IF S=0 OR S>12 THEN 870
880 INPUT " ENTER: Start Day No. ..........";T:IF T=0 OR T>31 THEN 880
890 M1$=MO$(S)+STR$(T)     :REM'start date
900 :REM'.....display
910 CLS:PRINT :COLOR 0,7:PRINT " Start date ";M1$;" ":COLOR 7,0
920 IF D=0 THEN PRINT " ENTER: Starting weight (";KP$;") ...";:INPUT Z:D=Z*KP
930 IF F=0 THEN PRINT " ENTER: Target weight (";KP$;") .....";:INPUT Z:F=Z*KP
940 IF F<D THEN 960
950 LOCATE CSRLIN-1:PRINT STRING$(80,32);:F=0:GOTO 930
960 VIEW PRINT 2 TO 24:CLS:VIEW PRINT:LOCATE 2
970 PRINT USING " Starting weight ........ ###.# ";D/KP;:PRINT KP$
980 PRINT USING " Target weight .......... ###.# ";F/KP;:PRINT KP$
990 PRINT UL$;
1000 :REM'.....display
1010 E=CINT(14*D*X)
1020 PRINT " You are currently eating an average of";E;"calories per day and";
1030 PRINT " you are"
1040 PRINT " ";A$
1050 PRINT UL$;
1060 PRINT " Press number in ( ) to select next step:"
1070 PRINT UL$;
1080 PRINT " (1) Find a target date based on a fixed daily calorie intake"
1090 PRINT " (2) Find a daily calorie intake based on an approximate target date"
1100 PRINT " (3) Quit"
1110 PRINT UL$;
1120 Z$=INKEY$
1130 IF Z$="1"THEN 1170
1140 IF Z$="2"THEN 1500
1150 IF Z$="3"THEN CLS:GOTO 370
1160 GOTO 1120
1170 :REM'.....find target date
1180 CLS:LOCATE 2
1190 LN=CSRLIN:COLOR 0,7
1200 PRINT" Daily intake must be within the range of 500 -";E;"calories."
1210 COLOR 7,0:PRINT:LN=CSRLIN
1220 INPUT " ENTER: Calories per day ....";M
1230 IF M<=E AND M>=500 THEN 1250
1240 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 1220
1250 FOR Z=1 TO 365:IF DN$(Z)=M1$ THEN 1270
1260 NEXT Z
1270 C=Z        :REM'start day number
1280 L=0        :REM'day number
1290 FC=F*14*X  :REM'target calories
1300 WT=E       :REM'body maintenance at start
1310 :REM'.....calculate
1320 L=L+1:IF L>365 THEN 1450
1330 WT=WT-(WT-M)/(14*X)^2:W=WT/(14*X)
1340 IF WT<FC THEN 1360
1350 GOTO 1320
1360 K=C+L  :REM' C=start day, L=no. of days, K=end day
1370 IF K>365 THEN K=K-365:GOTO 1370
1380 COLOR 0,7
1390 PRINT
1400 PRINT " Diet will last for about";L;"days, from ";DN$(C);" to ";DN$(K);" "
1410 PRINT :PRINT " Press any key to continue . . . ":COLOR 7,0
1420 IF INKEY$=""THEN 1420
1430 GOTO 1860
1440 :REM'.....display
1450 COLOR 0,7:PRINT " It would take more than a year ! "
1460 PRINT :PRINT " Press any key to continue . . . ":COLOR 7,0
1470 IF INKEY$=""THEN 1470
1480 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1490 GOTO 1220
1500 :REM'.....find daily diet calories
1510 FOR Z=1 TO 365:IF DN$(Z)=M1$ THEN 1530
1520 NEXT Z
1530 CS=Z:   :REM'start day number
1540 INPUT " ENTER: Target Month No. ........";U
1550 INPUT " ENTER: Target Day No. ..........";V
1560 M2$=MO$(U)+STR$(V)     :REM'end date
1570 FOR Z=1 TO 365:IF DN$(Z)=M2$ THEN 1600
1580 NEXT Z
1590 BEEP:COLOR 0,7:PRINT " DATE NOT VALID! ":COLOR 7,0:GOTO 1540
1600 CE=Z:   :REM'end day number
1610 VIEW PRINT 2 TO 24:CLS:VIEW PRINT:LOCATE 1,22
1620 L=CE-CS:IF L<0 THEN L=L+365
1630 FC=F*14*X    :REM'target calories
1640 WT=E         :REM'starting body maintenance
1650 M=0          :REM'daily diet calories
1660 DAY=0
1670 M=M+1
1680 :REM'.....calculate daily diet
1690 M=490:INC=10
1700 :REM'.....calculate
1710 M=M+INC
1720   FOR QQ=1 TO L
1730 WW=(WT-M)/(14*X)^2
1740 WT=WT-WW:W=WT/(14*X)
1750   NEXT QQ
1760 IF W<F THEN WT=E:GOTO 1710
1770 LOCATE 3:COLOR 7,0:PRINT STRING$(80,32);
1780 LOCATE 4:COLOR 0,7
1790 PRINT " Diet will last for about";L+1;
1800 PRINT "days, from ";DN$(CS);" to ";DN$(CE);" "
1810 PRINT
1820 COLOR 0,7:PRINT " Press any key to continue . . . ":COLOR 7,0
1830 IF INKEY$=""THEN 1830
1840 C=CS   :REM'start day number
1850 GOTO 1860
1860 :REM'.....chart
1870 V=INT(L/16):IF V=L/16 THEN 1880 :ELSE V=INT(L/16)+1
1880 CLS
1890 PRINT CINT(M);"Calorie Diet for a ";A$;" ";"person";
1900 PRINT ", charted at";V;"day intervals."
1910 PRINT TAB(13)"Date";TAB(25)"Weight";TAB(37);KP$;"/week";
1920 PRINT TAB(47);"Maintenance";TAB(60);KP$;"to date"
1930 PRINT UL$;
1940 LOCATE CSRLIN-1,47:PRINT " calories "
1950 W=D:CC=C:WC=0:LB=0:FLAG=0:IF CC=0 THEN CC=365
1960 GOSUB 2200  :REM'print one line
1970 :REM'.....calculate
1980 WT=E:W=0:VV=0
1990 FOR Z=0 TO L
2000 ZZ=WT:VV=VV+1
2010 WT=WT-(WT-M)/(14*X)^2:WC=(WT-ZZ)/(14*X):W=WT/(14*X)
2020 IF Z=2 THEN FLAG=WC*7
2030 CC=C+Z:LB=W-D:IF CC>365 THEN CC=CC-365
2040 IF VV=V THEN VV=0:GOSUB 2200
2050 NEXT Z
2060 IF VV=0 THEN 2090
2070 GOSUB 2200  :REM'print one line
2080 COLOR 0,7
2090 PRINT " It will take about";Z;"days to go from";CINT(E/(14*X)/KP);
2100 PRINT "to";CINT(W/KP);KP$;
2110 PRINT" After ";DN$(CC);" a diet of";CINT(14*W*X);"calories will ";
2120 PRINT "maintain about";CINT(F/KP);KP$;" if you remain ";A$;"   "
2130 COLOR 7,0
2140 PRINT UL$;
2150 IF ABS(FLAG/KP)<=2/KP THEN 2190
2160 COLOR 14,4:LOCATE CSRLIN-1,9
2170 PRINT USING " WARNING - IT MAY BE UNHEALTHY TO LOSE MORE THAN #.## ";2/KP;
2180 PRINT KP$;"/WEEK ":COLOR 7,0
2190 GOTO 2280     :REM'end
2200 :REM'.....print one line
2210 IF Z =CC THEN Z=0
2215 IF DN$(CC)=M1$ THEN Z=0
2220 PRINT " day";Z;
2230 PRINT TAB(12)DN$(CC);     :REM'date
2240 PRINT TAB(23)USING " ###.# ";W/KP;:PRINT KP$;
2250 PRINT TAB(38)USING " ##.##     ####.#    ####.## ";7*WC/KP,14*W*X,LB/KP;
2260 PRINT KP$
2270 RETURN
2280 :REM'.....end
2290 GOSUB 2300:GOTO 910
2300 :REM'.....PRT....print screen
2310 KEY OFF:GOSUB 2380:LOCATE 25,5:COLOR 0,2
2320 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2330 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2340 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2340 :ELSE GOSUB 2380
2350 IF Z$="3"THEN RETURN
2360 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2370 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2310
2380 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
2390 END
