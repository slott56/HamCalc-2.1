10 :REM'ACCELR - 26 MAR 2010 (rev. 02 APR 2010)
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 COLOR 15,2
70 PRINT " ACCELERATION"TAB(57)"by George Murphy VE3ERP ";
80 COLOR 7,0
90 :REM'.....start
100 M=0:A=0:T=0:D=0:VO=0:VF=0:G=9.806650161743164!
110 PRINT
120 PRINT " This program calculates force of acceleration using these equations:"
130 PRINT
140 PRINT " F=MA, where Force = Mass x Acceleration."
150 PRINT " d=vot+½at²"
160 PRINT " vf=vo+at"
170 PRINT " vf²-vo²=2ad"
180 PRINT  " where d=displacement, vo=original velocity, vf=final velocity, t=time in"
190 PRINT " seconds and 'a' is a constant calculated by the program."
200 PRINT
210 PRINT  " Force of acceleration is calculated in kilogams and Standard Gravitys (g's)."
220 PRINT
230 PRINT " When entering data, if you wish to bp-pass an entry press ENTER."
240 PRINT
250 PRINT " Press 1 to continue or 0 to EXIT"
260 Z$=INKEY$:IF Z$=""THEN 260
270 IF Z$="0"THEN CLS:RUN GO$
280 IF Z$="1"THEN 300
290 GOTO 260
300 CLS:PRINT
310 IF M=0 THEN INPUT " ENTER: Mass of moving object in kg";M
320 IF D=0 THEN INPUT " ENTER: Displacement in metres ";D
330 IF T=0 THEN INPUT " ENTER: Duration of notion in seconds ";T
340 IF VO THEN 360
350 IF VO=0 THEN INPUT " ENTER: Velocity at START of acceleration (metres/second)";VO
360 IF VF=0 THEN INPUT " ENTER: Velocity at END of acceleration (metres/second)";VF
370 IF VO*VF*T THEN A=(VF-VO)/T
380 IF VO=VF THEN VO=0:VF=0:GOTO 400
390 IF M*A*D*T*VO*VF THEN GOSUB 410:GOTO 470
400 CLS:GOTO 300
410 :REM'.....calculate
420 IF D=0 AND VO*T*A THEN D=VO*T+0.5!*A*T^2
430 IF VF=0 AND VO*A*T THEN VF=VO+A*T
440 IF VO=0 AND VF*A*T THEN V0=VF-A*T
450 IF M*D*T*VO*VF*A THEN F=M*A:GOTO 470
460 RETURN
470 CLS
480 PRINT
490 PRINT " ACCELERATION CALCULATION"
500 PRINT
510 PRINT USING " Mass of moving object (kilograms)..M= ####.###";M
520 PRINT USING " Displacement (metres)..............D= ####.###";D
530 PRINT USING " Duration of motion (seconds).......T= ####.###";T
540 PRINT USING " Start velocity (metres/second)....Vo= ####.###";VO
550 PRINT USING " End velocity (metres/second)......Vf= ####.###";VF
560 PRINT USING " Acceleration constant (m./sec.)....A= ####.###";A
570 PRINT USING " Acceleration force (kilograms).....F= ####.###";F
580 PRINT USING " Force (standard gravitys)............ ####.###";F/G
590 PRINT
600 PRINT " (Standard gravity <g-force> is";G;"metres/second²)."
610 :REM'.....PRT
620 GOSUB 630:CLS:GOTO 60
630 KEY OFF:GOSUB 700:LOCATE 25,5:COLOR 0,2
640 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
650 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
660 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 660 :ELSE GOSUB 700
670 IF Z$="3"THEN RETURN
680 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
690 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 630
700 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
