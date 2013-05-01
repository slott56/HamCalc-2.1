10 :REM'BINARY - R.J.Dehoney 1/19/07
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'
70 :REM'.....title page
80 CLS
90 COLOR 15,2,0
100 PRINT " Decimal to Binary Converter"TAB(61)"by R.J.Dehoney IEEE ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 PRINT " This program finds the binary representation of a decimal number."
140 PRINT " It is limited to 24 binary digits (decimal 16777216)."
150 PRINT:PRINT " Press 1 to continue or 0 to EXIT."
160 Z$=INKEY$:IF Z$=""THEN 160
170 IF Z$="0"THEN CLS:RUN EX$
180 IF Z$="1"THEN 210
190 GOTO 160
200 :REM'
210 :REM'.....start
220 CLS:COLOR 7,0,0
230 INPUT "ENTER: Decimal number to be converted or 0 to Quit";W0
240 IF W0=0 THEN 70
250 DIM W(24),X(24),D(24)
260 N=INT(LOG(W0)/LOG(2)) :W(N)=W0
270 FOR M=N TO 1 STEP -1
280 W(M-1)=W(M)-2^M
290 IF W(M-1)>=0 THEN D(M)=1
300 IF W(M-1)=0 THEN 340
310 IF W(M-1)<0 THEN W(M-1)=W(M)
320 NEXT M
330 D(0)=1
340 PRINT :PRINT "24 bit Binary representation of"W0""
350 FOR M=23 TO 0 STEP -1
360 PRINT USING "#";D(M);
370 NEXT M
380 PRINT :PRINT : RUN 230
