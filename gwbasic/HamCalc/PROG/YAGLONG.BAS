10 :REM'YAGILONG - Extremely Long Yagi - 06 MAY 95 rev.13 APR 97
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COLOR 7,0,1
50 DIM S(100),D(100),DH(100),DL(100),T(100)
60 UL$=STRING$(80,205)
70 U$="#####.###"
80 :REM'
90 :REM'.....start
100 CLS
110 COLOR 15,2
120 PRINT " YAGI ANTENNA - Extremely Long";TAB(60);"by Günter Hoch DL6WU ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 TB=9
160 PRINT TAB(TB);
170 PRINT "Program written by Jerry Haigwood, KY4Z, and Bob Stein, W6NBI,"
180 PRINT TAB(TB);
190 PRINT "based on the article 'Extremely Long Yagi Antennas' by Günter"
200 PRINT TAB(TB);
210 PRINT "Hoch, DL6WU, in the March 1981 issue of VHF Communications."
220 PRINT TAB(TB);
230 PRINT "Program edited for HAMCALC by George Murphy, VE3ERP."
240 PRINT UL$;
250 COLOR 0,7:LOCATE CSRLIN,22
260 PRINT " Press 1 to continue or 0 to EXIT....."
270 COLOR 7,0
280 Z$=INKEY$:IF Z$=""THEN 280
290 IF Z$="0"THEN CLS:RUN EX$
300 IF Z$="1"THEN 320
310 GOTO 290
320 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
330 :REM'
340 :REM'.....input frequency
350 INPUT " ENTER: Design Frequency (MHz)........";F
360 IF F>0 GOTO 400
370 PRINT : PRINT" ---> STOP FOOLING AROUND - ENTER A FREQUENCY!"
380 PRINT : GOTO 350
390 :REM'
400 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
410 CM=29979.30078125! : I=11802.900390625!:REM'Wavelength factors for cm and in.
420 PRINT " Press number in < > to choose how you want to enter dimensions:"
430 PRINT UL$;
440 PRINT "   < 1 >  Inches"
450 PRINT "   < 2 >  Centimetres"
460 PRINT "   < 3 >  Wavelengths"
470 P$=INKEY$
480 IF P$="1" OR P$="2" OR P$="3" THEN 510
490 GOTO 470
500 :REM'
510 PRINT UL$;
520 IF P$="1"THEN PP$=" inches "
530 IF P$="2"THEN PP$=" cm "
540 IF P$="3"THEN PP$=" wavelengths "
550 PRINT " Press number in < > to select design option:"
560 PRINT UL$;
570 PRINT "   < 1 >  Enter antenna gain in dBd and accept calculated boom ";
580 PRINT "length"
590 PRINT "          ( dBd = gain over a half-wave dipole )"
600 PRINT "   < 2 >  Enter boom length and accept calculated gain"
610 B$=INKEY$
620 IF B$="1" OR B$="2" THEN 650
630 GOTO 610
640 :REM'
650 PRINT UL$;
660 PRINT " Press number in < > to select type of construction:"
670 PRINT UL$;
680 PRINT "   < 1 >  Elements pass through and are NOT insulated from a metal ";
690 PRINT "boom"
700 PRINT "   < 2 >  Elements pass through and ARE insulated from a metal boom"
710 PRINT "   < 3 >  A non-metallic boom is used"
720 PRINT "          --- OR ---"
730 PRINT "          Elements are mounted on insulators above or below a metal"
740 PRINT "          boom with metal-to-metal spacing greater than the boom ";
750 PRINT "radius"
760 E$=INKEY$
770 IF E$="1" OR E$="2" OR E$="3" THEN 800
780 GOTO 760
790 :REM'
800 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
810 IF B$="2" THEN 1090
820 :REM'
830 PRINT" ANTENNA GAIN MUST BE BETWEEN 11.8 dBd AND 21.5 dBd"
840 PRINT
850 INPUT" ENTER: Antenna Gain (dBd)........" ;G
860 IF G>=11.800000190734863! AND G<=21.5! THEN 930
870 PRINT" ---> GAIN IS OUT OF RANGE - TRY AGAIN!"
880 PRINT " Press any key to continue......"
890 IF INKEY$=""THEN 890
900 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
910 GOTO 830
920 :REM'
930 :REM'.....boom wavelengths for specified gain
940 BL=EXP((G-9.199999809265137!)/3.390000104904175!)
950 B1=BL*I/F:REM'Boom length in in.
960 B2=BL*CM/F:REM'Boom length in cm
970 B3=B1/12:REM'Boom length in ft
980 PRINT
990 PRINT " THEORETICAL BOOM LENGTH FROM REFLECTOR TO LAST DIRECTOR:"
1000 PRINT USING"  ###.## feet =  ####.## inches =  #####.# cm";B3,B1,B2
1010 PRINT
1020 PRINT " Do you want to use this boom length?  (y/n)"
1030 C$=INKEY$
1040 IF C$="Y"OR C$="y"THEN 1440
1050 IF C$="N"OR C$="n"THEN 1070
1060 GOTO 1030
1070 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 550
1080 :REM'
1090 :REM'.....boom length
1100 PRINT " BOOM LENGTH FROM REFLECTOR TO LAST DIRECTOR MUST BE BETWEEN"
1110 PRINT" 2.2 AND 38.5 WAVELENGTHS"
1120 PRINT
1130 INCH1=INT(2.200000047683716!*I/F*10^2+0.5!)/10^2:INCH2=INT(38.5!*I/F*10^2+0.5!)/10^2
1140 CENT1=INT(2.200000047683716!*CM/F*10+0.5!)/10:CENT2=INT(38.5!*CM/F*10+0.5!)/10
1150 IF P$="1"THEN PRINT " Length @";F;"MHz must be between";INCH1;"and";
1160 IF P$="1"THEN PRINT INCH2;"inches"
1170 IF P$="2"THEN PRINT " Length @";F;"MHz must be between";CENT1;"and";
1180 IF P$="2"THEN PRINT CENT2;"cm"
1190 PRINT
1200 PRINT " ENTER: Boom Length (";PP$;").....";:INPUT BL
1210 IF P$="1" AND BL=>2.200000047683716!*I/F AND BL=<38.5!*I/F GOTO 1290
1220 IF P$="2" AND BL=>2.200000047683716!*CM/F AND BL=<38.5!*CM/F GOTO 1290
1230 IF P$="3" AND BL=>2.200000047683716! AND BL=<38.5! GOTO 1290
1240 PRINT
1250 GOSUB 3430
1260 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 1090
1270 GOTO 1110
1280 :REM'
1290 A=BL
1300 GOSUB 3270
1310 BL=A:REM'Boom wavelengths
1320 G=9.199999809265137!+3.390000104904175!*LOG(BL) :REM'Gain in terms of boom length
1330 PRINT
1340 PRINT USING" THEORETICAL MAX. ANTENNA GAIN = ##.# dBd -- IT MAY BE LESS";G
1350 PRINT
1360 PRINT " Do you want to accept this gain?  (y/n)"
1370 A$=INKEY$
1380 IF A$="Y"OR A$="y"THEN 1440
1390 IF A$="N"OR A$="n"THEN 1420
1400 GOTO 1370
1410 IF A$="Y" OR A$="y" THEN 1440
1420 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 1090
1430 :REM'
1440 IF E$="3" GOTO 1640
1450 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1460 PRINT" BOOM DIAMETER MUST BE LESS THAN 0.075 WAVELENGTH"
1470 PRINT
1480 INCH=INT(0.07500000298023224!*I/F*10^3+0.5!)/10^3
1490 CENT=INT(0.07500000298023224!*CM/F*10^2)/10^2
1500 IF P$="1"THEN PRINT " 0.075 Wavelength @";F;"MHz =";INCH;"inches"
1510 IF P$="2"THEN PRINT " 0.075 Wavelength @";F;"MHz =";CENT;"cm"
1520 PRINT
1530 PRINT " ENTER: Boom Diameter (";PP$;")..... ";:INPUT BD
1540 IF P$="1" AND BD=<0.07500000298023224!*I/F GOTO 1610
1550 IF P$="2" AND BD=<0.07500000298023224!*CM/F GOTO 1610
1560 IF P$="3" AND BD=<0.07500000298023224! GOTO 1610
1570 PRINT
1580 GOSUB 3430
1590 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 1440
1600 :REM'
1610 A=BD
1620 GOSUB 3270
1630 BD=A:REM'Boom diameter in wavelengths
1640 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1650 PRINT" ELEMENT DIAMETER MUST BE BETWEEN 0.001 AND 0.02 WAVELENGTH"
1660 PRINT
1670 INCH1=INT(0.0010000000474974513!*I/F*10^3+0.5!)/10^3:INCH2=INT(0.019999999552965164!*I/F*10^3+0.5!)/10^3
1680 CENT1=INT(0.0010000000474974513!*CM/F*10^2+0.5!)/10^2:CENT2=INT(0.019999999552965164!*CM/F*10^2+0.5!)/10^2
1690 IF P$="1"THEN PRINT " Diameter @";F;"MHz must be between";INCH1;"and";
1700 IF P$="1"THEN PRINT INCH2;"inches"
1710 IF P$="2"THEN PRINT " Diameter @";F;"MHz must be between";CENT1;"and";
1720 IF P$="2"THEN PRINT CENT2;"cm"
1730 :REM'
1740  PRINT
1750  PRINT " ENTER: Driven Element Diameter (";PP$;")......";:INPUT DD
1760  IF P$="1" AND DD=>0.0010000000474974513!*I/F AND DD=<0.019999999552965164!*I/F GOTO 1830
1770  IF P$="2" AND DD=>0.0010000000474974513!*CM/F AND DD=<0.019999999552965164!*CM/F GOTO 1830
1780  IF P$="3" AND DD=>0.0010000000474974513! AND DD=<0.019999999552965164! GOTO 1830
1790  PRINT
1800  GOSUB 3430
1810  VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 1630
1820 :REM'
1830  A=DD
1840  GOSUB 3270
1850  PRINT
1860  DD=A
1870 :REM'
1880 PRINT " ENTER: Parasitic Element Diameter (";PP$;")....";:INPUT ED
1890 LN=CSRLIN-1
1900 IF P$="1" AND ED=>0.0010000000474974513!*I/F AND ED=<0.019999999552965164!*I/F GOTO 1970
1910 IF P$="2" AND ED=>0.0010000000474974513!*CM/F AND ED=<0.019999999552965164!*CM/F GOTO 1970
1920 IF P$="3" AND ED=>0.0010000000474974513! AND ED=<0.019999999552965164! GOTO 1970
1930 PRINT
1940 GOSUB 3430
1950 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 1860
1960 :REM'
1970 A=ED
1980 GOSUB 3270
1990 ED=A         :REM'Element diameter in wavelengths
2000 SR=0.21614399552345276!:REM'Reflector spacing
2010 LA=BL-SR:REM'Subtract reflector spacing from boom length
2020 :REM'
2030 FOR N=1 TO 14:REM'First 14 directors
2040 S(N)=0.08144400268793106!+0.12178000062704086!*LOG(N):REM'Director spacing from previous element
2050 IF N=1 THEN T(N)=SR+S(N) :ELSE T(N)=T(N-1)+S(N) :REM'Tot.distance from reflector
2060 LA=LA-S(N)         :REM'Subtract from boom length
2070 IF LA<0 THEN M=N-1 : LA=LA+S(N) : GOTO 2170:REM'Last director number
2080 NEXT N
2090 :REM'
2100 FOR N=15 TO 100    :REM'From director 15 on
2110 S(N)=S(14)         :REM'Constant spacing after director 14
2120 T(N)=T(N-1)+S(N):REM'Total distance from reflector
2130 LA=LA-S(N)         :REM'Subtract from boom length
2140 IF LA<0 THEN M=N-1 : LA=LA+S(N) : GOTO 2170:REM'Last director number
2150 NEXT N
2160 :REM'
2170 LL=BL-LA              :REM'Boom length from reflector to last director
2180 G1=9.199999809265137!+3.390000104904175!*LOG(LL)   :REM'Actual gain based on active boom length
2190 IF G1<11.800000190734863! THEN BL=1.0499999523162842!*BL :ELSE GOTO 2220:REM'Increment until G1=9.8
2200 GOTO 2010
2210 :REM'
2220 :REM'.....calculate factors for element length equation
2225 RESTORE
2230 FOR Q=1 TO 7
2240 READ K,K1,K2,K3,K4    :REM'K=standard element diameter
2250 IF K=ED THEN J=0 : GOTO 2340
2260 IF K<ED THEN L=K :ELSE GOTO 2280
2270 KL1=K1 : KL2=K2 : KL3=K3 : KL4=K4
2280 IF K>ED THEN H=K :ELSE GOTO 2310
2290 KH1=K1 : KH2=K2 : KH3=K3 : KH4=K4
2300 GOTO 2330
2310 NEXT Q
2320 :REM'
2330 J=(ED-L)/(H-L):REM'Interpolation factor
2340 R=0.47694501280784607!:REM'Reflector length
2350 IF E$="1" OR E$="2" THEN X=R :ELSE GOTO 2380
2360 GOSUB 3320
2370 R=X
2380 DE=0.4719200134277344!
2390 :REM'DE=(.4777-(1.0522*DD)+(.43363*(DD^-.014891)))/2    'Driven element length
2400 :REM'
2410 :REM'.....calculate director lengths
2420 FOR N=1 TO M
2430 IF J=0 THEN D(N)=(K1-K2*LOG(N))*(1-K3*EXP(-K4*N)) :ELSE GOSUB 3370 :REM'Dir lgth
2440 IF E$="1" OR E$="2" THEN X=D(N) :ELSE GOTO 2470
2450 GOSUB 3320
2460 D(N)=X
2470 NEXT N
2480 CLS
2490 :REM'
2500 :REM'.....screen display
2510 PRINT " DL6WU LONG YAGI ANTENNA"
2520 PRINT UL$;
2530 PRINT TAB(9);"Centre Frequency.............";USING U$;F;
2540 PRINT " MHz  (";USING U$;300/F;:PRINT " metres )"
2550 PRINT TAB(9);"Gain.........................";USING U$;G1;:PRINT " dB ";
2560 PRINT "over a ½ wave dipole"
2570 PRINT TAB(9);"Driven Element...............  Folded Dipole"
2580 PRINT TAB(9);"Drive Impedance..............  200 Ω (approximate)"
2590 FT=LL*I/(F*12):IN=LL*I/F:CE=LL*CM/F
2600 PRINT TAB(9);"Reflector to last Director...";USING U$;CE;:PRINT " cm    ┐"
2610 PRINT TAB(9);"                            =";USING U$;IN;:PRINT " inches├";
2620 PRINT " = minimum boom length"
2630 PRINT TAB(9);"                            =";USING U$;FT;:PRINT " feet  ┘"
2640 IF E$="3" GOTO 2680
2650 IN=BD*I/F:CE=BD*CM/F
2660 PRINT TAB(9);"Boom Diameter................";USING U$;CE;:PRINT " cm"
2670 PRINT TAB(9);"                            =";USING U$;IN;:PRINT " inches"
2680 IN=DD*I/F:CE=DD*CM/F
2690 PRINT TAB(9);"Driven Element Diameter......";USING U$;CE;:PRINT " cm"
2700 PRINT TAB(9);"                            =";USING U$;IN;:PRINT " inches"
2710 IN=ED*I/F:CE=ED*CM/F
2720 PRINT TAB(9);"Parasitic Element Diameter...";USING U$;CE;:PRINT " cm"
2730 PRINT TAB(9);"                            =";USING U$;IN;:PRINT " inches"
2740 PRINT TAB(9);"No. of Parasitic Elements....";USING "#####";M
2750 PRINT UL$;
2760 IF E$="1" THEN PRINT TAB(9);"Elements pass through and are NOT ";
2770 IF E$="1" THEN PRINT "insulated from a metal boom"
2780 IF E$="2" THEN PRINT TAB(9);"Elements pass through and are insulated ";
2790 IF E$="2" THEN PRINT "from a metal boom"
2800 IF E$="3" THEN PRINT TAB(9);"Boom is non-metallic"
2810 IF E$="3" THEN PRINT TAB(9);"     --- OR ---"
2820 IF E$="3" THEN PRINT TAB(9);"Elements are mounted on insulators above ";
2830 IF E$="3" THEN PRINT "or below a metal boom";
2840 IF E$="3" THEN PRINT TAB(9);"with metal-to-metal spacing greater than ";
2850 IF E$="3" THEN PRINT "the boom radius"
2860 PRINT UL$;
2870 GOSUB 3630
2880 :REM'
2890 :REM'.....diagram
2900 CLS
2910 Z=7    :REM'indent
2920 PRINT TAB(29);"DL6WU LONG YAGI ANTENNA"
2930 PRINT UL$;
2940 PRINT TAB(Z+2);"CUMULATIVE";TAB(Z+57);"ELEMENT"
2950 PRINT TAB(Z+2);"SPACING";TAB(Z+57);"LENGTH"
2960 PRINT TAB(Z);"══════════════";TAB(Z+53);"══════════════"
2970 PRINT TAB(Z);"cm";TAB(Z+8);"inches";TAB(Z+53);"cm";TAB(Z+61);"inches"
2980 PRINT TAB(Z);"──────────────";TAB(Z+53);"──────────────"
2990 PRINT TAB(Z);"0";TAB(Z+10);"0";
3000 PRINT TAB(Z+16);"Reflector ──────────┼─────────-";
3010 PRINT TAB(Z+51);USING "###.##";R*CM/F;
3020 PRINT TAB(Z+61);USING"###.###";R*I/F
3030 PRINT TAB(Z+36);"│"
3040 PRINT TAB(Z-2);USING"###.##";SR*CM/F;
3050 PRINT TAB(Z+9);USING"##.###";SR*I/F;
3060 PRINT TAB(Z+16);"Driven El. ═════════╪═════════";
3070 PRINT TAB(Z+50);USING "####.##";DE*CM/F;
3080 PRINT TAB(Z+61);USING "###.###";DE*I/F
3090 :REM'
3100 ROW=10       :REM'default row number
3110 FOR N=1 TO M
3120 ROW=ROW+1
3130 PRINT TAB(Z+36);"│"
3140 ROW=ROW+1
3150 PRINT TAB(Z-4);USING"#####.##";T(N)*CM/F;
3160 PRINT TAB(Z+7);USING"####.###";T(N)*I/F;
3170 PRINT TAB(Z+20);
3180 IF N<=9 THEN PRINT " ";
3190 PRINT "D"+STR$(N)+"    ────────┼───────-";
3200 PRINT TAB(Z+50);USING "####.##";D(N)*CM/F;
3210 PRINT TAB(Z+61);USING"###.###";D(N)*I/F;
3220 IF ROW<24 THEN PRINT "":GOTO 3240
3230 GOSUB 3630:CLS:ROW=0
3240 NEXT N
3250 GOTO 3580       :REM'end
3260 :REM'
3270 :REM'.....convert measurements
3280 IF P$="1" THEN A=A*F/I             :REM'Convert in. to wavelength
3290 IF P$="2" THEN A=A*F/CM:REM'Convert cm to wavelength 
3300 RETURN
3310 :REM'
3320 :REM'.....correction factors for element lengths
3330 IF E$="1" THEN X=X+0.6000000238418579!*BD
3340 IF E$="2" THEN X=X+0.25!*BD
3350 RETURN
3360 :REM'
3370 :REM'.....interpolate for D(N)
3380 DL(N)=(KL1-KL2*LOG(N))*(1-KL3*EXP(-KL4*N))
3390 DH(N)=(KH1-KH2*LOG(N))*(1-KH3*EXP(-KH4*N))
3400 D(N)=DL(N)+J*(DH(N)-DL(N))
3410 RETURN
3420 :REM'
3430 :REM'.....entry not valid
3440 PRINT " ---> INCORRECT ENTRY - TRY AGAIN! (press any key to continue....)"
3450 IF INKEY$=""THEN 3450
3460 RETURN
3470 :REM'
3480 :REM'First number in each data line is element diameter.  Next 4 numbers are
3490 :REM'K1-K4, used to determine element lengths.
3500 DATA .001,.4711,.018,.08398,.965
3510 DATA .003,.462,.01941,.08543,.9697
3520 DATA .005,.4538,.02117,.0951,1.007
3530 DATA .007,.4491,.02274,.08801,.9004
3540 DATA .01,.4421,.02396,.1027,1.038
3550 DATA .015,.4358,.02558,.1149,1.034
3560 DATA .02,.4268,.02614,.1112,1.036
3570 :REM'
3580 :REM'.....end
3590 GOSUB 3630
3600 GOTO 90   :REM'start
3610 END
3620 :REM'
3630 :REM'.....PRT
3640 KEY OFF:GOSUB 3710:LOCATE 25,5:COLOR 0,2
3650 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3660 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3670 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3670 :ELSE GOSUB 3710
3680 IF Z$="3"THEN RETURN
3690 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3700 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3640
3710 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
