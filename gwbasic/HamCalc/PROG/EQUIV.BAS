10 :REM'\hamcalc\prog\EQUIV - 09 SEP 92 rev. 14 SEP 2002
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 DIM X(20)
80 DIM U$(20)
90 UL$=STRING$(80,205)
100 ER$=STRING$(80,32)
110 L$=STRING$(80,223)
120 PI=3.1415929794311523!
130 :REM'
140 :REM'.....start
150 CLS
160 COLOR 15,2
170 PRINT " EQUIVALENT VALUES";TAB(57);"by George Murphy VE3ERP ";
180 COLOR 1,0:PRINT STRING$(80,223);
190 COLOR 7,0
200 IF DMS=1 THEN 1630
210 PRINT " Press number in < > to determine equivalent values of:"
220 PRINT UL$;
230 PRINT "  < a >  Capacitance"
240 PRINT "  < b >  Current"
250 PRINT "  < c >  Degrees / Minutes / Seconds"
260 PRINT "  < d >  Degrees / Radians"
270 PRINT "  < e >  Frequencies/Wavelengths"
280 PRINT "  < f >  Inductance"
290 PRINT "  < g >  Length / Distance"
300 PRINT "  < h >  Transmission Line Length"
310 PRINT "  < i >  Resistance"
320 PRINT "  < j >  Temperature"
330 PRINT "  < k >  Time"
340 PRINT "  < l >  Sexigesimal/decimal converter"
350 PRINT "  < m >  Miles per imperial gallon / kilometres per litre"
360 PRINT "  < n >  Electrical length / Physical length"
370 PRINT UL$;
380 PRINT "  < z >  EXIT program"
390 Y$=INKEY$:IF Y$=""THEN 390
400 IF Y$="z"THEN CLS:CHAIN GO$
410 IF Y$="a"THEN 930
420 IF Y$="b"THEN 1140
430 IF Y$="c"THEN 1560
440 IF Y$="d"THEN 2240
450 IF Y$="e"THEN 1230
460 IF Y$="f"THEN 1030
470 IF Y$="g"THEN 1340
480 IF Y$="h"THEN 2570
490 IF Y$="i"THEN 1470
500 IF Y$="j"THEN 2390
510 IF Y$="k"THEN 2120
520 IF Y$="l"THEN CLS:CHAIN"deciconv"
530 IF Y$="m"THEN 2890
540 IF Y$="n"THEN 3130
550 GOTO 390
560 :REM'
570 :REM'.....screen display
580 CLS
590 COLOR 1,1:PRINT ER$;:LOCATE CSRLIN-1
600 COLOR 15,1:PRINT " EQUIVALENT ";T$;" "
610 COLOR 1,0:PRINT L$;
620 COLOR 7,0
630 PRINT " Press number in < > to select base unit:"
640 PRINT UL$;
650 FOR Z=1 TO N
660 PRINT "  (";Z;")  ";U$(Z)
670 NEXT Z
680 Z$=INKEY$:IF U$(VAL(Z$))=""THEN 680 :ELSE 700
690 GOTO 680
700 LOCATE 3:PRINT ER$;:LOCATE 3
710 IF Y$="c"THEN 1630  :REM'deg/min/sec
720 PRINT " ENTER: How many ";U$(VAL(Z$));:INPUT Q#
730 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1
740 PRINT USING "########,###.###";Q#;:PRINT " ";U$(VAL(Z$))+" ="
750 IF Y$="j"THEN 2460   :REM'print
760 Y#=Q#/X(VAL(Z$))
770 IF Y$="d"THEN 2310
780 IF X(VAL(Z$))=999 THEN Y#=299792.458#/Q#      :REM'frequency/wavelength only
790 FOR Z=1 TO N:J#=Y#*X(Z)
800 IF X(Z)=999 THEN J#=299792.458#/(Y#/1000.0!)  :REM'frequency/wavelength ony
810 K#=INT(J#*10^2+0.5!)/10^2:U$="##,###.##":TOL$=".01"
820 IF Y$="c"THEN K#=INT(J#*10^3+0.5!)/10^3:U$="##,###.###":TOL$=".001"
830 IF Y$="a"OR Y$="f"THEN K#=INT(J#*10^4+0.5!)/10^4:U$="##,###.####":TOL$=".0001"
840 LOCATE 4+Z,34:PRINT " = ";
850 IF K#<VAL(TOL$) THEN PRINT "     -       less than ";TOL$:GOTO 880
860 IF K#>=10^5 THEN PRINT "     -       more than 99,999.999":GOTO 880
870 PRINT USING U$;K#
880 NEXT Z
890 PRINT UL$;
900 PRINT TAB(14);"Values shown are rounded off to the nearest ";TOL$
910 GOTO 3370
920 :REM'
930 :REM'.....Capacitance
940 CLS
950 T$="CAPACITANCES"
960 U$(1)="Farads..............(F)":X(1)=1
970 U$(2)="Microfarads........(µF)":X(2)=10^6
980 U$(3)="Nanofarads.........(nF)":X(3)=10^9
990 U$(4)="Picofarads.........(pF)":X(4)=10^12
1000 N=4
1010 GOTO 570
1020 :REM'
1030 :REM'.....Inductance
1040 CLS
1050 T$="INDUCTANCES"
1060 U$(1)="Henrys..............(H)":X(1)=1
1070 U$(2)="Millihenrys........(mH)":X(2)=10^3
1080 U$(3)="Microhenrys........(µH)":X(3)=10^6
1090 U$(4)="Nanohenrys.........(nH)":X(4)=10^9
1100 U$(5)="Picohenrys.........(pH)":X(5)=10^12
1110 N=5
1120 GOTO 570
1130 :REM'
1140 :REM'.....Current
1150 CLS
1160 T$="CURRENTS"
1170 U$(1)="Amperes.............(A)":X(1)=1
1180 U$(2)="Milliamperes.......(mA)":X(2)=10^3
1190 U$(3)="Microamperes.......(µA)":X(3)=10^6
1200 N=3
1210 GOTO 570
1220 :REM'
1230 :REM'.....Frequency
1240 CLS
1250 T$="FREQUENCIES/WAVELENGTHS"
1260 U$(1)="hertz..............(Hz)":X(1)=1
1270 U$(2)="kilohertz.........(kHz)":X(2)=10^-3
1280 U$(3)="megahertz.........(MHz)":X(3)=10^-6
1290 U$(4)="gigahertz.........(GHz)":X(4)=10^-9
1300 U$(5)="wavelength (metres)....":X(5)=999
1310 N=5
1320 GOTO 570
1330 :REM'
1340 :REM'.....Lengths/Distances
1350 CLS
1360 T$="LENGTHS/DISTANCES"
1370 U$(1)="Millimetres........(mm)":X(1)=10^3
1380 U$(2)="Centimeters........(cm)":X(2)=10^2
1390 U$(3)="Metres..............(m)":X(3)=1
1400 U$(4)="Kilometres.........(km)":X(4)=0.0010000000474974513!
1410 U$(5)="Inches.............(in)":X(5)=39.369998931884766!
1420 U$(6)="Feet...............(ft)":X(6)=39.369998931884766!/12
1430 U$(7)="Miles..............(mi)":X(7)=39.369998931884766!/12/5280
1440 N=7
1450 GOSUB 570
1460 :REM'
1470 :REM'.....Resistance
1480 CLS
1490 T$="RESISTANCES"
1500 U$(1)="Ohms................(Ω)":X(1)=1
1510 U$(2)="Kilohm.............(kΩ)":X(2)=10^-3
1520 U$(3)="Megohm.............(MΩ)":X(3)=10^-6
1530 N=3
1540 GOTO 570
1550 :REM'
1560 :REM'.....Degrees/Minutes/Seconds
1570 CLS
1580 T$="DEGREES/MINUTES/SECONDS"
1590 U$(1)="Decimal degrees"
1600 U$(2)="Degrees/Minutes/Seconds"
1610 N=2
1620 GOTO 570
1630 IF LN=0 THEN LN=4
1640 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE 21
1650 T=7
1660 PRINT TAB(T);
1670 PRINT "Calculated values are to the nearest .001 degree and nearest second"
1680 PRINT TAB(T);
1690 PRINT "of angle. 0.001° of latitude = approximately 100m.(350 ft.) and one"
1700 PRINT TAB(T);
1710 PRINT "second (1";CHR$(34);") of angle = approx. 30m.(100ft.)."
1720 LOCATE 3
1730 IF DMS=1 THEN 1900
1740 IF Z$="2"THEN 1900
1750 LOCATE LN
1760 INPUT " ENTER: Decimal degrees ";D
1770 LOCATE LN:PRINT ER$;:LOCATE LN
1780 D1=INT(D)           :REM'degrees
1790 D2=(D-D1)*60        :REM'minutes
1800 D3=(D2-INT(D2))*60  :REM'seconds
1810 D2=INT(D2)
1820 D3=INT(D3+0.5!)
1830 IF D3=60 THEN D2=D2+1:D3=0
1840 IF D2=60 THEN D1=D1+1:D2=0
1850 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1860 PRINT STR$(D);"° =";STR$(D1);"°";STR$(D2);"'";STR$(D3);CHR$(34)
1870 TOL$="second of angle"
1880 GOTO 2040
1890 :REM'
1900 LOCATE 3:COLOR 0,7
1910 PRINT " Enter Degrees, Minutes and Seconds as three separate entities:"
1920 LOCATE LN:COLOR 7,0
1930 INPUT " ENTER: Whole degrees......";D
1940 IF D<>INT(D)THEN LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:BEEP:GOTO 1930
1950 INPUT " ENTER: Whole minutes......";M
1960 IF M<>INT(M)THEN LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:BEEP:GOTO 1950
1970 INPUT " ENTER: Seconds............";S
1980 D1=D+M/60+S/3600
1990 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
2000 PRINT USING " ####° ##' ##.#"+CHR$(34)+" = ";D,M,S;
2010 PRINT USING "####.###°";D1
2020 TOL$=".001°"
2030 :REM'
2040 COLOR 0,7:LOCATE ,20:PRINT " Do you want to do another?   (y/n) "
2050 COLOR 7,0
2060 J$=INKEY$:IF J$=""THEN 2060
2070 IF J$="n"OR J$="y"THEN LOCATE CSRLIN-1:PRINT STRING$(80,32);
2080 IF J$="n"THEN LOCATE 3:PRINT STRING$(80,32);:LOCATE LN+1:GOTO 890
2090 IF J$="y"THEN LN=LN+1:GOTO 1630
2100 GOTO 2060
2110 :REM'
2120 :REM'.....Time
2130 CLS
2140 T$="TIMES"
2150 U$(1)="Seconds................":X(1)=1
2160 U$(2)="Minutes................":X(2)=1/60
2170 U$(3)="Hours..................":X(3)=1/3600
2180 U$(4)="Days...................":X(4)=1/86400.0!
2190 U$(5)="Weeks..................":X(5)=1/604800.0!
2200 U$(6)="Years (365.25 days)....":X(6)=1/31557600.0#
2210 N=6
2220 GOTO 570
2230 :REM'
2240 :REM'.....deg/rad
2250 CLS
2260 T$="DEGREES / RADIANS"
2270 U$(1)="Degrees................":X(1)=180/PI
2280 U$(2)="Radians................":X(2)=PI/180
2290 N=2
2300 GOTO 570
2310 :REM'.....print deg/rad
2320 LOCATE 5,2
2330 A=1:B=2:IF Q#<Y# THEN SWAP A,B
2340 PRINT U$(A);USING "####.####";Q#
2350 LOCATE 6,2
2360 PRINT U$(B);USING "####.####";Y#
2370 TOL$=".0001":GOTO 890
2380 :REM'
2390 :REM'.....temperature
2400 CLS
2410 T$="TEMPERATURE"
2420 U$(1)="Degrees Fahrenheit....."
2430 U$(2)="Degrees Celsius........"
2440 N=2
2450 GOTO 570
2460 :REM'.....print temperature
2470 IF Z$="1"THEN Y#=(Q#-32)/1.7999999523162842!
2480 IF Z$="2"THEN Y#=1.7999999523162842!*Q#+32
2490 LOCATE 5,2
2500 A=1:B=2:IF Q#<Y# THEN SWAP A,B
2510 PRINT U$(A);USING "######.#";Q#
2520 LOCATE 6,2
2530 PRINT U$(B);USING "######.#";Y#
2540 PRINT UL$;
2550 GOTO 3370
2560 :REM'
2570 :REM'.....transmission line length
2580 CLS:L=0:N=0:F=0:V=0
2590 T$=" TRANMISSION LINE LENGTH - PHYSICAL vs. ELECTRICAL"
2600 PRINT T$
2610 PRINT UL$;
2620 COLOR 7,0
2630 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2640 IF L OR N THEN 2660
2650 INPUT " ENTER: Line length in feet....(if known)....";L:GOSUB 2740
2660 IF N OR L THEN 2680
2670 INPUT " ENTER: Line length in degrees (if known)....";N:GOSUB 2740
2680 IF F THEN 2700
2690 INPUT " ENTER: Frequency in MHz.....................";F:GOSUB 2740
2700 IF V THEN 2720
2710 INPUT " ENTER: Velocity factor of line (decimal)....";V:GOSUB 2740
2720 GOTO 2630
2730 :REM'
2740 :REM'.....calculate
2750 IF L=0 AND N*F*V<>0 THEN L=984*V*N/(F*360)
2760 IF N=0 AND L*F*V<>0 THEN N=L*F*360/(984*V)
2770 IF L*N*F*V<>0 THEN 2780 :ELSE RETURN
2780 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2790 U$="#####.###"
2800 PRINT " Frequency....................";USING U$;F;:PRINT " MHz"
2810 PRINT " Velocity factor of line......";USING U$;V
2820 PRINT " Line length, physical........";USING U$;L;:PRINT " feet =";
2830 PRINT USING U$;L*0.30480000376701355!;:PRINT " metres"
2840 PRINT " Line length, electrical......";USING U$;N;:PRINT "°"
2850 PRINT
2860 PRINT " Ref: HAMCALC "CHR$(34)"Transmission Line Length"CHR$(34)" program."
2870 GOTO 3370
2880 :REM'
2890 :REM'.....mpg - km/litre
2900 CLS:MPG=0:KPL=0
2910 M$=" Miles per imperial gallon..."
2920 K$=" Kilometres per litre........"
2930 LOCATE 23,22:PRINT "1 Imperial gallon = 1.2 U.S. gallons"
2940 LOCATE 12
2950 PRINT " Is known factor (m)iles per imperial gallon or (k)ilometres ";
2960 PRINT "per litre?  (m/k)"
2970 Z$=INKEY$:IF Z$=""THEN 2970
2980 IF Z$="m"THEN A$=M$:B$=K$
2990 IF Z$="k"THEN A$=K$:B$=M$
3000 PRINT
3010 PRINT " ENTER: ";A$;:INPUT Z
3020 IF Z$="m"THEN A=Z:B=Z*0.3540000021457672!:C=100/B:D=A/1.2000000476837158!
3030 IF Z$="k"THEN A=Z:B=Z/0.3540000021457672!:C=100/A:D=B/1.2000000476837158!
3040 CLS:LOCATE 12
3050 PRINT A$;USING " ###.## = ###.##"+B$;A,B
3060 PRINT
3070 PRINT USING " Litres per 100 km........... ###.##";C
3080 PRINT USING " Miles per U.S.gallon........ ###.##";D
3090 LOCATE 23,22:PRINT "1 Imperial gallon = 1.2 U.S. gallons"
3100 GOTO 3370
3110 END
3120 :REM'
3130 :REM'.....electrical length
3140 CLS:PRINT " Electrical Length"
3150 PRINT UL$;
3160 INPUT " ENTER: Frequency in MHZ";F
3170 IF F=0 THEN 3160
3180 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
3190 PRINT " Is known length in (d)egrees, (i)nches, or (c)entimetres? (d/i/c)"
3200 L$=INKEY$:IF L$=""THEN 3200
3210 IF L$="d"OR L$="i" OR L$="c"THEN 3230
3220 GOTO 3200
3230 IF L$="d"THEN Z$="degrees"
3240 IF L$="i"THEN Z$="inches"
3250 IF L$="c"THEN Z$="centimetres"
3260 PRINT " ENTER: Length (";Z$;")";:INPUT L
3270 IF L$="d"THEN LD=L:LI=L*(32.79999923706055!/F):LC=LI*2.5399999618530273!:GOTO 3300
3280 IF L$="i"THEN LI=L:LC=LI*2.5399999618530273!:LD=LI/(32.79999923706055!/F):GOTO 3300
3290 IF L$="c"THEN LC=L:LI=LC/2.5399999618530273!:LD=LI/(32.79999923706055!/F):GOTO 3300
3300 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
3310 PRINT USING " Frequency.......... ###.### MHz";F
3320 PRINT USING " Electrical length.. ###.### deg.";LD
3330 PRINT USING " Physical length.... ###.### in.";LI
3340 PRINT USING "                .... ###.### cm.";LC
3350 GOTO 3370
3360 :REM'
3370 :REM'.....end
3380 GOSUB 3420
3390 IF DMS=1 THEN DMS=0:CHAIN PROG$
3400 DMS=0:GOTO 140     :REM'start
3410 :REM'
3420 :REM'PRT
3430 KEY OFF:GOSUB 3500:LOCATE 25,5:COLOR 0,2
3440 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3450 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3460 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3460 :ELSE GOSUB 3500
3470 IF Z$="3"THEN RETURN
3480 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3490 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3430
3500 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
