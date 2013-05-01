10 :REM'PATHFIND - Combined GRCIRCL & LATLONG programs - 02 APR 92 rev. 17 APR 2010
20 COMMON EX$,PROG$
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN PROG$="pathfind"
50 GO$="latlong"
60 IF LIB=1 THEN 430   :REM'LIB = data already loaded flag
70 IF POSN THEN 430
80 LIB=1
90 ON ERROR  GOTO 210
100 CLS:KEY OFF
110 COLOR 7,0,0
120 DIM A$(1024,4),F$(50,2)
130 U1$="#####.#":U2$="##,###.#":U3$="####.#":U4$="####,###.#":U5$="###.#"
140 UL$=STRING$(80,205)
150 XX$=STRING$(79,32)          :REM'blank
160 E$=CHR$(248)                :REM'° symbol
170 PI=3.1415929794311523!
180 IF BASEONLY=1 THEN GOSUB 300:GOTO 4100     :REM'run database only
190 GOSUB 310:GOTO 430
200 :REM'
210 :REM'.....error trap
220 IF ERR=75 OR ERR=76 AND ERL=4330 THEN 250
230 PRINT "Error";ERR;"in line";ERL;"...Press any key to start over..."
240 IF INKEY$=""THEN 240 :ELSE 270
250 CLS:BEEP:PRINT " Error";ERR;" Path or File Access Error."
260 PRINT " You may be trying to write to a Read Only disc."
270 PRINT " Press F2 to start over....."
280 END
290 RUN EX$
300 :REM'
310 :REM'.....load data
320 PRINT " LOADING DATA from DISK - Please stand by......"
330 OPEN "I",1,"\hamcalc\latlong\LATLONG.DAT"
340 IF EOF(1) THEN 400
350 N=N+1
360 FOR Y=1 TO 4
370 INPUT# 1,A$(N,Y)
380 NEXT Y
390 GOTO 340
400 CLOSE
410 RETURN
420 :REM'
430 :REM'.....start
440 CLS
450 IF LATLONG=1 THEN LATLONG=0:GOTO 4100   :REM'latlong program
460 COLOR 15,2
470 PRINT " GREAT CIRCLE PATHS, BEARINGS and DISTANCES";
480 PRINT TAB(57);"by George Murphy VE3ERP ";
490 COLOR 1,0:PRINT STRING$(80,223);
500 COLOR 7,0
510 IF POSN THEN Z=POSN:GOSUB 1300:GOTO 1000
520 :REM'
530 GOSUB 7060  :REM'preface
540 PRINT UL$;
550 PRINT " Press number in < > to:"
560 PRINT UL$;
570 PRINT "  < 1 >  RUN program"
580 PRINT "  < 2 >  VIEW/EDIT/SEARCH data files (Latitude/Longitude Data Base)"
590 PRINT UL$;
600 PRINT "  < 0 >  EXIT"
610 Z$=INKEY$
620 IF Z$="0"THEN CLS:RUN EX$
630 IF Z$="1"THEN GOSUB 670:GOTO 790
640 IF Z$="2"THEN CLS:CHAIN"latlong"
650 GOTO 610
660 :REM'
670 :REM'....units of distance
680 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
690 PRINT " Press letter in < > to select units of distance:"
700 PRINT UL$;
710 PRINT "  < n >  Nautical miles"
720 PRINT "  < s >  Statute miles"
730 PRINT "  < k >  Kilometres"
740 Z$=INKEY$
750 IF Z$="n"OR Z$="s"OR Z$="k"THEN FAR$=Z$:GOTO 770
760 GOTO 740
770 RETURN
780 :REM'
790 :REM'.....instructions
800 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3,2
810 COLOR 0,7:PRINT " NOTE: ":COLOR 7,0
820 PRINT
830 PRINT "  Enter latitude and longitude as decimal degrees, to the nearest ";
840 PRINT "1/10th of a"
850 PRINT "  degree, e.g. 47.3 for 48°20'. If you enter data with more than ";
860 PRINT "one place of"
870 PRINT "  decimals the data entered will be used in all calculations, even ";
880 PRINT "though all"
890 PRINT "  data displayed will be rounded-off to the nearest 1/10th degree."
900 PRINT
910 PRINT "  1/10th of a degree longitude is equal to about 11 kilometres ";
920 PRINT "at the equator,"
930 PRINT "  less than 6 Km. at 60° latitude."
940 PRINT
950 PRINT UL$;
960 :REM'
970 :REM'.....inputs
980 P$(1)="A ":P$(2)="B "
990 :REM'
1000 LOCATE 15
1010 IF POSN THEN ZZ=POSN :ELSE ZZ=1
1020 IF POSN<>1 THEN 1080
1030 GOSUB 1280
1040 IF Z=1 THEN PRINT "Point A:"
1050 PRINT "Latitude of  ";P$(Z);USING U2$;ABS(LA(Z));:PRINT NS$(Z)
1060 PRINT "Longitude of ";P$(Z);USING U2$;ABS(LO(Z));:PRINT EW$(Z)
1070 :REM'
1080    FOR Z=ZZ TO 2   :REM'********** start input loop **********
1090 DOT$=STRING$(39-LEN(P$(Z)),".")
1100 IF POSN=Z THEN GOSUB 1280:GOTO 1340
1110 IF(P$(Z)<>"" AND LA(Z)*LO(Z))THEN 1340
1120 COLOR 0,7:LOCATE CSRLIN,7
1130 PRINT" (ENTER <x> to access data on file or enter latitude:";
1140 COLOR 7,0
1150 PRINT" ENTER: Latitude (minus if South) of ";P$(Z);:INPUT I$
1160 IF I$="x"OR I$="X"THEN POSN=Z:CLS:GOTO 4100       :REM'latlong program
1170 LA(Z)=VAL(I$):GOSUB 1280
1180 FOR CL=CSRLIN-2 TO CSRLIN:LOCATE CL:PRINT XX$:NEXT CL
1190 LOCATE CSRLIN-3,8
1200 PRINT " Latitude of  ";P$(Z);DOT$;USING U2$;ABS(LA(Z));:PRINT NS$(Z)
1210 PRINT" ENTER: Longitude (minus if West) of ";P$(Z);:INPUT LO(Z)
1220 GOSUB 1280
1230 FOR CL=CSRLIN-1 TO CSRLIN:LOCATE CL:PRINT XX$:NEXT CL
1240 LOCATE CSRLIN-2,8
1250 PRINT " Longitude of ";P$(Z);DOT$;USING U2$;ABS(LO(Z));:PRINT EW$(Z)
1260 GOTO 1340
1270 :REM'
1280 IF SGN(LA(Z))=-1 THEN NS$(Z)=E$+"S ":ELSE NS$(Z)=E$+"N "
1290 IF SGN(LO(Z))=-1 THEN EW$(Z)=E$+"W ":ELSE EW$(Z)=E$+"E "
1300 RLA(Z)=LA(Z)*PI/180      :REM'latitude in radians
1310 RLO(Z)=LO(Z)*PI/180      :REM'longitude in radians
1320 RETURN
1330 :REM'
1340 IF MID$(P$(Z),2)=" "THEN 1350 :ELSE 1500
1350 PRINT " Do you want to name ";P$(Z);"?  (y/n)"
1360 Z$=INKEY$
1370 IF Z$="n"OR Z$="N"THEN LOCATE CSRLIN-1:PRINT XX$:LOCATE CSRLIN-1:GOTO 1500
1380 IF Z$="y"OR Z$="Y"THEN 1410
1390 GOTO 1360
1400 :REM'
1410  LOCATE CSRLIN-1:PRINT XX$:LOCATE CSRLIN-1
1420  PRINT " ENTER: Name of ";P$(Z);" ? ";:LINE INPUT P$(Z)
1430   FOR X=1 TO LEN(P$(Z))
1440    V=ASC(MID$(P$(Z),X)):IF V<97 OR V>122 THEN 1460
1450    MID$(P$(Z),X)=CHR$(V-32)
1460   NEXT X
1470  X=0:LOCATE CSRLIN-1:PRINT XX$
1480 FOR CL=CSRLIN-3 TO CSRLIN-2:LOCATE CL,22:PRINT P$(Z):NEXT CL
1490 :REM'
1500    NEXT Z    :REM'********** end input loop **********
1510 :REM'
1520 ROUTE=SGN(LA(1)+LA(2))                   :REM'determine north or south route
1530 IF LA(1)<0 AND LA(2)<0 THEN ROUTE=1      :REM'A & B both in southern hemisphere
1540 :REM'
1550 :REM'.....display initial Pathfind data
1560 VIEW PRINT 3 TO 23:CLS:VIEW PRINT        :REM'erase screen
1570 LOCATE 3
1580 Z=1:GOSUB 1280
1590 PRINT TAB(8);"Path between";
1600 DOT$=STRING$(39-LEN(P$(1)),".")
1610 PRINT TAB(21);P$(1);" ";DOT$;
1620 PRINT TAB(61);USING U1$;ABS(LA(1));
1630 PRINT NS$(1);USING U1$;ABS(LO(1));
1640 PRINT EW$(1);
1650 LOCATE CSRLIN-1,44:PRINT " Solar zone UTC";USING "+##";LO(1)/15;
1660 Z=2:GOSUB 1280
1670 PRINT TAB(13);"    and";
1680 DOT$=STRING$(39-LEN(P$(2)),".")
1690 PRINT TAB(21);P$(2);" ";DOT$;
1700 PRINT TAB(61);USING U1$;ABS(LA(2));
1710 PRINT NS$(2);USING U1$;ABS(LO(2));
1720 PRINT EW$(2);
1730 LOCATE CSRLIN-1,44:PRINT " Solar zone UTC";USING "+##";LO(2)/15;
1740 GOSUB 1840                                :REM'to make B > A
1750  MERID=0                                  :REM'default value
1760  IF LO(1)=LO(2)THEN MERID=1:GOTO 1810     :REM'A & B on same meridian
1770 IF ABS(LO(1))+ABS(LO(2))<>180 THEN 1810
1780  LA(2)=180-LA(2):MERID=1                  :REM'A & B on opposite meridians
1790  IF LA(2)>180 THEN LA(2)=LA(2)-90
1800  RLA(2)=LA(2)*PI/180                      :REM'angle in radians
1810 GOSUB 3430                                :REM'calculation sub-routine
1820 GOTO 1940                                 :REM'screen print
1830 :REM'
1840 :REM'.....point B must be place of greater latitude
1850 ALA=RLA(1):BLA=RLA(2)
1860 IF(ALA=BLA)AND(RLO(1)>RLO(2))THEN 1890              :REM'both on equator
1870 IF (ALA<0)AND(BLA<0)THEN ALA=ABS(ALA):BLA=ABS(BLA)  :REM'both south of equator
1880 IF BLA>ALA THEN 1920
1890 SWAP RLA(1),RLA(2)
1900 SWAP RLO(1),RLO(2)
1910 SWAP P$(1),P$(2)
1920 RETURN
1930 :REM'
1940 :REM'.....display balance of Pathfind data
1950 IF SGN(LO(1))=SGN(LO(2))THEN 1970
1960 LONDIFF=ABS(LO(1))+ABS(LO(2)):GOTO 1980
1970 LONDIFF=ABS(LO(1)-LO(2))                  :REM'difference in longitude
1980 HR=LONDIFF
1990 ZONE=LONDIFF/15                           :REM'no. of 1 hr.time zones
2000 HR=ZONE
2002 :H=INT(HR):M=(HR-H)*60
2010 T=21
2020 IF FAR$=""THEN FAR$="n"                   :REM'default
2030 IF FAR$="n"THEN DIST=ZD*60:DIST$=" Naut.Miles":GOTO 2060
2040 IF FAR$="s"THEN DIST=ZD*24856.80078125!/360:DIST$=" Stat.Miles":GOTO 2060
2050 IF FAR$="k"THEN DIST=ZD*40000.0!/360:DIST$=" Kilometres"
2060  PRINT TAB(T);"Great Circle distance (";DIST$;" )";STRING$(4,".");" ";
2070  PRINT USING U2$;DIST;
2080  PRINT TAB(T);"Solar Time difference (hr:min)..........";
2090  PRINT USING "#######:##";H,M
2100  D1$=STRING$(27-LEN(P$(1)),".")
2110  PRINT TAB(T);"Bearing from ";P$(1);D1$;TAB(64);USING "####.##";XD;
2120  PRINT CHR$(248)
2130   D2$=STRING$(27-LEN(P$(2)),46)
2140  PRINT TAB(T);"Bearing from ";P$(2);D2$;TAB(64);USING "####.##";YD;
2150  PRINT CHR$(248)
2160 :REM'
2170 :REM'.....intermediate plots
2180 IF MERID<>1 THEN 2200
2190 IF LO(1)<>LO(2)THEN LB=PI-LB
2200 IF RLO(1)<0 THEN RLO(1)=2*PI+RLO(1)
2210 IF RLO(2)<0 THEN RLO(2)=2*PI+RLO(2)
2220 :REM'COLOR 1,0:PRINT STRING$(80,223);
2230 :REM'COLOR 0,7
2240 PRINT UL$;
2250 IPL$=" INTERMEDIATE  PLOTS "
2260 COLOR 7,0
2270 PRINT " To ";P$(1);
2280 PRINT TAB((80-LEN(IPL$))/2);IPL$;
2290 T=80-3-LEN(P$(2))
2300 PRINT TAB(T);"To ";P$(2);
2310 PRINT "  └─«";TAB(6);DIST$;
2320 PRINT TAB(18);"«─ Bearing";
2330 PRINT TAB(29);"«─ ┌── From Plot ──┐ ─»";
2340 PRINT TAB(53);"Bearing ─»";
2350 PRINT TAB(63);DIST$;TAB(76);"»─┘"
2360 PRINT UL$;
2370 :REM'
2380 :REM'.....loop for intermediate plots
2390 NP=11                                      :REM'no. of plots
2400 IF ZR<PI/200 THEN 3280                     :REM'A & B closer than 100 Km apart
2410 D=NP+1                                     :REM'no.of segments
2420 DS=(ZR/D)                                  :REM'interval distance angle
2430 HOLD=N                                     :REM'hold N=no. of locations on file
2440 FIRST=RLO(1)                               :REM'longitude of start plot
2450 :REM'
2460 FOR N=NP TO 1 STEP-1 :REM'******************START LOOP********************
2470 :REM'
2480 :REM'.....find latitude of plot
2490 REM                                         LA=latitude of FIRST
2500 REM                                         X=bearing FIRST
2510 DA=DS*N                                    :REM'segment distance angle
2520 SEG=N/D*DIST                               :REM'segment distance
2530 IF ROUTE<>0 THEN DA=DA*ROUTE               :REM'route can be north or south
2540 IF EQUAT THEN LAP=PI/2:PLAP=PI/2:PLA=0:GOTO 2620
2550 IF MERID THEN PLA=LA+DA:GOTO 2650
2560 LAP=PI/2-LA                                :REM'angle between LA & pole
2570 A=COS(LAP)*COS(DA)+SIN(LAP)*SIN(DA)*COS(X) :REM'law of cosines for sides
2580 ANGL=ATN(A/SQR(-A*A+1))                    :REM'angle between plot & pole
2590 PLAP=ABS(ANGL-PI/2)
2600 PLA=PI/2-PLAP                              :REM'latitude of plot
2610 :REM'
2620 :REM'.....find longitude of plot
2630 B=(COS(DA)-COS(PLAP)*COS(LAP))/SIN(PLAP)/SIN(LAP) :REM'law of cosines for sides
2640 NOTE=0:IF ABS(B)>=1 THEN B=0.9999998807907104!:BEEP:NOTE=1   :REM'round-off inaccuracy
2650 IF MERID THEN PLO=FIRST:PLOD=0:GOTO 2780
2660 PLOD=ATN(B/SQR(-B*B+1))+PI/2               :REM'difference in longitude
2670 :REM'
2680 IF PLOD<PI/2 THEN PLOD=PI/2-PLOD+PI/2:GOTO 2710
2690 IF PLOD>PI/2 THEN PLOD=PI-PLOD
2700 :REM'
2710 IF RLO(2)-FIRST>PI THEN RLO(2)=RLO(2)-2*PI :REM'path crossing 0° meridian
2720 IF FIRST-RLO(2)>PI THEN RLO(2)=RLO(2)+2*PI
2730 IF FIRST<RLO(2)THEN PLO=FIRST+PLOD
2740 IF FIRST>RLO(2)THEN PLO=FIRST-PLOD
2750 IF PLO<0 THEN PLO=PLO+2*PI
2760 IF PLO>2*PI THEN PLO=PLO-2*PI
2770 :REM'
2780 PLAN=PLA
2790 IF MERID <>1 THEN 2820
2800   IF PLAN>PI/2 THEN PLAN=PI-PLAN:PLO=PLO+PI
2810   IF PLAN<-PI/2 THEN PLAN=PI+PLAN:PLO=PLO+PI
2820 PLON=PLO                                   :REM'location for printout
2830 IF PLON>PI THEN PLON=2*PI-PLON
2840 RLA(2)=PLA:RLO(2)=PLO                      :REM'new start point
2850 GOSUB 3430     :REM'calculate bearings
2860 :REM'
2870 :REM'.....display plot headings & distance
2880 REM                                         Y=bearing to P$(1)
2890 YR=Y+PI                                    :REM'reciprocal heading to P$(2)
2900 IF YR>2*PI THEN YR=YR-2*PI
2910 IF FAR$="n"THEN D1=NM:D2=DIST-D1           :REM'distance - nautical miles
2920 IF FAR$="s"THEN D1=SM:D2=DIST-D1           :REM'distance - statute miles
2930 IF FAR$="k"THEN D1=KM:D2=DIST-D1           :REM'distance - kilometres
2940 :REM'
2950 :REM'.....display plots
2960 N$=STR$(NP-N+1):IF LEN(N$)=2 THEN N$=" "+N$
2970 N$=RIGHT$(N$,2)
2980 E$=CHR$(248)                                           :REM'° degree symbol
2990 :REM'
3000 PRINT " ";N$;                                          :REM'plot no.
3010 PRINT TAB(7);                                          :REM'set margin
3020 PRINT USING U4$;ABS(SEG);:PRINT "  ";                  :REM'distance
3030 E$=CHR$(248)                                           :REM'° degree symbol
3040 PRINT USING U1$;Y*180/PI;:PRINT E$;                    :REM'bearing
3050 PRINT "  «─";                                          :REM'left arrow
3060 IF PLAN<0 THEN NS$=E$+"S":ELSE NS$=E$+"N"
3070 COLOR 0,7
3080 PRINT USING U3$;ABS(PLAN*180/PI);:PRINT NS$;           :REM'latitude
3090 IF PLO>PI AND PLO<2*PI THEN EW$=E$+"W":ELSE EW$=E$+"E"
3100 PRINT USING U1$;ABS(PLON)*180/PI;:PRINT EW$;"  ";      :REM'longitude
3110 COLOR 7,0
3120 PRINT "─»";                                            :REM'right arrow
3130 RY=YR*180/PI:IF CINT(RY)=360 THEN RY=0
3140 PRINT USING U1$;RY;:PRINT E$;"  ";                     :REM'bearing
3150 PRINT USING U4$;ABS(DIST-SEG);:PRINT " ";              :REM'distance
3160 IF N=3 OR N=9 THEN COLOR 0,7:PRINT "1/4 way";
3170 IF N=4 OR N=8 THEN COLOR 0,7:PRINT "1/3 way";
3180 IF N=6 THEN COLOR 0,7:PRINT "1/2 way";
3190 COLOR 7,0
3200 PRINT ""                                               :REM'end of line
3210 :REM'
3220    NEXT N         :REM'******************END LOOP*********************
3230 IF NOTE THEN 3250
3240 PRINT UL$;
3250 N=HOLD                   :REM'N=no. of locations on file
3260 GOTO 3340
3270 :REM'
3280 :REM'.....A & B very close together
3290 COLOR 14,12
3300 PRINT "     Intermediate plots are redundant for locations less than 100 ";
3310 PRINT "km. apart"
3320 COLOR 7,0
3330 :REM'
3340 IF NOTE=0 THEN 3390
3350 COLOR 14,12
3360 PRINT "  SOME PLOT BEARINGS MAY BE INACCURATE DUE TO CALCULATION ";
3370 PRINT "ROUNDING-OFF ERRORS";
3380 COLOR 7,0
3390 GOSUB 7270:GOTO 6980                     :REM'screen dump/exit option
3400 :REM'
3410 :REM'**********SUB-ROUTINES**********
3420 :REM'
3430 :REM'.....calculate bearings and distance
3440 REM RLA(n) & RLO(n) are LAT & LONG inputs in radians
3450 LB=RLA(2)                               :REM'latitude of point B in radians
3460 LA=RLA(1)                               :REM'latitude of point A in radians
3470 IF LA=0 AND LB=0 THEN 3660              :REM'both points on equator
3480 C=RLO(1)-RLO(2)                         :REM'difference in longitude
3490 IF C=0 THEN 3530                        :REM'both points on same meridian
3500 IF ABS(C)=PI THEN 3590                  :REM'points on opposite meridian
3510 GOTO 3750
3520 :REM'
3530 :REM'.....A & B both on same meridian
3540 ZR=LB-LA:ZD=ZR*180/PI
3550 Y=PI:YD=180
3560 X=0:XD=0
3570 RETURN
3580 :REM'
3590 :REM'.....A & B on opposite meridians
3600 ZR=LB-LA:IF ZR>PI THEN ZR=2*PI-ZR
3610 IF ZR<PI THEN Y=0:YD=0:X=0:XD=0
3620 IF ZR>PI THEN Y=PI:YD=180:X=PI:XD=180
3630 ZD=ZR*180/PI
3640 RETURN
3650 :REM'
3660 :REM'.....A & B both on equator
3670 EQUAT=1                                 :REM'flag
3680 Y=PI/2:YD=Y*180/PI
3690 X=1.5!*PI:XD=X*180/PI
3700 L=ABS(RLO(1)-RLO(2))
3710 IF L>PI THEN L=2*PI-L
3720 ZR=L:ZD=ZR*180/PI
3730 GOTO 3910
3740 :REM'
3750 :REM'.....formula elements
3760 F0=1/TAN(C/2)                           :REM'cotangent C/2
3770 F1=F0*SIN((LB-LA)/2)/COS((LB+LA)/2)
3780 IF LB+LA=0 THEN F2=F0*COS((LB-LA)/2)/SIN(1.0000000116860974e-07!):GOTO 3800
3790 F2=F0*COS((LB-LA)/2)/SIN((LB+LA)/2)
3800 F3=ATN(F1)
3810 F4=ATN(F2)
3820 :REM'
3830 :REM'.....bearings
3840 Y=F4+F3                                 :REM'bearing at point B
3850 IF LA<0 AND LB<0 THEN Y=Y+PI:GOTO 3870  :REM'A & B both in southern hemisphere
3860 IF ABS(LA)>ABS(LB)THEN Y=Y+PI
3870 IF Y<0 THEN Y=Y+2*PI
3880 IF Y>=(2*PI)THEN Y=Y-2*PI
3890 YD=Y*180/PI                             :REM'bearing in degrees at point B
3900 :REM'
3910 X=F4-F3                                 :REM'bearing at point A
3920 IF LA<0 AND LB<0 THEN X=X+PI:GOTO 3940  :REM'A & B both in southern hemisphere
3930 IF ABS(LA)>ABS(LB)THEN X=X+PI
3940 IF X<0 THEN X=X+2*PI
3950 IF X>=(2*PI)THEN X=X-2*PI
3960 XR=2*PI-X                               :REM'reciprocal
3970 IF XR<0 THEN XR=XR+2*PI
3980 IF XR>=(2*PI)THEN XR=XR-2*PI
3990 XD=XR*180/PI                            :REM'bearing in degrees at point A
4000 :REM'
4010 :REM'.....distance
4020 IF RLO(1)=RLO(2)THEN ZR=ABS(LB-LA):GOTO 4060
4030 IF LA=LB THEN LB=LB+1.0000000116860974e-07!:GOTO 3480  :REM'avoids trig function of angle 0
4040 F5=TAN((LB-LA)/2)*SIN(F4)/SIN(F3)       :REM'F5=tan ZR/2 (ZR=distance angle)
4050 ZR=ABS(2*ATN(F5))                       :REM'distance angle in radians
4060 ZD=ZR*180/PI                            :REM'distance angle in degrees
4070 :REM'
4080 RETURN
4090 :REM'
4100 :REM'.....LATLONG - 20 NOV 85 rev. 12 FEB 94
4110 CLS
4120 IF FAR$<>""THEN 5410
4130 COLOR 15,2
4140 PRINT " LATITUDE & LONGITUDE Data Base";TAB(57);"by George Murphy VE3ERP ";
4150 COLOR 1,0:PRINT STRING$(80,223);
4160 COLOR 7,0
4170 PRINT " Press number in < > to:"
4180 PRINT UL$;
4190 PRINT "  < 1 >  ADD a listing"
4200 PRINT "  < 2 >  FIND or EDIT a listing"
4210 PRINT "  < 3 >  DISPLAY listings"
4220 PRINT UL$;
4230 PRINT "  < 0 >  EXIT"
4240 Z$=INKEY$
4250 IF Z$="1"THEN CLS:GOTO 4600
4260 IF Z$="2"THEN CLS:GOTO 5410
4270 IF Z$="3"THEN CLS:GOSUB 4740:GOTO 5000
4280 IF Z$="0"THEN 430
4290 GOTO 4240
4300 :REM'
4310 :REM'.....save data
4320 PRINT " SAVING DATA to DISK"
4330 OPEN "O",1,"\hamcalc\latlong\LATLONG.DAT"
4340 FOR Z=1 TO N
4350 WRITE# 1,A$(Z,1),A$(Z,2),A$(Z,3),A$(Z,4)
4360 NEXT Z
4370 CLOSE
4380 GOTO 4110
4390 :REM'
4400 :REM'.....change text to capital letters
4410 FOR U=1 TO LEN(I$)
4420 V=ASC(MID$(I$,U,1))
4430 IF V>96 AND V<123 THEN MID$(I$,U,1)=CHR$(V-32)
4440 NEXT U
4450 RETURN
4460 :REM'.....inputs
4470 INPUT " ENTER: City or town...................";I$:GOSUB 4400
4480 GOSUB 4560:RETURN
4490 INPUT " ENTER: Province, State or Country.....";I$:GOSUB 4400
4500 GOSUB 4560:RETURN
4510 INPUT " ENTER: Latitude (minus if South)......";I$
4520 GOSUB 4560:RETURN
4530 INPUT " ENTER: Longitude (minus if West)......";I$
4540 GOSUB 4560:RETURN
4550 :REM'
4560 LOCATE CSRLIN-1:PRINT STRING$(6,32)
4570 LOCATE CSRLIN-1,39:PRINT "  ";I$;"   "
4580 RETURN
4590 :REM'
4600 :REM'.....new listing
4610 N=N+1
4620 PRINT " NEW LISTING"
4630 PRINT UL$;
4640 FOR Z=1 TO 4
4650 ONZ GOSUB 4470,4490,4510,4530
4660 A$(N,Z)=I$
4670 NEXT Z
4680 CLS
4690 Z=N
4700 IF LEN(A$(N,1))+LEN(A$(N,2))<21 THEN 6610
4710 BEEP:PRINT:PRINT " TOO LONG! Please abbreviate one or both names"
4720 PRINT:GOTO 6610
4730 :REM'
4740 :REM'.....compile
4750 IF A$(1,1)<>""THEN 4840
4760 FOR Y=1 TO N
4770 FOR X=1 TO 4
4780 A$(Y,X)=A$(Y+1,X)
4790 NEXT X
4800 NEXT Y
4810 N=N-1
4820 GOTO 4750
4830 :REM'
4840 :REM'.....sort
4850 SN=N:SM=SN:PRINT " SORTING at level.....";
4860 SM=INT(SM/2):IF SM=0 THEN CLS:GOTO 4980
4870 LOCATE 1,20:PRINT USING "####";SM*2
4880 SK=SN-SM:SJ=1
4890 SI=SJ
4900 SL=SI+SM
4910 IF A$(SI,1)<=A$(SL,1)THEN 4960
4920 FOR X=1 TO 4
4930 SWAP A$(SI,X),A$(SL,X)
4940 NEXT X
4950 SI=SI-SM:IF SI>0 THEN 4900
4960 SJ=SJ+1:IF SJ>SK THEN 4860
4970 GOTO 4890
4980 RETURN
4990 :REM'
5000 :REM'.....screen display
5010 CLS
5020 LIN=0            :REM'line no.
5030 :REM'
5040 FOR Z=1 TO N STEP 2
5050 LIN=LIN+1
5060 IF LIN=1 THEN LOCATE 1
5070 GOSUB 5260                              :REM'determine NEWS suffix
5080 PRINT USING U5$;ABS(Z1);:PRINT Z1$;" ";
5090 PRINT USING U5$;ABS(Z2);:PRINT Z2$;"  ";A$(Z,1);
5100 IF A$(Z,2)=""THEN 5110 :ELSE PRINT ", ";A$(Z,2);
5110 IF A$(Z+1,1)=""THEN 5170
5120 PRINT TAB(41);USING U5$;ABS(Z3);:PRINT Z3$;" ";
5130 PRINT USING U5$;ABS(Z4);:PRINT Z4$;"  ";A$(Z+1,1);
5140 IF A$(Z+1,2)=""THEN 5150 :ELSE PRINT ", ";A$(Z+1,2);
5150 IF LIN<24 THEN PRINT "":GOTO 5170
5160 GOSUB 7270:LIN=0:CLS
5170 NEXT Z
5180 :REM'
5190 IF LIN>21 THEN GOSUB 7270:GOTO 5200 :ELSE 5210
5200 CLS
5210 PRINT UL$;
5220 PRINT N;"listings as of ";DATE$
5230 GOSUB 7270
5240 COLOR 7,0:CLS:GOTO 4310  :REM'save data
5250 :REM'
5260 :REM'.....determine NSEW suffix
5270 E$=CHR$(248)
5280 Z1=VAL(A$(Z,3)):IF Z1<0 THEN Z1$=E$+"S":ELSE Z1$=E$+"N"
5290 Z2=VAL(A$(Z,4)):IF Z2<0 THEN Z2$=E$+"W":ELSE Z2$=E$+"E"
5300 Z3=VAL(A$(Z+1,3)):IF Z3<0 THEN Z3$=E$+"S":ELSE Z3$=E$+"N"
5310 Z4=VAL(A$(Z+1,4)):IF Z4<0 THEN Z4$=E$+"W":ELSE Z4$=E$+"E"
5320 RETURN
5330 :REM'
5340 :REM'.....menu return
5350 :REM'CLS
5360 PRINT:PRINT " Nothing starting with ";I$;" on file...."
5370 PRINT:PRINT " Press SPACE BAR to return to Menu"
5380 Z$=INKEY$:IF Z$=" "THEN CLS:GOTO 4140
5390 GOTO 5380
5400 :REM'
5410 :REM'.....find location
5420 LOCATE 1
5430 PRINT " Press number in ( ) to enter what you know about sought location:"
5440 PRINT UL$;
5450 PRINT " (1) City, Town, Province, State or Country"
5460 PRINT " (2) Latitude and Longitude"
5470 Z$=INKEY$
5480 IF Z$="1"THEN CLS:GOTO 5830
5490 IF Z$="2"THEN CLS:GOTO 5520
5500 GOTO 5470
5510 :REM'
5520 :REM'.....find latitude & longitude
5530 GOSUB 4510:LA$=I$:GOSUB 4530:LO$=I$
5540 LAT=VAL(LA$):LON=VAL(LO$)         :REM'sought co-ordinates
5550 CLS:LOCATE 24,18
5560 PRINT " SEARCHING for Latitude ";USING "+##.#";LAT;
5570 PRINT ", Longitude ";USING "+###.#";LON
5580 D=PI   :REM'distance angle
5590 A=VAL(LA$)*PI/180
5600 L1=VAL(LO$)*PI/180
5610 FOR X=1 TO N
5620  B=VAL(A$(X,3)):L2=VAL(A$(X,4))
5630  IF A=B AND L1=L2 THEN 5520
5640  B=B*PI/180:L2=L2*PI/180
5650  Z=SIN(A)*SIN(B)+COS(A)*COS(B)*COS(ABS(L1-L2))
5660 IF Z>=1 THEN  Z=0.9999998807907104!
5670  GOSUB 6910
5680  IF RC<D THEN D=RC:LL=X
5690 NEXT X
5700 :REM'
5710 CLS:Z=LL
5720 IF LAT>0 THEN LAT$=E$+"N":ELSE LAT$=E$+"S"
5730 IF LON>0 THEN LON$=E$+"E":ELSE LON$=E$+"W"
5740 DIST=D*180/PI*40000.0!/360:D$="kilometres"
5750 DIST=INT(DIST*10+0.5!)/10             :REM'round-off to 1 decimal place
5760 PRINT " Target location is ";USING U1$;ABS(LAT);:PRINT LAT$;",";
5770 PRINT USING U2$;ABS(LON);:PRINT LON$
5780 IF DIST=0 THEN 5800
5790 PRINT " Nearest location on file,";DIST;D$;" from target location, is:"
5800 PRINT UL$;
5810 GOSUB 6410:GOTO 6240
5820 :REM'
5830 :REM'.....find name
5840 LOCATE 1
5850 INPUT" ENTER first few characters of Town, State, Country, Prefix, etc.";I$
5860 GOSUB 4400         :REM'capitalize
5870 CLS
5880 LOCATE 24,35:PRINT " SEARCHING...";
5890 LOCATE 1
5900 L=LEN(I$):F=0
5910 FOR Z=1 TO N
5920 FOR Y=1 TO 2:IF LEFT$(A$(Z,Y),L)<>I$ THEN 6000
5930 F=F+1
5940 F$(F,2)=STR$(Z)
5950 F$(F,1)=A$(Z,1)
5960 IF A$(Z,2)<>""THEN F$(F,1)=F$(F,1)+", "+A$(Z,2)
5970 IF F$(F,1)+F$(F,2)=F$(F-1,1)+F$(F-1,2)THEN F=F-1:GOTO 6010
5980 IF F<27 THEN 6000
5990 CLS:PRINT" LONG LIST - Please enter more letters !":GOTO 5850
6000 NEXT Y
6010 NEXT Z:IF F=0 THEN 5340
6020 CLS:IF F=1 THEN Z=VAL(F$(F,2)):GOTO 6230
6030 :REM'
6040 PRINT " Location names starting with ";
6050 COLOR 0,7:PRINT " ";I$;" ":COLOR 7,0
6060 PRINT UL$;
6070 CF=CINT(F/2)
6080 FOR Z=1 TO CINT(F/2)
6090 PRINT " (";CHR$(96+Z);")  ";F$(Z,1);TAB(41);
6100 PRINT "(";CHR$(96+CF+Z);")  ";F$(Z+CF,1)
6110 NEXT Z
6120 IF F/2<>INT(F/2)THEN LOCATE CSRLIN-1,41:PRINT STRING$(39,32)
6130 PRINT UL$;
6140 LIN=CSRLIN
6150 PRINT " Press letter in ( ) to select listing or <0> to return to menu"
6160 Z$=INKEY$:IF Z$=""THEN 6160
6170 IF Z$="0"THEN 4110
6180 Z=ASC(Z$)-96
6190 IF Z>=1 AND Z<=F THEN Y=Z:Z=VAL(F$(Y,2)):CLS:GOTO 6230
6200 GOTO 6160
6210 :REM'
6220 :REM'.....display listing
6230 GOSUB 6410
6240 PRINT " Press number in ( ) for next step:":PRINT UL$;
6250 IF FAR$=""THEN 6280
6260 PRINT " (1) SELECT this listing for Great Circle calculation"
6270 IF FAR$<>""THEN 6300
6280 PRINT " (2) EDIT Listing"
6290 PRINT " (3) DELETE Listing"
6300 PRINT UL$;
6310 PRINT " (0) RETURN to menu"
6320 Z$=INKEY$
6330 IF FAR$=""THEN 6360
6340 IF Z$="1"THEN CLS:GOTO 6530
6350 IF FAR$<>""THEN 6380
6360 IF Z$="2"THEN CLS:GOTO 6610
6370 IF Z$="3"THEN BEEP:PRINT:GOTO 6780
6380 IF Z$="0"THEN 4110
6390 GOTO 6320
6400 :REM'
6410 PRINT" line 1: ";A$(Z,1)
6420 PRINT" line 2: ";A$(Z,2)
6430 B=VAL(A$(Z,3)):IF B<0 THEN B$=E$+"S":ELSE B$=E$+"N"
6440 PRINT" line 3: ";
6450 PRINT"Lat  ";USING "###.###";ABS(B);:PRINT B$
6460 PRINT" line 4: ";
6470 B=VAL(A$(Z,4)):IF B<0 THEN B$=E$+"W":ELSE B$=E$+"E"
6480 PRINT"Long ";USING "###.###";ABS(B);:PRINT B$
6490 PRINT"         Solar Time Zone UTC";USING "+##";B/15
6500 PRINT UL$;
6510 RETURN
6520 :REM'
6530 :REM'.....assign variables for Great Circle calculations
6540 P$(POSN)=A$(Z,1)
6550 IF A$(Z,2)<>""THEN P$(POSN)=P$(POSN)+", "+A$(Z,2)
6560 LA(POSN)=VAL(A$(Z,3))
6570 LO(POSN)=VAL(A$(Z,4))
6580 GOTO 10
6590 :REM'
6600 :REM'.....change listing
6610 GOSUB 6410:PRINT " Press number in ( ) to change listing:":PRINT UL$;
6620 FOR Y=1 TO 4:PRINT " (";Y;")  Change Line";Y:NEXT Y
6630 PRINT " ( 5 )  O.K. as is"
6640 Z$=INKEY$:Q=VAL(Z$):IF Q<1 OR Q>5 THEN 6750
6650 IF Z$="1"THEN GOSUB 4470:A$(Z,1)=I$:GOSUB 6710:CLS:GOTO 6610
6660 IF Z$="2"THEN GOSUB 4490:A$(Z,2)=I$:GOSUB 6710:CLS:GOTO 6610
6670 IF Z$="3"THEN GOSUB 4510:A$(Z,3)=I$:CLS:GOTO 6610
6680 IF Z$="4"THEN GOSUB 4530:A$(Z,4)=I$:CLS:GOTO 6610
6690 IF Z$="5"THEN CLS:GOTO 4310
6700 :REM'
6710 IF LEN(A$(Z,1))+LEN(A$(Z,2))<21 THEN 6760
6720 BEEP:PRINT " TOO LONG! Please abbreviate lines 1 and/or 2...."
6730 PRINT " Press any key to continue.........."
6740 IF INKEY$=""THEN 6740 :ELSE CLS:GOTO 6600
6750 GOTO 6640
6760 RETURN
6770 :REM'
6780 :REM'.....delete listing
6790 BEEP:COLOR 0,7
6800 PRINT " Are you SURE you want to delete this file?   (y/n) "
6810 COLOR 7,0
6820 Z$=INKEY$
6830 IF Z$="y"THEN 6860
6840 IF Z$="n"THEN CLS:GOTO 6220
6850 GOTO 6820
6860 CLS:PRINT " LISTING DELETED. File being re-sorted.....please wait...."
6870 FOR X=Z TO N:LOCATE 12,39:PRINT N-X
6880 FOR Y=1 TO 4
6890 A$(X,Y)=A$(X+1,Y):NEXT Y:NEXT X:N=N-1:GOTO 4310   :REM'save data
6900 :REM'
6910 :REM'.....ACS, ASN                  'GOSUB HERE TO GET ASN/ACS
6920 IF Z=0 THEN RC=PI/2:GOTO 6950   :REM'Z=VALUE FROM PROGRAM
6930 IF Z=1 THEN RC=0:GOTO 6950
6940 RC=-ATN(Z/SQR(1-Z^2))+PI/2      :REM'RC=ANGLE IN RADIANS IF Z=COS
6950 RS=PI/2-RC                      :REM'RS=ANGLE IN RADIANS IF Z=SIN
6960 RETURN
6970 :REM'
6980 :REM'....clear memories
6990 FOR M=1 TO 2
7000 P$(M)="":LA(M)=0:LO(M)=0
7010 NEXT M
7020 POSN=0:FAR$=""
7030 Z$="":QX=0:QY=0:FF=0
7040 GOTO 430
7050 :REM'
7060 :REM'.....preface
7070 T=7
7080 PRINT TAB(T);
7090 PRINT "This program calculates Great Circle paths, bearings and distances"
7100 PRINT TAB(T);
7110 PRINT "between any two points on earth, including those on or very close"
7120 PRINT TAB(T);
7130 PRINT "to the same meridian, the equator, or the earth's poles. Several"
7140 PRINT TAB(T);
7150 PRINT "intermediate points are also calculated as an aid in plotting the"
7160 PRINT TAB(T);
7170 PRINT "path on a flat chart or map drawn in any projection. Solar time"
7180 PRINT TAB(T);
7190 PRINT "difference between the two end points is also shown."
7200 PRINT
7210 PRINT TAB(T);
7220 PRINT "Also included is a data base of over 500 locations that can be"
7230 PRINT TAB(T);
7240 PRINT "inserted into the program, and which can be edited by the user."
7250 RETURN
7260 :REM'
7270 :REM'PRT
7280 KEY OFF:GOSUB 7350:LOCATE 25,5:COLOR 0,2
7290 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
7300 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
7310 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 7310 :ELSE GOSUB 7350
7320 IF Z$="3"THEN RETURN
7330 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
7340 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 7280
7350 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
