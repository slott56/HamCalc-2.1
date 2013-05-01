10 :REM'MINIQUAD - Coil Shortened Quad Antenna - 13 NOV 94 rev. 11 JAN 2006
20 REM The ARRL Antenna Compendium, vol. 2, page 90
30 COMMON U,UH,EX$,PROG$,FQ,W
40 IF EX$=""THEN EX$="EXIT"
50 PROG$="miniquad"
60 CLS:KEY OFF
70 COLOR 7,0,1
80 PI=3.1415929794311523!
90 UL$=STRING$(80,205)
100 U1$="##.##"
110 U2$="###.###"
120 U3$="##.#"
130 :REM'
140 :REM'.....AWG calculator
150 DIM GA(40)      :REM'AWG gauge
160 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)     :REM'increment multiplier
170 FOR Z=1 TO 40
180 N=Z+3
190 GA(Z)=0.46000000834465027!/K^N
200 NEXT Z
210 :REM'
220 :REM'.....start
230 CLS
240 COLOR 15,2
250 PRINT " MINIQUAD - Coil Shortened Quad Antenna";
260 PRINT TAB(52);"by Kris Merschrod KA2OIG/TI2 ";
270 PRINT STRING$(80,32);
280 LOCATE CSRLIN-1,20:PRINT "edited for HAMCALC by George Murphy VE3ERP"
290 COLOR 1,0:PRINT STRING$(80,223);
300 COLOR 7,0
310 :REM'
320 :REM'.....print diagram
330 T=59:COLOR 0,7
340 PRINT "        DIRECTOR       ";  TAB(T);"     REFLECTOR        ";
350 PRINT "   ┌∩∩∩∩─────────∩∩∩∩┐ ";  TAB(T);"┌∩∩∩∩─────────∩∩∩∩┐   ";
360 PRINT "   │ L1           L2 │ ";  TAB(T);"│ L5           L6 │   ";
370 PRINT "   │«────── W ──────»│ ";  TAB(T);"│«──── 1.05W ────»│   ";
380 PRINT "   │                 │ ";  TAB(T);"│                 │   ";
390 PRINT "   │                 H ";  TAB(T);"│               1.05H ";
400 PRINT "   │                 │ ";  TAB(T);"│                 │   ";
410 PRINT "   │                 │ ";  TAB(T);"│                 │   ";
420 PRINT "   └∩∩∩∩───┐ ┌───∩∩∩∩┘ ";  TAB(T);"└∩∩∩∩─────────∩∩∩∩┘   ";
430 PRINT "     L3           L4   ";  TAB(T);"  L7           L8     ";
440 COLOR 7,0
450 FOR X=4 TO 13
460 LOCATE X,26:PRINT STRING$(30,32)
470 NEXT X
480 LOCATE 14:PRINT UL$;
490 :REM'
500 GOSUB 1990  :REM'preface
510 PRINT UL$;
520 COLOR 0,7:LOCATE CSRLIN,22
530 PRINT " Press 1 to continue or 0 to EXIT....."
540 COLOR 7,0
550 Z$=INKEY$:IF Z$=""THEN 550
560 IF Z$="0"THEN CLS:RUN EX$
570 IF Z$="1"THEN 600
580 GOTO 340
590 :REM'
600 :REM'.....unit of measure
610 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 15
620 PRINT " Press number in < > to choose standard units of measure:"
630 PRINT UL$;
640 PRINT "  < 1 >  Metric"
650 PRINT "  < 2 >  U.S.A./Imperial"
660 Z$=INKEY$
670 IF Z$="1"THEN UM=0.30480000376701355!:UM$=" m.":M$="m":GOTO 700
680 IF Z$="2"THEN UM=1:UM$=" ft.":M$="'":GOTO 700
690 GOTO 660
700 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 15
710 :REM'
720 :REM'.....data input
730 PRINT " Width of Quad (";UM$;")......w= ";:INPUT A:A=A/UM
740 COLOR 0,7
750 LOCATE 7,11:PRINT USING U1$;A*UM;:PRINT M$;"─"
760 LOCATE 7,T+6:PRINT USING U1$;(A*1.0499999523162842!)*UM;:PRINT M$;"─"
770 COLOR 7,0
780 GOSUB 1830
790 :REM'
800 PRINT " Height of Quad (";UM$;").....H= ";:INPUT H:H=H/UM
810 TEST=A/(H+A)
820 IF TEST <=0.5! THEN 880
830 PRINT " Height cannot be less than length!"
840 PRINT " Press any key to continue....."
850 IF INKEY$=""THEN 850
860 GOTO 220
870 :REM'
880 COLOR 0,7
890 LOCATE 9,19:PRINT USING U1$;H*UM;:PRINT M$
900 LOCATE 9,T+15:PRINT USING U1$;(H*1.0499999523162842!)*UM;:PRINT M$;" "
910 COLOR 7,0:GOSUB 1830
920 :REM'
930 :REM'.....element diameter
940 LN=CSRLIN
950 PRINT " Press letter in < > to describe size of conductor in sides of quad:"
960 PRINT UL$;
970 PRINT "  < a >  Diameter in millimetres"
980 PRINT "  < b >  Diameter in inches"
990 PRINT "  < c >  AWG#"
1000 Z$=INKEY$
1010 IF Z$="a"OR Z$="A"THEN WS$="mm":GOTO 1050
1020 IF Z$="b"OR Z$="B"THEN WS$="inches":GOTO 1050
1030 IF Z$="c"OR Z$="C"THEN WS$="AWG#":GOTO 1050
1040 GOTO 1000
1050 PRINT " ENTER: Conductor size (";WS$;") ";:INPUT Z
1060 IF WS$="mm"THEN DIA=Z/25.399999618530273!
1070 IF WS$="inches"THEN DIA=Z
1080 IF WS$="AWG#"THEN AWG=Z:DIA=GA(Z)
1090 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 15
1100 :REM'
1110 :REM'.....frequency
1120 INPUT " ENTER: Frequency in MHz ";F
1130 WL=300/F     :REM'wavelength
1140 TEST2=1005/F
1150 SC=4*H/TEST2*100
1160 PRINT USING " Size is about ##% of a full size quad";SC
1170 PRINT " .....press any key....."
1180 Z$=INKEY$:IF Z$=""THEN 1180 :ELSE 1190
1190 IF TEST2>(A*2+H*2)THEN 1240
1200 PRINT " This loop is larger than necessary for";F;"MHz operation."
1210 PRINT " Press any key to begin again....."
1220 IF INKEY$=""THEN 1220
1230 GOTO 220
1240 GOSUB 1830
1250 :REM'
1260 :REM'.....calculate inductance
1270 A1=A
1280 B=A/2
1290 A=A+H
1300 F1=10^6/(68*PI^2*F^2)
1310 F2=LOG(24*((251/F)-B)/DIA)-1
1320 F3=((1-(F*B/251))^2)-1
1330 F4=(251/F)-B
1340 F5=LOG(((24*A/2)-B)/DIA)-1
1350 F6=(((F*A/2)-F*B)/251)^2-1
1360 F7=A/2-B
1370 LMH=F1*((F2*F3/F4)-(F5*F6/F7))
1380 :REM'
1390 :REM'.....screen display
1400 COLOR 7,0,0
1410 LOCATE 2:PRINT UL$;
1420 LOCATE 3:PRINT STRING$(80,32);
1430 LOCATE 4,27:PRINT "ANTENNA:"
1440 LOCATE 5,28:PRINT "Frequency (MHz)....";USING U2$;F
1450 LOCATE 6,28:PRINT "Wavelength (metres)";USING U2$;WL
1460 IF AWG=0 THEN 1480
1470 LOCATE 7,28:PRINT "Conductor (AWG)...#";AWG
1480 M$="mm.":IF UM=1 THEN M$="in."
1490 Y=UM:IF UM<>1 THEN Y=1/25.399999618530273!
1500 LOCATE 8,28:PRINT "Conductor dia.(";M$;")";USING U2$;DIA/Y
1510 LOCATE 9,28:PRINT USING "Size= ##% of full size quad";SC
1520 LOCATE 10,27:PRINT "L1 - L8:"
1530 LOCATE 11,28:PRINT "Inductance (µH)....";USING U2$;LMH
1540 :REM'.....notes
1550 S1=WL*0.11999999731779099!:S2=WL*0.15000000596046448!:S$="metres"            :REM'element spacing
1560 IF UM=1 THEN S1=S1/0.30480000376701355!:S2=S2/0.30480000376701355!:S$="feet"
1570 LOCATE 15
1580 PRINT " Notes:"
1590 PRINT " ══════"
1600 PRINT " 1.  Antenna can be fed directly with 50Ω or 75Ω coaxial cable."
1610 PRINT " 2.  The use of a Transmatch is recommended."
1620 PRINT " 3.  Space director and reflector elements from ";USING"##.#";S1;
1630 PRINT " to ";USING "##.#";S2;:PRINT " ";S$;" apart."
1640 PRINT " 4.  Adjust element spacing for minimum SWR."
1650 PRINT " 5.  Prune vertical sides for minimum SWR.";
1660 PRINT " 6.  Do not alter the coils or prune horizontal sides."
1670 GOSUB 2070   :REM'screen dump
1680 GOSUB 1830   :REM'clear bottom of screen
1690 PRINT " Press number in <> to:"
1700 PRINT UL$;
1710 PRINT "  <1> Design coils for this quad"
1720 PRINT "  <2> Select commercial (B&W) coils for this quad"
1730 PRINT "  <3> Design another quad"
1740 PRINT
1750 PRINT "  <0) EXIT program"
1760 Z$=INKEY$
1770 IF Z$="1"THEN CLS:UH=LMH:FQ=F:W=DIA:CHAIN"coilq"
1780 IF Z$="2"THEN CLS:U=LMH:CHAIN"aircore"
1790 IF Z$="3"THEN 220
1800 IF Z$="0"THEN CLS:RUN EX$
1810 GOTO 1760
1820 :REM'
1830 :REM'.....clear screen
1840 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 15
1850 RETURN
1860 :REM'
1870 :REM'.....preface
1880 TB=7
1890 PRINT TAB(TB);
1900 PRINT "Adapted from a program by D. Sander, CQ magazine, Dec.1981, p.44."
1910 PRINT
1920 PRINT TAB(TB);
1930 PRINT "See THE ARRL ANTENNA COMPENDIUM, Volume 2, page 90, for a detailed"
1940 PRINT TAB(TB);
1950 PRINT "description of this antenna by Kris Merschrod, KA2OIG/TI2."
1960 PRINT UL$;
1970 RETURN
1980 :REM'
1990 :REM'.....preface
2000 TB=7
2010 PRINT TAB(TB);
2020 PRINT "This antenna can be designed to fit the space available, bearing in"
2030 PRINT TAB(TB);
2040 PRINT "mind that the larger it is the more efficient it will be."
2050 RETURN
2060 :REM'
2070 :REM'PRT
2080 KEY OFF:GOSUB 2150:LOCATE 25,5:COLOR 0,2
2090 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2100 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2110 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2110 :ELSE GOSUB 2150
2120 IF Z$="3"THEN RETURN
2130 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2140 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2080
2150 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
