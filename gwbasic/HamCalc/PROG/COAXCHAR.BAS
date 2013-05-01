5 SAVE"coaxchar"
10 :REM'COAXCHAR - Coaxial Cable - 02 MAY 94 rev. 27 AUG 09
20 CLS:KEY OFF
30 COMMON EX$,PROG$,C$
40 IF EX$=""THEN EX$="EXIT"
50 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
60 PROG$="coaxchar"
70 ON ERROR  GOTO 100
80 GOTO 170
90 :REM'
100 IF ERR=70 OR ERR=75 OR ERR=76 AND ERL=1560 THEN 120
110 BEEP:PRINT "Error";ERR;"in line";ERL:END
120 CLS:BEEP:PRINT " Error";ERR;" Path or File Access Error."
130 PRINT " You may be trying to write to a Read Only disc."
140 PRINT " Press F2 to start over, or F10 to EXIT."
150 END
160 :REM'
170 LF=1/LOG(10)    :REM'log factor to convert to base 10
180 PI=4*ATN(1)
190 DIM C$(60,9)    :REM'coax data
200 DIM L(20)       :REM'coax fault locator
210 UL$=STRING$(80,205)
220 U$="###.##"
230 V$="####.###"
240 W$="####.##"
250 :REM'
260 :REM'.....start
270 CLS:COLOR 7,0,0
280 B=0:C=0:E=0:I=0:O=0:U=0:V=0:ZO=0
290 GOSUB 1550      :REM'read data
300 COLOR 15,2
310 PRINT " COAXIAL CABLE CHARACTERISTICS";TAB(57);"by George Murphy VE3ERP ";
320 COLOR 1,0:PRINT STRING$(80,223);
330 COLOR 7,0
340 LOCATE 3,35:COLOR 0,7:PRINT " CONTENTS ":COLOR 7,0
350 PRINT "       - Coaxial Cable Equations"
360 PRINT "       - Coaxial Cable Primer"
370 PRINT "       - Coaxial cable physical dimensions"
380 PRINT "       - Coaxial Cable Fault Locator"
390 PRINT "       - Characteristics of commonly used coaxial cables"
400 PRINT "       - Attenuation in dB of commonly used coaxial cables"
410 PRINT "       - Characteristics of an unidentified coaxial cable"
420 PRINT "       - Find dielectric constant from published coaxial cable ";
430 PRINT "data"
440 PRINT "       - Transmission line length - physical vs. electrical"
450 PRINT "       - Transmission line stubs (coaxial cable)"
460 PRINT "       - Transmission line - square coaxial"
470 PRINT UL$;
480 PRINT " This program uses equations listed in Table 2, page 24-18 of the";
490 PRINT " ARRL Antenna "
500 PRINT " Book, 18th edition, to calculate characteristics of transmission";
510 PRINT " lines listed "
520 PRINT " on page 19.2 of the ARRL 2000 Handbook for Radio Amateurs."
530 PRINT UL$;
540 COLOR 0,7
550 PRINT " Press number in <   > to choose standard units of measure:"
560 COLOR 7,0
570 PRINT "                 < 1 >  Metric"
580 PRINT "                 < 2 >  U.S.A./Imperial"
590 COLOR 0,7:LOCATE ,10:PRINT " or Press 0 to EXIT ":COLOR 7,0
600 LOCATE 25,10
610 PRINT "This program is based on a concept by Göran Hosinsky, EA8YU";
620 Z$=INKEY$:IF Z$=""THEN 620
630 IF Z$="0"THEN CLS:CHAIN GO$
640 IF Z$="1"THEN UM=0.30480000376701355!:UM$="m.":GOTO 670
650 IF Z$="2"THEN UM=1:UM$="ft":GOTO 670
660 GOTO 620
670 VIEW PRINT 15 TO 24:CLS:VIEW PRINT:LOCATE 3
680 :REM' Z$=INKEY$:IF Z$=""THEN 6650
690 COLOR 0,7:PRINT " Press letter in < > for:";:COLOR 7,0:PRINT STRING$(40,32)
700 FOR Z=1 TO 11:LOCATE Z+3,3:PRINT "<";CHR$(96+Z);"> ":NEXT Z
710 PRINT UL$;:GOSUB 5660   :REM'preface
720 Z$=INKEY$
730 IF Z$="a"THEN 5860
740 IF Z$="b"THEN CLS:CHAIN"coaxspec"
750 IF Z$="c"THEN 4830
760 IF Z$="d"THEN 6260
770 IF Z$="e"THEN 1740
780 IF Z$="f"THEN 2520
790 IF Z$="g"THEN 3060
800 IF Z$="h"THEN 4010
810 IF Z$="i"THEN 4430
820 IF Z$="j"THEN CLS:CHAIN"coaxstub"
830 IF Z$="k"THEN CLS:CHAIN"sqcoax"
840 GOTO 720
850 :REM'
860 :REM'.....data
870 :REM'                          dielectric                        centre
880 :REM'  type    no.  dielectric  constant  OD      Z(Ω)    volts  conductor
890 :REM'------    ---  ----------  -------- ----     ----    -----  ------inches
900 DATA RG-6/8215,    PE,       2.355,  .275,    75.0,   2700,  21s,  .0285,M1
910 DATA RG-6/U/1189,  PE,       2.355,  .270,    75.0,    300,  18s,  .0403,M1
920 DATA RG-8/9913,    ASPE,     1.507,  .405,    50.0,    600,  10s,  .1019,M1
930 DATA RG-8/102,     ASPE,     1.434,  .405,    50.0,    600,  9.5s, .1080,M3
940 DATA RG-8/DRF-BF*, FPE,      1.494,  .405,    50.0,    600,  9.5s, .1080,M4
950 DATA RG-8/WM CQ*,  FPE,      1.494,  .405,    50.0,    600,  9.5s, .1080,M3
960 DATA RG-8/9914,    TFE,      1.531,  .405,    50.0,   3700,  10s,  .1019,M1
970 DATA RG-8/8237,    PE,       2.344,  .405,    52.0,   3700,  13f,  .0820,M1
980 :REM'
990 DATA RG-8X/118*,   FPE,      1.556,  .242,    50.0,    300,  16f,  .0576,M3
1000 DATA RG-8X/9258,   TFE,      1.594,  .242,    50.0,    300,  16f,  .0576,M1
1010 :REM'
1020 DATA RG-9/8242,    PE,       2.332,  .420,    51.0,   3700,  13f,  .0820,M1
1030 :REM'
1040 DATA RG-11/8213*,  FPE,      1.677,  .405,    75.0,    600,  14s,  .0641,M1
1050 DATA RG-11/8238,   PE,       2.355,  .405,    75.0,    600,  18f,  .0456,M1
1060 :REM'
1070 DATA RG-58/124,    PE,       2.316,  .195,    53.5,   1400,  20s,  .0320,M3
1080 DATA RG-58/8240,   PE,       2.316,  .193,    53.5,   1400,  20s,  .0320,M1
1090 DATA RG-58A/8219*, FPE,      1.750,  .198,    50.0,    300,  20f,  .0363,M1
1100 DATA RG-58A/8259,  PE,       2.362,  .193,    50.0,   1400,  20f,  .0363,M1
1110 DATA RG-58C/8262,  PE,       2.362,  .195,    50.0,   1400,  20f,  .0363,M1
1120 DATA RG-58U/7806,  PE,       2.350,  .195,    75.0,    300,  19s,  .0359,M1
1130 DATA RG-59/8212,   TFE,      1.677,  .242,    75.0,    300,  20s,  .0320,M1
1140 DATA RG-59B/8263,  PE,       2.355,  .242,    75.0,   1700,  23s,  .0226,M1
1150 :REM'
1160 DATA RG-62A/9269,  ASPE,     1.570,  .260,    93.0,    750,  22s,  .0253,M1
1170 DATA RG-62B/8255,  ASPE,     1.570,  .260,    93.0,    750,  24s,  .0201,M1
1180 DATA RG-62B/9857,  ASPE,     1.464,  .405,   125.0,    750,  22s,  .0253,M1
1190 :REM'
1200 DATA RG-142B/83242,TFE,      2.123,  .195,    50.0,   1400,  18s,  .0403,M1
1210 DATA RG-174/8216,  PE,       2.362,  .101,    50.0,   1100,  26s,  .0159,M1
1220 DATA RG-213/8267,  PE,       2.362,  .405,    50.0,   3700,  13f,  .0820,M1
1230 DATA RG-214/8268,  PE,       2.362,  .425,    50.0,   3700,  13f,  .0820,M1
1240 DATA RG-216/9850,  PE,       2.355,  .425,    75.0,   3700,  18f,  .0456,M1
1250 :REM'
1260 DATA RG-217/217,   PE,       2.362,  .545,    50.0,   7000,  9.5s, .1080,M5
1270 DATA RG-218/218,   PE,       2.167,  .870,    50.0,  11000,  4.5s, .1928,M6
1280 DATA RG-223/9273,  PE,       2.362,  .212,    50.0,   1700,  19s,  .0359,M1
1290 DATA RG-303/84303, TFE,      2.123,  .170,    50.0,   1400,  18s,  .0403,M1
1300 DATA RG-316/84316, TFE,      2.094,  .098,    50.0,    900,  26s,  .0159,M1
1310 :REM'
1320 DATA RG-393/393,   TFE,      2.152,  .390,    50.0,   5000,  12s,  .0808,M7
1330 DATA RG-400/400,   TFE,      2.152,  .195,    50.0,   1900,  20s,  .0320,M8
1340 DATA LMR200*,      FPE,      1.494,  .195,    50.0,    300,  17s,  .0453,M2
1350 DATA LMR240*,      FPE,      1.458,  .242,    50.0,    300,  15s,  .0571,M2
1360 DATA LMR400*,      FPE,      1.422,  .405,    50.0,    600,  10s,  .1019,M2
1370 DATA LMR500*,      FPE,      1.422,  .500,    50.0,   2500,  7s,   .1443,M2
1380 DATA LMR600*,      FPE,      1.363,  .590,    50.0,   4000,  5.5s, .1717,M2
1390 DATA LMR1200*,     FPE,      1.330, 1.200,    50.0,   4500,  1/0s, .3249,M2
1400 :REM'
1410 DATA Alum 1/2in*, FPE,       1.556,  .500,    50.0,   2500,  5.5s, .1717,M9
1420 DATA Alum 1/2in*, FPE,       1.562,  .500,    75.0,   2500,  11.5, .0856,M9
1430 DATA Alum 7/8in*, FPE,       1.556,  .875,    50.0,   4000,  1s,   .2893,M9
1440 DATA Alum 7/8in*, FPE,       1.562,  .875,    75.0,   4000,  5.5s, .1717,M9
1450 :REM'
1460 DATA LDF4-50A*,   FPE,       1.670,  .630,    50.0,   1400,  5s,  .1819,M0
1470 DATA LDF5-50A*,   FPE,       1.670, 1.090,    50.0,   2100,  ---, .3550,M0
1480 DATA LDF6-50A*,   FPE,       1.670, 1.550,    50.0,   3200,  ---, .5160,M0
1490 :REM'
1500 DATA TV receiving,   300, 80, 5.8, 20s, .0320,  ---
1510 DATA Xmit.Tubular,   300, 80, 5.8, 20s, .0320,  8000
1520 DATA Window line,    450, 91, 4.0, 18s, .0403, 10000
1530 DATA Openwire line,  600, 92, 1.1, 12s, .0808, 1200
1540 :REM'
1550 :REM'.....read data
1560 OPEN"O",1,"\hamcalc\coaxfile\coaxial.fil"
1570 N=49    :REM'no.of coaxial cable data groups above
1580  FOR Z=1 TO N
1590    FOR Y=1 TO 9
1600   READ C$(Z,Y)
1610    NEXT Y
1620   WRITE#1,C$(Z,1);C$(Z,2);C$(Z,3);C$(Z,4);C$(Z,5);C$(Z,6);C$(Z,7);C$(Z,8)
1630   WRITE#1,C$(Z,9)
1640  NEXT Z
1650 FOR Z=N+1 TO N+4
1660    FOR Y=1 TO 7
1670   READ C$(Z,Y)
1680    NEXT Y
1690   WRITE#1,C$(Z,1);C$(Z,2);C$(Z,3);C$(Z,4);C$(Z,5);C$(Z,6);C$(Z,7)
1700  NEXT Z
1710 CLOSE
1720 RETURN
1730 :REM'
1740 :REM'.....display table
1750 COLOR 7,0,0:CLS:PRINT STRING$(79,205)
1760 T$=" COAXIAL CABLE CHARACTERISTICS (HAMCALC) "
1770 COLOR 0,7:LOCATE CSRLIN-1,19:PRINT T$:COLOR 7,0
1780 T1=34:T2=65
1790 PRINT "  * = foam dielectric"TAB(T1)"s = solid conductor";
1800 PRINT TAB(T2)"M5 = M17/79-RG"
1810 PRINT " Zo = characteristic impedance";
1820 PRINT TAB(T1)"f = flex.(stranded) conductor"TAB(T2)"M6 = M17/78-RG"
1830 PRINT " VF = velocity factor"TAB(T1)"M1 = Belden"TAB(T2)"M7 = M17/127-RG"
1840 PRINT "  Σ = dielectric factor"TAB(T1)"M2 = TMS"TAB(T2)"M8 = M17/128-RG"
1850 PRINT "  ß = D/d factor"TAB(T1)"M3 = WM CQ"TAB(T2)"M9 = CATV"
1860 PRINT " TM = Trademark/Brand"TAB(T1)"M4 = DRF-BF"TAB(T2)"M0 = Heliax"
1870 PRINT " ═════════════╤═════╤════╤═════╤════╤═════";
1880 PRINT "╤═════╤═════╤══════════╤═════╤════╤═══";
1890 M$=UM$:D$="in.":IF UM$="m."THEN M$="m.":D$="mm."
1900 PRINT "              │ Zo  │ VF │ pF  │ µH │ O.D.│ nom.│ nom.│  Centre  ";
1910 PRINT "│ Max.│Diel│"
1920 PRINT " Type/Cat.#   │ohms │ %  │ /";M$;" │/";M$;" │ ";D$;" │  Σ  │ ";
1930 PRINT " ß  │  Wire    │ RMS │Matl│TM";
1940 PRINT " ═════════════╪═════╪════╪═════╪════╪═════";
1950 PRINT "╪═════╪═════╪══════════╪═════╪════╪═══"
1960 LOCATE CSRLIN-2,56:PRINT " "+D$+"/ AWG "
1970 LN=11
1980 :REM'
1990 FOR Y=1 TO N
2000 LN=LN+1
2010  PRINT TAB(2);C$(Y,1);               :REM'cable type
2020   E=VAL(C$(Y,3))                     :REM'dielectric constant
2030   Z=VAL(C$(Y,5))                     :REM'impedance
2040   D=10^(Z*SQR(E)/138)                :REM'D/d factor
2050   V=1/SQR(E)                         :REM'velocity factor
2060   C=(7.260000228881836!*E/(LOG(D)*LF))             :REM'capacitance
2070   U=0.14000000059604645!*LOG(D)*LF                    :REM'inductance
2080   OD=VAL(C$(Y,4))                    :REM'O.D. of jacket
2090 PRINT TAB(15)USING "│###.#│##.#│###.#│.###│";Z,V*100,C/UM,U/UM;
2100 IF UM=1 THEN Q$="#.###│":ELSE OD=OD*25.399999618530273!:Q$="###.#│"
2110  PRINT USING Q$;OD;
2120 DD=VAL(C$(Y,8))
2130 IF D>=10 THEN Q$="#.###│##.##│":ELSE Q$="#.###│#.###│"
2140 PRINT USING Q$;E,D;
2150 IF UM=1 THEN Q$=".#### ":ELSE DD=DD*25.399999618530273!:Q$="##.## "
2160 PRINT USING Q$;DD;
2170 PRINT C$(Y,7);
2180 RMS=VAL(C$(Y,6))
2190  PRINT TAB(66)USING "│#####│";RMS;
2200  PRINT C$(Y,2);              :REM'dielectric material
2210 PRINT TAB(77)"│";C$(Y,9);
2220  IF LN<24 THEN PRINT "":GOTO 2240
2230  GOSUB 6720:CLS:LN=0:GOTO 2240
2240 NEXT Y
2250 T$="###.#│##.#│###.#│"+STRING$(7,32)+"Twinlead"+STRING$(7,32)+"│#.### "
2260  FOR X=N+1 TO N+4
2270 PRINT " ";C$(X,1)TAB(15)"│";
2280 IF UM=1 THEN M=1 :ELSE M=25.399999618530273!
2290 PRINT USING T$;VAL(C$(X,2)),VAL(C$(X,3)),VAL(C$(X,4))/UM,VAL(C$(X,6))*M;
2300 PRINT C$(X,5);TAB(66)"│";
2310 IF VAL(C$(X,7))=0 THEN PRINT " --- │":GOTO 2330
2320 PRINT USING "#####│";VAL(C$(X,7))
2330  NEXT X
2340 PRINT UL$;
2350 PRINT " ASPE = Air Spaced Polyethylene"
2360 PRINT " PE =   Polyethylene,        temp.range  -65° to  +80°C ";
2370 PRINT "( -85° to +176°F)"
2380 PRINT " FPE =  Foamed polyethylene, temp.range  -65° to  +80°C ";
2390 PRINT "( -85° to +176°F)"
2400 PRINT " TFE =  TEFLON,              temp.range -250° to +250°C ";
2410 PRINT "(-418° to +482°F)"
2420 PRINT " NOTE: The values for Zo, VF, pF and Σ for foam cables are approx";
2430 PRINT "imate due to "
2440 PRINT " practical limitations in controlling the ratio of air to dielect";
2450 PRINT "ric in the   "
2460 PRINT " foam during manufacture. Actual values can vary between producti";
2470 PRINT "on runs, and "
2480 PRINT " particularly between different manufacturers.";
2490 GOTO 6670
2500 :REM'
2510 :REM'
2520 :REM'.....line loss in standard cables
2530 CLS:COLOR 7,0,0
2540 PRINT TAB(17)" ATTENUATION IN COMMONLY USED COAXIAL CABLES "
2550 PRINT UL$;
2560 GOSUB 5310    :REM'preface
2570 PRINT UL$;
2580 PRINT " ENTER: Length of line (";UM$;")....";:INPUT LG:LG=LG/UM
2590 INPUT " ENTER: Frequency (MHz)....";F
2600 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2610 PRINT " Attenuation in dB @";USING V$;F;:PRINT " MHz";
2620 LOCATE ,55:PRINT "* denotes foam dielectic"
2630 PRINT " For Cable Length";USING W$;LG*0.30480000376701355!;:PRINT " m. (";
2640 PRINT USING W$;LG;:PRINT " feet), total attenuation is:"
2650 PRINT UL$;
2660 Q$="┌─Zo────dB─┐"
2670 LOCATE ,15:PRINT Q$;
2680 LOCATE ,42:PRINT Q$;
2690 LOCATE ,69:PRINT Q$;
2700 FOR X=1 TO 41
2710  ZO=VAL(C$(X,5))         :REM'impedance
2720  D=VAL(C$(X,4))          :REM'ID of outer conducter
2730  E=VAL(C$(X,3))          :REM'dielectric constant
2740  B=10^(ZO*SQR(E)/138)    :REM'D/d constant
2750   IF RIGHT$(C$(X,7),1)="f"THEN K1= 0.9390000104904175! :ELSE K1=1
2760  K2=1:K=K1+K2
2770 A=0.4350000023841858!/ZO/D*B*K*SQR(F)   :REM'attenuation per 100 feet
2780 A=A*LG/100               :REM'total attenuation of line
2790 C$(X,6)=STR$(A)          :REM'atten.constant array
2800 NEXT X
2810 :REM'
2820 FOR Y=1 TO 14
2830 PRINT TAB(2)C$(Y,1);
2840 PRINT TAB(15)USING "###.#";VAL(C$(Y,5));
2850 PRINT USING "###.##";VAL(C$(Y,6));
2860 :REM'
2870 PRINT " │"+C$(Y+14,1);
2880 IF VAL(C$(Y+14,5))<100 THEN U$="###.#":ELSE U$="#### "
2890 PRINT TAB(42)USING U$;VAL(C$(Y+14,5));
2900 PRINT USING "###.##";VAL(C$(Y+14,6));
2910 IF Y>=13 THEN PRINT "":GOTO 2960
2920 :REM'
2930 PRINT " │"+C$(Y+28,1);
2940 PRINT TAB(69)USING "###.#";VAL(C$(Y+28,5));
2950 PRINT USING "###.##";VAL(C$(Y+28,6));
2960 NEXT Y
2970 COLOR 0,7
2980 PRINT "     D (outer conducter ID)"TAB(52)"0.435┌        ┐              ";
2990 PRINT " ß= ───";TAB(33)"Attenuation in dB= ─────│ß(K1+K2)│√ƒ+2.78√Σ*P*ƒ ";
3000 PRINT "     d (inner conductor OD)"TAB(52)" Zo*D└        ┘              ";
3010 COLOR 7,0
3020 PRINT " K1=strand factor, K2=braid factor, ƒ=frequency in MHz,";
3030 PRINT " P=power factor";
3040 GOTO 6670
3050 :REM'
3060 :REM'.....unidentified cable
3070 T$=" UNIDENTIFIED COAXIAL CABLE "
3080 GOTO 3120
3090 :REM'.....clear screen
3100 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
3110 RETURN
3120 :REM'.....start
3130 CLS
3140 Z=0:C=0:L=0:E=0:V=0:B=0
3150 LOCATE ,26:COLOR 0,7,0:PRINT T$:COLOR 7,0
3160 PRINT UL$;
3170 PRINT "If a requested value is unknown, press <ENTER> to by-pass the ";
3180 PRINT "request."
3190 PRINT UL$;
3200 :REM'
3210 :REM'.....data input
3220  IF Z THEN 3250
3230 INPUT "ENTER: Impedance (ohms)...............";Z
3240 IF Z THEN GOSUB 3450
3250  IF C THEN 3280
3260 INPUT "ENTER: Capacitance in pF/ft...........";C
3270 IF C THEN GOSUB 3450
3280  IF L THEN 3310
3290 INPUT "ENTER: Inductance in µH/ft............";L
3300 IF L THEN B=EXP(L*LOG(10)/0.14000000059604645!):GOSUB 3450
3310  IF E THEN 3340
3320 INPUT "ENTER: Dielectric constant Σ..........";E
3330 IF E THEN V=1/SQR(E):GOSUB 3450
3340  IF V THEN 3380
3350 INPUT "ENTER: Velocity factor (decimal)......";V
3360 IF V>1 THEN BEEP:GOTO 3350
3370 IF V THEN E=(1/V)^2:GOSUB 3450
3380  IF B THEN 3420
3390 PRINT " D/d factor = (I.D. of outer conductor) ÷ (O.D. of inner conductor)"
3400 INPUT "ENTER: D/d factor.....................";B
3410 IF B THEN L=0.14000000059604645!*LOG(B)/LOG(10):GOSUB 3450
3420  IF Z*C*L*E*V*B THEN 3910
3430 GOTO 3210
3440 :REM'
3450 :REM'.....calculate
3460 IF E=0 AND Z*C<>0 THEN GOSUB 3820:GOTO 3450
3470 IF C=0 AND E*B<>0 THEN C=7.260000228881836!*E/(LOG(B)/LOG(10)):GOTO 3450
3480 IF E=0 AND C*B<>0 THEN E=C*LOG(B)/LOG(10)/7.260000228881836!:GOTO 3450
3490 IF B=0 AND C*E<>0 THEN B=10^(7.260000228881836!*E/C):GOTO 3450
3500 IF Z=0 AND E*B<>0 THEN Z=138/SQR(E)*LOG(B)/LOG(10):GOTO 3450
3510 IF E=0 AND Z*B<>0 THEN E=(138/Z*LOG(B)/LOG(10))^2:GOTO 3450
3520 IF B=0 AND Z*E<>0 THEN B=EXP(Z*SQR(E)*LOG(10)/138):GOTO 3450
3530 :REM'
3540 IF L=0 AND B<>0 THEN L=0.14000000059604645!*LOG(B)/LOG(10)
3550 IF B=0 AND L<>0 THEN B=EXP(L*LOG(10)/0.14000000059604645!)
3560 IF V=0 AND E<>0 THEN V=1/SQR(E)
3570 IF E=0 AND V<>0 THEN E=(1/V)^2
3580 :REM'
3590 :REM'.....display
3600 LN=5:GOSUB 3090
3610 IF Z*C*L*E*V*B THEN LN=3:GOSUB 3090
3620 :REM'
3630 IF Z THEN PRINT USING "Characteristic impedance...Zo= ###.### ohms";Z
3640 IF C THEN PRINT USING "Capacitance................ C= ###.### pF/ft";C;
3650 IF C THEN PRINT USING " = ###.### pF/metre";C/0.30480000376701355!
3660 IF L THEN PRINT USING "Inductance..................L= ###.### µH/ft";L;
3670 IF L THEN PRINT USING " = ###.### µH/metre";L/0.30480000376701355!
3680 IF E THEN PRINT USING "Dielectric factor...........Σ= ###.###";E
3690 IF V THEN PRINT USING "Velocity factor.............V= ###.# %";V*100
3700 IF B THEN PRINT USING "D/d factor..................ß= ###.###";B
3710 PRINT UL$;
3720 IF FLAG OR Z*C*L*E*V*B<>0 THEN 3930
3730 COLOR 0,7:PRINT " Press 1 to continue or 0 to quit ":COLOR 7,0
3740 LN=CSRLIN-1
3750 FLAG=0
3760 Z$=INKEY$:IF Z$=""THEN 3760
3770 PRINT USING " = ###.### pF/metre";C/0.30480000376701355!
3780 IF Z$="0"THEN GOSUB 3090:FLAG=1:GOTO 3920
3790 IF Z$="1"THEN GOSUB 3090:RETURN
3800 GOTO 3760
3810 :REM'
3820 :REM'.....iteration
3830 EC=0.10000000149011612!:N=0.10000000149011612!
3840 EC=EC+N
3850 EZ=((7.260000228881836!*EC*138)/(C*Z))^2
3860 IF ABS(EC-EZ)<9.999999747378752e-05! THEN 3890
3870 IF EZ>EC THEN EC=EC-N:N=N/10:GOTO 3840
3880 GOTO 3840
3890 E=EC:RETURN
3900 :REM'
3910 :REM'.....end
3920 LN=3:GOSUB 3090:GOTO 3630
3930 GOSUB 6090:GOSUB 6720:GOSUB 3090:COLOR 0,7
3940 LOCATE 13,28:PRINT " Want another?    (y/n) ":COLOR 7,0
3950 Z$=INKEY$:IF Z$=""THEN 3950
3960 IF Z$="n"THEN 3990
3970 IF Z$="y"THEN FLAG=0:GOTO 3120
3980 GOTO 3950
3990 GOTO 6690  :REM'end
4000 :REM'
4010 :REM'.....DIELECTRIC CONSTANT
4020 COLOR 7,0,0:CLS:PRINT UL$;:COLOR 0,7
4030 LOCATE CSRLIN-1,16
4040 PRINT " COAXIAL CABLE - CALCULATED DIELECTRIC CONSTANT "
4050 COLOR 7,0:PRINT
4060 PRINT" Many coaxial cable equations stem from the dielectric constant Σ."
4070 PRINT" Most published coaxial cable tables do not show this constant."
4080 PRINT" Most published coaxial cable tabular data appear to be rounded off."
4090 PRINT" The least rounding-off appears to be in the listed Zo and pF/ft. ";
4100 PRINT "values."
4110 PRINT" This program calculates Σ based on published Zo and pF/ft. values."
4120 PRINT " Using Σ it re-calculates the characteristic impedance & velocity";
4130 PRINT " factor."
4140 PRINT UL$;
4150 LN=CSRLIN
4160 INPUT " ENTER: Nominal characteristic impedance (ohms)...";Z
4170 IF Z=0 THEN 4160
4180 INPUT " ENTER: Published capacity (pF/ft.)...............";C
4190 IF C=0 THEN 4180
4200 :REM'.....iteration
4210 EC=0.10000000149011612!:N=0.10000000149011612!
4220 EC=EC+N
4230 EZ=((7.260000228881836!*EC*138)/(C*Z))^2
4240 IF ABS(EC-EZ)<9.999999747378752e-05! THEN 4280
4250 IF EZ>EC THEN EC=EC-N:N=N/10:GOTO 4220
4260 GOTO 4220
4270 :REM'
4280 VV=100/SQR(EC)
4290 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
4300 PRINT USING " Published impedance................. ####.### ohms";Z
4310 PRINT USING " Published capacitance............... ####.### pF/ft";C
4320 PRINT
4330 PRINT USING " Calculated Dielectric Constant...... ####.###";EC
4340 PRINT USING " Calculated velocity factor.......... ####.### %";VV
4350 PRINT UL$;
4360 COLOR 0,7:PRINT " Do another?  (y/n) ":COLOR 7,0
4370 Z$=INKEY$:IF Z$=""THEN 4370
4380 IF Z$="n"THEN 6690
4390 IF Z$="y"THEN 4010
4400 GOTO 4370
4410 GOTO 6670
4420 :REM'
4430 :REM'.....line length - physical vs. electrical
4440 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
4450 :REM'
4460 :REM'.....cable table
4470 FOR Z=1 TO 12
4480 PRINT TAB(1)USING "##:";Z;:PRINT C$(Z,1);
4490 PRINT TAB(21)USING "##:";Z+12;:PRINT C$(Z+12,1);
4500 PRINT TAB(41)USING "##:";Z+24;:PRINT C$(Z+24,1);
4510 IF Z=12 THEN 4530
4520 PRINT TAB(61)USING "##:";Z+36;:PRINT C$(Z+36,1)
4530 NEXT Z
4540 PRINT UL$;
4550 INPUT " ENTER: An item number from above list to select coaxial cable";N
4560 IF N>=1 AND N<=47 THEN 4580
4570 BEEP:GOTO 4550
4580 E=VAL(C$(N,3))
4590 VF=1/SQR(E)
4600 INPUT " ENTER: Frequency in MHz..........................";F
4610 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
4620 PRINT TAB(9);C$(N,1);
4630 PRINT " Transmission Line Physical Length vs. Electrical Length"
4640 PRINT UL$;
4650 W=299.7925109863281!/F  :REM'length of wavelength in free space
4660 L=W*VF        :REM'electrical length in metres
4670 PRINT "        Frequency.................................";USING V$;F;
4680 PRINT " MHz"
4690 PRINT "        Velocity factor...........................";USING V$;VF;
4700 PRINT USING " (##.#%)";VF*100
4710 PRINT "        Length of one wavelength in free space....";USING V$;W;
4720 PRINT " m. =";USING V$;W/0.30480000376701355!;:PRINT " ft."
4730 PRINT "        Length of full wavelength line............";USING V$;L;
4740 PRINT " m. =";USING V$;L/0.30480000376701355!;:PRINT " ft."
4750 PRINT "        Length of  1/2 wavelength line............";USING V$;L/2;
4760 PRINT " m. =";USING V$;L/2/0.30480000376701355!;:PRINT " ft."
4770 PRINT "        Length of  1/4 wavelength line............";USING V$;L/4;
4780 PRINT " m. =";USING V$;L/4/0.30480000376701355!;:PRINT " ft."
4790 PRINT "        Length of  1/8 wavelength line............";USING V$;L/8;
4800 PRINT " m. =";USING V$;L/8/0.30480000376701355!;:PRINT " ft."
4810 GOTO 6670
4820 :REM'
4830 :REM'.....physical dimensions
4840 CLS
4850 PRINT UL$;:LOCATE CSRLIN-1,22
4860 COLOR 0,7,0:PRINT " COAXIAL CABLE PHYSICAL DIMENSIONS ":COLOR 7,0
4870 T=53
4880 PRINT "  A = Outside diameter of jacket";
4890 PRINT TAB(T)"NOTE: Dimensions may vary"
4900 PRINT "  B = Inside diameter of outer conductor (shield)";
4910 PRINT TAB(T+6)"from manufacturer to"
4920 PRINT "  C = Wall thickness of outer conductor plus jacket";
4930 PRINT TAB(T+6)"manufacturer."
4940 PRINT "  D = Outside diameter of inner conductor";
4950 PRINT TAB(T)"* denotes foam dielectric"
4960 PRINT UL$;
4970 T$=" Dimensions in "
4980 IF UM=1 THEN T$=T$+"inches ":ELSE T$=T$+" millimetres "
4990 T=LEN(T$):LOCATE CSRLIN-1,(80-T)/2:COLOR 0,7:PRINT T$:COLOR 7,0
5000 T$="A    B    C    D"
5010 PRINT TAB(20)T$;TAB(39)"│";TAB(60)T$
5020 FOR Z=1 TO 20
5030 E=VAL(C$(Z,3))     :REM'dielectric constant
5040 E1=VAL(C$(Z+20,3)) :REM'dielectric constant
5050 A$=C$(Z,1)         :REM'type
5060 A1$=C$(Z+20,1)     :REM'type
5070 B=VAL(C$(Z,5))     :REM'impedance
5080 B1=VAL(C$(Z+20,5)) :REM'impedance
5090 C=VAL(C$(Z,4))     :REM'jacket O.D.
5100 C1=VAL(C$(Z+20,4)) :REM'jacket O.D.
5110 DD=10^(B*SQR(E)/138)    :REM'D/d factor
5120 DD1=10^(B1*SQR(E1)/138) :REM'D/d factor
5130 ID=VAL(C$(Z,8))      :REM'inner conductor diameter
5140 ID1=VAL(C$(Z+20,8))  :REM'inner conductor diameter
5150 D=DD*ID              :REM'dielectric OD
5160 D1=DD1*ID1           :REM'dielectric OD
5170 W=(C-D)/2
5180 W1=(C1-D1)/2
5190 IF UM=1     THEN X=1:   Q$="###.### .### .### .####"
5200 IF UM=0.30480000376701355! THEN X=25.399999618530273!:Q$="####.## ##.# ##.# ##.##"
5210 PRINT " ";A$;
5220 PRINT TAB(15)USING Q$;C*X,D*X,W*X,ID*X;
5230 PRINT " ";
5240 PRINT TAB(39);"│ ";A1$;
5250 PRINT TAB(55)USING Q$;C1*X,D1*X,W1*X,ID1*X;
5260 IF Z<>17 THEN PRINT "":GOTO 5280
5270 GOSUB 6730:CLS
5280 NEXT Z
5290 GOTO 6670
5300 :REM'
5310 :REM'.....line loss preface
5320 T=7
5330 PRINT TAB(T);
5340 PRINT "Line loss in any type of coaxial cable can vary considerably from"
5350 PRINT TAB(T);
5360 PRINT "values shown in most published graphs because characteristics can"
5370 PRINT TAB(T);
5380 PRINT "vary in the same type of cable from different manufacturers. Also,"
5390 PRINT TAB(T);
5400 PRINT "age and condition of the cable can effect the inherent loss, as can"
5410 PRINT TAB(T);
5420 PRINT "the installation environment. Therefore any theoretical loss values"
5430 PRINT TAB(T);
5440 PRINT "(including those computed by this program) MUST be considered as"
5450 PRINT TAB(T);
5460 PRINT "approximate only. The only reliable way to determine line loss is"
5470 PRINT TAB(T);
5480 PRINT "by actual measurement. However, the values computed by this program"
5490 PRINT TAB(T);
5500 PRINT "should be accurate enough for most Amateur Radio applications."
5510 PRINT TAB(T);
5520 PRINT
5530 PRINT TAB(T);
5540 PRINT "The equations used in this program those published in the ARRL"
5550 PRINT TAB(T);
5560 PRINT "ANTENNA BOOK, 18th edition, page 24-18, Table 2, assuming power"
5570 PRINT TAB(T);
5580 PRINT "factor P=0, strand factor K1=0.939 for stranded wire, 1.0 for solid"
5590 PRINT TAB(T);
5600 PRINT "wire, and braid factor K2=1."
5610 PRINT
5620 PRINT TAB(T);
5630 PRINT "Calculated values are only for properly matched transmission lines."
5640 RETURN
5650 :REM'
5660 :REM'.....note
5670 PRINT " The values of Zo (impedance), VF (velocity factor) and capacity ";
5680 PRINT "per unit of   "
5690 PRINT " length shown in many published data sheets are nominal values on";
5700 PRINT "ly, because   "
5710 PRINT " these values are functions of Σ (dielectric factor) and ß (insid";
5720 PRINT "e diameter of "
5730 PRINT " outer conductor ÷ outside diameter of inner conductor). Σ ad ß c";
5740 PRINT "an vary       "
5750 PRINT " between production runs and different manufacturers, and rarely ";
5760 PRINT "appear in data"
5770 PRINT " sheets. This program computes the nominal values of Σ and ß requ";
5780 PRINT "ired for the  "
5790 PRINT " generally accepted nominal values of Zo and pF/ft published by t";
5800 PRINT "he ARRL, and  "
5810 PRINT " re-calculates VF and other values that are functions of Σ and ß,";
5820 PRINT " using the    "
5830 PRINT " equations published by the ARRL (Item <a> in the above menu).";
5840 RETURN
5850 :REM'
5860 :REM'.....equations
5870 CLS
5880 PRINT TAB(27)" COAXIAL CABLE EQUATIONS "
5890 PRINT UL$;
5900 GOSUB 6090
5910 PRINT TAB(16)"ß = D/d factor"
5920 PRINT TAB(16)"Σ = dielectric constant"
5930 PRINT TAB(16)"C = capacity in pF/ft"
5940 PRINT TAB(16)"L = inductance in µH/ft"
5950 PRINT TAB(16)"Zo= characteristic impedance in ohms"
5960 PRINT TAB(16)"V = velocity factor (% of speed of light)"
5970 PRINT TAB(16)"and"
5980 PRINT TAB(16)"    0.435┌        ┐"
5990 PRINT TAB(16)"A = ─────│ß(K1+K2)│√ƒ+2.78√Σ*P*ƒ"
6000 PRINT TAB(16)"     Zo*D└        ┘"
6010 PRINT TAB(16)"where"
6020 PRINT TAB(16)"A = attenuation in dB/100 feet"
6030 PRINT TAB(16)"K1= manufacturer's strand factor"
6040 PRINT TAB(16)"K2= manufacturer's braid factor"
6050 PRINT TAB(16)"ƒ = frequency in MHz"
6060 PRINT TAB(16)"P = power factor";
6070 GOTO 6670
6080 :REM'
6090 :REM'.....equation graphics
6100 T=11:N=CSRLIN-1:LOCATE N
6110 LOCATE ,T:PRINT "╤══════"
6120 LOCATE ,T:PRINT "│    D "
6130 LOCATE ,T:PRINT "│ ß= ─ "
6140 LOCATE ,T:PRINT "│    d "
6150 LOCATE ,T:PRINT "└──────"
6160 T=18:LOCATE N
6170 LOCATE ,T:PRINT "╤══════════╤═══════════════╤═══════════════╤════════╤"
6180 LOCATE ,T:PRINT "│    7.26Σ │               │     138       │    100 │"
6190 LOCATE ,T:PRINT "│ C= ───── │ L= 0.14 log ß │ Zo= ─── log ß │ V= ─── │"
6200 LOCATE ,T:PRINT "│    log ß │               │     √Σ        │    √Σ  │"
6210 LOCATE ,T:PRINT "┴──────────┴───────────────┴───────────────┴────────┘"
6220 PRINT TAB(16)"D = inner diameter of outer conductor"
6230 PRINT TAB(16)"d = outer diameter of inner conductor"
6240 RETURN
6250 :REM'
6260 :REM'.....fault locator
6270 CLS:KEY OFF
6280 REM: DIM L(20)@ start of program
6290 PRINT " CABLE FAULT LOCATOR (algorithm by Robert DeHoney) "
6300 PRINT STRING$(80,205);
6310 LN=CSRLIN
6320 PRINT "This program finds the length of a shorted or open low loss cable"
6330 PRINT
6340 INPUT "Is the cable shorted or open?  <s/o> ",A$
6350 INPUT "ENTER: Input reactance (ohms) including +or- sign";X
6360 INPUT "ENTER: Input frequency (MHz) ";F
6370 INPUT "ENTER: Cable characteristic impedance (ohms)  ";Z0
6380 INPUT "ENTER: Cable velocity factor (decimal) ";K
6390 WL=300*K/F:B=2*PI/WL
6400 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
6410 PRINT USING " Input reactance..................+####.### ohms";X
6420 F$=" Frequency........................ ####.### MHz  ( ####.### m.)"
6430 PRINT USING F$;F,300/F
6440 PRINT USING " Cable characteristic impedance... ####.### ohms";Z0
6450 PRINT USING " Cable velocity factor............ ####.###";K
6460 PRINT USING " 1 wavelength in cable............ ####.### metres";WL
6470 IF A$="s"THEN S$=" Short"
6480 IF A$="o"THEN S$=" Open"
6490 LN=CSRLIN:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
6500 COLOR 0,7:PRINT S$" circuit fault is located one of these distances";
6510 PRINT " from input end of cable ":COLOR 7,0
6520 IF A$="o" THEN 6630
6530 :REM'
6540 :REM'.....short circuit
6550 L=ATN(X/Z0)/B:IF L<0 THEN L=ABS(L)+WL/4
6560 L(0)=L-WL/2
6570 FOR Q=1 TO 15
6580 L(Q)=L(Q-1)+WL/2
6590 PRINT USING" #####.## m. ( #####.## ft.)";L(Q),L(Q)/0.30480000376701355!
6600 NEXT Q
6610 GOTO 6670
6620 :REM'
6630 :REM'.....open circuit
6640 L=ATN(-Z0/X)/B:IF L<0 THEN L=ABS(L)+WL/4
6650 GOTO 6560
6660 :REM'
6670 :REM'.....end
6680 GOSUB 6720
6690 RESTORE:GOTO 260   :REM'start
6700 END
6710 :REM'
6720 :REM'PRT
6730 KEY OFF:GOSUB 6800:LOCATE 25,5:COLOR 0,2
6740 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
6750 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
6760 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 6760 :ELSE GOSUB 6800
6770 IF Z$="3"THEN RETURN
6780 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
6790 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 6730
6800 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
