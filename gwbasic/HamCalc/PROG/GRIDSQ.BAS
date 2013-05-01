10 :REM'GRIDSQ - Grid Square Locator - 16 MAR 97 rev. 30 APR 1998
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="gridsq"
40 COMMON PROG$,DMS,EX$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 PI=3.1415929794311523!
80 DIM M$(12)
90 DATA JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC
100 FOR Z=1 TO 12:READ M$(Z):NEXT Z
110 FOR Z=1 TO 12:IF VAL(LEFT$(DATE$,2))=Z THEN 120 :ELSE NEXT Z
120 D$=MID$(DATE$,4,2)+" "+M$(Z)+" "+RIGHT$(DATE$,4)
130 GOTO 190
140 :REM'
150 :REM'.....clear to bottom of screen
160 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
170 RETURN
180 :REM'
190 :REM'.....start
200 CLS:COLOR 15,2
210 PRINT " GRID SQUARE LOCATOR (Maidenhead)";
220 PRINT TAB(56)"by Dr.Thomas Clark W3IWI ";
230 PRINT STRING$(80,32);
240 LOCATE CSRLIN-1,12
250 PRINT " edited and enhanced for HAMCALC by George Murphy VE3ERP"
260 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
270 GOSUB 4580
280 COLOR 0,7
290 LOCATE 24,10
300 PRINT " Do you want to run the EQUIVALENT VALUES program now?  (y/n) ";
310 COLOR 7,0
320 Z$=INKEY$:IF Z$=""THEN 320
330 IF Z$="n"THEN LOCATE 24,1:PRINT STRING$(79,32);:GOTO 360
340 IF Z$="y"THEN CLS:DMS=1:CHAIN"equiv"
350 GOTO 320
360 COLOR 0,7:LOCATE 25,13
370 PRINT " Press 1 to continue, 2 for world chart, or 0 to EXIT...";:COLOR 7,0
380 Z$=INKEY$:IF Z$=""THEN 380
390 IF Z$="0"THEN CLS:RUN EX$
400 IF Z$="1"THEN CLS:GOTO 450
410 IF Z$="2"THEN CLS:GOTO 5030
420 GOTO 380
430 LN=4:GOSUB 150
440 :REM'
450 :REM'.....initial entries
460 COLOR 0,7:LOCATE ,30:PRINT " GRID SQUARE LOCATIONS ";:COLOR 7,0
470 PRINT TAB(62)D$
480 :REM'
490 :REM'.....initialize constants:
500 E9=10^-6:D=0
510 GOSUB 1430
520 :REM'
530 :REM'.....loop back here for subsequent entries
540 D=D+1   :REM'counter
550 IF D>1 THEN 600
560 PRINT
570 COLOR 0,7:PRINT " Home QTH ":COLOR 7,0
580 GOTO 950
590 :REM'
600 COLOR 0,7
610 PRINT " Choose:  Away QTH (c)oordinates, Away QTH (g)rid, or (q)uit?     ";
620 PRINT "(c/g/q) "
630 COLOR 7,0
640 T$=INKEY$:IF T$=""THEN 640
650 IF T$="c"OR T$="g" OR T$="q"THEN LN=CSRLIN-1:GOSUB 150
660 IF T$="c" THEN 930
670 IF T$="g" THEN 710
680 IF T$="q" THEN 5680
690 GOTO 640
700 :REM'
710 :REM'.....coordinates for given grid square
720 COLOR 0,7:PRINT " Away QTH #";D-1;" ":COLOR 7,0
730 INPUT "  ENTER: Grid square code (enter 2, 4, or all 6 characters)";G$
740 LN=CSRLIN-2
750 GOSUB 1540:IF L3=6 THEN 800 :ELSE BEEP
760 TIM=TIMER:COLOR 0,7
770 PRINT " Grid square has been padded to middle of cell, i.e. ";G$;" "
780 COLOR 7,0:PRINT TAB(20)"Please wait......."
790 IF TIMER<TIM+2.5! THEN 790
800 GOSUB 1790:GOSUB 1840
810 GOSUB 150
820 SG=SGN(LON)
830 IF ABS(LON)>180 THEN LON=(360-ABS(LON))*SG
840 IF SGN(LAT)=-1 THEN L$="S":ELSE L$="N"
850 IF SGN(LON)=-1 THEN W$="W":ELSE W$="E"
860 PRINT " ";STR$(D-1);") ";G$;" =";USING "###.#°";ABS(LAT);
870 PRINT L$;USING "####.#°";ABS(LON);:PRINT W$;
880 PRINT ", DX=";:GOTO 1230
890 :REM'
900 :REM'.....invalid entry
910 BEEP:LOCATE CSRLIN-1:PRINT STRING$(80,32);:RETURN
920 :REM'
930 COLOR 0,7:PRINT " Away QTH #";D-1;" ":COLOR 7,0
940 :REM'
950 INPUT " ENTER: Latitude in decimal degrees (+° if North, -° if South)";T
960 IF ABS(T)>90 THEN GOSUB 900:LOCATE CSRLIN-1:GOTO 950
970 IF T<>0 OR D>1 THEN LAT=T
980 :REM'
990 INPUT " ENTER: Longitude in decimal degrees  (+° if East, -° if West)";T
1000 IF ABS(T)>180 THEN GOSUB 900:LOCATE CSRLIN-1:GOTO 990
1010 IF T<>0 OR D>1 THEN LON=T
1020 :REM'
1030 LN=CSRLIN-2:GOSUB 150
1040 IF D>1 THEN LOCATE CSRLIN-1
1050 GOSUB 1440
1060 IF SGN(LAT)=-1 THEN L$="S":ELSE L$="N"
1070 IF SGN(LON)=-1 THEN W$="W":ELSE W$="E"
1080 IF D=1 THEN PRINT SPC(5);::ELSE PRINT " ";STR$(D-1);") ";
1090 PRINT G$;" =";USING "###.#°";ABS(LAT);
1100 PRINT L$;USING "####.#°";ABS(LON);:PRINT W$;
1110 IF D>1 THEN PRINT ", DX=";:GOTO 1230 :ELSE PRINT ""
1120 LN=CSRLIN:LOCATE 2,62:PRINT "┌── SUN ──┐"
1130 LOCATE 2,27:PRINT "(« = yesterday, » = tomorrow)─────>"
1140 LOCATE 3,60:PRINT "Rise  UTC   Set"
1150 LOCATE LN:PRINT STRING$(80,205);
1160 COLOR 0,7
1170 LOCATE LN:COLOR 0,7:PRINT " Away QTH "
1180 COLOR 7,0
1190 :REM'LOCATE LN,33:PRINT " ⌐ Distance & Beam Hdg.¬ "
1200 LIN=4:L=LAT:W=LON:GOSUB 2880:LOCATE LN+1   :REM'get rise/set times
1210 GOTO 1310
1220 :REM'
1230 IF D=2 THEN LOCATE 5,33:PRINT " ⌐ Distance & Beam Hdg.¬ ":LOCATE 6,34
1240 LA(2)=LAT:LO(2)=LON
1250 GOSUB 1890
1260 IF A=0 THEN A=360
1270 PRINT USING "##### ";RX;:PRINT UU$;USING " @ ###°";A
1280 LIN=CSRLIN-1:L=LAT:W=LON:GOSUB 2880
1290 GOTO 530
1300 :REM'
1310 LA(1)=LAT:LO(1)=LON
1320 COLOR 0,7
1330 PRINT " Choose: DX in (k)ilometers, (s)tatute miles or (n)autical ";
1340 PRINT "miles?   (k/s/n) ":COLOR 7,0
1350 U$=INKEY$:IF U$="" THEN 1350
1360 IF U$="k"OR U$="s"OR U$="n"THEN 1370 :ELSE 1350
1370 IF U$="k"THEN UU$="kilometres":GOTO 1410
1380 IF U$="s"THEN UU$="stat.miles":GOTO 1410
1390 IF U$="n"THEN UU$="naut.miles":GOTO 1410
1400 GOTO 1350
1410 LN=CSRLIN-1:GOSUB 150:GOTO 530
1420 :REM'
1430 :REM'.....grid Square from latitude and longitude
1440 W3=180+LON
1450  W1=INT(W3/20+E9)
1460  W2=INT((W3-20*W1)/2+E9)+48:W1=W1+65
1470  W3=INT(24*(W3/2-INT(W3/2)+E9))+65
1480  L1=INT((LAT+90)/10+E9):L2=INT(LAT+90+E9-10*L1)
1490  L3=INT((LAT+90-10*L1-L2)*24+E9):L1=L1+65:L2=L2+48:L3=L3+65
1500 G$=CHR$(W1)+CHR$(L1)+CHR$(W2)+CHR$(L2)+CHR$(W3)+CHR$(L3)
1510 RETURN
1520 :REM'
1530 :REM'.....pad grid square if not all 6 characters are given (centre is 55LL)
1540 L3=LEN(G$):IF L3>6 THEN 1740
1550 IF L3=6 THEN 1590
1560 IF L3<4 THEN 1570 :ELSE G$=MID$(G$,1,4)+"LL":GOTO 1590
1570 IF L3<2 THEN 1740 :ELSE G$=MID$(G$,1,2)+"55LL"
1580 :REM'
1590 :REM'.....Convert 1st 2 characters to upper case, last 2 to upper case
1600 Z=ASC(MID$(G$,1,1)):IF Z>96 THEN MID$(G$,1,1)=CHR$(Z-32)
1610 Z=ASC(MID$(G$,2,1)):IF Z>96 THEN MID$(G$,2,1)=CHR$(Z-32)
1620 Z=ASC(MID$(G$,5,1)):IF Z>96 THEN MID$(G$,5,1)=CHR$(Z-32)
1630 Z=ASC(MID$(G$,6,1)):IF Z>96 THEN MID$(G$,6,1)=CHR$(Z-32)
1640 :REM'
1650 :REM'.....check for valid range of characters
1660 T$=MID$(G$,1,1):IF T$<"A"OR T$>"R" THEN 1740
1670 T$=MID$(G$,2,1):IF T$<"A"OR T$>"S" THEN 1740
1680 T$=MID$(G$,3,1):IF T$<"0"OR T$>"9" THEN 1740
1690 T$=MID$(G$,4,1):IF T$<"0"OR T$>"9" THEN 1740
1700 T$=MID$(G$,5,1):IF T$<"A"OR T$>"X" THEN 1740
1710 T$=MID$(G$,6,1):IF T$<"A"OR T$>"X" THEN 1740
1720 RETURN
1730 :REM'
1740 BEEP:COLOR 0,7:PRINT " ";G$;" IS AN INVALID GRID SQUARE ";
1750 PRINT ".....Press any key to continue.....":COLOR 7,0
1760 IF INKEY$=""THEN 1760
1770 GOSUB 150:GOTO 730
1780 :REM'
1790 :REM'.....grid square to approximate longitude (middle of cell)
1800 W1=ASC(MID$(G$,1,1))-65:W2=ASC(MID$(G$,3,1))-48:W3=ASC(MID$(G$,5,1))-65
1810 LON=-(180-20*W1-2*W2-W3/12-1/24)
1820 RETURN
1830 :REM'
1840 :REM'.....grid Square to approximate latitude (middle of cell)
1850 L1=ASC(MID$(G$,2,1))-65:L2=ASC(MID$(G$,4,1))-48:L3=ASC(MID$(G$,6,1))-65
1860 LAT=-90+10*L1+L2+L3/24+1/48
1870 RETURN
1880 :REM'
1890 :REM'.....range (distance) and beam heading
1900 RLA(1)=LA(1)*PI/180
1910 RLO(1)=LO(1)*PI/180:P$(1)="HOME"
1920 RLA(2)=LA(2)*PI/180
1930 RLO(2)=LO(2)*PI/180:P$(2)="AWAY"
1940 GOSUB 2040                                :REM'to make B > A
1950  MERID=0                                  :REM'default value
1960  IF LO(1)=LO(2)THEN MERID=1:GOTO 2010     :REM'A & B on same meridian
1970 IF ABS(LO(1))+ABS(LO(2))<>180 THEN 2010
1980  LA(2)=180-LA(2):MERID=1                  :REM'A & B on opposite meridians
1990  IF LA(2)>180 THEN LA(2)=LA(2)-90
2000  RLA(2)=LA(2)*PI/180                      :REM'angle in radians
2010 GOSUB 2220                                :REM'calculation sub-routine
2020 GOTO 2140                                 :REM'screen print
2030 :REM'
2040 :REM'.....point B must be place of greater latitude
2050 ALA=RLA(1):BLA=RLA(2)
2060 IF(ALA=BLA)AND(RLO(1)>RLO(2))THEN 2090              :REM'both on equator
2070 IF (ALA<0)AND(BLA<0)THEN ALA=ABS(ALA):BLA=ABS(BLA)  :REM'both south of equator
2080 IF BLA>ALA THEN 2120
2090 SWAP RLA(1),RLA(2)
2100 SWAP RLO(1),RLO(2)
2110 SWAP P$(1),P$(2)
2120 RETURN
2130 :REM'
2140 :REM'.....range R (distance)
2150 IF UU$="naut.miles"THEN RX=ZD*60
2160 IF UU$="stat.miles"THEN RX=ZD*24856.80078125!/360
2170 IF UU$="kilometres"THEN RX=ZD*40000.0!/360
2180 :REM'
2190 :REM'.....bearing angle A
2200 IF P$(1)="HOME" THEN A=XD :ELSE A=YD
2210 :REM'
2220 :REM'.....calculate bearings and distance
2230 REM RLA(n) & RLO(n) are LAT & LONG inputs in radians
2240 LB=RLA(2)                               :REM'latitude of point B in radians
2250 LA=RLA(1)                               :REM'latitude of point A in radians
2260 IF LA=0 AND LB=0 THEN 2450              :REM'both points on equator
2270 C=RLO(1)-RLO(2)                         :REM'difference in longitude
2280 IF C=0 THEN 2320                        :REM'both points on same meridian
2290 IF ABS(C)=PI THEN 2380                  :REM'points on opposite meridians
2300 GOTO 2540
2310 :REM'
2320 :REM'.....A & B both on same meridian
2330 ZR=LB-LA:ZD=ZR*180/PI
2340 Y=PI:YD=180
2350 X=0:XD=0
2360 RETURN
2370 :REM'
2380 :REM'.....A & B on opposite meridians
2390 ZR=LB-LA:IF ZR>PI THEN ZR=2*PI-ZR
2400 IF ZR<PI THEN Y=0:YD=0:X=0:XD=0
2410 IF ZR>PI THEN Y=PI:YD=180:X=PI:XD=180
2420 ZD=ZR*180/PI
2430 RETURN
2440 :REM'
2450 :REM'.....A & B both on equator
2460 EQUAT=1                                 :REM'flag
2470 Y=PI/2:YD=Y*180/PI
2480 X=1.5!*PI:XD=X*180/PI
2490 L=ABS(RLO(1)-RLO(2))
2500 IF L>PI THEN L=2*PI-L
2510 ZR=L:ZD=ZR*180/PI
2520 GOTO 2700
2530 :REM'
2540 :REM'.....formula elements
2550 F0=1/TAN(C/2)                           :REM'cotangent C/2
2560 F1=F0*SIN((LB-LA)/2)/COS((LB+LA)/2)
2570 IF LB+LA=0 THEN F2=F0*COS((LB-LA)/2)/SIN(1.0000000116860974e-07!):GOTO 2590
2580 F2=F0*COS((LB-LA)/2)/SIN((LB+LA)/2)
2590 F3=ATN(F1)
2600 F4=ATN(F2)
2610 :REM'
2620 :REM'.....bearings
2630 Y=F4+F3                                 :REM'bearing at point B
2640 IF LA<0 AND LB<0 THEN Y=Y+PI:GOTO 2660  :REM'A & B both in southern hemisphere
2650 IF ABS(LA)>ABS(LB)THEN Y=Y+PI
2660 IF Y<0 THEN Y=Y+2*PI
2670 IF Y>=(2*PI)THEN Y=Y-2*PI
2680 YD=Y*180/PI                             :REM'bearing in degrees at point B
2690 :REM'
2700 X=F4-F3                                 :REM'bearing at point A
2710 IF LA<0 AND LB<0 THEN X=X+PI:GOTO 2730  :REM'A & B both in southern hemisphere
2720 IF ABS(LA)>ABS(LB)THEN X=X+PI
2730 IF X<0 THEN X=X+2*PI
2740 IF X>=(2*PI)THEN X=X-2*PI
2750 XR=2*PI-X                               :REM'reciprocal
2760 IF XR<0 THEN XR=XR+2*PI
2770 IF XR>=(2*PI)THEN XR=XR-2*PI
2780 XD=XR*180/PI                            :REM'bearing in degrees at point A
2790 :REM'
2800 :REM'.....distance
2810 IF RLO(1)=RLO(2)THEN ZR=ABS(LB-LA):GOTO 2850
2820 IF LA=LB THEN LB=LB+1.0000000116860974e-07!:GOTO 2270  :REM'avoids trig function of angle 0
2830 F5=TAN((LB-LA)/2)*SIN(F4)/SIN(F3)       :REM'F5=tan ZR/2 (ZR=distance angle)
2840 ZR=ABS(2*ATN(F5))                       :REM'distance angle in radians
2850 ZD=ZR*180/PI                            :REM'distance angle in degrees
2860 RETURN
2870 :REM'
2880 :REM'..... UTC times - based on DAYLIGHT program, HAM-SOFT disk# 1247
2890 LX=L:LO=-W
2900 Z1=LX
2910 LATI=Z1*0.017453299835324287!
2920 ZONE=ZON*PI/180
2930 Z2=LO
2940  FOR Z=0 TO 12
2950  IF ABS(Z2)>=Z*15-7.5! THEN ZON=Z*SGN(Z2)
2960  NEXT Z
2970 ZONE=ZON*15*PI/180
2980 LONG=Z2*0.017453299835324287!
2990 H=VAL(RIGHT$(DATE$,4))
3000 I=VAL(LEFT$(DATE$,2))
3010 J=VAL(MID$(DATE$,4,2))
3020 I$=M$(I)
3030 :REM'.....local standard time
3040 STC=-ZON      :REM'solar time zone
3050 :REM'.....day of year
3060 K=INT((I+9)/12)
3070 X=H/4
3080 Y=INT(X)
3090 Z=X-Y
3100 IF Z=0 THEN 3120
3110 K=K*2
3120 H=INT(275*I/9)
3130 H=H+J-K-30
3140 :REM'.....sunrise phenomena
3150 I=0
3160 J=PI/2
3170 GOSUB 3660  :REM'approximate time
3180 :REM'.....local solar time
3190 RR=-0.014543900266289711!
3200 GOSUB 4060 :REM'coordinate conversion
3210 :REM'.....local standard time
3220 RISE=V+X/60
3230 DCL=Q*180/PI
3240 NOON=DCL
3250 :REM'.....azimuth
3260 AZ=180-AZ
3270 AZ(1)=AZ
3280 :REM'
3290 :REM'.....sunset phenomena
3300 I=1
3310 J=PI*1.5!
3320 GOSUB 3660    :REM'approximate time
3330 :REM'.....local solar time
3340 RR=-0.014543900266289711!
3350 GOSUB 4060
3360 :REM'.....local standard time
3370 SET=V+X/60:HD=SET-RISE   :REM'hours of daylight
3380 :REM'
3390 :REM'.....format time
3400 UP=RISE+ZON:DN=SET+ZON
3410 U$=" ":D$=" "
3420 UP=INT(UP)*100+(UP-INT(UP))*60
3430 UP=INT(UP*10+0.5!)/10
3440 IF UP<0 THEN UP=UP+2400:U$="«"
3450 UP$=STR$(UP):UP$=RIGHT$(UP$,LEN(UP$)-1)
3460 IF LEN(UP$)<4 THEN UP$="0"+UP$:GOTO 3460
3470 UP$=U$+UP$
3480 DN=INT(DN)*100+(DN-INT(DN))*60
3490 DN=INT(DN*10+0.5!)/10
3500 IF DN>2400 THEN DN=DN-2400:D$="»"
3510 DN$=STR$(DN):DN$=RIGHT$(DN$,LEN(DN$)-1)
3520 IF LEN(DN$)<4 THEN DN$="0"+DN$:GOTO 3520
3530 DN$=DN$+D$
3540 LOCATE LIN,59:PRINT UP$;
3550 LOCATE LIN,71:PRINT DN$
3560 RETURN
3570 :REM'
3580 :REM'.....declination
3590 DCL=Q*180/PI
3600 NOON=(NOON+DCL)/2      :REM'approx declination at noon
3610 :REM'.....azimuth
3620 AZ=180+AZ
3630 AZ(2)=AZ
3640 RETURN
3650 :REM'
3660 :REM'.....approximate time
3670 K=H+((J+LONG)/(PI*2))
3680 :REM'.....solar mean anomaly
3690 L=K*0.017201999202370644!
3700 L=L-0.05740389972925186!
3710 :REM'.....solar true longitude
3720 Z=SIN(L)
3730 M=L+0.03344050049781799!*Z
3740 Z=SIN(2*L)
3750 M=M+0.00034906598739326!*Z
3760 M=M+4.932889938354492!
3770 :REM'.....quadrant determination
3780 Z=M
3790 GOSUB 4490
3800 M=Z
3810 X=M/(PI/2)
3820 Y=INT(X)
3830 Z=X-Y
3840 IF Z<>0 THEN 3860
3850 M=M+4.848140179092297e-06!
3860 N=2
3870 IF M>(PI*1.5!) THEN 3920
3880 N=1
3890 IF M>(PI/2) THEN 3920
3900 N=0
3910 :REM'.....solar right ascension
3920 P=0.917460024356842!*TAN(M)
3930 P=ATN(P)
3940 :REM'.....quadrant adjustment
3950 IF N=0 THEN 4010
3960 IF N=2 THEN 3990
3970 P=P+PI
3980 GOTO 4010
3990 P=P+PI*2
4000 :REM'.....solar declination
4010 Q=0.39781999588012695!*SIN(M)
4020 Q=Q/SQR(-Q*Q+1)
4030 Q=ATN(Q)
4040 RETURN
4050 :REM'
4060 :REM'.....coordinate conversion
4070 S=RR-(SIN(Q)*SIN(LATI))
4080 S=S/(COS(Q)*COS(LATI))
4090 :REM'.....null phenomenon
4100 Z=ABS(S)
4110 IF Z<=1 THEN 4150
4120 V=0
4130 RETURN
4140 :REM'
4150 :REM'.....adjustment
4160 S=S/SQR(-S*S+1)
4170 S=-ATN(S)+PI/2
4180 IF I=1 THEN 4200
4190 S=PI*2-S
4200 :REM'.....local apparent time
4210 Z=0.017202800139784813!*K
4220 T=S+P-Z-1.7336399555206299!
4230 :REM'.....universal time
4240 U=T+LONG
4250 :REM'.....wall clock time
4260 V=U-ZONE
4270 :REM'.....decimal to sexagesimal
4280 Z=V
4290 GOSUB 4490
4300 Z=Z*3.8197200298309326!
4310 :REM'.....azimuth
4320 HR=(12-Z)*15                :REM'hour angle in degrees
4330 HRA=HR*PI/180               :REM'hour angle in radians
4340 X=SIN(Q)*COS(LATI)-COS(Q)*SIN(LATI)*COS(HRA)
4350 ZA=ATN(X/SQR(-X*X+1))+PI/2  :REM'azimuth in radians
4360 AZ=ZA*180/PI                :REM'azimuth in degrees
4370 IF AZ<0 THEN AZ=AZ+360
4380 V=INT(Z)
4390 W=(Z-V)*60
4400 X=INT(W)
4410 Y=W-X
4420 IF Y<0.5! THEN 4440
4430 X=X+1
4440 IF X<60 THEN 4470
4450 V=V+1
4460 X=0
4470 RETURN
4480 :REM'
4490 :REM'.....normalization
4500 IF Z>=0 THEN 4530
4510 Z=Z+PI*2
4520 GOTO 4490
4530 IF Z<PI*2 THEN 4560
4540 Z=Z-PI*2
4550 GOTO 4530
4560 RETURN
4570 :REM'
4580 :REM'.....preface
4590 TB=7
4600 PRINT TAB(TB);
4610 PRINT "  Grid squares were developed by an international group at a"
4620 PRINT TAB(TB);
4630 PRINT "conference in Maidenhead, England, hence the name ";
4640 PRINT CHR$(34);"Maidenhead";CHR$(34);
4650 PRINT TAB(TB);
4660 PRINT "grid squares."
4670 PRINT TAB(TB);
4680 PRINT "  Grid squares are based on latitude and longitude. Each square is"
4690 PRINT TAB(TB);
4700 PRINT "1° high x 2° wide, further divided into sub-squares only a few"
4710 PRINT TAB(TB);
4720 PRINT "kilometres wide. Grid squares are coded with a 2-letter/2-number/"
4730 PRINT TAB(TB);
4740 PRINT "2-letter code (such as FN04HO). Most people just use the first four"
4750 PRINT TAB(TB);
4760 PRINT "characters (such as FN04), which is the grid square. The last two"
4770 PRINT TAB(TB);
4780 PRINT "letters are generally used only when it is desired to pinpoint a"
4790 PRINT TAB(TB);
4800 PRINT "a location within a sub-square."
4810 PRINT TAB(TB);
4820 PRINT "  This program computes the grid square code for any latitude/"
4830 PRINT TAB(TB);
4840 PRINT "longitude in the world, or the coordinates of the approximate"
4850 PRINT TAB(TB);
4860 PRINT "centre of any grid square or sub-square. It also computes distances"
4870 PRINT TAB(TB);
4880 PRINT "and beam headings between specified grid squares or sub-squares."
4890 PRINT TAB(TB);
4900 PRINT "  Coordinates need only be known within an accuracy of 0.1° which"
4910 PRINT TAB(TB);
4920 PRINT "is about 11 km north-south, and east-west about 11 km at the"
4930 PRINT TAB(TB);
4940 PRINT "equator, 8 km at 45° latitude, and 1 km at 85° latitude."
4950 PRINT TAB(TB);
4960 PRINT "  All computations are in decimal degrees. To convert deg/min/sec"
4970 PRINT TAB(TB);
4980 PRINT "coordinates to decimal degrees, run the EQIVALENT VALUES program."
4990 PRINT TAB(TB);
5000 PRINT "  (ref. The ARRL OPERATING MANUAL, 5th Edition, pp.12-4 to 12-6)";
5010 RETURN
5020 :REM'
5030 :REM'.....world chart
5040 PRINT TAB(12)"M A I D E N H E A D   G R I D   S Q U A R E   F I E L D S"
5050 PRINT TAB(18)"with First Two Characters of Grid Square Code"
5060 TB=13
5070 PRINT TAB(TB+10)"Degrees West";TAB(TB+35)"Degrees East"
5080 PRINT TAB(TB)"   160°  120°  80°   40°    0°   40°   80°   120°  160°"
5090 LN=CSRLIN:LOCATE LN
5100 FOR RO=82 TO 65 STEP-1
5110 PRINT STRING$(TB,32)+"│";
5120  FOR CO=65 TO 82
5130  IF CO=73 THEN I$="║":ELSE I$="│"
5140  PRINT CHR$(CO)+CHR$(RO)+I$;
5150  NEXT CO
5160 I$="═╪═":J$=I$+I$+I$+I$+I$+I$+I$+I$
5170 IF RO=74 THEN PRINT STRING$(TB,32)+"╞═"+J$+"═╬═"+J$+"═╡"
5180 IF RO=74 THEN LOCATE CSRLIN-1,TB+24:COLOR 0,7:PRINT "«EQUATOR»":COLOR 7,0
5190 NEXT RO
5200 FOR Z=0 TO 8
5210 LOCATE LN+8-Z,TB-11
5220 PRINT USING "##";Z*10;:PRINT "°N -";STR$(Z*10+10);"°N"
5230 NEXT Z
5240 FOR Z=0 TO 8
5250 LOCATE LN+10+Z,TB-11
5260 PRINT USING "##";Z*10;:PRINT "°S -";STR$(Z*10+10);"°S"
5270 NEXT Z
5280 LOCATE 24
5290 PRINT TAB(TB)"180°  140°  100°  60°   20°   20°   60°   100°  140°  180°";
5300 LOCATE 11
5310 LOCATE ,70:PRINT "Each Field"
5320 LOCATE ,70:PRINT "contains"
5330 LOCATE ,70:PRINT "100 grid"
5340 LOCATE ,70:PRINT "squares,"
5350 LOCATE ,70:PRINT "each being"
5360 LOCATE ,70:PRINT "2° wide x"
5370 LOCATE ,70:PRINT "1° high."
5380 GOSUB 5720
5390 :REM'
5400 :REM'.....draw sub-square
5410 CLS
5420 PRINT TAB(6);
5430 PRINT"4-CHARACTER CODES FOR 1°x 2° GRID SQUARES WITHIN EACH 10°x 20° FIELD"
5440 PRINT TAB(18)"(xx = FIRST TWO letters of Grid Square Code)"
5450 LN=CSRLIN:TB=5
5460 Y$="───┬───"
5470 PRINT TAB(TB)"┌───";:FOR Y=1 TO 9:PRINT Y$;:NEXT Y:PRINT "───┐"
5480 FOR X=1 TO 9
5490 PRINT
5500 Y$="───┼───"
5510 PRINT TAB(TB)"├───";:FOR Y=1 TO 9:PRINT Y$;:NEXT Y:PRINT "───┤"
5520 NEXT X
5530 PRINT
5540 Y$="───┴───"
5550 PRINT TAB(TB)"└───";:FOR Y=1 TO 9:PRINT Y$;:NEXT Y:PRINT "───┘"
5560 LOCATE LN+1
5570 FOR Y=9 TO 0 STEP-1
5580 PRINT TAB(TB)"│";
5590 FOR X=0 TO 9
5600 Z=Y+X*10:Z$=STR$(Z):Z$=RIGHT$(Z$,LEN(Z$)-1)
5610 IF LEN(Z$)<2 THEN Z$="0"+Z$
5620 Z$=" xx"+Z$+" │"
5630 PRINT Z$;
5640 NEXT X:PRINT "":PRINT
5650 NEXT Y
5660 GOTO 5680
5670 :REM'
5680 :REM'.....end
5690 GOSUB 5720:GOTO 190
5700 END
5710 :REM'
5720 :REM'PRT
5730 KEY OFF:GOSUB 5800:LOCATE 25,5:COLOR 0,2
5740 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
5750 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
5760 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 5760 :ELSE GOSUB 5800
5770 IF Z$="3"THEN RETURN
5780 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
5790 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 5730
5800 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
