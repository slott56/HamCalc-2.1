10 :REM'LINELOSS - Losses in Transmission Lines - 28 APR 94 rev. 18 OCT 1998
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 U1$="#,###.###"
80 UL$=STRING$(80,205)
90 E$=STRING$(80,32)
100 :REM'
110 :REM'.....start
120 LG=0:FQ=0:DB=0:SL=0:SI=0:LM=0:LT=0
130 A=0:B=0:C=0:L1=0
140 CLS
150 COLOR 15,2
160 PRINT " TRANSMISSION LINE LOSSES";TAB(57);"by George Murphy VE3ERP ";
170 COLOR 1,0:PRINT STRING$(80,"▀");
180 COLOR 7,0
190 GOSUB 1110      :REM'preface
200 COLOR 0,7:LOCATE 25,22
210 PRINT " Press 1 to continue or 0 to EXIT.....";
220 COLOR 7,0
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN CLS:CHAIN GO$
250 IF Z$="1"THEN 280
260 GOTO 230
270 :REM'
280 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
290 PRINT " Press number in < > to choose standard unit of measure:"
300 PRINT UL$;
310 PRINT "   < 1 >  Metric"
320 PRINT "   < 2 >  U.S.A./Imperial"
330 Z$=INKEY$
340 IF Z$="1"THEN UM=0.30480000376701355!:UM$="m.":GOTO 380
350 IF Z$="2"THEN UM=1:UM$="ft.":GOTO 380
360 GOTO 330
370 :REM'
380 :REM'.....inputs
390 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
400 PRINT " Press <ENTER> to by-pass any of the following inputs:"
410 PRINT " (If you by-pass an essential input you will be asked for it again)"
420 PRINT UL$;
430 IF LG THEN 470
440 PRINT " ENTER: Length of transmission line (";UM$;")......................";
450 IF UM$="m."THEN PRINT ".";
460 INPUT LG:LG=LG/UM:GOSUB 650
470 IF FQ THEN 500
480 INPUT " ENTER: Frequency (MHz)........................................";FQ
490 GOSUB 650
500 IF DB THEN 540
510 PRINT " ENTER: Attenuation of line (dB per 100 ";UM$;") when matched......";
520 IF UM$="m."THEN PRINT ".";
530 INPUT DB:DB=DB*UM:GOSUB 650
540 IF SL THEN 580
550 INPUT " ENTER: SWR at load (e.g. antenna).............................";SL
560 IF SL=1 THEN SL=1.0000100135803223!
570 GOSUB 650
580 IF SI THEN 620
590 INPUT " ENTER: SWR at input (e.g.transmitter or transmatch)............";SI
600 IF SI=1 THEN SI=1.0000100135803223!
610 GOSUB 650
620 VIEW PRINT 6 TO 24:CLS:VIEW PRINT:LOCATE 6
630 GOTO 390
640 :REM'
650 :REM'.....calculate
660 FOR Z=1 TO 3
670 IF LG=0 AND M<>0    THEN LG=M/0.30480000376701355!
680 IF A=0 AND SI<>0    THEN A=(SI+1)/(SI-1)
690 IF B=0 AND DB*LG<>0 THEN LM=DB*LG/100:B=10^(LM/10)
700 IF C=0 AND SL<>0    THEN C=(SL-1)/(SL+1)
710 IF SL=0 AND A*B<>0  THEN SL=(A+B)/(A-B)
720 IF SI=0 AND B*C<>0  THEN SI=(B+C)/(B-C)
730 IF L1=0 AND B*C<>0  THEN L1=B^2-C^2:L2=B*(1-C^2)
740 IF L1*L2<>0 AND L2<=0 THEN 800
750 IF LT=0 AND L1*L2<>0  THEN LT=10*LOG(L1/L2)/LOG(10) :REM'base 10
760 IF SI*SL*LT*FQ THEN 880
770 NEXT Z
780 RETURN
790 :REM'
800 :REM'.....infinite SWR
810 BEEP:PRINT:COLOR 15,4
820 PRINT " Line loss is excessively high. SWR is infinite............"
830 PRINT " .............Press any key to start over.................."
840 COLOR 7,0
850 IF INKEY$=""THEN 850
860 CLS:RUN EX$
870 :REM'
880 :REM'.....print
890 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
900 PRINT " Length of transmission line...................";
910 PRINT USING U1$;LG*UM;:PRINT " ";UM$
920 PRINT " Frequency.....................................";
930 PRINT USING "#####.###";FQ;:PRINT " MHz"
940 PRINT " Attenuation per 100 ";UM$;" of line when matched..";
950 IF UM$="m."THEN PRINT ".";
960 PRINT USING U1$;DB/UM;:PRINT " dB @";:PRINT FQ;"MHz"
970 PRINT " SWR at load (e.g. antenna)....................";
980 PRINT USING U1$;SL;:PRINT " : 1"
990 PRINT " SWR at input (e.g. transmitter / transmatch)..";
1000 PRINT USING U1$;SI;:PRINT " : 1"
1010 PRINT " Attenuation of line when matched..............";
1020 PRINT USING U1$;LM;:PRINT " dB"
1030 PRINT " Additional loss due to SWR....................";
1040 PRINT USING U1$;LT-LM;:PRINT " dB"
1050 PRINT " Total loss in line............................";
1060 PRINT USING U1$;LT;:PRINT " dB"
1070 PRINT UL$;
1080 GOSUB 1550
1090 GOTO 110   :REM'start
1100 :REM'
1110 :REM'.....text
1120 T=7     :REM'tab
1130 PRINT TAB(T);
1140 PRINT "It is impossible to give a specific relationship between line loss"
1150 PRINT TAB(T);
1160 PRINT "and frequency that will apply to all types of lines. Losses are"
1170 PRINT TAB(T);
1180 PRINT "due to many factors, such as the characteristics of the dielectric,"
1190 PRINT TAB(T);
1200 PRINT "whether the dielectric is air or a manufactured material, and on"
1210 PRINT TAB(T);
1220 PRINT "the line's construction, tolerances, installation, age, and state"
1230 PRINT TAB(T);
1240 PRINT "of deterioration. Furthermore, the same lines from different"
1250 PRINT TAB(T);
1260 PRINT "suppliers often have substantially different loss characteristics."
1270 PRINT
1280 PRINT TAB(T);
1290 PRINT"To use this program it is necessary to enter the loss in dB per"
1300 PRINT TAB(T);
1310 PRINT"unit length at a specific frequency for the transmission line under"
1320 PRINT TAB(T);
1330 PRINT"consideration. For the reasons stated above this data cannot be"
1340 PRINT TAB(T);
1350 PRINT"calculated accurately. However, for purposes of this program "
1360 PRINT TAB(T);
1370 PRINT"approximate data will suffice. This data can be found in graph form"
1380 PRINT TAB(T);
1390 PRINT"in the ARRL HANDBOOK, the ARRL Antenna Book, or the ARRL Electronics"
1400 PRINT TAB(T);
1410 PRINT"Data Book."
1420 PRINT
1430 PRINT TAB(T);
1440 PRINT "HAMCALC's ";CHR$(34);"COAXIAL CABLE CHARACTERISTICS";CHR$(34);
1450 PRINT " program can also provide"
1460 PRINT TAB(T);
1470 PRINT "estimated dB losses at any frequency for coaxial cable transmission"
1480 PRINT TAB(T);
1490 PRINT "lines."
1500 PRINT
1510 PRINT TAB(T);
1520 PRINT "This program was developed from a concept by Göran Hosinsky, EA8YU."
1530 RETURN
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
