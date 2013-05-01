10 :REM'BANDQ - Bandwidth vs. Q - Loaded Circuits - 10 JUN 01  rev.26 JUL 01
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="bandQ"
60 COMMON EX$,PROG$
70 UL$=STRING$(80,205)
80 COLOR 7,0,0
90 :REM'
100 :REM'.....title page
110 Q=0:R=0:X=0:F=0:B=0
120 CLS:COLOR 15,2
130 PRINT " BANDWIDTH vs. Q, Loaded Resonant Circuits";
140 PRINT TAB(57)"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 PRINT TAB(12)"(Ref: ARRL 2000 Handbook for Radio Amateurs, page 6.41)"
180 PRINT UL$;
190 VIEW PRINT 10 TO 24:CLS:VIEW PRINT:LOCATE 10:PRINT UL$;
200 COLOR 0,7:LOCATE ,(23):PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
210 Z$=INKEY$:IF Z$=""THEN 210
220 IF Z$="0"THEN CLS:CHAIN GO$
230 IF Z$="1"THEN 260
240 GOTO 210
250 :REM'
260 :REM'.....start
270 IF X*F=0 THEN Q=0:R=0:X=0:F=0:B=0   :REM'X & F may be chained from TUNECCT"
280 VIEW PRINT 11 TO 24:CLS
290 COLOR 0,7:PRINT " If value not known, press <ENTER>, otherwise: ":COLOR 7,0
300 :REM'
310 :REM'.....data input
320 VIEW PRINT 12 TO 24:CLS:VIEW PRINT:LOCATE 12
330 GOSUB 620
340 IF Q THEN 370
350 PRINT " ENTER: Loaded Q of resonant circuit, if known..................Q=";
360 INPUT Q:GOSUB 520
370 IF R THEN 400
380 PRINT " ENTER: Load resistance, if known...............................Ω=";
390 INPUT R:GOSUB 520
400 IF X THEN 430
410 PRINT " ENTER: Either inductive or capacitive reactance, if known......Ω=";
420 INPUT X:GOSUB 520
430 IF F THEN 460
440 PRINT " ENTER: Frequency, if known...................................MHz=";
450 INPUT F:GOSUB 520
460 IF B THEN 500
470 PRINT " ENTER: Bandwidth, if known...................................kHz=";
480 INPUT B:B=B*10^-3:GOSUB 520
490 IF Q*R*X*F*B THEN GOSUB 620:GOTO 780
500 GOTO 320
510 :REM'
520 :REM'.....calculate
530 IF Q=0 AND R*X<>0 THEN Q=R/X:GOTO 520
540 IF R=0 AND Q*X<>0 THEN R=Q*X:GOTO 520
550 IF X=0 AND Q*R<>0 THEN X=R/Q:GOTO 520
560 IF B=0 AND F*Q<>0 THEN B=F/Q:GOTO 520
570 IF F=0 AND B*Q<>0 THEN F=B*Q:GOTO 520
580 IF Q=0 AND B*F<>0 THEN Q=F/B:GOTO 520
590 GOSUB 620
600 RETURN
610 :REM'
620 :REM'.....screen display
630 VIEW PRINT 5 TO 9:CLS:VIEW PRINT:LOCATE 5
640 P$="        Loaded Q of resonant circuit................Q="
650 IF Q THEN PRINT P$;USING " #######.#  ";Q
660 P$="        Load resistance.............................R="
670 IF R THEN PRINT P$;USING " ###,###.# ohms";R
680 P$="        Inductive and capacitive reactances, each...X="
690 IF X THEN PRINT P$;USING " ###,###.# ohms";X
700 P$="        Frequency...................................F="
710 IF F THEN PRINT P$;USING " ###,###.### MHz";F
720 P$="        Bandwidth.................................. B="
730 IF B THEN PRINT P$;USING " ###,###.# kHz";B*10^3
740 IF Q*R*X*F*B THEN 780
750 VIEW PRINT 12 TO 24:CLS
760 RETURN
770 :REM'
780 VIEW PRINT 11 TO 24:CLS:VIEW PRINT
790 COLOR 0,7:LOCATE 11,7
800 PRINT " Want to use one of the above values in another calculation? (y/n)"
810 COLOR 7,0
820 Z$=INKEY$:IF Z$=""THEN 820
830 IF Z$="y"THEN 870
840 IF Z$="n"THEN VIEW PRINT 11 TO 24:CLS:VIEW PRINT:GOTO 990
850 GOTO 820
860 :REM'
870 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11,18
880 COLOR 0,7):PRINT " Want to retain Q,R,X,F, or B?   (q/r/x/f/b)":COLOR 7,0
890 Z$=INKEY$:IF Z$=""THEN 890
900 IF Z$="q"THEN R=0:X=0:F=0:B=0:GOSUB 620:GOTO 960
910 IF Z$="r"THEN Q=0:X=0:F=0:B=0:GOSUB 620:GOTO 960
920 IF Z$="x"THEN Q=0:R=0:F=0:B=0:GOSUB 620:GOTO 960
930 IF Z$="f"THEN Q=0:R=0:X=0:B=0:GOSUB 620:GOTO 960
940 IF Z$="b"THEN Q=0:R=0:X=0:F=0:GOSUB 620:GOTO 960
950 GOTO 890
960 GOTO 280
970 :REM'
980 :REM'.....end
990 GOSUB 1010:GOTO 100
1000 :REM'
1010 :REM'.....PRT
1020 KEY OFF:GOSUB 1090:LOCATE 25,5:COLOR 0,2
1030 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1040 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1050 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1050 :ELSE GOSUB 1090
1060 IF Z$="3"THEN RETURN
1070 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1080 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1020
1090 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
