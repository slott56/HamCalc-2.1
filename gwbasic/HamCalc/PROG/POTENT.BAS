10 :REM'POTENT - Custom Potentiometer - 5 FEB 91 rev. 17 APR 1999
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="potent"
40 COMMON EX$,PROG$,R,E    :REM'for chaining to PRECIRES
50 CLS
60 COLOR 7,0,1
70 DIM SR(12)           :REM'wiper travel
80 UL$=STRING$(80,205)  :REM'underline
90 ER$=STRING$(80,32)   :REM'erase
100 U1$="######,###"
110 U3$="#####,###"
120 O$=" Ω"
130 LF=1/LOG(10)
140 :REM'
150 :REM'.....start
160 CLS
170 COLOR 15,2
180 PRINT " CUSTOM POTENTIOMETERS";TAB(57);"by George Murphy VE3ERP ";
190 COLOR 1,0:PRINT STRING$(80,"▀");
200 COLOR 7,0
210 :REM'
220 :REM'.....preface
230 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
240 GOSUB 1840    :REM'text
250 PRINT
260 COLOR 0,7:LOCATE CSRLIN,22
270 PRINT " Press 1 to continue or 0 to EXIT.....";
280 COLOR 7,0
290 Z$=INKEY$:IF Z$=""THEN 290
300 IF Z$="0"THEN CLS:RUN EX$
310 IF Z$="1"THEN 340
320 GOTO 290
330 :REM'
340 :REM'.....diagram
350 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
360 LOCATE 10,56:PRINT "┌» ───┐"
370 LOCATE 11,56:PRINT "│     │"
380 LOCATE 12,56:PRINT "│     ├───┐"
390 LOCATE 13,56:PRINT "│     │   │"
400 LOCATE 14,56:PRINT "   ┌─»R1  R2"
410 LOCATE 15,56:PRINT "│  └──┤   │"
420 LOCATE 16,56:PRINT "│     ├───┘"
430 LOCATE 17,56:PRINT "│     │"
440 LOCATE 18,56:PRINT "└» ───┘"
450 COLOR 0,7:LOCATE 14,55:PRINT " R ":COLOR 7,0      :REM'hi-lite R
460 :REM'
470 :REM'.....inputs
480 LOCATE 3
490 INPUT " ENTER: Desired custom full scale resistance (ohms)........R =";R
500 IF R=0 THEN LOCATE CSRLIN-1:PRINT ER$;:GOTO 480
510 LOCATE CSRLIN-1:PRINT STRING$(8,32)
520 LOCATE CSRLIN-1,63:COLOR 0,7:PRINT USING U1$;R;:PRINT O$:COLOR 7,0
530 PRINT " ENTER: Value of a standard linear pot greater than R......R1=";
540 INPUT R1
550 IF R1=R THEN R1=R1+R1*10^-6
560 IF R1<R THEN LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:GOTO 530
570 LOCATE CSRLIN-1:PRINT STRING$(8,32)
580 LOCATE CSRLIN-1,63:PRINT USING U1$;R1;:PRINT O$
590 Y=CSRLIN
600 LOCATE 14,62:COLOR 0,7:PRINT "R1":COLOR 7,0
610 LOCATE Y
620 R2=R*R1/(R1-R)         :REM'parallel resistor
630 :REM'
640 :REM'.....display results
650 PRINT "        Parallel resistor for full scale wiper travel......R2=";
660 PRINT USING U1$;R2;:PRINT O$
670 COLOR 0,7
680 Y=CSRLIN
690 LOCATE 14,65:PRINT" R2=";:PRINT USING U3$;R2;:PRINT O$
700 LOCATE Y
710 COLOR 7,0
720 PRINT UL$;
730 :REM'
740 J=1:J$="(Ω)"
750 IF R1>=10^3 THEN J=10^-3:J$=" kΩ "
760 IF R1>=10^6 THEN J=10^-6:J$=" MΩ "
770 LOCATE CSRLIN-1,8:PRINT "╦";
780 LOCATE CSRLIN,15:PRINT "╤";
790 LOCATE CSRLIN,21:PRINT "╤";
800 LOCATE CSRLIN,27:PRINT "╦";
810 LOCATE CSRLIN,54:PRINT "╦"
820 PRINT " Wiper ║";
830 LOCATE ,11:PRINT "R1";
840 LOCATE ,15:PRINT "│  R";
850 PRINT TAB(21);"│Atten║min«──────── R ───────»max║";
860 COLOR 0,7
870 LOCATE CSRLIN,56:PRINT " R1 is a";USING U1$;R1;:PRINT ;O$;"    ";
880 COLOR 7,0
890 PRINT STRING$(53,"═")
900 LOCATE CSRLIN-1,15:PRINT "╧";
910 LOCATE CSRLIN,21:PRINT "╧";
920 LOCATE CSRLIN,27:PRINT "╬";
930 LOCATE CSRLIN,54:PRINT "╣";
940 COLOR 0,7:LOCATE CSRLIN,56:PRINT " lin.taper potentiometer";
950 COLOR 7,0:LOCATE CSRLIN,1:PRINT " Travel╚";
960 LOCATE ,10:PRINT J$;:LOCATE ,17:PRINT J$;:LOCATE ,23:PRINT " dB"
970 :REM'
980 :REM'.....wiper travel
990  FOR Z=1 TO 10
1000   SR(Z)=Z*10                           :REM'% wiper travel
1010  NEXT Z
1020 MAX=R1*R2/(R1+R2)                      :REM'value of R at 100% wiper travel
1030 G=1/((R2/(R/2)-1)/R2)                  :REM'value of R1 at 1/2 R
1040 GG=G/R1*100:SR(11)=GG                  :REM'% wiper travel for R/2
1050 :REM'
1060 :REM'.....calculate rotation & display
1070    FOR Z=1 TO 10
1080 IF Z=10 THEN COLOR 15
1090 PRINT USING "###.#%";SR(Z);  :REM'% wiper travel
1100 COLOR 7,0
1110 C=SR(Z)*R1/100               :REM'value of R1
1120 D=C*R2/(C+R2)                :REM'value of R
1130 Q=(100-SR(Z))/100            :REM'travel conversion
1140 F1=C:F2=Q*D
1150 IF Z=10 THEN 1170
1160 DB=LF*20*LOG(F2/F1)
1170 PRINT USING "####.##";C*J;
1180 IF Z=10 THEN COLOR 15
1190 PRINT USING "####.##";D*J;
1200 IF Z=5 THEN PCT=D/R*R*J
1210 COLOR 7,0
1220 IF Z=10 THEN PRINT "  max.";:GOTO 1250
1230 PRINT USING "####.#";DB;
1240 :REM'
1250 :REM'.....bar chart
1260 B=INT(26*D/R)
1270 BB=26*D/R-B
1280 IF BB>=0.5! THEN BB=219 :ELSE BB=221
1290 LOCATE CSRLIN,27:PRINT "║";
1295 COLOR 4:LOCATE ,26+B:PRINT "*";
1300 :REM'COLOR 4:PRINT STRING$(B,219);CHR$(BB);
1310 COLOR 7,0
1320 LOCATE CSRLIN,54
1330 PRINT "║"
1340    NEXT Z
1350 :REM'
1360 PRINT TAB(28);STRING$(52,205);
1370 LOCATE ,27:PRINT "╚";
1380 LOCATE ,54:PRINT "╩"
1390 PRINT USING "###.#% ###.## ###.##";GG,G*J,R/2*J;
1400 PRINT " = 50.0% of maximum resistance R "
1410 PRINT USING "###.#% ###.## ###.##";50,R1/2*J;PCT;
1420 PCT2=PCT/R/J*100
1430 PRINT USING " = ##.#% of maximum resistance R ";PCT2;
1440 COLOR 0,7:PRINT " *(See Notes) "
1450 :REM'
1460 COLOR 7,0:PRINT UL$;
1470 COLOR 0,7:PRINT " * NOTES:";
1480 COLOR 7,0
1490 PRINT" The resistance curve of the customized potentiometer is not linear."
1500 PRINT " A precision parallel resistor (R2) will be designed for you ";
1510 PRINT "when you continue.";
1520 GOSUB 2310
1530 LOCATE 25,1:PRINT ER$;:LOCATE 25,11
1540 COLOR 15,1
1550 PRINT " Do you want to calculate current through R1 & R2 ?  (y/n) ";
1560 COLOR 7,0
1570 Z$=INKEY$
1580 IF Z$="n"THEN E=-1:GOTO 2280
1590 IF Z$="y"THEN 1620
1600 GOTO 1570
1610 :REM'
1620 :REM'.....calculate current
1630 LOCATE 24,1:PRINT ER$;
1640 LOCATE 25,1:PRINT ER$;
1650 COLOR 0,7
1660 LOCATE 19,1:INPUT " ENTER: Voltage across R ";E
1670 COLOR 7,0
1680 LOCATE 19,1:PRINT STRING$(50,205);
1690 LOCATE ,27:PRINT "╩"
1700 LOCATE 24,2
1710 PRINT "Currents shown above are in ma. for a voltage drop across R of";
1720 COLOR 0,7:PRINT E;"volts ";
1730 COLOR 7,0
1740 LOCATE 7,28:PRINT "   I(R1) + I(R2) =  I(R)  "
1750 :REM'
1760 FOR Z=1 TO 10
1770 LOCATE Z+8,28
1780 C=SR(Z)*R1/100
1790 D=C*R2/(C+R2)
1800 PRINT USING " #####.# #####.# #####.#  ";E/C*10^3,E/R2*10^3,E/D*10^3
1810 NEXT Z
1820 GOTO 2270
1830 :REM'
1840 :REM'.....preface
1850 T=8
1860 PRINT TAB(T);
1870 PRINT "  The custom potentiometer consists of a linear taper potentiometer"
1880 PRINT TAB(T);
1890 PRINT "in parallel with a fixed bridging resistance. When you exit the"
1900 PRINT TAB(T);
1910 PRINT "program the final screen display will show how two standard"
1920 PRINT TAB(T);
1930 PRINT "resistors in parallel can provide a bridging resistor within about"
1940 PRINT TAB(T);
1950 PRINT "1% of the required bridge resistance."
1960 PRINT TAB(T);
1970 PRINT "  The resistance curve of this custom potentiometer is not linear."
1980 PRINT TAB(T);
1990 PRINT "It has a taper approximately as shown in the block graph on the"
2000 PRINT TAB(T);
2010 PRINT "screen display."
2020 PRINT TAB(T);
2030 PRINT "  Choose a standard linear taper potentiometer with a value higher"
2040 PRINT TAB(T);
2050 PRINT "than the custom full scale value you want. The closer the value is"
2060 PRINT TAB(T);
2070 PRINT "to the custom value the more linear will be the resistance curve."
2080 PRINT TAB(T);
2090 PRINT "  If the value of the standard potentiometer is far removed from"
2100 PRINT TAB(T);
2110 PRINT "the specified custom value then part of the custom range will be"
2120 PRINT TAB(T);
2130 PRINT "crowded near one end of the wiper travel."
2140 PRINT TAB(T);
2150 PRINT "  You may want to experiment with ";CHR$(34);"far removed";
2160 PRINT CHR$(34);" audio taper"
2170 PRINT TAB(T);
2180 PRINT "potentiometers. If you get lucky you could end up with a near"
2190 PRINT TAB(T);
2200 PRINT "linear resistance curve even if the rotation may be in the wrong"
2210 PRINT TAB(T);
2220 PRINT "direction. Who cares? If you weren't an experimenter you wouldn't"
2230 PRINT TAB(T);
2240 PRINT "be messing about with this anyway."
2250 RETURN
2260 :REM'
2270 GOSUB 2310
2280 CLS:R=R2
2290 CHAIN"precires"     :REM'precision resistor program
2300 :REM'
2310 :REM'PRT
2320 KEY OFF:GOSUB 2390:LOCATE 25,5:COLOR 0,2
2330 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2340 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2350 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2350 :ELSE GOSUB 2390
2360 IF Z$="3"THEN RETURN
2370 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2380 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2320
2390 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
