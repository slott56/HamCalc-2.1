10 :REM'MISMAT - Transmission Line Mismatch - 13 AUG 2009
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS
80 COLOR 15,2
90 PRINT " TRANSMISSION LINE MISMATCH"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 7,0:PRINT STRING$(80,205);
110 COLOR 15,2:LOCATE CSRLIN-1,24:PRINT " (algorithm by R.J.Dehoney IEEE) "
120 COLOR 7,0
130 :REM'-------------ERROR.BAS,rjd,8/8/09-----------------
140 A$=" Source Reflection Coefficient ="
150 B$=" Load Reflection Coefficient ="
160 C$=" Source VSWR ="
170 D$=" Load VSWR ="
180 E$=" Source Return Loss in dB ="
190 F$=" Load Return Loss in dB ="
200 :REM'.....start
210 PRINT
220 GOSUB 610
230 PRINT " This program calculates the max and min error caused by imperfect matching"
240 PRINT " between a source of power and a load."
250 PRINT " and return losses 10 dB or greater."
260 PRINT
270 PRINT " Press (1) to continue or (0) to EXIT"
280 Z$=INKEY$:IF Z$=""THEN 280
290 IF Z$="0"THEN RUN GO$
300 IF Z$="1"THEN LN=3:GOSUB 710:GOTO 320
310 GOTO 280
320 :REM'.....start program
330 PRINT
340 PRINT "                       ┌───────┐       ┌───────┐"
350 PRINT "                       │ Power │       │       │"
360 PRINT "                       │ Source├───────┤ Load  │"
370 PRINT "                       │       │       │       │"
380 PRINT "                       └───────┘       └───────┘"
390 PRINT ""
400 LN=CSRLIN
410 INPUT " ENTER: VSWR, return loss (dB), or reflection coefficient of the Source ";X :X=ABS(X)
420 INPUT " ENTER:  VSWR, return loss (dB), or reflection coefficient of the Load ";Y :Y=ABS(Y)
430 IF X<1 THEN RC1=X:X$=A$:GOTO 460 :REM'          X must be reflection coefficient
440 IF X<10 THEN RC1=(X-1)/(X+1):X$=C$:GOTO 460 :REM'X must be VSWR
450 IF X=>10 THEN RC1=10^(-X/20):X$=E$ :REM'        X must be return loss in dB
460 IF Y<1 THEN RC2=Y:Y$=B$:GOTO 490 :REM'          Y must be reflection coefficient
470 IF Y<10 THEN RC2=(Y-1)/(Y+1):Y$=D$:GOTO 490:REM' Y must be VSWR
480 IF Y=>10 THEN RC2=10^(-Y/20):Y$=F$:PRINT :REM'  Y must be return loss in dB
490 ME1=10*LOG((1+RC1*RC2)^2/(1-RC1^2)/(1-RC2^2))/LOG(10)
500 ME2=10*LOG((1-RC1*RC2)^2/(1-RC1^2)/(1-RC2^2))/LOG(10)
510 GOSUB 700
520 PRINT
530 PRINT "if"
540 PRINT X$;X
550 PRINT "and"
560 PRINT Y$;Y
570 PRINT "then"
580 PRINT USING " MAXIMUM mismatch error = ##.### dB";ME1
590 PRINT USING " MINIMUM mismatch error = ##.### dB";ME2
600 GOTO 730
610 :REM'.....preamble
620 PRINT " There are many formulas claimimg to calculate mismatch loss, but the"
630 PRINT " ones herein have the virtue of giving results agreeing with Eq.1:"
640 PRINT "        Pout      Vout^2/RL"
650 PRINT " (Eq.1) ----- = -------------"
660 PRINT "        Pmax      Vin^2/4/RS"
670 PRINT " which has to be true for max and min power ratio. RL and RS are calculated"
680 PRINT " from R0 and the VSWRs."
690 RETURN
700 :REM'.....Clear bottom of screen
710 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
720 RETURN
730 :REM'.....end
740 GOSUB 750:GOTO 60
750 :REM'.....PRT
760 KEY OFF:GOSUB 830:LOCATE 25,5:COLOR 0,2
770 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
780 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
790 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 790 :ELSE GOSUB 830
800 IF Z$="3"THEN RETURN
810 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
820 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 760
830 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
