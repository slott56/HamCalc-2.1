10 :REM'LOOPXMIT - Loop Antenna Equations - 09 DEC 2002
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 DIM Y(8,12)
80 UL$=STRING$(80,205)
90 :REM'
100 :REM'.....start
110 CLS
120 COLOR 15,2,1
130 PRINT " Small Transmitting Loop Antennas",TAB(57)"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 7,0
160 GOSUB 1980  :REM'introduction
170 PRINT UL$
180 LOCATE CSRLIN-1
190 Z$=INKEY$:IF Z$=""THEN 190
200 IF Z$="0"THEN CLS:CHAIN GO$
210 IF Z$="1"THEN 230
220 GOTO 190
230 PRINT " Want dimensioms in metric or USA units?   (m/u)"
240 Z$= INKEY$:IF Z$=""THEN 240
250 IF Z$="u"THEN D$="in.":DX=2.5399999618530273!:GOTO 290
260 IF Z$="m"THEN D$="cm.":DXM=1  :GOTO 290
270 GOTO 240
280 :REM'
290 :REM'.....data input
300 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
310 F=0:PL=0:L=0:P=0
320 INPUT " ENTER: Frequency in MHz";F:WL=300/F
330 PP=INT(10^4*0.08500000089406967!*WL+0.5!)/10^4
340 IF D$="in."THEN L$="feet":ELSE L$="metres"
350 IF D$="cm."THEN P=PP :ELSE P=PP/0.30480000376701355!
360 COLOR 0,7
370 COLOR 0,7:PRINT " NOTE: The perimeter should be as large as possible but ";
380 PRINT "must be ";
390 PRINT "less than "
400 PRINT INT(P*1000.0!)/1000.0!;L$;" "
410 COLOR 7,0,0:PRINT " ENTER: Perimeter of loop in ";L$;:INPUT PL
420 IF D$="in."THEN PL=PL*0.30480000376701355!
430 IF PL>PP THEN BEEP:GOTO 410
440 PRINT " ENTER: Diameter of conductor (";D$;")";:INPUT L
450 IF D$="in."THEN L=L*2.5399999618530273!
460 INPUT " ENTER: Transmitter power, in watts";P
470 :REM'
480 CLS
490 COLOR 0,7,0:PRINT " Single Turn Loop Transmitting Antennas ";:COLOR 7,0
500 PRINT UL$;
510 R=0.9959999918937683!*10^-6*SQR(F*10^6)/(L/2.5399999618530273!)   :REM'AC resistance in ohms per foot
520 TR=R*PL/0.30480000376701355!      :REM'total AC resistance
530 XL=2*PI*LUH*F      :REM'inductive reactance
540 PRINT USING "Frequency............ ####.### MHz";F
550 PRINT USING "Wavelength........... ####.### m. ";WL
560 PRINT USING "Loop perimeter....... ####.### m.  = ###.### ft.";PL,PL/0.30480000376701355!;
570 COLOR 0,7
580 PRINT USING " = #.### wavelength ";PL/WL;
590 COLOR 7,0
600 PRINT "(max.=.085)"
610 PRINT USING "Conductor diameter... ####.### cm. = ###.### in.";L,L/2.5399999618530273!
620 PRINT USING "AC resistance........ ####.### ohms";TR
630 PRINT USING "Transmitter power.... ####.### watts";P
640 PRINT "Shape of loop.......................";
650 PRINT TAB(39)"TRIANGLE"TAB(51)"SQUARE"TAB(60)"HEXAGON"TAB(70)"OCTAGON"
660 :REM'
670 :REM'.....triangle
680 S=PL/3*100:Y(3,1)=S          :REM'length of side in cm.
690 E1=0.006000000052154064!*S
700 E2=LOG(1.1547000408172607!*S/2^L)
710 E3=0.1348000019788742!*2^L/S
720 LUH=E1*(E2+0.6553300023078918!+E3):Y(3,2)=LUH
730 XL=2*PI*F*LUH:Y(3,3)=XL      :REM'inductance
740 M=S/100:A=M/2*SQR(M^2-(M^2/(2*M))^2):Y(3,4)=A   :REM'area m²
750 RR=3.119999885559082!*10^4*(A/WL^2)^2:Y(3,5)=RR :REM'radiation resistance
760 Q=XL/(2*(RR+TR)):Y(3,6)=Q    :REM'Q
770 EF=RR/(RR+TR)*100:Y(3,7)=EF  :REM'efficiency
780 C=25330.2890625!/F^2/LUH:Y(3,8)=C  :REM'capacitance
790 VC=SQR(P*XL*Q):Y(3,9)=VC     :REM'voltage across capacitor
800 BW=F/Q*10^3:Y(3,10)=BW       :REM'bandwidth in kHz
810 CC=S/0.8659999966621399!/30.479999542236328!:Y(3,11)=CC   :REM'circumscribed circle
820 IL=SQR(P*Q/XL):Y(3,12)=IL    :REM'circulating current
830 :REM'
840 :REM'.....square
850 S=PL/4*100:Y(4,1)=S          :REM'length of side in cm.
860 E1=0.008000001311302185!*S
870 E2=LOG(1.414199948310852!*S/2^L)
880 E3=0.33329999446868896!*2^L/S
890 LUH=E1*(E2+0.3794200122356415!+E3):Y(4,2)=LUH
900 XL=2*PI*F*LUH:Y(4,3)=XL      :REM'inductance
910 A=(S/100)^2:Y(4,4)=A         :REM'area m²
920 RR=3.119999885559082!*10^4*(A/WL^2)^2:Y(4,5)=RR :REM'radiation resistance
930 Q=XL/(2*(RR+TR)):Y(4,6)=Q    :REM'Q
940 EF=RR/(RR+TR)*100:Y(4,7)=EF  :REM'efficiency
950 C=25330.2890625!/F^2/LUH:Y(4,8)=C  :REM'capacitance
960 VC=SQR(P*XL*Q):Y(4,9)=VC     :REM'voltage across capacitor
970 BW=F/Q*10^3:Y(4,10)=BW       :REM'bandwidth in kHz
980 CC=SQR(2*S^2)/30.479999542236328!:Y(4,11)=CC :REM'circumscribed circle
990 IL=SQR(P*Q/XL):Y(4,12)=IL    :REM'circulating current
1000 :REM'
1010 :REM'.....hexagon
1020 S=PL/6*100:Y(6,1)=S          :REM'length of side in cm.
1030 E1=0.012000000104308128!*S
1040 E2=LOG(2*S/2^L)
1050 E3=0.1348000019788742!*2^L/S
1060 LUH=E1*(E2+0.6553300023078918!+E3):Y(6,2)=LUH
1070 XL=2*PI*F*LUH:Y(6,3)=XL      :REM'inductance
1080 A=2.5980000495910645!*(S/100)^2:Y(6,4)=A   :REM'area m²
1090 RR=3.119999885559082!*10^4*(A/WL^2)^2:Y(6,5)=RR :REM'radiation resistance
1100 Q=XL/(2*(RR+TR)):Y(6,6)=Q    :REM'Q
1110 EF=RR/(RR+TR)*100:Y(6,7)=EF  :REM'efficiency
1120 C=25330.2890625!/F^2/LUH:Y(6,8)=C  :REM'capacitance
1130 VC=SQR(P*XL*Q):Y(6,9)=VC     :REM'voltage across capacitor
1140 BW=F/Q*10^3:Y(6,10)=BW       :REM'bandwidth in kHz
1150 CC=2*S/30.479999542236328!:Y(6,11)=CC      :REM'circumscribed circle
1160 IL=SQR(P*Q/XL):Y(6,12)=IL    :REM'circulating current
1170 :REM'
1180 :REM'.....octagon
1190 S=PL/8*100:Y(8,1)=S          :REM'length of side in cm.
1200 E1=0.01600000075995922!*S
1210 E2=LOG(2.61299991607666!*S/2^L)
1220 E3=0.07152999937534332!*2^L/S
1230 LUH=E1*(E2+0.7514299750328064!+E3):Y(8,2)=LUH
1240 XL=2*PI*F*LUH:Y(8,3)=XL      :REM'inductance
1250 A=4.828000068664551!*(S/100)^2:Y(8,4)=A   :REM'area m²
1260 RR=3.119999885559082!*10^4*(A/WL^2)^2:Y(8,5)=RR :REM'radiation resistance
1270 Q=XL/(2*(RR+TR)):Y(8,6)=Q
1280 EF=RR/(RR+TR)*100:Y(8,7)=EF  :REM'efficiency
1290 C=25330.2890625!/F^2/LUH:Y(8,8)=C  :REM'capacitance
1300 VC=SQR(P*XL*Q):Y(8,9)=VC     :REM'voltage across capacitor
1310 BW=F/Q*10^3:Y(8,10)=BW       :REM'bandwidth in kHz
1320 CC=2*S*1.3070000410079956!/30.479999542236328!:Y(8,11)=CC :REM'circumscribed circle
1330 IL=SQR(P*Q/XL):Y(8,12)=IL    :REM'circulating current
1340 :REM'
1350 :REM'.....display
1360 X$="#####.### #####.### #####.### #####.###"
1370 Y$="Length of each side (cm.)........... "+X$
1380 PRINT USING Y$;Y(3,1),Y(4,1),Y(6,1),Y(8,1)
1390 Y$="                    (in.)........... "+X$
1400 PRINT USING Y$;Y(3,1)/2.5399999618530273!,Y(4,1)/2.5399999618530273!,Y(6,1)/2.5399999618530273!,Y(8,1)/2.5399999618530273!
1410 Y$="Dia. of circumscribed circle (ft.).. "+X$
1420 PRINT USING Y$;Y(3,11),Y(4,11),Y(6,11),Y(8,11)
1430 Y$="Area enclosed by loop (metre²)...... "+X$
1440 PRINT USING Y$;Y(3,4),Y(4,4),Y(6,4),Y(8,4)
1450 Y$="Inductance (µH)..................... "+X$
1460 PRINT USING Y$;Y(3,2),Y(4,2),Y(6,2),Y(8,2)
1470 Y$="Inductive reactance (ohms).......... "+X$
1480 PRINT USING Y$;Y(3,3),Y(4,3),Y(6,3),Y(8,3)
1490 Y$="Radiation resistance (ohms)......... "+X$
1500 PRINT USING Y$;Y(3,5),Y(4,5),Y(6,5),Y(8,5)
1510 Y$="Q................................... "+X$
1520 PRINT USING Y$;Y(3,6),Y(4,6),Y(6,6),Y(8,6)
1530 Y$="Capacitance req'd to resonate (pF).. "+X$
1540 PRINT USING Y$;Y(3,8),Y(4,8),Y(6,8),Y(8,8)
1550 Y$="Voltage across capacitor............ "+X$
1560 PRINT USING Y$;Y(3,9),Y(4,9),Y(6,9),Y(8,9)
1570 Y$="Circulating current (amperes)....... "+X$
1580 PRINT USING Y$;Y(3,12),Y(4,12),Y(6,12),Y(8,12)
1590 Y$="Bandwidth (kHz)..................... "+X$
1600 PRINT USING Y$;Y(3,10),Y(4,10),Y(6,10),Y(8,10)
1610 Y$="Efficiency (%)...................... "+X$
1620 PRINT USING Y$;Y(3,7),Y(4,7),Y(6,7),Y(8,7)
1630 COLOR 0,7
1640 :REM'
1650 :REM'.....change values
1660 PRINT " Change (f)requency? (p)erimeter? (c)onductor? (w)atts? ";
1670 PRINT "or (q)uit?  (f/p/c/w/q) ";:COLOR 7,0
1680 Z$=INKEY$:IF Z$=""THEN 1680
1690 IF Z$="f"OR Z$="F"THEN 1750
1700 IF Z$="p"OR Z$="P"THEN 1770
1710 IF Z$="c"OR Z$="C"THEN 1790
1720 IF Z$="w"OR Z$="W"THEN 1800
1730 IF Z$="q"OR Z$="Y"THEN 2280
1740 GOTO 1680
1750 INPUT " ENTER: Frequency in MHz";F:WL=300/F
1760 IF PL>WL*0.08500000089406967! THEN A$="f":GOTO 1830 :ELSE 1960
1770 INPUT " ENTER: Perimeter of loop (in metres)";PL
1780 IF PL>WL*0.08500000089406967! THEN A$="p":GOTO 1830 :ELSE 1960
1790 INPUT " ENTER: Diameter of conductor, in centimetres";L:GOTO 1960
1800 INPUT " ENTER: Transmitter power, in watts";P:GOTO 1960
1810 GOTO 480
1820 :REM'
1830 :REM'.....value out of range
1840 VIEW PRINT 5 TO 24:CLS:VIEW PRINT:LOCATE 6
1850 PRINT "PERIMETER EXCEEDS 0.085 WAVELENGTH!"
1860 IF A$="f"THEN H=300/PL*0.08500000089406967!:GOTO 1890
1870 IF A$="p"THEN H=300*0.08500000089406967!/F:GOTO 1920
1880 GOTO 1860
1890 A$=" ##.### MHz too high for ##.### m. perimeter loop. "
1900 A$=A$+"Try ##.#### MHz or lower"
1910 PRINT USING A$;F,PL,H:GOTO 1750
1920 A$=" ###.### m. too long for ###.### MHz.loop. "
1930 A$=A$+"Try ##.#### m. or less"
1940 PRINT USING A$;PL,F,H:GOTO 1770
1950 IF A$="p"THEN PRINT PL"m. too long. Try a shorter perimeter":GOTO 1770
1960 GOTO 480
1970 :REM'
1980 :REM'.....intro
1990 PRINT "  This program solves the equations for the properties of small t";
2000 PRINT "ransmitting   "
2010 PRINT " single-turn loop antennas (The ARRL Antenna book, pp. 5-2 to 5-1";
2020 PRINT "0).           "
2030 PRINT "  The components in a resonated transmission loop are subject to ";
2040 PRINT "both high     "
2050 PRINT " current and voltages as a result of the large circulating curren";
2060 PRINT "ts found in   "
2070 PRINT " the high-Q tuned circuit formed by the antenna."
2080 PRINT "  An unfortunate consequence of having a small but high efficienc";
2090 PRINT "y transmitting"
2100 PRINT " loop is high Q, and therefore limited bandwidth."
2110 PRINT "  For maximum efficiency the perimeter of the loop and the conduc";
2120 PRINT "tor diameter  "
2130 PRINT " should both be as large as practicable."
2140 PRINT "  The current around the perimeter of the loop must be in phase. ";
2150 PRINT "When the      "
2160 PRINT " perimeter of the loop is more than about 0.085 wavelength, this ";
2170 PRINT "is no longer  "
2180 PRINT " true."
2190 PRINT "  The equations in this program are valid only for small transmit";
2200 PRINT "ting loops    "
2210 PRINT " having a perimeter length of 0.085 wavelength or less.          "
2220 PRINT
2230 PRINT " (Ref.The ARRL Antenna Book, 18th edition, page 5-4)."
2240 PRINT
2250 COLOR 0,7:LOCATE ,23:PRINT " Press 1 to continue or 0 the EXIT ":COLOR 7,0
2260 RETURN
2270 :REM'
2280 :REM'.....end
2290 VIEW PRINT CSRLIN-1 TO 24:CLS:VIEW PRINT
2300 GOSUB 2320:GOTO 100
2310 :REM'
2320 :REM'.....PRT
2330 KEY OFF:GOSUB 2400:LOCATE 25,5:COLOR 0,2
2340 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2350 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2360 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2360 :ELSE GOSUB 2400
2370 IF Z$="3"THEN RETURN
2380 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2390 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2330
2400 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
