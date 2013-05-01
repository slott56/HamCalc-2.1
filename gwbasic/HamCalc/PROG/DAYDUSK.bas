10 :REM'\hamcalc\prog\DAYDUSK - Daylight, Dawn & Dusk - 24 MAY 01
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$,PROG$
50 COLOR 7,0,0
60 PI=4*ATN(1)  :REM'3.141593
70 A=PI/2
80 B=PI
90 C=1.5!*PI
100 D=2*PI
110 U1$=STRING$(80,205)
120 U2$=STRING$(40,196)
130 :REM'
140 :REM'.....title page
150 CLS
160 COLOR 15,2
170 PRINT " DAYLIGHT DUSK & DAWN CALCULATOR"TAB(66)"Author Unknown ";
180 COLOR 1,0:PRINT STRING$(80,223);
190 COLOR 15,2:LOCATE CSRLIN-1,18
200 PRINT " Edited for HAMCALC by George Murphy, VE3ERP "
210 COLOR 7,0
220 PRINT:GOSUB 2740   :REM'proloque
230 PRINT U1$;
240 PRINT " Press number in < > to:"
250 PRINT U1$;
260 PRINT "   < 1 > run this program"
270 PRINT "   < 2 > run Sunrise/Sunset program"
280 PRINT "   < 0 > EXIT";
290 Z$=INKEY$:IF Z$=""THEN 290
300 IF Z$="0"THEN CLS:CHAIN EX$
310 IF Z$="1"THEN 360
320 IF Z$="2"THEN CLS:CHAIN"\hamcalc\prog\riseset"
330 GOTO 290
340 END
350 :REM'
360 :REM'.....data input
370 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 4
380 INPUT " ENTER: Latitude, in decimal degrees (minus if south)...";Z1
390 IF SGN(Z1)=-1 THEN LAT$="S":ELSE LAT$="N"
400 LAT=Z1*0.017453299835324287!
410 INPUT " ENTER: Longitude, in decimal degrees (minus if west)...";Z2
420 IF SGN(Z2)=-1 THEN LONG$="W":ELSE LONG$="E"
430 LONG=-Z2*0.017453299835324287!
440 UT=FIX(Z2/15)   :REM'UTC time differential
450 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
460 Z$=" Location..............  ##.#°"+LAT$+" ###.#°"+LONG$
470 Z$=Z$+".   Local UTC Zone: UTC +## hours"
480 PRINT USING Z$;ABS(Z1),ABS(Z2),UT
490 PRINT U1$;
500 :REM'
510 INPUT " ENTER: Year...........";H
520 INPUT " ENTER: Month no. .....";I
530 INPUT " ENTER: Day no. .......";J
540 VIEW PRINT 5 TO 24:CLS:VIEW PRINT:LOCATE 5
550 PRINT USING " Date (y/m/d).......... ####/##/##";H,I,J
560 :REM'
570 REM UT=FIX(Z2/15)   'UTC time differential
580 :REM'
590 GOSUB 1370
600 ZONE=-UT*0.26179900765419006!  :REM'UTC time zone
610 :REM'
620 :REM'.....day of year
630 K=INT((I+9)/12)
640 X=H/4
650 Y=INT(X)
660 Z=X-Y
670 IF Z=0 THEN 690
680 K=K*2
690 H=INT(275*I/9)
700 H=H+J-K-30
710 :REM'
720 :REM'.....rising phenomena
730 I=0
740 J=A
750 GOSUB 1500
760 :REM'
770 PRINT U1$;
780 :REM'
790 R=-0.30901700258255005!
800 PRINT TAB(22)"local solar"
810 PRINT TAB(25)"time"
820 GOSUB 2030
830 PRINT " Astronomical Dawn..... ";V$;" = ";UTC$;" UTC";
840 PRINT "   Sun 18° below horizon"
850 :REM'
860 R=-0.20791199803352356!
870 GOSUB 2030
880 PRINT " Nautical Dawn......... ";V$;" = ";UTC$;" UTC";
890 PRINT "   Sun 12° below horizon"
900 :REM'
910 R=-0.10452800244092941!
920 GOSUB 2030
930 PRINT " Civil Dawn............ ";V$;" = ";UTC$;" UTC";
940 PRINT "   Sun  6° below horizon"
950 :REM'
960 R=-0.014543900266289711!
970 GOSUB 2030
980 PRINT " Sunrise............... ";V$;" = ";UTC$;" UTC";
990 PRINT "   Top of sun at the horizon"
1000 :REM'
1010 PRINT U2$
1020 :REM'
1030 :REM'.....setting phenomena
1040 I=1
1050 J=C
1060 GOSUB 1500
1070 :REM'
1080 R=-0.014543900266289711!
1090 GOSUB 2030
1100 PRINT " Sunset................ ";V$;" = ";UTC$;" UTC";
1110 PRINT "   Top of sun at the horizon"
1120 :REM'
1130 R=-0.10452800244092941!
1140 GOSUB 2030
1150 PRINT " Civil Dusk............ ";V$;" = ";UTC$;" UTC";
1160 PRINT "   Sun  6° below horizon"
1170 :REM'
1180 R=-0.20791199803352356!
1190 GOSUB 2030
1200 PRINT " Nautical Dusk......... ";V$;" = ";UTC$;" UTC";
1210 PRINT "   Sun 12° below horizon"
1220 :REM'
1230 R=-0.30901700258255005!
1240 GOSUB 2030
1250 PRINT " Astronomical Dusk..... ";V$;" = ";UTC$;" UTC";
1260 PRINT "   Sun 18° below horizon"
1270 :REM'
1280 PRINT U1$;
1290 PRINT " UTC zone local SOLAR times shown. Times vary with longitude acro";
1300 PRINT "ss the UTC  "
1310 PRINT " time zone at the rate of 4 minutes per degree of longitude.     "
1320 PRINT U1$;
1330 GOTO 3000
1340 :REM'
1350 :REM'.....sexagesimal to decimal
1360 :REM'
1370 W=1
1380 IF Z>=0 THEN 1460
1390 W=-1
1400 Z=ABS(Z)
1410 X=INT(Z)
1420 Z=(Z-X)*100
1430 Y=INT(Z)
1440 Z=(Z-Y)*100
1450 Z=(X+Y/60+Z/3600)*W
1460 RETURN
1470 :REM'
1480 :REM'.....approximate time
1490 :REM'
1500 K=H+((J+LONG)/D)
1510 :REM'
1520 :REM'.....solar mean anomoly
1530 :REM'
1540 L=K*0.017201999202370644!
1550 L=L-0.05740389972925186!
1560 :REM'
1570 :REM'.....solar true longitutde
1580 :REM'
1590 Z=SIN(L)
1600 M=L+0.03344050049781799!*Z
1610 Z=SIN(2*L)
1620 M=M+0.00034906598739326!*Z
1630 M=M+4.932889938354492!
1640 :REM'
1650 :REM'.....quadrant determination
1660 :REM'
1670 Z=M
1680 GOSUB 2660
1690 M=Z
1700 X=M/A
1710 Y=INT(X)
1720 Z=X-Y
1730 IF Z<>0 THEN 1750
1740 M=M+4.848140179092297e-06!
1750 N=2
1760 IF M>C THEN 1830
1770 N=1
1780 IF M>A THEN 1830
1790 N=0
1800 :REM'
1810 :REM'.....solar right ascension
1820 :REM'
1830 P=0.917460024356842!*TAN(M)
1840 P=ATN(P)
1850 :REM'
1860 :REM'.....quadrant adjustment
1870 :REM'
1880 IF N=0 THEN 1960
1890 IF N=2 THEN 1920
1900 P=P+B
1910 GOTO 1960
1920 P=P+D
1930 :REM'
1940 :REM'.....solar declination
1950 :REM'
1960 Q=0.39781999588012695!*SIN(M)
1970 Q=Q/SQR(-Q*Q+1)
1980 Q=ATN(Q)
1990 RETURN
2000 :REM'
2010 :REM'.....coordinate conversion
2020 :REM'
2030 S=R-(SIN(Q)*SIN(LAT))
2040 S=S/(COS(Q)*COS(LAT))
2050 :REM'
2060 :REM'.....null phenomenon
2070 :REM'
2080 Z=ABS(S)
2090 IF Z<=1 THEN 2150
2100 V=0
2110 RETURN
2120 :REM'
2130 :REM'.....adjustment
2140 :REM'
2150 S=S/SQR(-S*S+1)
2160 S=-ATN(S)+A
2170 IF I=1 THEN 2220
2180 S=D-S
2190 :REM'
2200 :REM'.....local apparent time
2210 :REM'
2220 Z=0.017202800139784813!*K
2230 T=S+P-Z-1.7336399555206299!
2240 :REM'
2250 :REM'.....universal time
2260 :REM'
2270 U=T+LONG
2280 :REM'
2290 :REM'.....wall clock time
2300 :REM'
2310 V=U-ZONE
2320 :REM'
2330 :REM'.....decimal to sexigesimal
2340 :REM'
2350 Z=V
2360 GOSUB 2660
2370 Z=Z*3.8197200298309326!
2380 V=INT(Z)
2390 W=(Z-V)*60
2400 X=INT(W)
2410 Y=W-X
2420 IF Y<0.5! THEN 2440
2430 X=X+1
2440 IF X<60 THEN 2500
2450 V=V+1
2460 X=0
2470 :REM'
2480 :REM'.....conventional format
2490 :REM'
2500 Z$="00"
2510 HR$=MID$(STR$(V),2)
2520 HR$=RIGHT$(Z$+HR$,2)
2530 MI$=MID$(STR$(X),2)
2540 MI$=RIGHT$(Z$+MI$,2)
2550 V$=HR$+":"+MI$
2560 UTC=VAL(HR$)-UT
2570 IF UTC<0 THEN UTC=UTC+24:GOTO 2590
2580 IF UTC>24 THEN UTC=UTC-24
2590 UTC$=STR$(UTC):UTC$=RIGHT$(UTC$,LEN(UTC$)-1)
2600 IF LEN(UTC$)<2 THEN UTC$="0"+UTC$:GOTO 2600
2610 UTC$=UTC$+MI$
2620 RETURN
2630 :REM'
2640 :REM'.....normalization
2650 :REM'
2660 IF Z>=0 THEN 2690
2670 Z=Z+D
2680 GOTO 2660
2690 IF Z<D THEN 2720
2700 Z=Z-D
2710 GOTO 2690
2720 RETURN
2730 :REM'
2740 :REM'.....prologue
2750 PRINT " This program computes times of sunrise, sunset, dawn and dusk at";
2760 PRINT " any location."
2770 PRINT
2780 PRINT " Enter the latitude and longitude of the location in decimal degr";
2790 PRINT "ees. If the   "
2800 PRINT " latitude is south of the equator enter the latitude as a minus (";
2810 PRINT "-) value or as"
2820 PRINT " a positive value if north of the equator. If the longitude is we";
2830 PRINT "st of the     "
2840 PRINT " prime meridian (0° - Greenwich) enter the longitude as a minus (";
2850 PRINT "-) value or as"
2860 PRINT " a positive value if west of the prime meridian.                 "
2870 PRINT
2880 PRINT " Times calculated are local sidereal (SOLAR) times. Forget about ";
2890 PRINT "Standard Time,"
2900 PRINT " Daylight Saving Time, local political time, UTC, or any other ma";
2910 PRINT "n-made time   "
2920 PRINT " system. Sidereal time is time referenced to the stars. It is the";
2930 PRINT " time shown   "
2940 PRINT " for millenia on properly installed sun dials.                   "
2950 PRINT
2960 PRINT " Related data can also be calculated using Hamcalc's `Sunrise/Sun";
2970 PRINT "set' program. "
2980 RETURN
2990 :REM'
3000 :REM'.....end
3010 GOSUB 3030:GOTO 140
3020 :REM'
3030 :REM'.....PRT
3040 KEY OFF:GOSUB 3110:LOCATE 25,5:COLOR 0,2
3050 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3060 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3070 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3070 :ELSE GOSUB 3110
3080 IF Z$="3"THEN RETURN
3090 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3100 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3040
3110 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
