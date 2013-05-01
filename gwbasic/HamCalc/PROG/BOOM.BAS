10 :REM'BOOM - Boom Droop, Beam Antennas - 04 MAY 2000 rev.
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$
50 COLOR 7,0,0
60 PI=4*ATN(1)       :REM'3.141593
70 DIM EL(10,2)
80 E=103*10^5        :REM'Modulus of elasticity for aluminum
90 PCI=0.09790001064538956!  :REM'Aluminum weight in lbs/in²
100 GOTO 160
110 :REM'
120 :REM'.....print line
130 PRINT P$;USING " ###.### in.= ###.## cm";M,N
140 RETURN
150 :REM'
160 :REM'.....title page
170 CLS
180 COLOR 15,2
190 PRINT " BOOM DROOP - Beam Antennas"TAB(57)"by George Murphy VE3ERP ";
200 COLOR 1,0:PRINT STRING$(80,223);
210 COLOR 7,0
220 :REM'
230 :REM'.....start
240 GOSUB 1490   :REM'preface
250 PRINT
260 COLOR 0,7:LOCATE ,24:PRINT " Press 1 to continue, or 0 to EXIT ":COLOR 7,0
270 Z$=INKEY$:IF Z$=""THEN 270
280 IF Z$="0"THEN CLS:RUN EX$
290 IF Z$="1"THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 320
300 GOTO 270
310 :REM'
320 PRINT " Referring to one of the boom arms:"
330 PRINT
340 PRINT " ENTER: Distance (inches) from centre to end of boom............";
350 INPUT EL(1,1)
360 PRINT " ENTER: Number of antenna elements on this arm..................";
370 INPUT J
380 PRINT " ENTER: Weight (lbs.) of element no. 1 at boom end..............";
390 INPUT EL(1,2)
400 IF J<2 THEN 490
410 FOR X=2 TO J
420 PRINT " ENTER: Dist.(in.) from boom end to next inner element no.";X;"...";
430 INPUT EL(X,1):IF EL(X,1)>EL(1,1)THEN BEEP:GOTO 420
440 PRINT " ENTER: Weight (lbs.) of element no.";X;".........................";
450 INPUT EL(X,2)
460 NEXT X
470 EL(X,1)=EL(1,1)-EL(J,1)
480 :REM'
490 PRINT
500 PRINT " Some standard O.D.'s are: .75, 1.00, 1.25, 1.50, 2.00, 2.50,";
510 PRINT " 3.00 inches"
520 INPUT " ENTER: Outside diameter of boom (inches).......................";OD
530 PRINT
540 PRINT " Some standard wall gauges are: .035, .049, .058, .065, .083,";
550 PRINT " .125, .250 inches"
560 INPUT " ENTER: Boom wall thickness (inches)............................";GA
570 CLS:GOSUB 1210  :REM'diagram
580 :REM'
590 :REM'....calculate
600 ID=OD-2*GA
610 L=EL(1,1)
620 AR=PI*(OD^2-ID^2)/4    :REM'cross-section area
630 Y=OD/2                 :REM'OD radius
640 I=PI*(OD^4-ID^4)/64    :REM'moment of inertia in in^4
650 Z=I/Y                  :REM'section modulus in in^3
660 K=SQR(I/AR)            :REM'radius of gyration
670 WT=AR*L*PCI            :REM'weight of this end of boom
680 :REM'
690 LOCATE 6
700 P$=" Distance from mast to end of boom..................":M=L:N=M*2.5399999618530273!
710 GOSUB 120
720 P$=" Outside diameter of boom...........................":M=OD:N=M*2.5399999618530273!
730 GOSUB 120
740 P$=" Boom wall thickness................................":M=GA:N=N*2.5399999618530273!
750 GOSUB 120
760 P$=" Inside diameter of boom............................":M=ID:N=M*2.5399999618530273!
770 GOSUB 120
780 P$=" Cross-section area of aluminum....................."
790 PRINT P$;USING " ###.### in²= ###.## cm²";AR,AR*6.451600074768066!
800 P$=" Radius of gyration.................................":M=K:N=M*2.5399999618530273!
810 GOSUB 120
820 P$=" Moment of inertia.................................."
830 PRINT P$;USING " ###.### inches^4";I
840 P$=" Section modulus...................................."
850 PRINT P$;USING " ###.### inches^3";Z
860 DT=0    :REM'clear total deflection variable
870 :REM'
880 :REM'.....boom weight
890 D(0)=(WT*L^3)/(8*E*I)  :REM'deflection due to weight of boom
900 DT=D(0)     :REM'DT=total deflection
910 M=WT:N=M*0.4535900056362152!
920 PRINT " Boom deflection (droop) due to:"
930 PRINT USING " ###.## lb. (##.## kg) weight of boom...............";M,N;
940 M=D(0):N=M*2.5399999618530273!
950 PRINT USING " ###.### in.= ###.## cm.";M,N
960 :REM'
970 :REM'.....end element
980 D(1)=(EL(1,2)*L^3)/(3*E*I):DT=DT+D(1)
990 M=EL(1,2):N=M*0.4535900056362152!
1000 PRINT USING " ###.## lb. (##.## kg) weight of outer element no. 1";M,N;
1010 M=D(1):N=M*2.5399999618530273!
1020 PRINT USING " ###.### in.= ###.## cm.";M,N
1030 IF J<2 THEN 1160
1040 :REM'
1050 :REM'.....other elements
1060 FOR X=2 TO J
1070 BB=EL(X,1):LL=EL(1,1)-BB
1080 D(X)=(EL(X,2)*LL^2)/(6*E*I)*(2*LL+3*BB):DT=DT+D(X)
1090 M=DT:N=M*2.5399999618530273!
1100 M=EL(X,2):N=M*0.4535900056362152!
1110 PRINT USING " ###.## lb. (##.## kg) weight of inner element no. #";M,N,X;
1120 M=D(X):N=M*2.5399999618530273!
1130 PRINT USING " ###.### in.= ###.## cm.";M,N
1140 NEXT X
1150 :REM'
1160 :REM'.....finish
1170 M=DT:N=M*2.5399999618530273!
1180 LOCATE ,32:PRINT USING "Total deflection..... ###.### in.= ###.## cm.";M,N
1190 GOTO 1400
1200 :REM'
1210 :REM'.....diagram
1220 IF J=1 THEN 1340
1230 PRINT "  ";:FOR X=1 TO J:PRINT USING "#       ";X;:NEXT X:PRINT "┌ mast"
1240 PRINT "  │";
1250 C=0:FOR X=2 TO J:CC=EL(X,1)-C
1260 PRINT USING " ###.##│";CC;:C=C+CC:NEXT X:PRINT USING " ###.##";EL(J+1,1);
1270 PRINT " «in."
1280 LOCATE ,2:PRINT " ╞";:FOR X=1 TO J:PRINT "═══════╪";:NEXT X:PRINT " «boom"
1290 LOCATE ,2:PRINT " │";
1300 C=0:FOR X=2 TO J:CC=EL(X,1)*2.5399999618530273!-C
1310 PRINT USING " ###.##│";CC;:C=C+CC:NEXT X
1320 PRINT USING " ###.##";(EL(J+1,1))*2.5399999618530273!;:PRINT " «cm."
1330 RETURN
1340 PRINT       "  1       ┌ mast"
1350 PRINT USING "  │ ###.## «in.";EL(1,1)
1360 PRINT       "  ╞═══════╪ «boom"
1370 PRINT USING "  │ ###.## «cm.";EL(1,1)*2.5399999618530273!
1380 RETURN
1390 :REM'
1400 :REM'.....calculation complete
1410 LOCATE 24,20:COLOR 0,7
1420 PRINT " (o)k as is?, (c)hange boom size?   (o/c)";
1430 COLOR 7,0
1440 Z$=INKEY$:IF Z$=""THEN 1440
1450 IF Z$="o"THEN LOCATE CSRLIN-1:PRINT STRING$(80,32);:GOTO 1760
1460 IF Z$="c"THEN CLS:GOTO 490
1470 GOTO 1440
1480 :REM'
1490 :REM'.....preface
1500 PRINT " Before running this program, the weight of each antenna element ";
1510 PRINT "mounted on the"
1520 PRINT " boom must be known or estimated."
1530 PRINT
1540 PRINT " The location of the boom support (e.g., mast), usually located a";
1550 PRINT "t the antenna "
1560 PRINT " centre of gravity, is assumed to be at the centre of the boom. I";
1570 PRINT "n most Amateur"
1580 PRINT " Radio applications this approximation is close enough for purpos";
1590 PRINT "es of this    "
1600 PRINT " program."
1610 PRINT
1620 PRINT " Each half of the boom is considered to be a cantilever beam. Def";
1630 PRINT "lection of the"
1640 PRINT " beam is calculated using standard beam equations (Machinery's Ha";
1650 PRINT "ndbook, 21st  "
1660 PRINT " edition, page 408). Calculations are for 6061-T6 (61S-T6) round ";
1670 PRINT "aluminum tube."
1680 PRINT
1690 PRINT " Run each half of the beam antenna through the program separately";
1700 PRINT ". The end     "
1710 PRINT " deflections of each half will be equalized when the boom is atta";
1720 PRINT "ched to the   "
1730 PRINT " mast at the boom's actual centre of gravity."
1740 RETURN
1750 :REM'
1760 :REM'.....END
1770 GOSUB 1790:GOTO 160
1780 :REM'
1790 :REM'PRT
1800 KEY OFF:GOSUB 1870:LOCATE 25,5:COLOR 0,2
1810 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1820 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1830 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1830 :ELSE GOSUB 1870
1840 IF Z$="3"THEN RETURN
1850 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1860 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1800
1870 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
