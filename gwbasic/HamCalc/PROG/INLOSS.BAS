10 :REM'INLOSS - Insertion Loss - 17 Aug 2009
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$,QU
60 :REM'.....START
70 COLOR 15,2
80 PRINT " INSERTION LOSS"TAB(57)"by George Murphy VE3ERP ";
90 COLOR 7,0:PRINT STRING$(80,205);
100 COLOR 15,2:LOCATE CSRLIN-1,24:PRINT " (algorithm by R.J.Dehoney IEEE) "
110 COLOR 7,0
120 PRINT " This program finds the insertion loss of a resonant tank coupled to a source"
130 PRINT " and load. Required inputs are the unloaded Q of the tank and the loaded Q of"
140 PRINT " the final circuit. Insertion loss is the relative power absorbed by the tank."
150 PRINT
160 LN=CSRLIN:PRINT " .....Press (1) to continue or (0) to EXIT....."
170 Z$=INKEY$:IF Z$=""THEN 170
180 IF Z$="0"THEN CLS:RUN GO$
190 IF Z$="1"THEN GOSUB 330:GOTO 210
200 GOTO 180
210 :REM'..... data entry"
220 PRINT
230 INPUT " ENTER: Final circuit Q...";QL
240 PRINT " For loss of 0.5 db or less, a minimum unloaded tank Q of";18*QL;"is recommanded!"
250 INPUT " ENTER: Unloaded tank Q...";QU
255 IF QU<QL THEN BEEP:GOTO 230
260 GOSUB 330
270 X=QL/QU :ILDB=20*LOG(1/(1-X))/LOG(10) :IL=100*(1-(1-X)^2)
280 PRINT
290 PRINT " Final circuit Q........";QL
300 PRINT " Unloaded tank Q........";QU
310 PRINT :PRINT USING " Insertion Loss = ##.## % or ##.## dB";IL;ILDB
320 GOTO 360
330 :REM'.....CLS to bottom
340 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
350 RETURN
360 :REM'.....end
370 GOSUB 380:CLS:IF GO$="helreson"THEN CHAIN GO$ :ELSE 60
380 :REM'.....PRT
390 KEY OFF:GOSUB 460:LOCATE 25,5:COLOR 0,2
400 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
410 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
420 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 420 :ELSE GOSUB 460
430 IF Z$="3"THEN RETURN
440 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
450 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 390
460 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
