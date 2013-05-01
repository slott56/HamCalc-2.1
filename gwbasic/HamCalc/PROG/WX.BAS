10 :REM'WINDCHIL - Wind Chill Factor - 16 NOV 2005
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'
70 :REM'.....title page
80 CLS
90 COLOR 15,2
100 PRINT " WINDCHILL FACTOR"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 :REM'
140 :REM'.....start
150 PRINT " Before you climb your antenna tower you might want to run this pr";
160 PRINT "ogram to     "
170 PRINT " check out wind conditions at the top!"
180 PRINT STRING$(80,205);
190 PRINT " ref: http//ourworld.compuserve.com/homepages/Gene_Nygaard/windch";
200 PRINT "ill.htm"
210 PRINT STRING$(80,205);
220 PRINT " To RUN program ....press 1"
230 PRINT " To EXIT........... press 0"
240 Z$= INKEY$:IF Z$="" THEN 240
250 IF Z$="0"THEN COLOR 7,0,0:CLS:RUN EX$
260 IF Z$="1"THEN COLOR 7,0,0:CLS:GOTO 290
270 GOTO 300
280 :REM'
290 :REM'.....start
300 LN=CSRLIN
310 PRINT "For inputs in metric units.....press 1"
320 PRINT "For inputs in USA units........press 2"
330 Z$=INKEY$:IF Z$=""THEN 330
340 IF Z$="1"THEN T$="°C":W$="Km/hr":GOTO 380
350 IF Z$="2"THEN T$="°F":W$="MPH":GOTO 380
360 GOTO 330
370 :REM'
380 PRINT " ENTER: actual air temperature in ";T$;:INPUT T
390 IF T$="°F"THEN TF=T:TC=5*(T-32)/9
400 IF T$="°C"THEN TC=T:TF=9*T/5+32
410 GOSUB 700
420 :REM'
430 COLOR 14,0:LN=CSRLIN
440 PRINT " NOTE: Results are not valid for all wind speeds outside the range "
450 PRINT "       of from 6.5 Km/hr (4 MPH) to 90 Km/hr (55.5 MPH).           "
460 COLOR 7,0,0:LN=CSRLIN
470 PRINT " ENTER: estimated wind speed in ";W$;:INPUT W
480 GOSUB 700
490 IF W$="Km/hr"THEN WN=W
500 IF W$="MPH"THEN WN=W*1.6089999675750732!
510 :REM'
520 :REM'.....calculate
530 MS=WN*10^3/60^2         :REM'metres per second
540 IF MS<1.788159966468811! OR MS>25 THEN BEEP:GOSUB 700:GOTO 470
550 WI=(10.449999809265137!+(10*(SQR(MS)))-MS)*(33-TC)  :REM'equation
560 WT=(-0.04543999955058098!*WI)+33      :REM'wind temp Celcius
570 IF T$="°C"THEN T=TC:S=WN:C=WT
580 COLOR 11,0
590 PRINT USING " Wind speed= ###.# "+W$;S;
600 PRINT USING "     Air temp.= ###.# "+T$;T;
610 PRINT USING ", but feels like ###.#"+T$;C
620 COLOR 7,0
630 :REM'
640 LN=CSRLIN:PRINT  " Want to change wind speed?   (y/n)"
650 Z$=INKEY$:IF Z$=""THEN 650
660 IF Z$="n"THEN GOSUB 700:GOSUB 740:GOTO 70
670 IF Z$="y"THEN GOSUB 700:GOTO 470
680 GOTO 650
690 :REM'
700 :REM'.....erase previous line
710 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
720 RETURN
730 :REM'
740 :REM'.....PRT
750 KEY OFF:GOSUB 820:LOCATE 25,5:COLOR 0,2
760 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
770 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
780 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 780 :ELSE GOSUB 820
790 IF Z$="3"THEN RETURN
800 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
810 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 750
820 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
