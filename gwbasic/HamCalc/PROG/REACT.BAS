10 :REM'REACT - Hamcalc Reactance programs - 21 JUL 08
20 CLS:KEY OFF
30 DIM P$(400)
40 IF EX$=""THEN EX$="exit"
50 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
60 PROG$="react"
70 COMMON EX$,PROG$
80 PRINT "HAMCALC Reactance progams"
90 PRINT
100 :REM'PRINT "...Press any key..."
110 :REM'Z$=INKEY$:IF Z$=""THEN 110
120 :REM'CLS
130 ON ERROR  GOTO 230
140 N=10
150 DATA ACCALC,A.C.Calculator
160 DATA FORMULAE,Formula Library
170 DATA IMPEDCCT,Reactance/Resistance Circuits
180 DATA TUNECCT,Tuned Circuit Design
190 N=N+1:READ A$,B$
200 PRINT N;TAB(5)A$,B$
210 P$(N)=A$
220 GOTO 150
230 INPUT "ENTER a 2 digit number to continue or 00 to exit";Z$
240 IF Z$="00"THEN CLS:RUN GO$
250 X=VAL(Z$):H$="\hamcalc\prog\"+P$(X):CHAIN H$
260 GOTO 240
