10 :REM'ZOSTEPUP - Folded Dipole Zo Step-up Ratios - 20 NOV 96 rev.13 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 U$="####.##"
60 GOTO 190
70 :REM'
80 :REM'.....clear bottom of screen
90 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
100 RETURN
110 :REM'
120 BEEP:LN=CSRLIN:PRINT :COLOR  0,7
130 PRINT " Spacing between d1 and d2 is excessive. Try again using different "
140 PRINT " diameters for d1 and/or d2. Press any key to start over . . . . . "
150 COLOR 7,0
160 IF INKEY$=""THEN 160
170 LN=11:GOSUB 80:GOTO 190
180 :REM'
190 :REM'.....start
200 CLS
210 COLOR 15,2
220 PRINT " FOLDED DIPOLE Zo STEP-UP RATIOS";TAB(57);"by George Murphy VE3ERP ";
230 COLOR 1,0:PRINT STRING$(80,223);
240 COLOR 7,0
250 GOSUB 1050    :REM'diagram
260 PRINT
270 GOSUB 1160    :REM'preface
280 COLOR 0,7:LOCATE 25,22
290 PRINT " Press 1 to continue or 0 to EXIT....";:COLOR 7,0
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="0"THEN CLS:RUN EX$
320 IF Z$="1"THEN 340
330 GOTO 300
340 LN=9:GOSUB 80
350 :REM'
360 :REM'.....input data
370 S=0:SP=0
380 LN=CSRLIN
390 INPUT " ENTER: Antenna feed point impedance (ohms)...........";Z1
400 INPUT " ENTER: Feedline characteristic impedance (ohms)......";Z2
410 Z3=Z2/Z1
420 GOSUB 80
430 PRINT "        Antenna feed point impedance..................";USING U$;Z1;
440 PRINT " ohms"
450 PRINT "        Feedline characteristic impedance.............";USING U$;Z2;
460 PRINT " ohms"
470 COLOR 0,7:LN=CSRLIN
480 PRINT " Do you want dimensions in (m)illimetres or (i)nches?  (m/i) "
490 COLOR 7,0
500 Z$=INKEY$:IF Z$=""THEN 500
510 IF Z$="i"THEN UM=1:UM$="in.":GOTO 540
520 IF Z$="m"THEN UM=25.399999618530273!:UM$="mm.":GOTO 540
530 GOTO 500
540 GOSUB 80
550 :REM'
560 PRINT " ENTER: Diameter of feedline d1 wire or rod (";UM$;").....";
570 INPUT D:D1=D/UM
580 GOSUB 80
590 PRINT "        Diameter of feedline wire or rod...........d1=";
600 PRINT USING U$;D1*25.399999618530273!;:PRINT " mm. =";USING U$;D1;:PRINT " in."
610 :REM'
620 LN=CSRLIN
630 PRINT " ENTER: Diameter of antenna element d2 (";UM$;")..........";
640 INPUT D:D2=D/UM
650 GOSUB 80
660 PRINT "        Diameter of antenna element................d2=";
670 PRINT USING U$;D2*25.399999618530273!;:PRINT " mm. =";USING U$;D2;:PRINT " in."
680 :REM'
690 PRINT "        Impedance step-up ratio.......................";USING U$;Z3;
700 PRINT ":1"
710 IF D1<>D2 THEN 790
720 LN=CSRLIN
730 LOCATE LN-4,55:PRINT USING U$;Z1*4
740 LOCATE LN-1,55:PRINT USING U$;4
750 LOCATE LN
760 PRINT "        Centre-to-centre spacing S is not critical."
770 GOTO 1400   :REM'end
780 :REM'
790 LN=CSRLIN:COLOR 0,7:PRINT " Iterating....please wait....":COLOR 7,0
800 S=(D1+D2)    :REM'minimum spacing
810 :REM'
820 :REM'.....iteration
830 S=S+0.0010000000474974513!
840 IF S/D2>20 THEN 120
850 A=LOG(2*S/D1)
860 B=LOG(2*S/D2)
870 R=(1+A/B)^2
880 IF D1=D2 THEN 950
890 IF D2>D1 AND R<=Z3 THEN 930
900 IF D2<D1 AND R>=Z3 THEN 930
910 GOTO 830
920 :REM'
930 :REM'.....display results
940 S=S-0.0005000000237487257!
950 IF SP<>0 THEN S=SP
960 GOSUB 80
970 PRINT "        Centre-to-centre between d1 and d2..........S=";
980 PRINT USING U$;S*25.399999618530273!;:PRINT " mm. =";USING U$;S;:PRINT " in."
990 PRINT "          ratio d2/d1 ................................";
1000 PRINT USING U$;D2/D1;:PRINT ":1"
1010 PRINT "          ratio S/d2 .................................";
1020 PRINT USING U$;S/D2;:PRINT ":1"
1030 GOTO 1400   :REM'end
1040 :REM'
1050 :REM'.....diagram
1060 COLOR 0,7:X=20
1070 LOCATE ,X:PRINT "                                         "
1080 LOCATE ,X:PRINT "    ╒═════════════════════════════╕«─ d2 "
1090 LOCATE ,X:PRINT " S─»│                             │      "
1100 LOCATE ,X:PRINT "    ╘═════════════╕ ╒═════════════╛«─ d1 "
1110 LOCATE ,X:PRINT "               feed point                "
1120 LOCATE ,X:PRINT "                                         "
1130 COLOR 7,0
1140 RETURN
1150 :REM'
1160 :REM'.....preface
1170 TB=7
1180 PRINT TAB(TB);
1190 PRINT "The feed point impedance of a ½-wave dipole is about 70 Ω. A folded"
1200 PRINT TAB(TB);
1210 PRINT "dipole has an inherent impedance step-up ratio of 4:1 if all the"
1220 PRINT TAB(TB);
1230 PRINT "conductors in the dipole are the same diameter."
1240 PRINT
1250 PRINT TAB(TB);
1260 PRINT "Impedance ratios larger than 4:1 are frequently desirable when the"
1270 PRINT TAB(TB);
1280 PRINT "folded dipole is used as the driven element in a directive array,"
1290 PRINT TAB(TB);
1300 PRINT "because the radiation of such an array is usually quite low. A wide"
1310 PRINT TAB(TB);
1320 PRINT "choice of impedance step-up ratios is available by varying the"
1330 PRINT TAB(TB);
1340 PRINT "relative sizes d1 & d2 and spacing S of the conductors."
1350 PRINT
1360 PRINT TAB(TB);
1370 PRINT "( The ARRL ANTENNA BOOK, 17th Edition, pages 2-32 and 2-33.)"
1380 RETURN
1390 :REM'
1400 :REM'.....end
1410 GOSUB 1440:GOTO 190
1420 END
1430 :REM'
1440 :REM'PRT
1450 KEY OFF:GOSUB 1520:LOCATE 25,5:COLOR 0,2
1460 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1470 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1480 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1480 :ELSE GOSUB 1520
1490 IF Z$="3"THEN RETURN
1500 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1510 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1450
1520 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
