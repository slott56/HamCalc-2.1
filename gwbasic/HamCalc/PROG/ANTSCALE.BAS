10 :REM'ANTSCALE - Antenna Frequency Scaling - 17 MAR 97 rev.08 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 F$="######.###"
50 I$="####.### in."
60 C$="####.## cm.="
70 UL$=STRING$(80,205)
80 X$=STRING$(80,32)
90 LF=1/LOG(10)   :REM'log factor for base 10
100 COLOR 7,0,0
110 GOTO 220
120 :REM'
130 :REM'.....erase bottom of screen
140 VIEW PRINT LN TO 24:CLS:VIEW PRINT
150 RETURN
160 :REM'
170 :REM'.....format input line
180 LOCATE CSRLIN-1:PRINT SPC(7);
190 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING M$;ZZ;
200 RETURN
210 :REM'
220 :REM'.....start
230 COLOR 15,2
240 PRINT " ANTENNA FREQUENCY SCALING";TAB(57)"by George Murphy VE3ERP ";
250 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
260 :REM'
270 LN=3:GOSUB 130:LOCATE 3
280 GOSUB 1070   :REM'preface
290 PRINT UL$;
300 PRINT " Press number in < > for:"
310 PRINT UL$;
320 PRINT "  < 1 >  Frequency Scaling"
330 PRINT "  < 2 >  Element Diameter/Length Scaling"
340 PRINT UL$;
350 PRINT "  < 0 >  EXIT"
360 Z$=INKEY$:IF Z$=""THEN 360
370 IF Z$="0"THEN CLS:RUN EX$
380 IF Z$="1"OR Z$="2"THEN LN=3:GOSUB 130:LOCATE LN:GOTO 410
390 GOTO 360
400 :REM'
410 :REM'.....initial inputs
420 INPUT " ENTER: Original Design Frequency...............(MHz)";F1
430 ZZ=F1:M$=F$:GOSUB 170:PRINT " MHz"
440 :REM'
450 INPUT " ENTER: Scaled Frequency of operation...........(MHz)";F2
460 ZZ=F2:M$=F$:GOSUB 170:PRINT " MHz"
470 SC=F1/F2   :REM'scale
480 PRINT "        Scale........................................";
490 PRINT USING F$;SC;:PRINT ":1"
500 IF Z$="1"THEN 530
510 IF Z$="2"THEN 640
520 :REM'
530 :REM'.....frequency scaling
540 COLOR 0,7:PRINT " Enter original dimension in any unit. Scaled dimension ";
550 PRINT "is in same unit. ":COLOR 7,0
560 INPUT " ENTER: Original design dimension or 0 to quit.......";OD
570 IF OD=0 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE 6:PRINT X$;:GOTO 610
580 ZZ=OD:M$=F$:GOSUB 170:PRINT " =";:PRINT USING M$;ZZ*SC
590 LOCATE CSRLIN-1,34:PRINT STRING$(13,".")
600 GOTO 560
610 LOCATE 6,66:PRINT "Scaled Dimen."
620 GOTO 1300   :REM'end
630 :REM'
640 :REM'.....element diameter scaling
650 COLOR 0,7
660 PRINT " Do you want enter dimensions in (c)entimetes or (i)nches?  (c/i) "
670 COLOR 7,0
680 D$=INKEY$:IF D$=""THEN 680
690 IF D$="c"THEN UM=2.5399999618530273!:UM$="cm.":GOTO 730
700 IF D$="i"THEN UM=1   :UM$="in.":GOTO 730
710 GOTO 680
720 :REM'
730 LN=CSRLIN-1:GOSUB 130:LOCATE LN+1
740 PRINT " ENTER: Original Element Diameter...............(";UM$;")";
750 INPUT EL1:EL1=EL1/UM:ZZ=EL1*2.5399999618530273!:M$=C$:GOSUB 170:PRINT USING I$;EL1
760 D1=EL1/(11803/F1)    :REM'free space wavelength
770 :REM'
780 PRINT " ENTER: Original Element Length.................(";UM$;")";
790 INPUT LG1:LG1=LG1/UM:ZZ=LG1*2.5399999618530273!:M$=C$:GOSUB 170:PRINT USING I$;LG1
800 L1=LG1/(11803/F1)    :REM'free space wavelength
810 M1=LOG(2/D1)*LF
820 A1=430.79998779296875!*M1-339
830 LR1=0.5!-(33.25!+3.190000057220459!*M1-0.3499999940395355!*M1^2)/(861.5999755859375!*M1-678)
840 FR1=LR1/L1
850 :REM'
860 ND=EL1*SC*UM
870 PRINT "        Scaled Element Diameter......................";USING C$;ND;
880 PRINT USING I$;EL1*SC
890 LG2=LG1*SC*UM
900 PRINT "        Scaled Element Length........................";USING C$;LG2;
910 PRINT USING I$;LG1*SC
920 PRINT
930 PRINT " ENTER: Your choice of scaled element diameter..(";UM$;")";
940 INPUT EL2:EL2=EL2/UM:ZZ=EL2*2.5399999618530273!:M$=C$:GOSUB 170:PRINT USING I$;EL2
950 D2=EL2/(11803/F2)    :REM'free space wavelength
960 M2=LOG(2/D2)*LF
970 A2=430.79998779296875!*M2-339
980 LR2=0.5!-(33.25!+3.190000057220459!*M2-0.3499999940395355!*M2^2)/(861.5999755859375!*M2-678)
990 FR2=1-(A1*(1-FR1))/A2
1000 L2=LR2/FR2
1010 WL=11803/F2   :REM'free space wavelength in inches
1020 LGTH=L2*WL*2.5399999618530273!
1030 PRINT "        Corrected element length for this diameter...";
1040 PRINT USING C$;LGTH;:PRINT USING I$;L2*WL
1050 GOTO 1300
1060 :REM'
1070 :REM'.....preface
1080 T=7
1090 PRINT TAB(T);
1100 PRINT "Any antenna design can be scaled for use on another frequency or on"
1110 PRINT TAB(T);
1120 PRINT "another amateur band. To scale an antenna properly, ALL physical"
1130 PRINT TAB(T);
1140 PRINT "dimensions must be scaled, including element lengths, element"
1150 PRINT TAB(T);
1160 PRINT "spacings, boom length and element diameters. This usually results"
1170 PRINT TAB(T);
1180 PRINT "in a scaled element diameter of inconvenient size. Simply changing"
1190 PRINT TAB(T);
1200 PRINT "the diameter is not satisfactory without making a corresponding"
1210 PRINT TAB(T);
1220 PRINT "element length correction. This program computes both Frequency"
1230 PRINT TAB(T);
1240 PRINT "scaling and Element diameter/length scaling."
1250 PRINT
1260 PRINT TAB(T);
1270 PRINT "(ref. The ARRL Antenna Book, 17th Edition, pages 2-24 and 2-25)"
1280 RETURN
1290 :REM'
1300 :REM'.....end
1310 GOSUB 1330:GOTO 270
1320 :REM'
1330 :REM'PRT
1340 KEY OFF:GOSUB 1410:LOCATE 25,5:COLOR 0,2
1350 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1360 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1370 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1370 :ELSE GOSUB 1410
1380 IF Z$="3"THEN RETURN
1390 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1400 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1340
1410 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
