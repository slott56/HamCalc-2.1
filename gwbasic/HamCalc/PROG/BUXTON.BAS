10 :REM'\hamcalc\prog\BUXTRAP Coax Cable Super Traps - Double Layer - 12 OCT 01
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$
50 COLOR 7,0,1
60 PI=4*ATN(1)  :REM'3.141593
70 UL$=STRING$(80,205)
80 RG$="RG-58U"   :REM'coax type
90 DC=0.11599999666213989!        :REM'diameter of coax core, in inches
100 C=7.099999904632568!          :REM'capacity between the two windings (pF/ft)
110 :REM'
120 :REM'.....title page
130 CLS
140 COLOR 15,2
150 PRINT " COAXIAL CABLE SUPER TRAP (High Reactance)";
160 PRINT TAB(57)"by George Murphy VE3ERP ";
170 COLOR 1,0:PRINT STRING$(80,223);
180 COLOR 15,2:LOCATE CSRLIN-1,25
190 PRINT " Algorithm by Al Buxton W8NX "
200 COLOR 7,0
210 :REM'
220 :REM'.....start
230 LOCATE 4
240 GOSUB 1010   :REM'preface
250 PRINT UL$;
260 GOSUB 1320  :REM'diagram
270 PRINT UL$;
280 COLOR 0,7:LOCATE ,23
290 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="0"THEN CLS:CHAIN EX$
320 IF Z$="1"THEN 350
330 GOTO 300
340 :REM'
350 CLS
360 PRINT
370 GOSUB 1630  :REM'diagram 2
380 PRINT
390 GOSUB 1130  :REM'coil form sizes
400 GOSUB 1790
410 COLOR 0,7:LOCATE 23
420 LOCATE ,Q:INPUT " ENTER: Desired trap resonant frequency (MHz)     ";FT
430 LOCATE ,Q:INPUT " ENTER: Diameter of coil form (inches)............";DF
440 COLOR 7,0
450 N1=5
460    FOR I=1 TO 50   :REM'iteration loop
470 D1=DF+DC
480 D2=D1+DC*3^0.5!
490 N2=N1-0.949999988079071!
500 L1=N1^2*D1^2/4/(4.5!*D1+10*N1*DC)
510 L2=N2^2*D2^2/4/(4.5!*D2+10*N2*DC)
520 KM=(D1/D2)^2*N2/N1
530 LT=L1+L2+2*KM*SQR(L1*L2)
540 CT=PI*D2*(N2-0.05000000074505806!)/12*C/4+0.20999999344348907!*D2
550 F=1000/2/PI/SQR(LT*CT)
560 N1=N1*F/FT
570    NEXT I
580 :REM'
590 :REM'.....screen display
600 CLS:PRINT TAB(27)"COAXIAL CABLE SUPER TRAPS"
610 PRINT TAB(27)"designed by Al Buxton W8NX"
620 PRINT UL$;
630 Z$=" Trap resonant frequency................................. ###.### MHz"
640 Z=F:PRINT USING Z$;Z
650 Z$=" Number of turns - inner winding......................... ###.#"
660 Z=N1:PRINT USING Z$;Z
670 Z$=" Number of turns - outer winding......................... ###.#"
680 Z=N2:PRINT USING Z$;Z
690 Z$=" Mutual inductance coupling coefficient between layers... ###.#"
700 Z=KM:PRINT USING Z$;Z
710 PRINT " Source of coax core.....................................     ";RG$
720 Z$=" Diameter of coax core (O.D. of dielectric insulation)... ###.### in."
730 Z=DC:PRINT USING Z$+"=###.#  mm";Z,Z*25.399999618530273!
740 Z$=" Total length of coax core per trap...................... ###.### ft."
750 Z=PI*(N1*(D1+DC)+N2*(D2+DC))/12+0.75!:PRINT USING Z$+"=###.## m";Z,Z*0.30480000376701355!
760 Z$=" Length of inner winding............................. A = ###.### in."
770 Z=N1*DC:PRINT USING Z$+"=###.## cm";Z,Z*2.5399999618530273!
780 Z$=" Diameter of coil form................................... ###.### in."
790 Z=DF:PRINT USING Z$+"=###.## cm";Z,Z*2.5399999618530273!
800 Z$=" Approximate coil length/diameter ratio.................. ###.##:1"
810 Z=(N1*DC)/(DF+DC):PRINT USING Z$;Z
820 Z$=" Capacitance between winding layers...................... ###.# pF "
830 Z=C:PRINT USING Z$;Z;:PRINT "per foot of"
840 PRINT TAB(66)"outer winding"
850 Z$=" Total trap inductance................................... ###.### µH"
860 Z=LT:PRINT USING Z$;Z
870 Z$=" Total trap capacitance.................................. ###.### pF"
880 Z=CT:PRINT USING Z$;Z
890 COLOR 14,0
900 Z$=" Trap characteristic reactance.......................... #### Ω"
910 Z=1000*SQR(LT/CT):PRINT USING Z$;Z
920 PRINT
930 PRINT " Note: Reactance of this design can be up to four times greater t";
940 PRINT "han that     "
950 PRINT " provided by conventional coax-cable traps."
960 COLOR 7,0
970 PRINT UL$;
980 LOCATE 23,23:PRINT "(program suggested by Ed Snow W2UN)"
990 GOTO 1760
1000 :REM'
1010 :REM'.....preface
1020 PRINT " This trap consists of a short length of PVC plastic pipe close-wo";
1030 PRINT "und with a   "
1040 PRINT " double layer of RG-58U coaxial cable stripped of its outer jacket";
1050 PRINT ". The outer  "
1060 PRINT " winding has one less turn than the inner winding, with each turn ";
1070 PRINT "nested in the"
1080 PRINT " gully between turns of the inner winding. (ref. QST, July 1992, p";
1090 PRINT "age 35 and   "
1100 PRINT " the ARRL 2000 Handbook for Radio Amateurs, page 20.13)."
1110 RETURN
1120 :REM'
1130 COLOR 7,0
1140 PRINT " For maximum Q the length/diameter ratio of the coil should be clo";
1150 PRINT "se to 0.5:1."
1160 PRINT " To achieve an acceptable l/d ratio, select a coil form diameter u";
1170 PRINT "sing the    "
1180 PRINT " following guidelines for PVC pipe:"
1190 Q=15
1200 PRINT TAB(Q)" Band    MHz   ANSII Pipe size       Actual O.D."
1210 PRINT TAB(Q)" 80 m    3.5       3  in.        3.500 in. ( 226mm )"
1220 PRINT TAB(Q)" 40 m    7.0       2  in.        2.375 in. ( 153mm )"
1230 PRINT TAB(Q)" 30 m   10.0       1½ in.        1.900 in. ( 123mm )"
1240 PRINT TAB(Q)" 20 m   14.0       1½ in.        1.900 in. ( 123mm )"
1250 PRINT TAB(Q)" 17 m   18.0       1¼ in.        1.660 in. ( 107mm )"
1260 PRINT TAB(Q)" 15 m   21.0       1¼ in.        1.660 in. ( 107mm )"
1270 PRINT TAB(Q)" 12 m   24.9       1  in.        1.315 in. (  85mm )"
1280 PRINT TAB(Q)" 10 m   28.0       1  in.        1.315 in. (  85mm )"
1290 PRINT TAB(Q)"  6 m   50.0       3/4in.        1.050 in. (  27mm )"
1300 RETURN
1310 :REM'
1320 :REM'.....diagram
1330 COLOR 0,7:Q=9
1340 LOCATE ,Q:PRINT "    (x = antenna attachment holes)     "
1350 LOCATE ,Q:PRINT "            │«─── A ───»│              "
1360 LOCATE ,Q:PRINT "          ┌─╥╫╥╫╥╫╥╫╥╫╥───┐            "
1370 LOCATE ,Q:PRINT "         ╔╡1╝║║║║║║║║║║╔4 ╞╗           "
1380 LOCATE ,Q:PRINT " antenna─╨┼x ║║║║║║║║║║║ x┼╨─ antenna  "
1390 LOCATE ,Q:PRINT "          │ 3╚║║║║║║║║║║╗2│«─coil form "
1400 LOCATE ,Q:PRINT "          └───╨╫╨╫╨╫╨╫╨╫╨─┘            "
1410 LOCATE ,Q:PRINT " inner winding┘        └ outer winding "
1420 :REM'
1430 Q=50:LOCATE 10
1440 LOCATE ,Q:PRINT "     HOLE PATTERN     "
1450 LOCATE ,Q:PRINT "    │«──── A ───»│    "
1460 LOCATE ,Q:PRINT "  ┌─┼────────────┼─┐  "
1470 LOCATE ,Q:PRINT "  │ o 1        4 o │  "
1480 LOCATE ,Q:PRINT "  │ o x        x o │  "
1490 LOCATE ,Q:PRINT "  │ o 3        2 o │  "
1500 LOCATE ,Q:PRINT "  └───┬────────────┘  "
1510 LOCATE ,Q:PRINT "      └ coil form     "
1520 COLOR 7,0
1530 PRINT " Remove outer jacket and shield from a length if RG-58U coaxial ca";
1540 PRINT "ble. Feed   "
1550 PRINT " remaining core into start end of form up through hole #1. Close-w";
1560 PRINT "ind inner   "
1570 PRINT " layer to and down through hole #2. Run core inside form directly ";
1580 PRINT "to and up   "
1590 PRINT " through hole #3. Close-wind outer layer to and down through hole ";
1600 PRINT "#4 and out. "
1610 RETURN
1620 :REM'
1630 :REM'.....diagram 2
1640 COLOR 0,7:Q=13
1650 LOCATE ,Q:PRINT "               ┌─┬─┬─┬─┬─┬───┐ Wind inner layer and apply"
1660 LOCATE ,Q:PRINT " hot-melt glue─┼»╪═╪═╪═╪═╪   │ a minimum of 4 strips of  "
1670 LOCATE ,Q:PRINT " inner winding─┼»│ │ │ │ │   │ hot-melt glue equispaced  "
1680 LOCATE ,Q:PRINT "        start──┤1┘ ╪═╪═╪═╪   │ around form, to inhibit   "
1690 LOCATE ,Q:PRINT "   coil form──»│   │ │ │ │ ┐2│ spreading of inner layer  "
1700 LOCATE ,Q:PRINT "               │   ╪═╪═╪═╪═╪ │ turns as outer layer is   "
1710 LOCATE ,Q:PRINT "               └───┴─┴─┴─┴─┴─┘ being wound.              "
1720 LOCATE ,Q:PRINT "   Weatherproof trap by wrapping with electrical tape.   "
1730 COLOR 7,0
1740 RETURN
1750 :REM'
1760 :REM'.....end
1770 GOSUB 1790:GOTO 120
1780 :REM'
1790 :REM'.....PRT
1800 GOSUB 1860:LOCATE 25,18:COLOR 0,2
1810 PRINT " Press #»▌1=Print▌2=Print/Form Feed▌3=Continue";:COLOR 7,0
1820 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1820 :ELSE GOSUB 1860
1830 IF Z$="3"THEN RETURN
1840 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1850 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1800
1860 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
