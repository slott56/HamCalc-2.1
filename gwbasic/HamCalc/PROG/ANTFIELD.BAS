10 :REM'ANTFIELD - Antenna Field Strength - 07 JUN 95  rev. 08 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 UL$=STRING$(80,205)
80 U$="#####.###"
90 :REM'
100 :REM'.....start
110 COLOR 15,2
120 PRINT " ANTENNA FIELD STRENGTH";TAB(64);"(author unknown) ";
130 PRINT STRING$(80,32);
140 LOCATE CSRLIN-1,2:PRINT "modified by ";CHR$(34);"LB";CHR$(34);" Cebik, ";
150 PRINT "W4RNL, and edited for HAMCALC by George Murphy, VE3ERP"
160 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
170 :REM'
180 PRINT " Press number in < > to choose standard units of measure:"
190 PRINT UL$;
200 PRINT "  < 1 >  Metric"
210 PRINT "  < 2 >  U.S.A./Imperial"
220 PRINT UL$;
230 PRINT "    or Press < 0 > to EXIT"
240 Z$=INKEY$
250 IF Z$="1"THEN UM=1:UM$="metres":GOTO 290
260 IF Z$="2"THEN UM=0.30480000376701355!:UM$="feet":GOTO 290
270 IF Z$="0"THEN CLS:CHAIN GO$
280 GOTO 240
290 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
300 :REM'
310 :REM'.....inputs
320 M=7
330 PRINT TAB(M);
340 PRINT"Antenna field strength relatively close to an antenna is measured in"
350 PRINT TAB(M);
360 PRINT"volts per metre and can be reasonably estimated from the effective"
370 PRINT TAB(M);
380 PRINT"height of the antenna, the RF power into the antenna at a known"
390 PRINT TAB(M);
400 PRINT"impedance, the operating frequency, and the distance from the"
410 PRINT TAB(M);
420 PRINT "antenna."
430 PRINT UL$;
440 GOTO 510
450 :REM'
460 :REM'.....format input line
470 LOCATE CSRLIN-1:PRINT SPC(7);
480 LOCATE CSRLIN,59:PRINT USING U$;Z;
490 RETURN
500 :REM'
510 :REM'.....data input
520 V$=UM$
530 PRINT " ENTER: Effective antenna height..........................(";V$;")";
540 INPUT Z:GOSUB 460:PRINT " ";V$:B=Z*UM
550 :REM'
560 V$="watts"
570 PRINT " ENTER: Power at antenna..................................(";V$;")";
580 INPUT Z:GOSUB 460:PRINT " ";V$:P=Z
590 :REM'
600 V$="ohms"
610 PRINT " ENTER: Antenna impedance (not including transmatch)......(";V$;")";
620 INPUT Z:GOSUB 460:PRINT " ";V$:O=Z:I=SQR(P/O)
630 :REM'
640 V$="MHz"
650 PRINT " ENTER: Operating frequency...............................(";V$;")";
660 INPUT Z:GOSUB 460:PRINT " ";V$:F=Z:W=300/F
670 :REM'
680 V$=UM$
690 PRINT " ENTER: Distance from antenna.............................(";V$;")";
700 INPUT D:R=D*UM
710 E=(188*B*I)/(W*R)
720 V$="volts/metre"
730 LOCATE CSRLIN-1
740 PRINT "        Field strength @";D;UM$;" from antenna................";
750 LOCATE CSRLIN,59
760 PRINT USING U$;E;:PRINT " ";V$
770 GOSUB 820
780 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
790 CLS:GOTO 100     :REM'return to start
800 END
810 :REM'
820 :REM'PRT
830 KEY OFF:GOSUB 900:LOCATE 25,5:COLOR 0,2
840 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
850 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
860 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 860 :ELSE GOSUB 900
870 IF Z$="3"THEN RETURN
880 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
890 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 830
900 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
