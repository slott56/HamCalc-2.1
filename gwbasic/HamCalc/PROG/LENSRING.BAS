10 :REM'LENSRING - 10 MAY 86 rev. 12 MAR 2000
20 CLS:KEY OFF
30 MENU=1    :REM'flag
40 COMMON A,B,F,X,MENU
50 DIM R(7,4)
60 A=36   :REM'frame length in mm.
70 B=24   :REM'frame width in mm.
80 UL$=STRING$(80,205)
90 U$="####.#"
100 E$=STRING$(80,32)
110 T$=" LENS EXTENSION RINGS and BELLOWS "
120 COLOR 0,2,2
130 PRINT UL$;
140 LOCATE 1,(80-LEN(T$))/2:PRINT T$
150 COLOR 2,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 GOSUB 1260
180 PRINT " PRESS number in < > to compute lens extension by means of:"
190 PRINT UL$;
200 PRINT "   <1>  Extension Rings"
210 PRINT "   <2>  Bellows"
220 Z$=INKEY$
230 IF Z$="1"THEN 360
240 IF Z$="2"THEN CLS:RUN"lenses"
250 GOTO 220
260 GOTO 360
270 :REM'
280 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING USIN$;Z;
290 RETURN
300 :REM'
310 :REM'.....format input line
320 LOCATE CSRLIN-1:PRINT SPC(7);
330 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;Z;
340 RETURN
350 :REM'
360 :REM'.....inputs
370 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
380 PRINT "        Enter lengths (in mm.) of the 3 rings for your camera."
390 PRINT "        ( Separate the lengths by commas, e.g. enter 7,14,25 )"
400 PRINT
410 COLOR 0,7
420 INPUT " ENTER: 3 Ring Lengths.....";R1,R2,R3
430 COLOR 7,0
440 :REM'
450 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
460 INPUT " ENTER: Focal length of lens.....................(mm)";F
470 IF F=0 THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 460
480 Z=F:GOSUB 310:PRINT " mm"
490 :REM'
500 FOR Z=1 TO 2
510 IF R1>R2 THEN SWAP R1,R2
520 IF R2>R3 THEN SWAP R2,R3
530 NEXT Z
540 R(1,1)=R1:R(1,4)=R1
550 R(2,1)=R1:R(2,2)=R2:R(2,4)=R1+R2
560 R(3,1)=R1:R(3,2)=R2:R(3,3)=R3:R(3,4)=R1+R2+R3
570 R(4,1)=R1:R(4,2)=R3:R(4,4)=R1+R3
580 R(5,1)=R2:R(5,4)=R2
590 R(6,1)=R2:R(6,2)=R3:R(6,4)=R2+R3
600 R(7,1)=R3:R(7,4)=R3
610 :REM'
620 :REM'.....start sort
630 SN=7
640 SM=SN
650 SM=INT(SM/2):IF SM=0 THEN 770
660 SK=SN-SM:SJ=1
670 SI=SJ
680 SL=SI+SM
690 IF R(SI,4)<=R(SL,4)THEN 750:REM'ELSE SWAP r(SI,1),r(SL,1)
700 SWAP R(SI,1),R(SL,1)
710 SWAP R(SI,2),R(SL,2)
720 SWAP R(SI,3),R(SL,3)
730 SWAP R(SI,4),R(SL,4)
740 SI=SI-SM:IF SI>0 THEN 680
750 SJ=SJ+1:IF SJ>SK THEN 650
760 GOTO 670
770 :REM'.....end of sort
780 :REM'
790 :REM'.....screen display
800 PRINT UL$;
810 PRINT "  Set";
820 PRINT TAB(9);"Extension Ring";
830 PRINT TAB(27);"Total";
840 PRINT TAB(36);"Magnif.";
850 PRINT TAB(44);"Expos."
860 :REM'
870 PRINT "  No.";
880 PRINT TAB(10);"Sizes ( mm.)";
890 PRINT TAB(25);"Extension";
900 PRINT TAB(36);"Factor";
910 PRINT TAB(44);"Factor";
920 PRINT TAB(55);"Maximum Subject Size"
930 PRINT UL$;
940 :REM'
950 FOR J=1 TO 7:FOR K=1 TO 4
960 V$="###"
970 W$="##.#"
980 X$="####"
990 Y=R(J,K)
1000 IF K=1 THEN PRINT " ";J;">  ";USING V$;Y;:GOTO 1040
1010 IF K=4 THEN PRINT "   =";USING V$;Y;:GOTO 1040
1020 IF Y>0 THEN PRINT " + ";USING V$;Y;:GOTO 1040
1030 PRINT "      ";
1040 NEXT K
1050 V=F+R(J,4)   :REM'lens to film plane
1060 M=V/F-1      :REM'magnification
1070 EF=(V/F)^2
1080 PRINT " mm";USING " ###.##";M;:PRINT "x";
1090 PRINT USING " ###.##";EF;:PRINT "x  ";
1100 PRINT USING V$;A/M;:PRINT " x";USING X$;B/M;
1110 PRINT " mm = ";USING W$;A/M/25.399999618530273!;:PRINT " x";USING W$;B/M/25.399999618530273!;
1120 PRINT " in."
1130 IF R(J,1)=R(J,4)THEN LOCATE CSRLIN-1,11:PRINT " only"
1140 NEXT J
1150 PRINT UL$;
1160 GOSUB 1760
1170 LOCATE 25,1:PRINT E$;:LOCATE 15,14:COLOR 0,7
1180 PRINT " PRESS one of the above Set Numbers to continue....."
1190 Z$=INKEY$
1200 IF VAL(Z$)<1 OR VAL(Z$)>7 THEN 1190
1210 X=R(VAL(Z$),4)
1220 COLOR 7,0
1230 CLS:CHAIN"lenses"
1240 END
1250 :REM'
1260 :REM'.....preface
1270 T=7
1280 PRINT TAB(T);
1290 PRINT "  Mounting a lens more than its focal length away from the film"
1300 PRINT TAB(T);
1310 PRINT "plane for Close-Up photography introduces certain changes in the"
1320 PRINT TAB(T);
1330 PRINT "operation of a camera:"
1340 PRINT UL$;
1350 PRINT " 1.";TAB(T);
1360 PRINT "  The image seen in the viewfinder of a single lens reflex camera"
1370 PRINT TAB(T);
1380 PRINT "will be dimmer than normal."
1390 PRINT " 2.";TAB(T);
1400 PRINT "  Lens focusing will not be very effective. Set the lens at"
1410 PRINT TAB(T);
1420 PRINT "infinity and focus by moving the entire camera back and forth."
1430 PRINT " 3.";TAB(T);
1440 PRINT "  The ƒ/STOP markings on the lens will be inaccurate. This program"
1450 PRINT TAB(T);
1460 PRINT "computes the actual EFFECTIVE apertures for each ƒ/STOP marking."
1470 PRINT " 4.";TAB(T);
1480 PRINT "  Additional exposure compensation will be required. Through-the-"
1490 PRINT TAB(T);
1500 PRINT "lens metering will make this compensation automatically, otherwise"
1510 PRINT TAB(T);
1520 PRINT "multiply externally metered (at the EFFECTIVE aperture) exposure"
1530 PRINT TAB(T);
1540 PRINT "times by the exposure factors computed by this program. DO NOT"
1550 PRINT TAB(T);
1560 PRINT "alter exposures by changing the ƒ/STOP."
1570 PRINT " 5.";TAB(T);
1580 PRINT "  Exposures of 1 sec. or more may reduce the normal ISO rating of"
1590 PRINT TAB(T);
1600 PRINT "the film you are using, due to its inherent reciprocity failure"
1610 PRINT TAB(T);
1620 PRINT "characteristics. Try making 3 exposures at the final computed speed"
1630 PRINT TAB(T);
1640 PRINT "and aperture, changing the ISO setting of the 2nd and 3rd exposures"
1650 PRINT TAB(T);
1660 PRINT "to ½ and ¼ (respectively) the normal ISO rating."
1670 PRINT TAB(T);
1680 COLOR 0,7:PRINT "..... Press 1 to continue or 0 to EXIT.....":COLOR 7,0
1690 Z$=INKEY$:IF Z$=""THEN 1690
1700 IF Z$="1"THEN 1730
1710 IF Z$="0"THEN CLS:RUN "fotomenu"
1720 GOTO 1690
1730 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1740 RETURN
1750 :REM'
1760 :REM'PRT
1770 KEY OFF:GOSUB 1840:LOCATE 25,5:COLOR 0,2
1780 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1790 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1800 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1800 :ELSE GOSUB 1840
1810 IF Z$="3"THEN RETURN
1820 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1830 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1770
1840 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
