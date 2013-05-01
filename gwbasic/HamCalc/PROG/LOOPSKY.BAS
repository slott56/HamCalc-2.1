10 :REM'LOOPSKY - Loop Skywire Dimensions - 05 FEB 97 rev. 12 NOV 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 PI=3.1415929794311523!
50 U$="#####.##"
60 V$="######.#"
70 COLOR 7,0,1
80 GOTO 140
90 :REM'
100 :REM'.....clear bottom of screen
110 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
120 RETURN
130 :REM'
140 :REM'.....start
150 CLS
160 COLOR 15,2
170 PRINT " LOOP SKYWIRE DIMENSIONS";TAB(57)"by George Murphy VE3ERP ";
180 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
190 LN=CSRLIN
200 GOSUB 690
210 PRINT:COLOR 0,7:LOCATE ,2
220 PRINT " Press number for:";
230 PRINT " <1> Dimensions in metres  <2> Dimensions in feet  <0> Exit "
240 COLOR 7,0
250 A$=INKEY$:IF A$=""THEN 250
260 IF A$="0"THEN CLS:RUN EX$
270 IF A$="1"THEN UM=0.30480000376701355!:UM$=" m":GOTO 310
280 IF A$="2"THEN UM=1:UM$=" ft":GOTO 310
290 GOTO 250
300 :REM'
310 :REM'.....inputs
320 GOSUB 100
330 INPUT " ENTER: Lowest frequency of operation (MHz)...........";F
340 GOSUB 100
350 L=1005/F*UM   :REM'length
360 RC=L/PI/2     :REM'radius of circle
370 AC=PI*RC^2    :REM'area of circle
380 PRINT " Lowest frequency of operation..........";USING U$;F;:PRINT " MHz"
390 PRINT " Total length of wire in loop...........";USING U$;L;:PRINT UM$
400 PRINT " Radius of a circular loop..............";USING U$;RC;:PRINT UM$;
410 PRINT " (";USING U$;RC*2;:PRINT UM$;" diam.)"
420 PRINT " Area of a circular loop................";USING U$;AC;:PRINT UM$+"²";
430 PRINT " ( Area Factor = 100% )"
440 COLOR 0,7:LOCATE ,22:PRINT " - R E G U L A R   P O L Y G O N S - ":COLOR 7,0
450 PRINT TAB(2)"No.of";TAB(14)"Length of";TAB(26);"Centre to";
460 PRINT TAB(38)"Centre to";TAB(50)"Enclosed";TAB(65)"Area"
470 PRINT TAB(2)"Sides";TAB(14)"each side";TAB(26);"each side";
480 PRINT TAB(38)"ea.corner";TAB(50)"  Area  ";TAB(62)"  Factor  "
490 FOR N=3 TO 16
500 S=L/N               :REM'length of side
510 K=PI/N              :REM'angle in rad of 1/2 segment
520 RS=S/2/TAN(K)       :REM'distance to side
530 RP=S/2/SIN(K)       :REM'distance to corner
540 A=N*S*RS/2
550 PRINT USING "####";N;
560 PRINT STRING$(8,".");
570 PRINT TAB(13);USING U$;S;
580 PRINT TAB(25);USING U$;RS;
590 PRINT TAB(37);USING U$;RP;
600 PRINT TAB(48);USING V$;A;
610 PRINT UM$;"²";TAB(62);USING "####.## %";A/AC*100
620 NEXT N
630 IF UM=1 THEN D$="feet":ELSE D$="metres"
640 COLOR 0,7:LOCATE 24,26
650 PRINT " All dimensions are in ";D$;" ";
660 COLOR 7,0
670 GOSUB 1080:GOTO 140
680 :REM'
690 :REM'.....preface
700 T=7
710 PRINT TAB(T);
720 PRINT "The Loop Skywire is a multi-band HF antenna consisting of a single"
730 PRINT TAB(T);
740 PRINT "horizontal full-wave wire loop, fed by either coaxial or open-wire"
750 PRINT TAB(T);
760 PRINT "line. It requires no pruning and exhibits quite acceptable bandwidth"
770 PRINT TAB(T);
780 PRINT "and SWR characteristics, especially if a transmatch is used. For"
790 PRINT TAB(T);
800 PRINT "more details see any recent edition of The ARRL ANTENNA BOOK."
810 PRINT
820 PRINT TAB(T);
830 PRINT "This program computes dimensions of regular polygons wherein all"
840 PRINT TAB(T);
850 PRINT "sides are equal and joined to each other at the same angle. These"
860 PRINT TAB(T);
870 PRINT "dimensions are useful in the preliminary design of practical loops,"
880 PRINT TAB(T);
890 PRINT "even though their final shapes will rarely be perfect polygons."
900 PRINT TAB(T);
910 PRINT "Maximum enclosed space within the wire loop is the fundamental rule."
920 PRINT
930 PRINT TAB(T);
940 PRINT "The most efficient loop is a perfect circle. All other shapes have"
950 PRINT TAB(T);
960 PRINT "less enclosed space. As a general rule, the more sides a polygon has"
970 PRINT TAB(T);
980 PRINT "and the more regular its shape, the more space it encloses for any"
990 PRINT TAB(T);
1000 PRINT "given periphery."
1010 PRINT
1020 PRINT TAB(T);
1030 PRINT"The program computes dimensions for a circular loop and several"
1040 PRINT TAB(T);
1050 PRINT "polygons, including equilateral triangles and squares."
1060 RETURN
1070 :REM'
1080 :REM'PRT
1090 KEY OFF:GOSUB 1160:LOCATE 25,5:COLOR 0,2
1100 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1110 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1120 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1120 :ELSE GOSUB 1160
1130 IF Z$="3"THEN RETURN
1140 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1150 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1090
1160 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
