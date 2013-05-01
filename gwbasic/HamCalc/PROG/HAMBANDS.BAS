10 :REM'HAMBANDS - Ham Band Edges - 21 APR 95 rev.11 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 DIM F(15,3)
70 L$=" "+STRING$(78,205)
80 COLOR 15,2,1
90 PRINT " HAM BAND EDGE & CENTRE FREQUENCIES";
100 PRINT TAB(57);"by George Murphy VE3ERP ";
110 COLOR 1,7
120 PRINT STRING$(80,223);
130 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
140 COLOR 7,0
150 :REM'
160 DATA 1.8, 2, 3.5, 4, 7, 7.3, 10.1, 10.15, 14, 14.35, 18.068, 18.168
170 DATA 21, 21.45, 24.89, 24.99, 28, 29.7, 50, 54, 144, 148, 222, 225
180 DATA 420, 450,902, 928, 1240, 1300
190 :REM'
200 FOR Z=1 TO 15:READ F(Z,1):READ F(Z,3):NEXT Z
210 FOR Z=1 TO 15:F(Z,2)=SQR(F(Z,1)*F(Z,3)):NEXT Z
220 :REM'
230 :REM'.....screen display
240 COLOR 0,7
250 PRINT "        ┌                           ┌                           ┌ "
260 PRINT " 160 m.─┤*                    17 m.─┤*                     2 m.─┤*"
270 PRINT "  band  └                     band  └                     band  └ "
280 PRINT L$;
290 PRINT "        ┌                           ┌                           ┌ "
300 PRINT "  80 m.─┤*                    15 m.─┤*                  1.25 m.─┤*"
310 PRINT "  band  └                     band  └                     band  └ "
320 PRINT L$;
330 PRINT "        ┌                           ┌                           ┌ "
340 PRINT "  40 m.─┤*                    12 m.─┤*                   70 cm.─┤*"
350 PRINT "  band  └                     band  └                     band  └ "
360 PRINT L$;
370 PRINT "        ┌                           ┌                           ┌ "
380 PRINT "  30 m.─┤*                    10 m.─┤*                   33 cm.─┤*"
390 PRINT "  band  └                     band  └                     band  └ "
400 PRINT L$;
410 PRINT "        ┌                           ┌                           ┌ "
420 PRINT "  20 m.─┤*                     6 m.─┤*                   23 cm.─┤*"
430 PRINT "  band  └                     band  └                     band  └ "
440 PRINT L$;
450 PRINT "  * Centre Frequency = √(Bottom Edge Frequency x Top Edge Frequency)"
460 PRINT L$;
470 COLOR 7,0
480 :REM'
490 X=0
500 FOR Z=3 TO 19 STEP 4
510 X=X+1
520 COLOR 15,1
530 Y=F(X,1)   :GOSUB 800:LOCATE Z,11:PRINT USING U$;Y;:PRINT " MHz "
540 Y=F(X+5,1) :GOSUB 800:LOCATE Z,39:PRINT USING U$;Y;:PRINT " MHz "
550 Y=F(X+10,1):GOSUB 800:LOCATE Z,67:PRINT USING U$;Y;:PRINT " MHz "
560 COLOR 7,0
570 NEXT Z
580 :REM'
590 X=0
600 FOR Z=4 TO 20 STEP 4
610 X=X+1
620 COLOR 7,1
630 Y=F(X,2)   :GOSUB 800:LOCATE Z,11:PRINT USING U$;Y;:PRINT " MHz "
640 Y=F(X+5,2) :GOSUB 800:LOCATE Z,39:PRINT USING U$;Y;:PRINT " MHz "
650 Y=F(X+10,2):GOSUB 800:LOCATE Z,67:PRINT USING U$;Y;:PRINT " MHz "
660 COLOR 7,0
670 NEXT Z
680 :REM'
690 X=0
700 FOR Z=5 TO 21 STEP 4
710 X=X+1
720 COLOR 15,1
730 Y=F(X,3)   :GOSUB 800:LOCATE Z,11:PRINT USING U$;Y;:PRINT " MHz "
740 Y=F(X+5,3) :GOSUB 800:LOCATE Z,39:PRINT USING U$;Y;:PRINT " MHz "
750 Y=F(X+10,3):GOSUB 800:LOCATE Z,67:PRINT USING U$;Y;:PRINT " MHz "
760 COLOR 7,0
770 NEXT Z
780 GOTO 850
790 :REM'
800 U$=               "#####.#"
810 IF Y<10^3 THEN U$="####.##"
820 IF Y<10^2 THEN U$="###.###"
830 RETURN
840 :REM'
850 GOSUB 870:CLS:CHAIN GO$
860 :REM'
870 :REM'PRT
880 KEY OFF:GOSUB 950:LOCATE 25,5:COLOR 0,2
890 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
900 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
910 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 910 :ELSE GOSUB 950
920 IF Z$="3"THEN RETURN
930 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
940 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 880
950 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
