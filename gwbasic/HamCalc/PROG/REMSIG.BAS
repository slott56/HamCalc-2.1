10 :REM'REMSIG - 18 DEC 2010
20 :REM'REMSIG - 17 DEC 2010
30 CLS:KEY OFF
40 IF EX$=""THEN EX$="EXIT"
50 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
60 COMMON EX$,PROG$
70 :REM'.....title page
80 COLOR 15,2
90 PRINT " REMOTE SIGNAL LAMP"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 7,0
110 :REM'.....start
120 PRINT ""
130 PRINT "                             K1nc*──────┐"
140 PRINT "     ┌*─────┬────────────────────*K1cp  S1 (LP on/off)"
150 PRINT "     │      │T1┌──>├─* to *┐ K1no*───>├─┤"
160 PRINT "     │      >││<  D1   PB. │         D3 │"
170 PRINT "   110vAC   >││<12vAC      └─┤<─┐       LP"
180 PRINT "     │      >││<             D2 │       │"
190 PRINT "     │      │  └─────────────K1─┘       │"
200 PRINT "     └*─────┴───────────────────────────┘"
210 PRINT
220 PRINT " T1......... 110/12 volt 300 ma. transformer"
230 PRINT " S1..........SPST switch"
240 PRINT " D1,D2,,,,,,,1N4001 rectifier diode"
250 PRINT " D3..........1N5402 3A. rectifier diode"
260 PRINT " K1..........12 vDC SPDT relay"
270 PRINT " PB..........Remote pushbutton"
280 PRINT " LP..........110 v. signal lanp in out-of-sight location"
290 PRINT
300 PRINT " This device signals anyone at a remote location where the signal lamp is"
310 PRINT " located. When the pushtton is pushed, if tha lamp is off it will turn on."
320 PRINT " If on, it will go dim."
325 GOSUB 330:GOTO 70
330 :REM'.....PRT
340 KEY OFF:GOSUB 410:LOCATE 25,5:COLOR 0,2
350 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
360 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
370 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 370 :ELSE GOSUB 410
380 IF Z$="3"THEN CLS:RUN EX$
390 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
400 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 340
410 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
