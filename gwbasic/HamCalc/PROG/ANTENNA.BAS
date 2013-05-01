10 :REM'ANTENNA   13 JAN 91 rev. 10 APR 1998
20 CLS:KEY OFF
30 IF EC$=""THEN EX$="exit"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 COLOR 7,0
70 UL$=STRING$(80,205)
80 U$="##,###.###"
90 V$="####.# "
100 W$="#####,###.###"
110 V#=299792458.0#    :REM'speed of light in metres per second
120 :REM'                 based on ISO standards (1992)
130 :REM'
140 COLOR 15,2
150 PRINT " ANTENNA ELEMENT LENGTHS & PRUNING CALCULATOR";
160 PRINT TAB(57);"by George Murphy VE3ERP ";
170 COLOR 1,0:PRINT STRING$(80,223);
180 COLOR 7,0
190 :REM'
200 :REM'.....start
210 PRINT " Press number in < > for:"
220 PRINT UL$;
230 PRINT "    < 1 >  Antenna Length calculator (ARRL standards)"
240 PRINT "    < 2 >  Antenna Pruning calculator"
250 PRINT "    < 3 >  Antenna Lengths & K-Factors (NEC-2 models)"
260 PRINT UL$;
270 PRINT "    < 0 >  EXIT"
280 Z$=INKEY$
290 IF Z$="0"THEN CLS:RUN GO$
300 IF Z$="1"THEN 350
310 IF Z$="2"THEN 1820
320 IF Z$="3"THEN CLS:CHAIN"kfactor"
330 GOTO 280
340 :REM'
350 :REM'.....input frequency
360 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
370 PRINT " Press number in < > to choose standard units of measure:"
380 PRINT UL$;
390 PRINT "    < 1 >  Metric"
400 PRINT "    < 2 >  U.S.A./Imperial"
410 Z$=INKEY$
420 IF Z$="1" THEN UM=0.30480000376701355!:UM$=" metres":GOTO 450
430 IF Z$="2" THEN UM=1:UM$=" feet":GOTO 450
440 GOTO 410
450 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
460 :REM'
470 :REM'.....input data
480 INPUT " ENTER: Frequency in MHz ";F
490 IF F=0 THEN 360
500 :REM'
510 :REM'.....define elements
520 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
530 PRINT " Press number in < > to define antenna elements:"
540 PRINT UL$;
550 PRINT "  <1> WIRE"
560 PRINT "  <2> TUBING"
570 Z$=INKEY$
580 IF Z$="1"THEN E$="Wire":GOTO 620
590 IF Z$="2"THEN E$="Tubing":GOTO 620
600 GOTO 570
610 :REM'
620 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
630 IF E$="Tubing"THEN 660
640 IF E$="Wire"THEN 770
650 :REM'
660 PRINT " Do you want to enter tubing size in (m)illimetres or (i)nches?";
670 PRINT "   (m/i) "
680 PRINT UL$;
690 Z$=INKEY$
700 IF Z$="i"THEN MM=1:MM$="inches":GOTO 730
710 IF Z$="m"THEN MM=25.399999618530273!:MM$="mm.":GOTO 730
720 GOTO 690
730 PRINT " ENTER: Outside diameter of tubing (";MM$;")";:INPUT D:D=D/MM
740 IF D=0 THEN CLS:GOTO 660
750 GOTO 990
760 :REM'
770 PRINT " Press letter in < > to select how you want to enter wire size:"
780 PRINT UL$;
790 PRINT "   < a > Diameter in millimetres"
800 PRINT "   < b > Diameter in inches"
810 PRINT "   < c > Diameter in AWG size"
820 Z$=INKEY$
830 IF Z$="a"THEN MM=25.399999618530273!:MM$="mm":GOTO 880
840 IF Z$="b"THEN MM=1:MM$="inches":GOTO 880
850 IF Z$="c"THEN MM=1:MM$="AWG#":GOTO 880
860 GOTO 820
870 :REM'
880 PRINT UL$;
890 PRINT " ENTER: Wire diameter (";MM$;")";:INPUT N
900 IF Z$="c"THEN GOSUB 930:GOTO 910 :ELSE D=N/MM
910 GOTO 990
920 :REM'
930 :REM'.....convert AWG size to diameter in inches
940 KK=(0.46000000834465027!/0.004999999888241291!)^(1/39)
950 NN=N+3
960 D=0.46000000834465027!/KK^NN
970 RETURN
980 :REM'
990 :REM'.....K factor
1000 J=V#/2/0.30480000376701355!/10^6   :REM'factor for speed of light, in feet, for 1/2 wavelength
1010 REM J=491.7865
1020 WL=J/F              :REM'1/2 wavelength in free space
1030 R=WL*12/D           :REM'ratio of 1/2 wavelength to element diameter
1040 K=0.9100000262260437!
1050 IF R>10 THEN K=0.9200000166893005!
1060 IF R>12 THEN K=0.9300000071525574!
1070 IF R>15 THEN K=0.9399999976158142!
1080 IF R>22 THEN K=0.949999988079071!
1090 IF R>50 THEN K=0.9599999785423279!
1100 IF R>200 THEN K=0.9700000286102295!
1110 IF R>2000 THEN K=0.9800000190734863!
1120 :REM'
1130 :REM'.....antenna length
1140 REM J=491.7865
1150 HW=J*K/F                :REM'half wave flat top in feet
1160 IF(E$="Wire")AND(F<=30)THEN HW=0.949999988079071!*HW/K :REM'end effect correction if F<=30mHz
1170 VA=234/F                :REM'full size vertical
1180 HWL=J*(1-0.05000000074505806!)/F         :REM'half wave long wire
1190 FWL=J*(2-0.05000000074505806!)/F         :REM'full wave long wire
1200 FHL=J*(3-0.05000000074505806!)/F         :REM'3/2 wave long wire
1210 WL2=J*(4-0.05000000074505806!)/F         :REM'two-wave long wire
1220 :REM'
1230 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1240 PRINT " Velocity of light (ISO 1992 standard)....V=";
1250 PRINT USING "########,###.###";V#/10^3;:PRINT " km. per second"
1260 PRINT " Frequency ...............................F=   ";USING W$;F;
1270 Z=CINT(WL*0.30480000376701355!*2)
1280 PRINT " MHz (";Z;"m. band)"
1290 PRINT " 1/2 Wavelength in free space=[ V(km)÷F(kHz)÷2 ]= ";
1300 PRINT USING U$;WL*0.30480000376701355!;
1310 PRINT " m.  (";USING "###.###";WL;:PRINT " ft.)"
1320 PRINT " Minimum recommended height (1/4 wavelength)....= ";
1330 PRINT USING U$;WL*0.30480000376701355!/2;
1340 PRINT " m.  (";USING "###.###";WL/2;:PRINT " ft.)"
1350 PRINT UL$;
1360 AED$=" "+E$+" Antenna Element Data:"
1370 PRINT AED$;
1380 IF MM$="AWG#"THEN PRINT "  ( ";MM$;N;")" :ELSE PRINT ""
1390 PRINT STRING$(LEN(AED$),196)           :REM'underline
1400 IF UM=1 THEN MM=D:MM$=" in." :ELSE MM=D*25.399999618530273!:MM$=" mm."
1410 PRINT" Antenna element diameter.........................";USING U$;MM;
1420 PRINT MM$
1430 PRINT " Ratio of 1/2 wavelength to element diameter......";USING U$;R;
1440 PRINT ":1"
1450 PRINT " Velocity factor of conductor (approximate).....K=";USING U$;K
1460 PRINT UL$;
1470 AEL$=" "+E$+" Antenna Element Lengths:"
1480 PRINT AEL$;TAB(39);"*ALK (Length = ALK ÷ Frequency in MHz)"
1490 PRINT STRING$(30,196);SPC(8);"─────"
1500 :REM'
1510 ALK=F*HW*UM
1520 PRINT " Half-Wave flat top (e.g. dipole)....";USING V$;ALK;
1530 PRINT "......";USING U$;HW*UM;:PRINT UM$
1540 :REM'
1550 ALK=F*VA*UM
1560 PRINT " Quarter-Wave vertical (height)......";USING V$;ALK;
1570 PRINT "......";USING U$;VA*UM;:PRINT UM$
1580 :REM'
1590 PRINT UL$;
1600 :REM'
1610 ALK=F*HWL*UM
1620 PRINT " Half-Wave end fed single wire.......";USING V$;ALK;
1630 PRINT "......";USING U$;HWL*UM;:PRINT UM$
1640 :REM'
1650 ALK=F*FWL*UM
1660 PRINT " Full-Wave end fed single wire.......";USING V$;ALK;
1670 PRINT "......";USING U$;FWL*UM;:PRINT UM$
1680 :REM'
1690 ALK=F*FHL*UM
1700 PRINT " 3/2  Wave end fed single wire.......";USING V$;ALK;
1710 PRINT "......";USING U$;FHL*UM;:PRINT UM$
1720 :REM'
1730 ALK=F*WL2*UM
1740 PRINT " Two-Wave end fed single wire........";USING V$;ALK;
1750 PRINT "......";USING U$;WL2*UM;:PRINT UM$
1760 :REM'
1770 PRINT UL$;
1780 PRINT " *ALK = Antenna Length Constant.";
1790 PRINT " Includes calculated K and end-effect factors.";
1800 GOTO 2190
1810 :REM'
1820 :REM'.....pruning calculator
1830 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1840 GOTO 1900
1850 :REM'.....format input line
1860 U$="####.###":LOCATE CSRLIN-1:PRINT SPC(7);
1870 LOCATE CSRLIN,49:PRINT STRING$(7,".");USING U$;Z;
1880 RETURN
1890 :REM'
1900 PRINT TAB(9);
1910 PRINT "                                   ALK (Antenna Length Constant)"
1920 PRINT TAB(9);
1930 PRINT "Antenna length formula:   Length = ────────────────────────────-"
1940 PRINT TAB(9);
1950 PRINT "                                          Frequency (MHz)"
1960 PRINT
1970 PRINT TAB(9);
1980 PRINT "You may enter antenna length in either metres or feet."
1990 PRINT TAB(9);
2000 PRINT "The calculation results will be in the same units of measurement."
2010 PRINT UL$;
2020 INPUT " ENTER: Design Frequency........................(MHz)";FD
2030 Z=FD:GOSUB 1850:PRINT " MHz"
2040 INPUT " ENTER: Unpruned Antenna Length......................";LU
2050 Z=LU:GOSUB 1850
2060 DLF=FD*LU   :REM'design length factor
2070 PRINT "        Design ALK (Antenna Length Constant)...........";
2080 PRINT USING U$;DLF
2090 INPUT " ENTER: Frequency at which minimum SWR occurs...(MHz)";FA
2100 Z=FA:GOSUB 1850:PRINT " MHz"
2110 ALK=FA*LU   :REM'actual length factor
2120 PL=ALK/FD
2130 PRINT "        Actual ALK for this installation...............";
2140 PRINT USING U$;ALK
2150 PRINT "        Pruned Antenna Length should be................";
2160 PRINT USING U$;PL
2170 GOTO 2190
2180 :REM'
2190 :REM'.....end
2200 GOSUB 2220:CLS:GOTO 50
2210 :REM'
2220 :REM'PRT
2230 KEY OFF:GOSUB 2300:LOCATE 25,5:COLOR 0,2
2240 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2250 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2260 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2260 :ELSE GOSUB 2300
2270 IF Z$="3"THEN RETURN
2280 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2290 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2230
2300 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
