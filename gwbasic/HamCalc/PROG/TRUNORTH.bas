10 :REM'TRUNORTH - True North Finder - 24 FEB 96 rev. 27 APR 2007
20 :REM'Ref. ARRL ANTENNA BOOK, 14th Edition, page 16-2
30 IF EX$=""THEN EX$="EXIT"
40 PROG$="trunorth"
50 COMMON EX$,PROG$,DMS
60 CLS:KEY OFF
70 COLOR 7,0,1
80 DIM M$(12)     :REM'month names
90 DIM C(36,3)    :REM'wobble factors
100 U$="#####"
110 UL$=STRING$(80,205)
120 :REM'
130 DATA Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
140 FOR Z=1 TO 12:READ M$(Z):NEXT Z
150 :REM'
160 :REM'.....wobble correction factors
170 DATA  4,8,11,  13,14,14,  13,10,8,  4,1,-1,       -3,-4,-4,     -3,-1,1
180 DATA  4,5,6,   6,5,3,     1,-3,-7,  -10,-13,-15,  -16,-16,-14,  -11,-7,-2
190 Y=-9
200 FOR Z=1 TO 36
210    M=Z/3:IF M=INT(M) THEN C(Z,1)=M :ELSE C(Z,1)=INT(M)+1
220    Y=Y+10:C(Z,2)=Y
230    IF Y=21 THEN Y=-9
240  READ C(Z,3)
250 NEXT Z
260 :REM'
270 :REM'.....start
280 CLS
290 COLOR 15,2
300 PRINT " TRUE NORTH via the Sun";TAB(57)"by George Murphy VE3ERP ";
310 COLOR 1,0:PRINT STRING$(80,223);
320 COLOR 7,0
330 GOSUB 920   :REM'preface
340 COLOR 0,7
350 LOCATE 25,22:PRINT " Press 1 to continue or 0 to quit....";
360 COLOR 7,0
370 Z$=INKEY$:IF Z$=""THEN 370
380 IF Z$="0"THEN CLS:RUN EX$
390 IF Z$="1"THEN 420
400 GOTO 370
410 :REM'
420 COLOR 7,0:GOSUB 1510:LOCATE 24,2:COLOR 0,7
430 PRINT " Do you want to convert degree/minute/second values to decimal ";
440 PRINT "degrees? (y/n) ";
450 COLOR 7,0
460 Z$=INKEY$:IF Z$=""THEN 460
470 IF Z$="y"THEN CLS:DMS=1:CHAIN "equiv"
480 IF Z$="n"THEN 510
490 GOTO 460
500 :REM'
510 :REM'.....inputs
520 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
530 PRINT " ENTER: Your longitude in decimal degrees:"
540 PRINT "        (MINUS value if West, PLUS value if East)....";:INPUT DEG
550 DEG=-DEG
560 LN=CSRLIN-2:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE 3
570 IF SGN(DEG)=1 THEN L$="W":ELSE L$="E"
580 TIM=(-DEG-7.5!)/15
590 IF TIM=INT(TIM)THEN UTC=TIM :ELSE UTC=INT(TIM+1)     :REM'UTC differential
600 TIM=DEG/15          :REM'time in hours to centre of time zone
610 SN=TIM+12
620 T=INT(SN)*100+(SN-INT(SN))*60
630 T=INT(T+0.5!):T$=RIGHT$(STR$(T),LEN(STR$(T))-1)
640 IF LEN (T$)<4 THEN T$="0"+T$:GOTO 640
650 PRINT TAB(9)"At longitude";USING "####.#";ABS(DEG);:PRINT "°";L$;
660 PRINT " SOLAR NOON times throughout the year are:"
670 PRINT TAB(9)"(UTC = Universal Co-ordinated Time)   (LST = Local SOLAR Time)"
680 PRINT UL$;
690 :REM'
700 :REM'.....display
710    FOR Z=1 TO 18
720 N=SN+C(Z,3)/60:IF N>=1160 THEN N=N+40
730 IF N<0 THEN N=N+24
740 T=INT(N)*100+(N-INT(N))*60
750 T=INT(T+0.5!):T$=RIGHT$(STR$(T),LEN(STR$(T))-1)
760 IF LEN (T$)<4 THEN T$="0"+T$:GOTO 760
770 LST=T+UTC*100:IF LST>=2400 THEN LST=T-1200
780 PRINT TAB(6)M$(C(Z,1));USING "###";C(Z,2);
790 PRINT " @ ";T$;" UTC (";LST;"LST )";
800 :REM'
810 N=SN+C(Z+18,3)/60:IF N>=1160 THEN N=N+40
820 IF N<0 THEN N=N+24
830 T=INT(N)*100+(N-INT(N))*60
840 T=INT(T+0.5!):T$=RIGHT$(STR$(T),LEN(STR$(T))-1)
850 IF LEN (T$)<4 THEN T$="0"+T$:GOTO 850
860 LST=T+UTC*100:IF LST>=2400 THEN LST=T-1200
870 PRINT TAB(47)M$(C(Z+18,1));USING "###";C(Z+18,2);
880 PRINT " @ ";T$;" UTC (";LST;"LST )"
890    NEXT Z
900 GOTO 1370
910 :REM'
920 :REM'.....preface
930 M=7
940 PRINT TAB(M);
950 PRINT "  The shadow of a vertically plumb stake cast by the sun at High"
960 PRINT TAB(M);
970 PRINT "Noon runs exactly north and south. This ancient axiom can be used to"
980 PRINT TAB(M);
990 PRINT "aim your antenna, orient a sundial, or calibrate your car compass."
1000 PRINT TAB(M);
1010 PRINT "  If the stake is north of lat. 23.5°N the shadow points north, if"
1020 PRINT TAB(M);
1030 PRINT "south of lat. 23.5°S, it points south. If the stake is between"
1040 PRINT TAB(M);
1050 PRINT "these latitudes and above the Equator the shadow points north in"
1060 PRINT TAB(M);
1070 PRINT "the winter and south in the summer. If south of the Equator it"
1080 PRINT TAB(M);
1090 PRINT "points north in the summer and south in the winter."
1100 PRINT TAB(M);
1110 PRINT"  To determine just when High Noon is, you must know your longitude."
1120 PRINT TAB(M);
1130 PRINT "This will tell you when High Noon is SUPPOSED to occur but doesn't,"
1140 PRINT TAB(M);
1150 PRINT "due to the somewhat complex wobbling of the earth about its axis as"
1160 PRINT TAB(M);
1170 PRINT "it circles the sun. Ancient mathematicians didn't know much about"
1180 PRINT TAB(M);
1190 PRINT "the wobble but we do, so we have to take it into account, which the"
1200 PRINT TAB(M);
1210 PRINT "program does."
1220 PRINT TAB(M);
1230 PRINT "  The program refers to High Noon as SOLAR NOON (it sounds more"
1240 PRINT TAB(M);
1250 PRINT "High Tech). Local SOLAR (geophysical) TIMES shown may not be the"
1260 PRINT TAB(M);
1270 PRINT "same as STANDARD (political) TIMES in some political jurisdictions,"
1280 PRINT TAB(M);
1290 PRINT "and are dependent on your distance east or west of longitude 0.00°"
1300 PRINT TAB(M);
1310 PRINT "or the nearest multiple of 15 degrees of longitude."
1320 PRINT
1330 PRINT TAB(M);
1340 PRINT "  Your longitude must be entered in decimal degrees."
1350 RETURN
1360 :REM'
1370 :REM'.....end
1380 GOSUB 1420
1390 GOTO 270
1400 END
1410 :REM'
1420 :REM'.....PRT
1440 KEY OFF:GOSUB 1510:LOCATE 25,5:COLOR 0,2
1450 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1460 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1470 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1470 :ELSE GOSUB 1510
1480 IF Z$="3"THEN RETURN
1490 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1500 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1440
1510 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
