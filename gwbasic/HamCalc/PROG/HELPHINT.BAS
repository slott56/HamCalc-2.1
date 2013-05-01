10 :REM'HELPHINT - 17 AUG 92 rev. 17 DEC 2003
20 IF EX$=""THEN EX$="\hamcalc\menu\hcal"
30 COMMON EX$
40 COLOR 7,0,0
50 CLS:KEY OFF
60 PRINT:COLOR 0,7
70 PRINT " If the HAMCALC window does not fill the screen, press ALT-ENTER."
80 PRINT
90 PRINT " IMPORTANT! PLEASE READ THE INSTRUCTIONS PROVIDED WITH THE HAMCALC ";
100 PRINT "PROGRAM! "
110 COLOR 7,0
120 PRINT
130 PRINT " Most of these programs ask you to input data. If you are asked to ";
140 PRINT "enter some  ";
150 PRINT " data that you don't know, or that you want the computer to tell YO";
160 PRINT "U, just     ";
170 PRINT " press the <ENTER> key to by-pass the question.                    ";
180 PRINT "            "
190 PRINT
200 PRINT " Some of the data asked for is essential. In this case the computer";
210 PRINT " will keep  ";
220 PRINT " hounding you for it no matter how many times you try to dodge the ";
230 PRINT "question.   ";
240 PRINT " Don't worry if you by-pass a question you feel you should have ans";
250 PRINT "wered. The  ";
260 PRINT " computer will ask it again if it is something the computer really ";
270 PRINT "needs.      "
280 PRINT
290 PRINT " If a prompt begins with the word ENTER then type in the data and p";
300 PRINT "ress the    ";
310 PRINT " <ENTER> key. If you are prompted to PRESS a key then just press th";
320 PRINT "e indicated ";
330 PRINT " key. There is no need to press <ENTER> as well.                   ";
340 PRINT "            "
350 PRINT
360 PRINT " If something goes wrong press the CTRL key and hold it down while ";
370 PRINT "you press   ";
380 PRINT " the PAUSE/BREAK key. This will halt the program and a 'Break' mes";
390 PRINT "sage will   ";
400 PRINT " appear on the screen. Then press the F2 key to re-start the progr";
410 PRINT "am from the ";
420 PRINT " beginning, or the F10 key to return to GWBASIC. You can try this ";
430 PRINT "right now if";
440 PRINT " you wish, just to see how it works . . . . .                     ";
450 PRINT "            "
460 GOSUB 490
470 CLS:CHAIN"\hamcalc\prog\lptsetup"
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
