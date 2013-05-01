10 :REM'BEAMSECT - 11 FEB 89 rev. 23 MAR 2000
20 IF EX$=""THEN EX$="EXIT"
30 COMMON EX$,LN,I,A,X$
40 CLS:KEY OFF
50 COLOR 7,0,4
60 DIM X$(11)
70 US$="###,###.###"
80 UL$=STRING$(80,205)
90 PI=3.1415929794311523!
100 HD$=" PROPERTIES OF COMMON SECTIONS OF BEAMS "
110 AD$="   ( NOTE: ENTER ALL DIMENSIONS IN INCHES )"
120 Y$=" in."
130 COLOR 11,1:PRINT HD$;TAB(57);"by George Murphy VE3ERP ";
140 COLOR 4,0:PRINT STRING$(80,"▀");
150 Z$=" Ref: Machinery's Handbook, 21st Edition "
160 COLOR 11,4:LOCATE CSRLIN-1,(80-LEN(Z$))/2:PRINT Z$
170 COLOR 7,0:PRINT UL$;
180 :REM'
190 :REM'.....input data
200 DATA " Solid Rectangular Beam "
210 DATA " Solid Triangular Beam (flat bottom) "
220 DATA " Hollow Rectangular Box Beam "
230 DATA " Solid Cylindrical Beam "
240 DATA " Hollow Tubular Beam "
250 DATA " I-Section Built-Up Beam "
260 DATA " H-Section Built-Up Beam "
270 DATA " [-Section Built-Up Beam "
280 DATA " U-Section Built-Up Beam "
290 DATA " T-Section Built-Up Beam "
300 DATA " EXIT "
310 FOR Z=1 TO 11:READ X$(Z):NEXT Z
320 :REM'
330 PRINT " Press letter in < > to select beam section:"
340 PRINT UL$;
350 FOR Z=1 TO 11
360 PRINT TAB(4);"< ";CHR$(Z+96);" >  ";X$(Z)
370 NEXT Z
380 Z$=INKEY$
390 IF Z$="a"THEN X$=X$(1):GOSUB 520:GOTO 580
400 IF Z$="b"THEN X$=X$(2):GOSUB 520:GOTO 770
410 IF Z$="c"THEN X$=X$(3):GOSUB 520:GOTO 950
420 IF Z$="d"THEN X$=X$(4):GOSUB 520:GOTO 1190
430 IF Z$="e"THEN X$=X$(5):GOSUB 520:GOTO 1340
440 IF Z$="f"THEN X$=X$(6):GOSUB 520:GOTO 1520
450 IF Z$="g"THEN X$=X$(7):GOSUB 520:GOTO 1760
460 IF Z$="h"THEN X$=X$(8):GOSUB 520:GOTO 2000
470 IF Z$="i"THEN X$=X$(9):GOSUB 520:GOTO 2240
480 IF Z$="j"THEN X$=X$(10):GOSUB 520:GOTO 2500
490 IF Z$="k"THEN CLS:CHAIN"mechmenu"
500 GOTO 380
510 :REM'
520 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
530 RETURN
540 :REM'
550 VIEW PRINT 5 TO 24:CLS:VIEW PRINT:LOCATE 5
560 RETURN
570 :REM'
580 :REM'.....solid rectangular
590 PRINT TAB(8)X$+AD$
600 PRINT UL$;
610 INPUT " ENTER: Width of base of section........";B
620 INPUT " ENTER: Height of section...............";D
630 A=B*D
640 Y=D/2
650 I=B*D^3/12
660 Z=I/Y
670 K=SQR(I/A)
680 GOSUB 550
690 PRINT TAB(8);" Width of base of section..............";USING US$;B;
700 PRINT Y$
710 PRINT TAB(8);" Height of section.....................";USING US$;D;
720 PRINT Y$
730 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
740 PRINT " in²"
750 GOTO 2760
760 :REM'
770 :REM'.....solid triangular
780 PRINT TAB(1)X$+AD$;
790 PRINT UL$;
800 INPUT " ENTER: Width of base of section........";B
810 INPUT " ENTER: Height of section...............";D
820 A=B*D/2
830 Y=2*D/3
840 I=B*D^3/36
850 Z=I/Y:K=SQR(I/A)
860 GOSUB 550
870 PRINT TAB(8);" Width of base of section..............";USING US$;B;
880 PRINT Y$
890 PRINT TAB(8);" Height of section.....................";USING US$;D;
900 PRINT Y$
910 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
920 PRINT " in²"
930 GOTO 2760
940 :REM'
950 :REM'.....hollow box
960 PRINT TAB(8)X$+AD$
970 PRINT UL$;
980 INPUT " ENTER: Width of base of section........";B
990 INPUT " ENTER: Height of section...............";D
1000 INPUT " ENTER: Thickness of sidewalls..........";T1:H=B-2*T1
1010 INPUT " ENTER: Thickness of top & bottom walls ";T2:K=D-2*T2
1020 A=B*D-H*K
1030 Y=D/2
1040 I=(B*D^3-H*K^3)/12
1050 Z=I/Y:K=SQR(I/A)
1060 GOSUB 550
1070 PRINT TAB(8);" Width of base of section..............";USING US$;B;
1080 PRINT Y$
1090 PRINT TAB(8);" Height of section.....................";USING US$;D;
1100 PRINT Y$
1110 PRINT TAB(8);" Thickness of sidewalls................";USING US$;T1;
1120 PRINT Y$
1130 PRINT TAB(8);" Thickness of top & bottom walls.......";USING US$;T2;
1140 PRINT Y$
1150 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
1160 PRINT " in²"
1170 GOTO 2760
1180 :REM'
1190 :REM'.....solid cylindrical
1200 PRINT TAB(8)X$+AD$
1210 PRINT UL$;
1220 INPUT " ENTER: Diameter of section.............";D
1230 A=PI*D^2/4
1240 Y=D/2
1250 I=PI*D^4/64
1260 Z=I/Y:K=SQR(I/A)
1270 GOSUB 550
1280 PRINT TAB(8);" Diameter of section...................";USING US$;D;
1290 PRINT Y$
1300 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
1310 PRINT " in²"
1320 GOTO 2760
1330 :REM'
1340 :REM'.....tubular
1350 PRINT TAB(8)X$+AD$
1360 PRINT UL$;
1370 INPUT " ENTER: Outside diameter of section.....";D
1380 INPUT " ENTER: Inside diameter of section......";D1
1390 A=PI*(D^2-D1^2)/4
1400 Y=D/2
1410 I=PI*(D^4-D1^4)/64
1420 Z=I/Y:K=SQR(I/A)
1430 GOSUB 550
1440 PRINT TAB(8);" Outside diameter of section...........";USING US$;D;
1450 PRINT Y$
1460 PRINT TAB(8);" Inside diameter of section............";USING US$;D1;
1470 PRINT Y$
1480 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
1490 PRINT " in²"
1500 GOTO 2760
1510 :REM'
1520 :REM'.....I-section
1530 PRINT TAB(8);X$+AD$
1540 PRINT UL$;
1550 INPUT " ENTER: Width of top & bottom flanges......";B
1560 INPUT " ENTER: Height of section..................";D
1570 INPUT " ENTER: Thickness of top & bottom flanges..";S:H=D-2*S
1580 INPUT " ENTER: Thickness of vertical web..........";T
1590 A=B*D-H*(B-T)
1600 Y=H/2
1610 I=(B*D^3-H^3*(B-T))/12
1620 Z=I/Y:K=SQR(I/A)
1630 GOSUB 550
1640 PRINT TAB(8);" Width of top & bottom flanges.........";USING US$;B;
1650 PRINT Y$
1660 PRINT TAB(8);" Height of section.....................";USING US$;D;
1670 PRINT Y$
1680 PRINT TAB(8);" Thickness of top & bottom flanges.....";USING US$;S;
1690 PRINT Y$
1700 PRINT TAB(8);" Thickness of vertical web.............";USING US$;T;
1710 PRINT Y$
1720 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
1730 PRINT " in²"
1740 GOTO 2760
1750 :REM'
1760 :REM'.....H-section
1770 PRINT TAB(8)X$+AD$
1780 PRINT UL$;
1790 INPUT " ENTER: Width across outside of vertical legs..";D
1800 INPUT " ENTER: Height of vertical legs................";B
1810 INPUT " ENTER: Thickness of vertical legs.............";S:H=D-2*S
1820 INPUT " ENTER: Thickness of horizontal web............";T
1830 A=B*D-H*(B-T)
1840 Y=B/2
1850 I=(2*S*B^3+H*T^3)/12
1860 Z=I/Y:K=SQR(I/A)
1870 GOSUB 550
1880 PRINT TAB(8);" Width across outside of vertical legs ";USING US$;D;
1890 PRINT Y$
1900 PRINT TAB(8);" Height of vertical legs...............";USING US$;B;
1910 PRINT Y$
1920 PRINT TAB(8);" Thickness of vertical legs............";USING US$;S;
1930 PRINT Y$
1940 PRINT TAB(8);" Thickness of horizontal web...........";USING US$;T;
1950 PRINT Y$
1960 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
1970 PRINT " in²"
1980 GOTO 2760
1990 :REM'
2000 :REM'.....[-section
2010 PRINT TAB(8);X$+AD$
2020 PRINT UL$;
2030 INPUT " ENTER: Width of horizontal legs......................";B
2040 INPUT " ENTER: Vertical height of section....................";D
2050 INPUT " ENTER: Thickness of horizontal legs..................";S:H=D-2*S
2060 INPUT " ENTER: Thickness of vertical web.....................";T
2070 A=B*D-H*(B-T)
2080 Y=D/2
2090 I=(B*D^3-H^3*(B-T))/12
2100 Z=I/Y:K=SQR(I/A)
2110 GOSUB 550
2120 PRINT TAB(8);" Width of horizontal legs..............";USING US$;B;
2130 PRINT Y$
2140 PRINT TAB(8);" Vertical height of section............";USING US$;D;
2150 PRINT Y$
2160 PRINT TAB(8);" Thickness of horizontal legs..........";USING US$;S;
2170 PRINT Y$
2180 PRINT TAB(8);" Thickness of vertical web.............";USING US$;T;
2190 PRINT Y$
2200 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
2210 PRINT " in²"
2220 GOTO 2760
2230 :REM'
2240 :REM'.....U-section
2250 PRINT TAB(8);X$+AD$
2260 PRINT UL$;
2270 INPUT " ENTER: Width of base of section......................";D
2280 INPUT " ENTER: Height of section.............................";B
2290 INPUT " ENTER: Thickness of base web.........................";T
2300 INPUT " ENTER: Thickness of vertical legs....................";S:H=D-2*S
2310 A=B*D-H*(B-T)
2320 Q1=2*B^2*S+H*T^2
2330 Q2=2*B*D-2*H*(B-T)
2340 Y=B-Q1/Q2
2350 I=((2*S*B^3+H*T^3)/3)-(A*(B-Y)^2)
2360 Z=I/Y:K=SQR(I/A)
2370 GOSUB 550
2380 PRINT TAB(8);" Width of base of section..............";USING US$;H;
2390 PRINT Y$
2400 PRINT TAB(8);" Height of section.....................";USING US$;B;
2410 PRINT Y$
2420 PRINT TAB(8);" Thickness of base web.................";USING US$;T;
2430 PRINT Y$
2440 PRINT TAB(8);" Thickness of vertical legs............";USING US$;S;
2450 PRINT Y$
2460 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
2470 PRINT " in²"
2480 GOTO 2760
2490 :REM'
2500 :REM'.....T-section
2510 PRINT TAB(8)X$+AD$
2520 PRINT UL$;
2530 INPUT " ENTER: Width of horizontal flange....................";B
2540 INPUT " ENTER: Height of section.............................";D
2550 INPUT " ENTER: Thickness of horizontal flange................";S:H=D-S
2560 INPUT " ENTER: Thickness of vertical web.....................";T
2570 A=B*S+H*T
2580 Q1=D^2*T+S^2*(B-T)
2590 Q2=2*(B*S+H*T)
2600 Y=D-Q1/Q2
2610 I=((T*Y^3+B*(D-Y)^3)-(B-T)*(D-Y-S)^3)/3
2620 Z=I/Y:K=SQR(I/A)
2630 GOSUB 550
2640 PRINT TAB(8);" Width of horizontal flange............";USING US$;B;
2650 PRINT Y$
2660 PRINT TAB(8);" Height of section.....................";USING US$;D;
2670 PRINT Y$
2680 PRINT TAB(8);" Thickness of horizontal flange........";USING US$;S;
2690 PRINT Y$
2700 PRINT TAB(8);" Thickness of vertical web.............";USING US$;T;
2710 PRINT Y$
2720 PRINT TAB(8);" Cross section area of section.........";USING US$;A;
2730 PRINT " in²"
2740 GOTO 2760
2750 :REM'
2760 :REM'.....display results
2770 PRINT TAB(8);" Moment of Inertia....(in inches^4)....";USING US$;I
2780 PRINT TAB(8);" Section Modulus......(in inches^3)....";USING US$;Z
2790 PRINT TAB(8);" Radius of Gyration....................";USING US$;K;
2800 PRINT Y$
2810 PRINT UL$;
2820 LN=CSRLIN-1                           :REM'last line number
2830 LOCATE 3,1:PRINT STRING$(80,32);      :REM'erase heading
2840 LOCATE CSRLIN-1:PRINT TAB(8);X$       :REM'reprint heading without note
2850 GOSUB 3150
2860 LOCATE LN+2,6
2870 COLOR 0,3
2880 PRINT " Do you want to determine deflection of this beam under load?";
2890 PRINT "   (y/n) "
2900 COLOR 7,0
2910 Z$=INKEY$
2920 IF Z$="n"THEN 3100
2930 IF Z$="y"THEN 2960
2940 GOTO 2910
2950 :REM'
2960 :REM'.....take snapshot of screen
2970 DIM LN$(24)
2980 OPEN"O",1,"\hamcalc\data\snapshot.fil"
2990 FOR QX=5 TO LN-1               :REM'LN = last line on screen
3000 LN$(QX)=""                     :REM'clear variable memory
3010 FOR QY=1 TO 80                 :REM'80 characters
3020 LN$(QX)=LN$(QX)+CHR$(SCREEN(QX,QY))
3030 NEXT QY
3040 WRITE#1,LN$(QX)
3050 NEXT QX
3060 CLOSE
3070 ERASE LN$                     :REM'clear array DIM
3080 CLS:CHAIN"beamdefl"
3090 :REM'
3100 :REM'.....clear variables & return to main menu
3110 RESTORE:ERASE X$
3120 GOTO 40
3130 END
3140 :REM'
3150 :REM'PRT
3160 KEY OFF:GOSUB 3230:LOCATE 25,5:COLOR 0,2
3170 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3180 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3190 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3190 :ELSE GOSUB 3230
3200 IF Z$="3"THEN RETURN
3210 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3220 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3160
3230 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
