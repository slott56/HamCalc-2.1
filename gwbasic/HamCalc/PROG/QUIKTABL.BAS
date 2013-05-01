10 :REM'QUIKTABL - math tables - 07 JUN 2002
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 PROG$="quiktabl"
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 UL$=STRING$(80,205)
80 :REM'
90 :REM'.....title page
100 CLS
110 COLOR 15,2,1
120 PRINT " QuikTables"TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 :REM'
160 COLOR 0,7
170 PRINT " Press letter in ( ) to select:":COLOR 7,0
180 PRINT "  (a) A.W.G. wire sizes"
190 PRINT "  (b) Circles - properties of"
200 PRINT "  (c) Decibels"
210 PRINT "  (d) Decimal numbers to degrees/minutes/seconds"
220 PRINT "  (e) Decimals to fractions"
230 PRINT "  (f) Degrees to radians"
240 PRINT "  (g) Degrees/minutes/seconds to decimal"
250 PRINT "  (h) Equivalent values"
260 PRINT "  (i) Fractions to decimals"
270 PRINT "  (j) Logarithms"
280 PRINT "  (k) Numbers - functions of"
290 PRINT "  (l) Powers of numbers"
300 PRINT "  (m) Prime numbers"
310 PRINT "  (n) Radians to degrees"
320 PRINT "  (o) Reciprocals of numbers"
330 PRINT "  (p) Roots of numbers"
340 PRINT "  (q) Temperature"
350 PRINT "  (r) Triangles - solution of"
360 PRINT "  (s) Trigonometric functions"
370 PRINT
380 PRINT "  (z) EXIT this program";
390 :REM'
400 Z$=INKEY$:IF Z$=""THEN 400
410 IF Z$="z"THEN CHAIN"\hamcalc\menu\hcal"
420 IF Z$="a"THEN CHAIN"awgexact"
430 IF Z$="b"THEN CHAIN"propcirc"
440 IF Z$="c"THEN CHAIN"decibel"
450 IF Z$="d"OR Z$="g"THEN CHAIN"deciconv"
460 IF Z$="e"OR Z$="i"THEN CHAIN"decifrac"
470 IF Z$="f" OR Z$="h"OR Z$="n"OR Z$="q"THEN CHAIN"equiv"
480 IF Z$="j"OR Z$="k"OR Z$="l"OR Z$="l"OR Z$="o"OR Z$="p"THEN CHAIN"numderiv"
490 IF Z$="m"THEN CHAIN"primenos"
500 IF Z$="r"THEN CHAIN"solutri"
510 IF Z$="s"THEN CHAIN"trig"
520 GOTO 400
