10 :REM'NODE - transmission line nodes - 01 FEB 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="node"
60 COMMON EX$,PROG$
70 :REM'.....title page
80 CLS
90 PRINT :COLOR 15,2,1
100 PRINT " TRANSMISSION LINE NODE LOCATOR"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 PRINT " This programs calculates the locations of voltage & current peak ";
140 PRINT "& null nodes"
150 PRINT " along a balanced or unbalanced antenna feedline."
160 PRINT
170 PRINT " .....Press 1 to continue or 0 to exit....."
180 Z$=INKEY$:IF Z$=""THEN 180
190 IF Z$="0" THEN COLOR 7,0,0:CLS:RUN EX$
200 IF Z$="1"THEN 220
210 GOTO 180
220 :REM'.....start
230 CLS: COLOR  0,7,0
240 PRINT " 1/4 WAVELENGTH TRANSMISSION LINE VOLTAGE & CURRENT NODES ":COLOR 7,0
250 VIEW PRINT 2 TO 24:CLS:VIEW PRINT:LOCATE 3
260 INPUT " ENTER: Frequency in MHz";F
270 LOCATE CSRLIN-1:PRINT USING " Frequency = ####.### MHz /";F;
280 W=299.792458#/F :REM'exact
290 PRINT USING " wavelength = ###.### metres";W
300 LM=W/4:LF=LM/0.30480000376701355!
310 PRINT USING" Length of feedline........ ###.### m. = ###.### ft.";LM,LF
320 NM=LM/8:NF=NM/0.30480000376701355!
330 PRINT USING" Node spacing along line... ###.### m. = ###.### ft.";NM,NF
340 PRINT " Antenna feed point is at node 0.";
350 PRINT " Feedline feed point is at node 8."
360 PRINT " Centre fed antennas:"
370 PRINT "  I(peak) and E(null) occur at nodes 0, 2, 4, 6, 8"
380 PRINT "  E(peak) and I(null) occur at nodes 1, 3, 5, 7"
390 PRINT " End fed antennas:"
400 PRINT "  E(peak) and I(null) occur at nodes 0, 2, 4, 6, 8"
410 PRINT "  I(peak) and E(null) occur at nodes 1, 3, 5, 7"
420 PRINT " Distances from node 0 (Antenna feed point):"
430 FOR Z=1 TO 8
440 PRINT USING " Node ##       ###.### m.= ####.### ft.";Z,NM*Z,NF*Z
450 IF Z=8 THEN LOCATE CSRLIN-1,40:PRINT " (Transmission line feed point)"
460 NEXT Z
470 PRINT
480 COLOR 0,7:PRINT " Want to change frequency?   (y/n) ":COLOR 7,0
490 Z$=INKEY$:IF Z$="" THEN 490
500 IF Z$="n"THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):GOSUB 550:GOTO 80
510 IF Z$="y"THEN 250
520 GOTO 490
530 :REM'.....end
540 GOSUB 550:CLS:GOTO 70
550 :REM'.....PRT
560 IN=LF/8*12:CM=IN*2.5399999618530273!
570 KEY OFF:GOSUB 640:LOCATE 25,5:COLOR 0,2
580 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
590 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
600 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 600 :ELSE GOSUB 640
610 IF Z$="3"THEN RETURN
620 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
630 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 570
640 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
