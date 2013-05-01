10 :REM'TIMEZONE - Time Zones - 09 MAR 96 rev. 12 DEC 1997
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 DIM P$(24)
70 DATA ADAK (ALASKA) & AUCKLAND,NEW CALEDONIA,PAPUA & SAIPAN
80 DATA VLADIVOSTOK & ADELAIDE,SHANGHAI & MAYLASIA,CHRISTMAS ISLAND & CHUNKING
90 DATA BANGLADESH & RANGOON,PAKISTAN & MUMBAI,OMAN & KANDAHAR
100 DATA KUWAIT & MADAGASCAR,CAIRO & ISTANBUL,PRAGUE & STOCKHLOM
110 DATA "GREENWICH, ENGLAND",CANARY ISLANDS & CHAD,THE AZORES & SCORESBYSUND
120 DATA RIO de JANEIRO & NEWFOUNDLAND,BERMUDA & GOOSE BAY,OTTAWA & NASSAU
130 DATA NEW ORLEANS & GUATEMALA,WYOMING & CHIHUAHUA,LOS ANGELES & VANCOUVER
140 DATA PITCAIRN ISAND & WHITEHORSE,HAWAII & FAIRBANKS,RARATONGA & NOME
150 FOR Z=24 TO 1 STEP-1:READ P$(Z):NEXT Z
160 :REM'
170 :REM'.....start
180 COLOR 15,2
190 PRINT " TIME ZONES (Universal Co-Ordinated Time)";
200 PRINT TAB(57);"by George Murphy VE3ERP ";
210 COLOR 1,0:PRINT STRING$(80,223);
220 COLOR 7,0
230 :REM'
240 GOSUB 720  :REM'preface
250 PRINT
260 COLOR 0,7:LOCATE 25,22
270 PRINT " Press 1 to continue or 0 to EXIT.....";
280 COLOR 7,0
290 Z$=INKEY$:IF Z$=""THEN 290
300 IF Z$="0"THEN CLS:RUN EX$
310 IF Z$="1"THEN 340
320 GOTO 290
330 :REM'
340 COLOR 0,7:LOCATE 25,1
350 INPUT " ENTER: Reference time in UTC (e.g. 0517, 1625, etc.)....";ZU
360 COLOR 7,0
370 ZU=ABS(ZU)
380 :REM'
390 :REM'.....zones
400 CLS:COLOR ,,0
410 A=172.5!
420 LN=0      :REM'line number
430    FOR Z=-11 TO 12
440 LN=LN+1
450 ZULU=ZU+Z*100
460 IF Z=0 THEN COLOR 14,1 :ELSE COLOR 7,0
470 IF ZULU>=2400 THEN ZULU=ZULU-2400:DA$=" tomorrow  in ":GOTO 510
480 IF ZULU<0 THEN ZULU=ZULU+2400:    DA$=" yesterday in ":GOTO 510
490 IF Z=0 THEN                       DA$=" TODAY     in ":GOTO 510
500                                   DA$=" today     in ":COLOR 0,7:
510 Z$=STR$(ZULU):Z$=RIGHT$(Z$,LEN(Z$)-1)
520 IF LEN(Z$)<4 THEN Z$="0"+Z$:GOTO 520
530 Z$=RIGHT$(Z$,4)
540 IF Z>0 THEN A=A+15 :ELSE A=A-15
550 IF Z<0 THEN A$="°W":B$=A$
560 IF Z=0 THEN A$="°W":B$="°E"
570 IF Z>0 THEN A$="°E":B$=A$
580 B=A+15:IF B>180 THEN B=B-360:B$="°W"
590 PRINT USING "####.#";ABS(A);:PRINT A$;
600 PRINT " to";USING "####.#";ABS(B);:PRINT B$;" = ";
610 PRINT "UTC ";
620 IF Z=0 THEN Q$="   ":ELSE Q$=" = "
630 IF Z=0 THEN PRINT Q$;:GOTO 650
640 PRINT USING "+##";Z;
650 PRINT Q$;Z$;DA$;P$(LN)+STRING$(30-LEN(P$(LN))," ");
660 COLOR 7,0
670 IF Z<12 THEN PRINT "";
680    NEXT Z
690 GOSUB 1170
700 CLS:COLOR ,,1:GOTO 170
710 :REM'
720 :REM'.....preface
730 T=7
740 PRINT TAB(T);
750 COLOR 15
760 PRINT "  TIMES SHOWN ARE LOCAL SIDEREAL (SOLAR) TIMES.";
770 COLOR 7
780 PRINT " Not all countries or"
790 PRINT TAB(T);
800 PRINT "areas follow the International Time Zone System, but will use the"
810 PRINT TAB(T);
820 PRINT "time of some principal city as a standard or will have no standard"
830 PRINT TAB(T);
840 PRINT "time at all. In some areas or on groups of islands the system is"
850 PRINT TAB(T);
860 PRINT "applied with certain local deviations made necessary by frontiers"
870 PRINT TAB(T);
880 PRINT "to permit an entire island group to have the same time zone."
890 PRINT TAB(T);
900 PRINT "  The actual time used in each area, whether it is the time of the"
910 PRINT TAB(T);
920 PRINT "corresponding zone or modified time, is fixed by law and is called"
930 PRINT TAB(T);
940 PRINT "legal time, or more generally, standard time. Another deviation is"
950 PRINT TAB(T);
960 PRINT "that certain areas, for economic reasons, modify their legal time"
970 PRINT TAB(T);
980 PRINT "for part of the year (especially in summer) by advancing it an hour"
990 PRINT TAB(T);
1000 PRINT "or another fraction of time (e.g., Daylight Saving Time)."
1010 PRINT TAB(T);
1020 PRINT "  Cities and countries displayed are located within the geographic"
1030 PRINT TAB(T);
1040 PRINT "limits indicated by the meridians shown, but may observe a LEGAL"
1050 PRINT TAB(T);
1060 PRINT "time different from the sidereal (solar) time shown for that zone."
1070 PRINT TAB(T);
1080 PRINT "  The times 0000 & 2400 (midnight) are interchangeable. 0000 refers"
1090 PRINT TAB(T);
1100 PRINT "to the day just begun, 2400 to the day just ended. Local times"
1110 PRINT TAB(T);
1120 PRINT "shown are SIDEREAL times, and may differ from the LEGAL times"
1130 PRINT TAB(T);
1140 PRINT "decreed in individual communities or areas within that zone.";
1150 RETURN
1160 :REM'
1170 :REM'PRT
1180 KEY OFF:GOSUB 1250:LOCATE 25,5:COLOR 0,2
1190 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1200 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1210 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1210 :ELSE GOSUB 1250
1220 IF Z$="3"THEN RETURN
1230 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1240 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1180
1250 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
