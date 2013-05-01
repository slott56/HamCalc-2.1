10 :REM'TURNRAD - Turning Radius - Beam Antennas - 20 FEB 2002
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$,DIMN$,A,B,C
60 COLOR 7,0,1
70 UL$=STRING$(80,205)
80 M$(1)=" Length of boom............................... A"
90 M$(2)=" Length of each leg of long end element....... B"
100 M$(3)=" Length of each leg of short end element...... C"
110 M$(4)=" Distance from pivot to long end element...... D"
120 M$(5)=" Distance from pivot to short end element..... E"
130 M$(6)=" Distance from pivot to element ends 1,2,3,4.. R"
140 P$=" = ###.###"
150 GOTO 200
160 :REM'
170 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 15
180 RETURN
190 :REM'
200 :REM'.....title page
210 CLS
220 COLOR 15,2
230 PRINT " TURNING RADIUS - Beam Antennas"TAB(57)"by George Murphy VE3ERP ";
240 COLOR 1,0:PRINT STRING$(80,223);
250 COLOR 7,0
260 :REM'
270 :REM'.....start
280 GOSUB 940  :REM'diagram
290 PRINT UL$;
300 GOSUB 760  :REM'preface
310 PRINT UL$;
320 IF A*B*C THEN FLAG=1:GOTO 500
330 :REM'
340 COLOR 0,7:LOCATE ,23:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
350 Z$=INKEY$:IF Z$=""THEN 350
360 IF Z$="0"THEN COLOR ,,0:CLS:CHAIN GO$
370 IF Z$="1"THEN 400
380 GOTO 350
390 :REM'
400 :REM'.....data input
410 GOSUB 170
420 FOR Z=1 TO 3
430 IF M(Z)THEN 440 :ELSE GOSUB 170:PRINT " ENTER:";M$(Z);:INPUT M(Z):
440 NEXT Z
450 A=M(1):B=M(2):C=M(3)
460 IF A*B*C THEN 470 :ELSE 420
470 GOSUB 560
480 GOSUB 1100:A=0:B=0:C=0:D=0:R=0:FOR Z=1 TO 6:M(Z)=0:NEXT Z:GOTO 200
490 :REM'
500 :REM'.....chain program
510 M(1)=A:M(2)=B:M(3)=C
520 GOSUB 560
530 PRINT " Sketch is typical for any number of intermediate elements."
540 GOSUB 1100:CHAIN PROG$
550 :REM'
560 :REM'.....calculate
570 F1=(B-C)/2
580 F2=(B+C)/2
590 F3=A/2
600 E=F1*F2/F3+F3:M(5)=E
610 D=A-E:M(4)=D
620 R=SQR(C^2+E^2):M(6)=R
630 GOSUB 170
640 :REM'
650 :REM'.....screen display
660 FOR Z=1 TO 6
670 PRINT M$(Z)USING P$;M(Z);
680 PRINT USING " ft. = ###.### m.";M(Z)*0.30480000376701355! :ELSE PRINT ""
690 IF Z=5 THEN PRINT " Turning radius:"
700 NEXT Z
710 PRINT UL$;
720 FLAG=0
730 RETURN
740 END
750 :REM'
760 :REM'.....preface
770 T=8
780 PRINT TAB(T);
790 PRINT "Minimum turning radius of a beam is achieved when the boom is"
800 PRINT TAB(T);
810 PRINT "attached to the mast at a point where tips 1,2,3,4 of the endmost"
820 PRINT TAB(T);
830 PRINT "radiators are all the same distance from the pivot. This program"
840 PRINT TAB(T);
850 PRINT "calculates the location of the pivot point. If this point does not"
860 PRINT TAB(T);
870 PRINT "coincide with the centre of gravity of the beam, addition of"
880 PRINT TAB(T);
890 PRINT "suitably located counterweights is recommended to obtain both"
900 PRINT TAB(T);
910 PRINT "static balance and minimum turning radius.";
920 RETURN
930 :REM'
940 :REM'.....diagram
950 COLOR 0,7:T=25
960 LOCATE ,T:PRINT "                              "
970 LOCATE ,T:PRINT "          │«─ C ─»│«─ C ─»│   "
980 LOCATE ,T:PRINT "  ┌»┌───» 1═══════╦═══════2   "
990 LOCATE ,T:PRINT "  │ │             ║           "
1000 LOCATE ,T:PRINT "  │ E             ║           "
1010 LOCATE ,T:PRINT "  A │     ════════╬════════   "
1020 LOCATE ,T:PRINT "  │ ├───────────» ╫ «─ pivot  "
1030 LOCATE ,T:PRINT "  │ D             ║           "
1040 LOCATE ,T:PRINT "  └»└─» 4═════════╩═════════3 "
1050 LOCATE ,T:PRINT "        │«── B ──»│«── B ──»│ "
1060 LOCATE ,T:PRINT "                              "
1070 COLOR 7,0
1080 RETURN
1090 :REM'
1100 :REM'.....PRT
1110 KEY OFF:GOSUB 1180:LOCATE 25,5:COLOR 0,2
1120 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1130 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1140 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1140 :ELSE GOSUB 1180
1150 IF Z$="3"THEN RETURN
1160 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1170 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1110
1180 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
