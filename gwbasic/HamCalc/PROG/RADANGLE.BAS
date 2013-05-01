10 :REM'RADANGLE - Antenna radiation angle vs. height - 09 OCT 95 rev.16 SEP 98
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 DIM A(20)
60 PI=3.1415929794311523!
70 V=2997931.0!*10^-4   :REM'speed of light
80 UL$=STRING$(80,205)
90 U1$="###.###"
100 N=0    :REM'reset counter
110 :REM'
120 :REM'.....start
130 CLS
140 FOR Z=1 TO 20:A(Z)=0:NEXT Z
150 COLOR 15,2
160 PRINT " RADIATION ANGLE - ANTENNAS";TAB(57);"by George Murphy VE3ERP ";
170 COLOR 1,0:PRINT STRING$(80,223);
180 COLOR 7,0
190 :REM'
200 :REM'.....standard antenna disclaimer
210 :REM'OPEN"I",1,"\hamcalc\docfiles\antenna.doc
220 :REM'IF EOF(1)THEN 240
230 :REM'INPUT#1,Z$:PRINT "   ";Z$:GOTO 220
240 CLOSE
250 PRINT UL$;
260 GOSUB 1250    :REM'preface
270 Z$=INKEY$:IF Z$=""THEN 270
280 IF Z$="0"THEN CLS:RUN EX$
290 IF Z$="1"THEN 310
300 GOTO 270
310 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
320 GOTO 390
330 :REM'
340 :REM'.....format input line
350 LOCATE CSRLIN-1:PRINT SPC(7);
360 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U1$;ZZ;
370 RETURN
380 :REM'
390 :REM'.....input data
400 PRINT " Press number in < > to enter antenna height in:"
410 PRINT UL$;
420 PRINT "   <1> Wavelengths"
430 PRINT "   <2> Metres"
440 PRINT "   <3> Feet"
450 I$=INKEY$:IF I$=""THEN 450
460 IF I$="1"THEN L=1:GOTO 490
470 IF VAL(I$)>=1 AND VAL(I$)<=3 THEN 490
480 GOTO 450
490 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
500 INPUT " ENTER: Resonant frequency of antenna...........(MHz)";F
510 ZZ=F:GOSUB 340:PRINT " MHz"
520 W=V/F
530 PRINT "        Wavelength...................................";USING U1$;W;
540 PRINT " metres"
550 :REM'
560 IF I$="1"THEN H$="wavelengths"
570 IF I$="2"THEN H$="metres....."
580 IF I$="3"THEN H$="feet......."
590 PRINT " ENTER: Height of antenna in ";H$;".............";:INPUT HT
600 ZZ=HT:GOSUB 340:PRINT "        "
610 IF I$="1"THEN H=HT
620 IF I$="2"THEN H=HT/W
630 IF I$="3"THEN H=HT/W*0.30480000376701355!
640 IF H=HT THEN 660
650 PRINT "        Height of antenna in wavelengths.............";USING U1$;H
660 IF H>=0.25! AND H<=5 THEN 890
670 BEEP:PRINT
680 IF H>=0.25! THEN 810
690 M=HT/H/4
700 IF I$="1"THEN M$="":PRINT
710 IF I$="2"THEN M$=" metres."
720 IF I$="3"THEN M$=" feet."
730 PRINT TAB(6);"1/4 wavelength =";USING U1$;M;:PRINT M$
740 PRINT
750 PRINT TAB(6);
760 PRINT "Antenna heights less than 1/4 wavelength cannot attain maximum"
770 PRINT TAB(6);
780 PRINT "ground reflection reinforcement to the direct ray from the antenna."
790 GOTO 860
800 :REM'
810 PRINT:PRINT TAB(6);
820 PRINT "You have entered a height of more than five wavelengths, which is";
830 PRINT TAB(6);
840 PRINT "the arbitrary practical limit set by this program."
850 GOTO 860
860 PRINT:PRINT TAB(6);"Press any key to start over..........."
870 IF INKEY$=""THEN 870 :ELSE CLS:GOTO 150
880 :REM'
890 :REM'.....compute results
900 N=0
910 IF H/0.25!=INT(H/0.25!)THEN H=H+1.0000000116860974e-07!
920 N=N+1
930 X=N/4/H
940 GOSUB 1180
950 IF DELTA=PI/2 THEN 990
960 A(N)=D
970 GOTO 920
980 :REM'
990 :REM'.....screen print
1000 PRINT UL$;
1010 PRINT TAB(7);
1020 PRINT "RADIATION ANGLES AT WHICH GROUND-REFLECTION MAXIMA and NULLS APPEAR"
1030 PRINT TAB(27);"MAXIMA";TAB(46);"NULLS"
1040 PRINT UL$;
1050 FOR Z=1 TO N STEP 2
1060 IF A(Z)<>0 THEN PRINT TAB(28);USING "##.#";A(Z);:PRINT "°";
1070 IF A(Z+1)<>0 THEN PRINT TAB(46);USING "##.#";A(Z+1);:PRINT "°";
1080 NEXT Z
1090 PRINT UL$;
1100 PRINT TAB(T);
1110 PRINT "Appreciable HF radiation at angles smaller than a few degrees is"
1120 PRINT TAB(T);
1130 PRINT "almost impossible to obtain over horizontal ground. However, above"
1140 PRINT TAB(T);
1150 PRINT "15° the above angles are accurate enough for practical purposes."
1160 GOTO 1580   :REM'end
1170 :REM'
1180 :REM'.....compute arcsin of angle X
1190 Y=-X^2+1
1200 IF Y<=0 THEN DELTA=PI/2:GOTO 1220
1210 DELTA=ATN(X/SQR(Y))        :REM'wave angle in radians
1220 D=DELTA*180/PI             :REM'wave angle in degrees
1230 RETURN
1240 :REM'
1250 :REM'.....preface
1260 T=7
1270 PRINT TAB(T);
1280 PRINT "  This program computes the antenna wave angle versus height above"
1290 PRINT TAB(T);
1300 PRINT "the effective ground plane, which is seldom the actual surface of"
1310 PRINT TAB(T);
1320 PRINT "the ground. Instead, it is usually a few centimetres to perhaps a"
1330 PRINT TAB(T);
1340 PRINT "metre or so below it, depending on the characteristics of the soil."
1350 PRINT
1360 PRINT TAB(T);
1370 PRINT "  The calculations are valid for all horizontal antennas and for"
1380 PRINT TAB(T);
1390 PRINT "vertical antennas having a length equal to an even multiple of"
1400 PRINT TAB(T);
1410 PRINT "one-half wavelength. For vertical antennas an odd number of half-"
1420 PRINT TAB(T);
1430 PRINT "waves long, the maxima are the angles shown in the 'NULLS' column"
1440 PRINT TAB(T);
1450 PRINT "and the nulls are the angles shown in the 'MAXIMA' column."
1460 PRINT
1470 PRINT TAB(T);
1480 PRINT "  The program is based on data presented in the ARRL ELECTRONICS"
1490 PRINT TAB(T);
1500 PRINT "DATA BOOK, Second Edition, page 7-1, and the 1994 ARRL HANDBOOK,"
1510 PRINT TAB(T);
1520 PRINT "pages 17-2 and 17-3."
1530 COLOR 0,7:LOCATE 25,22
1540 PRINT " Press 1 to continue or 0 to EXIT.....";
1550 COLOR 7,0
1560 RETURN
1570 :REM'
1580 :REM'.....end
1590 GOSUB 1630
1600 GOTO 120
1610 END
1620 :REM'
1630 :REM'PRT
1640 KEY OFF:GOSUB 1710:LOCATE 25,5:COLOR 0,2
1650 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1660 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1670 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1670 :ELSE GOSUB 1710
1680 IF Z$="3"THEN RETURN
1690 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1700 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1640
1710 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
