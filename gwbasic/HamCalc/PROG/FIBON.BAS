10 :REM'FIBON - Fibonacci Numbers - 16 Oct 2004 rev. 26 APR 2009
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'
70 :REM'.....title page
80 CLS
90 COLOR 15,2
100 PRINT " FIBONACCI SERIES of Numbers"TAB(57)"by George Murphy VE3ERP ";
110 PRINT
120 COLOR 7,0
130 :REM'
140 PRINT "A Fibonacci series is a series of numbers, positive or negative, in";
150 PRINT "teger or"
160 PRINT "decimal, where each number is the sum of the two preceding numbers."
170 PRINT
180 PRINT "The Fibonacci Ratio R is the value of any number in the series divi";
190 PRINT "ded by the"
200 PRINT "previous number. R approaches, but can never reach the Golden Ratio";
210 PRINT " Phi."
220 PRINT
230 PRINT "In cryptograhy (e.g., the DaVinci Code) the Golden Ratio Phi is, li";
240 PRINT "ke the value"
250 PRINT "of Pi, an irrational number."
260 PRINT
270 COLOR 0,7:PRINT " EQUATIONS: ":COLOR 7,0
280 PRINT " Pi= 4 x arctangent of 1 radian."
290 PRINT " Phi= (1/r+1), where r is the Fibonacci Ratio."
300 PRINT " n = nr² + nr where n is a Finonacci number."
310 PRINT
320 COLOR 0,7:PRINT " Commonly accepted practical values are: ":COLOR 7,0
330 :REM'PRINT
340 PI#=ATN(1)*4
350 PRINT " Pi=";PI#;"(approx.)"
360 PRINT " Phi=1.618033989 (approx.)"
370 PHI#=1.618033989#
380 PRINT
390 COLOR 0,7
400 PRINT " To display progressive series (in ascending) order.....press 1 "
410 PRINT " To display regressive series (in descending) order.....press 2 "
420 PRINT " To EXIT program........................................press 0 "
430 COLOR 7,0
440 Z$=INKEY$:IF Z$="" THEN 440
450 IF Z$="0"THEN CLS:CHAIN EX$
460 IF Z$="1"THEN 550
470 IF Z$="2"THEN GOSUB 1070:GOTO 770
480 GOTO 440
490 PRINT " Want to (r)un program or (q)uit?    (r/q) ":COLOR 7,0
500 Z$=INKEY$:IF Z$="" THEN 400
510 IF Z$="r"THEN 70
520 IF Z$="q"THEN CLS:RUN EX$
530 GOTO 500
540 :REM'
550 :REM'.....start progressive series
560 COLOR 7,0,0:CLS
570 INPUT "ENTER: first number in progressive series";B
580 IF B=0 THEN B=1
590 A=0:C=0:R=0:P=0:N=3
600 CLS:GOSUB 1010
610 :REM'.....start loop
620 LOCATE N
630 IF R=0 OR R>10000000.0! THEN N=N-1
640 IF C>=10000000.0! THEN COLOR 0,7:PRINT " N>10 million":COLOR 7,0:GOTO 700
650 PRINT C,TAB(16)R,TAB(45)P,TAB(65)USING "#.######";D
660 IF N=23 THEN 700
670 N=N+1
680 A=B:B=C:C=A+B:R=C/B:P=1/R+1:D=P-(INT(PHI#*1000000.0!)/1000000.0!)
690 GOTO 610  :REM'continue loop
700 LOCATE 25,27:COLOR 0,7:PRINT " run program again?   (y/n) ";
710 COLOR 7,0
720 Z$=INKEY$
730 IF Z$="y"THEN 550
740 IF Z$="n"THEN 1220
750 GOTO 720
760 :REM'
770 :REM'.....start regressive series
780 COLOR 7,0,0:CLS
790 INPUT "ENTER: first number in regressive series";B
800 IF B<0 THEN B=B*SGN(B)
810 P=0:N=3:R=PHI#
820 CLS:GOSUB 1010
830 :REM'.....start loop
840 LOCATE N
850 IF C<1 OR P=0 THEN N=N-1
860 IF P<0 THEN 920
870 PRINT C,TAB(16)R,TAB(45)P,TAB(65)USING "#.######";D
880 IF N=23 THEN 940
890 N=N+1
900 C=B:B=C/R:A=C-B:R=B/A:P=1/R+1:D=P-(INT(PHI#*1000000.0!)/1000000.0!)
910 GOTO 830 :REM'continue loop
920 VIEW PRINT N TO 24:CLS:VIEW PRINT:LOCATE N:COLOR 0,7
930 PRINT " Further regression not feasible"
940 LOCATE 25,27:COLOR 0,7:PRINT " run program again?   (y/n) ";
950 COLOR 7,0
960 Z$=INKEY$
970 IF Z$="y"THEN 770
980 IF Z$="n"THEN 1220
990 GOTO 960
1000 :REM'
1010 :REM'.....column heading
1020 PRINT " N (number)"TAB(16)" R (ratio N/previous N)";
1030 PRINT TAB(45)" P (ratio 1/R+1)"TAB(65)"Diff. (P-Phi)"
1040 PRINT STRING$(79,205)
1050 RETURN
1060 :REM'
1070 :REM'.....regressive disclaimer
1080 CLS:COLOR 0,7:PRINT " WARNING!":COLOR 7,0
1090 PRINT
1100 PRINT "In calculating the second number in a regressive series, it is"
1110 PRINT "assumed that its ratio to the first number you specify is equal to"
1120 PRINT "Phi, which is only an approximation of an irrational value."
1130 PRINT
1140 PRINT "This can result in somewhat inaccurate regressive values being"
1150 PRINT "calculated and stoppage of further calculation when a negative"
1160 PRINT "value is reached."
1170 PRINT
1180 COLOR 0,7:PRINT ".....press any key to continue.....":COLOR 7,0
1190 Z$=INKEY$:IF Z$="" THEN 1190
1200 RETURN
1210 :REM'
1220 :REM'.....end
1230 GOSUB 1250:GOTO 70
1240 :REM'
1250 :REM'.....PRT
1260 KEY OFF:GOSUB 1330:LOCATE 25,5:COLOR 15,2
1270 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1280 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1290 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1290 :ELSE GOSUB 1330
1300 IF Z$="3"THEN RETURN
1310 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1320 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1260
1330 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
