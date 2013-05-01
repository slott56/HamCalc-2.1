10 :REM'BUYSELL - 28 OCT 97, rev. 29 DEC 2000
20 IF EX$=""THEN EX$="exit"
30 CLS:KEY OFF
40 IF EX$=""THEN EX$="EXIT"
50 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
60 COMMON EX$,PROG$
70 COLOR 7,0,1
80 DIM I$(7),V(7)
90 E$=STRING$(80,32)
100 U$="###,###.##"
110 UN$="###,###"
120 PC$="###,###.## %"
130 UP$="###,###.### per unit"
140 DATA " Total Selling Price...."
150 DATA " Unit Selling Price....."
160 DATA " Markdown %............."
170 DATA " No.of Units............"
180 DATA " Markup %..............."
190 DATA " Unit Cost Price........"
200 DATA " Total Cost Price......."
210 FOR Z=1 TO 7:READ I$(Z):NEXT Z
220 :REM'
230 :REM'.....start
240 COLOR 15,2
250 PRINT " MARKUP/MARKDOWN CALCULATOR";TAB(57)"by George Murphy VE3ERP ";
260 COLOR 1,0:PRINT STRING$(80,223);
270 COLOR 7,0
280 :REM'
290 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
300 LOCATE 3:GOSUB 1100
310 PRINT
320 COLOR 0,7:LOCATE ,24
330 PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
340 Z$=INKEY$:IF Z$=""THEN 340
350 IF Z$="0"THEN CLS:CHAIN GO$
360 IF Z$="1"THEN 390
370 GOTO 340
380 :REM'
390 VIEW PRINT 12 TO 24:CLS:VIEW PRINT:LOCATE 12
400 GOSUB 1290
410 PRINT
420 COLOR 0,7:PRINT " ENTER:";:COLOR 7,0:PRINT I$(4);:INPUT V(4)
430 IF V(4)=0 THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 420
440 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
450 GOSUB 850
460 :REM'
470 :REM'.....input known values
480 LN=16
490 IF V(1)*V(2)*V(3)*V(4)*V(5)*V(6)*V(7)=0 THEN 510
500 GOTO 680
510 LOCATE LN:COLOR 0,7
520 PRINT " Press a letter in ( ) to ENTER a known factor:"
530 COLOR 7,0
540 PRINT " or press SPACE BAR to QUIT."
550 Z$=INKEY$:IF Z$=" "THEN ERASE V:GOTO 290
560 IF Z$="z"THEN 680
570 IF Z$>="a"AND Z$<="g"THEN 580 :ELSE 550
580 Z=ASC(Z$)-96
590 IF Z=3 AND V(5)<>0 THEN 790
600 IF Z=5 AND V(3)<>0 THEN 790
610 IF V(Z)=0 THEN 630
620 BEEP:LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 470
630 LOCATE LN:PRINT E$;:LOCATE LN
640 COLOR 0,7:PRINT " ENTER:";:COLOR 7,0:PRINT I$(Z);:INPUT V(Z)
650 GOSUB 850
660 GOTO 470
670 :REM'
680 :REM'.....sales tax
690 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:COLOR 0,7
700 INPUT " ENTER: Sales Tax(es) % or 0 if not applicable";TAX:COLOR 7,0
710 ST=TAX/100*V(1)
720 LOCATE CSRLIN-1:PRINT E$;:COLOR 7,0:LOCATE 12,52:PRINT STRING$(9,205)
730 LOCATE ,27:PRINT TAX;"% Sales Tax(es)";:LOCATE ,51:PRINT USING U$;ST
740 LOCATE ,28:PRINT "Bottom Line............";USING U$;V(1)+ST
750 LOCATE ,52:PRINT STRING$(9,205)
760 COLOR 0,7:LOCATE ,31:PRINT " Press any key......":COLOR 7,0
770 IF INKEY$=""THEN 770 :ELSE ERASE V:GOTO 290
780 :REM'
790 :REM'.....markup/markdown warning
800 BEEP:COLOR 0,7:PRINT " The computer will calculate";I$(Z):COLOR 7,0
810 PRINT " Press any key to continue......"
820 IF INKEY$=""THEN 820
830 VIEW PRINT LN TO 24:CLS:VIEW PRINT:GOTO 470
840 :REM'
850 :REM'.....calculate
860 IF V(1)=0 AND V(2)<>0      THEN V(1)=V(2)*V(4):             GOTO 850
870 IF V(2)=0 AND V(1)<>0      THEN V(2)=V(1)/V(4):             GOTO 850
880 IF V(3)=0 AND V(1)*V(7)<>0 THEN V(3)=(V(1)-V(7))/V(1)*100:  GOTO 850
890 IF V(1)=0 AND V(3)*V(7)<>0 THEN V(1)=V(7)*(1/(1-V(3)/100)): GOTO 850
900 IF V(1)=0 AND V(5)*V(7)<>0 THEN V(1)=(1+V(5)/100)*V(7):     GOTO 850
910 :REM'
920 IF V(7)=0 AND V(3)*V(1)<>0 THEN V(7)=(1-V(3)/100)*V(1):     GOTO 850
930 IF V(7)=0 AND V(5)*V(1)<>0 THEN V(7)=V(1)*(1/(1+V(5)/100)): GOTO 850
940 IF V(5)=0 AND V(1)*V(7)<>0 THEN V(5)=(V(1)-V(7))/V(7)*100:  GOTO 850
950 IF V(6)=0 AND V(7)<>0      THEN V(6)=V(7)/V(4):             GOTO 850
960 IF V(7)=0 AND V(6)<>0      THEN V(7)=V(6)*V(4):             GOTO 850
970 :REM'.....print
980 LOCATE 3:X=20
990 FOR Z=7 TO 1 STEP-1
1000 IF Z=4 OR Z=3 THEN PRINT
1010 X$=U$
1020 IF Z=2 OR Z=6 THEN X$=UP$
1030 IF Z=3 OR Z=5 THEN X$=PC$
1040 IF Z=4 THEN X$=UN$:COLOR 0,7 :ELSE COLOR 7,0
1050 LOCATE ,X:PRINT "( ";CHR$(96+Z);" )  ";I$(Z);
1060 IF V(Z)=0 THEN PRINT " " :ELSE PRINT USING X$;V(Z);:PRINT " "
1070 NEXT Z
1080 RETURN
1090 :REM'
1100 :REM'.....preface
1110 T=7
1120 PRINT TAB(T);
1130 PRINT"This program is equally at home in the flea market, the supermarket,"
1140 PRINT TAB(T);
1150 PRINT "or the Real Estate market. It calculates total and unit selling and"
1160 PRINT TAB(T);
1170 PRINT "cost prices, as well as markups, markdowns (discounts), and sales"
1180 PRINT TAB(T);
1190 PRINT "taxes (if any)."
1200 PRINT
1210 PRINT TAB(T);
1220 PRINT "Enter all values in the same currency unit (e.g., dollars, cents,"
1230 PRINT TAB(T);
1240 PRINT "rubles, yen, etc.). Calculated values will be in the same currency"
1250 PRINT TAB(T);
1260 PRINT "units."
1270 RETURN
1280 :REM'
1290 :REM'.....note units
1300 PRINT TAB(T);
1310 PRINT "In order to calculate unit cost and/or unit price, please let the"
1320 PRINT TAB(T);
1330 PRINT "computer know how many units are to be costed/priced. A unit can"
1340 PRINT TAB(T);
1350 PRINT "be a single thing (e.g., bottle), a quantity (e.g., dozen), a"
1360 PRINT TAB(T);
1370 PRINT "measurement (e.g., litre), etc."
1380 PRINT
1390 PRINT TAB(T);
1400 PRINT "If you are not interested in cost/price per unit, enter 1."
1410 RETURN
