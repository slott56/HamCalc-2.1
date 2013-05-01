10 :REM'DIAMFIND - diameter finder - 21 DEC 02 rev. 06 JAN 03
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$
50 PI=4*ATN(1)  :REM'3.141593
60 :REM'
70 :REM'.....title page
80 CLS
90 COLOR 15,2,0
100 PRINT " Diameter Finder"TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 :REM'
140 :REM'.....diagram
150 COLOR 0,7:C=19
160 LOCATE ,C:PRINT "                                           "
170 LOCATE ,C:PRINT "            ║                              "
180 LOCATE ,C:PRINT "  ┌───╥╥╥╥╥╥╫───┐                          "
190 LOCATE ,C:PRINT "  │   ║║║║║║║   │«─ object being measured. "
200 LOCATE ,C:PRINT "  │  ─╫╫╫╫╫╫╫─ «┼ draw a line across turns."
210 LOCATE ,C:PRINT "  │   ║║║║║║║«──┼ several turns of fishing "
220 LOCATE ,C:PRINT "  └───╫╨╨╨╨╨╨───┘ line or heavy thread.    "
230 LOCATE ,C:PRINT "      ║                                    "
240 LOCATE ,C:PRINT "                                           "
250 COLOR 7,0
260 LN=CSRLIN
270 :REM'
280 PRINT
290 PRINT " This program measures the diameter of cylindrical objects such a";
300 PRINT "s coil forms, "
310 PRINT " cables of bunched wires, etc. with micrometer accuracy when a mi";
320 PRINT "crometer is   "
330 PRINT " not available."
340 PRINT
350 COLOR 0,7
360 LOCATE ,23:PRINT " Press 1 to continue or 0 to EXIT. ":COLOR 7,0
370 Z$=INKEY$:IF Z$=""THEN 370
380 IF Z$="0"THEN CLS:CHAIN EX$
390 IF Z$="1"THEN 410
400 :REM'.....start
410 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
420 PRINT
430 PRINT " Close-wind several turns of fishing line or thread around the ob";
440 PRINT "ject and with "
450 PRINT " a marking pen draw a line across the turns. Unwind the turns, co";
460 PRINT "unt the dots, "
470 PRINT " straighten the line and measure the distance between the first a";
480 PRINT "nd last dots. "
490 PRINT
500 PRINT " Any unit of measure can be used. Results will be in the same units."
510 PRINT
520 INPUT " ENTER: number of dots............................";N
530 INPUT " ENTER: distance between first and last dot.......";L
540 D=L/(PI*(N-1))
550 PRINT:COLOR 0,7:LOCATE ,25
560 PRINT USING " Diameter of object = ###.### ";D:COLOR 7,0
570 GOSUB 590:GOTO 70
580 :REM'
590 :REM'.....PRT
600 KEY OFF:GOSUB 670:LOCATE 25,5:COLOR 0,2
610 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
620 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
630 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 630 :ELSE GOSUB 670
640 IF Z$="3"THEN RETURN
650 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
660 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 600
670 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
