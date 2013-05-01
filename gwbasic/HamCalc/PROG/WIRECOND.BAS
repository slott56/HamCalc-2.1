10 :REM'WIRECOND - Maximum number of wires in a conduit - 11 MAR 96 rev.13 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 U1$="##,###.###"
70 U2$="##,###"
80 I$="conduit inside diameter"
90 O$="wire/cable outside diameter"
100 N$="number of wires/cables"
110 :REM'
120 COLOR 15,2
130 PRINT " WIRES in CONDUIT";TAB(57)"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 7,0
160 GOSUB 1380    :REM'preface
170 PRINT
180 COLOR 0,7
190 LOCATE ,23
200 PRINT " Press 1 to continue or 0 to EXIT..."
210 COLOR 7,0
220 Z$=INKEY$:IF Z$=""THEN 220
230 IF Z$="1"THEN 260
240 IF Z$="0"THEN CLS:RUN EX$
250 GOTO 220
260 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
270 :REM'
280 :REM'.....start
290 ID=0:OD=0:NW=0
300 ID$="Specified "
310 OD$="Specified "
320 NW$="Specified "
330 PRINT " Enter dimensions in any unit (e.g. inches, millimetres etc.)"
340 PRINT " The results will be displayed in the same units."
350 PRINT
360 PRINT " Two of the following factors must be known."
370 PRINT " Press number in ( ) to identify the UNKNOWN factor....."
380 PRINT UL$;
390 PRINT "   (1) ";I$
400 PRINT "   (2) ";O$
410 PRINT "   (3) ";N$
420 Z$=INKEY$:IF Z$=""THEN 420
430 IF Z$="1"THEN Y$=I$:GOTO 480
440 IF Z$="2"THEN Y$=O$:GOTO 480
450 IF Z$="3"THEN Y$=N$:GOTO 480
460 GOTO 420
470 :REM'
480 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
490 PRINT " To find ";Y$;":"
500 PRINT
510 IF Y$=I$ OR ID<>0 GOTO 530
520 PRINT " ENTER: ";I$;:INPUT ID:GOSUB 590
530 IF Y$=O$ OR OD<>0 GOTO 550
540 PRINT " ENTER: ";O$;:INPUT OD:GOSUB 590
550 IF Y$=N$ OR NW<>0 GOTO 570
560 PRINT " ENTER: ";N$;:INPUT NW:GOSUB 590
570 GOTO 510
580 :REM'
590 IF ID*OD<>0 THEN 1000
600 IF ID*NW<>0 THEN 1130
610 IF OD*NW<>0 THEN 1260
620 RETURN
630 :REM'
640 :REM'.....display results
650 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
660 PRINT TAB(26)"WIRES/CABLES PACKED IN A CONDUIT"
670 PRINT TAB(15);STRING$(52,205)""
680 PRINT TAB(15)NW$;N$;STRING$(32-LEN(N$),".");USING U2$;NW
690 PRINT TAB(15)OD$;O$;STRING$(32-LEN(O$),".");USING U1$;OD
700 PRINT TAB(15)ID$;I$;STRING$(32-LEN(I$),".");USING U1$;ID
710 PRINT
720 PRINT TAB(5)"* ";Y$;" includes packing clearance allowances."
730 PRINT UL$;
740 PRINT
750 COLOR 15,4
760 LOCATE ,31:PRINT " ╔═══════════════╗ "
770 LOCATE ,31:PRINT " ║ W A R N I N G ║ "
780 LOCATE ,31:PRINT " ╚═══════════════╝ "
790 COLOR 7,0
800 PRINT
810 T=7
820 PRINT TAB(T);
830 PRINT "The overriding factor governing the maximum number of conductors"
840 PRINT TAB(T);
850 PRINT "in a conduit is the danger of fire due to heat build-up caused by"
860 PRINT TAB(T);
870 PRINT "current flow through the conductors."
880 PRINT
890 COLOR 12
900 PRINT TAB(T);
910 PRINT "The maximum number of conductors allowed by your local Electrical"
920 PRINT TAB(T);
930 PRINT "Codes may be less than the maximum number of conductors that will"
940 PRINT TAB(T);
950 PRINT "physically fit into the conduit."
960 COLOR 7
970 GOTO 1590
980 END
990 :REM'
1000 :REM'.....Conduit ID (D) and wire OD known
1010 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1020 N=0:NW$="* Maximum "
1030 N=N+0.009999999776482582!      :REM'number of complete layers
1040 W=3*N^2+3*N+1:D=(2*N+1)*OD:GOSUB 1090
1050 W=3*N^2+5*N+2:D=(2*N+2)*OD:GOSUB 1090
1060 W=3*N^2+6*N+3:D=(1+2*SQR(N^2+N+1/3))*OD:GOSUB 1090
1070 W=3*N^2+7*N+4:D=(1+SQR(4*N^2+5.644000053405762!*N+2))*OD:GOSUB 1090
1080 GOTO 1030
1090 IF D>=ID THEN 640
1100 NW=W
1110 RETURN
1120 :REM'
1130 :REM'.....Conduit ID (ID) and number of wires (NW) known
1140 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1150 N=0:OD$="* Maximum "
1160 N=N+0.009999999776482582!      :REM'number of complete layers
1170 W=3*N^2+3*N+1:WD=ID/(2*N+1):GOSUB 1220
1180 W=3*N^2+5*N+2:WD=ID/(2*N+2):GOSUB 1220
1190 W=3*N^2+6*N+3:WD=ID/(1+2*SQR(N^2+N+1/3)):GOSUB 1220
1200 W=3*N^2+7*N+4:WD=ID/(1+SQR(4*N^2+5.644000053405762!*N+2)):GOSUB 1220
1210 GOTO 1160
1220 IF W>=NW THEN 640
1230 OD=WD
1240 RETURN
1250 :REM'
1260 :REM'.....Wire OD (OD) and number of wires (NW) known
1270 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOSUB 1380
1280 N=0:ID$="* Minimum "
1290 N=N+1      :REM'number of complete layers
1300 W=3*N^2+3*N+1:WD=(2*N+1)*OD
1310 W=3*N^2+5*N+2:WD=(2*N+2)*OD:GOSUB 1350
1320 W=3*N^2+6*N+3:WD=(1+2*SQR(N^2+N+1/3))*OD:GOSUB 1350
1330 W=3*N^2+7*N+4:WD=(1+SQR(4*N^2+5.644000053405762!*N+2))*OD:GOSUB 1350
1340 GOTO 1290
1350 IF W>=NW THEN ID=2*SQR(((WD/2)^2)*1.0199999809265137!):GOTO 640
1360 RETURN
1370 :REM'
1380 :REM'.....preface
1390 T=8
1400 PRINT TAB(T);
1410 PRINT "This program computes the geometry of a circle enclosing a given"
1420 PRINT TAB(T);
1430 PRINT "number of smaller circles all of the same size, such as a conduit"
1440 PRINT TAB(T);
1450 PRINT "or hole surrounding a number of same-size wires or cables."
1460 PRINT
1470 PRINT TAB(T);
1480 PRINT "The calculations are based on formulae published in Machinery's"
1490 PRINT TAB(T);
1500 PRINT "Handbook, Revised 21st Edition, pages 86-87, adjusted to provide"
1510 PRINT TAB(T);
1520 PRINT "clearances to ease the near-impossible task of trying to pack the"
1530 PRINT TAB(T);
1540 PRINT "theoretical maximum number of wires into any appreciable length"
1550 PRINT TAB(T);
1560 PRINT "of conduit."
1570 RETURN
1580 :REM'
1590 :REM'.....end
1600 GOSUB 1640
1610 CLS:GOTO 120
1620 END
1630 :REM'
1640 :REM'....PRT
1650 KEY OFF:GOSUB 1720:LOCATE 25,5:COLOR 0,2
1660 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1670 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1680 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1680 :ELSE GOSUB 1720
1690 IF Z$="3"THEN RETURN
1700 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1710 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1650
1720 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
