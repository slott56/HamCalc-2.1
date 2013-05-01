10 :REM'SMETER - S-Meter vs. Power - 07 JUN 96 rev. 10 JAN 2004
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 U$="###,###.###"
70 :REM'
80 COLOR 15,2
90 PRINT " S-METER READINGS vs. POWER";TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 7,0
120 GOTO 170
130 :REM'
140 LOCATE 3:VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
150 RETURN
160 :REM'
170 :REM'.....start
180 GOSUB 140
190 GOSUB 1090     :REM'preface
200 LOCATE 25,24:COLOR 15,4
210 PRINT " Press 1 to continue or 0 to EXIT ";
220 COLOR 7,0
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN RUN EX$
250 IF Z$="1"THEN 280
260 GOTO 230
270 :REM'
280 GOSUB 140
290 PRINT " To express power in watts............press 1"
300 PRINT " To express power in decibels.........press 2"
310 Z$=INKEY$:IF Z$="" THEN 310
320 IF Z$="1" THEN 510
330 IF Z$="2" THEN 360
340 GOTO 310
350 :REM'
360 :REM'.....decibels
370 GOSUB 150
380 PRINT  "Is known factor (s)meter reading or power in (d)ecibels?  (s/d)"
390 Z$=INKEY$:IF Z$=""THEN 390
400 IF Z$="s"THEN GOSUB 140:GOTO 430
410 IF Z$="d"THEN GOSUB 140:GOTO 450
420 GOTO 390
430 INPUT " ENTER: Signal strength in S units..............";S
440 PDB=6*(S-9)-73:GOTO 480
450 INPUT " ENTER: Signal strength in -db..................";PDB
460 IF PDB>=0 THEN PDB =-PDB
470 S=(9+(73+PDB)/6):GOTO 480
480 GOSUB 140
490 PRINT USING " Signal strength: #### dB = S ##.#";PDB,S
500 GOTO 1500
510 :REM'.....watts
520 GOSUB 140
530 PRINT " Describe a typical transmitter and its signal report:"
540 PRINT " Describe a typical transmitter and its signal report:"
550 PRINT UL$;
560 INPUT " ENTER: Power in watts......................";P
570 INPUT " ENTER: S-meter reading (9.00 or less)......";S
580 IF S<=9 THEN 600
590 BEEP:LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 570
600 B=P/4^S
610 PRINT B
620 GOSUB 140
630 PRINT " Relative Signal Strengths at Various Power Levels:"
640 PRINT UL$;
650      FOR Z=1 TO 9
660 Y=10
670 IF FLAG=1 THEN FLAG=0:GOTO 690
680 IF S>Z-1 AND S<(Z)THEN 960
690 X=B*4^Z
700 GOSUB 1030
710 COLOR 7,0
720 IF P=X OR P=X*10^3 OR P=X*10^6 THEN COLOR 0,7
730 PRINT " S";USING "#";Z;:PRINT TAB(Y);USING Z$;X;:PRINT W$;
740 IF P=X OR P=X*10^3 OR P=X*10^6 THEN 750 :ELSE COLOR 7,0:GOTO 760
750 COLOR 0,7:PRINT " (reference level) ";
760 PRINT ""
770      NEXT Z
780 FOR Z=1 TO 4
790 X=B*4^9*10^Z:GOSUB 1030
800 COLOR 7,0
810 PRINT " S9";USING "+##";Z*10;:PRINT TAB(Y);USING Z$;X;:PRINT W$""
820      NEXT Z
830 PRINT UL$;
840 T=8
850 PRINT TAB(T);
860 PRINT "These are the power levels required to achieve S-meter readings"
870 PRINT TAB(T);
880 PRINT "at levels other than the reference level."
890 PRINT
900 PRINT TAB(T);
910 PRINT "International regulations stipulate that no station should use more"
920 PRINT TAB(T);
930 PRINT "power than is necessary for the communication.";
940 GOTO 1500
950 :REM'
960 COLOR 0,7
970 S$=STR$(S):S$=RIGHT$(S$,LEN(S$)-1)
980 PRINT " S";USING "#.#";S;:PRINT TAB(Y);USING Z$;P;:PRINT " watts ";
990 PRINT "(reference level) "
1000 COLOR 0,7
1010 FLAG=1:Z=Z-1:GOTO 770
1020 :REM'
1030 :REM'.....format display
1040 Z$=U$:W$=" watts"
1050 IF X>=10^3  THEN X=X/10^3:W$=" kilowatts"
1060 IF X>=10^6  THEN X=X/10^6:W$=" megawatts"
1070 RETURN
1080 :REM'
1090 :REM'.....preface
1100 T=7:Z$=CHR$(34)
1110 PRINT TAB(T);Z$;
1120 PRINT "Because S meters are relative-reading instruments, signal reporting"
1130 PRINT TAB(T);
1140 PRINT "based on the amount of needle deflection is generally without"
1150 PRINT TAB(T);
1160 PRINT "meaning. No two receivers render the same reading of a given signal,"
1170 PRINT TAB(T);
1180 PRINT "unless by coincidence. This is because gain distribution within an"
1190 PRINT TAB(T);
1200 PRINT "amateur receiver varies from band to band. Since most S meters are"
1210 PRINT TAB(T);
1220 PRINT "activated from the AGC line in a receiver, what might be S9 on one"
1230 PRINT TAB(T);
1240 PRINT "ham band could easily become S6 or 10 dB over S9 on another band. A"
1250 PRINT TAB(T);
1260 PRINT "receiver that rendered accurate readings on each band it covered"
1270 PRINT TAB(T);
1280 PRINT "would be extremely esoteric and complex.";Z$;
1290 PRINT TAB(T);
1300 PRINT "(The 1994 ARRL HANDBOOK for RADIO AMATEURS, page 12-30)."
1310 PRINT
1320 PRINT TAB(T);
1330 PRINT "To increase your received signal by only ONE S-unit you need FOUR"
1340 PRINT TAB(T);
1350 PRINT "TIMES your current power. You need SIXTEEN times your current power"
1360 PRINT TAB(T);
1370 PRINT "for two S-units. If you are willing to decrease your signal by one"
1380 PRINT TAB(T);
1390 PRINT "S-unit (a barely discernible reduction to the listener) your power"
1400 PRINT TAB(T);
1410 PRINT "can be reduced to ONE-QUARTER of its current level."
1420 PRINT
1430 PRINT TAB(T);
1440 PRINT "(with TNX to IK5MDF in ";Z$;"RADIO REVISTA";Z$;" via Bob Eldridge,";
1450 PRINT " VE7BS, in"
1460 PRINT TAB(T);
1470 PRINT "the April 1996 issue of ";Z$;"THE CANADIAN AMATEUR";Z$;", page 24)"
1480 RETURN
1490 :REM'
1500 :REM'.....end
1510 GOSUB 1550
1520 GOTO 170
1530 END
1540 :REM'
1550 :REM'PRT
1560 KEY OFF:GOSUB 1630:LOCATE 25,5:COLOR 0,2
1570 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1580 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1590 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1590 :ELSE GOSUB 1630
1600 IF Z$="3"THEN RETURN
1610 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1620 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1560
1630 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
