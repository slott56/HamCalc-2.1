10 :REM'CENTRIF - Centrifugal Force - 26 MAR 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 COLOR 7,0,0:GOTO 80
70 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
80 :REM'.....title page
90 COLOR 15,2
100 PRINT " CENTRIFUGAL/CENTRIPETAL Force"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 7,0
120 :REM'.....start
130 PRINT
140 PRINT" DEFINITIONS:"
150 PRINT
160 PRINT " CENTRIFUGAL FORCE: Force directed in a straight line away from the centre."
170 :REM'PRINT " (e.g. a thrown object released from the grasp of the thrower).
180 PRINT
190 PRINT " CENTRIPETAL FORCE: Force directed in a curve toward the centre of rotation."
200 PRINT
210 PRINT " In either case the force is the same."
220 PRINT:LN=CSRLIN-1
230 PRINT " Press 1 to continue or 0 to EXIT"
240 Z$=INKEY$:IF Z$=""THEN 240
250 IF Z$="0"THEN RUN GO$
260 IF Z$="1"THEN 280
270 GOTO 240
280 :REM'.....input data
290 F=0:M=0:V=0:R=0
300 GOSUB 70:PRINT
310 PRINT
320 IF F*M*V*R THEN 430
330 IF F=0 THEN INPUT " ENTER: Force in kilograms";F
340 IF M=0 THEN INPUT " ENTER: Mass in kilograms";M
350 IF V=0 THEN INPUT " Velocity in metres/second";V
360 IF R=0 THEN INPUT " Radius of orbit in metres";R
370 :REM'
380 IF F=0 AND M*V*R THEN F=M*V^2/R :GOTO 300
390 IF M=0 AND F*V*R THEN M=F/(V^2/R):GOTO 300
400 IF V=0 AND F*M*R THEN V=SQR(F/M*R):GOTO 300
410 IF R=0 AND F*M*V THEN R=M*V^2/F:GOTO 300
420 GOTO 300
430 :REM'.....display
440 GOSUB 70
450 PRINT
460 PRINT USING " Force........... ####.### kg = ########.### lb.";F;F*2.2046000957489014!
470 PRINT USING " Mass............ ####.### kg = ########.### lb.";M;M*2.2046000957489014!
480 PRINT USING " Velocity........ ####.### m./sec = ####.### ft/sec";V;V*3.2808001041412354!
490 PRINT USING " Orbital Radius.. ####.### m. = ########.### ft.";R;R*3.2799999713897705!
500 GOSUB 510:CLS:GOTO 80
510 :REM'.....PRT
520 KEY OFF:GOSUB 590:LOCATE 25,5:COLOR 0,2
530 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
540 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
550 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 550 :ELSE GOSUB 590
560 IF Z$="3"THEN RETURN
570 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
580 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 520
590 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
