10 :REM'COPWIRE - Copper Wire Data - 15 DEC 85 rev. 20 MAR 2005
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,0
70 PI=4*ATN(1)
80 UL$=STRING$(80,205)       :REM'underline
90 ER$=STRING$(80,32)        :REM'erase
100 U$="####.###"
110 V$="####.####"
120 DIM A(70,4)               :REM'AWG sizes (American Wire Gauge)
130 DIM B(50,4)               :REM'BSWG sizes (British Standard Wire Gauge)
140 DIM GA(40,7)              :REM'enamelled copper transformer wire
150 DIM W(24,10)              :REM'stranded copper wire
160 :REM'
170 :REM'.....AWG wire sizes
180 :REM'     AWG system: Geometrical progression of 40 wire sizes from #0000 AWG
190 :REM'     to #36 AWG, where:
200 :REM'      #0000 = 0.4600" dia. (maximum)
210 :REM'      #36   = 0.0050" dia. (minimum)
220 :REM'     Number of increments = 39
230 :REM'    (Range of sizes was eventually extended to #50)
240 K#= (0.46000000834465027!/0.004999999888241291!)^(1/39) :REM'     = 1.122932  (increment constant)
250 :REM'     n = AWG gauge# + 3 (to allow for sizes #0, 00, 000 and 0000)
260 :REM'     Wire diameter = 0.46 ÷ K#^n
270   FOR Z=1 TO 70
280 N=Z+3
290 WIRE=0.46000000834465027!/K#^N         :REM'wire diameter in inches
300 :REM'     DC resistance per metre = 1/(πa²δ) where:
310 :REM'                           a = radius of wire in metres
320 :REM'    conductivity of copper δ = 5.8 * 10^7 mho/m
330 A=WIRE/2                       :REM'wire radius
340 OHM=304.79998779296875!/(58*PI*(A*25.399999618530273!)^2)   :REM'ohms per 1000 feet
350 :REM'.....alternate calculation for ohms/1000 ft.
360 :REM'.....CM=(WIRE*10^3)^2         'circular mils
370 :REM'.....OHM=10,371/CM            'ohms per 1000 feet
380 A(Z,1)=WIRE
390 A(Z,2)=OHM
400   NEXT Z
410 :REM'
420 :REM'.....BSWG wire sizes
430 WIRE=0.3240000009536743!         :REM'initial diameter
440 FOR Z=1 TO 50
450 IF Z<=3 THEN WIRE =WIRE-0.024000000208616257!:GOTO 580
460 IF Z<=6 THEN WIRE =WIRE-0.019999999552965164!:GOTO 580
470 IF Z<=10 THEN WIRE =WIRE-0.01600000075995922!:GOTO 580
480 IF Z<=14 THEN WIRE =WIRE-0.012000000104308128!:GOTO 580
490 IF Z<=19 THEN WIRE =WIRE-0.008000001311302185!:GOTO 580
500 IF Z<=23 THEN WIRE =WIRE-0.004000000189989805!:GOTO 580
510 IF Z<=26 THEN WIRE =WIRE-0.0020000000949949026!:GOTO 580
520 IF Z<=28 THEN WIRE =WIRE-0.0015999999595806003!:GOTO 580
530 IF Z<=30 THEN WIRE =WIRE-0.0012000000569969416!:GOTO 580
540 IF Z<=39 THEN WIRE =WIRE-0.0007999999797903001!:GOTO 580
550 IF Z<=49 THEN WIRE =WIRE-0.00039999998989515007!:GOTO 580
560 WIRE=WIRE-0.00019999999494757503!
570 :REM'
580 B(Z,1)=WIRE
590 CIRC=(WIRE*10^3)^2     :REM'circular mils
600 A=WIRE/2
610 OHM=304.79998779296875!/(58*PI*(A*25.399999618530273!)^2)   :REM'resistance per 1000 feet
620 B(Z,2)=OHM
630 NEXT Z
640 :REM'
650 :REM'.....current in air
660 DATA 73,55,41,32,22,16,11
670 :REM'.....current in cable
680 DATA 46,33,23,17,13,10,7.5,5
690 :REM'
700 FOR Z=8 TO 20 STEP 2:READ A(Z,3):NEXT Z     :REM'current in air
710 FOR Z=8 TO 22 STEP 2:READ A(Z,4):NEXT Z     :REM'current in cable/bundles
720 :REM'
730 :REM'.....start
740 CLS
750 COLOR 15,2
760 PRINT" COPPER WIRE DATA";TAB(57);"by George Murphy VE3ERP ";
770 COLOR 1,0:PRINT STRING$(80,223);
780 COLOR 7,0
790 GOSUB 8380
800 PRINT UL$;
810 PRINT "       Press number in < > to choose standard units of measure:"
820 PRINT UL$;
830 PRINT "       < 1 >  Metric (where applicable)"
840 PRINT "       < 2 >  U.S.A./Imperial"
850 PRINT UL$;
860 PRINT "       or press <0> to EXIT....."
870 Z$=INKEY$
880 IF Z$="0"THEN CLS:CHAIN GO$
890 IF Z$="1"THEN UM=25.399999618530273!:UM$="mm.":GOTO 920
900 IF Z$="2"THEN UM=1:UM$="in.":GOTO 920
910 GOTO 870
920 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
930 LOCATE 3,25:COLOR 0,7
940 PRINT " Press letter in < > for...... ":COLOR 7,0
950 PRINT UL$;
960 PRINT "  < a >  Copper wire table - metric/inch/AWG"
970 PRINT "  < b >  Copper wire table - metric/inch/BSWG"
975 PRINT "  < c >  Copper wire properties"
980 PRINT "  < d >  Current carrying capacity of AWG sizes of copper wire"
990 PRINT "  < e >  Current carrying capacity of printed circuit board traces"
1000 PRINT "  < f >  DC resistance of copper wire"
1010 PRINT "  < g >  RF resistance of copper wire & skin effect"
1020 PRINT "  < h >  Stranded copper wire (AWG Standard)"
1030 PRINT "  < i >  Voltage drop in long wire runs"
1040 PRINT "  < j >  Weight of copper wire"
1050 PRINT "  < k >  Wire size conversions - metric/inch/AWG"
1060 PRINT "  < l >  Wire size conversions - AWG/BSWG"
1070 PRINT "  < m >  Wire table - enameled copper wire"
1080 PRINT "  < z >  QUIT";
1090 Z$=INKEY$
1100 IF Z$="a"THEN GA$="A.W.G.":GOTO 2140
1110 IF Z$="b"THEN GA$="B.S.W.G.":GOTO 2140
1114 IF Z$="c"THEN CHAIN"wireprop"
1120 IF Z$="d"THEN 1850
1130 IF Z$="e"THEN 6500
1140 IF Z$="f"THEN 4260
1150 IF Z$="g"THEN 3610
1160 IF Z$="h"THEN 7080
1170 IF Z$="i"THEN 1310
1180 IF Z$="j"THEN 3020
1190 IF Z$="k"THEN 2800
1200 IF Z$="l"THEN 5130
1210 IF Z$="m"THEN 5660
1220 IF Z$="z"THEN 730
1230 GOTO 1090
1240 :REM'
1250 :REM'.....display input
1260 LOCATE CSRLIN-1:PRINT STRING$(7,32)
1270 LOCATE CSRLIN-1,39:PRINT STRING$(40,32)
1280 LOCATE CSRLIN-1,39:PRINT ".......";USING U$;Q;
1290 RETURN
1300 :REM'
1310 :REM'.....voltage drop
1320 CLS
1330 IF UM=1 THEN M=1:M$="ft.":ELSE M=0.30480000376701355!:M$="m."
1340 H$=" VOLTAGE DROP IN COPPER WIRE CONDUCTOR"
1350 COLOR 15,2
1360 PRINT H$;
1370 PRINT TAB(57);"by George Murphy VE3ERP ";
1380 COLOR 1,0:PRINT STRING$(80,223);
1390 COLOR 7,0
1400 PRINT " ENTER: Length of wire.........(";M$;")";:INPUT L:L=L/M
1410 IF L=0 THEN LOCATE CSRLIN-1:PRINT STRING$(78,32):LOCATE CSRLIN-1:GOTO 1400
1420 LG=INT(L*10*M+0.5!)/10
1430 INPUT " ENTER: Current...............(amps)";I
1440 IF I=0 THEN LOCATE CSRLIN-1:PRINT STRING$(78,32):LOCATE CSRLIN-1:GOTO 1430
1450 INPUT " ENTER: Circular mils per amp (if applicable)...";CMA
1460 VIEW PRINT 3 TO 23:CLS:VIEW PRINT
1470 COLOR 2,2:LOCATE 1,1:PRINT STRING$(80,32);
1480 COLOR 15,2
1490 LOCATE 1,1:PRINT H$;LG;M$;" long @";I;"amp ";
1500 COLOR 7,0
1510 LOCATE 3
1520 FOR Z=1 TO 40
1530 CM=(A(Z,1)*1000)^2                     :REM'circular mils
1540 R=A(Z,2)/1000*L                        :REM'ohms/1000 ft.
1550 E=I*R                                  :REM'voltage drop
1560 C=I*CMA:IF CM>=C THEN W=Z              :REM'CMA = CM per amp.
1570 IF CM<C THEN COLOR 0,7 :ELSE COLOR 7,0
1580 IF Z/2<>INT(Z/2)THEN LOCATE CSRLIN,1 :ELSE LOCATE CSRLIN-1,42
1590 PRINT " #";
1600 IF Z<10 THEN PRINT " ";
1610 PRINT Z;"AWG";
1620 Z$="#####.####"
1630 IF R>=10   THEN Z$="######.###"
1640 IF R>=10^2 THEN Z$="#######.##"
1650 IF R>=10^3 THEN Z$="########.#"
1660 PRINT USING Z$;R;:PRINT " Ω";
1670 Z$="#####.####"
1680 IF E>=10   THEN Z$="######.###"
1690 IF E>=10^2 THEN Z$="#######.##"
1700 IF E>=10^3 THEN Z$="########.#"
1710 PRINT USING Z$;E;:PRINT " v."
1720 NEXT Z
1730 COLOR 7,0:PRINT UL$;
1740 FOR Z=2 TO 22:LOCATE Z,41:PRINT "║":NEXT Z  :REM'print vertical bar
1750 LOCATE 23,41:PRINT CHR$(202)
1760 PRINT " Ω= resistance of";LG;M$;" of wire,";
1770 PRINT " v.= voltage drop in";LG;M$;" of wire";
1780 IF W=40 THEN 1820
1790 COLOR 0,7:LOCATE 23,3
1800 PRINT" Current exceeds";CMA;"CM per amp capacity of wires smaller than";
1810 PRINT" AWG";W;
1820 COLOR 7,0
1830 GOTO 8600
1840 :REM'
1850 :REM'.....current carrying capacity
1860 CLS
1870 COLOR 15,2
1880 PRINT" CONTINUOUS-DUTY CAPACITY OF COPPER WIRE in AMPERES";
1890 PRINT TAB(57)"by George Murphy VE3ERP ";
1900 COLOR 1,0:PRINT STRING$(80,223);
1910 COLOR 7,0
1920 PRINT " Wire Size  Ohms/Mft.  ";
1930 PRINT " Single  Bunched   Chassis   500 cmA   700 cmA  1000 cmA"
1940 PRINT UL$;
1950    FOR Z=10 TO 40 STEP 2
1960 PRINT "  ";Z;" AWG";
1970 PRINT USING "######.###";A(Z,2);
1980 IF A(Z,3)=0 THEN PRINT "       - ";:GOTO 2000
1990 PRINT USING "#######.#";A(Z,3);
2000 IF A(Z,4)=0 THEN PRINT "       - ";:GOTO 2020
2010 PRINT USING "#######.#";A(Z,4);
2020 CM=(A(Z,1)*1000)^2
2030 PRINT USING "#######.##";CM/250;
2040 PRINT USING "#######.##";CM/500;
2050 PRINT USING "#######.##";CM/700;
2060 PRINT USING "#######.##";CM/1000
2070    NEXT Z
2080 PRINT" <Single> = Single wire in open air (e.g. power transmission line)."
2090 PRINT" <Bunched>= Wires or cables in conduits or bundles."
2100 PRINT" <Chassis>= Short point-to-point & general chassis wiring (250 cmA)."
2110 PRINT" <cmA>    = Circular mils per amp.(used in transformer design).";
2120 GOTO 8600
2130 :REM'
2140 :REM'.....wire table
2150 CLS
2160 COLOR 15,2
2170 PRINT " COPPER WIRE TABLE - ";GA$;" SIZES";
2180 PRINT TAB(57);"by George Murphy VE3ERP ";
2190 COLOR 1,0:PRINT STRING$(80,223);
2200 COLOR 7,0
2210 :REM'
2220 FOR N=1 TO 40
2230 T=2:L=CSRLIN
2240 IF N/2=INT(N/2)THEN T=43:L=CSRLIN-1
2250 LOCATE L,T
2260 PRINT "#";USING "###";N;
2270 IF UM<>1 THEN 2490 :ELSE 2290
2280 :REM'
2290 :REM'.....USA/IMPERIAL table
2300 IF GA$="A.W.G."THEN WIRE=A(N,1):ELSE WIRE=B(N,1)
2310 PRINT "  ";CHR$(237);USING ".####";WIRE;
2320 PRINT CHR$(34);
2330 CM=(WIRE*10^3)^2
2340 Z$="####,###"
2350 IF CM<10^4 THEN Z$="######.#"
2360 IF CM<10^3 THEN Z$="#####.##"
2370 IF CM<10^2 THEN Z$="####.###"
2380 IF CM<10   THEN Z$="###.####"
2390 PRINT USING Z$;CM;:PRINT " φm";
2400 IF GA$="A.W.G."THEN OHM=A(N,2):ELSE OHM=B(N,2)
2410 Z$="####.####"
2420 IF OHM>=10   THEN Z$="#####.###"
2430 IF OHM>=10^2 THEN Z$="######.##"
2440 IF OHM>=10^3 THEN Z$="#######.#"
2450 PRINT USING Z$;OHM;
2460 PRINT " Ω/M"
2470 GOTO 2640
2480 :REM'
2490 :REM'.....Metric table
2500 IF GA$="A.W.G."THEN WIRE=A(N,1):ELSE WIRE=B(N,1)
2510 PRINT "  ";CHR$(237);USING "#.###";WIRE*UM;
2520 AR=(WIRE*UM/2)^2*PI
2530 Z$="#####.##":IF AR<10 THEN Z$="####.###"
2540 PRINT USING Z$;AR;:PRINT " mm²";
2550 IF GA$="A.W.G."THEN OHM=A(N,2):ELSE OHM=B(N,2)
2560 Z$="####.####"
2570 IF OHM/0.30480000376701355!>=10   THEN Z$="#####.###"
2580 IF OHM/0.30480000376701355!>=10^2 THEN Z$="######.##"
2590 IF OHM/0.30480000376701355!>=10^3 THEN Z$="#######.#"
2600 PRINT USING Z$;OHM/0.30480000376701355!;
2610 PRINT " Ωkm"
2620 GOTO 2640
2630 :REM'
2640  NEXT N
2650 :REM'
2660 PRINT UL$;
2670 FOR Z=2 TO 22:LOCATE Z,41:PRINT CHR$(186):NEXT Z
2680 LOCATE 23,41:PRINT CHR$(202)
2690 IF UM=1 THEN 2750
2700 PRINT " φ = Diameter (mm)";
2710 PRINT TAB(30);"mm² = cross-section area";
2720 PRINT TAB(67);"Ωkm = Ohms/km";
2730 GOTO 2780
2740 :REM'
2750 PRINT " φ = Diameter (in.)";
2760 PRINT TAB(23);"φm=Circular Mils (wire diameter x 1000)²";
2770 PRINT TAB(65);"Ω/M = Ohms/M ft.";
2780 GOTO 8600
2790 :REM'
2800 :REM'.....calculate size or gauge
2810 CLS
2820 COLOR 15,2
2830 PRINT " SOLID COPPER WIRE SIZES";
2840 PRINT TAB(57);"by George Murphy VE3ERP ";
2850 COLOR 1,0:PRINT STRING$(80,223);
2860 COLOR 7,0
2870 IF UM=1 THEN STD=1:GOTO 4650 :ELSE STD=2:GOTO 2890
2880 :REM'
2890 :REM'.....metric wire sizes
2900 COLOR 15,2
2910 PRINT " METRIC:";
2920 COLOR 0,7
2930 PRINT " Press (1) to enter diameter,(2) to enter X-section area,";
2940 PRINT "(0) to quit..."
2950 COLOR 7,0
2960 Z$=INKEY$
2970 IF Z$="0"THEN LOCATE CSRLIN-1:PRINT ER$;:GOTO 8600
2980 IF Z$="1"THEN 4490
2990 IF Z$="2"THEN 4570
3000 GOTO 2960
3010 :REM'
3020 :REM'.....weight of copper wire
3030 CLS
3040 COLOR 15,2
3050 PRINT " WEIGHT OF SOLID COPPER WIRE";TAB(57);"by George Murphy VE3ERP ";
3060 COLOR 1,0:PRINT STRING$(80,223);
3070 COLOR 7,0
3080 PRINT " Press number in < > to choose unit of measurement of wire size:"
3090 PRINT UL$;
3100 PRINT "  < 1 >  AWG gauge #"
3110 PRINT "  < 2 >  Diameter in inches"
3120 PRINT "  < 3 >  Diameter in millimetres"
3130 PRINT UL$;
3140 W$=INKEY$
3150 IF W$="1"THEN SZ$="AWG #":D$=" AWG":GOTO 3190
3160 IF W$="2"THEN SZ$="dia. in inches":D$=CHR$(34)+" dia.":GOTO 3190
3170 IF W$="3"THEN SZ$="dia. in mm.":D$="mm dia.":GOTO 3190
3180 GOTO 3140
3190 PRINT " ENTER: Wire ";SZ$;"......";:INPUT X
3200 IF W$="1"THEN 3240
3210 IF W$="2"THEN R=X/2:GOTO 3290
3220 IF W$="3"THEN R=X/25.399999618530273!/2:GOTO 3290
3230 :REM'
3240 FOR Z=1 TO 40
3250 IF Z=X THEN 3270
3260 NEXT Z
3270 R=A(Z,1)/2          :REM'radius
3280 :REM'
3290 AR=PI*R^2           :REM'cross-section area
3300 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
3310 PRINT " Press number in < > to choose unit of measurement of wire length:"
3320 PRINT UL$;
3330 PRINT "  < 1 >  Feet"
3340 PRINT "  < 2 >  Metres"
3350 PRINT UL$;
3360 L$=INKEY$
3370 IF L$="1"THEN LG$="feet":GOTO 3400
3380 IF L$="2"THEN LG$="metres":GOTO 3400
3390 GOTO 3360
3400 PRINT " ENTER: Length of wire in ";LG$;"........";:INPUT L
3410 IF L$="1"THEN LG=L*12:GOTO 3430
3420 IF L$="2"THEN LG=L*3.0480000972747803!*12:GOTO 3430
3430 CU=AR*LG            :REM'cubic inches of wire
3440 PCI=0.32100000977516174!            :REM'weight of 1 cubic inch of copper
3450 WLB=CU*PCI          :REM'weight in pounds
3460 LGLB=L/WLB          :REM'length units per pound
3470 WKG=CU*PCI/2.200000047683716!      :REM'weight in kilograms
3480 LGKG=L/WKG          :REM'length units per kilogram
3490 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
3500 IF D$=" AWG"THEN Y$=" #":ELSE Y$=""
3510 PRINT " Weight of";L;LG$;" of";Y$;STR$(X);D$;" bare copper wire:";
3520 PRINT TAB(55);USING "###.##";WLB;:PRINT " lb."
3530 PRINT TAB(55);USING "###.##";WKG;:PRINT " Kg."
3540 PRINT UL$;
3550 PRINT " Base weight:";
3560 PRINT TAB(14);USING "##,###.#";LGLB;:PRINT " ";LG$;:PRINT "/lb."
3570 PRINT TAB(14);USING "##,###.#";LGKG;:PRINT " ";LG$;:PRINT "/Kg."
3580 PRINT UL$;
3590 GOTO 8600
3600 :REM'
3610 :REM'.....RF resistance
3620 CLS
3630 COLOR 15,2
3640 PRINT " RF Resistance of Copper Wire";TAB(57);"by George Murphy VE3ERP ";
3650 COLOR 1,0:PRINT STRING$(80,223);
3660 COLOR 7,0
3670 U=1            :REM'permeability of copper
3680 UO=4*PI*10^-7  :REM'permeability for vacuum in Henry per metre
3690 D=5.800000190734863!*10^7     :REM'conductivity of copper in mho/metre
3700 :REM'
3710 PRINT " Press number in < > to choose method of entering wire size";
3720 PRINT UL$;
3730 PRINT "   < 1 > Diameter in millimetres"
3740 PRINT "   < 2 > Diameter in decimal inches"
3750 PRINT "   < 3 > Diameter in AWG gauge"
3760 Z$=INKEY$:IF Z$=""THEN 3760
3770 IF Z$="1"THEN Z$="mm.":GOTO 3810
3780 IF Z$="2"THEN Z$="in.":GOTO 3810
3790 IF Z$="3"THEN Z$="AWG":GOTO 3810
3800 GOTO 3760
3810 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
3820 PRINT " Diameter of wire.............(";Z$;")";:INPUT Z
3830 IF Z$="mm."THEN MM=Z
3840 IF Z$="in."THEN MM=Z*25.399999618530273!
3850 IF Z$="AWG"THEN MM=A(Z,1)*25.399999618530273!
3860 LOCATE CSRLIN-1,31:PRINT USING V$;MM;:PRINT " mm =";USING V$;MM/25.399999618530273!;
3870 PRINT " in.";
3880 IF Z$="AWG"THEN PRINT "  (#";Z;Z$;")" :ELSE PRINT ""
3890 A=MM/2/10^3    :REM'1/2 dia. of wire in metres
3900 :REM'
3910 IF UM$="mm."THEN Z$=" m." :ELSE Z$="ft."
3920 PRINT " Length of wire...............(";Z$;")";:INPUT L
3930 IF UM$="in."THEN L=L*0.30480000376701355!
3940 LOCATE CSRLIN-1,31:PRINT USING V$;L;:PRINT " m. =";USING V$;L/0.30480000376701355!;
3950 PRINT " ft."
3960 :REM'
3970 INPUT " Frequency....................(MHz)";FZ
3980 LOCATE CSRLIN-1,31:PRINT USING V$;FZ;:PRINT " MHz"
3990 F=FZ*10^6
4000 :REM'
4010 RDC=L*1/(PI*A^2*D)
4020 PRINT " DC resistance................";USING V$;RDC;:PRINT " Ω"
4030 :REM'
4040 W=2*PI*F
4050 RE=L*1/(2*PI*A)*SQR(W*U*UO/(2*D))
4060 PRINT " Reactance....................";USING V$;RE;:PRINT " Ω"
4070 PRINT " RF surface resistance........";USING V$;RE;:PRINT " Ω";
4080 PRINT "   (same value as reactance)"
4090 :REM'
4100 DS=SQR(2/(U*UO*W*D))*10^3
4110 PRINT " RF Penetration depth.........";USING V$;DS;:PRINT " mm =";
4120 PRINT USING V$;DS/25.399999618530273!;:PRINT " in. (skin effect)"
4130 PRINT UL$;
4140 LOCATE 15
4150 T=9
4160 PRINT TAB(T);
4170 PRINT "Program suggested by Göran Hosinsky, EA8YU, using formulae by"
4180 PRINT TAB(T);
4190 PRINT "SM0AQW in an article in QTC 1996 no.2, from original material"
4200 PRINT TAB(T);
4210 PRINT "published in Fundamental Electromagnetic Theory, by Ronold King"
4220 PRINT TAB(T);
4230 PRINT "(Dover Publications Inc.)"
4240 GOTO 8600
4250 :REM'
4260 :REM'.....DC resistance
4270 CLS
4280 COLOR 15,2
4290 PRINT " DC Resistance of Copper Wire";TAB(57);"by George Murphy VE3ERP ";
4300 COLOR 1,0:PRINT STRING$(80,223);
4310 COLOR 7,0
4320 PRINT " ENTER: Wire diameter..........(";UM$;")";:INPUT D
4330 IF UM=1 THEN D=D*25.399999618530273!
4340 LOCATE CSRLIN-1
4350 PRINT "        Wire diameter..........";USING V$;D;
4360 PRINT " mm. =";USING V$;D/25.399999618530273!;:PRINT " in."
4370 PRINT " ENTER: Wire length............(";UM$;")";:INPUT L
4380 IF UM=1 THEN L=L*25.399999618530273!
4390 LOCATE CSRLIN-1
4400 IF L<1000 THEN M$=" mm. =":Z=L::ELSE M$=" m.  =":Z=L/10^3
4410 PRINT "        Wire length............";USING V$;Z;:PRINT M$;
4420 IF L/25.399999618530273!<100 THEN M$=" in.":Z=L/25.399999618530273!::ELSE M$=" ft.":Z=L/304.79998779296875!
4430 PRINT USING V$;Z;:PRINT M$
4440 A=D/2       :REM'radius of wire
4450 R=L/10^3/(PI*A^2*58)
4460 PRINT "        Resistance.............";USING V$;R;:PRINT " ohms"
4470 GOTO 8600
4480 ,
4490 :REM'.....metric wire diameter
4500 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1
4510 COLOR 0,7:INPUT " ENTER: Diameter of wire (mm) ";M
4520 COLOR 7,0
4530 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1
4540 W=M/25.399999618530273!
4550 GOTO 4740
4560 :REM'
4570 :REM'.....metric wire cross section area
4580 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1
4590 COLOR 0,7:INPUT " ENTER: Cross-section area of wire (mm²) ";A
4600 COLOR 7,0
4610 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1
4620 W=SQR(A/PI)*2/25.399999618530273!
4630 GOTO 4740
4640 :REM'
4650 :REM'.....AWG & decimal wire sizes
4660 COLOR 0,7
4670 INPUT" ENTER: AWG Gauge #, or Dia.in decimal inches, or 0 to quit..";W
4680 COLOR 7,0
4690 IF W=0 THEN LOCATE CSRLIN-1:PRINT ER$;:GOTO 8600
4700 LOCATE CSRLIN-1
4710 PRINT ER$;
4720 LOCATE CSRLIN-1
4730 :REM'
4740 IF(W>0.30000001192092896!)AND(W<1)THEN BEEP:GOTO 4660
4750 IF W<1 THEN 4820
4760 GA=W
4770 GOSUB 5020                          :REM'print line
4780 PRINT UL$;
4790 IF STD=1 THEN 4650
4800 IF STD=2 THEN 2890
4810 :REM'
4820 FOR Z=70 TO 1 STEP-1
4830 IF A(Z,1)>=W THEN GA=Z:GOTO 4850
4840 NEXT Z
4850 GOSUB 5020
4860 COLOR 15,2
4870 K#=(0.46000000834465027!/0.004999999888241291!)^(1/39)
4880 AWG=LOG(0.46000000834465027!/W)/(LOG(K#))-3
4890 PRINT " AWG #";USING "##.#####";AWG;
4900 PRINT "        ";USING ".####";W;
4910 DI=W:GOSUB 5070
4920 COLOR 7,0
4930 FOR Z=1 TO 70
4940 IF A(Z,1)<W THEN GA=Z:GOTO 4960
4950 NEXT Z
4960 GOSUB 5020
4970 COLOR 7,0
4980 PRINT UL$;
4990 IF STD=1 THEN 4660
5000 IF STD=2 THEN 2890
5010 :REM'
5020 :REM'.....display wire table
5030 PRINT " AWG #";USING "##";GA;
5040 DI=A(GA,1)
5050 PRINT TAB(23);USING ".####";DI;
5060 :REM'
5070 PRINT CHR$(34);" dia.";
5080 CM=(DI*1000)^2
5090 PRINT USING "###,### c.m.(";CM;
5100 PRINT USING "##.### mm dia. ###.#### mm² area)";DI*25.399999618530273!,(DI*25.399999618530273!/2)^2*PI
5110 RETURN
5120 :REM'
5130 :REM'.....AWG/BWG equivalents
5140 LOCATE 1,1:COLOR 15,2:PRINT " AWG / BSWG EQUIVALENTS"
5150 COLOR 7,0:VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
5160 PRINT " Press letter in < > to:"
5170 PRINT UL$;
5180 PRINT "   < a > Convert AWG to BSWG"
5190 PRINT "   < b > Convert BSWG to AWG"
5200 Z$=INKEY$:IF Z$=""THEN 5200
5210 IF Z$="a"THEN 5250
5220 IF Z$="b"THEN 5420
5230 GOTO 5200
5240 :REM'
5250 :REM'.....AWG
5260 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
5270 INPUT " ENTER: AWG gauge number (1-50)";N
5280 IF N<1 OR N>50 THEN 5260
5290 FOR Z=1 TO 50
5300 IF B(Z,1)<A(N,1)THEN 5330
5310 NEXT Z
5320 LOCATE 3:GOTO 5360
5330 LOCATE 3
5340 PRINT " BSWG#";USING "### =";Z;
5350 PRINT USING "##.#### in.(##.### mm) dia.";B(Z,1),B(Z,1)*25.399999618530273!
5360 COLOR 0,7:PRINT "  AWG#";USING "### =";N;:COLOR 7,0
5370 PRINT USING "##.#### in.(##.### mm) dia.";A(N,1),A(N,1)*25.399999618530273!
5380 PRINT " BSWG#";USING "### =";Z-1;
5390 PRINT USING "##.#### in.(##.### mm) dia.";B(Z-1,1),B(Z-1,1)*25.399999618530273!
5400 GOTO 5600
5410 :REM'
5420 :REM'.....BSWG
5430 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
5440 INPUT " ENTER: BSWG gauge number (1-50)";N
5450 IF N<1 OR N>50 THEN 5430
5460 FOR Z=1 TO 50
5470 IF A(Z,1)<B(N,1)THEN 5500
5480 NEXT Z
5490 LOCATE 3:GOTO 5530
5500 LOCATE 3
5510 PRINT "  AWG#";USING "### =";Z;
5520 PRINT USING "##.#### in.(##.### mm) dia.";A(Z,1),A(Z,1)*25.399999618530273!
5530 COLOR 0,7:PRINT " BSWG#";USING "### =";N;:COLOR 7,0
5540 PRINT USING "##.#### in.(##.### mm) dia.";B(N,1),B(N,1)*25.399999618530273!
5550 IF Z=1 THEN 5580
5560 PRINT "  AWG#";USING "### =";Z-1;
5570 PRINT USING "##.#### in.(##.### mm) dia.";A(Z-1,1),A(Z-1,1)*25.399999618530273!
5580 GOTO 5600
5590 :REM'
5600 LOCATE 13,30:COLOR 0,7:PRINT " Try another?  (y/n) ":COLOR 7,0
5610 Z$=INKEY$:IF Z$=""THEN 5610
5620 IF Z$="n"THEN 730
5630 IF Z$="y"THEN 5130
5640 GOTO 5610
5650 :REM'
5660 :REM'.....enamelled copper wire
5670 CLS:KEY OFF
5680 PRINT " Enameled Copper Wire Table"
5690 PRINT UL$;
5700 PRINT " This table assumes a default current density of 1000 amperes per";
5710 PRINT " square inch, "
5720 PRINT " a conservative value commonly used in the design of power supply";
5730 PRINT " transformers."
5740 PRINT
5750 PRINT " For very small transformers, densities up to 2500 A/in² are some";
5760 PRINT "times used.   "
5770 PRINT
5780 PRINT " For general purpose wiring the maximum safe density of 5000 A/in";
5790 PRINT "² may be used."
5800 PRINT
5810 COLOR 0,7
5820 PRINT " Do you want to change the default density of 1000 A/in² ?   (y/n)"
5830 Z$=INKEY$:IF Z$=""THEN 5830
5840 IF Z$="n"THEN CD$="1000":GOTO 5890
5850 IF Z$="y"THEN 5870
5860 GOTO 5830
5870 INPUT " ENTER: Current density in A/in² ";CD$
5880 IF LEN(CD$)<4 THEN CD$=" "+CD$:GOTO 5880
5890 CD=VAL(CD$):COLOR 7,0
5900 :REM'.....AWG calculator
5910 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
5920 J=1.0063860416412354!:Q=SQR(J)
5930 FOR Z=1 TO 40
5940 N=Z+3
5950 Q=Q*J
5960 GA(Z,1)=0.46000000834465027!/K^N
5970 GA(Z,2)=GA(Z,1)*Q
5980 RAD=GA(Z,1)/2 :REM'wire radius
5990 AREA= PI*RAD^2
6000 GA(Z,3)=1/(GA(Z,2)*1.100000023841858!)
6010 GA(Z,4)=AREA*CD    :REM'current capacity in amps @ CD amps/sq.in.
6020 GA(Z,5)=(304.79998779296875!/(58*PI*(RAD*25.399999618530273!)^2))   :REM'ohms/M feet @ 20°C
6030 GA(Z,6)=0.25!  :REM'coil margin
6040 IF Z>14 THEN GA(Z,6)=0.1875!
6050 IF Z>17 THEN GA(Z,6)=0.125!
6060 IF Z>31 THEN GA(Z,6)=0.09375!
6070 IF Z>37 THEN GA(Z,6)=0.0625!
6080 GA(Z,7)=0.009999999776482582!  :REM'interlayer insulation
6090 IF Z>17 THEN GA(Z,7)=0.004999999888241291!
6100 IF Z>21 THEN GA(Z,7)=0.003000000026077032!
6110 IF Z>24 THEN GA(Z,7)=0.0020000000949949026!
6120 IF Z>29 THEN GA(Z,7)=0.001500000013038516!
6130 IF Z>33 THEN GA(Z,7)=0.0010000000474974513!
6140 IF Z>38 THEN GA(Z,7)=0.000750000006519258!
6150 NEXT Z
6160 :REM'
6170 :REM'.....wire table
6180 LN=6
6190 PRINT TAB(18)"ROUND ENAMELED COPPER POWER TRANSFORMER WIRE"
6200 PRINT TAB(3)"Ref.";
6210 PRINT TAB(8)"Reference Data for Radio Engineers, 2nd edition 1949, p.126 &"
6220 PRINT TAB(8);CHR$(34);"Round Heavy Film Insulated Solid Copper";
6230 PRINT CHR$(34);" chart - Belden Corp."
6240 PRINT STRING$(80,205);
6250 PRINT TAB(3)"AWG│"TAB(9)"Wire │"TAB(16)"Enamel│"TAB(23)" Turns │"TAB(33)"Max.I @ │";
6260 PRINT TAB(44)"Ω/M ft.│"TAB(54)"Ω/M ft.│"TAB(63)"Coil │";TAB(70)"Layer │"
6270 :REM'
6280 PRINT TAB(4)"# │"TAB(9)"Size │"TAB(17)"O.D. │"TAB(23)"per in.│"TAB(31)CD$+" A/in²│";
6290 PRINT TAB(44)"@ 20°C.│"TAB(54)"@ 50°C.│"TAB(62)"margin│"TAB(70)"Insul.│"
6300 FOR Z=10 TO 40:LN=LN+1
6310 PRINT USING "  ## │ .#### │ .#### │ ###.# │";Z,GA(Z,1),GA(Z,2),GA(Z,3);
6320 PRINT USING " ###.###  │ ####.## │ ####.## │";GA(Z,4),GA(Z,5),GA(Z,5)*1.1200000047683716!;
6330 PRINT USING " .### │ .#### │";GA(Z,6),GA(Z,7);
6340 IF LN<24 THEN PRINT ""
6350 IF LN=24 THEN GOSUB 8650:CLS:LN=0
6360 NEXT Z
6370 PRINT
6380 PRINT " All dimensions are in inches."
6390 PRINT " ";CHR$(34);
6400 PRINT "Enamel";CHR$(34);" refers also to any plastic film coating."
6410 PRINT " Thickness of enamel varies between manufacturers. Values shown a";
6420 PRINT "re maximum."
6430 PRINT " Turns-Per-Inch based on turns spaced at 110% of enamel O.D. ";
6440 PRINT "centre-to-centre."
6450 PRINT " Current capacity based on";CD;"amperes per square inch."
6460 PRINT
6470 LOCATE ,36: PRINT "TABLE A"
6480 GOTO 8600
6490 :REM'
6500 :REM'pctrace - circuit boards
6510 CLS
6520 PRINT " PRINTED CIRCUIT BOARD TRACES"
6530 PRINT UL$;
6540 PRINT " Of these three dimensions -"
6550 PRINT "  1) Thickness of copper layer;"
6560 PRINT "  2) Width of copper trace;"
6570 PRINT "  3) Diameter of an equivalent solid copper wire;"
6580 PRINT " Enter any two to calculate the third."
6590 PRINT " The trace will carry approximately the same current as the ";
6600 PRINT "equivalent wire."
6610 PRINT
6620 PRINT " To find the diameter of an equivalent copper wire for a given c";
6630 PRINT "urrent, run the"
6640 PRINT " `Wire Table - Enameled Copper Wire' program using a Current Den";
6650 PRINT "sity of 1000   "
6660 PRINT " amps per sq.inch. This density is appropriate for PC board trac";
6670 PRINT "e applications."
6680 PRINT
6690 PRINT UL$;
6700 LOCATE 15,17:COLOR 0,7
6710 PRINT " Do you want to see the wire table now?   (y/n) "
6720 Z$=INKEY$:IF Z$=""THEN 6720
6730 IF Z$="y"THEN COLOR 7,0:CLS:GOTO 5660
6740 IF Z$="n"THEN COLOR 7,0:GOTO 6760
6750 GOTO 6720
6760 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 15
6770 PRINT TAB(25)"Press <ENTER> if value unknown"
6780 T=0:W=0:D=0
6790 PI=4*ATN(1)
6800 T$=" ENTER: Thickness of copper layer ("+UM$+")....."
6810 W$=" ENTER: Width of copper trace ("+UM$+")........."
6820 D$=" ENTER: Diameter of equivalent wire ("+UM$+")..."
6830 VIEW PRINT 16 TO 24:CLS:VIEW PRINT:LOCATE 16
6840 IF T=0 THEN PRINT T$;:INPUT Z:T=Z/UM:GOSUB 6880
6850 IF W=0 THEN PRINT W$;:INPUT Z:W=Z/UM:GOSUB 6880
6860 IF D=0 THEN PRINT D$;:INPUT Z:D=Z/UM:GOSUB 6880
6870 IF T*W*D THEN 6920 :ELSE 6830
6880 IF T=0 AND W*D<>0 THEN R=D/2:T=PI*R^2/W:GOTO 6830
6890 IF W=0 AND T*D<>0 THEN R=D/2:W=PI*R^2/T:GOTO 6830
6900 IF D=0 AND T*W<>0 THEN R=SQR(T*W/PI):D=2*R:GOTO 6830
6910 RETURN
6920 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 16
6930 PRINT USING " Thickness of copper layer..... #.##mm = ##.### in.";T*25,T
6940 PRINT USING " Width of copper trace......... #.##mm = ##.### in.";W*25,W
6950 PRINT USING " Diameter of equivalent wire... #.##mm = ##.### in.";D*25,D;
6960 AWG=LOG(0.46000000834465027!/D)/(LOG(1.1229000091552734!))-3
6970 PRINT USING " = no. ##.# AWG";AWG
6980 PRINT
6990 PRINT UL$;
7000 GOSUB 8650
7010 LOCATE 22:PRINT " (a)nother?  (w)ire table?  (q)uit?      (a,w,q)"
7020 Z$=INKEY$
7030 IF Z$="a"THEN 6760
7040 IF Z$="w"THEN 5660
7050 IF Z$="q"THEN 730
7060 GOTO 7020
7070 :REM'
7080 :REM'.....Stranded wire
7090 CLS:COLOR 15,2,1
7100 PRINT " STRANDED COPPER WIRE"TAB(57)"by George Murphy VE3ERP ";
7110 COLOR 1,0:PRINT STRING$(80,223);
7120 COLOR 7,0
7130 PRINT " Press number in <> for:"
7140 PRINT UL$;
7150 PRINT "   < 1 > AWG Standard Copper Conductors"
7160 PRINT "   < 2 > Analyze unknown stranded cable"
7170 PRINT
7180 PRINT "   < 0 > Quit"
7190 Z$=INKEY$:IF Z$=""THEN 7190
7200 IF Z$="0"THEN 730
7210 IF Z$="1"THEN 7260
7220 IF Z$="2"THEN 8040
7230 GOTO 7190
7240 GOTO 7200
7250 :REM'
7260 :REM'..... AWG Standard Stranded Copper Wire
7270 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
7280 RESTORE 7300
7290 CLS:KEY OFF
7300 DATA .0974,.0867,.0772,.0688,.0612,.0545,.0486
7310 DATA .0432,.0385,.0305,.0242,.0192,.0152,.0121
7320 DATA .0096,.0076
7330 :REM'
7340 COLOR 15,2,1
7350 PRINT " STRANDED COPPER WIRE"TAB(57)"by George Murphy VE3ERP ";
7360 COLOR 1,0:PRINT STRING$(80,223);
7370 COLOR 7,0
7380 PRINT " The safe current carrying capacity of copper wire depends on the ";
7390 PRINT "heat it adds "
7400 PRINT " to its environment. A given size of wire can safely carry much mo";
7410 PRINT "re current as"
7420 PRINT " a single conductor in free air than it can when tightly packed in";
7430 PRINT " a cable or a"
7440 PRINT " transformer winding."
7450 PRINT
7460 PRINT " A safe current is one where the wire may be warm to the touch, bu";
7470 PRINT "t not hot    "
7480 PRINT " enough to create a fire hazard or to increase the resistance of t";
7490 PRINT "he wire to an"
7500 PRINT " appreciable degree."
7510 PRINT
7520 PRINT " A wire size of about 250 circular mils per ampere is recommended ";
7530 PRINT "for general  "
7540 PRINT " purpose chassis wiring and short lengths of loosely bunched cable";
7550 PRINT " typically   "
7560 PRINT " used in Amateur radio applications. Power transformer windings ma";
7570 PRINT "y require    "
7580 PRINT " sizes as large as 1000 circular mils per ampere."
7590 PRINT:COLOR 0,7
7600 INPUT " ENTER: Desired circular mils per ampere....";I
7610 COLOR 7,0:CLS
7620 :REM'
7630 FOR Z=2 TO 24
7640 IF Z>10 AND Z/2<>INT(Z/2)THEN 7750
7650 W(Z,2)=Z                  :REM'AWG #
7660 W(Z,3)=7                  :REM'no.of strands
7670 READ W(Z,4)               :REM'individual strand diameter
7680 R=W(Z,4)/2                :REM'strand radius
7690 W(Z,1)=(W(Z,4)*1000)^2*7  :REM'circular mils
7700 W(Z,5)=3*W(Z,4)           :REM'cable diameter
7710 W(Z,6)=PI*(W(Z,4)/2)^2*7  :REM'area
7720 W(Z,7)=W(Z,6)*12000*0.32100000977516174!  :REM'lbs./1000 ft.
7730 W(Z,8)=10371/W(Z,1)       :REM'resistance/1000 ft.
7740 W(Z,9)=W(Z,1)/I           :REM'max. current
7750 NEXT Z
7760 :REM'
7770 T$="TYPICAL A.W.G. STANDARD STRANDED COPPER CONDUCTORS"
7780 LOCATE ,(80-LEN(T$))/2:PRINT T$
7790 PRINT " │circular│ AWG │no.of│ea. wire│ cable  │total area│lbs.per │";
7800 PRINT "ohms per│ max.   │"
7810 PRINT " │  mils  │ no. │wires│diameter│diameter│  sq. in. │1000 ft.│";
7820 PRINT "1000 ft.│ amps.  │"
7830 PRINT " ╞════════╪═════╪═════╪════════╪════════╪══════════╪════════╪";
7840 PRINT "════════╪════════╡"
7850 FOR Z=2 TO 24
7860 IF Z>10 AND Z/2<>INT(Z/2)THEN 7970
7870 PRINT USING " │###,### │";W(Z,1);
7880 PRINT " #";USING "## │";W(Z,2);
7890 PRINT USING " ##  │";W(Z,3);
7900 PRINT USING "##.#### │";W(Z,4);
7910 PRINT USING "##.#### │";W(Z,5);
7920 PRINT USING "##.###### │";W(Z,6);
7930 PRINT USING "###.### │";W(Z,7);
7940 PRINT USING "###.### │";W(Z,8);
7950 PRINT USING "####.## │";W(Z,9);
7960 PRINT ""
7970 NEXT Z
7980 PRINT
7990 PRINT " Diameters are in decimal inches."
8000 PRINT " Max. current shown is for a current density of";
8010 PRINT USING "#### circular mils per ampere.";I;
8020 GOSUB 8650:GOTO 7080
8030 :REM'
8040 :REM'.....unknown stranded cable
8050 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
8060 PRINT
8070 PRINT " The individual strands in AWG stranded wire are not themselves s";
8080 PRINT "tandard AWG   "
8090 PRINT " sizes. For accurate analysis of a cable the strand diameter shou";
8100 PRINT "ld be measured"
8110 PRINT " with a micrometer or vernier caliper."
8120 PRINT
8130 INPUT " ENTER: Measured individual strand diameter (decimal inches) ";SD
8140 INPUT " ENTER: Number of strands in cable...........................";NS
8150 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
8160 PRINT USING " Number of strands in cable........... #######.#";NS
8170 PRINT USING " Measured individual strand diameter.. #######.#### in.";SD
8180 SA=PI*(SD/2)^2
8190 PRINT USING " Cross-section area of each strand....      ##.##^^^^ in²";SA
8200 AR=NS*SA
8210 PRINT USING " Total cross-section area.............      ##.##^^^^ in²";AR
8220 CM=(SD*1000)^2*NS
8230 PRINT USING " Cable circular mils.................. ###,###.#";CM
8240 W=SQR(CM)/1000
8250 PRINT USING " Equivalent solid single wire diameter      ##.#### in.";W
8260 AWG=LOG(0.46000000834465027!/W)/(LOG(1.1229000091552734!))-3
8270 IF AWG<1 THEN 8360
8280 PRINT USING " Equivalent AWG size of cable.........      ##.## AWG";AWG
8290 PRINT
8300 PRINT "  If cable is soft or annealed copper wire, then:"
8310 PRINT
8320 WT=AR*12000*0.32100000977516174!
8330 PRINT USING " Weight per 1000 feet ................ ###,###.## lb.";WT
8340 OHM=10371/CM
8350 PRINT USING " Resistance per 1000 feet............. #######.## ohms";OHM
8360 GOSUB 8650:GOTO 7080
8370 :REM'
8380 :REM'.....preface
8390 T=8
8400 PRINT TAB(T);
8410 PRINT "Most of the values produced by this program are computed from"
8420 PRINT TAB(T);
8430 PRINT "basic equations to a precision of 7 significant figures, with no"
8440 PRINT TAB(T);
8450 PRINT "rounding off anywhere in the calculations except in the final"
8460 PRINT TAB(T);
8470 PRINT "screen display. Most long-established published tables consist of"
8480 PRINT TAB(T);
8490 PRINT "values that may have been rounded-off during chained calculations."
8500 PRINT TAB(T);
8510 PRINT "The resulting final truncated published values may not be as"
8520 PRINT TAB(T);
8530 PRINT "precise as those produced by a computer. Because of this, you may"
8540 PRINT TAB(T);
8550 PRINT "find that HAMCALC calculations may not always agree to the last"
8560 PRINT TAB(T);
8570 PRINT "decimal place with our cherished handbooks!"
8580 RETURN
8590 :REM'
8600 :REM'.....end
8610 GOSUB 8650
8620 GOTO 730
8630 END
8640 :REM'
8650 :REM'PRT
8660 KEY OFF:GOSUB 8730:LOCATE 25,5:COLOR 0,2
8670 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
8680 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
8690 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 8690 :ELSE GOSUB 8730
8700 IF Z$="3"THEN RETURN
8710 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
8720 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 8660
8730 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
