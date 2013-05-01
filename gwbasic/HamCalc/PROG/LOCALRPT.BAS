10 :REM'LOCALRPT - LOCAL REPEATERS - 03 JUN 94 rev. 10 MAR 2000
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="localrpt"
40 COMMON EX$,PROG$,DMS
50 IF POSN THEN 770
60 ON ERROR  GOTO 440
70 CLS:KEY OFF
80 COLOR 7,0,1
90 DIM A$(511,7),F$(26,2)
100 DIM B$(511)
110 U1$="#####.#"
120 U2$="##,###.#"
130 U3$="####.#"
140 U4$="####,###.#"
150 U5$="###.#"
160 U6$="#####"
170 U7$="####"
180 U8$="######"
190 UL$=STRING$(80,205)
200 XX$=STRING$(79,32)          :REM'blank
210 PI=3.1415929794311523!
220 GOTO 240
230 :REM'
240 :REM'.....start
250 CLS:POSN=0
260 PRINT " LOCAL REPEATERS"
270 PRINT UL$;
280 GOSUB 7510    :REM'preface
290 PRINT UL$;
300 PRINT " Press number in < > to choose standard unit of measure:"
310 PRINT UL$;
320 PRINT "   < 1 >  Metric"
330 PRINT "   < 2 >  U.S.A./Imperial"
340 PRINT UL$;
350 PRINT "     or Press < 0 > to EXIT....."
360 Z$=INKEY$
370 IF Z$="0"THEN CLS:RUN EX$
380 IF Z$="1"THEN UM=1:UM$="Km.":GOTO 410
390 IF Z$="2"THEN UM=1.6093339920043945!:UM$="mi.":GOTO 410
400 GOTO 360
410 COLOR 7,0
420 GOTO 660
430 :REM'
440 :REM'.....error trap
450 IF ERR=75 OR ERR=76 AND ERL=3480 THEN 490
460 IF ERR=53 AND ERL=680 THEN 550
470 PRINT "Error";ERR;"in line";ERL:GOTO 510
480 END
490 CLS:BEEP:PRINT " Error";ERR;" Path or File Access error."
500 PRINT " You may be trying to write to a Read Only disc."
510 PRINT " Press F2 to start over....."
520 END
530 GOTO 10
540 :REM'
550 :REM'.....start new file
560 CLS:BEEP:COLOR 12
570 LOCATE 12,20:PRINT " There are no repeaters on file as yet."
580 LOCATE 13,20:PRINT " Do you want to start a file now?   (y/n)"
590 Z$=INKEY$:IF Z$="" THEN 590
600 IF Z$="n"THEN COLOR 7,0:CLS:GOTO 240
610 IF Z$="y"THEN 630
620 GOTO 590
630 COLOR 7,0:CLS:OPEN "O",1,"\hamcalc\index\rptrdex.fil":CLOSE
640 GOTO 240
650 :REM'
660 :REM'.....load data
670 N=0
680 OPEN "I",1,"\hamcalc\index\rptrdex.fil"
690 IF EOF(1) THEN 750
700 N=N+1
710 FOR Y=1 TO 7
720 INPUT# 1,A$(N,Y)
730 NEXT Y
740 GOTO 690
750 CLOSE
760 :REM'
770 :REM'.....display
780 COLOR 7,0:CLS
790 COLOR 15,2
800 PRINT " LOCAL REPEATERS";
810 PRINT TAB(57);"by George Murphy VE3ERP ";
820 COLOR 1,0:PRINT STRING$(80,223);
830 COLOR 7,0
840 IF POSN THEN Z=POSN:GOSUB 1240:GOTO 1080
850 :REM'
860 GOSUB 2400     :REM'text
870 PRINT UL$;
880 PRINT " Press number in < > to:"
890 PRINT UL$;
900 PRINT "  < 1 >  ADD/VIEW/EDIT/SEARCH List of Local Repeaters"
910 PRINT "  < 2 >  LIST repeaters within a SPECIFIED RANGE of any base station"
920 PRINT "  < 3 >  LOCATE a repeater on a RADAR SCREEN centred on any location"
930 PRINT "  < 4 >  Convert Degrees/Minutes/Seconds to Decimal Degrees"
940 Z$=INKEY$
950 IF Z$="1"THEN 3290                  :REM'data base program
960 IF Z$="2"THEN FAR$="k":GOTO 6510    :REM'repeater range
970 IF Z$="3"THEN FAR$="k":GOTO 1010    :REM'far$=k=kilometres
980 IF Z$="4"THEN CLS:DMS=1:CHAIN"equiv"
990 GOTO 940
1000 :REM'
1010 :REM'.....inputs
1020 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1030 LA(1)=0:LA(2)=0:LO(1)=0:LO(2)=0
1040 STN=0
1050 STN$(1)=" HOME "
1060 STN$(2)=" REPEATER "
1070 :REM'
1080 STN=STN+1
1090 IF POSN THEN ZZ=POSN :ELSE ZZ=1
1100 IF POSN<>1 THEN 1130
1110 GOSUB 1210
1120 :REM'
1130    FOR Z=ZZ TO 2   :REM'********** start input loop **********
1140 DOT$=STRING$(39-LEN(P$(Z)),".")
1150 IF POSN=Z THEN GOSUB 1210:GOTO 1280
1160 IF(P$(Z)<>"" AND LA(Z)*LO(Z))THEN 1280
1170 PRINT " Press any key to select";STN$(STN);"station.................."
1180 IF INKEY$=""THEN 1180
1190 POSN=Z:GOTO 3290                              :REM'data base program
1200 :REM'
1210 :REM'.....format latitude & longitude
1220 IF SGN(LA(Z))=-1 THEN NS$(Z)="°S":ELSE NS$(Z)="°N"
1230 IF SGN(LO(Z))=-1 THEN EW$(Z)="°W":ELSE EW$(Z)="°E"
1240 RLA(Z)=LA(Z)*PI/180      :REM'latitude in radians
1250 RLO(Z)=LO(Z)*PI/180      :REM'longitude in radians
1260 RETURN
1270 :REM'
1280    NEXT Z          :REM'********** end input loop **********
1290 :REM'
1300 ROUTE=SGN(LA(1)+LA(2))                   :REM'determine north or south route
1310 IF LA(1)<0 AND LA(2)<0 THEN ROUTE=1      :REM'A & B both in southern hemisphere
1320 :REM'
1330 :REM'.....display initial data
1340 VIEW PRINT 3 TO 23:CLS:VIEW PRINT        :REM'erase screen
1350 LOCATE 3
1360 Z=1:GOSUB 1210
1370 HOME$=P$(1)
1380 PRINT TAB(2);"HOME QTH:";
1390 DOT$=STRING$(47-LEN(P$(1)),".")
1400 PRINT TAB(12);P$(1);" ";DOT$;
1410 PRINT TAB(61);USING U1$;ABS(LA(1));
1420 PRINT NS$(1);USING U1$;ABS(LO(1));
1430 PRINT EW$(1);
1440 Z=2:GOSUB 1210
1450 PRINT TAB(2);"AWAY QTH:";
1460 DOT$=STRING$(47-LEN(P$(2)),".")
1470 PRINT TAB(12);P$(2);" ";DOT$;
1480 PRINT TAB(61);USING U1$;ABS(LA(2));
1490 PRINT NS$(2);USING U1$;ABS(LO(2));
1500 PRINT EW$(2)
1510 GOSUB 1610                                :REM'to make B > A
1520  MERID=0                                  :REM'default value
1530  IF LO(1)=LO(2)THEN MERID=1:GOTO 1580     :REM'A & B on same meridian
1540 IF ABS(LO(1))+ABS(LO(2))<>180 THEN 1580
1550  LA(2)=180-LA(2):MERID=1                  :REM'A & B on opposite meridians
1560  IF LA(2)>180 THEN LA(2)=LA(2)-90
1570  RLA(2)=LA(2)*PI/180                      :REM'angle in radians
1580 GOSUB 2620                                :REM'calculation sub-routine
1590 GOTO 1710                                 :REM'screen print
1600 :REM'
1610 :REM'.....point B must be place of greater latitude
1620 ALA=RLA(1):BLA=RLA(2)
1630 IF(ALA=BLA)AND(RLO(1)>RLO(2))THEN 1660              :REM'both on equator
1640 IF (ALA<0)AND(BLA<0)THEN ALA=ABS(ALA):BLA=ABS(BLA)  :REM'both south of equator
1650 IF BLA>ALA THEN 1690
1660 SWAP RLA(1),RLA(2)
1670 SWAP RLO(1),RLO(2)
1680 SWAP P$(1),P$(2)
1690 RETURN
1700 :REM'
1710 :REM'.....display balance of data
1720 LONDIFF=ABS(LO(1)-LO(2))                  :REM'difference in longitude
1730 IF LONDIFF >180 THEN LONDIFF=360-LONDIFF
1740 ZONE=LONDIFF/15                           :REM'no. of 1 hr.time zones
1750 MIN=INT((ZONE)*60)                        :REM'minutes
1760 SEC=(ZONE*60-MIN)*60                      :REM'seconds
1770 T=12                                      :REM'tab
1780 KM=ZD*4*10^4/360
1790 MI=KM/1.6093469858169556!
1800  PRINT TAB(T);"Great Circle distance";STRING$(27,".");USING U8$;KM;
1810  PRINT " km=";USING U6$;MI;:PRINT " mi."
1820  PRINT TAB(T);"Solar Time difference";STRING$(27,".");USING U8$;MIN;
1830   PRINT " min.";USING U7$;SEC;:PRINT " sec.";
1840   D1$=STRING$(35-LEN(P$(1)),".")
1850  PRINT TAB(T);"Bearing from ";P$(1);D1$;TAB(63);USING U5$;XD;:PRINT "°"
1860  IF P$(1)=HOME$ THEN BRG=XD
1870   D2$=STRING$(35-LEN(P$(2)),".")
1880  PRINT TAB(T);"Bearing from ";P$(2);D2$;TAB(63);USING U5$;YD;:PRINT "°"
1890  IF P$(2)=HOME$ THEN BRG=YD
1900 PRINT UL$;
1910 :REM'
1920 PRINT " BEARINGS ARE"
1930 PRINT " FROM TRUE NORTH"
1940 PRINT " ═══════════════"
1950 PRINT " ";
1960 COLOR 15,1
1970 PRINT "<*>";
1980 COLOR 7,0
1990 PRINT " = ";RPT$
2000 PRINT " Output: ";XMT$
2010 PRINT " Offset: ";SET$
2020 PRINT " Input:  ";RCV$
2030 PRINT " ═══════════════"
2040 R=7      :REM'radial
2050 H=R^2/2  :REM'1/2 square of hypotenuse
2060 X=41     :REM'x-axis
2070 Y=17     :REM'y-axis
2080 XY=2.34375!  :REM'xy ratio
2090 FOR Z=Y-R TO Y+R
2100  LOCATE Z,X-18
2110  PRINT STRING$(37,"█");
2120 IF Z<Y+R THEN PRINT ""
2130 NEXT Z
2140 COLOR 15,3
2150 LOCATE Y-R,X-2:PRINT "  N  "
2160 LOCATE Y-SQR(H),X-(SQR(H)*XY)-1.5!:PRINT " NW "
2170 LOCATE Y-SQR(H),X+(SQR(H)*XY)-1.5!:PRINT " NE "
2180 LOCATE Y,X-(R*XY)-2:PRINT "  W  "
2190 COLOR 15,1
2200 LOCATE Y,X-3:PRINT " HO*ME "
2210 COLOR 15,3
2220 LOCATE Y,X+(R*XY)-2:PRINT "  E  "
2230 LOCATE Y+SQR(H),X-(SQR(H)*XY)-1.5!:PRINT " SW "
2240 LOCATE Y+SQR(H),X+(SQR(H)*XY)-1.5!:PRINT " SE "
2250 LOCATE Y+R,X-2:PRINT "  S  ";
2260 :REM'....BRG = bearing from home station
2270 BRG=BRG-90              :REM'bearing in degrees
2280 HDG=BRG*3.1415929794311523!/180    :REM'bearing in radians
2290 YY=SIN(HDG)*R
2300 XX=COS(HDG)*R*XY
2310 COLOR 15,1
2320 LOCATE Y+YY,X+XX-1
2330 PRINT "<*>";
2340 LOCATE Y+YY/2,INT(X+XX/2-3)
2350 COLOR 15,0
2360 PRINT CINT(KM/UM);UM$
2370 COLOR 7,0:GOSUB 7610
2380 GOTO 240   :REM'start
2390 :REM'
2400 :REM'.....text
2410 TB=7
2420 PRINT TAB(TB);
2430 PRINT "When you first run this program, add your own station to the data"
2440 PRINT TAB(TB);
2450 PRINT "base, listing your output frequency as 0 Mhz."
2460 PRINT
2470 PRINT TAB(TB);
2480 PRINT "Enter your latitude and longitude, which you can determine from a"
2490 PRINT TAB(TB);
2500 PRINT "good road map or atlas. Enter these in decimal degrees, to the"
2510 PRINT TAB(TB);
2520 PRINT "nearest 0.1 degree."
2530 PRINT
2540 PRINT TAB(TB);
2550 PRINT "You can then add your local repeaters. The data base can be edited"
2560 PRINT TAB(TB);
2570 PRINT "at any time to add, delete, or change any listings."
2580 RETURN
2590 :REM'
2600 :REM'**********SUB-ROUTINES**********
2610 :REM'
2620 :REM'.....calculate bearings and distance
2630 REM RLA(n) & RLO(n) are LAT & LONG inputs in radians
2640 LB=RLA(2)                               :REM'latitude of point B in radians
2650 LA=RLA(1)                               :REM'latitude of point A in radians
2660 IF LA=0 AND LB=0 THEN 2850              :REM'both points on equator
2670 C=RLO(1)-RLO(2)                         :REM'difference in longitude
2680 IF C=0 THEN 2720                        :REM'both points on same meridian
2690 IF ABS(C)=PI THEN 2780                  :REM'points on opposite meridian
2700 GOTO 2940
2710 :REM'
2720 :REM'.....A & B both on same meridian
2730 ZR=LB-LA:ZD=ZR*180/PI
2740 Y=PI:YD=180
2750 X=0:XD=0
2760 RETURN
2770 :REM'
2780 :REM'.....A & B on opposite meridians
2790 ZR=LB-LA:IF ZR>PI THEN ZR=2*PI-ZR
2800 IF ZR<PI THEN Y=0:YD=0:X=0:XD=0
2810 IF ZR>PI THEN Y=PI:YD=180:X=PI:XD=180
2820 ZD=ZR*180/PI
2830 RETURN
2840 :REM'
2850 :REM'.....A & B both on equator
2860 EQUAT=1                                 :REM'flag
2870 Y=PI/2:YD=Y*180/PI
2880 X=1.5!*PI:XD=X*180/PI
2890 L=ABS(RLO(1)-RLO(2))
2900 IF L>PI THEN L=2*PI-L
2910 ZR=L:ZD=ZR*180/PI
2920 GOTO 3100
2930 :REM'
2940 :REM'.....formula elements
2950 F0=1/TAN(C/2)                           :REM'cotangent C/2
2960 F1=F0*SIN((LB-LA)/2)/COS((LB+LA)/2)
2970 IF LB+LA=0 THEN F2=F0*COS((LB-LA)/2)/SIN(1.0000000116860974e-07!):GOTO 2990
2980 F2=F0*COS((LB-LA)/2)/SIN((LB+LA)/2)
2990 F3=ATN(F1)
3000 F4=ATN(F2)
3010 :REM'
3020 :REM'.....bearings
3030 Y=F4+F3                                 :REM'bearing at point B
3040 IF LA<0 AND LB<0 THEN Y=Y+PI:GOTO 3060  :REM'A & B both in southern hemisphere
3050 IF ABS(LA)>ABS(LB)THEN Y=Y+PI
3060 IF Y<0 THEN Y=Y+2*PI
3070 IF Y>=(2*PI)THEN Y=Y-2*PI
3080 YD=Y*180/PI                             :REM'bearing in degrees at point B
3090 :REM'
3100 X=F4-F3                                 :REM'bearing at point A
3110 IF LA<0 AND LB<0 THEN X=X+PI:GOTO 3130  :REM'A & B both in southern hemisphere
3120 IF ABS(LA)>ABS(LB)THEN X=X+PI
3130 IF X<0 THEN X=X+2*PI
3140 IF X>=(2*PI)THEN X=X-2*PI
3150 XR=2*PI-X                               :REM'reciprocal
3160 IF XR<0 THEN XR=XR+2*PI
3170 IF XR>=(2*PI)THEN XR=XR-2*PI
3180 XD=XR*180/PI                            :REM'bearing in degrees at point A
3190 :REM'
3200 :REM'.....distance
3210 IF RLO(1)=RLO(2)THEN ZR=ABS(LB-LA):GOTO 3250
3220 IF LA=LB THEN LB=LB+1.0000000116860974e-07!:GOTO 2670  :REM'avoids trig function of angle 0
3230 F5=TAN((LB-LA)/2)*SIN(F4)/SIN(F3)       :REM'F5=tan ZR/2 (ZR=distance angle)
3240 ZR=ABS(2*ATN(F5))                       :REM'distance angle in radians
3250 ZD=ZR*180/PI                            :REM'distance angle in degrees
3260 :REM'
3270 RETURN
3280 :REM'
3290 :REM'.....data base program
3300 CLS
3310 IF FAR$<>""THEN 5010
3320 COLOR 15,2
3330 PRINT " LOCAL REPEATERS "
3340 COLOR 1,0:PRINT STRING$(80,223);
3350 COLOR 7,0
3360 PRINT " Press number in < > to:"
3370 PRINT UL$;
3380 PRINT "  < 1 >  ADD a listing"
3390 PRINT "  < 2 >  FIND/EDIT a listing"
3400 PRINT "  < 3 >  DISPLAY listings"
3410 Z$=INKEY$
3420 IF Z$="1"THEN CLS:GOTO 4100
3430 IF Z$="2"THEN CLS:GOTO 5010
3440 IF Z$="3"THEN GOSUB 4220:GOTO 4510
3450 GOTO 3410
3460 :REM'
3470 :REM'.....save data
3480 OPEN "O",1,"\hamcalc\index\rptrdex.fil"
3490 FOR Z=1 TO N
3500 WRITE# 1,A$(Z,1),A$(Z,2),A$(Z,3),A$(Z,4),A$(Z,5),A$(Z,6),A$(Z,7)
3510 NEXT Z
3520 CLOSE
3530 GOTO 240   :REM'start
3540 :REM'
3550 :REM'.....change text to capital letters
3560 FOR U=1 TO LEN(I$)
3570 V=ASC(MID$(I$,U,1))
3580 IF V>96 AND V<123 THEN MID$(I$,U,1)=CHR$(V-32)
3590 NEXT U
3600 RETURN
3610 :REM'
3620 :REM'.....inputs
3630 INPUT " ENTER: Call sign..............................";I$:GOSUB 3550
3640 GOSUB 4060:RETURN
3650 :REM'
3660 LINE INPUT " ENTER: Location (town or area).....................?";I$
3670 GOSUB 3550
3680 IF LEN(I$)<=28 THEN 3740
3690 CL=CSRLIN-1:BEEP:COLOR 15,4
3700 PRINT " TOO MANY CHARACTERS - PLEASE ABBREVIATE!....press any key...."
3710 COLOR 7,0
3720 IF INKEY$=""THEN 3720
3730 VIEW PRINT CL TO 24:CLS:VIEW PRINT:LOCATE CL:GOTO 3660
3740 GOSUB 4060:RETURN
3750 :REM'
3760 INPUT " ENTER: Repeater OUTPUT frequency (###.###) MHz";I$
3770 IF I$="" THEN LOCATE CSRLIN-1:GOTO 3760
3780 IF VAL(I$)=0 THEN I$="000.000"
3790 IF LEN(I$)<7 THEN I$=I$+"0":GOTO 3790
3800 GOSUB 4060:RETURN
3810 :REM'
3820 IF VAL(I$)=0 THEN 3880
3830 PRINT " Is Repeater INPUT offset + or - ?  (+/-)"
3840 I$=INKEY$:IF I$=""THEN 3840
3850 IF I$="+"OR I$="-"THEN I$=I$+"600"
3860 IF LEFT$(I$,1)="+"OR LEFT$(I$,1)="-"THEN 3880
3870 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 3820
3880 RETURN
3890 :REM'
3900 IF VAL(I$)=0 THEN I$="000.000":GOTO 3970
3910 Z=N      :REM'calculate input frequency
3920   I=VAL(A$(Z,4))/10^3+VAL(A$(Z,3))         :REM'output frequency
3930   Z$=STR$(I)
3940   I$=RIGHT$(Z$,LEN(Z$)-1)                  :REM'offset
3950   IF LEN(I$)<>7 THEN I$=I$+"0":GOTO 3950
3960 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
3970 PRINT "        Repeater INPUT frequency offset..........";I$;" MHz"
3980 RETURN                                   :REM'input frequency
3990 :REM'
4000 INPUT " ENTER: Latitude (minus if south)......";I$
4010 GOSUB 4060:RETURN
4020 :REM'
4030 INPUT " ENTER: Longitude (minus if west)......";I$
4040 GOSUB 4060:RETURN
4050 :REM'
4060 LOCATE CSRLIN-1:PRINT STRING$(7,32)
4070 LOCATE CSRLIN-1,48:PRINT "  ";I$+STRING$(20,32)
4080 RETURN
4090 :REM'
4100 :REM'.....new listing
4110 N=N+1
4120 PRINT " NEW LISTING"
4130 PRINT UL$;
4140  FOR X=1 TO 7
4150  ONX GOSUB 3630,3660,3760,3820,3900,4000,4030
4160  A$(N,X)=I$
4170  NEXT X
4180 CLS
4190 Z=N
4200 GOTO 6080
4210 :REM'
4220 :REM'.....sort
4230 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
4240 PRINT " Press number in < > to SORT LISTINGS by:"
4250 PRINT UL$;
4260 PRINT "  < 1 >  Call Sign"
4270 PRINT "  < 2 >  Location"
4280 PRINT "  < 3 >  Output Frequency"
4290 Y$=INKEY$
4300 IF Y$="1"OR Y$="2"OR Y$="3"THEN 4320
4310 GOTO 4290
4320 IF Y$="1"THEN J=1:K=2:TOP$=" Call Sign"
4330 IF Y$="2"THEN J=2:K=1:TOP$=" Location"
4340 IF Y$="3"THEN J=3:K=1:TOP$=" Output Frequency"
4350 :REM'
4360 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
4370 SN=N:SM=SN
4380 SM=INT(SM/2):IF SM=0 THEN 4490
4390 SK=SN-SM:SJ=1
4400 SI=SJ
4410 SL=SI+SM
4420 IF A$(SI,J)+A$(SI,K)<=A$(SL,J)+A$(SL,K) THEN 4470
4430 FOR X=1 TO 7
4440 SWAP A$(SI,X),A$(SL,X)
4450 NEXT X
4460 SI=SI-SM:IF SI>0 THEN 4410
4470 SJ=SJ+1:IF SJ>SK THEN 4380
4480 GOTO 4400
4490 RETURN
4500 :REM'
4510 :REM'.....screen display
4520 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
4530 LOCATE 1,18:PRINT N;"listings in order of";TOP$
4540 LOCATE 3
4550 PRINT " Callsign";TAB(21);"Location";
4560 PRINT TAB(41);"Output  Offset   Input    Lat.    Long."
4570 PRINT UL$;
4580 LIN=4            :REM'line no.
4590 :REM'
4600 FOR Z=1 TO N                     :REM'start loop
4610  LIN=LIN+1
4620  IF LIN<25 THEN 4680
4630 :REM'
4640  LOCALE=1:GOSUB 7610
4650  LIN=1
4660  COLOR 7,0:CLS
4670 :REM'
4680 GOSUB 4880                                    :REM'determine NEWS suffix
4690 PRINT TAB(2);A$(Z,1);                         :REM'call sign
4700 PRINT TAB(11);A$(Z,2);                        :REM'location
4710 PRINT STRING$(29-LEN(A$(Z,2)),".");
4720 PRINT TAB(41);USING "###.###";VAL(A$(Z,3));   :REM'output
4730 PRINT TAB(50);USING "+###";VAL(A$(Z,4));      :REM'offset
4740   I=VAL(A$(Z,3))+VAL(A$(Z,4))*10^-3           :REM'input
4750   Z$=STR$(I)
4760   I$=RIGHT$(Z$,LEN(Z$)-1)                     :REM'offset
4770   IF LEN(I$)<7 THEN I$=I$+"0":GOTO 4770
4780   A$(Z,5)=I$
4790 PRINT TAB(56);USING "###.###";VAL(A$(Z,5));   :REM'input
4800 IF Z1*Z2=0 THEN 4830
4810 PRINT TAB(65);USING U5$;ABS(Z1);:PRINT Z1$;   :REM'latitude
4820 PRINT TAB(73);USING U5$;ABS(Z2);:PRINT Z2$;   :REM'longitude
4830 IF LIN<24 THEN PRINT ""
4840 NEXT Z
4850 GOSUB 7610     :REM'screen dump
4860 GOTO 3470      :REM'save & return to menu
4870 :REM'
4880 :REM'.....determine NSEW suffix
4890 E$=CHR$(248)
4900 Z1=VAL(A$(Z,6)):IF Z1<0 THEN Z1$=E$+"S":ELSE Z1$=E$+"N"
4910 Z2=VAL(A$(Z,7)):IF Z2<0 THEN Z2$=E$+"W":ELSE Z2$=E$+"E"
4920 RETURN
4930 :REM'
4940 :REM'.....menu return
4950 CLS
4960 PRINT:PRINT " Nothing starting with ";I$;" on file...."
4970 PRINT:PRINT " Press SPACE BAR to return to Menu"
4980 Z$=INKEY$:IF Z$=" "THEN 240
4990 GOTO 4980
5000 :REM'
5010 :REM'.....find listing
5020 LOCATE 1
5030 PRINT " Press number in < > to find listing by:"
5040 PRINT UL$;
5050 PRINT "  < 1 >  CALL SIGN"
5060 PRINT "  < 2 >  LOCATION"
5070 PRINT "  < 3 >  OUTPUT FREQUENCY"
5080 K$=INKEY$
5090 IF K$="1"THEN CLS:F1$="CALL SIGN":GOTO 5140
5100 IF K$="2"THEN CLS:F1$="LOCATION":GOTO 5140
5110 IF K$="3"THEN CLS:F1$="OUTPUT FREQUENCY":GOTO 5140
5120 GOTO 5080
5130 :REM'
5140 :REM'.....find listing
5150 LOCATE 1
5160 PRINT " ENTER: First few characters in ";F1$;" ";:INPUT I$
5170 GOSUB 3550         :REM'capitalize
5180 CLS
5190 LOCATE 24,35:PRINT " SEARCHING...";
5200 LOCATE 1
5210 L=LEN(I$):F=0
5220 K=VAL(K$)
5230 FOR Z=1 TO N
5240    IF LEFT$(A$(Z,K),L)<>I$ THEN 5360
5250    F=F+1
5260    F$(F,2)=STR$(Z)
5270    F$(F,1)=A$(Z,1)
5280    IF A$(Z,2)<>""THEN F$(F,1)=F$(F,1)+", "+A$(Z,2)
5290    IF F$(F,1)+F$(F,2)=F$(F-1,1)+F$(F-1,2)THEN F=F-1:GOTO 5360
5300    IF F<26 THEN 5360
5310    CLS:BEEP:PRINT" LIST TOO LONG TO FIT THE SCREEN!"
5320    PRINT
5330    PRINT" Please enter an extra character or two for a shorter list."
5340    PRINT
5350    GOTO 5160
5360 NEXT Z:IF F=0 THEN 4940
5370 CLS:IF F=1 THEN Z=VAL(F$(F,2)):GOTO 5580
5380 :REM'
5390 PRINT F1$;"S starting with ";
5400 COLOR 0,7:PRINT " ";I$;" ":COLOR 7,0
5410 PRINT UL$;
5420 CF=CINT(F/2)
5430 FOR Z=1 TO CINT(F/2)
5440 PRINT "(";CHR$(96+Z);") ";F$(Z,1);TAB(41);
5450 PRINT "(";CHR$(96+CF+Z);") ";F$(Z+CF,1)
5460 NEXT Z
5470 IF F/2<>INT(F/2)THEN LOCATE CSRLIN-1,41:PRINT STRING$(39,32)
5480 PRINT UL$;
5490 LIN=CSRLIN
5500 PRINT " Press letter in ( ) to select listing or <0> to return to menu"
5510 Z$=INKEY$:IF Z$=""THEN 5510
5520 IF Z$="0"THEN 3290
5530 Z=ASC(Z$)-96
5540 IF Z>=1 AND Z<=F THEN Y=Z:Z=VAL(F$(Y,2)):CLS:GOTO 5570
5550 GOTO 5510
5560 :REM'
5570 :REM'.....display listing
5580 GOSUB 5810
5590 PRINT " Press number in ( ) to:"
5600 PRINT UL$;
5610 IF POSN=1 THEN POSN$="centre of the radar screen"
5620 IF POSN=2 THEN POSN$="repeater blip on the radar screen"
5630 IF POSN=3 THEN POSN$="location of the BASE STATION"
5640 IF FAR$=""THEN PRINT :GOTO 5670
5650 PRINT " ( 1 )  SELECT this listing as the ";POSN$
5660 IF FAR$<>""THEN 5690
5670 PRINT " ( 2 )  EDIT Listing"
5680 PRINT " ( 3 )  DELETE Listing"
5690 PRINT UL$;
5700 PRINT " ( 0 )  RETURN to menu"
5710 Z$=INKEY$
5720 IF FAR$=""THEN 5760
5730 IF Z$="1"AND(POSN=1 OR POSN=2)THEN CLS:GOTO 5960
5740 IF Z$="1"AND POSN=3 THEN CLS:GOTO 6570
5750 IF FAR$<>""THEN 5780
5760 IF Z$="2"THEN CLS:GOTO 6080
5770 IF Z$="3"THEN BEEP:PRINT:GOTO 6330
5780 IF Z$="0"THEN 240
5790 GOTO 5710
5800 :REM'
5810 :REM'.....print listing
5820 PRINT" Call sign...line 1: ";A$(Z,1)
5830 PRINT" Location....line 2: ";A$(Z,2)
5840 PRINT" Output......line 3: ";A$(Z,3)
5850 PRINT" Offset......line 4: ";A$(Z,4)
5860 PRINT" Input.......line 5: ";A$(Z,5)
5870 B=VAL(A$(Z,6)):IF B<0 THEN B$=E$+"S":ELSE B$=E$+"N"
5880 PRINT" Latitude....line 6: ";
5890 PRINT USING"###.#";ABS(B);:PRINT B$
5900 B=VAL(A$(Z,7)):IF B<0 THEN B$=E$+"W":ELSE B$=E$+"E"
5910 PRINT" Longitude...line 7: ";
5920 PRINT USING"###.#";ABS(B);:PRINT B$
5930 PRINT UL$;
5940 RETURN
5950 :REM'
5960 :REM'.....assign variables for Great Circle calculations
5970 P$(POSN)=A$(Z,1)
5980 IF A$(Z,2)<>""THEN P$(POSN)=P$(POSN)+", "+A$(Z,2)
5990 RPT$=A$(Z,1)
6000 XMT$=A$(Z,3)
6010 SET$=A$(Z,4)
6020 RCV$=A$(Z,5)
6030 LA(POSN)=VAL(A$(Z,6))
6040 LO(POSN)=VAL(A$(Z,7))
6050 GOTO 10
6060 :REM'
6070 :REM'.....edit menu
6080 GOSUB 5810:PRINT " Press number in ( ) to:"
6090 PRINT UL$;
6100 FOR Y=1 TO 7
6110 IF Y<>5 THEN 6140
6120 PRINT " ( Line 5 changes automatically with any change in ";
6130 PRINT "line 3 and/or line 4 )":GOTO 6140
6140 PRINT " (";Y;")  Change Line";Y
6150 NEXT Y
6160 PRINT UL$;
6170 PRINT " ( 0 )  ACCEPT as is"
6180 PRINT
6190 Z$=INKEY$:Q=VAL(Z$):IF Q<0 OR Q>7 THEN 6280
6200 IF Z$="1"THEN GOSUB 3630:A$(Z,1)=I$:CLS:GOTO 6070
6210 IF Z$="2"THEN GOSUB 3660:A$(Z,2)=I$:CLS:GOTO 6070
6220 IF Z$="3"THEN GOSUB 3760:A$(Z,3)=I$:GOSUB 3920:A$(Z,5)=I$:CLS:GOTO 6070
6230 IF Z$="4"THEN GOSUB 6290:A$(Z,4)=I$:GOSUB 3920:A$(Z,5)=I$:CLS:GOTO 6070
6240 IF Z$="5"THEN 6190
6250 IF Z$="6"THEN GOSUB 4000:A$(Z,6)=I$:CLS:GOTO 6070
6260 IF Z$="7"THEN GOSUB 4030:A$(Z,7)=I$:CLS:GOTO 6070
6270 IF Z$="0"THEN CLS:GOSUB 4360:GOTO 3470     :REM'sort & save
6280 GOTO 6190
6290 INPUT " ENTER: Repeater input ( +nnn or -nnn )......";I$
6300 IF LEN(I$)<4 THEN I$=I$+"0":GOTO 6300
6310 RETURN
6320 :REM'
6330 :REM'.....delete listing
6340 BEEP:COLOR 0,7
6350 PRINT " Are you SURE you want to delete this file?   (y/n) "
6360 COLOR 7,0
6370 Z$=INKEY$
6380 IF Z$="y"THEN 6410
6390 IF Z$="n"THEN CLS:GOTO 5570
6400 GOTO 6370
6410 CLS:PRINT " LISTING DELETED":FOR X=Z TO N:FOR Y=1 TO 7
6420 A$(X,Y)=A$(X+1,Y):NEXT Y:NEXT X:N=N-1:GOTO 3470   :REM'save data
6430 :REM'
6440 :REM'.....ACS, ASN                  'GOSUB HERE TO GET ASN/ACS
6450 IF Z=0 THEN RC=PI/2:GOTO 6480   :REM'Z=VALUE FROM PROGRAM
6460 IF Z=1 THEN RC=0:GOTO 6480
6470 RC=-ATN(Z/SQR(1-Z^2))+PI/2      :REM'RC=ANGLE IN RADIANS IF Z=COS
6480 RS=PI/2-RC                      :REM'RS=ANGLE IN RADIANS IF Z=SIN
6490 RETURN
6500 :REM'
6510 :REM'.....repeater range
6520 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
6530 PRINT " Press any key to select location of BASE STATION"
6540 POSN=3:IF INKEY$=""THEN 6540
6550 CLS:GOTO 5010                :REM'select hub station
6560 :REM'
6570 :REM'.....Z=file location of hub station
6580 LAH=VAL(A$(Z,6))*PI/180        :REM'latitude of hub station
6590 LOH=VAL(A$(Z,7))*PI/180        :REM'longitude of hub station
6600 :REM'
6610 PRINT " ENTER: Maximum range (";UM$;") of base station";:INPUT KM
6620 KM=KM*UM
6630 :REM'
6640 :REM'.....compile, sort & print
6650 GOSUB 240    :REM'sorting notice
6660 COLOR 7,0:LOCATE 1
6670 J=0       :REM'reset counter
6680    FOR Y=1 TO N
6690 LAR=VAL(A$(Y,6))*PI/180        :REM'latitude of repeater
6700 LOR=VAL(A$(Y,7))*PI/180        :REM'longitude of repeater
6710 IF(LAH=LAR)AND(LOH=LOR)THEN DIS=0:GOTO 6770
6720 :REM'
6730 D1=SIN(LAH)*SIN(LAR)+COS(LAH)*COS(LAR)*COS(LOR-LOH) :REM'D1=cos d2
6740 :REM'
6750 D2=ATN(D1/SQR(-D1*D1+1))+PI/2  :REM'distance angle in radians
6760 DIS=CINT(20000-D2*10^4/PI*2)   :REM'distance in kilometers
6770 IF DIS>KM THEN 7180            :REM'skip - out of range
6780 :REM'.....bearing
6790 IF(LAH=LAR)AND(LOH=LOR)THEN CD=-1:GOTO 6900
6800 IF(LOH=LOR)AND(LAH<LAR)THEN CD=0:GOTO 6870
6810 IF(LOH=LOR)AND(LAH>LAR)THEN CD=180:GOTO 6870
6820 C1=(SIN(LAR)-SIN(LAH)*D1)/(COS(LAH)*SIN(D2))   :REM'bearing formula
6830 CR=ATN(C1/SQR(-C1*C1+1))+PI/2  :REM'bearing in radians
6840 CD=CINT(CR*180/PI)
6850 IF LOH>LOR THEN CD=180+CD
6860 IF LOH<LOR THEN CD=180-CD
6870 B1$=STR$(CD)
6880 IF LEN(B1$)<>4 THEN B1$=" "+B1$:GOTO 6880
6890 B$=B1$+"°"
6900 IF CD=-1 THEN B$="  -  "
6910                     B2$="  N "
6920   IF CD> 11.25! THEN B2$=" NNE"
6930   IF CD> 33.75! THEN B2$="  NE"
6940   IF CD> 56.25! THEN B2$=" ENE"
6950   IF CD> 78.75! THEN B2$="  E "
6960   IF CD>101.25! THEN B2$=" ESE"
6970   IF CD>123.75! THEN B2$="  SE"
6980   IF CD>146.25! THEN B2$=" SSE"
6990   IF CD>168.75! THEN B2$="  S "
7000   IF CD>191.25! THEN B2$=" SSW"
7010   IF CD>213.75! THEN B2$="  SW"
7020   IF CD>236.25! THEN B2$=" WSW"
7030   IF CD>258.75! THEN B2$="  W "
7040   IF CD>281.25! THEN B2$=" WNW"
7050   IF CD>303.75! THEN B2$="  NW"
7060   IF CD>326.25! THEN B2$=" NNW"
7070   IF CD>348.75! THEN B2$="  N "
7080   IF CD=-1     THEN B2$="  - "
7090 B$=B$+B2$
7100 B3$=STR$(DIS)
7110 IF LEN(B3$)<5 THEN B3$=" "+B3$:GOTO 7110
7120 B$=B$+B3$
7130 B4$=A$(Y,1)
7140 IF LEN(B4$)<6 THEN B4$=B4$+" ":GOTO 7140
7150 B$=B$+"  "+B4$+"  "+(A$(Y,3))+"  "+A$(Y,4)+"  "+A$(Y,5)
7160 B$=B$+"  "+A$(Y,2)
7170 J=J+1:B$(J)=B$:B$=""
7180    NEXT Y
7190 :REM'
7200 :REM'******START SORT******
7210 SN=J
7220 SM=SN
7230 SM=INT(SM/2):IF SM=0 THEN CLS:GOTO 7330
7240 SK=SN-SM:SJ=1
7250 SI=SJ
7260 SL=SI+SM
7270 IF LEFT$(B$(SI),4)<=LEFT$(B$(SL),4)THEN 7290 :ELSE SWAP B$(SI),B$(SL)
7280 SI=SI-SM:IF SI>0 THEN 7260
7290 SJ=SJ+1:IF SJ>SK THEN 7230
7300 GOTO 7250
7310 :REM'******SORT COMPLETED******
7320 :REM'
7330 :REM'.....display
7340 PRINT TAB(13);"Repeaters within";USING U3$;KM/UM;
7350 PRINT " ";UM$;" of ";A$(Z,2)
7360 PRINT TAB(13);"(in clockwise order from True North)"
7370 PRINT UL$;
7380 PRINT " Bearing";TAB(13);"Km";TAB(18);"Call";TAB(25);"Output";
7390 PRINT TAB(33);"Offset";TAB(41);"Input";TAB(49);"Location"
7400 PRINT UL$;
7410 LN=5
7420 FOR Z=1 TO J
7430  LN=LN+1
7440  PRINT B$(Z);
7450 IF LN <24 THEN PRINT "":GOTO 7470
7460 GOSUB 7610:LN=0:CLS:GOTO 7470
7470 NEXT Z
7480 PRINT "":GOSUB 7610
7490 GOTO 240   :REM'start
7500 :REM'
7510 :REM'.....preface
7520 TX=7
7530 PRINT TAB(TX);
7540 PRINT "While this program is primarily a data base (which you can edit)"
7550 PRINT TAB(TX);
7560 PRINT "of your local repeaters, it also computes interesting information"
7570 PRINT TAB(TX);
7580 PRINT "and screen displays concerning them."
7590 RETURN
7600 :REM'
7610 :REM'PRT
7620 KEY OFF:GOSUB 7690:LOCATE 25,5:COLOR 0,2
7630 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
7640 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
7650 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 7650 :ELSE GOSUB 7690
7660 IF Z$="3"THEN RETURN
7670 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
7680 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 7620
7690 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
