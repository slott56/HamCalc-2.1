10 :REM'DISCONE - Discone Multiband Antenna - 03 NOV 96 rev. 30 JUL 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 F$="#####.###"
60 U$="#####.#"
70 V$="=####.##"
80 X$=STRING$(80,32)
90 PI=3.1415929794311523!
100 :REM'
110 :REM'.....start
120 CLS
130 COLOR 15,2
140 PRINT " DISCONE MULTIBAND ANTENNA";TAB(57);"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 Y=3:GOSUB 1120
180 GOSUB 1430
190 COLOR 0,7:LOCATE 25,22
200 PRINT " Press 1 to continue or 0 to EXIT....";:COLOR 7,0
210 Z$=INKEY$:IF Z$=""THEN 210
220 IF Z$="0"THEN CLS:RUN EX$
230 IF Z$="1"THEN 250
240 GOTO 210
250 CLS:Y=1:GOSUB 1120  :REM'diagram
260 :REM'
270 :REM'.....input data
280 INPUT " ENTER: Lowest frequency of multi-band operation (MHz)...";FQ
290 WL=299.7900085449219!/FQ   :REM'wavelength in metres
300 LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1
310 :REM'
320 PRINT " Lowest frequency of operation.....................Fq=";USING F$;FQ;
330 PRINT " MHz (";USING "###.##";WL;:PRINT " m.)";
340 CMAX=WL/4*10^3/25.399999618530273!    :REM'inches
350 A=CMAX
360 :REM'
370 PRINT " Dia. of cone lower rim (¼ free-space wavelength)...A=";
380 X=A:GOSUB 1070
390 LS=CMAX   :REM'optimum length of sloped side @ 60°
400 CMINOPT=LS/22:Z=CMINOPT
410 COLOR 0,7
420 :REM'
430 :REM'.....number of cone radials
440 LN=CSRLIN
450 NN=INT(A*0.02539999969303608!*PI/(0.019999999552965164!*WL))+1
460 COLOR 7,0:LOCATE 12,34:PRINT "Minimum number of cone radials =";NN
470 LOCATE LN
480 :REM'
490 COLOR 0,7
500 PRINT " Maximum diameter B at top of cone is";Z*2.5399999618530273!;"cm. (";Z;"in.)"
510 COLOR 7,0
520 LN=CSRLIN-1
530 :REM'
540 PRINT " Do you want dimension B in (c)entimetres or (i)nches?   (c/i)"
550 Z$=INKEY$:IF Z$=""THEN 550
560 IF Z$="i"THEN Y$="in.":Y=1:GOTO 590
570 IF Z$="c"THEN Y$="cm.":Y=2.5399999618530273!:GOTO 590
580 GOTO 550
590 LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1
600 :REM'
610 PRINT " ENTER: Diameter B at cone upper rim...............(";Y$;")";
620 INPUT Z:CMIN=Z/Y
630 IF CMIN>0 AND CMIN<=CMINOPT THEN 650
640 BEEP:GOTO 590
650 B=CMIN
660 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
670 :REM'
680 PRINT " Dia. of cone upper rim.............................B=";
690 X=B:GOSUB 1070
700 C=LS
710 :REM'
720 PRINT " Length of sloped skirt (¼ free-space wavelength)...C=";
730 X=C:GOSUB 1070
740 IF B=0 THEN 790
750 R=C/B
760 :REM'
770 PRINT " Ratio of cone skirt length to upper diameter.....C/B=";
780 PRINT USING "#####.#";R;:PRINT ":1"
790 D=SQR(C^2-((A-B)/2)^2)
800 :REM'
810 PRINT " Height of cone.....................................D=";
820 X=D:GOSUB 1070
830 ER=ATN(((A-B)/2)/D) :REM'angle in radians
840 E=ER*180/PI         :REM'angle in degrees
850 :REM'
860 PRINT " Flare angle (this angle is not critical)...........E=";
870 PRINT USING U$;E;:PRINT "°"
880 F=0.30000001192092896!*B
890 :REM'
900 PRINT " Disc-to-cone spacing...............................F=";
910 X=F:GOSUB 1070
920 G=0.699999988079071!*A
930 :REM'
940 PRINT " Disc diameter......................................G=";
950 X=G:GOSUB 1070
960 H=D+F
970 :REM'
980 PRINT " Overall height.....................................H=";
990 X=H:GOSUB 1070
1000 FC=299.7900085449219!/0.30480000376701355!*12*0.9599999785423279!/4/C       :REM'.96=velocity factor of apron material
1010 :REM'
1020 PRINT " Cutoff frequency (approximate)....................Fc=";USING F$;FC;
1030 PRINT " MHz";
1040 :REM'
1050 GOSUB 1620:GOTO 110
1060 :REM'
1070 :REM'.....print dimension
1080 IF X<100 THEN J=X:J$=" in.":ELSE J=X/12:J$=" ft."
1090 PRINT USING U$;X*2.5399999618530273!;:PRINT " cm.";USING V$;J;:PRINT J$
1100 RETURN
1110 :REM'
1120 :REM'.....diagram
1130 COLOR 7,0
1140 LOCATE Y:X=34
1150 LOCATE ,X:PRINT "DISCONE MULTIBAND ANTENNA"
1160 LOCATE ,X:PRINT STRING$(25,205)
1170 LOCATE ,X:PRINT "Locate disc at distance `F' above top of cone,"
1180 LOCATE ,X:PRINT "using insulated spacer(s). Feed with 50 Ω coax"
1190 LOCATE ,X:PRINT "line. Connect centre conductor to disc and"
1200 LOCATE ,X:PRINT "outer conductor to cone. If disc or cone is"
1210 LOCATE ,X:PRINT "constructed of wire or tube radials, connect"
1220 LOCATE ,X:PRINT "radial ends to form continuous wire or tube"
1230 LOCATE ,X:PRINT "perimeters at locations marked <■>. Disc"
1240 LOCATE ,X:PRINT "should have a minimum of 8 spokes."
1250 LOCATE Y:X=2
1260 COLOR 0,7
1270 LOCATE ,X:PRINT "                              "
1280 LOCATE ,X:PRINT "       │«─── G ───»│  F┐      "
1290 LOCATE ,X:PRINT " Disc=>■─────┬─────■ «─┤«───┐ "
1300 LOCATE ,X:PRINT "           ■─╫─■ «─────┘«─┐ │ "
1310 LOCATE ,X:PRINT "          /│ ║ │\         │ │ "
1320 LOCATE ,X:PRINT "         / │«B»│ \        │ │ "
1330 LOCATE ,X:PRINT " Cone=> /  │ ║    C       D H "
1340 LOCATE ,X:PRINT "       /«E»│ ║     \      │ │ "
1350 LOCATE ,X:PRINT "      /      ║      \     │ │ "
1360 LOCATE ,X:PRINT "     ■       ║       ■ «──┘«┘ "
1370 LOCATE ,X:PRINT "     │«── A ─╫──────»│        "
1380 LOCATE ,X:PRINT "             ║<= 50 Ω coax    "
1390 COLOR 7,0
1400 PRINT STRING$(80,205);
1410 RETURN
1420 :REM'
1430 :REM'.....preface
1440 TB=7
1450 PRINT TAB(TB);
1460 PRINT "Dimensions A and C are equal to a free-space quarter wavelength at"
1470 PRINT TAB(TB);
1480 PRINT "the lowest operating frequency. Due to the velocity factor of the"
1490 PRINT TAB(TB);
1500 PRINT "material used in a practical antenna, the actual cutoff frequency"
1510 PRINT TAB(TB);
1520 PRINT "will be slightly lower than the lowest operating frequency."
1530 PRINT
1540 PRINT TAB(TB);
1550 PRINT "This program is based on design data appearing in The ARRL ANTENNA"
1560 PRINT TAB(TB);
1570 PRINT "BOOK, 17th edition, on page 7-17, Fig.32, Fig.33 and the left-hand"
1580 PRINT TAB(TB);
1590 PRINT "column on page 7-18."
1600 RETURN
1610 :REM'
1620 :REM'PRT
1630 KEY OFF:GOSUB 1700:LOCATE 25,5:COLOR 0,2
1640 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1650 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1660 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1660 :ELSE GOSUB 1700
1670 IF Z$="3"THEN RETURN
1680 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1690 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1630
1700 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
