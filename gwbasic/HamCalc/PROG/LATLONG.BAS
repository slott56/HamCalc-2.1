10 :REM'LATLONG - Latitude/Longitude data base - 20 JUN 95 rev. 10 MAR 2000
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COMMON EX$,PROG$,LATLONG,DMS
50 LATLONG=1   :REM'flag
60 T=7
70 PRINT TAB(24);"LATITUDE and LONGITUDE DATA BASE"
80 PRINT TAB(24);"▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
90 PRINT
100 PRINT TAB(T);
110 PRINT "Some HAMCALC programs ask you to enter the latitude and longitude"
120 PRINT TAB(T);
130 PRINT "of a location, usually your own QTH. The data base contains this"
140 PRINT TAB(T);
150 PRINT "information for many places in the world, and you may add, delete"
160 PRINT TAB(T);
170 PRINT "or edit the data at any time. Solar time zones (±UTC) are calculated"
180 PRINT TAB(T);
190 PRINT "automatically for each location."
200 PRINT
210 PRINT TAB(T);
220 PRINT "Enter data in decimal degrees - to the nearest 0.1 degree is close"
230 PRINT TAB(T);
240 PRINT "enough for most amateur radio applications. Enter data as follows:"
250 PRINT
260 PRINT TAB(T);
270 PRINT "LATITUDE:  as Positive (+) values if NORTH of the equator"
280 PRINT TAB(T);
290 PRINT "           as Negative (-) values if SOUTH of the equator"
300 PRINT
310 PRINT TAB(T);
320 PRINT "LONGITUDE: as Positive (+) values if EAST of Greenwich, England"
330 PRINT TAB(T);
340 PRINT "           as Negative (-) values if WEST of Greenwich, England"
350 PRINT
360 PRINT TAB(T);
370 PRINT "If you wish to find the latitude and longitude of any location in"
380 PRINT TAB(T);
390 PRINT "the database, you need only enter the first few letters of a city,"
400 PRINT TAB(T);
410 PRINT "state or country and the program will display a list from which you"
420 PRINT TAB(T);
430 PRINT "may select the location of your choice."
440 COLOR 0,7:LOCATE 24,24
450 PRINT " Press 1 to continue or 0 to EXIT ";
460 COLOR 7,0
470 Z$=INKEY$:IF Z$=""THEN 470
480 IF Z$="0"THEN CLS:RUN EX$
490 IF Z$="1"THEN 510
500 GOTO 470
510 COLOR 0,7:LOCATE 24,3
515 DMS=0   :REM'degree/minute/second flag
520 PRINT " Do you want to convert Degrees/Minutes/Seconds to Decimal Degrees?";
530 PRINT "   (y/n) ";
540 COLOR 7,0
550 Z$=INKEY$:IF Z$=""THEN 550
560 IF Z$="y"THEN DMS=1:CLS:CHAIN"equiv"
570 IF Z$="n"THEN CLS:CHAIN"pathfind"
580 GOTO 550
