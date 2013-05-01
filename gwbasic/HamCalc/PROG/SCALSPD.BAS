10 :REM'SCALSPD - Scale Speefs - 11 NOV 05
20 IF EX$=""THEN EX$="exit"
30 COMMON EX$
40 :REM'
50 KEY OFF:CLS
60 E$=STRING$(79,32)
70 UL$=STRING$(80,205)
80 COLOR 15,2:PRINT " SCALE SPEED"TAB(57)"by George Murphy VE3ERP ";
90 COLOR 7,0:PRINT UL$;
100 PRINT " This program calculates the scale speed of a scale model travell";
110 PRINT "ing over a"
120 PRINT " full scale distance in real time."
130 PRINT UL$;
140 LN=CSRLIN:PRINT " Press <1> to run program or <0> to EXIT."
150 Z$=INKEY$:IF Z$=""THEN 150
160 IF Z$="0"THEN CHAIN EX$
170 IF Z$="1" THEN GOSUB 470:GOTO 190
180 GOTO 150
190 INPUT " ENTER: scale of model......     1:";SCL
200 GOSUB 470
210 PRINT " Scale of model..........       1 :";SCL
220 INPUT " ENTER: Full scale distance in inches";R
230 GOSUB 470
240 PRINT USING " Full scale distance..... ########.# inches";R
250 D=R*SCL
260 PRINT USING "                        = ####,###.# scale inches";D
270 INPUT " ENTER: Travel time in seconds";T
280 GOSUB 470
290 PRINT USING " Travel time............= ####,###.# seconds";T
300 S=D/T
310 PRINT USING " Scale speed............= ####,###.# scale inches per second";S
320 FT=S/12
330 PRINT USING "                        = ####,###.# scale feet per second";FT
340 MIN=FT*60
350 PRINT USING "                        = ####,###.# scale feet per minute";MIN
360 HR=MIN*60
370 PRINT USING "                        = ######,### scale feet per hour";HR
380 MPH=HR/5280
390 COLOR 0,7
400 PRINT USING "                        = ####,###.# scale miles per hour";MPH
410 COLOR 7,0
420 PRINT UL$;
430 :REM'
440 :REM'.....end
450 GOSUB 510:GOTO 50
460 :REM'
470 :REM'.....clear previous line
480 LOCATE CSRLIN-1:PRINT E$:LOCATE CSRLIN-1
490 RETURN
500 :REM'
510 :REM'.....PRT
520 KEY OFF:GOSUB 590:LOCATE 25,5:COLOR 0,2
530 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
540 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
550 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 550 :ELSE GOSUB 590
560 IF Z$="3"THEN RETURN
570 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
580 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 520
590 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
