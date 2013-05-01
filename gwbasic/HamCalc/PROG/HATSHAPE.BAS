10 :REM'HATSHAPE - Capacity Hat Geometric Shapes - 19 DEC 95 rev.11 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$
40 CLS:KEY OFF
50 COLOR 7,0,0
60 UL$=STRING$(80,205)
70 U$="#####.#"
80 :REM'
90 :REM'.....start
100 CLS:C=0:CD=0:CS=0:CC=0:D=0:DD=0:DS=0:DC=0
110 COLOR 15,2
120 PRINT " CAPACITY HAT GEOMETRIC SHAPES";TAB(57);"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 GOSUB 920    :REM'preface
160 PRINT UL$;
170 PRINT " Press number in < > to:"
180 PRINT UL$;
190 PRINT "   < 1 >  Find CAPACITANCE of Shapes of Known DIAMETER"
200 PRINT "   < 2 >  Find DIAMETER of Shapes of Known CAPACITANCE"
210 PRINT "   < 3 >  Run the W4RNL Capacitive Hat Calculator program"
220 PRINT UL$;
230 PRINT "   < 0 >  EXIT"
240 Z$=INKEY$:IF Z$=""THEN 240
250 IF Z$="0"THEN CLS:RUN EX$
260 IF Z$="1"THEN 430
270 IF Z$="2"THEN 470
280 IF Z$="3"THEN CLS:CHAIN "capyhat"
290 GOTO 240
300 :REM'
310 :REM'.....unit of measure
320 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
330 COLOR 0,7
340 PRINT " Do you want Diameter in (c)entimetres or (i)nches?  (c/i)"
350 COLOR 7,0
360 Z$=INKEY$:IF Z$=""THEN 360
370 IF Z$="i"THEN M=1:M$="in.":GOTO 400
380 IF Z$="c"THEN M=1/2.5399999618530273!:M$="cm.":GOTO 400
390 GOTO 360
400 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
410 RETURN
420 :REM'
430 :REM'.....input diameter
440 GOSUB 310
450 PRINT " ENTER: Diameter of shape (";M$;")......";:INPUT D:D=D*M:GOTO 510
460 :REM'
470 :REM'.....input capacitance
480 GOSUB 310
490 INPUT " ENTER: Capacitance of shape (pF)......";C:GOTO 510
500 :REM'
510 :REM'.....calculate
520 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
530 IF C=0 THEN CD=D*0.8899999856948853!:CS=D*1.399999976158142!:CC=D*2.0399999618530273!:GOTO 560
540 IF D=0 THEN DD=C/0.8899999856948853!:DS=C/1.399999976158142!:DC=C/2.0399999618530273!:GOTO 560
550 :REM'
560 :REM'.....screen print
570 GOSUB 920
580 PRINT UL$;
590 D$=STRING$(24,".")
600 IF C<>0 THEN 720
610 IF D<>0 THEN 630
620 :REM'
630 PRINT USING U$;D/M;:PRINT " ";M$;" dia. DISC.....";D$;
640 LOCATE CSRLIN,45:PRINT USING U$;CD;:PRINT " pF"
650 PRINT USING U$;D/M;:PRINT " ";M$;" dia. SPHERE...";D$;
660 LOCATE CSRLIN,45:PRINT USING U$;CS;:PRINT " pF"
670 PRINT USING U$;D/M;:PRINT " ";M$;" dia. CYLINDER,";D$;
680 LOCATE CSRLIN,27:PRINT USING U$;D/M;:PRINT " ";M$;" long";
690 LOCATE CSRLIN,45:PRINT USING U$;CC;:PRINT " pF"
700 GOTO 800
710 :REM'
720 PRINT USING U$;C;:PRINT " pF DISC.....";D$;
730 LOCATE CSRLIN,40:PRINT USING U$;DD/M;:PRINT " ";M$;" dia."
740 PRINT USING U$;C;:PRINT " pF SPHERE...";D$;
750 LOCATE CSRLIN,40:PRINT USING U$;DS/M;:PRINT " ";M$;" dia."
760 PRINT USING U$;C;:PRINT " pF CYLINDER,";D$;
770 LOCATE CSRLIN,40:PRINT USING U$;DC/M;:PRINT " ";M$;" dia.,";
780 PRINT USING U$;DC/M;:PRINT " ";M$;" long"
790 :REM'
800 PRINT UL$;
810 PRINT TAB(T);
820 PRINT "Values shown are sufficiently accurate for many amateur radio"
830 PRINT TAB(T);
840 PRINT "applications. Actual values may differ slightly due to site"
850 PRINT TAB(T);
860 PRINT "conditions and antenna construction."
870 PRINT UL$;
880 PRINT TAB(T);
890 PRINT "Reference: The ARRL ANTENNA BOOK, 17th Edition, page 2-39";
900 GOTO 1170
910 :REM'
920 :REM'.....preface
930 T=8
940 PRINT TAB(T);
950 PRINT "Physically shortened vertical antennas can be top-loaded with a"
960 PRINT TAB(T);
970 PRINT "flat-top 'Capacity Hat' to compensate for the missing height."
980 PRINT TAB(T);
990 PRINT "Practically any sufficiently large metallic structure can be used"
1000 PRINT TAB(T);
1010 PRINT "for the purpose, but simple geometric forms such as the sphere,"
1020 PRINT TAB(T);
1030 PRINT "cylinder and disc are preferred because of the relative ease with"
1040 PRINT TAB(T);
1050 PRINT "which their capacitance can be calculated."
1060 PRINT
1070 PRINT TAB(T);
1080 PRINT "These shapes can be constructed of sheet metal if such construction"
1090 PRINT TAB(T);
1100 PRINT "is feasible, but the capacitance will be practically the same in"
1110 PRINT TAB(T);
1120 PRINT "each case if a 'skeleton' construction with screening or networks"
1130 PRINT TAB(T);
1140 PRINT "of wire or aluminum tubing is used."
1150 RETURN
1160 :REM'
1170 :REM'.....end
1180 GOSUB 1220
1190 GOTO 90   :REM'start
1200 END
1210 :REM'
1220 :REM'PRT
1230 KEY OFF:GOSUB 1300:LOCATE 25,5:COLOR 0,2
1240 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1250 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1260 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1260 :ELSE GOSUB 1300
1270 IF Z$="3"THEN RETURN
1280 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1290 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1230
1300 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
