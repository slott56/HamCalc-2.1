10 :REM'HAIRPIN - Hairpin match for Yagi antennas - 10 MAR 95 rev. 25 OCT 1998
20 IF EX$=""THEN EX$="EXIT"      :REM'if ex$ not chained from previous program
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF:COLOR 7,0,1
60 UL$=STRING$(80,205)
70 U1$="#####.###"
80 U2$="###.#"
90 PI=3.1415929794311523!
100 :REM'
110 COLOR 15,2
120 PRINT " HAIRPIN BETA-MATCH for YAGI ANTENNAS";
130 PRINT TAB(55);"by Tom Cefalo Jr., WA1SPI ";
140 PRINT STRING$(80,32);
150 LOCATE CSRLIN-1,20:PRINT "edited for HAMCALC by George Murphy VE3ERP"
160 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
170 MARGIN=7
180 PRINT TAB(MARGIN);
190 PRINT "This program is adapted from WA1SPI's review of the Hairpin ";
200 PRINT "beta-match"
210 PRINT TAB(MARGIN);
220 PRINT "which was published in the Summer 1994 edition of Communications"
230 PRINT TAB(MARGIN);
240 PRINT "Quarterly, pp. 49-54. Refer to this article for theory of operation"
250 PRINT TAB(MARGIN);
260 PRINT "and construction details."
270 PRINT
280 :REM'
290 :REM'.....schematic
300 TB=19
310 COLOR 0,7
320 LOCATE ,TB:PRINT "                    ┬ ┬                    "
330 LOCATE ,TB:PRINT "                    │ │                    "
340 LOCATE ,TB:PRINT "            Boom ──»│ │                    "
350 LOCATE ,TB:PRINT "                 ┌╨─┴─┴─╨┐«── Shorting bar "
360 LOCATE ,TB:PRINT "                 └╥─┬─┬─╥┘    bolted to    "
370 LOCATE ,TB:PRINT "  Hairpin rods ──»║─┼─┼»║     boom         "
380 LOCATE ,TB:PRINT "                  ║ │ │ ║                  "
390 LOCATE ,TB:PRINT " ┌» ══════════════╩╦╪■╪╦╩══════════════    "
400 LOCATE ,TB:PRINT " └ Driven element  ║└─┘║                   "
410 LOCATE ,TB:PRINT " (split at centre)┌╨───╨┐                  "
420 LOCATE ,TB:PRINT "                  │ 1:1 │«── Balun         "
430 LOCATE ,TB:PRINT "                  └──▄──┘                  "
440 LOCATE ,TB:PRINT "                     █ «── Feedline        "
450 LOCATE ,TB:PRINT "                                           "
460 COLOR 7,0
470 LOCATE 24,14
480 COLOR 0,7
490 PRINT "........Press <1> to CONTINUE or <0> to EXIT.........";
500 COLOR 7,0
510 Z$=INKEY$
520 IF Z$="0"THEN CLS:CHAIN GO$
530 IF Z$="1"THEN LOCATE CSRLIN-1:PRINT STRING$(80,32);:GOTO 550
540 GOTO 510
550 GOSUB 1270      :REM'screen dumpLIST
560 :REM'
570 VIEW PRINT 2 TO 24:CLS:VIEW PRINT:LOCATE 2:PRINT UL$;
580 PRINT " Press number in < > to choose standard units of measure:"
590 PRINT UL$;
600 PRINT "   < 1 >  Metric"
610 PRINT "   < 2 >  U.S.A./Imperial"
620 Z$=INKEY$
630 IF Z$="1" THEN UM=25.399999618530273!:UM$="mm.":GOTO 660
640 IF Z$="2" THEN UM=1:UM$="in.":GOTO 670
650 GOTO 620
660 :REM'
670 :REM'.....data input
680 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
690 GOTO 760
700 :REM'
710 :REM'.....format entry
720 LOCATE CSRLIN-1:PRINT "       ";
730 LOCATE CSRLIN,58:PRINT USING U1$;Y;
740 RETURN
750 :REM'
760 INPUT " ENTER: Frequency.........................................(MHz) ";F
770 Y=F:GOSUB 710:PRINT " MHz  ":F=F*10^6
780 INPUT " ENTER: Antenna Feedpoint Resistance.....................(ohms) ";RA
790 Y=RA:GOSUB 710:PRINT " Ω    "
800 INPUT " ENTER: Transmission Line Impedance......................(ohms) ";ZO
810 Y=ZO:GOSUB 710:PRINT " Ω    "
820 IF RA<ZO THEN 900
830 :REM'
840 BEEP:LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1,8:COLOR 0,7
850 PRINT " Impedance must be greater than Feedpoint Resistance";
860 PRINT "....press any key.":COLOR 7,0
870 IF INKEY$=""THEN 870
880 BEEP:LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 800
890 :REM'
900 PRINT " ENTER: Hairpin Rod Diameter.............................(";UM$;")";
910 INPUT D:D=D/UM
920 Y=D*UM:GOSUB 710:PRINT " ";UM$
930 PRINT " ENTER: Hairpin Rod Spacing ( centre-to-centre ).........(";UM$;")";
940 INPUT S:S=S/UM
950 Y=S*UM:GOSUB 710:PRINT " ";UM$
960 :REM'
970 :REM'.....calculate
980 XA=SQR((ZO*RA)-RA^2): XL=ZO*RA/XA: A=S/D
990 ZHP=120*LOG(A+SQR(A^2-1)): EL=ATN(XL/ZHP)*180/PI
1000 PHYL=(300000000.0!*EL*39.369998931884766!*0.9750000238418579!)/(F*360)
1010 ZIN=SQR((XA*XL)^2+(XL*RA)^2)/SQR(RA^2+(XL-XA)^2)
1020 THETA#=ATN(RA/XA)-ATN((XL-XA)/RA): L=XL/(2*PI*F)
1030 RE=ZIN*COS(THETA#): IM=ZIN*SIN(THETA#)
1040 K=RE/ZO: P=SQR((K-1)^2+IM^2)/SQR((K+1)^2+IM^2)
1050 V=(1+P)/(1-P)
1060 :REM'
1070 PRINT "        Adjust Antenna Capacitive Reactance..............";
1080 PRINT USING U1$;XA;:PRINT " Ω"
1090 PRINT
1100 PRINT "        Hairpin Impedance................................";
1110 PRINT USING U1$;ZHP;:PRINT " Ω"
1120 PRINT "        Equivalent Inductance............................";
1130 PRINT USING U1$;L*10^6;:PRINT " µH"
1140 PRINT "        Electrical Length................................";
1150 PRINT USING U1$;EL;:PRINT "°"
1160 PRINT "        Physical Length..................................";
1170 IF UM=1 THEN M=1:M$="in." :ELSE M=2.5399999618530273!:M$="cm."
1180 PRINT USING U1$;PHYL*M;:PRINT " ";M$
1190 IF SGN(IM)=-1 THEN A$="-j":ELSE A$="+j"
1200 PRINT "        Impedance Seen by the Transmitter................";
1210 PRINT USING U1$;RE;:PRINT A$;USING U2$;ABS(IM);:PRINT " Ω"
1220 PRINT "        VSWR.............................................";
1230 PRINT USING U1$;V;:PRINT ":1"
1240 PRINT UL$;
1250 GOSUB 1270:GOTO 10
1260 :REM'
1270 :REM'PRT
1280 KEY OFF:GOSUB 1350:LOCATE 25,5:COLOR 0,2
1290 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1300 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1310 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1310 :ELSE GOSUB 1350
1320 IF Z$="3"THEN RETURN
1330 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1340 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1280
1350 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
