10 :REM'CALTODAY - 28 APR 89 rev. 06 JAN 03
20 :REM'Adapted from "How to Program Your IBM PC", by Carl Shipman
30 :REM'Published by Knight-Ridder Press        ISBN:0-89586-544-0
40 :REM'Library of Congress Catalog No. 83-81692
50 :REM'
60 IF EX$=""THEN EX$="\hamcalc\prog\EXIT"
70 COMMON EX$
80 CLS:KEY OFF
90 COLOR 7,0,0
100 :REM'
110 DIM LKUP$(12,2)
120 UL$=STRING$(80,205)
130 RESTORE
140 DATA JANUARY,31,FEBRUARY,28,MARCH,31,APRIL,30,MAY,31,JUNE,30
150 DATA JULY,31,AUGUST,31,SEPTEMBER,30,OCTOBER,31,NOVEMBER,30,DECEMBER,31
160 FOR J=1 TO 12:FOR K=1 TO 2
170 READ LKUP$(J,K)
180 NEXT K:NEXT J
190 :REM'
200 LIN=-11                      :REM'base line no.
210  FOR ABC=1 TO 3
220 IF ABC=1 THEN MGN=24         :REM'left margin - this month
230 IF ABC=2 THEN MGN=4          :REM'left margin - last month
240 IF ABC=3 THEN MGN=44         :REM'left margin - next month
250 Z$=DATE$                     :REM'current date
260 :REM'
270 MNUM%=VAL(LEFT$(DATE$,2))    :REM'current month no.
280 IF ABC=1 THEN 320
290 IF ABC=2 THEN MNUM%=MNUM%-1  :REM'last month no.
300 IF ABC=3 THEN MNUM%=MNUM%+1  :REM'next month no.
310 :REM'
320 DAY%=VAL(MID$(DATE$,4,2))    :REM'current day no.
330 IF ABC=2 THEN DAY%=1
340 :REM'
350 Y#=VAL(RIGHT$(DATE$,4))      :REM'current year no.
360 IF MNUM%>12 THEN MNUM%=1:Y#=Y#+1   :REM'next month no. next year
370 IF MNUM%<1 THEN MNUM%=12:Y#=Y#-1   :REM'last month no. last year
380 IF Q$<>""THEN 640
390 :REM'
400 :REM'.....start
410 PRINT " Press number in < > for:"
420 PRINT UL$;
430 PRINT "  < 1 >  Current 3 months"
440 PRINT "  < 2 >  Any month of any year after 1752"
450 PRINT "  < 3 >  12 month calendar for any year after 1752"
460 PRINT "  < 4 >  Count days between dates"
470 PRINT "  < 5 >  Sunrise/Sunset calendar"
480 PRINT UL$;
490 PRINT "  < 0 >  EXIT"
500 Q$=INKEY$
510 IF Q$="0"THEN CLS:RUN EX$
520 IF Q$="1"THEN CLS:GOTO 640
530 IF Q$="2"THEN CLS:GOTO 590
540 IF Q$="3"THEN CLS:GOTO 1430
550 IF Q$="4"THEN CLS:CHAIN"days"
560 IF Q$="5"THEN CLS:CHAIN"sunup"
570 GOTO 500
580 :REM'
590 INPUT " ENTER: Year.............";Y#
600 IF Y#<1753 THEN 2230
610 INPUT " ENTER: Month number.....";MNUM%
620 CLS
630 :REM'
640 :REM'.....look up data
650 COLOR 7,0,0
660 M$=LKUP$(MNUM%,1)            :REM'month name
670 MY$=M$+STR$(Y#)              :REM'month, year
680 ND%=VAL(LKUP$(MNUM%,2))      :REM'number of days in month
690 :REM'
700 :REM'....calculate calendar
710 FLEAP%=0                             :REM'flag
720 IF Y# MOD 400=0 THEN 750             :REM'leap year
730 IF Y# MOD 100=0 THEN 770             :REM'not leap year
740 IF Y# MOD 4<>0  THEN 770             :REM'not leap year
750 FLEAP%=1:IF ND%=28 THEN ND%=29       :REM'add day to Feb.if leap year
760 :REM'....get days in prior years
770 YDAYS=365*Y#+INT((Y#-1)/4)-INT(0.75!*(INT((Y#-1)/100)+1))
780 :REM'....add days in prior months this year
790 MDAYS=0
800 FOR I=1 TO MNUM%-1:MDAYS=MDAYS+VAL(LKUP$(I,2)):NEXT I
810 :REM'....add 1st day, this month
820 DAYS=YDAYS+MDAYS+1
830 :REM'....if leap year add leap day
840 IF FLEAP%=1 AND MNUM%>2 THEN DAYS=DAYS+1
850 DW%=DAYS+INT(-DAYS/7)*7+6:            :REM'calculate dayweek factor
860 :REM'
870 :REM'....display calendar
880 IF ABC=3 THEN LIN=1
890 LIN=LIN+12
900 COLOR 0,7
910 LOCATE LIN,MGN-1
920 PRINT CHR$(221);                  :REM'left border
930 LOCATE LIN,MGN
940 PRINT SPC(35);CHR$(222)           :REM'background & right border
950 T=INT((35-LEN(MY$))/2)
960 LOCATE LIN,MGN+T
970 PRINT MY$
980 LOCATE LIN+1,MGN-1
990 COLOR 0,7:PRINT CHR$(221);        :REM'left border
1000 COLOR 10,12
1010 PRINT " SUN  MON  TUE  WED  THU  FRI  SAT ";
1020 COLOR 0,7:PRINT CHR$(222)         :REM'right border
1030 CS%=1                             :REM'counts spaces
1040 :REM'
1050 :REM'.....blank background
1060 FOR Z=LIN+2 TO LIN+8
1070 LOCATE Z,MGN-1:COLOR 0,7:PRINT CHR$(221);
1080 COLOR 0,6:PRINT SPC(35);
1090 COLOR 0,7:PRINT CHR$(222)
1100 NEXT Z
1110 :REM'
1120 :REM'.....print days
1130 FOR R%=LIN+2 TO LIN+8             :REM'row
1140 FOR C%=1 TO 31 STEP 5             :REM'column
1150 CD%=CS%-DW%
1160 IF ABC=2 OR ABC=3 THEN 1190
1170 IF Q$="2"THEN COLOR 15,6:GOTO 1190
1180 IF CD%=DAY% THEN COLOR 15,3 :ELSE COLOR 15,6   :REM'hi-lite today's date
1190 :REM'....CD%=dates, ND%=days in month
1200 IF CD%<1 OR CD%>ND% THEN 1260     :REM'bad dates
1210 CD$=STR$(CD%)
1220 IF LEN(CD$)<3 THEN CD$=" "+CD$
1230 CD$=CD$+" "
1240 IF ABC=2 OR ABC=3 THEN COLOR 15,6
1250 LOCATE R%,C%+MGN:PRINT CD$
1260 CS%=CS%+1
1270 NEXT C%
1280 NEXT R%
1290 COLOR 0,7
1300 LOCATE LIN+8,MGN-1
1310 PRINT CHR$(221);                  :REM'left border
1320 PRINT SPC(35);CHR$(222)           :REM'background & right border
1330 IF Q$="2"THEN COLOR 7,0:GOTO 1410      :REM'single month display
1340 IF ABC=1 THEN MO$="THIS"
1350 IF ABC=2 THEN MO$="LAST"
1360 IF ABC=3 THEN MO$="NEXT"
1370 LOCATE CSRLIN-1,MGN+13
1380 PRINT MO$;" MONTH"
1390 COLOR 7,0
1400 NEXT ABC
1410 GOTO 2200                         :REM'screen dump
1420 :REM'
1430 :REM'.....12 month calendar
1440 CLS
1450 INPUT " ENTER: Year (yyyy).........";Y$
1460 IF VAL(Y$)<1753 THEN 2230
1470 IF LEN(Y$)<>4 THEN 1450
1480 Y%=VAL(Y$)
1490 CLS
1500 :REM'
1510 :REM'....calculate calendar
1520 FOR MON=1 TO 12:MNUM%=MON            :REM'month number
1530 M$=LKUP$(MNUM%,1)                    :REM'month name
1540 MY$=M$+STR$(Y%)                      :REM'month, year
1550 ND%=VAL(LKUP$(MNUM%,2))              :REM'number of days in month
1560 FLEAP%=0:                            :REM'flag
1570 IF Y% MOD 400=0 THEN 1600             :REM'leap year
1580 IF Y% MOD 100=0 THEN 1630             :REM'not leap year
1590 IF Y% MOD 4<>0  THEN 1630             :REM'not leap year
1600 FLEAP%=1: IF ND%=28 THEN ND%=29      :REM'add day to Feb.if leap year
1610 :REM'
1620 :REM'....get days in prior years
1630    YDAYS=365*Y%+INT((Y%-1)/4)-INT(0.75!*(INT((Y%-1)/100)+1))
1640 :REM'
1650 :REM'....add days in prior months this year
1660    MDAYS=0
1670     FOR I=1 TO MNUM%-1
1680      MDAYS=MDAYS+VAL(LKUP$(I,2))
1690     NEXT I
1700 :REM'
1710 :REM'....add 1st day, this month
1720    DAYS=YDAYS+MDAYS+1
1730 :REM'
1740 :REM'....if leap year add leap day
1750    IF FLEAP%=1 AND MNUM%>2 THEN DAYS=DAYS+1
1760    DW%=DAYS+INT(-DAYS/7)*7+6:            :REM'calculate dayweek factor
1770 :REM'
1780 :REM'....display calendar
1790 DATA 1,5,1,30,1,55
1800 DATA 9,5,9,30,9,55
1810 DATA 17,5,17,30,17,55
1820 DATA 1,5,1,30,1,55
1830 READ LIN,COL
1840 COLOR 0,7
1850 LOCATE LIN,COL
1860 PRINT SPC(22)
1870 T=INT((22-LEN(MY$))/2)
1880 LOCATE LIN,COL+T
1890 PRINT MY$
1900 COLOR 10,12
1910 LOCATE LIN+1,COL
1920 PRINT " SU MO TU WE TH FR SA ";
1930 CS%=1                             :REM'counts spaces
1940 :REM'
1950 COLOR 0,1
1960  FOR BGC=2 TO 7
1970   LOCATE LIN+BGC,COL
1980   PRINT SPC(22)         :REM'B/G colour
1990  NEXT BGC
2000 :REM'
2010 FOR R%=LIN+2 TO LIN+8
2020  FOR C%=COL+1 TO COL+21 STEP 3    :REM'column
2030  CD%=CS%-DW%
2040  :REM'.....CD%=DATES, ND%=DAYS IN MONTH
2050  IF CD%<1 OR CD%>ND% THEN 2120    :REM'bad dates
2060  CD$=STR$(CD%)
2070  CD$=RIGHT$(CD$,LEN(CD$)-1)       :REM'remove blank space
2080  IF LEN(CD$)<2 THEN CD$=" "+CD$
2090  LOCATE R%,C%
2100  COLOR 15,1
2110  PRINT CD$;
2120  CS%=CS%+1
2130  NEXT C%
2140 LN=LN+1
2150 IF LN=63 THEN COLOR 7,0:GOSUB 2320:CLS:LN=0:GOTO 2160
2160 NEXT R%
2170 COLOR 7,0:NEXT MON
2180 GOTO 2200
2190 :REM'
2200 :REM'.....end
2210 GOSUB 2320:CLS:Q$="":GOTO 200
2220 :REM'
2230 :REM'.....year before 1753
2240 BEEP:PRINT
2250 PRINT " Cannot calculate years earlier than 1753,"
2260 PRINT " when the Georgian Calendar was adopted."
2270 PRINT
2280 PRINT " Press any key to start over......."
2290 IF INKEY$=""THEN 2290
2300 CLS:GOTO 200
2310 :REM'
2320 :REM'PRT
2330 KEY OFF:GOSUB 2400:LOCATE 25,5:COLOR 0,2
2340 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2350 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2360 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2360 :ELSE GOSUB 2400
2370 IF Z$="3"THEN RETURN
2380 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2390 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2330
2400 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
