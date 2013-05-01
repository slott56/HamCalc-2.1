10 :REM'MECHMENU - MECHANICS - 06 APR 2000 rev.10 MAR 2006
20 CLS:KEY OFF
30 COMMON EX$
40 IF EX$=""THEN EX$="exit"
50 COLOR 7,0,4
60 :REM'
70 U$=STRING$(80,205)
80 T$="  M E C H A N I C S  "
90 DIM A$(36),B$(36),C$(36)
100 ON ERROR  GOTO 210
110 COLOR 1,7:PRINT U$;
120 COLOR 15,1
130 LOCATE CSRLIN-1,30:PRINT T$
140 COLOR 4,0
150 PRINT STRING$(80,223);
160 COLOR 7,0
170 PRINT TAB(20);"Press character in ( ) to select program"
180 PRINT U$;
190 N=0:GOTO 230
200 :REM'
210 PRINT "Error ";ERR;" in line ";ERL:END
220 :REM'
230 FOR N=1 TO 11:A$(N)=CHR$(N+96)
240 READ B$(N),C$(N)
250 NEXT N
260 B$(11)=EX$
270 :REM'
280 FOR Z=1 TO 11
290 COLOR 7,0
300 IF Z=11 THEN COLOR 15,1
310 PRINT " (";A$(Z);")  ";C$(Z)
320 COLOR 7,0
330 NEXT Z
340 PRINT U$;
350 :REM'
360 Z$=INKEY$:IF Z$=""THEN 360
370 IF ASC(Z$)>=65 AND ASC(Z$)<=90 THEN 460
380 FOR Z=1 TO 36
390 IF Z$=A$(Z)THEN 430
400 NEXT Z
410 GOTO 360
420 :REM'
430 IF B$(Z)=""THEN 360
440 CHAIN B$(Z)
450 :REM'
460 :REM'.....caps lock warning
470 CLS:BEEP:COLOR 14,1
480 PRINT
490 PRINT " Please turn your CAPS LOCK off and make all entries in lower case ";
500 PRINT " characters only."
510 PRINT
520 PRINT " The computer will provide upper case characters where appropriate."
530 PRINT
540 PRINT " Press anu key to continue................"
550 IF INKEY$=""THEN 550
560 CLS:CLEAR:COLOR 7,0,0:GOTO 10
570 :REM'
580 DATA beamdefl,BEAMS - Deflection in
590 DATA beamsect,BEAMS - Properties of (Start new beam design here)
600 DATA beltdriv,Belt Drives
610 DATA chain,Chain Drives
620 DATA cyl,Cylinders - Air & Hydraulic
630 DATA gearing,Gears & gearing
635 DATA binhop,Hoppered Bins & Tanks
640 DATA shaft,Shafting
650 DATA stairs,"Stairs, Ladders & Ramps"
660 DATA torque,Torque & Horsepower
670 DATA ex$,"EXIT"
680 END
