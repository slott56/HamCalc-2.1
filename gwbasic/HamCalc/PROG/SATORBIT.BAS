10 :REM'SATORBIT - satellite orbit - 14 MAR 95 rev.13 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 PI=3.1415929794311523!
60 RE=3963.340087890625!       :REM'radius of earth
70 SL=186*10^3      :REM'speed of light (miles per second)
80 E$=STRING$(80,32)
90 UL$=STRING$(80,205)
100 U1$="###,###"
110 U2$="###,###.####"
120 U3$="###,###.###"
130 U4$="###,###.##"
140 :REM'
150 :REM'start
160 CLS
170 COLOR 15,2
180 PRINT " SATELLITE ORBIT PARAMETERS";TAB(57);"by George Murphy VE3ERP ";
190 COLOR 1,0:PRINT STRING$(80,223);
200 COLOR 7,0
210 GOTO 270
220 :REM'
230 :REM'.....erase previous line
240 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
250 RETURN
260 :REM'
270 :REM'.....time and altitude
280 DIM B(20,3)
290 N=20             :REM'number of plots
300 INC=100          :REM'increment between plots
310 HI=144           :REM'ref.from graph
320 LO=88            :REM'ref.from graph
330 Y=(HI/LO)^(1/16) :REM'HI & LO 1600 miles apart on 100 mi.increment graph
340 :REM'
350 FOR Z=1 TO N
360 B(Z,1)=RE+INC*Z
370 B(Z,2)=(LO/Y)*Y^Z
380 B(Z,3)=B(Z,1)/B(Z,2)
390 NEXT Z
400 :REM'
410 PRINT " Press number in < > to choose standard units of measure:"
420 PRINT UL$;
430 PRINT "   < 1 >  Metric"
440 PRINT "   < 2 >  U.S.A./Imperial"
450 PRINT UL$;
460 PRINT "     or Press < 0 > to EXIT....."
470 Z$=INKEY$:IF Z$=""THEN 470
480 IF Z$="0"THEN CLS:RUN EX$
490 IF Z$="1"THEN UM=1.6093440055847168!:UM$="Km.":GOTO 520
500 IF Z$="2"THEN UM=1:UM$="miles":GOTO 520
510 GOTO 470
520 PRINT UL$;
530 INPUT " ENTER: Period (time for single orbit) (87-157 min.) ";MIN
540 IF MIN<87 OR MIN>157 THEN GOSUB 230:GOTO 530
550 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
560 FOR Z=1 TO N
570 IF MIN<B(Z,2)THEN 590
580 NEXT Z
590 J1=MIN-B(Z-1,2)
600 J2=B(Z,2)-B(Z-1,2)
610 J3=J1/J2
620 J4=B(Z-1,3)-B(Z,3)
630 J5=J3*J4
640 J6=B(Z-1,3)-J5
650 H=(J6*MIN)-RE
660 :REM'
670 LOCATE 3
680 PRINT "        Satellite altitude...........................";
690 PRINT USING U1$;H*UM;:PRINT " ";UM$
700 C=2*RE*PI    :REM'circumference of earth at equator (statute miles)
710 X=RE/(RE+H)                   :REM'hypotenuse of triangle
720 ACS=ATN(X/SQR(-X*X+1))+PI/2   :REM'inverse cosine of X
730 IF ACS>PI/2 THEN ACS=PI-ACS
740 MR=ACS/(2*PI)*C               :REM'map range in miles
750 PRINT "        Satellite signal map range (radio horizon)...";
760 PRINT USING U1$;MR*UM;:PRINT " ";UM$
770 CA=2*(90-(ACS*180/PI))
780 PRINT "        Apex angle of satellite signal cone..........";USING U1$;CA;
790 PRINT "°"
800 MD=2*MR                       :REM'map coverage circle diameter
810 PRINT "        Diameter of area covered by signal cone......";
820 PRINT USING U1$;MD*UM;:PRINT " ";UM$
830 PRINT "        Period (time for single orbit)...............";USING U1$;MIN;
840 PRINT " minutes"
850 OC=2*(RE+H)*PI   :REM'orbit circumference (miles)
860 OM=OC/MIN        :REM'orbital miles per minute
870 OH=OM*60         :REM'miles per hour
880 PRINT "        Satellite orbital speed......................";
890 PRINT USING U1$;OH*UM;:PRINT " ";UM$;" per hour"
900 MPM=OM/60*5280*12*25.399999618530273!/1000    :REM'metres per second
910 IF UM=1 THEN M=0.30480000376701355!:M$=" feet ":ELSE M=1:M$=" metres "
920 PRINT "                                                    =";
930 PRINT USING U1$;MPM/M;:PRINT M$;"per sec."
940 SIG=2*H/SL       :REM'signal time
950 PRINT "        Up-and-Back signal time .....................";USING U2$;SIG;
960 PRINT " sec."
970 INPUT " ENTER: UPLINK frequency (MHz).......................";UF
980 GOSUB 230
990 PRINT "        UPLINK frequency.............................";USING U3$;UF;
1000 PRINT " MHz"
1010 INPUT " ENTER: DOWNLINK frequency (MHz).....................";DF
1020 GOSUB 230
1030 PRINT "        DOWNLINK frequency...........................";USING U3$;DF;
1040 PRINT " MHz"
1050 DIF=ABS(UF-DF)
1060 DS=DIF/20
1070 PRINT "        Approximate maximum Doppler shift............";USING U1$;DS;
1080 PRINT " KHz"
1090 PRINT UL$;
1100 GOSUB 1150
1110 GOSUB 1290
1120 ERASE B:GOTO 150   :REM'start
1130 END
1140 :REM'
1150 :REM'.....notes
1160 TB=9
1170 PRINT TAB(TB);
1180 PRINT "The calculations used in this program were interpolated from"
1190 PRINT TAB(TB);
1200 PRINT "graphs appearing on page 111 of the Electronics Data Book"
1210 PRINT TAB(TB);
1220 PRINT "publication No. 27 of the ARRL. The results of these calculations"
1230 PRINT TAB(TB);
1240 PRINT "are sufficiently accurate for fast reference purposes but may not"
1250 PRINT TAB(TB);
1260 PRINT "be suitable for very accurate satellite tracking."
1270 RETURN
1280 :REM'
1290 :REM'PRT
1300 KEY OFF:GOSUB 1370:LOCATE 25,5:COLOR 0,2
1310 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1320 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1330 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1330 :ELSE GOSUB 1370
1340 IF Z$="3"THEN RETURN
1350 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1360 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1300
1370 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
