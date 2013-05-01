10 :REM'CHASE - 22 JAN 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="exit"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="chase"
60 COMMON EX$,PROG$
70 :REM'.....title page
80 COLOR 15,2
90 PRINT " PROGRAM NAME"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 7,0
110 :REM'.....start
120 CLS:KEY OFF
130 EX$="exit"
140 PRINT " SPEED CHASE"
150 PRINT STRING$(79,205)
160 PRINT " If two entities are launched along the same path from the same spo";
170 PRINT "t at        "
180 PRINT " different times and speeds they will eventually meet. This program";
190 PRINT " describes  "
200 PRINT " the meeting. Times, speeds and distances can be in any units."
210 LN=CSRLIN:PRINT
220 :REM'.....data entry
230 INPUT " ENTER: speed of one of the entities";A
240 INPUT " ENTER: Time delay between launches";P :IF P=0 THEN P=9.999999747378752e-06!
250 INPUT " ENTER: speed of the other entity";B
260 IF A>B THEN SWAP A,B
270 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
280 PRINT " .....please wait....."
290 T=0
300 :REM'.....calculate
310 T=T+P
320 LOCATE LN,30:PRINT "   time =";T
330 DA=T*A
340 IF T<P THEN 310
350 DB=(T-P)*B
360 X=DB-DA
370 IF X>1 THEN 390
380 GOTO 310
390 PRINT
400 :REM'.....display
410 LOCATE LN:PRINT STRING$(79,32)
420 PRINT " TIME";:PRINT TAB(10)"EVENT"
430 PRINT STRING$(14,205)
440 PRINT " 0";:PRINT  TAB(10)"Slower entity launched at speed";A
450 IF P=9.999999747378752e-06! THEN P=0
460 PRINT P;:PRINT TAB(10)"Faster entity launched at speed"B
470 M=((T*A)+((T-P)*B))/2
480 PRINT INT(T*1000)/1000;
490 PRINT TAB(10)"Entities meet at distance"M
500 PRINT STRING$(79,205)
510 LOCATE,10:PRINT "Press F2 for another or F10 to exit."
520 END
