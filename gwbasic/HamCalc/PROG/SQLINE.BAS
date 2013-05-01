10 :REM'SQLINE - 23 JUN 2000 rev.11 NOV 2000
20 CLS:KEY OFF:COLOR 7,0
30 UL$=STRING$(80,205)
40 T$=" IMPEDANCE and SPACING of PARALLEL TRANSMISSION LINE with SQUARE "
50 T$=T$+"CONDUCTORS"
60 LOCATE ,(80-LEN(T$))/2:PRINT T$
70 PRINT UL$;
80 LN=CSRLIN
90 PRINT " Open-wire lines of less than 83.1Ω impedance are not physically p";
100 PRINT "ossible with "
110 PRINT " round conductors because the space between the conductors would t";
120 PRINT "heoretically "
130 PRINT " be zero or less. Impedances of less than 83.1Ω or any other value";
140 PRINT " are possible"
150 PRINT " if the line is constructed using square conductors."
160 PRINT UL$;
170 PRINT " This program is an excerpt from ";CHR$(34);"HAMCALC - Painless Ma";
180 PRINT "th for Radio Amateurs";CHR$(34);",";
190 PRINT " free software with over 250 programs on CD-ROM, available from th";
200 PRINT "e author for "
210 PRINT " a modest charge to cover costs of materials and shipping. For det";
220 PRINT "ails, e-mail "
230 PRINT " <ve3erp@encode.com>. "
240 PRINT UL$;
250 PRINT
260 UM=0:GOTO 930
270 IF UM THEN 350
280 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
290 PRINT " Want dimensions in (m)illimetres or (i)nches?     (m/i)   "
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="m"THEN UM=25.399999618530273!:UM$="mm.":GOTO 350
320 IF Z$="i"THEN UM=1   :UM$="in.":GOTO 350
330 GOTO 300
340 :REM'
350 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
360 :REM'
370 :REM'.....start
380 PRINT " ENTER: Width of one side of square conductor (";UM$;").......";
390 INPUT W:W=W/UM
400 D=1.1799999475479126!*W
410 PRINT
420 PRINT " Do you want to find conductor (s)pacing or line (i)mpedance?  (s/i)"
430 Z$=INKEY$:IF Z$=""THEN 430
440 IF Z$="s"THEN 610
450 IF Z$="i"THEN 470
460 :REM'
470 :REM'.....find Zo
480 CCMIN=1.1799999475479126!*W
490 PRINT :COLOR 0,7
500 PRINT " Minimum c.c. distance between conductors";
510 PRINT USING " ##.### ";CCMIN*UM;:PRINT UM$
520 COLOR 7,0
530 PRINT
540 PRINT " ENTER: c.c. spacing between conductors (";UM$;")";:INPUT S
550 S=S/UM
560 IF S<CCMIN THEN BEEP:GOTO 490
570 A=S/D
580 ZO=120*LOG(A+SQR(A^2-1))
590 GOTO 750
600 :REM'
610 :REM'.....find S
620 PRINT
630 INPUT " ENTER: Impedance of line (ohms)";ZO
640 IF ZO<0 THEN BEEP:GOTO 620
650 A=SQR(1):K=0.10000000149011612!
660 B=EXP(ZO/120)
670 A=A+K
680 C=A+SQR(A^2-1)
690 IF ABS(C-B)<9.999999747378752e-05! THEN 720
700 IF C>B THEN A=A-K:K=K/10
710 GOTO 670
720 S=A*D
730 GOTO 750
740 :REM'
750 :REM'.....display results
760 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
770 PRINT " Width of one side of square conductor ......";
780 PRINT USING " ###.### in. = ####.# mm";W,W*25.399999618530273!
790 PRINT " Gap between conductors .....................";
800 PRINT USING " ###.### in. = ####.# mm";S-W,(S-W)*25.399999618530273!
810 PRINT " Conductor c.c. spacing......................";
820 PRINT USING " ###.### in. = ####.# mm";S,S*25.399999618530273!
830 PRINT USING " Characteristic impedance of line............ ###.# ohms";ZO
840 PRINT
850 IF ZO>=70 AND ZO<=120 THEN 930
860 IF ZO<70 THEN X$="less than  70"
870 IF ZO>120 THEN X$="more than 120"
880 COLOR 15,4
890 LOCATE ,15:PRINT " Calculations of impedances "+X$+" ohms may "
900 LOCATE ,15:PRINT " be unreliable and should be empirically tested.   "
910 COLOR 7,0:PRINT
920 :REM'
930 COLOR 0,7:LOCATE ,23:PRINT " (r)un program?  (q)uit?    (r/q) ":COLOR 7,0
940 Z$=INKEY$:IF Z$=""THEN 940
950 IF Z$="r"THEN 270
960 IF Z$="q"THEN CLS:SYSTEM
970 GOTO 940
