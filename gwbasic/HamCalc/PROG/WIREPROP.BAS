10 :REM'WIREPROP  - Wire size calculator - rev 10 MAR 09
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
140 IF Z$="1"THEN GOSUB 640:GOTO 190
150 IF Z$="2"THEN GOSUB 640:GOTO 370
160 IF Z$="0"THEN RUN"copwire"
170 GOTO 130
180 G=-1
190 :REM'.....wire specs
200 LN=CSRLIN:INPUT " ENTER: AWG wire size";G
210 IF G<0 THEN 390
220 IF G=99 THEN 610
230 IF G>50 THEN 180
240 GOSUB 580
250 GOSUB 640
260 PRINT USING " Wire size.................... ###### AWG";G
270 PRINT USING " Diameter..................... ######.### inches";M/10^3
280 PRINT USING " Cross-section................ ######.### circular mils";M^2
290 T = INT((1-G/180)*1000/(1.024999976158142!*M))
300 PRINT USING " Turns per inch............... ######.###";T
310 PRINT USING " Turns per square inch........ ######.###";T^2
320 R = 10370/A
330 L1=0.003026749938726425!*A
340 PRINT USING " Resistance per 1000 feet..... ######.### ohms";R
350 PRINT USING " Weight per 1000 feet......... ######.### lbs.";L1
360 GOTO 610
370 :REM'.....current density
380 LN=CSRLIN:GOSUB 640
390 INPUT " ENTER: Current in amperes";I
400 INPUT " ENTER: Current density in circular mils per ampere";D
410 GOSUB 640
420 G = 50
430 GOSUB 580
440 IF A<= I*D THEN G=G-1 :ELSE 460
450 GOTO 430
460 IF G>-1 THEN 470 :ELSE 480
470 GOTO 260
480 IF G<0 THEN 490::ELSE 440
490 G=G+1
500 IF G=0 THEN 530
510 GOTO 440
520 GOTO 290
530 PRINT " NOT VIABLE!..... Reduce current or circular mills....."
540 PRINT " ................ Press any key........................"
550 Z$=INKEY$:IF Z$=""THEN 550
560 GOSUB 640:GOTO 370
570 :REM'
580 M = 5/92^((G-36)/39)
590 A=M*M
600 RETURN
610 :REM'.....end
620 GOSUB 650:GOTO 20
630 :REM',,,,erase to bottom of screen
640 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
650 :REM'.....PRT
660 KEY OFF:GOSUB 730:LOCATE 25,5:COLOR 0,2
670 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
680 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
690 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 690 :ELSE GOSUB 730
700 IF Z$="3"THEN RETURN
710 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
720 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 660
730 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
