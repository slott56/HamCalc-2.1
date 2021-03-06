10 :REM'DECIFRAC - Decimal feet/inches to fractions  08 JAN 94 rev. 07 JUN 2002
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,0
70 UL$=STRING$(80,205)
80 :REM'
90 :REM'....start
100 CLS
110 COLOR 15,2
120 PRINT " DECIMAL / FRACTION CONVERTER";TAB(61);"by George C. Murphy ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 D=0:E=0:F=0:I=0:N=0       :REM'set variables to zero
160 D$="":E$="":F$="":I$="":  :REM'set variables to zero
170 PRINT " Press number in < > to convert INCHES/FEET/METRES from:"
180 PRINT UL$;
190 PRINT "  < 1 >  FRACTION to DECIMAL"
200 PRINT "  < 2 >  DECIMAL to FRACTION"
210 PRINT UL$;
220 PRINT "    or Press < 0 > to EXIT....."
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN CHAIN GO$
250 IF Z$="1"THEN 290
260 IF Z$="2"THEN 830
270 GOTO 230
280 :REM'
290 :REM'.....fraction to decimal
300 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
310 PRINT " FRACTION to DECIMAL"
320 PRINT UL$;
330 LOCATE 7
340 INPUT " ENTER: number of whole feet................................";F$
350 IF VAL(F$)<>INT(VAL(F$))THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):GOTO 330
360 IF F$=""THEN F$="0"
370 LG=LEN(F$)
380 Q$=F$+"'- ":F=VAL(F$)
390 LOCATE 5,2:PRINT Q$
400 LOCATE 8
410 INPUT " ENTER: number of whole inches..............................";I$
420 IF VAL(I$)<>INT(VAL(I$))THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):GOTO 400
430 IF I$=""THEN I$="0"
440 Q$=Q$+I$:I=VAL(I$)
450 LOCATE 5,2:PRINT Q$
460 LOCATE 9
470 INPUT " ENTER: fraction enumerator (top number of fraction)........";E$
480 IF VAL(E$)<>INT(VAL(E$))THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):GOTO 460
490 IF VAL(E$)=0 THEN E=0:GOTO 510
500 Q$=Q$+" "+E$+"/":E=VAL(E$)
510 LOCATE 5,2:PRINT Q$
520 LOCATE 10
530 IF E=0 THEN 560
540 INPUT " ENTER: fraction denominator (bottom number of fraction)....";D$
550 IF VAL(D$)<>INT(VAL(D$))THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):GOTO 520
560 Q$=Q$+D$+CHR$(34):D=VAL(D$)
570 LOCATE 5,2:PRINT Q$
580 VIEW PRINT 6 TO 24:CLS:VIEW PRINT:LOCATE 6
590 IF E=0 AND D=0 THEN IN=F*12+I:GOTO 610
600 IN=F*12+I+E/D
610 FT=IN/12
620 MR=IN*0.02539999969303608!
630 U$=STRING$(LG+2,"#")+".###"
640 PRINT " = ";USING U$;FT;:PRINT " feet"
650 PRINT " = ";USING U$;IN;:PRINT " inches"
660 PRINT " = ";USING U$;MR;:PRINT " metres"
670 PRINT
680 PRINT " ( dimensions shown are rounded off to the nearest .001 )"
690 PRINT UL$;
700 PRINT " Do you want a hard copy printout?  (y/n)"
710 Z$=INKEY$
720 IF Z$="n"THEN 810
730 IF Z$="y"THEN 750
740 GOTO 710
750 LN=CSRLIN-1:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
760 LPRINT TAB(2)Q$;
770 LPRINT TAB(20)USING U$;FT;:LPRINT " feet"
780 LPRINT TAB(20)USING U$;IN;:LPRINT " inches"
790 LPRINT TAB(20)USING U$;MR;:LPRINT " metres"
800 LPRINT
810 GOTO 1540
820 :REM'
830 :REM'.....decimal to fraction
840 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
850 PRINT " Press number in < > to select unit of measurement of ";
860 PRINT "number to be converted:"
870 PRINT UL$;
880 PRINT "  < 1 >  Decimal INCHES"
890 PRINT "  < 2 >  Decimal FEET"
900 PRINT "  < 3 >  Decimal MILLIMETRES"
910 PRINT "  < 4 >  Decimal CENTIMETRES"
920 PRINT "  < 5 >  Decimal METRES"
930 PRINT UL$;
940 Z$=INKEY$:IF Z$=""THEN 940
950 IF Z$="1"THEN M$="inches":GOTO 1020
960 IF Z$="2"THEN M$="feet":GOTO 1020
970 IF Z$="3"THEN M$="mm":GOTO 1020
980 IF Z$="4"THEN M$="cm":GOTO 1020
990 IF Z$="5"THEN M$="metres":GOTO 1020
1000 GOTO 940
1010 :REM'
1020 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1030 PRINT " DECIMAL to FRACTION"
1040 PRINT UL$;
1050 PRINT" ENTER: dimension (in decimal ";M$;") to be converted........";
1060 INPUT N
1070 I=N                                :REM'inches
1080 IF M$="feet"THEN I=I*12            :REM'feet
1090 IF M$="mm"THEN I=I/25.399999618530273!            :REM'millimetres
1100 IF M$="cm"THEN I=I*10/25.399999618530273!         :REM'centimetres
1110 IF M$="metres"THEN I=I*1000/25.399999618530273!   :REM'metres
1120 VIEW PRINT 5 TO 24:CLS:VIEW PRINT:LOCATE 5
1130 PRINT N;M$;" ="
1140 FT=0               :REM'set feet to 0
1150 IF I>12 THEN FT=INT(I/12):I=I-FT*12
1160 IN=INT(I)          :REM'whole inches
1170 FR=I-IN            :REM'decimal part of inch
1180 :REM'.....calculate fraction
1190 D=128              :REM'denominator
1200 E=FR*D             :REM'enumerator
1210 IF E=0 THEN D=0:GOTO 1260
1220 E=CINT(E/2):D=D/2
1230 IF E=0 THEN D=0:GOTO 1260
1240 IF E/2=INT(E/2)THEN 1220
1250 PRINT
1260 :REM'.....print result
1270 IF E=1 AND D=1 THEN IN=IN+1:E=0:D=0
1280 IF IN=12 THEN FT=FT+1:IN=0
1290 IN$=STR$(IN)
1300 FT$=STR$(FT)
1310 E$=STR$(E)
1320 D$=STR$(D):D$=RIGHT$(D$,LEN(D$)-1)
1330 PRINT FT$;"'-";IN$;
1340 IF E=0 THEN 1360
1350 PRINT E$;"/";D$;
1360 PRINT CHR$(34);
1370 PRINT TAB(18);"(rounded off to the nearest 1/64";CHR$(34);")"
1380 PRINT UL$;
1390 PRINT " Do you want a hard copy printout?  (y/n)"
1400 Z$=INKEY$
1410 IF Z$="n"THEN 1540
1420 IF Z$="y"THEN 1450
1430 GOTO 1400
1440 :REM'
1450 :REM'.....LPRINT data
1460 LN=CSRLIN-1:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1470 LPRINT TAB(2)N;M$;" =";
1480 LPRINT TAB(20)USING "#,###";VAL(FT$);:LPRINT "'-";IN$;
1490 IF E=0 THEN 1510
1500 LPRINT E$;"/";D$;
1510 LPRINT CHR$(34)
1520 GOTO 1540
1530 :REM'
1540 :REM'.....end
1550 GOTO 90
1560 END
