10 :REM'BAROMTR - Barometer readings - 07 MAY 2000 rev. 19 MAY 2000
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$
50 COLOR 7,0,0
60 UL$=STRING$(80,205)
70 DIM P$(11,2)
80 :REM'
90 :REM'.....title page
100 CLS
110 COLOR 15,2
120 PRINT " BAROMETER READING EQUIVALENTS"TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 PRINT " Press number in < > for:"
160 PRINT UL$;
170 PRINT "   < 1 > Typical barometer reading equivalents"
180 PRINT "   < 2 > Atmosphere pressure equivalents"
190 PRINT
200 PRINT "   < 0 > EXIT"
210 Z$=INKEY$:IF Z$=""THEN 210
220 IF Z$="0"THEN CHAIN EX$
230 IF Z$="1"THEN 270
240 IF Z$="2"THEN 510
250 GOTO 210
260 :REM'
270 :REM'.....barometer readings
280 CLS:COLOR 0,7
290 PRINT "  kPa    in.Hg    lb/in²  millibars  S.A. "
300 COLOR 7,0
310 FOR Z=95.5! TO 106 STEP 0.5!
320 X=Z
330 PRINT USING "####.#";X;
340 PRINT USING "#####.###";X/101.32499694824219!*29.92099952697754!;
350 PRINT USING "#####.###";X/101.32499694824219!*14.696000099182129!;
360 PRINT USING "########";X/101.32499694824219!*1.0329999923706055!*10^3;
370 PRINT USING "#####.### ";X/101.32499694824219!
380 NEXT Z
390 COLOR 0,7:LOCATE 1,47:PRINT " EQUIVALENT BAROMETER READINGS ":COLOR 7,0
400 LOCATE 2,48:PRINT  "( in.Hg = inches of mercury )"
410 LOCATE 3,48:PRINT  "( S.A.= standard atmospheres)"
420 LOCATE 5,48:PRINT  "1 standard atmosphere is the "
430 LOCATE 6,48:PRINT  "pressure exerted by a 76 cm. "
440 LOCATE 7,48:PRINT  "column of mercury at 0°C at  "
450 LOCATE 8,48:PRINT  "sea level at standard gravity"
460 LOCATE 9,48:PRINT  "of 980.6 cm/second².         "
470 LOCATE 22,48:PRINT  " Ref. POCKET REF, pages 8-9  "
480 LOCATE 23,48:PRINT  "    by Thomas J. Glover      "
490 GOSUB 1010:GOTO 90
500 :REM'
510 :REM'.....standard atmosphere
520 CLS
530 RESTORE
540 DATA Millibars, Standard atmospheres, Centimetres of mercury
550 DATA Inches of mercury,Metres of water,Inches of water
560 DATA Feet of water,Pounds per square inch,Pounds per square foot
570 DATA Kilograms per square centimetre,Kilopascals
580 FOR Z=1 TO 11:READ P$(Z,1):NEXT Z
590 FOR Z=1 TO 11:P$(Z,1)=P$(Z,1)+STRING$(34-LEN(P$(Z,1)),"."):NEXT Z
600 DATA 1033,1,76,29.921,10.3322,406.782,33.899,14.696,2116.2,1.033,101.325
610 FOR Z=1 TO 11:READ P$(Z,2):NEXT Z
620 T$="ATMOSPHERIC PRESSURE EQUIVALENTS"
630 LOCATE ,(80-LEN(T$))/2:PRINT T$
640 PRINT UL$;
650 PRINT " Altitude...............................  Sea Level"
660 PRINT " Temperature............................";
670 A=0:B=32
680 PRINT USING " ######.#°C        = ####.#°F";A,B
690 PRINT " Standard gravity.......................";
700 A=9.806639671325684!:B=32.17399978637695!
710 PRINT USING " ######.### m/sec² = ####.### ft/sec²";A,B
720 PRINT " Speed of sound in dry air..............";
730 A=331.45001220703125!:B=1087.4000244140625!
740 PRINT USING "┌ #####.### m/sec  = ####.### ft/sec";A,B
750 D=A/10^3*3600:E=B/5280*3600
760 LOCATE ,41:PRINT USING "└ #####.#   km/hr  = ####.#   miles/hr";D,E
770 PRINT UL$;
780 LN=CSRLIN
790 PRINT " Press letter in ( ) to select an atmospheric pressure unit:"
800 PRINT UL$;
810 FOR Z=1 TO 11
820 PRINT "  (";CHR$(Z+96);") ";P$(Z,1)
830 NEXT Z
840 J$=INKEY$:IF J$=""THEN 840
850 IF J$<"a"OR J$>"k"THEN 840
860 X=ASC(J$)-96
870 COLOR 0,7:PRINT " ENTER: Pressure in ";P$(X,1);:INPUT Z:COLOR 7,0
880 N=VAL(P$(X,2))/Z
890 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
900 PRINT " Equivalent Atmospheric Pressures:"
910 PRINT UL$;
920 FOR Z=1 TO 11
930 A$=P$(Z,1):B=VAL(P$(Z,2))/N
940 COLOR 7,0
950 PRINT "   ";:IF X=Z THEN COLOR 0,7 :ELSE COLOR 7,0
960 PRINT "   ";A$;:PRINT USING " ##,###.###   ";B
970 NEXT Z:COLOR 7,0
980 LOCATE 23,17:PRINT " (ref: POCKET REF, by Thomas J. Glover, pp 8-9)"
990 GOSUB 1010:GOTO 90
1000 :REM'
1010 :REM'PRT
1020 KEY OFF:GOSUB 1090:LOCATE 25,5:COLOR 0,2
1030 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1040 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1050 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1050 :ELSE GOSUB 1090
1060 IF Z$="3"THEN RETURN
1070 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1080 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1020
1090 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
