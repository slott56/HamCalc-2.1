10 :REM'HOTBOX - Heat loss - enclosures - 24 MAY 2008
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 GOTO 80
70 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
80 :REM'.....title page
90 COLOR 15,2
100 PRINT " HEAT DISSIPATION"TAB(61)"by R.J.DeHoney IEEE ";
110 COLOR 7,0:PRINT STRING$(80,205);
120 LN=CSRLIN
130 PRINT "This program uses equations from Sanjaya Maniktala's paper on convection"
140 PRINT "cooling. It calculates surface temperatures of a heated metal box."
150 PRINT
160 COLOR 0,7:PRINT " Press 1 to continue or 0 to exit.":COLOR 7,0
170 Z$=INKEY$:IF Z$=""THEN 170
180 IF Z$="0"THEN CLS:RUN EX$
190 IF Z$="1"THEN 210
200 GOTO 170
210 GOSUB 70
220 INPUT "Enter: Length (inches) of longest side of box";L
230 INPUT "Enter: Length (inches) of shortest side of box";H
240 INPUT "Enter: Length (inches) of other side of box";W
250 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
260 A1=2*L*H+2*W*H+L*W :REM'largest surface
270 PRINT " Box size ="L"x"W"x"H "inches"
280 LN=CSRLIN
290 PRINT  " Do you want temperatures in (c)elsius or (f)ahrenheit?  (c/f)"
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="c"THEN T$="°C"
320 IF Z$="f"THEN T$="°F"
330 PRINT " Enter ambient temperature in "+T$;
340 INPUT Z:IF Z$="f" THEN TF=Z:TC=(TF-32)/1.7999999523162842!
350 IF Z$="c"THEN TF=(1.7999999523162842!*Z)+32:TC=Z
360 GOSUB 70
370 INPUT " Enter power in watts dissipated inside box or 0 to quit";P
380 IF P=0 THEN 460
390 GOSUB 70
400 PRINT USING " Ambient temperature = ### °F = ###°C";TF,TC
410 PRINT STRING$(80,205);
420 LN=CSRLIN
430 T1=76.5!*P^0.800000011920929!/A1^0.699999988079071! :X=(1.809999942779541!*T1)+32:Y=T1
440 PRINT " Watts dissipated inside box =";P
450 PRINT USING " Surface tenperature of box  = ### °F = ### °C";X,Y
460 :REM'.....end
470 GOSUB 480:CLS:GOTO 80
480 :REM'.....PRT
490 KEY OFF:GOSUB 560:LOCATE 25,5:COLOR 0,2
500 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
510 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
520 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 520 :ELSE GOSUB 560
530 IF Z$="3"THEN RETURN
540 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
550 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 490
560 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
