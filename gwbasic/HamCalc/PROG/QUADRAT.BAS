10 :REM'QUADRAT - Quadratic equation 28 MAR 2007
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 ON ERROR  GOTO 360
70 :REM'.....title page
80 CLS:COLOR 15,2,0
90 PRINT " QUADRATIC EQUATION CALCULATOR"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 7,0,0
120 LN=CSRLIN:PRINT " This programs solves quadratic equations"
130 PRINT:PRINT " ....press 1 to continue or 0 to EXIT...."
140 Z$=INKEY$:IF Z$=""THEN 140
150 IF Z$="0"THEN RUN EX$
160 IF Z$="1"THEN GOSUB 350:GOTO 180
170 GOTO 140
180 :REM'.....start
190 PRINT " Quadratic equation:";:COLOR 0,7:PRINT" ax²+bx+c= 0 ":COLOR 7,0
200 PRINT:PRINT " This program calculates 2 values of x:"
210 PRINT "  x1 when b²-4ac >= 0  (if b²-4ac < 0 THEN x1 cannot be calculated)"
220 PRINT "  x2 when b²+4ac >= 0  (if b²-4ac < 0 THEN x2 cannot be calculated)"
230 PRINT"        (ref. Machinery's Handbook, revised 21st edition, page 118)"
240 PRINT :LN=CSRLIN:GOSUB 340
250 INPUT " ENTER: Value of a";A:IF A=0 THEN 250
260 INPUT " ENTER: Value of b";B
270 INPUT " ENTER: Value of c";C
280 X1=(-B+SQR(B^2+(4*A*C)))/2*A
290 X2=(-B-SQR(B^2+(4*A*C)))/2*A
300 GOSUB 340:PRINT
310 PRINT " ";:COLOR 0,7:PRINT  " a="A"█ b="B "█ c="C "█ x="X1 "or"X2
320 COLOR 7,0:PRINT:PRINT " Select the value of x that suits your application."
330 GOSUB 460:GOTO 70
340 :REM'.....eraser
350 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
360 :REM'.....error
370 GOSUB 350
380 PRINT :COLOR 0,7
390 PRINT " Error in line";ERL
400 PRINT " Values entered are not valid: ";
410 IF ERL=280 THEN PRINT " b²+4ac must be greater than zero."
420 IF ERL=290 THEN PRINT " b²-4ac must be greater than zero."
430 PRINT :PRINT ".....press any key....."
440 Z$=INKEY$:IF Z$=""THEN 440
450 COLOR 7,0:GOTO 80
460 :REM'.....PRINT
470 KEY OFF:GOSUB 540:LOCATE 25,5:COLOR 0,2
480 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
490 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
500 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 500 :ELSE GOSUB 540
510 IF Z$="3"THEN RETURN
520 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
530 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 470
540 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
