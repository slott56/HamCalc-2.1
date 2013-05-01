10 :REM'ANTIMP - Antenna Impedance - 06 NOV 97 rev. 12 NOV 2003
20 CLS:KEY OFF
30 COLOR 7,0,1
40 IF EX$=""THEN EX$="EXIT"
50 PROG$="antimp"
60 COMMON EX$,PROG$
70 PI=4*ATN(1)
80 :REM'
90 :REM'......start
100 COLOR 15,2
110 PRINT " IMPEDANCE - ANTENNAS";TAB(57)"by George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
130 GOSUB 1360 :REM'preface
140 LOCATE CSRLIN-1
150 GOSUB 1590 :REM'reference
160 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
170 GOTO 240
180 :REM'
190 :REM'.....format
200 A$="####.###"
210 LOCATE LN:PRINT STRING$(8,32);:LOCATE  ,54:PRINT USING A$;Y;
220 RETURN
230 :REM'
240 :REM'.....transmission line
250 INPUT " ENTER: Frequency ......................................(MHz)";F
260 LN=CSRLIN-1:Y=F:GOSUB 190:PRINT " MHz";
270 PRINT USING " (###.### m.)";300/F
280 INPUT " ENTER: Transmission line physical length ...........(metres)";M
290 LN=CSRLIN-1:Y=M:GOSUB 190:PRINT " m.        "
300 INPUT " ENTER: Transmission line decimal velocity factor ...........";V
310 LN=CSRLIN-1:Y=V:GOSUB 190:PRINT "           "
320 L=M/V:THETA=2*PI*L
330 INPUT " ENTER: Transmission line characteristic impedance ....(ohms)";ZO
340 LN=CSRLIN-1:Y=ZO:GOSUB 190:PRINT " Ω         "
350 PRINT "        Transmission line electrical length.................."
360 LN=CSRLIN-1:Y=L:GOSUB 190:PRINT " wavelengths"
370 F=F*10^6
380 PRINT :LN=CSRLIN:LOCATE  ,2
390 PRINT " Antenna impedance can be calculated from:"
400 LOCATE  ,2:COLOR 0,7
410 PRINT " < 1 > Measured resistance and reactance at input end of line "
420 COLOR 7,0
430 PRINT "         (equations courtesy of Bert Weller WD8KBW in the RSGB"
440 PRINT "          publication 'The Antenna Experimenter's Guide', second"
450 PRINT "          edition, p.146)"
460 PRINT "         (additional equations from the Autek RF-1 manual, courtesy"
470 PRINT "          of Paul Ferguson K5ESW via L.B.Cebik W4RNL)."
480 PRINT
490 PRINT "         -or-"
500 PRINT
510 LOCATE  ,2:COLOR 0,7
520 PRINT " < 2 > Measured SWR and impedance at input end of line "
530 COLOR 7,0:PRINT "         (Algorithm by Robert Dehoney IEEE)"
540 PRINT
550 PRINT
560 LOCATE  ,2:COLOR 0,7
570 PRINT " Press 1 or 2 to select your option ";:COLOR 7,0
580 Z$=INKEY$:IF Z$=""THEN 580
590 IF Z$="1"THEN 990
600 IF Z$="2"THEN 640
610 GOTO 580
620 :REM'
630 :REM'.....option<2> calculations
640 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
650 PRINT "  Measured impedance and SWR at input end of line:"
660 INPUT " ENTER: SWR .........................................";SWR
670 LN=CSRLIN-1:Y=SWR:GOSUB 190:PRINT ":1         "
680 ZMIN=ZO/SWR:ZMAX=ZO*SWR
690 LN=CSRLIN
700 I$= " Impedance magnitude should be within range of ### - #### Ω "
710 COLOR 0,7:PRINT USING I$;ZMIN;ZMAX
720 COLOR 7,0
730 INPUT "ENTER: Impedance magnitude..............................(ohms)";ZIN
740 IF ZIN>=ZMIN AND ZIN<=ZMAX THEN 770
750 BEEP:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 700
760 LN=CSRLIN-1:Y=ZIN:GOSUB 190:PRINT " ohms      "
770 LOCATE 11
780 I$="        Impedance magnitude.......................... ###.### Ω"
790 PRINT USING I$;ZIN
800 VIEW PRINT LN+1 TO 24:CLS:VIEW PRINT:LOCATE LN+1
810 ZN=ZIN/ZO :R=(1+ZN^2)*SWR/(SWR^2+1)
820 IF R>ZN THEN X=0 :ELSE X=SQR(ZN^2-R^2) :PRINT :GOSUB 1220 :PRINT
830 INPUT "Enter sign of j (+/-) ",A$ :IF A$="-" THEN X=-X
840 A=R:B=X-TAN(2*PI*L):C=1+X*TAN(2*PI*L):D=-R*TAN(2*PI*L)
850 DENOM=C^2+D^2:RL=(A*C+B*D)/DENOM:XL=(B*C-A*D)/DENOM
860 RIN=RL*ZO:AXIN=XL*ZO
870 IF AXIN<0 THEN S$="-j" :ELSE S$="+j"
880 AXIN=ABS(AXIN) :GOTO 1150
890 :REM'
900 :REM'.....option<1) calculations
910 IF (RL/XL<6 AND RL/XL>0.20000000298023224!)THEN 1070
920 BEEP:COLOR 12:PRINT " Impedance too high or SWR too low for option <1>";
930 PRINT ".....Press any key....then press 2";
940 PRINT " and enter an impedance less than";ZZ;"ohms":COLOR 7,0
950 Z$=INKEY$:IF Z$=""THEN 950
960 VIEW PRINT 9 TO 24:CLS:VIEW PRINT:LOCATE 8
970 GOTO 380
980 :REM'
990 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1000 PRINT " Measured complex impedance at input end of line:"
1010 PRINT
1020 INPUT " ENTER: Resistive part ................................(ohms)";RL
1030 LN=CSRLIN-1:Y=RL:GOSUB 190:PRINT " ohms      "
1040 INPUT " ENTER: Reactive part .................................(ohms)";XL
1050 LN=CSRLIN-1:Y=XL:GOSUB 190:PRINT " ohms      "
1060 :REM'
1070 ANG=-(2*PI*3.3330000981379726e-09!*L*F)
1080 DENOM=(ZO-XL*TAN(ANG))^2+(RL*TAN(ANG))^2
1090 RIN=ZO^2*RL*(1+TAN(ANG)^2) /DENOM
1100 XIN=ZO*(ZO*XL*(1-(TAN(ANG))^2)-(RL^2+XL^2-(ZO^2))*TAN(ANG))/DENOM
1110 IF XIN<0 THEN S$=" -j" :ELSE S$=" +j"
1120 IF SWR<>0 THEN S$=" ±j"
1130 AXIN=ABS(XIN)
1140 :REM'
1150 PRINT
1160 U$="###.##":
1170 PRINT " Impedance at antenna or load ...............";USING U$;RIN;
1180 PRINT S$;:PRINT USING U$;AXIN;:PRINT"  ohms"
1190 PRINT
1200 GOTO 1850
1210 :REM'
1220 PRINT TAB(T)
1230 PRINT "To determine the sign of j: Increase frequency very slightly and"
1240 PRINT TAB(T)
1250 PRINT"watch the impedance reading of your measuring device. If z decreases"
1260 PRINT TAB(T)
1270 PRINT "when frequency increases then j is negative (capacitive). If Z"
1280 PRINT TAB(T)
1290 PRINT "increases then j is positive (inductive). If you have a high Q load"
1300 PRINT TAB(T)
1310 PRINT "do not change frequency. Instead find the sign of j by inserting a"
1320 PRINT TAB(T)
1330 PRINT "short length of cable. If the value of Z increases, ";
1340 PRINT "then X is positive.";
1350 RETURN
1360 :REM'
1370 :REM'.....preface
1380 T=6
1390 PRINT TAB(T);
1400 PRINT"This program computes the impedance of an antenna or load at the far"
1410 PRINT TAB(T);
1420 PRINT "end of a transmission line from measurements taken at the near end."
1430 PRINT TAB(T);
1440 PRINT "Measurements may be made with a commercial instrument such as the"
1450 PRINT TAB(T);
1460 PRINT "Autek RF-1, or a homebrew device such as described in the HAMCALC"
1470 PRINT TAB(T);
1480 PRINT CHR$(34);"Impedance Bridge (3-meter)";CHR$(34);" program."
1490 PRINT
1500 PRINT TAB(T);
1510 PRINT "The program assumes a low loss type of transmission line.";
1520 PRINT:COLOR 0,7:LOCATE  ,24
1530 PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
1540 Z$=INKEY$:IF Z$=""THEN 1540
1550 IF Z$="0"THEN CLS:CHAIN EX$
1560 IF Z$="1"THEN RETURN
1570 GOTO 1540
1580 :REM'
1590 :REM'.....reference
1600 PRINT TAB(T);
1610 PRINT " You will be asked to enter the velocity factor and characteristic"
1620 PRINT TAB(T);
1630 PRINT "impedance of the transmission line, and its length in metres."
1640 PRINT TAB(T);
1650 PRINT " The main reference source for this program is `The Antenna Experi-"
1660 PRINT TAB(T);
1670 PRINT "menter's Guide, second edition, by Peter Dodd, G3LDO, using the"
1680 PRINT TAB(T);
1690 PRINT "equations shown on page 146."
1700 PRINT:COLOR 0,7):LOCATE ,7
1710 PRINT " To continue....................................... press (0)"
1720 COLOR 7,0
1730 PRINT "        - or-"
1740 PRINT "        For coaxial cable characteristcs................. press (1)"
1750 PRINT "        For open-wire transmission line characteristics.. press (2)"
1760 PRINT "        For SWR calculator............................... press (3)"
1770 COLOR 7,0
1780 Z$=INKEY$:IF Z$=""THEN 1780
1790 IF Z$="0"THEN 160
1800 IF Z$="1"THEN CLS:CHAIN"coaxchar"
1810 IF Z$="2"THEN CLS:CHAIN"openwire"
1820 IF Z$="3"THEN CLS:CHAIN"swr"
1830 GOTO 1780
1840 :REM'
1850 :REM'.....end
1860 GOSUB 1900
1870 COLOR 7,0:CLS:SWR=0:GOTO 100
1880 END
1890 :REM'
1900 :REM'PRT
1910 KEY OFF:GOSUB 1980:LOCATE 25,5:COLOR 0,2
1920 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1930 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1940 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1940 :ELSE GOSUB 1980
1950 IF Z$="3"THEN RETURN
1960 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1970 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1910
1980 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
