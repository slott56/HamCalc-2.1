10 :REM'SHORTDIP - Short Multiband Dipoles - 29 DEC 95 rev. 16 DEC 2001
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="shortdip"
40 COMMON EX$,PROG$,LX      :REM'note:lx=lg
50 CLS:KEY OFF
60 COLOR 7,0,1
70 PI=3.1415929794311523!
80 UL$=STRING$(80,205)
90 U$="###.##"
100 DIM FQ(9,2)
110 :REM'
120 DATA 160,80,40,30,20,17,15,12,10
130 DATA 1.9, 3.75, 7.15,10.125, 14.175, 18.118, 21.225, 24.94, 28.85
140 FOR Z=1 TO 9:READ FQ(Z,1):NEXT Z
150 FOR Z=1 TO 9:READ FQ(Z,2):NEXT Z
160 :REM'
170 :REM'.....start
180 CLS
190 COLOR 15,2
200 PRINT " SHORT MULTIBAND DIPOLE ARRAY";
210 PRINT TAB(57)"by George Murphy VE3ERP ";
220 COLOR 1,0:PRINT STRING$(80,223);
230 COLOR 7,0
240 GOSUB 1390     :REM'diagram
250 PRINT UL$;
260 GOSUB 1650     :REM'page 1
270 PRINT UL$;:LOCATE ,21
280 COLOR 0,7:PRINT " Press 1 to RUN program or 0 to EXIT....";:COLOR 7,0
290 Z$=INKEY$:IF Z$=""THEN 290
300 IF Z$="1"THEN 340
310 IF Z$="0"THEN CLS:RUN EX$
320 GOTO 290
330 :REM'
340 VIEW PRINT 14 TO 24:CLS:VIEW PRINT:LOCATE 14
350 PRINT " Press number in < > to choose standard units of measure:"
360 PRINT UL$;
370 PRINT "   < 1 >  Metric"
380 PRINT "   < 2 >  U.S.A./Imperial"
390 Z$=INKEY$:IF Z$=""THEN 390
400 IF Z$="1"THEN M$=" m.":W$=" φ 2 mm ":UM=0.30480000376701355!:GOTO 440
410 IF Z$="2"THEN M$=" ft":W$=" AWG 12 ":UM=1:GOTO 440
420 GOTO 390
430 :REM'
440 VIEW PRINT 13 TO 24:CLS:VIEW PRINT:LOCATE 13
450 GOSUB 1850  :REM'page 2
460 PRINT UL$;
470 PRINT " ENTER: Available space A (";M$;" ).......";:INPUT LG
480 :REM'
490 VIEW PRINT 13 TO 24:CLS:VIEW PRINT:LOCATE 13
500 GOSUB 2060  :REM'page 3
510 PRINT
520 LOCATE ,11:PRINT " Current values │ A=";LG*UM;"│ A/2=";LG/2*UM;"│ B=";B*UM;
530 PRINT "│";:IF B=0 THEN PCT=0 :ELSE PCT=PC*100
540 COLOR 0,7:PRINT USING " B% of A/2=###.# % ";PCT
550 COLOR 7,0:PRINT
560 INPUT " ENTER: Dimension B as a percentage of A/2......(%)";PC
570 IF PC>=100 THEN PC=99.9000015258789!
580 PC=PC/100
590 GOTO 790
600 VIEW PRINT 13 TO 24:CLS:VIEW PRINT:LOCATE 13
610 PRINT " Press number in < > to:"
620 PRINT UL$;
630 PRINT "   < 1 >  Relocate loading coils"
640 PRINT "   < 2 >  Run Detail Design program"
650 PRINT "   < 3 >  Change overall length A"
660 PRINT
670 PRINT "   < 0 >  EXIT"
680 Z$=INKEY$:IF Z$=""THEN 680
690 IF Z$="3"THEN B=0
700 IF Z$="1"THEN GOSUB 750:GOTO 500
710 IF Z$="2"THEN CLS:LX=LG:CHAIN"shortant"
720 IF Z$="3"THEN GOSUB 750:GOTO 440
730 IF Z$="0"THEN CLS:RUN EX$
740 GOTO 680
750 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOSUB 1390
760 RETURN
770 :REM'
780 VIEW PRINT 13 TO 24:CLS:VIEW PRINT
790 LG=LG/UM
800 B=PC*LG/2           :REM'dimension B
810 COLOR 0,7
820 LOCATE 4,M+26:PRINT " A=";USING U$;LG*UM;:PRINT M$+" "
830 LOCATE 5,M+14:PRINT USING U$;LG/2*UM;:PRINT M$+" "
840 LOCATE 6,M+19:PRINT USING U$;B*UM;:PRINT M$+" "
850 COLOR 7,0:LOCATE 12
860 PRINT STRING$(80,196);
870 LOCATE CSRLIN-1,8:PRINT "┬"
880 LOCATE CSRLIN-1,21:PRINT "┬"
890 LOCATE CSRLIN-1,32:PRINT "┬"
900 LOCATE CSRLIN-1,43:PRINT "┬"
910 LOCATE CSRLIN-1,55:PRINT "┬"
920 :REM'
930 VIEW PRINT 13 TO 24:CLS:VIEW PRINT:LOCATE 13
940 PRINT TAB(8)"│";TAB(21)"│  Dipole";
950 PRINT TAB(32)"│Efficiency│";TAB(46)"Loading";TAB(55)"│";TAB(63)"EFFICIENCY"
960 PRINT TAB(3)"Band │";TAB(13)"MHz";TAB(21)"│  Length";TAB(32)"│Threshold │";
970 PRINT TAB(46)"Coils L";TAB(55)"│ Excellent   Good   Fair"
980 PRINT STRING$(80,196);
990 LOCATE CSRLIN-1,8:PRINT "┴"
1000 LOCATE CSRLIN-1,21:PRINT "┴"
1010 LOCATE CSRLIN-1,32:PRINT "┴"
1020 LOCATE CSRLIN-1,43:PRINT "┴"
1030 LOCATE CSRLIN-1,55:PRINT "┼"
1040 :REM'
1050 :REM'.....calculate & print
1060 FOR Z=1 TO 9
1070 F=FQ(Z,2)
1080 HW=468/F
1090 IF HW<LG THEN L=0:GOTO 1210
1100 DIA=0.0640999972820282!  :REM'#14 AWG wire
1110 SP=300/F*0.656000018119812!          :REM'minimum dimension A
1120  F1=10^6/(68*PI^2*F^2)
1130  F2=LOG(24*(234/F-B)/DIA)-1
1140  F3=(1-F*B/234)^2-1
1150  F4=234/F-B
1160  F5=LOG(24*(LG/2-B)/DIA)-1
1170  F6=((F*LG/2-F*B)/234)^2-1
1180  F7=LG/2-B
1190 L=F1*(F2*F3/F4-F5*F6/F7)
1200 :REM'
1210 PRINT USING "####";FQ(Z,1);:PRINT " m.";    :REM'band
1220 PRINT USING "####.###";F;:PRINT " MHz";     :REM'frequency
1230 IF L>0 THEN PRINT USING "#####.##";LG*UM;:PRINT M$;:GOTO 1260
1240 PRINT USING "#####.##";HW*UM;:PRINT M$;     :REM'1/2 wave
1250 IF L=0 THEN PRINT TAB(37)"-";:GOTO 1270
1260 PRINT USING "#####.##";SP*UM;:PRINT M$;     :REM'A threshold
1270 IF L=0 THEN PRINT TAB(47)"none    │";:GOTO 1290
1280 PRINT USING "#######.#";L;:PRINT " µH │";   :REM'inductance
1290 IF LG<SP THEN COLOR 0,7:LOCATE CSRLIN,76:PRINT "[√]";:GOTO 1340
1300 IF L<>0 THEN 1330
1310 COLOR 0,7:LOCATE CSRLIN,58:PRINT "[√]";
1320 COLOR 7,0:LOCATE CSRLIN,62:PRINT "(½-wave dipole)";:GOTO 1340
1330 COLOR 0,7:LOCATE CSRLIN,69:PRINT "[√]";
1340 COLOR 7,0:IF CSRLIN<24 THEN PRINT ""
1350 NEXT Z
1360 GOTO 2210   :REM'end
1370 END
1380 :REM'
1390 :REM'.....diagram
1400 COLOR 0,7
1410 M=8
1420 LOCATE ,M
1430 PRINT "                                                                 "
1440 LOCATE ,M
1450 PRINT "     │«──────────────────────── A ────────────────────────»│     "
1460 LOCATE ,M
1470 PRINT "     │«───────── A/2 ──────────»│                          │     "
1480 LOCATE ,M
1490 PRINT "     │         │«───── B ──────»│ loading coils L─┐        │     "
1500 LOCATE ,M
1510 PRINT " ─ ─ ∞──────∩∩∩∩───────────────┬∞┬───────────────∩∩∩∩──────∞ ─ ─ "
1520 LOCATE ,M
1530 PRINT " ─ ─ ∞───────∩∩∩───────────────┤ ├───────────────∩∩∩───────∞ - - "
1540 LOCATE ,M
1550 PRINT " ┌─» ─ ─ ∞─────────────────────┤ ├────────────────────-∞ - - - ─ "
1560 LOCATE ,M
1570 PRINT " ├─» ─ - - - ∞─────────────────┤┌┴─────────────────∞ - - - - - - "
1580 LOCATE ,M
1590 PRINT " └─ full size ½ wave dipoles   └╢«── 50 Ω Coaxial cable          "
1600 LOCATE ,M
1610 PRINT "                                                                 "
1620 COLOR 7,0
1630 RETURN
1640 :REM'
1650 :REM'.....page 1
1660 T=7
1670 PRINT TAB(T);
1680 PRINT "A simple and effective multiband antenna array may be made by"
1690 PRINT TAB(T);
1700 PRINT "connecting a number of parallel dipoles a few inches apart to a"
1710 PRINT TAB(T);
1720 PRINT "single low-impedance transmission line at a common feed point. Some"
1730 PRINT TAB(T);
1740 PRINT "or all of these dipoles can be electrically lengthened, and thus"
1750 PRINT TAB(T);
1760 PRINT "mechanically shortened, to fit the space available by installing"
1770 PRINT TAB(T);
1780 PRINT "loading coils in the horizontal legs. Use this program to plan your"
1790 PRINT TAB(T);
1800 PRINT "array, then use the detailed design option from the menu at the end"
1810 PRINT TAB(T);
1820 PRINT "of the program to design each of the inductively loaded dipoles."
1830 RETURN
1840 :REM'
1850 :REM'.....page 2
1860 PRINT TAB(T);
1870 PRINT "  These antennas will perform very well at modest heights when A is"
1880 PRINT TAB(T);
1890 PRINT "longer than 1/5 wavelength for the band of operation. At lengths"
1900 PRINT TAB(T);
1910 PRINT "below this threshold an antenna will still work but its efficiency"
1920 PRINT TAB(T);
1930 PRINT "(rated 'Fair' by this program) begins to approach that of a typical"
1940 PRINT TAB(T);
1950 PRINT "inductively loaded mobile whip antenna."
1960 PRINT TAB(T);
1970 PRINT "  Spacing between individual dipoles is not critical, but should be"
1980 PRINT TAB(T);
1990 PRINT "not less than about twice the diameter of the largest loading coil."
2000 PRINT TAB(T);
2010 PRINT "  Very short antennas for the lower HF bands may require loading"
2020 PRINT TAB(T);
2030 PRINT "coils so large that the antenna may become physically impractical."
2040 RETURN
2050 :REM'
2060 :REM'.....page 3
2070 PRINT TAB(T);
2080 PRINT "The farther the loading coils are from the feed point, the greater"
2090 PRINT TAB(T);
2100 PRINT "the efficiency of the antenna. But as B increases, so does the size"
2110 PRINT TAB(T);
2120 PRINT "of the loading coils. Start with B at about 90% of A/2. If this"
2130 PRINT TAB(T);
2140 PRINT "results in impractically large coils, re-run the program using"
2150 PRINT TAB(T);
2160 PRINT "lesser values of B until an acceptable compromise between maximum B"
2170 PRINT TAB(T);
2180 PRINT "(efficiency) and practical coil values is reached."
2190 RETURN
2200 :REM'
2210 :REM'.....end
2220 GOSUB 2270
2230 VIEW PRINT 12 TO 24:CLS:VIEW PRINT:LOCATE 12:PRINT UL$;
2240 GOTO 600   :REM'menu
2250 END
2260 :REM'
2270 :REM'PRT
2280 KEY OFF:GOSUB 2350:LOCATE 25,5:COLOR 0,2
2290 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2300 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2310 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2310 :ELSE GOSUB 2350
2320 IF Z$="3"THEN RETURN
2330 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2340 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2280
2350 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
