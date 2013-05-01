10 :REM'ELECOST' -  07 APR 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " COST OF ELECTRICITY"TAB(57)"by George Murphy VE3ERP ";
90 COLOR 7,0
100 LOCATE 3
110 PRINT " This program calculates the operating cost of a device that is not turned off"
120 PRINT " for a long period of time."
130 PRINT
140 PRINT" .....Press 1 to continue or 0 to EXIT....."
150 Z$=INKEY$:IF Z$=""THEN 150
160 IF Z$="0"THEN RUN GO$
170 IF Z$="1"THEN 190
180 GOTO 160
190 CLS
200 PRINT " COST of ELECTICITY"
210 PRINT " ══════════════════"
220 INPUT " ENTER: Cost per kilowatt/hour";KWH
230 LOCATE 3
240 PRINT " Miature LED imdicators consume about 0.001 watt"
250 PRINT " Small incandescent night lights consume 1-7 watts"
260 PRINT " Normal room lighting bulbs consume 25-100 watts"
270 PRINT " Computer and TV monitors consume about 40 watts"
280 PRINT " Heaters and fans can consume up to 1500 watts"
290 PRINT
300 INPUT " ENTER: Comsumption in watts of a device";W
310 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
320 HR=W/1000*KWH
330 DA=HR*24
340 WK=DA*7
350 MO=DA*30
360 YR=DA*365
370 COLOR 0,7
380 LOCATE 3: PRINT " At"KWH"per kilowatt/hour the operating cost of a"W"watt device is:"
390 COLOR 7,0
400 PRINT
410 LOCATE ,50:PRINT USING " ######.## per hour";HR
420 LOCATE ,50:PRINT USING " ######.## per day";DA
430 LOCATE ,50:PRINT USING " ######.## per week";WK
440 LOCATE ,50:PRINT USING " ######.## per ponth";MO
450 LOCATE ,50:PRINT USING " ######.## per year";YR
460 :REM'.....end
470 GOSUB 480:CLS:GOTO 60
480 :REM'.....PRT
490 KEY OFF:GOSUB 560:LOCATE 25,5:COLOR 0,2
500 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
510 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
520 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 520 :ELSE GOSUB 560
530 IF Z$="3"THEN RETURN
540 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
550 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 490
560 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
