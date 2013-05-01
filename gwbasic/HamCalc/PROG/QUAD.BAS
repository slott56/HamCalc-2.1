10 :REM'QUAD - Quad Antenna Dimensions - 28 APR 2000 rev. 08 MAR 2009
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 PROG$="quad"
50 COMMON EX$,PROG$,DIMN$,A,B,C
60 COLOR 7,0,1
70 LGF=1/LOG(10)   :REM'factor to convert log to base 10
80 UL$=STRING$(80,205)
90 SL=299792.5!  :REM'speed of light in metres/sec
100 :REM'.....AWG calculator
110 DIM GA(50)
120 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
130 FOR Z=1 TO 50
140 N=Z+3
150 GA(Z)=0.46000000834465027!/K^N
160 NEXT Z
170 :REM'
180 :REM'.....start
190 CLS
200 COLOR 15,2
210 PRINT " QUAD ANTENNA DIMENSIONS";TAB(57);"by George Murphy VE3ERP ";
220 COLOR 1,0:PRINT STRING$(80,223);
230 LOCATE CSRLIN-1,24:COLOR 15,2
240 PRINT " Algorithms by L.B.Cebik, W4RNL "
250 COLOR 7,0
260 PRINT
270 GOSUB 5150   :REM'print text
280 COLOR 0,7
290 LOCATE ,26:PRINT " Press 1 for 1-element quad "
300 LOCATE ,26:PRINT " Press 2 for 2-element quad "
310 LOCATE ,26:PRINT " Press 3 for 3-element quad "
320 LOCATE ,26:PRINT " Press 4 for 4-element quad "
330 LOCATE ,26:PRINT " Press 0 to EXIT            ";
340 COLOR 7,0
350 E$=INKEY$:IF E$=""THEN 350
360 IF E$="0"THEN CLS:RUN EX$
370 IF E$="1"THEN 4630
380 IF E$="2"OR E$="3"OR E$="4"THEN 410
390 GOTO 350
400 :REM'
410 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 4
420 GOSUB 5510  :REM'diagram
430 PRINT
440 INPUT " ENTER: Centre frequency of band (MHz).....";F
450 CLS
460 PRINT " Press number in < > to choose units for wire diameter:"
470 PRINT UL$;
480 PRINT "  < 1 >  inches"
490 PRINT "  < 2 >  millimetres"
500 PRINT "  < 3 >  wavelengths"
510 PRINT "  < 4 >  AWG size"
520 PRINT UL$;
530 Z$=INKEY$
540 IF Z$="1"THEN Y$="(inches)":GOTO 590
550 IF Z$="2"THEN Y$="(mm.)":GOTO 590
560 IF Z$="3"THEN Y$="(wavelengths)":GOTO 590
570 IF Z$="4"THEN Y$="(AWG size)":GOTO 590
580 GOTO 530
590 PRINT " ENTER: Wire diameter ";Y$;" ";:INPUT WD
600 IF Z$="1"THEN WLI=SL/25.399999618530273!/F:D=WD/WLI  :REM'WLI=freq. in kHz
610 IF Z$="2"THEN WLI=SL/F:D=WD/WLI
620 IF Z$="3"THEN D=WD
630 IF Z$="4"THEN D=(GA(WD)*25.399999618530273!)/(SL/F)
640 :REM'
650 CLS:X$=" "+E$+"-ELEMENT QUAD ANTENNA DIMENSIONS  (wL = wavelengths) "
660 LOCATE 1,(80-LEN(X$))/2:COLOR 15,2:PRINT X$:COLOR 7,0
670 PRINT USING " Operating frequency:          #####.### MHz";F;
680 WL=SL/F/10^3:WF=WL/0.30480000376701355!
690 PRINT USING " = ##.### metres";WL:GOTO 700
700 Z$="  Wire diameter in wavelengths...............= ##.######^^^^ wL"
710 PRINT USING Z$;D
720 A=SL/F*D:B=A/25.399999618530273!:C=(LOG(0.46000000834465027!/B))/LOG(1.1229000091552734!)-3
730 Z$="  Wire diameter.................. ##.### mm. = ##.### in.= AWG ##.#"
740 PRINT USING Z$;A,B,C
750 IF E$="2"THEN 790
760 IF E$="3"THEN 1110
770 IF E$="4"THEN 1930
780 :REM'
790 :REM'.....2-element perimeter calculation - algorithm by L.B.Cebik, W4RNL
800 L=LGF*LOG(D*10^5):LL=L^2:LM=LL*0.012799999676644802!:LN=LM+1.0413000583648682!:D1=LGF*LOG(D)
810 COLOR 14,4
820 IF D1<-4.5! THEN 830 :ELSE 840
830 PRINT "Wire diameter less than 3E-5 wL:  results uncertain."
840 IF D1>-2 THEN 850 :ELSE 860
850 PRINT "Wire diameter greater than 1E-2 wL:  results uncertain."
860 COLOR 7,0
870 AD=0.00336#:BD=0.04966518519#:CD=0.2731955556#:DD=0.6716364021#:ED=1.644147937#
880 DE=(AD*(D1^4))+(BD*(D1^3))+(CD*(D1^2))+(DD*D1)+ED
890 AR=0.003173333333#:BR=0.0508237037#:CR=0.3081977778#:DR=0.8663851852#
900 ER=2.040064444#
910 RE=(AR*(D1^4))+(BR*(D1^3))+(CR*(D1^2))+(DR*D1)+ER
920 AS=-0.003#:BS=-0.03551851852#:CS=-0.1553055556#:DS=-0.2902116402#
930 ES=-0.02540079365#
940 SP=(AS*(D1^4))+(BS*(D1^3))+(CS*(D1^2))+(DS*D1)+ES
950 AZ=1.976333333#:BZ=30.84751852#:CZ=172.4909722#:DZ=419.5162831#
960 EZ=519.8747579#
970 ZR=(AZ*(D1^4))+(BZ*(D1^3))+(CZ*(D1^2))+(DZ*D1)+EZ
980 AG=-0.06333333333#:BG=-0.7203703704#:CG=-3.010277778#:DG=-5.381375661#
990 EG=3.738769841#
1000 GN=(AG*(D1^4))+(BG*(D1^3))+(CG*(D1^2))+(DG*D1)+EG
1010 AW=1.6886666670000001#:BW=23.76837037#:CW=124.9339444#:DW=295.8872328#
1020 EW=281.2755159#
1030 SW=(AW*(D1^4))+(BW*(D1^3))+(CW*(D1^2))+(DW*D1)+EW
1040 AF=-0.00266666667#:BF=0.388#:CF=4.790666667#:DF=19.55485714#:EF=28.76628571#
1050 FB=(AF*(D1^4))+(BF*(D1^3))+(CF*(D1^2))+(DF*D1)+EF
1060 AN=-0.08333333333#:BN=-0.9462962963#:CN=-3.943055556#:DN=-7.582671958#
1070 EN=-5.23234127#
1080 DG=(AN*(D1^4))+(BN*(D1^3))+(CN*(D1^2))+(DN*D1)+EN
1090 GOTO 3120
1100 :REM'
1110 :REM'.....3-element perimeter calculation - algorithm by L.B.Cebik, W4RNL
1120 COLOR 0,7
1130 PRINT " Want best design for (w)ide-band or (h)igh gain?    (w/h) "
1140 COLOR 7,0
1150 Z$=INKEY$:IF Z$=""THEN 1150
1160 IF Z$="w"THEN LOCATE CSRLIN-1:GOTO 1200
1170 IF Z$="h"THEN LOCATE CSRLIN-1:GOTO 1580
1180 GOTO 1150
1190 :REM'
1200 :REM'.....wide band
1210 L=LGF*LOG(D*10^5):LL=L^2:LM=LL*0.012799999676644802!:LN=LM+1.0413000583648682!:D1=LGF*LOG(D)
1220 COLOR 14,4
1230 IF D1<-4.5! THEN 1240 :ELSE 1250
1240 PRINT "Wire diameter less than 3E-5 wavelengths:  results uncertain."
1250 IF D1>-2 THEN 1260 :ELSE 1270
1260 PRINT "Wire diameter greater than 1E-2 wavelengths:  results uncertain."
1270 COLOR 7,0
1280 AD=0.0006399999838322401!:BD=0.01044148148#:CD=0.06484444444#:DD=0.1886626455#:ED=1.232080635#
1290 DE=(AD*(D1^4))+(BD*(D1^3))+(CD*(D1^2))+(DD*D1)+ED
1300 AR=0.0009333333333#:BR=0.01915555556#:CR=0.13983333333#:DR=0.4587492063#
1310 ER=1.64042381#
1320 RE=(AR*(D1^4))+(BR*(D1^3))+(CR*(D1^2))+(DR*D1)+ER
1330 AI=-0.0012000000000000001#:BI=-0.020903703699999998#:CI=-0.13021111111#:DI=-0.3498137566#
1340 EI=0.5941126984#
1350 IR=(AI*(D1^4))+(BI*(D1^3))+(CI*(D1^2))+(DI*D1)+EI
1360 AS=-0.0033#:BS=-0.03927777778#:CS=-0.1724583333#:DS=-0.3239603175#
1370 ES=-0.04951547619#
1380 SP=(AS*(D1^4))+(BS*(D1^3))+(CS*(D1^2))+(DS*D1)+ES
1390 AP=-0.004866666667#:BP=-0.06262962963#:CP=-0.29347222222#:DP=-0.6174457672#
1400 EP=-0.2289269841#
1410 IP=(AP*(D1^4))+(BP*(D1^3))+(CP*(D1^2))+(DP*D1)+EP
1420 AZ=-2.227066667#:BZ=-26.752474069999998#:CZ=-115.9142556#:DZ=-217.8183323#
1430 EZ=-79.59203175#
1440 ZR=(AZ*(D1^4))+(BZ*(D1^3))+(CZ*(D1^2))+(DZ*D1)+EZ
1450 AG=-0.07#:BG=-0.7877777778#:CG=-3.350833333#:DG=-6.143888889#:EG=5.104166667#
1460 GN=(AG*(D1^4))+(BG*(D1^3))+(CG*(D1^2))+(DG*D1)+EG
1470 AW=-0.05847333333#:BW=-0.5028392593#:CW=-0.4586494444#:DW=6.080227037#
1480 EW=17.61091389#
1490 SW=(AW*(D1^4))+(BW*(D1^3))+(CW*(D1^2))+(DW*D1)+EW
1500 AF=0.11695666667#:BF=1.717985556#:CF=9.6510925#:DF=25.23848992#
1510 EF=27.78167988#
1520 FB=(AF*(D1^4))+(BF*(D1^3))+(CF*(D1^2))+(DF*D1)+EF
1530 AN=-0.04666666667#:BN=-0.5414814815#:CN=-2.302777778#:DN=-4.364074074#
1540 EN=-3.092777778#
1550 DG=(AN*(D1^4))+(BN*(D1^3))+(CN*(D1^2))+(DN*D1)+EN
1560 GOTO 3120
1570 :REM'
1580 :REM'.....high gain
1590 L=LGF*LOG(D*10^5):LL=L^2:LM=LL*0.012799999676644802!:LN=LM+1.0413000583648682!:D1=LGF*LOG(D)
1600 COLOR 14,4
1610 IF D1<-4.5! THEN 1620 :ELSE 1630
1620 PRINT "Wire diameter less than 3E-5 wavelengths:  results uncertain."
1630 IF D1>-2 THEN 1640 :ELSE 1650
1640 PRINT "Wire diameter greater than 1E-2 wavelengths:  results uncertain."
1650 COLOR 7,0
1660 AD=0.000266666667#:BD=0.00506666667#:CD=0.03633333333#:DD=0.1221904762#
1670 ED=1.183285714#
1680 DE=(AD*(D1^4))+(BD*(D1^3))+(CD*(D1^2))+(DD*D1)+ED
1690 AR=0.0037333333333#:BR=0.05362962963#:CR=0.29275555556#:DR=0.7424529101#
1700 ER=1.814412698#
1710 RE=(AR*(D1^4))+(BR*(D1^3))+(CR*(D1^2))+(DR*D1)+ER
1720 AI=-0.00266666667#:BI=-0.033244444444#:CI=-0.1550666667#:DI=-0.3222793651#
1730 EI=0.7283809524#
1740 IR=(AI*(D1^4))+(BI*(D1^3))+(CI*(D1^2))+(DI*D1)+EI
1750 AS=0.00033333333#:BS=0.004837037037#:CS=0.02552777778#:DS=0.05643756614#
1760 ES=0.2191230159#
1770 SP=(AS*(D1^4))+(BS*(D1^3))+(CS*(D1^2))+(DS*D1)+ES
1780 AP=-0.002333333333#:BP=-0.03128148148#:CP=-0.15586111111#:DP=-0.3417669312#
1790 EP=-0.05499206349#
1800 IP=(AP*(D1^4))+(BP*(D1^3))+(CP*(D1^2))+(DP*D1)+EP
1810 AZ=4.4029#:BZ=53.43954444#:CZ=239.2408583#:DZ=462.3614437#:EZ=373.3035655#
1820 ZR=(AZ*(D1^4))+(BZ*(D1^3))+(CZ*(D1^2))+(DZ*D1)+EZ
1830 AG=-0.15#:BG=-1.7685185190000001#:CG=-7.763055556#:DG=-14.78592593#:EG=-0.609722222#
1840 GN=(AG*(D1^4))+(BG*(D1^3))+(CG*(D1^2))+(DG*D1)+EG
1850 AW=0.16666666667#:BW=2.265925926#:CW=11.706111111#:DW=27.930582010000002#
1860 EW=28.88753968#
1870 SW=(AW*(D1^4))+(BW*(D1^3))+(CW*(D1^2))+(DW*D1)+EW
1880 AF=0.11933333333#:BF=1.671777778#:CF=8.9885#:DF=22.45931746#:EF=23.68797619#
1890 FB=(AF*(D1^4))+(BF*(D1^3))+(CF*(D1^2))+(DF*D1)+EF
1900 DG=0
1910 GOTO 3120
1920 :REM'
1930 :REM'.....4-element calculation
1940 BL=0    :REM'boom length
1950 L=LGF*LOG(D*10^5):LL=L^2:LM=LL*0.012799999676644802!:LN=LM+1.0413000583648682!:D1=LGF*LOG(D)
1960 COLOR 14,4
1970 IF D1<-4.5! THEN 1980 :ELSE 1990
1980 PRINT "Wire diameter less than 3E-5 wavelengths:  results uncertain."
1990 IF D1>-2 THEN 2000 :ELSE 2010
2000 PRINT "Wire diameter greater than 1E-2 wavelengths:  results uncertain."
2010 COLOR 7,0
2020 AD=-0.00018000000272877514!:BD=-0.002359259259#:CD=-0.01090277778#
2030 DD=-0.01971296296#:ED=0.1174938889#
2040 DE=(AD*(D1^4))+(BD*(D1^3))+(CD*(D1^2))+(DD*D1)+ED:DE=DE*8
2050 AR=0.0002666666667#:BR=0.004237037037#:CR=0.02554444444#
2060 DR=0.07158756614#:ER=0.2119230159#
2070 RE=(AR*(D1^4))+(BR*(D1^3))+(CR*(D1^2))+(DR*D1)+ER:RE=RE*8
2080 AI=-0.0002#:BI=-0.002525925926#:CI=-0.01182777778#
2090 DI=-0.02473915344#:EI=0.1008246032#
2100 IR=(AI*(D1^4))+(BI*(D1^3))+(CI*(D1^2))+(DI*D1)+EI:IR=IR*8
2110 AT=-0.0006000000000000001#:BT=-0.009059259259#:CT=-0.04912777778#
2120 DT=-0.1152343915#:ET=0.01678174603#
2130 TT=(AT*(D1^4))+(BT*(D1^3))+(CT*(D1^2))+(DT*D1)+ET:TT=TT*8
2140 SP=0.16349999606609344!:IP=0.48100000619888306!
2150 ATT=0.0026666666667#:BTT=0.036888888889#:CTT=0.177#
2160 DTT=0.3386587302#:ETT=1.046738095#
2170 TTP=(ATT*(D1^4))+(BTT*(D1^3))+(CTT*(D1^2))+(DTT*D1)+ETT
2180 AZ=1.2#:BZ=13.92592593#:CZ=60.777777778#:DZ=113.9177249#:EZ=132.618254#
2190 ZR=(AZ*(D1^4))+(BZ*(D1^3))+(CZ*(D1^2))+(DZ*D1)+EZ
2200 AG=-0.1#:BG=-1.184444444#:CG=-5.228333333#:DG=-9.831507937#:EG=4.045238095#
2210 GN=(AG*(D1^4))+(BG*(D1^3))+(CG*(D1^2))+(DG*D1)+EG
2220 AW=-0.06663333333#:BW=-0.6539148148#:CW=-1.677836111#
2230 DW=1.361137831#:EW=9.502790079#
2240 SW=(AW*(D1^4))+(BW*(D1^3))+(CW*(D1^2))+(DW*D1)+EW
2250 AF=-0.03#:BF=-0.27666667#:CF=-0.4475#:DF=2.348809524#:EF=7.853214286#
2260 FB=(AF*(D1^4))+(BF*(D1^3))+(CF*(D1^2))+(DF*D1)+EF
2270 WL=299.7925109863281!/F
2280 WF=983.5592041015625!/F
2290 :REM'
2300 A=RE/4:B=A*WL:C=A*WF
2310 Z$=" Reflector sides................. ##.#### wL = ##.### m. = ###.### ft."
2320 COLOR 0,7:PRINT USING Z$;A,B,C:COLOR 7,0
2330 :REM'
2340 A=RE:B=RE*WL:C=RE*WF
2350 Z$=" Reflector perimeter............. ##.#### wL = ##.### m. = ###.### ft."
2360 PRINT USING Z$;A,B,C
2370 :REM'
2380 A=SQR(2*(RE/4)^2):B=A*WL:C=A*WF
2390 Z$=" Reflector diagonal arms......... ##.#### wL = ##.### m. = ###.### ft."
2400 PRINT USING Z$;A,B,C
2410 :REM'
2420 A=SP:B=SP*WL:C=SP*WF
2430 Z$="  Reflector/Driver spacing....... ##.#### wL = ##.### m. = ###.### ft."
2440 COLOR 15:PRINT USING Z$;A,B,C:COLOR 7
2450 :REM'
2460 A=DE/4:B=A*WL:C=A*WF
2470 Z$=" Driver sides.................... ##.#### wL = ##.### m. = ###.### ft."
2480 COLOR 0,7:PRINT USING Z$;A,B,C:COLOR 7,0
2490 :REM'
2500 A=DE:B=A*WL:C=A*WF
2510 Z$=" Driver perimeter................ ##.#### wL = ##.### m. = ###.### ft."
2520 PRINT USING Z$;A,B,C
2530 :REM'
2540 A=SQR(2*(DE/4)^2):B=A*WL:C=A*WF
2550 Z$=" Driver diagonal arms............ ##.#### wL = ##.### m. = ###.### ft."
2560 PRINT USING Z$;A,B,C
2570 :REM'
2580 A=IP-SP:B=A*WL:C=A*WF
2590 Z$="  Driver/Director-1 spacing...... ##.#### wL = ##.### m. = ###.### ft."
2600 COLOR 15:PRINT USING Z$;A,B,C:COLOR 7
2610 :REM'
2620 A=IR/4:B=A*WL:C=A*WF
2630 Z$=" Director-1 sides................ ##.#### wL = ##.### m. = ###.### ft."
2640 COLOR 0,7:PRINT USING Z$;A,B,C:COLOR 7,0
2650 :REM'
2660 A=IR:B=A*WL:C=A*WF
2670 Z$=" Director-1 perimeter............ ##.#### wL = ##.### m. = ###.### ft."
2680 PRINT USING Z$;A,B,C
2690 :REM'
2700 A=SQR(2*(IR/4)^2):B=A*WL:C=A*WF
2710 Z$=" Director-1 diagonal arms........ ##.#### wL = ##.### m. = ###.### ft."
2720 PRINT USING Z$;A,B,C
2730 :REM'
2740 A=TTP-IP:B=A*WL:C=A*WF
2750 Z$="  Director-1/Director-2 spacing.. ##.#### wL = ##.### m. = ###.### ft."
2760 COLOR 15:PRINT USING Z$;A,B,C:COLOR 7
2770 :REM'
2780 BL=TTP  :REM'boom length
2790 :REM'
2800 A=TT/4:B=A*WL:C=A*WF
2810 Z$=" Director-2 sides................ ##.#### wL = ##.### m. = ###.### ft."
2820 COLOR 0,7:PRINT USING Z$;A,B,C:COLOR 7,0
2830 :REM'
2840 A=TT:B=A*WL:C=A*WF
2850 Z$=" Director-2 perimeter............ ##.#### wL = ##.### m. = ###.### ft."
2860 PRINT USING Z$;A,B,C
2870 :REM'
2880 A=SQR(2*(TT/4)^2):B=A*WL:C=A*WF
2890 Z$=" Director-2 diagonal arms........ ##.#### wL = ##.### m. = ###.### ft."
2900 PRINT USING Z$;A,B,C
2910 :REM'
2920 A=BL:B=A*WL:C=A*WF
2930 Z$="  Boom length.................... ##.#### wL = ##.### m. = ###.### ft."
2940 COLOR 15:PRINT USING Z$;A,B,C:COLOR 7
2950 :REM'
2960 PRINT USING " Feedpoint Impedance...........≈ ###.### ohms";ZR
2970 Z=SW/100*F
2980 PRINT USING " 2:1 VSWR bandwidth............≈ ###.### MHz";Z
2990 Z=FB/100*F
3000 PRINT USING " >20 dB F/B ratio bandwidth....≈ ###.### MHz";Z;
3010 PRINT USING ", Free-space gain ≈ ##.### dBi";GN;
3020 GOSUB 5740
3030 CLS:LOCATE 12:PRINT " Want to find minimum turning radius?   (y/n) "
3040 Z$=INKEY$:IF Z$=""THEN 3040
3050 IF Z$="n"THEN 3090
3060 IF Z$="y"THEN 3080
3070 GOTO 3040
3080 PROG$="quad":DIMN$="feet":A=BL*WF:B=RE/4/2*WF:C=TT/4/2*WF:CHAIN"turnrad"
3090 GOTO 180
3100 :REM'
3110 PRINT TAB(T);
3120 :REM'.....screen print (2-el & 3-el)
3130 BL=0    :REM'boom length
3140 A=DE/4:B=A*WL:C=A*WF
3150 Z$=" Driver sides.................... ##.#### wL = ##.### m. = ###.### ft."
3160 COLOR 0,7:PRINT USING Z$;A,B,C:COLOR 7,0
3170 :REM'
3180 A=DE:B=A*WL:C=A*WF
3190 Z$=" Driver perimeter................ ##.#### wL = ##.### m. = ###.### ft."
3200 PRINT USING Z$;A,B,C
3210 :REM'
3220 A=SQR(2*(DE/4)^2):B=A*WL:C=A*WF
3230 Z$=" Driver diagonal arms............ ##.#### wL = ##.### m. = ###.### ft."
3240 PRINT USING Z$;A,B,C
3250 :REM'
3260 A=SP:B=A*WL:C=A*WF
3270 Z$="  Driver/Reflector spacing....... ##.#### wL = ##.### m. = ###.### ft."
3280 COLOR 15:PRINT USING Z$;A,B,C:COLOR 7
3290 :REM'
3300 BL=BL+SP
3310 :REM'
3320 A=RE/4:B=A*WL:C=A*WF
3330 Z$=" Reflector sides................. ##.#### wL = ##.### m. = ###.### ft."
3340 COLOR 0,7:PRINT USING Z$;A,B,C:COLOR 7,0
3350 :REM'
3360 A=RE:B=A*WL:C=A*WF
3370 Z$=" Reflector perimeter............. ##.#### wL = ##.### m. = ###.### ft."
3380 PRINT USING Z$;A,B,C
3390 :REM'
3400 A=SQR(2*(RE/4)^2):B=A*WL:C=A*WF
3410 Z$=" Reflector diagonal arms......... ##.#### wL = ##.### m. = ###.### ft."
3420 PRINT USING Z$;A,B,C
3430 :REM'
3440 IF E$="2"THEN 3640
3450 :REM'
3460 A=IP:B=A*WL:C=A*WF
3470 Z$="  Driver/Director spacing........ ##.#### wL = ##.### m. = ###.### ft."
3480 COLOR 15:PRINT USING Z$;A,B,C:COLOR 7
3490 :REM'
3500 BL=BL+IP
3510 :REM'
3520 A=IR/4:B=A*WL:C=A*WF
3530 Z$=" Director sides.................. ##.#### wL = ##.### m. = ###.### ft."
3540 COLOR 0,7:PRINT USING Z$;A,B,C:COLOR 7,0
3550 :REM'
3560 A=IR:B=A*WL:C=A*WF
3570 Z$=" Director perimeter.............. ##.#### wL = ##.### m. = ###.### ft."
3580 PRINT USING Z$;A,B,C
3590 :REM'
3600 A=SQR(2*(IR/4)^2):B=A*WL:C=A*WF
3610 Z$=" Director diagonal arms.......... ##.#### wL = ##.### m. = ###.### ft."
3620 PRINT USING Z$;A,B,C
3630 :REM'
3640 A=BL:B=BL*WL:C=A*WF
3650 Z$="  Boom length.................... ##.#### wL = ##.### m. = ###.### ft."
3660 COLOR 15:PRINT USING Z$;A,B,C:COLOR 7
3670 :REM'
3680 :REM'.....other data
3690 PRINT USING " Resonant feedpoint impedance..... ≈ ####.### Ω";ZR
3700 PRINT USING " Free-space gain.................. ≈ ####.### dBi";GN
3710 PRINT USING " 2:1 VSWR bandwidth............... ≈ ####.### MHz";SW/100*F
3720 PRINT USING " >20 dB front/back ratio bandwidth ≈ ####.### MHz";FB/100*F
3730 IF DG=0 THEN 3760
3740 Z$=" Rate of gain change.............. ≈ ####.### dB per ##.### MHz"
3750 PRINT USING Z$;DG,0.009999999776482582!*F
3760 GOSUB 5740
3770 CLS:LOCATE 12:PRINT " Want to find minimum turning radius?   (y/n) "
3780 Z$=INKEY$:IF Z$=""THEN 3780
3790 IF Z$="n"THEN 3850
3800 IF Z$="y"THEN 3820
3810 GOTO 3780
3820 IF E$="2"THEN C=DE/4/2*WF
3830 IF E$="3"THEN C=IR/4/2*WF
3840 PROG$="quad":DIMN$="feet":A=BL*WF:B=RE/4/2*WF:CHAIN"turnrad"
3850 IF E$="2"THEN 4080
3860 IF E$="3"THEN 5710
3870 END
3880 :REM'
3890 :REM'.....diagram 1
3900 LOCATE 1,(80-LEN(P$))/2:PRINT P$
3910 COLOR 0,7:J=12
3920 LOCATE ,J:PRINT"                                                          "
3930 LOCATE ,J:PRINT"  │«──── R ────»│   │«──── D ────»│                       "
3940 :REM'IF E$="3"THEN C=IR/4
3950 LOCATE ,J:PRINT"  │  each side  │   │  each side  │                       "
3960 LOCATE ,J:PRINT"  ┌─────────────┐r  ┌─────────────┐d                      "
3970 LOCATE ,J:PRINT"  │             │   │             │   ╟──∞────D────∞──╢   "
3980 LOCATE ,J:PRINT"  │   Reflector │   │   Driver    │   ║«─ masts (4) ─»║   "
3990 LOCATE ,J:PRINT"  │             │   │             │   ╟─∞─────R─────∞─╢   "
4000 LOCATE ,J:PRINT"  │   Element   │   │   Element   │  -╜-----earth-----╜-- "
4010 LOCATE ,J:PRINT"  │             │   │             │  ┌────────┴─────────┐ "
4020 LOCATE ,J:PRINT" r└─────────────┘  d└───── x ─────┘  Locate R as close to "
4030 LOCATE ,J:PRINT"                     x = feed point    earth as possible  "
4040 LOCATE ,J:PRINT"                                                          "
4050 COLOR 7,0
4060 RETURN
4070 :REM'
4080 :REM'.....continue diagram
4090 IF F<12 THEN 4200
4100 LOCATE CSRLIN-1
4110 PRINT " A 2 element quad can also be configured as a Near Vertical Incide";
4120 PRINT "nce Skywave "
4130 PRINT " (NVIS) antenna but NVIS antennas are not effective at frequencies";
4140 PRINT " higher than"
4150 PRINT " 12 MHz. Your design is for a frequency of";F;"MHz."
4160 PRINT
4170 PRINT " .....press any key....."
4180 Z$=INKEY$:IF Z$=""THEN 4180 :ELSE CLS:GOTO 180
4190  GOTO 4180
4200 COLOR 0,7
4210 PRINT " Want to configure for a NVIS (Near Vertical Incidence Skywave) an";
4220 PRINT "tenna?  (y/n) ";:COLOR 7,0
4230 Z$=INKEY$:IF Z$=""THEN 4230
4240 IF Z$="n"THEN 180
4250 IF Z$="y"THEN 4280
4260 GOTO 4230
4270 VIEW PRINT LN TO 24:CLS:VIEW PRINT:GOTO 5710
4280 CLS:P$=STR$(F)+" MHz NEAR VERTICAL INCIDENCE SKYWAVE QUAD"
4290 :REM'
4300 GOSUB 3890  :REM'diagram
4310 PRINT
4320 PRINT " R = ";
4330 A=RE/4:B=A*WL:C=A*WF
4340 Z$="  Reflector sides............... ##.#### wL = ##.### m. = ##.### ft."
4350 PRINT USING Z$;A,B,C
4360 :REM'
4370 PRINT " rr= ";
4380 A=SQR(2*(RE/4)^2):B=A*WL:C=A*WF
4390 Z$="  Reflector diagonals........... ##.#### wL = ##.### m. = ##.### ft."
4400 PRINT USING Z$;A,B,C
4410 :REM'
4420 PRINT "     ";
4430 A=SP:B=A*WL:C=A*WF
4440 Z$="  Reflector to Driver spacing... ##.#### wL = ##.### m. = ##.### ft."
4450 PRINT USING Z$;A,B,C
4460 PRINT " D = ";
4470 A=DE/4:B=A*WL:C=A*WF
4480 Z$="  Driver sides.................. ##.#### wL = ##.### m. = ##.### ft."
4490 PRINT USING Z$;A,B,C
4500 :REM'
4510 PRINT " dd= ";
4520 A=SQR(2*(DE/4)^2):B=A*WL:C=A*WF
4530 Z$="  Driver diagonals.............. ##.#### wL = ##.### m. = ##.### ft."
4540 PRINT USING Z$;A,B,C
4550 IF E$="2"THEN 4610
4560 :REM'
4570 PRINT "     ";
4580 A=IP:B=A*WL:C=A*WF
4590 Z$="  Driver to Director spacing.... ##.#### wL = ##.### m. = ##.### ft."
4600 PRINT USING Z$;A,B,C
4610 GOSUB 5740:GOTO 180
4620 :REM'
4630 :REM'.....single element quad
4640 CLS
4650 INPUT " ENTER: Centre frequency of band (MHz).....";F
4660 PRINT " Press number in < > to choose units for wire diameter:"
4670 PRINT UL$;
4680 PRINT "  < 1 >  inches"
4690 PRINT "  < 2 >  millimetres"
4700 PRINT "  < 3 >  wavelengths"
4710 PRINT "  < 4 >  AWG size"
4720 PRINT UL$;
4730 Z$=INKEY$
4740 IF Z$="1"THEN Y$="(inches)":GOTO 4790
4750 IF Z$="2"THEN Y$="(mm.)":GOTO 4790
4760 IF Z$="3"THEN Y$="(wavelengths)":GOTO 4790
4770 IF Z$="4"THEN Y$="(AWG size)":GOTO 4790
4780 GOTO 4730
4790 PRINT " ENTER: Wire diameter ";Y$;" ";:INPUT WD
4800 IF Z$="1"THEN WLI=SL/25.399999618530273!/F:D=WD/WLI  :REM'WLI=freq. in kHz
4810 IF Z$="2"THEN WLI=SL/F:D=WD/WLI
4820 IF Z$="3"THEN D=WD
4830 IF Z$="4"THEN D=(GA(WD)*25.399999618530273!)/(SL/F)
4840 :REM'
4850 CLS
4860 PRINT " SINGLE ELEMENT SQUARE QUAD"
4870 PRINT "  (wL = wavelength)"
4880 PRINT UL$;
4890 PRINT USING " Operating frequency........... ###.### MHz";F
4900 WL=SL/F/10^3:WF=WL/0.30480000376701355!
4910 Z$=" Operating wavelength.......... ###.### m.  = ###.### ft."
4920 PRINT USING Z$;WL,WF
4930 Z$=" Wire diameter in wavelengths..  ##.###^^^^ wL"
4940 PRINT USING Z$;D
4950 A=SL/F*D:B=A/25.399999618530273!:C=(LOG(0.46000000834465027!/B))/LOG(1.1229000091552734!)-3
4960 Z$=" Wire diameter................. ###.### mm. = ##.### in.= AWG ##.#"
4970 PRINT USING Z$;A,B,C
4980 PRINT UL$;
4990 LF=1/LOG(10)
5000 L=LF*LOG(D*10^5):LL=L^2:LM=LL*0.012799999676644802!:LN=LM+1.0413000583648682!
5010 PM=LN*WL:PF=LN*WF
5020 PRINT " ELEMENT DIMENSIONS"
5030 PRINT UL$;
5040 Z$=" Perimeter..................... ##.##### wL = ###.### m. = ###.### ft."
5050 PRINT USING Z$;LN,PM,PF
5060 Z$=" Each side..................... ##.##### wL = ###.### m. = ###.### ft."
5070 PRINT USING Z$;LN/4,PM/4,PF/4
5080 A=SQR(2*(LN/4)^2):B=A*WL:C=A*WF
5090 Z$=" Diagonal...................... ##.##### wL = ###.### m. = ###.### ft."
5100 PRINT USING Z$;A,B,C
5110 PRINT UL$;
5120 GOSUB 5740:GOTO 180
5130 END
5140 :REM'
5150 :REM'.....text
5160 T=(8)   :REM'tab
5170 PRINT TAB(T);
5180 PRINT "  Most published design data for quad antennas determine the sizes"
5190 PRINT TAB(T);
5200 PRINT "of the elements by dividing an empirical number (usually in the"
5210 PRINT TAB(T);
5220 PRINT "order of 1005 or thereabouts) by the frequency in MHz to arrive at"
5230 PRINT TAB(T);
5240 PRINT "the length of the perimeter in feet. Actually, the factor 1005"
5250 PRINT TAB(T);
5260 PRINT "applies only at some single arbitrary frequency with some single"
5270 PRINT TAB(T);
5280 PRINT "arbitrary conductor diameter. In reality, this empirical factor "
5290 PRINT TAB(T);
5300 PRINT "varies considerably with frequency and conductor diameter."
5310 PRINT TAB(T);
5320 PRINT "(ref. ARRL Publication #36, Antenna Anthology, 1978, p.56)."
5330 PRINT TAB(T);
5340 PRINT "  Dimensions are not critical, as the quad is relatively broad in"
5350 PRINT TAB(T);
5360 PRINT "frequency response, therefore element lengths calculated by that"
5370 PRINT TAB(T);
5380 PRINT "method can usually be made to work to some degree of satisfaction."
5390 PRINT TAB(T);
5400 PRINT "  More precise dimensions can be calculated but seldom are, due to"
5410 PRINT TAB(T);
5420 PRINT "the complex mathematics involved. This program utilizes the"
5430 PRINT TAB(T);
5440 PRINT "mathematical, rather than the empirical, method of calculation to"
5450 PRINT TAB(T);
5460 PRINT "design square quad beams as modelled by L.B.Cebik, W4RNL, using"
5470 PRINT TAB(T);
5480 PRINT "NEC antenna software."
5490 RETURN
5500 :REM'
5510 :REM'.....anatomy diagram
5520 COLOR 0,7:C=21
5530 LOCATE ,C:PRINT "         TYPICAL QUAD ANTENNA          "
5540 LOCATE ,C:PRINT "                                       "
5550 LOCATE ,C:PRINT "         │«─ reflector                 "
5560 LOCATE ,C:PRINT "         │   │«─ driver                "
5570 LOCATE ,C:PRINT "         │   │   │«─ director          "
5580 LOCATE ,C:PRINT "         │   │   │   │«─ director      "
5590 LOCATE ,C:PRINT "  boom ─»┼───┼─╫─┼───┼    »─ gain ─»   "
5600 LOCATE ,C:PRINT "         │   │ ║ │   │                 "
5610 LOCATE ,C:PRINT "         │   │ ║ │                     "
5620 LOCATE ,C:PRINT "         │ ┌»│ ║                       "
5630 LOCATE ,C:PRINT "         │ │   ║«─ mast                "
5640 LOCATE ,C:PRINT " ┌─────────┘   ║                       "
5650 LOCATE ,C:PRINT " └ Feed at centre of a driver side;    "
5660 LOCATE ,C:PRINT " -bottom side for horizontal polarity, "
5670 LOCATE ,C:PRINT " -vertical side for vertical polarity. "
5680 COLOR 7,0
5690 RETURN
5700 :REM'
5710 :REM'.....end
5720 GOSUB 5740:GOTO 180
5730 :REM'
5740 :REM'PRT
5750 KEY OFF:GOSUB 5820:LOCATE 25,5:COLOR 0,2
5760 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
5770 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
5780 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 5780 :ELSE GOSUB 5820
5790 IF Z$="3"THEN RETURN
5800 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
5810 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 5750
5820 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
