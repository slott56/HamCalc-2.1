10 :REM'LOSSY - SWR vs. Line Loss  -  6 DEC 2003
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 UL$=STRING$(80,205)
80 :REM'
90 :REM'.....title page
100 CLS
110 COLOR 15,2,1
120 PRINT " SWR vs. Line Loss"TAB(60)"by Robert J. DeHoney ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 :REM'
160 :REM'.....start
170 PRINT "This program finds the attenuation factor in dB/100 feet for a ";
180 PRINT "transmission"
190 PRINT "line or feeder. It requires the user to input the length and ";
200 PRINT "measured SWR of "
210 PRINT "the line when terminated in a short or open condition."
220 PRINT
230 COLOR 0,7:PRINT " to run program....press 1 "
240 PRINT " to EXIT...........press 0 ":COLOR 7,0
250 PRINT
260 Z$=INKEY$:IF Z$=""THEN 260
270 IF Z$="1"THEN 310
280 IF Z$="0"THEN CHAIN GO$
290 GOTO 260
300 :REM'
310 :REM'.....data input
320 INPUT "ENTER:Line or feeder length in feet........ ";L
330 INPUT "ENTER:SWR of the shorted or open line...... ";SWR
340 PRINT
350 ATT=LOG((SWR+1)/(SWR-1))/2/L :REM'nepers/foot
360 ATTDB=ATT*100/0.11509999632835388! :REM'dB/100ft
370 U$=" Line attenuation factor is ##.### dB/100ft"
380 COLOR 0,7:PRINT USING U$;ATTDB:COLOR 7,0
390 PRINT
400 GOTO 420
410 :REM'
420 :REM'.....end
430 GOSUB 450:GOTO 90
440 :REM'
450 :REM'.....PRT
460 KEY OFF:GOSUB 530:LOCATE 25,5:COLOR 0,2
470 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
480 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
490 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 490 :ELSE GOSUB 530
500 IF Z$="3"THEN RETURN
510 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
520 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 460
530 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
