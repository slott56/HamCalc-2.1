10 :REM'555TIMER - 19 JAN 91  rev. 06 JUN 2007
20   :REM'formulae from Radio Shack "Programs for Electronic Circuit Design"
30   :REM'by David Leithauser, cat.#62-1054, pages 85-87
40 IF EX$=""THEN EX$="EXIT"
50 CLS:KEY OFF
60 COLOR 7,0,1
70 UL$=STRING$(80,205)
80 U$="######,###.###"
90 U1$="######,###.##"
100 U2$="######,###"
110 :REM'
120 :REM'.....start
130 IF F*R1*R2*C=0 AND D*R1*C=0 THEN CLS:GOTO 330
140 VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE 17
150 PRINT  " Press number in < > to run again with:"
160 IF F  THEN PRINT "  < 1 >  same FQ"
170 IF R1 THEN PRINT "  < 2 >  same R1"
180 IF R2 THEN PRINT "  < 3 >  same R2"
190 IF C  THEN PRINT "  < 4 >  same C1"
200 IF D  THEN PRINT "  < 5 >  same PD"
210 PRINT "  < 0 >  all new variables, or EXIT"
220 Z$=INKEY$:IF Z$=""THEN 220
230 IF Z$="0"THEN 330
240 V=VAL(Z$):IF V<0 OR V54 THEN 220
250 VIEW PRINT 17 TO 24:CLS:VIEW PRINT:LOCATE 17
260 IF V=1 THEN R1=0:R2=0:C=0:D=0
270 IF V=2 THEN F=0:R2=0:C=0:D=0
280 IF V=3 THEN F=0:R1=0:C=0:D=0
290 IF V=4 THEN F=0:R1=0:R2=0:D=0
300 IF V=5 THEN F=0:R1=0:R2=0:C=0
310 IF FLAG$="MON" THEN 1480 :ELSE 530
320 :REM'
330 :REM'.....clear all variables
340 CLS
350 C=0:C1=0:D=0:F=0:R1=0:R2=0
360 CC=0:CR1=0:CR2=0:HT=0:LT=0:Y=0:T=0
370 COLOR 15,2
380 PRINT " 555 TIMER CALCULATOR";TAB(57);"by George Murphy VE3ERP ";
390 COLOR 1,0:PRINT STRING$(80,223);
400 COLOR 7,0
410 PRINT " Press number in < > for:"
420 PRINT UL$;
430 PRINT "  < 1 >  ASTABLE application     (Free-Running Multivibrator)"
440 PRINT "  < 2 >  MONOSTABLE application  (One-shot Timer)"
450 PRINT UL$;
460 PRINT "  < 0 >  EXIT"
470 Z$=INKEY$
480 IF Z$="0"THEN CLS:RUN EX$
490 IF Z$="1"THEN FLAG$="AST":GOTO 530
500 IF Z$="2"THEN FLAG$="MON":GOTO 1490
510 GOTO 470
520 :REM'
530 :REM'.....Astable multivibrator
540 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
550 TWO$="TRIG":SIX$="R2 Ω"
560 LOCATE 1:COLOR 15,2
570 PRINT " 555 TIMER AS AN ASTABLE FREE-RUNNING MULTIVIBRATOR"
580 COLOR 1,0:PRINT STRING$(80,223);
590 :REM'
600 :REM'.....inputs
610 GOSUB 1880
620 LOCATE 4
630 INPUT " ENTER: Freq.in Hz.(0 if unknown)......";F:GOSUB 800
640 IF F<32750 THEN 680
650 PRINT :PRINT " Hz must be less than 32750! ...press any key...! "
660 Z$=INKEY$:IF Z$=""THEN 660
670 CLS:GOTO 120
680 IF F AND C=0 THEN R2=1000
690 IF R1 THEN 720
700 CR1=1:GOSUB 1880:PRINT " ENTER: R1 in Kohms (0 if unknown)....";
710 INPUT Z:R1=Z*1000:GOSUB 800
720 IF R2 THEN 750
730 CR2=2:GOSUB 1880:PRINT " ENTER: R2 in Kohms (0 if unknown)....";
740 INPUT Z:R2=Z*1000:GOSUB 800
750 IF C THEN 610
760 CC=1:GOSUB 1880:INPUT " ENTER: C1 in µF.  (0 if unknown).....";C
770 C=C/10^6:GOSUB 800
780 GOTO 600
790 :REM'
800 :REM'.....calculate
810 IF R1*R2*C THEN F=1/0.6930000185966492!/((R1+2*R2)*C):GOTO 870
820 IF R1*R2*F THEN C=1/0.6930000185966492!/((R1+2*R2)*F):GOTO 870
830 IF C*F*R2 THEN R1=1/0.6930000185966492!/(C*F)-2*R2:GOTO 870
840 IF C*F*R1 THEN R2=1/0.6930000185966492!/2/(C*F)-R1/2:GOTO 870
850 RETURN
860 :REM'
870 :REM'.....display results
880 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
890 CR1=1:CR2=1:CC=1
900 GOSUB 1880:LOCATE 3
910 PRINT " FQ (frequency)....:";USING U2$;F;: PRINT " Hz."
920 PRINT " R1 ...............:";USING U2$;R1/1000;:PRINT " KΩ"
930 PRINT " R2 ...............:";USING U2$;R2/1000;:PRINT " KΩ"
940 PRINT " C1 ...............:";USING U$;C*10^6;:PRINT " µF"
950 HT=0.6930000185966492!*(R1+R2)*C*10^3       :REM'high time
960 LT=0.6930000185966492!*R2*C*10^3            :REM'low time
970 PRINT " Pulse Cycle Time  :";USING U1$;LT+HT;:PRINT "  milliseconds"
980 PRINT " Output Low Time   :";USING U$;LT;:PRINT " milliseconds"
990 PRINT " Output High Time  :";USING U$;HT;:PRINT " milliseconds"
1000 PRINT " Percent High Time :";USING U$;(HT/(HT+LT)*100);:PRINT " %"
1010 COLOR 0,7
1020 IF ABS(R1)<1000 THEN PRINT" R1 should be 1000 Ω or more !               "
1030 IF ABS(R2)<1000 THEN PRINT" R2 should be 1000 Ω or more !               "
1040 IF R1+R2>3300000.0! THEN PRINT" Total of R1+R2 should be 3.3 megΩ or less ! "
1050 IF ABS(C)<4.999999858590343e-10! THEN PRINT" C1 should be .0005 µF or more !             "
1060 IF F>10^6 THEN PRINT  " Frequency should be 1.0 MHz or less !       "
1065 IF ABS (C)<9.999999974752427e-07! THEN PRINT " C1 too low - try another!"
1070 IF R1<0 OR R1<0 OR C<0 THEN PRINT" WARNING - IMPOSSIBLE COMPONENT VALUES !"
1080 COLOR 7,0
1090 LOCATE 15:PRINT " (NOTE: Calculated values have been rounded off)"
1100 LOCATE 17
1110 PRINT " Percent High Time - is a function of the relationship of R1 to R2."
1120 PRINT "                   - must be greater than 50% and less than 100%"
1130 PRINT "                   - is, for example, 55.556% when R1 = ¼ R2"
1140 PRINT "                                      66.667% when R1 = R2"
1150 PRINT "                                      75.000% when R1 = 2 x R2"
1160 PRINT "                                      83.333% when R1 = 4 x R2"
1170 COLOR 0,7
1180 PRINT " Would you like to change the Percent High Time?    (y/n)":COLOR 7,0
1190 Z$=INKEY$
1200 IF Z$="n"THEN 1240
1210 IF Z$="y"THEN 1380
1220 GOTO 1190
1230 :REM'
1240 VIEW PRINT 18 TO 24:CLS:VIEW PRINT:LOCATE 18
1250 IF F<37 OR F>15000 THEN 1360 :ELSE COLOR 0,7
1260 PRINT " Note: Some people may have trouble hearing tones higher than ";
1270 PRINT "4186 Hz. (the "
1280 PRINT " highest note on most pianos)."
1290 PRINT
1300 PRINT " Would you like to hear a";CINT(F);"Hz tone?   (y/n) ":COLOR 7,0
1310 Z$=INKEY$:IF Z$=""THEN 1310
1320 IF Z$="n"OR Z$="y"THEN VIEW PRINT 17 TO 24:CLS:VIEW PRINT
1330 IF Z$="n"THEN 1360
1340 IF Z$="y"THEN SOUND F,36:GOTO 1360
1350 GOTO 1310
1360 GOSUB 2200:GOTO 120
1370 :REM'
1380 LOCATE CSRLIN-1:PRINT STRING$(79,32):LOCATE CSRLIN-1:COLOR 0,7
1390 INPUT " ENTER: Desired Percent High Time...........";PC:COLOR 7,0
1400 P=PC/100
1410 Y=(2*P-1)/(1-P)        :REM'ratio R1:R2
1420 T=R1+2*R2              :REM'constant
1430 R2=T/(Y+2)             :REM'new value of R2
1440 R1=R2*Y
1450 F=0:GOTO 810
1460 GOTO 120
1470 :REM'
1480 :REM'.....monostable multivibrator
1490 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
1500 TWO$="IN  ":SIX$="│"
1510 LOCATE 1:COLOR 15,2
1520 PRINT " 555 TIMER AS A ONE-SHOT TIMER"
1530 COLOR 1,0:PRINT STRING$(80,223);
1540 COLOR 7,0
1550 :REM'
1560 :REM'.....inputs
1570 GOSUB 1880:LOCATE 4:IF D THEN 1590
1580 INPUT " ENTER: Pulse in sec.(0 if unknown)";D:GOSUB 1660
1590 IF R1 THEN 1610
1600 CR1=1:GOSUB 1880:INPUT " ENTER: R1 in ohms...(0 if unknown)";R1:GOSUB 1660
1610 IF C THEN 1570
1620 CC=1:GOSUB 1880:INPUT " ENTER: C1 in µF. ...(0 if unknown)";C
1630 C=C/10^6:GOSUB 1660
1640 GOTO 1560
1650 :REM'
1660 :REM'.....calculation
1670 IF D*C THEN R1=D/(1.4429999589920044!*C):GOTO 1720      :REM'1.443=1/.693
1680 IF D*R1 THEN C=D/(1.4429999589920044!*R1):GOTO 1720
1690 IF R1*C THEN D=1.4429999589920044!*R1*C:GOTO 1720
1700 RETURN
1710 :REM'
1720 :REM'.....display results
1730 VIEW PRINT 3 TO 24:CLS
1740 CR1=1:CC=1
1750 GOSUB 1880:LOCATE 3
1760 PRINT " R1 ................:";USING U2$;R1;:PRINT "     Ω"
1770 PRINT " C1 ................:";USING U$;C*10^6;:PRINT " µF"
1780 PRINT " PD (pulse duration):";USING U$;D;:PRINT " seconds"
1790 COLOR 0,7
1800 IF R1>3300000.0! THEN PRINT " R1 should be 3.3 megohms or less ! "
1810 IF ABS(R1)<10^3 THEN PRINT  " R1 should be 1000 ohms or more !   "
1820 IF ABS(C)<4.999999858590343e-10! THEN PRINT " C1 should be .0005 µF or more !    "
1830 COLOR 7,0
1840 LOCATE 15:PRINT " (NOTE: Calculated values have been rounded off)"
1850 GOSUB 2200
1860 GOTO 120   :REM'start
1870 :REM'
1880 :REM'.....diagram
1890 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
1900 COLOR 7,0
1910 LOCATE 3       :REM'line
1920 LN=3
1930 CN=52          :REM'base column
1940 COLOR 0,7
1950 LOCATE ,CN:PRINT "           +5v to +15v      "
1960 LOCATE ,CN:PRINT "      ┌───────┐ │           "
1970 LOCATE ,CN:PRINT " GRND ┤1     8├─┤ +Vcc      "
1980 LOCATE ,CN:PRINT "      │       │ R1 Ω        "
1990 LOCATE ,CN:PRINT " TRIG ┤2     7├─┤ Discharge "
2000 LOCATE ,CN:PRINT "      │  555  │             "
2010 LOCATE ,CN:PRINT " OUT  ┤3     6├─┤ Threshold "
2020 LOCATE ,CN:PRINT "      │       │ │           "
2030 LOCATE ,CN:PRINT " RESET┤4     5├ │ Control V "
2040 LOCATE ,CN:PRINT "      └───────┘ │           "
2050 LOCATE ,CN:PRINT "                C1 µF       "
2060 LOCATE ,CN:PRINT "                │           "
2070 LOCATE ,CN:PRINT "              \\┴\\         "
2080 LOCATE LN+5,CN+16:PRINT SIX$
2090 COLOR 7,0
2100 LOCATE 16:PRINT UL$;
2110 :REM'.....hi-lites
2120 IF CR1 THEN COLOR 7,0:LOCATE LN+3,CN+15:PRINT " R1 Ω"
2130 IF CR2 THEN COLOR 7,0:LOCATE LN+5,CN+15:PRINT " ";SIX$
2140 IF CC THEN COLOR  7,0:LOCATE LN+10,CN+15:PRINT " C1 µF"
2150 CR1=0:CR2=0:CC=0
2160 COLOR 7,0
2170 LOCATE CSRLIN-1
2180 RETURN
2190 :REM'
2200 :REM'PRT
2210 KEY OFF:GOSUB 2280:LOCATE 25,5:COLOR 0,2
2220 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2230 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2240 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2240 :ELSE GOSUB 2280
2250 IF Z$="3"THEN RETURN
2260 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2270 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2200
2280 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
