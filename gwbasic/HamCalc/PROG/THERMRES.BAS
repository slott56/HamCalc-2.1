10 :REM'THERMRES - Thermal Resistance - 04 DEC 1997
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 U$="#####.###"
70 :REM'
80 :REM'.....start
90 F=0:P=0:B=0:K=0:L=0:A=0:T=0:O=0
100 CLS
110 COLOR 15,2
120 PRINT " THERMAL RESISTANCE"TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 GOSUB 1330  :REM'preface
160 PRINT
170 COLOR 0,7:LOCATE ,24:PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
180 Z$=INKEY$:IF Z$=""THEN 180
190 IF Z$="0"THEN CLS:RUN EX$
200 IF Z$="1"THEN 220
210 GOTO 180
220 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
230 GOSUB 1460
240 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
250 PRINT TAB(TB);
260 PRINT "Enter length and cross-section area of the conductive material in"
270 PRINT TAB(TB);
280 PRINT "the same units, e.g.,inches & square inches, mm & mm², etc."
290 PRINT
300 PRINT TAB(TB);
310 PRINT "In practical applications the actual input power to the conductive"
320 PRINT TAB(TB);
330 PRINT "material may be considerably less than the rated output of the"
340 PRINT TAB(TB);
350 PRINT "heating device due to heat dissipation to the surrounding"
360 PRINT TAB(TB);
370 PRINT "environment other than the conductive material. E.G., a 25 watt"
380 PRINT TAB(TB);
390 PRINT "soldering iron applied to the end of a wire could lose considerable"
400 PRINT TAB(TB);
410 PRINT "heat to the air around it and only transfer as little as 10 watts"
420 PRINT TAB(TB);
430 PRINT "of heat energy to the wire."
440 PRINT UL$;
450 :REM'
460 :REM'.....inputs
470 LN=CSRLIN
480 :REM'
490 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
500 IF F THEN 540
510 PRINT " ENTER: Ambient temperature in °C.............................";
520 PRINT "......";:INPUT F:GOSUB 840
530 :REM'
540 IF P THEN 580
550 PRINT " ENTER: Power (heat) conducted between two points, in watts...";
560 PRINT "......";:INPUT P:GOSUB 840
570 :REM'
580 IF B THEN 620
590 PRINT " ENTER: Power (heat) conducted between two points, in Btu/hour";
600 PRINT "......";:INPUT B:GOSUB 840
610 :REM'
620 IF K THEN 660
630 PRINT " ENTER: Thermal conductance K of conductor, in milliwatts per ";
640 PRINT "°C....";:INPUT K:GOSUB 840
650 :REM'
660 IF L THEN 700
670 PRINT " ENTER: Length of conductor...................................";
680 PRINT "......";:INPUT L:GOSUB 840
690 :REM'
700 IF A THEN 740
710 PRINT " ENTER: Cross-section area of conductor.......................";
720 PRINT "......";:INPUT A:GOSUB 840
730 :REM'
740 IF T THEN 780
750 PRINT " ENTER: Change in temperature between the two points, in °C ..";
760 PRINT "......";:INPUT T:GOSUB 840
770 :REM'
780 IF O THEN 820
790 PRINT " ENTER: Thermal resistance of conductor, in °C per watt.......";
800 PRINT "......";:INPUT O:GOSUB 840
810 :REM'
820 GOTO 490
830 :REM'
840 :REM'.....calculate
850 IF B=0 AND P<>0       THEN B=P*3.4119999408721924!:GOTO 840
860 IF P=0 AND B<>0       THEN P=B/3.4119999408721924!:GOTO 840
870 IF P=0 AND K*A*L*T<>0 THEN P=K*A/L*T:GOTO 840
880 IF P=0 AND T*O<>0     THEN P=T/O:    GOTO 840
890 IF K=0 AND P*A*L*T<>0 THEN K=P*L/T/A:GOTO 840
900 IF L=0 AND P*A*K*T<>0 THEN L=K*A*T/P:GOTO 840
910 IF A=0 AND P*K*L*T<>0 THEN A=P*L/T/K:GOTO 840
920 IF T=0 AND P*K*L*A<>0 THEN T=P*L/A/K:GOTO 840
930 IF T=0 AND P*O<>0     THEN T=P*O:    GOTO 840
940 IF O=0 AND L*K*A<>0   THEN O=L/K/A:  GOTO 840
950 IF O=0 AND P*T<>0     THEN O=T/P:    GOTO 840
960 :REM'
970 IF P*K*A*L*T*O<>0 THEN 1000
980 RETURN
990 :REM'
1000 :REM'.....print
1010 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1020 PRINT " Ambient temperature......................................";
1030 PRINT USING U$;F;:PRINT "°C"
1040 PRINT SPC(57)"=";USING U$;9*F/5+32;:PRINT "°F"
1050 PRINT
1060 PRINT " Power (in form of heat) conducted between two points.....";
1070 PRINT USING U$;P;:PRINT " watts"
1080 PRINT SPC(57)"=";USING U$;B;:PRINT " Btu/hour"
1090 PRINT
1100 PRINT " Thermal conductance K of conductor.......................";
1110 PRINT USING U$;K;:PRINT " mW per °C"
1120 PRINT " Length of conductor......................................";
1130 PRINT USING U$;L;:PRINT " units"
1140 PRINT " Cross-section area of conductor..........................";
1150 PRINT USING U$;A;:PRINT " units²"
1160 PRINT " Thermal resistance of conductor..........................";
1170 PRINT USING U$;O;:PRINT "°C per watt"
1180 PRINT " Change in temperature between the two points.............";
1190 PRINT USING U$;T;:PRINT "°C"
1200 PRINT
1210 PRINT " Temperature at hot end of conductor (ambient + change)...";
1220 PRINT USING U$;T+F;:PRINT "°C"
1230 PRINT SPC(57)"=";USING U$;9*(T+F)/5+32;:PRINT "°F"
1240 PRINT
1250 PRINT TAB(TB);
1260 PRINT "If this appears a little high, remember that this is for the steady"
1270 PRINT TAB(TB);
1280 PRINT "state condition, where the heat source has been applied to the"
1290 PRINT TAB(TB);
1300 PRINT "conductive material for a long time."
1310 GOTO 1690 :REM'end
1320 :REM'
1330 :REM'.....preface
1340 TB=7
1350 PRINT TAB(TB);
1360 PRINT "This program computes the transfer of heat energy, and thus the"
1370 PRINT TAB(TB);
1380 PRINT "change in temperature, between two ends of a block of material,"
1390 PRINT TAB(TB);
1400 PRINT "such as a heat sink."
1410 PRINT
1420 PRINT TAB(TB);
1430 PRINT "(ref. the 1997 ARRL HANDBOOK for RADIO AMATEURS, page 10.16)"
1440 RETURN
1450 :REM'
1460 :REM'.....chart
1470 PRINT " THERMAL CONDUCTIVITIES OF VARIOUS MATERIALS"
1480 PRINT " Gases at 0°C, others at 25°C"
1490 PRINT " (from PHYSICS, by Halliday and Resnick, 3rd Edition)"
1500 PRINT UL$;
1510 PRINT " MATERIAL          K ( in milliwatts per °C )"
1520 PRINT UL$;
1530 PRINT " Aluminum          200"
1540 PRINT " Brass             110"
1550 PRINT " Copper            390"
1560 PRINT " Lead               35"
1570 PRINT " Silver            410"
1580 PRINT " Steel              46"
1590 PRINT " Silicon           150"
1600 PRINT " Air                 0.024"
1610 PRINT " Glass               0.8"
1620 PRINT " Wood                0.08"
1630 PRINT UL$;
1640 PRINT " Make a note of the K factor for the material of interest."
1650 PRINT " Press any key to continue....."
1660 IF INKEY$=""THEN 1660
1670 RETURN
1680 :REM'
1690 :REM'.....end
1700 GOSUB 1730:GOTO 80
1710 END
1720 :REM'
1730 :REM'PRT
1740 KEY OFF:GOSUB 1810:LOCATE 25,5:COLOR 0,2
1750 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1760 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1770 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1770 :ELSE GOSUB 1810
1780 IF Z$="3"THEN RETURN
1790 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1800 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1740
1810 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
