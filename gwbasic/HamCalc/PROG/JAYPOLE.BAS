10 :REM'JAYPOLE - J-Pole End-fed Zepp Antenna - 08 JAN 2000 - rev. 25 AUG 2007
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 PI=4*ATN(1)
70 :REM'
80 :REM'.....title page
90 F=0:ZF=0:ZA=0:Z0=0
100 CLS
110 COLOR 15,2
120 PRINT " J-POLE End-Fed Zepp Antenna"TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 15,1:LOCATE CSRLIN-1,16
150 PRINT " From an original algorithm by Gary O'Neil, N3GO "
160 LOCATE ,16:PRINT "       Communications Quarterly, Fall 1996       "
170 COLOR 7,0
180 GOSUB 1500: :REM'preface
190 :REM'
200 :REM'.....disclaimer
210 :REM'OPEN"I",1,"\hamcalc\docfiles\antenna.doc
220 :REM'IF EOF(1)THEN 240
230 :REM'INPUT#1,NOTE$:PRINT "   ";NOTE$:GOTO 220
240 :REM'CLOSE
250 PRINT UL$;
260 :REM'
270 COLOR 0,7:LOCATE 24,23:PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
280 Z$=INKEY$:IF Z$=""THEN 280
290 IF Z$="1"THEN 330
300 IF Z$="0"THEN CLS:RUN EX$
310 GOTO 280
320 :REM'
330 N=4:VIEW PRINT N TO 24:CLS:VIEW PRINT:LOCATE 4
340 GOSUB 1340        :REM'diagram
350 INPUT " ENTER: Frequency (MHz).....................";F
360 INPUT " ENTER: Feedline Impedance (ohms)...........";ZF
370 COLOR 15,0
380 PRINT "  Typical impedance of a vertical end-fed radiator is in the range";
390 PRINT " of about"
400 PRINT "  3500-5500 Ω. Low horizontal radiators may be 1000 Ω or less. If u";
410 PRINT "nknown,"
420 PRINT "  enter 5000 for vertical, or 1000 for horizontal.":COLOR 7,0
430 INPUT " ENTER: End-Fed Radiator impedance (ohms)...";ZA
440 J=CSRLIN-4:VIEW PRINT J TO 24:CLS:VIEW PRINT:LOCATE J
450 INPUT " ENTER: Series-Section impedance (ohms).....";Z0
460 COLOR 0,7
470 PRINT " Typical velocity factors of popular transmission lines:           "
480 PRINT "  300 Ω TV Twinlead....................... 0.80 ┐ARRL HANDBOOK for "
490 PRINT "  450 Ω TV Window Line.................... 0.91 │Radio Amateurs,   "
500 PRINT "  600 Ω Open Wire Line.................... 0.92 │77th Edition,     "
510 PRINT "  Solid coax (do NOT use foam)....... 0.66-0.85 ┘2000, page 19.2   "
520 COLOR 7,0
530 INPUT " ENTER: Series-Section velocity factor (decimal).. ";VF
540 INPUT " ENTER: Shunt Stub impedance (ohms)............... ";Z0SHNT
550 INPUT " ENTER: Shunt Stub velocity factor (decimal)...... ";VFSHNT
560 CLS:N=1:GOSUB 1350  :REM'diagram
570 :REM'
580 ZMAX=SQR(ZA*ZF)
590 IF Z0<=ZMAX THEN 610 :ELSE 1280
600 :REM'
610 :REM'...ZP (antenna impedance ZA normalized to the stub impedance Z0)
620 ZP=ZA/Z0                                                     :REM'Equation A1
630 :REM'
640 :REM'...RHO (antenna reflection coeff. with respect to matching stub impedance
650 RHO=(ZP-1)/(ZP+1)                                            :REM'Equation A2
660 :REM'
670 :REM'...YF (feedline admittance 1/ZF normalized to stub admittance 1/Z0
680 YF=Z0/ZF                                                     :REM'Equation A3
690 :REM'
700 :REM'...B (normalized susceptance of the shorted stub section)
710 B=SQR((RHO^2*(YF+1)^2-(YF-1)^2)/(1-RHO^2))                   :REM'Equation A4
720 :REM'
730 :REM'...X2 (normalized reactance of the shorted stub section)
740 X2=1/B                                                       :REM'Equation A5
750 :REM'...shunt stub length L2 in degrees
760 :REM'L2=ATN(X2)*180/PI                                        old Equation A6
770 :REM'...re-normalize X2 relative to Z0SHUNT for L2 shorted shunt stub length
780 L2=ATN(X2*Z0/Z0SHNT)*180/PI                              :REM'new Equation A6
790 :REM'
800 R=YF/(YF^2+B^2)                                       :REM'(Real) Equation A7
810 X1=B/(YF^2+B^2)                                       :REM'(Imag) Equation A7
820 L1=90-(ATN(X1)*(180/PI))                                     :REM'Equation A8
830 :REM'
840 :REM'...constant 5606 is 95 percent of the speed of light in
850 :REM'   inches for half a wavelength at 1 MHz.
860 POLE=5606/F                                                  :REM'Equation A9a
870 :REM'...constant 32.78 is the speed of light in inches/degree/MHz
880 SERIES=32.779998779296875!*VF*(L1/F)                                       :REM'Equation A9b
890 :REM'
900 :REM'...shorted shunt stub length SHUNT (inches)
910 :REM'SHUNT=32.78*VF*(L2/F)                                    old Equation A9c
920 SHUNT=32.779998779296875!*VFSHNT*(L2/F)                                :REM'new Equation A9c
930 :REM'
940 COLOR 7,0,0:CLS:GOSUB 1350
950 SL=299.7925109863281!  :REM'constant for speed of light in Mm/sec
960 MC=0.02539999969303608!     :REM'metric conversion factor
970 COLOR 0,2:LOCATE ,9
980 PRINT "( wL denotes no. of wavelengths, ° denotes electrical degrees )"
990 COLOR 7,0
1000 G=SL/F:H=SL/MC/(12*F)
1010 PRINT USING "* Freq.= ####.### MHz ";F;
1020 PRINT TAB(27)USING "Wavelength = ####.### m. ( ###.### ft.)";G,H
1030 GOTO 1120
1040 :REM'
1050 :REM'.....display
1060 PRINT Z$;USING " ####.### in. = ####.### ft. = ####.### m.";Z1,Z2,Z3;
1070 IF Z4=0 THEN PRINT "":GOTO 1100
1080 IF Z4*Z5=0 THEN PRINT USING " (wL = #.###)";Z4:GOTO 1100
1090 PRINT USING " (wL = #.### = ###.###°)";Z4,Z5
1100 RETURN
1110 :REM'
1120 Z$="     A =":Z1=SERIES+SHUNT+POLE:Z2=Z1/12:Z3=Z1*MC:Z4=0:GOSUB 1050
1130 Z$="     B =":Z1=SHUNT:Z2=Z1/12:Z3=Z1*MC:Z4=L2/360:Z5=L2:GOSUB 1050
1140 Z$="     C =":Z1=SERIES:Z2=Z1/12:Z3=Z1*MC:Z4=L1/360:Z5=L1:GOSUB 1050
1150 Z$="   B+C =":Z1=SERIES+SHUNT
1160 Z2=Z1/12:Z3=Z1*MC:Z4=(L1+L2)/360:Z5=L1+L2:GOSUB 1050
1170 Z$="     D =":Z1=POLE:Z2=Z1/12:Z3=Z1*MC:Z4=POLE*MC/G:Z5=0:GOSUB 1050
1180 PRINT USING "* End-fed radiator impedance.......... ####.### Ω";ZA
1190 PRINT USING "* Antenna feedline impedance.......... ####.### Ω";ZF
1200 PRINT USING "* Series-section impedance............ ####.### Ω";Z0
1210 PRINT USING " (Series-section max. useable Zo...... ####.### Ω)";ZMAX
1220 PRINT USING "* Series-section velocity factor...... ####.##";VF
1230 PRINT USING "* Shunt stub impedance................ ####.### Ω";Z0SHNT
1240 PRINT USING "* Shunt stub velocity factor ......... ####.##";VFSHNT;
1250 PRINT SPC(5)"(* = data input by user)";
1260 GOTO 1700
1270 :REM'
1280 :REM'....error trap
1290 BEEP:COLOR 15,4
1300 PRINT"      Matchline must have a Zo less than ";ZMAX;" Ω"
1310 PRINT "      or the feedline a Zo greater than ";Z0^2/ZA;" Ω "
1320 COLOR 7,0
1330 GOTO 1700
1340 :REM'
1350 :REM'.....diagram
1360 COLOR 0,7:T=12:LOCATE N
1370 LOCATE ,T:PRINT "               J-Pole End-Fed Zepp Antenna               "
1380 LOCATE ,T:PRINT "         │«─────────────────── A ─────────────────────»│ "
1390 LOCATE ,T:PRINT "         │«─B─»│«─ C ─»│«───────────── D ─────────────»│ "
1400 LOCATE ,T:PRINT "         │shunt│series │  1/2 wave monopole radiator   │ "
1410 LOCATE ,T:PRINT "         │stub │section│ may be vertical or horizontal │ "
1420 LOCATE ,T:PRINT " ant. »────────┐       │                               │ "
1430 LOCATE ,T:PRINT " system  ┬─────┴───────x                               │ "
1440 LOCATE ,T:PRINT " feed    ┴─────┬───────x───────────────────────────────  "
1450 LOCATE ,T:PRINT " line »────────┘       ├── Matchline can be any type     "
1460 LOCATE ,T:PRINT "         └─ Matchline ─┘   of transmission line(s)       "
1470 COLOR 7,0
1480 RETURN
1490 :REM'
1500 :REM'.....preface
1510 PRINT " The J-Pole is a compact antenna that operates independently of g";
1520 PRINT "round or"
1530 PRINT " radials. It consists of a half-wave vertical or horizontal radia";
1540 PRINT "tor and a"
1550 PRINT " series-section matching line. A shorted shunt stub tunes out res";
1560 PRINT "idual"
1570 PRINT " reactance. This design is valid for wire antennas where D/diamet";
1580 PRINT "er is greater"
1590 PRINT " than about 1000. Pipe and tube construction at 28 MHZ and above ";
1600 PRINT "may require"
1610 PRINT " further pruning."
1620 PRINT "   For related data see the following HAMCALC programs:"";"
1630 PRINT "           Antenna Length & Pruning Calculator"
1640 PRINT "           K-Factor & Antenna Length"
1650 PRINT "           Transmission Line Length"
1660 PRINT "           Transmission Line - Open Wire"
1670 PRINT "           Velocity Factor (see HAMCALC index)"
1680 RETURN
1690 :REM'
1700 :REM'.....end
1710 GOSUB 1730:GOTO 80
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
