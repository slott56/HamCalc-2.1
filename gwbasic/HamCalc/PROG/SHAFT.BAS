10 :REM'SHAFT : 3 DEC 85  rev. 20 MAR 2000
20 IF EX$=""THEN EX$="exit"
30 COMMON EX$
40 CLS:KEY OFF
50 UL$=STRING$(80,205)
60 U$="######.###"
70 GOTO 110
80 :REM'
90 LOCATE C1,1:FOR U=C2 TO C3:LOCATE U,1:PRINT STRING$(80,32);:NEXT U:RETURN
100 :REM'
110 :REM'.....start
120 CLS:COLOR 11,1,4
130 COLOR 11,1:PRINT " SHAFTING DESIGN";TAB(57)"by George Murphy VE3ERP ";
140 COLOR 4,0:PRINT STRING$(80,"▀");
150 COLOR 7,0
160 PRINT TAB(24)"  Press number in ( ) to describe shaft"
170 PRINT UL$;
180 PRINT TAB(24)"  (1)  Main shaft"
190 PRINT TAB(24)"  (2)  Shaft with pulleys"
200 PRINT TAB(24)"  (3)  Stub shaft"
210 PRINT
220 PRINT TAB(24)"  (0)  EXIT"
230 Z$=INKEY$
240 IF Z$="1"THEN CLS:Y=80:W=1:GOTO 310
250 IF Z$="2"THEN CLS:Y=53.5!:W=1:Z=1:GOTO 310
260 IF Z$="3"THEN CLS:Y=38:W=0:GOTO 310
270 IF Z$="0"THEN CLS:CHAIN"mechmenu"
280 GOTO 230
290 ON ERROR  CLS:PRINT "Error";ERR;"in line";ERL:END
300 :REM'
310 CLS:COLOR 7,0,0
320 PRINT "SHAFTING SPECIFICATIONS:":PRINT
330 INPUT "Shaft R.P.M. .................";N
340 IF N=0 THEN CLS:GOTO 310
350 PRINT"( Press [ENTER] if you want to determine shaft dia. from other data )"
360 INPUT "Shaft diameter (in) ..........";D
370 IF D=0 THEN C1=4:C2=4:C3=5:GOSUB 90:LOCATE 4,1:GOTO 400
380 H=D^3*N/Y
390 GOTO 440
400 PRINT"( Press [ENTER] if you want to determine horsepower from other data )"
410 INPUT "Horsepower ...................";H
420 IF H=0 THEN C1=4:C2=4:C3=5:GOSUB 90:LOCATE 4,1:GOTO 350
430 D=(H*Y/N)^(1/3)
440 X=(D^2)^(1/3)
450 IF Z=1 THEN L=62.400001525878906!*X :ELSE L= 107.4000015258789!*X
460 CLS:PRINT "SHAFTING SPECIFICATIONS":PRINT
470 PRINT "Minimum shaft diameter (in.)..";USING U$;D
480 PRINT "Shaft R.P.M. .................";USING U$;N
490 PRINT "Maximum horsepower ...........";USING U$;H
500 IF W=0 THEN 530
510 PRINT "Max. inches between bearings..";USING U$;L
520 :REM'
530 :REM'.....end
540 GOSUB 560:GOTO 110
550 :REM'
560 :REM'PRT
570 KEY OFF:GOSUB 640:LOCATE 25,5:COLOR 0,2
580 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
590 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
600 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 600 :ELSE GOSUB 640
610 IF Z$="3"THEN RETURN
620 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
630 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 570
640 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
