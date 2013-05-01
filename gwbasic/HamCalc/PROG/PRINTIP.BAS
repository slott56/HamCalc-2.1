10 :REM'PRINTIP - 20 FEB 2005 - rev. 25 OCT 2010
20 CLS:KEY OFF
30 COMMON EX$
35 IF EX$=""THEN EX$="exit"
40 PRINT " PRINTER TIPS"
50 PRINT STRING$(80,205);
60 :REM'COLOR 0,7
70 :REM'PRINT " HAMCALC does not support USB printer connections.                  "
80 :REM'PRINT " Your printer must be connected to a parallel port of your computer."
90 :REM'PRINT " Printer must support MS-DOS printer control codes.                 "
100 COLOR 7,0
110 :REM'PRINT
120 PRINT " HAMCALC does not contain any printer dr";
130 PRINT  "ivers. It utilizes the default settings"
140 PRINT " of your printer, so if your printer pro";
150 PRINT  "duces strange results, it may be       "
160 PRINT " necessary to change its default setting";
170 PRINT  "s. This will not affect the printouts "
180 PRINT " of other programs containing printer d";
190 PRINT  "rivers to set up the printer for their"
200 PRINT " own use. You can reset the printer to ";
210 PRINT  "its default settings at any time by   "
220 PRINT " turning it off, then on again.        "
230 PRINT
240 COLOR 0,7:PRINT  " Recommended Default Settings (to match GWBASIC): "
250 COLOR 7,0:PRINT
260 PRINT " Type Font.................. Courier"
270 PRINT " Type Size.................. 12 point"
280 PRINT " Pitch...................... 10 CPI (characters per inch)"
290 PRINT " Character (Symbol) Set..... PC-8 (ASCII Code Page 437)"
300 PRINT " Line Spacing............... 6 lines per inch"
310 PRINT " Page width................. 8-1/2 inches"
312 PRINT
320 GOSUB 350
330 CLS:CHAIN "addons"
340 :REM'
350 :REM'PRT
360 KEY OFF:GOSUB 430:LOCATE 25,5:COLOR 0,2
370 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
380 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
390 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 390 :ELSE GOSUB 430
400 IF Z$="3"THEN RETURN
410 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
420 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 360
430 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
