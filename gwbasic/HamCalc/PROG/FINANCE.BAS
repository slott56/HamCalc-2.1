10 :REM'FINANCE -Financial Calculators - 30 DEC 2000 rev.
20 CLS:KEY OFF
30 PROG$="finance"
40 IF EX$=""THEN EX$="EXIT"
50 COMMON EX$,PROG$
60 COLOR 7,0,1
70 DIM A$(7),B$(7),C$(7)
80 UL$=STRING$(80,205)
90 FOR N=1 TO 7:READ A$(N),B$(N),C$(N):NEXT N
100 :REM'
110 :REM'.....start
120 CLS
130 COLOR 15,2
140 PRINT " FINANCIAL CALCULATORS";TAB(57)"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 GOSUB 420 :REM'preface
180 PRINT UL$;
190 PRINT " Press letter in ( ) to select:"
200 PRINT UL$;
210 :REM'
220 FOR N=1 TO 7
230 PRINT TAB(10)"(";A$(N);")  ";C$(N)
240 IF N=7 THEN PRINT
250 NEXT N
260 :REM'
270 Z$=INKEY$
280 IF Z$="g"THEN CLS:CHAIN EX$
290 FOR Z=1 TO 7
300 IF Z$=A$(Z)THEN CLS:CHAIN B$(Z)
310 NEXT Z
320 GOTO 270
330 :REM'
340 DATA a,mortgag,Mortgage Calculator
350 DATA b,loanpay,Monthly Time Payment Calculator (approximate)
360 DATA c,mortgag,Monthly Time Payment Calculator (exact)
370 DATA d,compint,Compound Interest Calculator
380 DATA e,deprec,Depreciation Schedule Calculator
390 DATA f,buysell,Markup/Markdown Calculator
400 DATA g,exit,EXIT
410 :REM'
420 :REM'.....preface
430 PRINT " These programs may be of interest if you are thinking about buyi";
440 PRINT "ng a new rig, "
450 PRINT " antenna farm, car or QTH."
460 RETURN
