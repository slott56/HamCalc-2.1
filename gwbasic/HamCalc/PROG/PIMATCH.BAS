10 :REM'PIMATCH : Pi-Section Matching Network  21 APR 95 rev.12 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 PI=3.1415929794311523!
60 E$=STRING$(80,32)
70 UL$=STRING$(80,205)
80 U1$="####.#"
90 DATA 1.9, 3.75, 7.15, 10.125, 14.175, 18.118, 21.225, 24.94, 28.85
100 FOR Z=1 TO 9:READ CF(Z):NEXT Z
110 :REM'
120 :REM'.....start
130 CLS
140 COLOR 15,2
150 PRINT " PI-SECTION MATCHING NETWORK";TAB(57);"by George Murphy VE3ERP ";
160 COLOR 1,0:PRINT STRING$(80,"▀");
170 COLOR 7,0
180 :REM'
190 :REM'.....diagram
200 CO=18   :REM'column
210 COLOR 0,7:LOCATE 3
220 LOCATE ,CO:PRINT "                      L                      "
230 LOCATE ,CO:PRINT "  ┌─────────┬───────∩∩∩∩∩───────┬─────────┐  "
240 LOCATE ,CO:PRINT "  │       C1│                   │C2       │  "
250 LOCATE ,CO:PRINT " R1        ═╪═                 ═╪═        R2 "
260 LOCATE ,CO:PRINT "  │         │                   │         │  "
270 LOCATE ,CO:PRINT "  └─────────┴───────────────────┴─────────┘  "
280 COLOR 7,0
290 LOCATE 11:PRINT UL$;
300 :REM'
310 COLOR 0,7:LOCATE CSRLIN,21
320 PRINT " Press 1 to continue or 0 to EXIT..... "
330 COLOR 7,0
340 Z$=INKEY$:IF Z$=""THEN 340
350 IF Z$="0"THEN CLS:RUN EX$
360 IF Z$="1"THEN 380
370 GOTO 340
380 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
390 PRINT " Enter the two impedances to be matched.................."
400 PRINT "  ( insert a comma between the two values, e.g. 1200,52 )"
410 INPUT "   ENTER: Two impedances, in ohms, in any order..........";R1,R2
420 IF R2>R1 THEN SWAP R1,R2
430 COLOR 0,7
440 LOCATE 6,10:PRINT "impedance";R1;"Ω"
450 LOCATE 6,55:PRINT R2;"Ω impedance"
460 COLOR 7,0
470 VIEW PRINT 12 TO 24:CLS:VIEW PRINT
480 LOCATE 12
490 T=7    :REM'tab
500 PRINT TAB(T);
510 PRINT "Enter a Q factor for the circuit, bearing in mind that the lower the"
520 PRINT TAB(T);
530 PRINT "the Q the more practical the component values become. Q factors of"
540 PRINT TAB(T);
550 PRINT "from 1 to 5 are are generally acceptable for matching solid-state"
560 PRINT TAB(T);
570 PRINT "stages or devices. Q factors of from 5 to 15 are suitable for most"
580 PRINT TAB(T);
590 PRINT "other applications. You can change the Q factor later in the program"
600 PRINT TAB(T);
610 PRINT "if you wish."
620 PRINT
630 PRINT TAB(T);
640 INPUT "ENTER: Q factor..................";Q
650 VIEW PRINT 12 TO 24:CLS:VIEW PRINT
660 IF R1/R2<1 THEN 740
670  MIN=SQR(R1/R2-1)
680  IF Q>MIN THEN 740
690  QQ=INT(MIN)+1
700  BEEP:LOCATE 12:PRINT " The minimum possible Q for this configuration is";QQ
710  PRINT " Press any key to continue...................."
720  IF INKEY$=""THEN 720
730  Q=QQ
740 Q1=(R1*Q-SQR(R1*R2*Q^2-(R1-R2)^2))/(R1-R2)
750 Q2=Q-Q1
760 XC1=R1/Q1
770 XC2=R2/Q2
780 COLOR 0,T
790 LOCATE 7,23:PRINT USING U1$;XC1;:PRINT " Ω Xc"
800 LOCATE 7,43:PRINT USING U1$;XC2;:PRINT " Ω Xc"
810 XL=R1*Q/(Q1^2+1)
820 LOCATE 5,35:PRINT USING U1$;XL;:PRINT " Ω Xl"
830 COLOR 7,0
840 LOCATE 9,2:PRINT "( Xl = inductive reactance )"
850 LOCATE 9,51:PRINT "( Xc = capacitive reactance )"
860 COLOR 15,3
870 LOCATE 11,22:PRINT " COMPONENT VALUES FOR A Q FACTOR OF";Q
880 COLOR 7,0
890 :REM'
900 VIEW PRINT 12 TO 24:CLS:VIEW PRINT:LOCATE 13
910 PRINT " Do you want values of C1, C2, and L for a specific frequency";
920 PRINT "    (y/n)"
930 Z$=INKEY$
940 IF Z$="n"THEN 1110
950 IF Z$="y"THEN 970
960 GOTO 930
970 VIEW PRINT 12 TO 24:CLS:VIEW PRINT:LOCATE 13
980 INPUT " ENTER: Frequency in MHz..........";F
990 VIEW PRINT 12 TO 24:CLS:VIEW PRINT:LOCATE 13
1000 F=F*10^6                             :REM'frequency in Hz
1010 C1=(1/(2*PI*F*XC1))*10^12            :REM'capacity in pF
1020 C2=(1/(2*PI*F*XC2))*10^12            :REM'capacity in pF
1030 L=(XL/(2*PI*F))*10^6                 :REM'inductance in µH * 1000
1040 PRINT " Frequency......";USING "###.###";F/10^6;:PRINT " Mhz"
1050 PRINT " Capacitor C1...";USING U1$;C1;:PRINT " pF"
1060 PRINT " Capacitor C2...";USING U1$;C2;:PRINT " pF"
1070 PRINT " Inductor L.....";USING U1$;L;:PRINT " µH"
1080 PRINT UL$;
1090 GOSUB 1370:GOTO 1110
1100 :REM'
1110 :REM'.....print table
1120 VIEW PRINT 12 TO 24:CLS:VIEW PRINT:LOCATE 12
1130 PRINT TAB(6);"MHz";TAB(20);"C1 (pF)";TAB(40);"C2 (pF)";TAB(61);"L (µH)"
1140 PRINT UL$;
1150 FOR Z= 1 TO 9
1160 F=CF(Z)*10^6                         :REM'frequency in Hz
1170 C1=(1/(2*PI*F*XC1))*10^12            :REM'capacity in pF
1180 C2=(1/(2*PI*F*XC2))*10^12            :REM'capacity in pF
1190 L=(XL/(2*PI*F))*10^6                 :REM'inductance in µH * 1000
1200 PRINT TAB(3);USING "###.###";F/10^6;
1210 PRINT TAB(21);USING U1$;C1;
1220 PRINT TAB(41);USING U1$;C2;
1230 PRINT TAB(60);USING U1$;L
1240 IF Z=1 THEN UH=L
1250 NEXT Z
1260 COLOR 0,7:LOCATE CSRLIN,17
1270 INPUT " ENTER: <0> if OK - or - ENTER: New Q factor ";Z$
1280 COLOR 7,0
1290 IF VAL(Z$)=0 THEN 1320
1300 IF VAL(Z$)>0 THEN Q=VAL(Z$):GOTO 650
1310 GOTO 1270
1320 LOCATE CSRLIN-1:PRINT E$;
1330 GOSUB 1370
1340 GOTO 120   :REM'start
1350 END
1360 :REM'
1370 :REM'PRT
1380 KEY OFF:GOSUB 1450:LOCATE 25,5:COLOR 0,2
1390 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1400 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1410 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1410 :ELSE GOSUB 1450
1420 IF Z$="3"THEN RETURN
1430 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1440 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1380
1450 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
