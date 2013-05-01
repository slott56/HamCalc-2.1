10 :REM'LPTSETUP - 13 AUG 92 rev. 30 OCT 2010
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$
40 CLS:COLOR 7,0,0
50 TB=7       :REM'tab for text
60 PRINT
70 PRINT TAB(TB);
80 PRINT "Hard copy printouts are made by scanning the screen for ASCII"
90 PRINT TAB(TB);
100 PRINT "characters and sending each character or space one-at-a-time to the"
110 PRINT TAB(TB);
120 PRINT "printer. Connect your printer to an LPT port of your computer.     "
130 PRINT
140 COLOR 14,4:PRINT TAB(TB);
150 PRINT "If your printer is connected to a USB port item (2) in the green "
160 PRINT TAB(TB);
170 PRINT "options bar may not work. See following pages for instructions.  "
180 COLOR 7,0:PRINT
190 PRINT TAB(TB);
200 PRINT "YOUR COMPUTER/PRINTER CONFIGURATION MUST SUPPORT STANDARD ASCII"
210 PRINT TAB(TB);
220 PRINT "CHARACTERS 128-254 (code page 437). This is the default character"
230 PRINT TAB(TB);
240 PRINT "set installed in most English language computers. Otherwise, the"
250 PRINT TAB(TB);
260 PRINT "procedure described below may produce graphics characters other    "
270 PRINT TAB(TB);
280 PRINT "than those shown on the screen display.                            "
290 PRINT
300 PRINT TAB(TB);
310 PRINT "The message below appears at the bottom of the screen whenever"
320 PRINT TAB(TB);
330 PRINT "appropriate. If you press <1> the message disappears and contents of"
340 PRINT TAB(TB);
350 PRINT "the screen are sent to the printer queue. If you press <2> the same"
360 PRINT TAB(TB);
370 PRINT "thing happens except the printer prints the page immediately and"
380 PRINT TAB(TB);
390 PRINT "ejects or advances the paper (in printer jargon this is called Form"
400 PRINT TAB(TB);
410 PRINT "Feed). In either case the message bar re-appears and you can either";
420 PRINT TAB(TB);
430 PRINT "print more copies of the screen or press (3) to continue with the"
440 PRINT TAB(TB);
450 PRINT "program."
460 GOSUB 490:CLS:CHAIN "printip"
470 END
480 :REM'
490 :REM'PRT
500 KEY OFF:GOSUB 570:LOCATE 25,5:COLOR 0,2
510 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
520 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
530 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 530 :ELSE GOSUB 570
540 IF Z$="3"THEN RETURN
550 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
560 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 500
570 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
