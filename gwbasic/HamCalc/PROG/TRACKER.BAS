10 :REM'TRACKER - Tracking Receiver Tuned Circuits - 01 JAN 2000
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COLOR 7,0,1
50 PI=4*ATN(1)  :REM'3.141593
60 UL$=STRING$(80,205)
70 GOTO 220
80 :REM'
90 :REM'.....diagram
100 COLOR 0,7:T=11:LOCATE 3
110 LOCATE,T:PRINT "                                                           "
120 LOCATE,T:PRINT "           C2            L1- IF transformer secondary      "
130 LOCATE,T:PRINT "   ┌────┬──╫──┬──────┐   C1- Main tuning capacitor section "
140 LOCATE,T:PRINT "   (    |     │      │   C2- Padding capacitor             "
150 LOCATE,T:PRINT " L1(  C4╪  C3═/═  C1═/═ «──(variable)                      "
160 LOCATE,T:PRINT "   (    |     │      │   C3- Trimmer capacitor             "
170 LOCATE,T:PRINT "   └────┴─────┴──────┘   C4- Distributed capacity of coil  "
180 LOCATE,T:PRINT "                                                           "
190 COLOR 7,0
200 RETURN
210 :REM'
220 :REM'.....title page
230 CLS
240 COLOR 15,2
250 PRINT " TRACKER - Receiver Tuned Circuits"TAB(57)"by George Murphy VE3ERP ";
260 COLOR 1,0:PRINT STRING$(80,223);
270 COLOR 7,0
280 GOSUB 90  :REM'print diagram
290 PRINT UL$;
300 :REM'
310 :REM'.....program
320 LN=CSRLIN
330 GOSUB 1130
340 Z$=INKEY$:IF Z$=""THEN 340
350 IF Z$="0" THEN CLS:RUN EX$
360 IF Z$="1"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 380
370 GOTO 340
380 INPUT " ENTER: Intermediate frequency (MHz)............................";F0
390 COLOR 0,7
400 PRINT " Enter three frequencies at which exact tracking is to be obtained:"
410 COLOR 7,0
420 PRINT " (best average oscillator tracking is obtained when the frequencies";
430 PRINT " of exact"
440 PRINT " tracking (commonly termed cross-over frequencies) are so chosen th";
450 PRINT "at the"
460 PRINT " midrange frequency is approximately mid-way between the other two ";
470 PRINT "frequencies."
480 PRINT
490 INPUT " ENTER: 1st (lowest) frequency (MHz)............................";F1
500 INPUT " ENTER: 2nd (midrange) frequency (MHz)..........................";F2
510 INPUT " ENTER: 3rd (highest) frequency (MHz)...........................";F3
520 INPUT " ENTER: Maximum capacity of variable tuning capacitor C1 (pF)...";C0
530 INPUT " ENTER: Lowest freq.(MHz) to which RF circuit is to be tuned....";FQ
540 A=F1+F2+F3
550 B=SQR(F1*F2+F1*F3+F2*F3)
560 C=(F1*F2*F3)^(1/3)
570 D=A+2*F0
580 L=SQR((B^2*D-C^2)/(2*F0))
590 M=SQR(L^2+F0^2+A*D-B^2)
600 N=SQR((C^2*D+F0^2*L^2)/M^2)
610 UL=25330/(C0*FQ)
620 AA=C0*FQ*(1/N^2-1/L^2)
630 BB=C0*FQ/L^2
640 OSC=M*SQR((F0^2+N^2)/(F0^2+L^2))
650 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
660 PRINT " For exact tracking at";
670 PRINT USING " ##.###, ##.###, and ##.### MHz.";F1,F2,F3
680 PRINT USING " I.F.= ##.### MHz., C1 max.= ### pF,";F0,C0;
690 PRINT USING " Lowest tuneable freq.= ##.### MHz.";FQ
700 PRINT UL$;
710 COLOR 0,7
720 PRINT "  All capacitor values in the following table are in pF "
730 COLOR 7,0
740 :REM'
750 PRINT " Case 1. When C4=0, or C4<<C2 (the usual case):"
760 C2=C0*FQ^2*(1/N^2-1/L^2)
770 C3=C0*FQ^2/L^2
780 C4=0
790 L1=UL*(L^2/M^2)*((C2+C3)/C2)
800 GOSUB 1080
810 :REM'
820 PRINT " Case 2. When C3=0:"
830 C2=C0*FQ^2/N^2
840 C3=0
850 C4=C0*FQ^2/(L^2-N^2)
860 L1=UL*(L^2/M^2)*C2/(C2+C4)
870 GOSUB 1080
880 :REM'
890 PRINT " Case 3. When C4 is known:"
900 INPUT " ENTER: Value of C4 (pF) ";C4
910 LOCATE CSRLIN-2,20:PRINT C4;"pF:   "
920 C2=AA*(0.5!+SQR(0.25!+C4/AA))
930 C3=C0*FQ^2/L^2-(C2*C4/(C2+C4))
940 L1=UL*(L^2/M^2)*(C2+C3)/(C2+C4)
950 GOSUB 1080
960 :REM'
970 PRINT " Case 4. When C3 is known:"
980 INPUT " ENTER: Value of C3 (pF) ";C3
990 LOCATE CSRLIN-2,20:PRINT C3;"pF:   "
1000 C2=C0*FQ^2/N^2-C3
1010 C4=C2*BB/(C2-BB)
1020 L1=UL*(L^2/M^2)*(C2+C3)/(C2+C4)
1030 GOSUB 1080
1040 GOSUB 1230
1050 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1060 GOTO 310
1070 :REM'
1080 :REM'.....display
1090 COLOR 0,7:PRINT TAB(3);
1100 PRINT USING"C2= ####.#▐ C3= ####.#▐ C4= ####.#▐ L1= ####.# µH▐";C2,C3,C4,L1
1110 COLOR 7,0:RETURN
1120 :REM'
1130 :REM'.....preface
1140 PRINT " This program computes local oscillator proportions in superhet r";
1150 PRINT "eceivers to"
1160 PRINT " obtain accurate tracking at three frequencies within any tuning ";
1170 PRINT "range."
1180 PRINT " (ref. F.E.Terman, Radio Engineers' Handbook, 1943, pp.649-652)"
1190 PRINT
1200 COLOR 0,7:LOCATE ,22:PRINT " Press 1 to continue, or 0 to EXIT "
1210 COLOR 7,0:RETURN
1220 :REM'
1230 :REM'PRT
1240 KEY OFF:GOSUB 1310:LOCATE 25,5:COLOR 0,2
1250 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1260 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1270 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1270 :ELSE GOSUB 1310
1280 IF Z$="3"THEN RETURN
1290 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1300 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1240
1310 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
