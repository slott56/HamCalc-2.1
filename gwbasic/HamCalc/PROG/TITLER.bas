10 :REM'TITLER - 15 DEC 89   rev. 13 MAR 2000
20 CLEAR
30 SCREEN 9:SCREEN 0
40 COLOR 7,0,1:KEY OFF
50 CLS:DIM T$(24),L(24)
60 WIDTH 80
70 :REM'
80 :REM'.....print menu
90 :REM'
100 COLOR 15,1
110 PRINT " TITLER:";
120 COLOR 7,0
130 PRINT TAB(10);"A PROGRAM TO COMPOSE TITLES FOR YOUR ";
140 PRINT "SLIDE OR VIDEO PRESENTATIONS";
150 PRINT STRING$(80,205);
160 T$="The program will display text on the screen"
170 PRINT TAB((80-LEN(T$))/2);T$
180 T$="that you can copy with your camera or camcorder"
190 PRINT TAB((80-LEN(T$))/2);T$
200 PRINT STRING$(80,205);
210 COL=29
220 PRINT TAB(COL);"Press number in ( ) to:"
230 PRINT TAB(COL);"═══════════════════════"
240 PRINT TAB(COL);"     ( 1 )  Continue"
250 PRINT TAB(COL);"     ( 0 )  EXIT"
260 Z$=INKEY$
270   IF Z$="0"THEN CLS:RUN "fotomenu"
280   IF Z$="1"THEN 310
290 GOTO 260
300 :REM'
310 :REM'.....input text
320 :REM'
330 PRINT
340 COL=COL-3
350 PRINT TAB(COL);"Press number in ( ) to select:"
360 PRINT TAB(COL);"══════════════════════════════"
370 PRINT TAB(COL);"  ( 1 )  Single spaced lines"
380 PRINT TAB(COL);"  ( 2 )  Double spaced lines"
390 Z$=INKEY$
400 IF Z$="1"OR Z$="2"THEN 410 :ELSE 390
410 CLS:COLOR 7,0,0:LSPC=VAL(Z$)
420 L=0       :REM'line number
430 PRINT "Press ENTER if no further text is to be entered....."
440 PRINT STRING$(80,205);
450 :REM'
460 L=L+1:IF L>17 THEN 700
470 L$=RIGHT$(STR$(L),LEN(STR$(L))-1):IF L<10 THEN L$="0"+L$
480 :REM'
490 IF LSPC=1 THEN 520
500 IF L/2<>INT(L/2)THEN 520
510 IF L/2=INT(L/2)THEN PRINT:I$=" ":GOTO 620
520 PRINT "ENTER: text for line ";L$;": ";
530 COLOR 0,7:LINE INPUT I$:COLOR 7,0         :REM'input line
540 IF LEN(I$)<=32 THEN 620
550 :REM'
560 BEEP:LOCATE CSRLIN-1:COLOR 0,7
570 PRINT " Maximum number of characters & spaces = 32";
580 PRINT "....Press any key to continue...."
590 IF INKEY$=""THEN 590
600 COLOR 7,0:LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 520
610 :REM'
620 IF I$=""THEN 730 :ELSE 630
630 LGTH=LEN(I$)
640 IF LGTH>MAX THEN MAX=LGTH       :REM'MAX=length of longest line
650 MARG=(40-LGTH)/2                :REM'left margin
660 I$=STRING$(MARG,32)+I$+STRING$(40-LGTH,32)
670 T$(L)=I$
680 GOTO 460              :REM'enter next line
690 :REM'
700 PRINT "Maximum number of lines = 17.......Press any key to continue......"
710 IF INKEY$=""THEN 710
720 :REM'
730 :REM'.....proof read
740 :REM'
750 CLS
760   FOR Z=1 TO L
770     PRINT T$(Z)
780   NEXT Z
790 PRINT STRING$(40,205)
800 COLOR 0,7
810 LOCATE CSRLIN,7
820 PRINT " Is this layout OK?   (y/n) "
830 COLOR 7,0
840   Z$=INKEY$
850     IF Z$="n"OR Z$="N"THEN 10
860     IF Z$="y"OR Z$="Y"THEN 880 :ELSE 840
870 :REM'
880 :REM'.....select colours
890 CLS
900 FOR Y=0 TO 7:Y$=RIGHT$(STR$(Y),1)
910  FOR Z=1 TO 3
920   FOR X=8 TO 15
930    COLOR Y,0
940     IF X=Y THEN PRINT "          ";:GOTO 960
950     PRINT " ████████ ";
960   NEXT X
970  NEXT Z
980 IF Y<7 THEN LOCATE CSRLIN-2 :ELSE LOCATE CSRLIN-1
990  FOR W=0 TO 7:W$=RIGHT$(STR$(W),1)
1000   COLOR W+8,Y
1010   LOCATE CSRLIN,W*10+5
1020   PRINT W$;Y$;
1030  NEXT W
1040 LOCATE CSRLIN+1
1050 NEXT Y
1060 COLOR 7,0
1070 LOCATE 25,1
1080 INPUT "ENTER one of the above 2-digit numbers to select colour ";COL$
1090 LOCATE 1
1100 IF LEN(COL$)<>2 THEN 1580
1110 CH=VAL(LEFT$(COL$,1))+8   :REM'character colour
1120 BG=VAL(RIGHT$(COL$,1))    :REM'background colour
1130 IF CH>15 OR BG>7 OR CH=BG THEN 1580
1140 :REM'
1150 :REM'.....border option
1160 CLS
1170 COLOR 0,7
1180 PRINT " Do you want a border surrounding the title?   (y/n) ";
1190 Z$=INKEY$
1200 IF Z$="y"OR Z$="Y"THEN BOR=1:GOTO 1240
1210 IF Z$="n"OR Z$="N"THEN BOR=0:GOTO 1240
1220 GOTO 1190
1230 :REM'
1240 :REM'.....print display
1250 :REM'
1260 COLOR 7,0
1270 CLS
1280 WIDTH 40
1290 COLOR BG,0
1300  FOR Z=1 TO 23
1310   PRINT STRING$(40,219);
1320  NEXT Z
1330 LN=((23-L)/2)                     :REM'first line number
1340 LB=(40-MAX)/2-2:                  :REM'left border
1350 RB=40-LB+1                        :REM'right border
1360 BL=40-2*LB                        :REM'horizontal border length
1370 COLOR CH,BG
1380 LOCATE LN-1,LB
1390 IF BOR=0 THEN A=32:B=32:C=32:D=32:E=32:F=32
1400 IF BOR=1 THEN A=201:B=205:C=187:D=186:E=200:F=188
1410 PRINT CHR$(A);STRING$(BL,B);CHR$(C)
1420 :REM'
1430   FOR Z=1 TO L
1440     LOCATE LN+Z
1450     PRINT T$(Z)
1460   NEXT Z
1470 :REM'
1480   FOR X=0 TO L+1
1490     LOCATE LN+X,LB:PRINT CHR$(D);
1500     LOCATE LN+X,RB:PRINT CHR$(D)
1510   NEXT X
1520 :REM'
1530 LOCATE CSRLIN-1,LB
1540 PRINT CHR$(E);STRING$(BL,B);CHR$(F)
1550 COLOR 7,0
1560 IF INKEY$=""THEN 1560 :ELSE 10
1570 :REM'
1580 :REM'.....incorrect colour selection
1590 CLS
1600 PRINT COL$;" is not a valid number......press any key to try again...."
1610 IF INKEY$=""THEN 1610
1620 GOTO 880
