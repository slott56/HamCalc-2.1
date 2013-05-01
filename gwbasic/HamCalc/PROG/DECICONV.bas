10 :REM'\hamcalc\prog\DECICONV - Decimal hours/degrees converter - 10 APR 01
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 UL$=STRING$(80,205)
70 :REM'
80 :REM'.....title page
90 COLOR 15,2,0
100 PRINT " DECIMAL HOUR/DEGREE CONVERTER"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0:GOSUB 750   :REM'preface
130 PRINT UL$;
140 PRINT " Press number in < > to:"
150 PRINT UL$;
160 PRINT "   <1> Convert decimal hours to sexagesimal format"
170 PRINT "   <2> Convert decimal degrees to sexagesimal format"
180 PRINT "   <3> Convert sexagesimal hours to decimal format"
190 PRINT "   <4> Convert sexagesimal degrees to decimal format"
200 PRINT
210 PRINT "   <0> EXIT"
220 Z$=INKEY$:IF Z$=""THEN 220
230 IF Z$="0"THEN CLS:CHAIN GO$
240 IF Z$="1"THEN A$="hours":B$=":":C$=":":D$=" ":E$="(hrs:min:sec)"
250 IF Z$="2"THEN A$="degrees":B$="° ":C$="'":D$=CHR$(34):E$="(deg/min/sec)"
260 IF Z$="1"OR Z$="2"THEN CLS:GOTO 320
270 IF Z$="3"THEN COLOR 7,0,0:CLS:U$="Hrs."
280 IF Z$="4"THEN COLOR 7,0,0:CLS:U$="Deg."
290 IF Z$="3"OR Z$="4"THEN CLS:GOTO 560
300 GOTO 220
310 :REM'
320 :REM'.....start
330 COLOR 7,0,0:PRINT STRING$(79,32):LOCATE CSRLIN-1
340 COLOR 0,7
350 PRINT " ENTER: Decimal ";A$;" (or 0 to quit).....";:INPUT HRS:COLOR 7,0
360 IF HRS=0 THEN 830
370 D=HRS
380 D1=INT(D)           :REM'degrees/hours
390 D2=(D-D1)*60        :REM'minutes
400 D3=(D2-INT(D2))*60  :REM'seconds
410 D2=INT(D2)
420 IF D3=60 THEN D2=D2+1:D3=0
430 IF D2=60 THEN D1=D1+1:D2=0
440 :REM'
450 Y$=STR$(D1):HRS$=RIGHT$(Y$,LEN(Y$)-1)+B$
460 IF LEN(HRS$)<5 THEN HRS$=" "+HRS$:GOTO 460
470 Y$=STR$(D2):MIN$=RIGHT$(Y$,LEN(Y$)-1)+C$
480 IF LEN(MIN$)<3 THEN MIN$="0"+MIN$:GOTO 480
490 LN=CSRLIN-1:COLOR 7,0:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
500 PRINT USING "       ###.#### decimal "+A$+" = ";HRS;
510 COLOR 14,4:PRINT " ";HRS$;MIN$;
520 PRINT USING "###.#"+D$;D3;
530 COLOR 7,0:PRINT " ";E$
540 GOTO 320
550 :REM'
560 :REM'.....decimal format
570 LN=CSRLIN
580 COLOR 0,7:PRINT " ENTER: Whole ";U$;:INPUT D:D=INT(D):GOSUB 710
590 COLOR 0,7:INPUT " ENTER: Whole minutes";M:M=INT(M):GOSUB 710
600 COLOR 0,7:INPUT " ENTER: Seconds";S:GOSUB 710
610 D1=D+M/60+S/3600
620 COLOR 14,4
630 PRINT USING " #### "+U$;D;
640 PRINT USING " ## min. ##.# sec. = ####.#### "+U$;M,S,D1
650 COLOR 0,7:LN=CSRLIN:PRINT " Want (a)nother or (q)uit?   (a/q) ":COLOR 7,0
660 Z$=INKEY$:IF Z$=""THEN 660
670 IF Z$="q"THEN 830
680 IF Z$="a"THEN GOSUB 710:GOTO 570
690 GOTO 660
700 :REM'
710 :REM'.....clear screen
720 COLOR 7,0:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
730 RETURN
740 :REM'
750 :REM'.....preface
760 PRINT " This program converts decimal hours or decimal degrees to sexige";
770 PRINT "simal formats:"
780 PRINT "   HH:MM:SS  (hours/min./sec.) for time"
790 PRINT "   DD°MM'SS";CHR$(34);" (degrees/min./sec.) for degrees"
800 PRINT " and vice versa."
810 RETURN
820 :REM'
830 :REM'.....end
840 LOCATE CSRLIN-1:PRINT STRING$(79,32)
850 GOSUB 870:CLS:GOTO 80
860 :REM'
870 :REM'.....PRT
880 KEY OFF:GOSUB 950:LOCATE 25,5:COLOR 0,2
890 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
900 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
910 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 910 :ELSE GOSUB 950
920 IF Z$="3"THEN RETURN
930 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
940 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 880
950 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
