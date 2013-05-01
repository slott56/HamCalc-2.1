10 :REM'TRANLINE - Transmission Line Performance - 26 FEB 95 rev. 19 APR 2004
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF:COLOR 7,0,1
60 :REM'
70 :REM'.....clear variables
80 IL=0:EL=0:THI=0:THE=0:THIR=0:THER=0:IIM=0:IRL=0:IPOL=0:IPHS=0:IPHSD=0:EIM=0
90 ERM=0:EPOL=0:EPHS=0:EPHSD=0:RL=0:XL=0:ZO=0:VF=0:F=0:LD=0:LM=0:LF=0:LR=0:T=0
100 TS=0:DA=0:DB=0:DN=0:RS=0:XS=0:XL=0:XM=0:XN=0:RZ=0:XZ=0:RI=0:XI=0:LN=0:LG=0
110 RA=0:XA=0:LL=0
120 :REM'
130 PI=3.1415929794311523!
140 US$="#####.###"
150 UL$=STRING$(80,205)
160 E$=STRING$(80,32)
170 L$=STRING$(8,32)+STRING$(58,196)
180 :REM'
190 :REM'.....start
200 CLS
210 COLOR 15,2
220 PRINT " TRANSMISSION LINE PERFORMANCE";
230 PRINT TAB(61);"by ";CHR$(34);"LB";CHR$(34);" Cebik W4RNL ";
240 PRINT STRING$(80,32);
250 LOCATE CSRLIN-1,20:PRINT "edited for HAMCALC by George Murphy VE3ERP"
260 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
270 IF AGAIN=1 THEN AGAIN=0:GOTO 890
280 MAR=6     :REM'margin
290 PRINT TAB(MAR);
300 PRINT "Calculates Input E, I, R, and X for specified transmission lines,"
310 PRINT TAB(MAR);
320 PRINT "given the 'terminal' E, I, R, and X of the antenna. Calculations can"
330 PRINT TAB(MAR);
340 PRINT "be for a specific length of line (in degrees, feet, or metres) or,"
350 PRINT TAB(MAR);
360 PRINT "more generally, for every 5° of an unspecified line length. Data can"
370 PRINT TAB(MAR);
380 PRINT "be from MININEC, NEC or measurements."
390 PRINT UL$;
400 COLOR 0,7:LOCATE CSRLIN,22
410 PRINT " Press 1 to continue or 0 to EXIT....."
420 COLOR 7,0
430 Z$=INKEY$:IF Z$=""THEN 430
440 IF Z$="0"THEN CLS:CHAIN GO$
450 IF Z$="1"THEN 470
460 GOTO 430
470 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
480 GOTO 550
490 :REM'
500 :REM'.....overprint data entry
510 LOCATE CSRLIN-1:PRINT "        ";
520 LOCATE CSRLIN,57:PRINT USING US$;Q;
530 RETURN
540 :REM'
550 :REM'.....data input
560 INPUT " ENTER: Antenna Load Resistance R........................(ohms)";RL
570 Q=RL:GOSUB 500:PRINT " ohms   "
580 INPUT " ENTER: Antenna Reactance X..............................(ohms)";XL
590 Q=XL:GOSUB 500:PRINT " ohms   "
600 :REM'
610 PRINT " Do you wish to enter (v)oltage & current or (p)ower?  (v/p)"
620 A$=INKEY$:IF A$="v"THEN 780 :ELSE IF A$="p"THEN 640 :ELSE 620
630 :REM'
640 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
650 INPUT " ENTER: Load power......................................(watts)";PWR
660 Q=PWR:GOSUB 500:PRINT " watts  "
670 IL=SQR(PWR/RL):THI=0:EL=IL*SQR(RL^2+XL^2):THER=ATN(XL/RL):THE=THER*180/PI
680 PRINT "        Antenna Load Current..................................."
690 Q=IL:GOSUB 500:PRINT " amps   "
700 PRINT "        Load Current Phase Angle.........................(deg.)"
710 Q=THI:GOSUB 500:PRINT " °      "
720 PRINT "        Antenna Load Voltage............................(volts)"
730 Q=EL:GOSUB 500:PRINT " volts  "
740 PRINT "        Load Voltage Phase Angle.........................(deg.)"
750 Q=THE:GOSUB 500:PRINT " °      "
760 GOTO 890
770 :REM'
780 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
790 INPUT " ENTER: Antenna Load Current (usually 1)................ (amps)";IL
800 Q=IL:GOSUB 500:PRINT " A.     "
810 INPUT " ENTER: Load Current Phase Angle.........................(deg.)";THI
820 Q=THI:GOSUB 500:PRINT " °      "
830 INPUT " ENTER: Antenna Load Voltage............................(volts)";EL
840 Q=EL:GOSUB 500:PRINT " volts  "
850 INPUT " ENTER: Load Voltage Phase Angle.........................(deg.)";THE
860 Q=THE:GOSUB 500:PRINT " °      "
870 PWR=IL*RL
880 :REM'
890 INPUT " ENTER: Line Characteristic Impedance....................(ohms)";ZO
900 Q=ZO:GOSUB 500:PRINT " ohms   "
910 INPUT " ENTER: Velocity Factor as a decimal...........................";VF
920 Q=VF:GOSUB 500:PRINT "        "
930 INPUT " ENTER: Frequency.........................................(MHz)";F
940 Q=F:GOSUB 500:PRINT " MHz    "
950 PRINT
960 PRINT " Do you wish to use a specific line length?  (y/n)"
970 A$=INKEY$
980 IF A$="Y" OR A$="y" THEN 1010
990 IF A$="N" OR A$="n" THEN 1750
1000 GOTO 970
1010 LOCATE CSRLIN-1
1020 :REM'
1030 PRINT " Press letter in < > to select unit for line length"
1040 PRINT UL$;
1050 PRINT "  < d > Degrees"
1060 PRINT "  < f > Feet"
1070 PRINT "  < m > Metres"
1080 U$=INKEY$
1090 IF U$="d"THEN M$="degrees":GOTO 1130
1100 IF U$="f"THEN M$="feet":GOTO 1130
1110 IF U$="m"THEN M$="metres":GOTO 1130
1120 GOTO 1080
1130 PRINT
1140 PRINT " ENTER: Line Length in ";M$;"....";:INPUT LL
1150 IF U$="d" THEN LD=LL
1160 IF U$="f" THEN LD=((0.3660131096839905!*F)*LL)/VF
1170 IF U$="m" THEN LD=((1.2008310556411743!*F)*LL)/VF
1180 GOTO 2190
1190 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
1200 PRINT TAB(23);"LINE INPUT RESISTANCE AND REACTANCE"
1210 PRINT L$;
1220 U$="####.###"
1230 PRINT "        Frequency........................";USING U$;F;:PRINT " MHz."
1240 PRINT "        Power............................";USING U$;PWR;
1250 PRINT " watts"
1260 PRINT L$
1270 PRINT "        Antenna Current..................";USING U$;IL;
1280 PRINT " amps  @";USING U$;THI;:PRINT "°"
1290 PRINT "        Antenna Voltage..................";USING U$;EL;
1300 PRINT " volts @";USING U$;THE;:PRINT "°"
1310 PRINT "        Antenna Resistance...............";USING U$;RL;
1320 PRINT " ohms"
1330 PRINT "        Antenna Reactance................";USING U$;XL;
1340 PRINT " ohms"
1350 PRINT L$
1360 PRINT "        Line Characteristic Impedance....";USING U$;ZO;
1370 PRINT " ohms"
1380 PRINT "        Line Velocity Factor.............";USING U$;VF
1390 PRINT "        Line Voltage.....................";USING U$;EPOL;
1400 PRINT " volts @";USING U$;EPHSD;:PRINT "°"
1410 PRINT "        Line Current.....................";USING U$;IPOL;
1420 PRINT " amps  @";USING U$;IPHSD;:PRINT "°"
1430 PRINT "        Line Impedance...................";USING U$;Z;
1440 PRINT " ohms  @";USING U$;THZD;:PRINT "°"
1450 PRINT "        Line Electrical Length...........";USING U$;LD;:PRINT " °"
1460 PRINT "                                        =";USING U$;LG;
1470 PRINT " feet"
1480 PRINT "                                        =";USING U$;LN;
1490 PRINT " metres"
1500 PRINT L$
1510 PRINT "        LINE INPUT RESISTANCE............";USING U$;RI;
1520 PRINT " ohms"
1530 PRINT "        LINE INPUT REACTANCE.............";USING U$;XI;
1540 PRINT " ohms";
1550 GOSUB 2670   :REM'hardcopy
1560 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
1570 PRINT " Would you like another run?    (y/n)"
1580 R$=INKEY$
1590 IF R$="Y" OR R$="y" THEN 1630
1600 IF R$="N" OR R$="n" THEN 190
1610 GOTO 1580
1620 :REM'
1630 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
1640 PRINT " Press number in < > to:"
1650 PRINT UL$;
1660 PRINT "   < 1 >  Create a whole new entry"
1670 PRINT "   < 2 >  Begin with a new line characteristic impedance"
1680 PRINT "   < 3 >  Begin with a new line length."
1690 PRINT
1700 I$=INKEY$
1710 IF I$="1" THEN 50
1720 IF I$="2" THEN VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4:GOTO 890
1730 IF I$="3" THEN VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4:GOTO 1030
1740 GOTO 1700
1750 CLS
1760 PRINT " Values of I, E, Phase Angles, R, and X for Frequency ";F;"MHz"
1770 PRINT UL$;
1780 PRINT " Ant I....";USING "###.##";IL;:PRINT " A. @";THI;"°";
1790 PRINT TAB(28);"Ant E....";EL;"v. @";THE;"°"
1800 PRINT " Ant R....";RL;"Ω";
1810 PRINT TAB(28);"Ant X....";XL;"Ω";
1820 PRINT TAB(56);"Power...";USING "####.#";PWR;:PRINT " watts"
1830 PRINT " Line Zo..";ZO;"Ω";
1840 PRINT TAB(28);"Vel.Fctr.";USING "##.##";VF;
1850 PRINT TAB(56);"Freq....";F;"MHz"
1860 PRINT UL$;
1870 PRINT "┌─── Line Length ───┐"
1880 PRINT " Degrees Feet Metres    E(in) Phase I(in) Phase  R(in)   ";
1890 PRINT "X(in)  Z Phase   Z"
1900 PRINT UL$;
1910 ROW=9
1920 FOR LD=0 TO 180 STEP 5
1930 GOTO 2190
1940 PRINT USING "#####";LD;:PRINT "°";
1950 PRINT USING "####.##";LG;LG*12*0.02539999969303608!;
1960 PRINT USING "######.##";EPOL;
1970 PRINT USING "#####";EPHSD;
1980 PRINT USING "####.##";IPOL;
1990 PRINT USING "#####";IPHSD;
2000 PRINT USING "#####.##";RI;XI;THZD;Z;
2010 ROW=ROW+1
2020 IF ROW<=23 THEN PRINT "":GOTO 2040
2030 GOSUB 2670:ROW=0:CLS
2040 NEXT LD
2050 GOSUB 2670:ROW=0:CLS
2060 PRINT " Do you wish another run?   (y/n)"
2070 B$=INKEY$
2080 IF B$="Y" OR B$="y" THEN 2120
2090 IF B$="N" OR B$="n" THEN 180
2100 GOTO 2070
2110 PRINT
2120 PRINT " Press <1> to create a whole new entry"
2130 PRINT " Press <2> to begin with a new line characteristic impedance"
2140 I$=INKEY$
2150 IF I$="1" THEN 190
2160 IF I$="2" THEN AGAIN=1:GOTO 190
2170 GOTO 2140
2180 :REM'
2190 LR=(PI*LD)/180:THIR=(PI*THI)/180
2200 THER=(PI*THE)/180:IF THER=0 THEN THER=1.0000000116860974e-07!
2210 IIM=(IL*(SIN(THIR)*COS(LR)))+((EL/ZO)*(COS(THER)*SIN(LR)))
2220 IF IIM>-0.0010000000474974513! AND IIM<0.0010000000474974513! THEN IIM=0
2230 IRL=(IL*(COS(THIR)*COS(LR)))-((EL/ZO)*(SIN(THER)*SIN(LR)))
2240 IF IRL=0 THEN IRL=1.0000000116860974e-07!
2250 IPOL=SQR((IRL*IRL)+(IIM*IIM)):IPHS=ATN(IIM/IRL)
2260 IPHSD=(IPHS*180)/PI
2270 IF IIM=>0 AND IRL=>0 THEN IPHSD=ABS(IPHSD)
2280 IF IIM=>0 AND IRL<0 THEN IPHSD=180-ABS(IPHSD)
2290 IF IIM<0 AND IRL<0 THEN IPHSD=180+ABS(IPHSD)
2300 IF IIM<0 AND IRL=>0 THEN IPHSD=360-ABS(IPHSD)
2310 EIM=(EL*(SIN(THER)*COS(LR)))+((IL*ZO)*(COS(THIR)*SIN(LR)))
2320 IF EIM>-0.0010000000474974513! AND EIM<0.0010000000474974513! THEN EIM=0
2330 ERM=(EL*(COS(THER)*COS(LR)))-((IL*ZO)*(SIN(THIR)*SIN(LR)))
2340 IF ERM=0 THEN ERM=1.0000000116860974e-07!
2350 EPOL=SQR((ERM*ERM)+(EIM*EIM)):EPHS=ATN(EIM/ERM)
2360 EPHSD=(EPHS*180)/PI
2370 IF EIM=>0 AND ERM=>0 THEN EPHSD=ABS(EPHSD)
2380 IF EIM=>0 AND ERM<0 THEN EPHSD=180-ABS(EPHSD)
2390 IF EIM<0 AND ERM<0 THEN EPHSD=180+ABS(EPHSD)
2400 IF EIM<0 AND ERM=>0 THEN EPHSD=360-ABS(EPHSD)
2410 IF RL=0 THEN RL=9.99999993922529e-09!
2420 RA=RL/ZO
2430 XA=XL/ZO
2440 T=TAN(LR)
2450 TS=T*T
2460 DA=(1-(XA*T))*(1-(XA*T))
2470 DB=(RA*T)*(RA*T)
2480 DN=DA+DB
2490 RS=RA*RA
2500 XS=XA*XA
2510 RN=RA*(1+TS)
2520 XK=XA*(1-TS)
2530 XM=((1-RS)-XS)*T
2540 XN=XK+XM
2550 RZ=RN/DN
2560 XZ=XN/DN
2570 RI=ZO*RZ
2580 XI=ZO*XZ
2590 Z=SQR((RI*RI)+(XI*XI))
2600 THZD=(ATN(XI/RI)*180)/PI
2610 LN=(LD*VF)/(1.2008310556411743!*F)
2620 LG=(LD*VF)/(0.3660131096839905!*F)
2630 IF A$="N" OR A$="n" THEN 1940
2640 IF A$="Y" OR A$="y" THEN 1190
2650 END
2660 :REM'
2670 :REM'PRT
2680 KEY OFF:GOSUB 2750:LOCATE 25,5:COLOR 0,2
2690 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2700 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2710 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2710 :ELSE GOSUB 2750
2720 IF Z$="3"THEN RETURN
2730 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2740 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2680
2750 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
