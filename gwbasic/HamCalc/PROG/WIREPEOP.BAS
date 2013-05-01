10 :REM'WIREPROP  - Wire size calculator - revised 10 MAR 09
20 CLS:KEY OFF
30 IF EX$="" THEN EX$="exit"
40 COMMON EX$,PROG$
50 UL$=STRING$(80,205)
60 PRINT " COPPER WIRE PROPERTIES"TAB(57)"by George Murphy VE3ERP ";
70 PRINT UL$;
80 LOCATE CSRLIN-1,26:PRINT " (algorithm author unknown) "
90 LN=CSRLIN
100 PRINT " For wire specifications..............press <1>"
110 PRINT " For current density calculation......press <2>"
120 PRINT " To EXIT..............................press <0>"
130 Z$=INKEY$:IF Z$=""THEN 130
140 IF Z$="1"THEN GOSUB 670:GOTO 190
150 IF Z$="2"THEN GOSUB 670:GOTO 390
160 IF Z$="0"THEN RUN"copwire"
170 GOTO 130
180 G=-1
190 :REM'.....wire specs
200 LN=CSRLIN:INPUT " ENTER: AWG wire size";G
220 IF G<0 THEN 410
230 IF G=99 THEN 640
240 IF G>50 THEN 180
250 GOSUB 610
260 GOSUB 670
270 PRINT USING " Wire size.................... ###### AWG";G
280 PRINT USING " Diameter..................... ######.### inches";M/10^3
290 PRINT USING " Cross-section................ ######.### circular mils";M^2
300 T = INT((1-G/180)*1000/(1.024999976158142!*M))
310 PRINT USING " Turns per inch............... ######.###";T
320 PRINT USING " Turns per square inch........ ######.###";T^2
330 R = 10370/A
340 L1=0.003026749938726425!*A
350 PRINT USING " Resistance per 1000 feet..... ######.### ohms";R
360 PRINT USING " Weight per 1000 feet......... ######.### lbs.";L1
370 GOTO 640
380 :REM'
390 :REM'.....current density
400 LN=CSRLIN:GOSUB 670
410 INPUT " ENTER: Current in amperes";I
420 INPUT " ENTER: Current density in circular mils per ampere";D
430 GOSUB 670
440 G = 50
450 GOSUB 610
460 IF A<= I*D THEN G=G-1 :ELSE 490
470 GOTO 450
480 :REM'PRINT "WIRE SIZE = ";
490 IF G>-1 THEN 500 :ELSE 510
500 GOTO 270
510 IF G<0 THEN 520::ELSE 460
520 G=G+1
530 IF G=0 THEN 560
540 GOTO 460
550 GOTO 300
560 PRINT " NOT VIABLE!..... Reduce current or circular mills....."
570 PRINT " ................ Press any key........................"
580 Z$=INKEY$:IF Z$=""THEN 580
590 GOSUB 670:GOTO 390
600 :REM'
610 M = 5/92^((G-36)/39)
620 A=M*M
630 RETURN
640 :REM'.....end
650 GOSUB 680:GOTO 20
660 :REM',,,,erase to bottom of screen
670 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
680 :REM'.....PRT
690 KEY OFF:GOSUB 760:LOCATE 25,5:COLOR 0,2
700 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
710 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
720 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 720 :ELSE GOSUB 760
730 IF Z$="3"THEN RETURN
740 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
750 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 690
760 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
