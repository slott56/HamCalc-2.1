10 :REM'ANTIMP - Antenna Impedance - 06 NOV 97 rev. 29 OCT 2003
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
130 GOSUB 1320 :REM'preface
140 LOCATE CSRLIN-1
150 GOSUB 1520 :REM'reference
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
320 L=M*V:THETA=2*PI*L
330 INPUT " ENTER: Transmission line characteristic impedance ....(ohms)";ZO
340 LN=CSRLIN-1:Y=ZO:GOSUB 190:PRINT " Ω         "
350 PRINT "        Transmission line electrical length.................."
360 LN=CSRLIN-1:Y=L:GOSUB 190:PRINT " m.         "
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
530 PRINT
540 PRINT
550 LOCATE  ,2:COLOR 0,7
560 PRINT " Press 1 or 2 to select your option ";:COLOR 7,0
570 Z$=INKEY$:IF Z$=""THEN 570
580 IF Z$="1"THEN 990
590 IF Z$="2"THEN 630
600 GOTO 570
610 :REM'
620 :REM'.....option<2> calculations
630 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
640 PRINT "  Measured impedance and SWR at input end of line:"
650 INPUT " ENTER: SWR .........................................";SWR
660 LN=CSRLIN-1:Y=SWR:GOSUB 190:PRINT ":1         "
670 RC=(SWR-1)/(SWR+1)
680 ZMIN=ZO/SWR:ZMAX=ZO*SWR
690 LN=CSRLIN
700 I$= "ENTER: Impedance (ohms) within range of ### - ### Ω "
710 PRINT USING I$;ZMIN;ZMAX:LOCATE CSRLIN-1,52:INPUT ZIN
720 IF ZIN>=ZMIN AND ZIN<=ZMAX THEN 750
730 BEEP:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 710
740 LN=CSRLIN-1:Y=ZIN:GOSUB 190:PRINT " ohms      "
750 LOCATE 11
760 PRINT USING "        Impedance.................................... ### Ω";ZIN
770 VIEW PRINT LN+1 TO 24:CLS:VIEW PRINT:LOCATE LN+1
780 FOR ANG=0 TO 180 STEP 0.009999999776482582!:A=ANG*PI/180
790 ZMIN=ZO/SWR:ZMAX=ZO*SWR
800 K1=1-2*RC*COS(A)+RC^2
810 R=(1-RC^2)/K1:X=2*RC*SIN(A)/K1
820 Z=ZO*SQR(R^2+X^2)
830 :REM'IF Z/ZIN<1.005 AND Z/ZIN>.995 THEN PRINT "Rin="R*ZO" Xin=±j"X*ZO:GOTO 830
840 NEXT ANG
850 A=R:B=X-TAN(2*PI*L):C=1+X*TAN(2*PI*L):D=-R*TAN(2*PI*L)
860 DENOM=C^2+D^2:RL=(A*C+B*D)/DENOM:XL=(B*C-A*D)/DENOM
870 RIN=RL*ZO:AXIN=XL*ZO
880 S$=" ±j":GOTO 1150
890 :REM'
900 :REM'.....option<1) calculations
910 IF (RL/XL<6 AND RL/XL>0.20000000298023224!)THEN 1070
920 BEEP:COLOR 12:PRINT " Impedance too high or SWR too low for option <2>";
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
1200  IF S$<>" ±j" THEN 1980
1210 :REM'GOSUB 1710
1220 :REM'
1230 PRINT TAB(T)
1240 PRINT "To determine the sign of j: Increase frequency very slightly and"
1250 PRINT TAB(T)
1260 PRINT"watch the impedance reading of your measuring device. If z decreases"
1270 PRINT TAB(T)
1280 PRINT "when frequency increases then j is negative (capacitive). If Z"
1290 PRINT TAB(T)
1300 PRINT "increases then j is positive (inductive).";
1310 GOTO 1980
1320 :REM'
1330 :REM'.....preface
1340 T=6
1350 PRINT TAB(T);
1360 PRINT"This program computes the impedance of an antenna or load at the far"
1370 PRINT TAB(T);
1380 PRINT "end of a transmission line from measurements taken at the near end."
1390 PRINT TAB(T);
1400 PRINT "Measurements may be made with a commercial instrument such as the"
1410 PRINT TAB(T);
1420 PRINT "Autek RF-1, or a homebrew device such as described in the HAMCALC"
1430 PRINT TAB(T);
1440 PRINT CHR$(34);"Impedance Bridge (3-meter)";CHR$(34);" program.";
1450 PRINT:COLOR 0,7:LOCATE  ,24
1460 PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
1470 Z$=INKEY$:IF Z$=""THEN 1470
1480 IF Z$="0"THEN CLS:CHAIN EX$
1490 IF Z$="1"THEN RETURN
1500 GOTO 1470
1510 :REM'
1520 :REM'.....reference
1530 PRINT TAB(T);
1540 PRINT " You will be asked to enter the velocity factor and characteristic"
1550 PRINT TAB(T);
1560 PRINT "impedance of the transmission line, and its length in metres."
1570 PRINT TAB(T);
1580 PRINT " The main reference source for this program is `The Antenna Experi-"
1590 PRINT TAB(T);
1600 PRINT "menter's Guide, second edition, by Peter Dodd, G3LDO, using the"
1610 PRINT TAB(T);
1620 PRINT "equations shown on page 146. The equations include a factor L,"
1630 PRINT TAB(T);
1640 PRINT "which the author erroneously defines as the electrical length of"
1650 PRINT TAB(T);
1660 PRINT "the feeder, but L is actually the product of the physical length of"
1670 PRINT TAB(T);
1680 PRINT "the feeder, multiplied by its velocity factor. This HAMCALC"
1690 PRINT TAB(T);
1700 PRINT "version of the equations computes the correct value of L and the"
1710 PRINT TAB(T);
1720 PRINT "actual electrical length of the feeder."
1730 PRINT:COLOR 0,7):LOCATE ,7
1740 PRINT " To continue....................................... press (0)"
1750 COLOR 7,0
1760 PRINT "        - or-"
1770 PRINT "        For coaxial cable characteristcs................. press (1)"
1780 PRINT "        For open-wire transmission line characteristics.. press (2)"
1790 PRINT "        For SWR calculator............................... press (3)"
1800 COLOR 7,0
1810 Z$=INKEY$:IF Z$=""THEN 1810
1820 IF Z$="0"THEN 160
1830 IF Z$="1"THEN CLS:CHAIN"coaxchar"
1840 IF Z$="2"THEN CLS:CHAIN"openwire"
1850 IF Z$="3"THEN CLS:CHAIN"swr"
1860 GOTO 1810
1870 :REM'
1880 :REM'.....error condition
1890 :REM'FOR Q=SWR TO 6 STEP (6-SWR)/5
1900 SW=Q
1910 PRINT USING "if SWR= #.##:1 then:";Q;
1920 :REM'RL=(2500+ZZ^2)*SW/(ZO*(SW^2+1)) :PRINT USING "    R= #####.## Ω";RL;
1930 :REM'PRINT USING "   X= ####.## Ω";XL;
1940 :REM'PRINT USING "    R/X= #.####";RL/XL
1950 :REM'NEXT Q
1960 :REM'RETURN
1970 :REM'
1980 :REM'.....end
1990 GOSUB 2030
2000 COLOR 7,0:CLS:SWR=0:GOTO 100
2010 END
2020 :REM'
2030 :REM'PRT
2040 KEY OFF:GOSUB 2110:LOCATE 25,5:COLOR 0,2
2050 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2060 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2070 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2070 :ELSE GOSUB 2110
2080 IF Z$="3"THEN RETURN
2090 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2100 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2040
2110 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
